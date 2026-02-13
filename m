Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11BE221F26
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 13:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770988479; cv=none; b=ZPjh4FdckJ0aghM6ST+QSEhp/PnRBPoMPMa5XDC9N8tRSOmzRhIB2krpfSvRjoKYwK4xyqVCEdURSHsrwes0u0HVBgmp3RdVelWf3PR5C5amhKw5HHHoL2hp295zSYLsW0uoZMI4g/4CbXNgSGALkqslIs4HWqoqIrKyqE2RLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770988479; c=relaxed/simple;
	bh=JkQ5szIV/inGZBvxQ2Ahrtas9JfTktE7SOHapF9uZsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K51JAiKAydZPbGYAIRA9FJNSBLJ3XSEjyuKbZVdDBK9PhOZcahoCT6bxosh14aOIAhF6siyVcyp0D+C8s4IxYwEmH9iit3zw/idmNx5kkAj8eIj1lKtXn0qmhVfHxjtg1PjZpKJwjjGvGQtaDA9HXMx2n6rdtnIutwrok7HAaiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HdGI/Ygh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vx3/mLCT; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HdGI/Ygh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vx3/mLCT"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E38151D00198;
	Fri, 13 Feb 2026 08:14:36 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 13 Feb 2026 08:14:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1770988476; x=1771074876; bh=lFLCcqrE/i
	7E4U+JUQZvXEfxGarK8wH2RlI03mCvQ4Q=; b=HdGI/Ygh1kDSUNYQA4064r0azE
	bLiJgzBNP/np6S3N2GlHhWeWhOxcvYMD1t6eLraoDOsuUffQyWgVU9XRjR5E8K4p
	dHNxYc/7gfuFucEtINw0mRXGxwQgffnq6SCzG8ElhWPNX7hzvIh2zbtfE7xN9JqU
	zFRzT/rsJl0CmD5K6MPD04CrFpYIm51puI2FsVZcE0v5hSg+XbilRUPUy5xF8ilt
	AUGhVce9JbH99m+nqqla3ykWTPlteYBP8m8fsgL2renJ22gC7c/G4a6vv1wZQ6aA
	JRa6V0+A2aPelotQwXjKIHLojH1jci/+UnqLxOzY5Z9Y54MypKRI43Rk4Jmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770988476; x=1771074876; bh=lFLCcqrE/i7E4U+JUQZvXEfxGarK8wH2RlI
	03mCvQ4Q=; b=vx3/mLCTvYP+/S2nHYbE+usMWh3QiI/TenGnCL/JyjDbYJKXsGg
	K/fOPYbsbm2axXBTOg7WjR05lAbhNMARf5kRD6c54Y3Gh4Fs+xSV/nZ93z6YAAol
	OjgxARP8yeTmLNorW1VOrtngu7mOeaKsXn53hYb84v3HXx0gPE0HXr2QTa6tCfgP
	2NOfluTp/Aw+QOfLgRAzfBzjC/B6cJTZoi7Th0btoepHuHS9+cLV9/i23P4R0N/J
	HiABxRHWGTyHNVJR1AEevPpOLIC4+rNzHwTZXMHfUCleiN3yKxRDFz7rwX5Z6bYC
	Ay9wdj+GYyAaJAkHVYmkOwdO3sV0FcYL2kg==
X-ME-Sender: <xms:vCOPaUynLbzS1veHtm2UXxJQZx8kkHrLePiwS0D0IbjZ1gdEdKa9Wg>
    <xme:vCOPaeQiYh5vqR297gAhs_1ThrDpbXFvong83oNb4myH87Uio5-YF45Zj606QxfCc
    w4CDLjEu_lyzcXnwg1LyqZA9Ht97YxBjy3gsotaPyQUJlguXN2kg38>
X-ME-Received: <xmr:vCOPaT-pmjGxBgbNYaV5wABnmSTPaCA_SMekL993x1EfCUqUJ0pOF77c__jiL-gGpa1SA7dyr65fMwk9weaeYYZup1yysi41Gotbn0aeBHlN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdekfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vCOPadry1uJ2G1vUikq5ZiNtkNWmdtj5gCnQVx_vsIn7EHvulYO3-w>
    <xmx:vCOPaYnAc4o9B8h-Ft39qHkFrtbSu1KPofwGija_EFpTPu7nUnuUjA>
    <xmx:vCOPacL7J9zCMqoQYju6UScCFQMfqgBDgXEwsy0eYSdA6PwXnROI6w>
    <xmx:vCOPaVwwo9ctsDDp8GdlhwpDZ2YtXawXUfeTWhBXdrCRJiFaOkISJg>
    <xmx:vCOPaQg3ARyPz1eJ3V34kDln6f1xConsBgTUKA8Jc7-NsBOLYZZCUjB5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 08:14:35 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8d2b84d3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 13:14:33 +0000 (UTC)
Date: Fri, 13 Feb 2026 14:14:31 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/5] builtin/repo: add OID annotations to table output
Message-ID: <aY8jt_8LoN1LdboG@pks.im>
References: <20260203221758.1164434-1-jltobler@gmail.com>
 <20260203221758.1164434-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203221758.1164434-4-jltobler@gmail.com>

On Tue, Feb 03, 2026 at 04:17:56PM -0600, Justin Tobler wrote:
> diff --git a/builtin/repo.c b/builtin/repo.c
> index 51a4359685..6fc2d9db12 100644
> --- a/builtin/repo.c
> +++ b/builtin/repo.c
> @@ -272,6 +275,12 @@ static void stats_table_vaddf(struct stats_table *table,
>  		table->name_col_width = name_width;
>  	if (!entry)
>  		return;
> +	if (entry->oid) {
> +		entry->index = table->annotations.nr + 1;
> +		strbuf_addf(&buf, "[%" PRIuMAX "] %s", (uintmax_t)entry->index,
> +			    oid_to_hex(entry->oid));
> +		string_list_append(&table->annotations, buf.buf);

Can't we hand over ownership here to avoid the extra string copy?

    string_list_append_nodup(&table->rows, strbuf_detach(&buf, NULL));

> @@ -282,6 +291,8 @@ static void stats_table_vaddf(struct stats_table *table,
>  		if (unit_width > table->unit_col_width)
>  			table->unit_col_width = unit_width;
>  	}
> +
> +	strbuf_release(&buf);
>  }
>  
>  static void stats_table_addf(struct stats_table *table, const char *format, ...)

I was wondering why we only start releasing the buffer now. But before
these changes we used `strbuf_detach()` on it, so there's been no memory
leak here.

> @@ -321,6 +332,27 @@ static void stats_table_size_addf(struct stats_table *table, size_t value,
>  	va_end(ap);
>  }
>  
> +static void stats_table_object_size_addf(struct stats_table *table,
> +					 struct object_id *oid, size_t value,
> +					 const char *format, ...)
> +{
> +	struct stats_table_entry *entry;
> +	va_list ap;
> +
> +	CALLOC_ARRAY(entry, 1);
> +	humanise_bytes(value, &entry->value, &entry->unit, HUMANISE_COMPACT);
> +
> +	/*
> +	 * A NULL OID should not have a table annotation.
> +	 */
> +	if (!is_null_oid(oid))
> +		entry->oid = oid;

I guess this case could be hit if a certain object type didn't have any
objects at all?

> diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
> index 1999f325d0..918af7269f 100755
> --- a/t/t1901-repo-structure.sh
> +++ b/t/t1901-repo-structure.sh
> @@ -89,41 +89,46 @@ test_expect_success SHA1 'repository with references and objects' '
>  		# git-rev-list(1) --disk-usage=human option printing the full
>  		# "byte/bytes" unit string instead of just "B".
>  		cat >expect <<-EOF &&
> -		| Repository structure | Value      |
> -		| -------------------- | ---------- |
> -		| * References         |            |
> -		|   * Count            |      4     |
> -		|     * Branches       |      1     |
> -		|     * Tags           |      1     |
> -		|     * Remotes        |      1     |
> -		|     * Others         |      1     |
> -		|                      |            |
> -		| * Reachable objects  |            |
> -		|   * Count            |   3.02 k   |
> -		|     * Commits        |   1.01 k   |
> -		|     * Trees          |   1.01 k   |
> -		|     * Blobs          |   1.01 k   |
> -		|     * Tags           |      1     |
> -		|   * Inflated size    |  16.03 MiB |
> -		|     * Commits        | 217.92 KiB |
> -		|     * Trees          |  15.81 MiB |
> -		|     * Blobs          |  11.68 KiB |
> -		|     * Tags           |    132 B   |
> -		|   * Disk size        | $(object_type_disk_usage all true) |
> -		|     * Commits        | $(object_type_disk_usage commit true) |
> -		|     * Trees          | $(object_type_disk_usage tree true) |
> -		|     * Blobs          |  $(object_type_disk_usage blob true) |
> -		|     * Tags           |    $(object_type_disk_usage tag) B   |
> -		|                      |            |
> -		| * Largest objects    |            |
> -		|   * Commits          |            |
> -		|     * Maximum size   |    223 B   |
> -		|   * Trees            |            |
> -		|     * Maximum size   |  32.29 KiB |
> -		|   * Blobs            |            |
> -		|     * Maximum size   |     13 B   |
> -		|   * Tags             |            |
> -		|     * Maximum size   |    132 B   |
> +		| Repository structure     | Value      |
> +		| ------------------------ | ---------- |
> +		| * References             |            |
> +		|   * Count                |      4     |
> +		|     * Branches           |      1     |
> +		|     * Tags               |      1     |
> +		|     * Remotes            |      1     |
> +		|     * Others             |      1     |
> +		|                          |            |
> +		| * Reachable objects      |            |
> +		|   * Count                |   3.02 k   |
> +		|     * Commits            |   1.01 k   |
> +		|     * Trees              |   1.01 k   |
> +		|     * Blobs              |   1.01 k   |
> +		|     * Tags               |      1     |
> +		|   * Inflated size        |  16.03 MiB |
> +		|     * Commits            | 217.92 KiB |
> +		|     * Trees              |  15.81 MiB |
> +		|     * Blobs              |  11.68 KiB |
> +		|     * Tags               |    132 B   |
> +		|   * Disk size            | $(object_type_disk_usage all true) |
> +		|     * Commits            | $(object_type_disk_usage commit true) |
> +		|     * Trees              | $(object_type_disk_usage tree true) |
> +		|     * Blobs              |  $(object_type_disk_usage blob true) |
> +		|     * Tags               |    $(object_type_disk_usage tag) B   |
> +		|                          |            |
> +		| * Largest objects        |            |
> +		|   * Commits              |            |
> +		|     * Maximum size   [1] |    223 B   |
> +		|   * Trees                |            |
> +		|     * Maximum size   [2] |  32.29 KiB |
> +		|   * Blobs                |            |
> +		|     * Maximum size   [3] |     13 B   |
> +		|   * Tags                 |            |
> +		|     * Maximum size   [4] |    132 B   |
> +
> +		[1] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a
> +		[2] 60665251ab71dbd8c18d9bf2174f4ee0d58aa06c
> +		[3] 97d808e45116bf02103490294d3d46dad7a2ac62
> +		[4] 4dae4f5954f5e6feb3577cfb1b181daa3fd3afd2
>  		EOF

I was briefly wondering whether we can do better here and for example
output something like this:

	| * Largest objects              |            |
	|   * Commits                    |            |
	|     * Maximum size   [commits] |    223 B   |

	[commits] 0dc91eb18580102a3a216c8bfecedeba2b9f9b9a

But I think that becomes quite unwieldy as the column's size is extended
quite a bit, so numbers it probably the better interface.

Patrick
