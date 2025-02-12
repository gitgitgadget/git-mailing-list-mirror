Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA21D206F21
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 09:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739354222; cv=none; b=h0F7/t/X0y0x57Gk9iWSiTt96NwgBKmpUe1TI3yVWzOFn4j2+Tc89YrYsoZEQk1HRIdfheD+G9Au7ikvpjgzAPzEQ/kcIz4bFEJhYCpcXGkPzANK0gCsAu6eb3xZU3CJZ+ePwojZ1QApSePT7UsMQ9UaYtTBNBRwB1tmED4Qq0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739354222; c=relaxed/simple;
	bh=ZU38HQGai4qNFy6FfUReLmEQoGi8J9RQx+YtVo4p8PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfYvrRbWQXvxfbarrPhoi3LL3kECSxMKz3U6wm4uguR3cwEDGxa/7O2wBD9KG9qxP70CaRStzOKNs2YVi3+A2Tc9FzojNYEXGP7TDjaF43T0Xyza/qLbOYdW4xJAqRavHmCq1yCZsbBeRxV0R/oUNL3Lp2bVoeisnVYn99NpKts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e5gXKqxf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s8Eeofnd; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e5gXKqxf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s8Eeofnd"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8305114013D;
	Wed, 12 Feb 2025 04:56:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 12 Feb 2025 04:56:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739354219; x=1739440619; bh=nhwZHP6V+K
	Ft9ZAUQmXL2xIegSuO3P3aMlkeTzFDZh4=; b=e5gXKqxf+qFbT5uf7jivOh2Or1
	mfwJC08jkBn1QxSgxO+JqC+xZ7rahnBQGWcaWIi1bWByBoroTrOoew32/Ln1iBjm
	VG6yPl6twm/2i5lCu82Tb4HiHYln45+39hthrcls9l/660ulb9gJe8hQRGKMCmfC
	TCdpczEsE6UuKO3Gn+7GXFxYWxGJQLvcgOytPHMnifXcEI35RWDZQIVhdkHbCxpf
	7dnreP17nElNw6OolXNqtyvxjGy8EA21AFS2goN2kESQzr2OPebYUxMk9AKBte77
	YJQ93Vq0WXKCXFcWWJBVG4MQBhlHTCTqp8NS2XPOdj/zTdZrxwNWnh/KfLWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739354219; x=1739440619; bh=nhwZHP6V+KFt9ZAUQmXL2xIegSuO3P3aMlk
	eTzFDZh4=; b=s8EeofndXmJvWnFyIBZOKd08ZTBFPKPMUHmBEHk60ckDyaDpwCr
	TWSxdxmiqFpBg8EQDWMdMvoD0zTG1Ggp2q/+K12U4q+j5jlqzb2eeFIh+3J/V1qL
	cpyG2MxcvzgMwcT4EevaX094XVr1u7lr3n9sDEqQFVh8eJtdFAVihTbsFO8ASX3w
	eEUqZjOpPl+D2H2aWj9r9M7C4mL/Af0M4inUsN3AH9cougwUQifRUAx7oU5TbqZW
	ScfonElfJC+yFDNp+69YgSnE/n0R9EVC1deKuyKKDKUYaDVwQRbkU3NSEOyvHel+
	NuWOfqiySEENxL+3AfB+YlcYhUbrM18Ma8w==
X-ME-Sender: <xms:a3CsZxKc1wulk1i8meOURsBSUlMenOgYGd4N9tmh998zjCgL-BFhOA>
    <xme:a3CsZ9K7k4XMW3jdzv-nIC43FK1F1hrVEFx7iypUH4HjGuNUrIABG8m3paK0sghN6
    GRopUNrC8J2zqBFHg>
X-ME-Received: <xmr:a3CsZ5v8ndNIMaJYC4CbqzqHmx4fDnmvFNh0EsbDh__vETNMt40TJyt_QM1r1f6KoPOfea9mu5zqhHpfxh7f07Cu6jGV5QWSlMiKzOl25RSEFUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepmhhhrghgghgvrhesrghluhhmrdhmihhtrdgvughupdhrtghpthht
    ohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:a3CsZyY8_5grFlM1qVNcVM4-KpKgvNjbc53pjCH5YEwmxre7wH62dQ>
    <xmx:a3CsZ4aEAhgMTBnSGYmEHwATqLFWdvIGM1d7oXud-CCYOogX5ZK1HA>
    <xmx:a3CsZ2BtkVx-G4aDv9jwLYBDANqXtkkKFqnUbU8l0lLeA8YE-kBoCg>
    <xmx:a3CsZ2ZjTZnHOOXKHJJpuM0X-1mwBHOuTmDRIik1ZghJ_eHn_4HzTQ>
    <xmx:a3CsZ3zUoBvY2zr-dDZkQse0-us8m2tRoKjTwXZTIHOKprBvXieGjQBq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 04:56:58 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c5f51e71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 09:56:57 +0000 (UTC)
Date: Wed, 12 Feb 2025 10:56:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 7/8] packed-backend: check whether the "packed-refs"
 is sorted
Message-ID: <Z6xwaMIUx_x6QVrU@pks.im>
References: <Z6RPJI10-2QkwyqH@ArchLinux>
 <Z6RP2_wL1gjsWpkR@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6RP2_wL1gjsWpkR@ArchLinux>

On Thu, Feb 06, 2025 at 01:59:55PM +0800, shejialuo wrote:
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index 658f6bc7da..0fbdc5c3fa 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1767,6 +1773,28 @@ static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_s
>  	return empty_ref_iterator_begin();
>  }
>  
> +struct fsck_packed_ref_entry {
> +	unsigned long line_number;
> +
> +	struct snapshot_record record;
> +};
> +
> +static struct fsck_packed_ref_entry *create_fsck_packed_ref_entry(unsigned long line_number,
> +								  const char *start)
> +{
> +	struct fsck_packed_ref_entry *entry = xcalloc(1, sizeof(*entry));
> +	entry->line_number = line_number;
> +	entry->record.start = start;
> +	return entry;
> +}
> +
> +static void free_fsck_packed_ref_entries(struct fsck_packed_ref_entry **entries, size_t nr)
> +{
> +	for (size_t i = 0; i < nr; i++)
> +		free(entries[i]);
> +	free(entries);
> +}
> +
>  static int packed_fsck_ref_next_line(struct fsck_options *o,
>  				     struct strbuf *packed_entry, const char *start,
>  				     const char *eof, const char **eol)
> @@ -1794,19 +1822,33 @@ static int packed_fsck_ref_next_line(struct fsck_options *o,
>  }
>  
>  static int packed_fsck_ref_header(struct fsck_options *o,
> -				  const char *start, const char *eol)
> +				  const char *start, const char *eol,
> +				  unsigned int *sorted)
>  {
> -	if (!starts_with(start, "# pack-refs with:")) {
> +	struct string_list traits = STRING_LIST_INIT_NODUP;
> +	char *tmp_line;
> +	int ret = 0;
> +	char *p;
> +
> +	tmp_line = xmemdupz(start, eol - start);
> +	if (!skip_prefix(tmp_line, "# pack-refs with:", (const char **)&p)) {
>  		struct fsck_ref_report report = { 0 };
>  		report.path = "packed-refs.header";
>  
> -		return fsck_report_ref(o, &report,
> -				       FSCK_MSG_BAD_PACKED_REF_HEADER,
> -				       "'%.*s' does not start with '# pack-refs with:'",
> -				       (int)(eol - start), start);
> +		ret = fsck_report_ref(o, &report,
> +				      FSCK_MSG_BAD_PACKED_REF_HEADER,
> +				      "'%.*s' does not start with '# pack-refs with:'",
> +				      (int)(eol - start), start);
> +		goto cleanup;
>  	}
>  
> -	return 0;
> +	string_list_split_in_place(&traits, p, " ", -1);
> +	*sorted = unsorted_string_list_has_string(&traits, "sorted");

I think we call them capabilities, not traits.

[snip]
>  static int packed_fsck_ref_content(struct fsck_options *o,
>  				   struct ref_store *ref_store,
>  				   const char *start, const char *eof)
>  {
>  	struct strbuf packed_entry = STRBUF_INIT;
> +	struct fsck_packed_ref_entry **entries;
>  	struct strbuf refname = STRBUF_INIT;
>  	unsigned long line_number = 1;
> +	unsigned int sorted = 0;
> +	size_t entry_alloc = 20;
> +	size_t entry_nr = 0;
>  	const char *eol;
>  	int ret = 0;
>  
>  	strbuf_addf(&packed_entry, "packed-refs line %lu", line_number);
>  	ret |= packed_fsck_ref_next_line(o, &packed_entry, start, eof, &eol);
>  	if (*start == '#') {
> -		ret |= packed_fsck_ref_header(o, start, eol);
> +		ret |= packed_fsck_ref_header(o, start, eol, &sorted);
>  
>  		start = eol + 1;
>  		line_number++;
>  	}
>  
> +	ALLOC_ARRAY(entries, entry_alloc);
>  	while (start < eof) {
> +		struct fsck_packed_ref_entry *entry
> +			= create_fsck_packed_ref_entry(line_number, start);

Instead of slurping in all entries and allocating them in an array, can
we instead remember the last one and just compare that the last record
is smaller than the current record?

> @@ -1915,11 +2011,16 @@ static int packed_fsck_ref_content(struct fsck_options *o,
>  			start = eol + 1;
>  			line_number++;
>  		}
> +		entry->record.len = start - entry->record.start;
>  	}
>  
> +	if (!ret && sorted)
> +		ret |= packed_fsck_ref_sorted(o, ref_store, entries, entry_nr);

Okay, we now conditionally check whether the refs are sorted based on
whether or not we found the "sorted" capability.

> diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> index 3ab6b5bba5..adcb5c1bda 100755
> --- a/t/t0602-reffiles-fsck.sh
> +++ b/t/t0602-reffiles-fsck.sh
> @@ -706,4 +706,67 @@ test_expect_success 'packed-refs content should be checked' '
>  	)
>  '
>  
> +test_expect_success 'packed-ref with sorted trait should be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit default &&
> +		git branch branch-1 &&
> +		git branch branch-2 &&
> +		git tag -a annotated-tag-1 -m tag-1 &&
> +		branch_1_oid=$(git rev-parse branch-1) &&
> +		branch_2_oid=$(git rev-parse branch-2) &&
> +		tag_1_oid=$(git rev-parse annotated-tag-1) &&
> +		tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
> +		refname1="refs/heads/main" &&
> +		refname2="refs/heads/foo" &&
> +		refname3="refs/tags/foo" &&
> +		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
> +		printf "%s %s\n" "$branch_2_oid" "$refname1" >>.git/packed-refs &&
> +		printf "%s %s\n" "$branch_1_oid" "$refname2" >>.git/packed-refs &&

Same comment here as in the previous patch, this can be simplified with
HERE docs.

> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: packed-refs line 2: packedRefUnsorted: refname '\''$refname1'\'' is not less than next refname '\''$refname2'\''
> +		EOF
> +		rm .git/packed-refs &&
> +		test_cmp expect err &&
> +
> +		printf "# pack-refs with: peeled fully-peeled sorted \n"  >.git/packed-refs &&
> +		printf "%s %s\n" "$tag_1_oid" "$refname3" >>.git/packed-refs &&
> +		printf "^%s\n" "$tag_1_peeled_oid" >>.git/packed-refs &&
> +		printf "%s %s\n" "$branch_2_oid" "$refname2" >>.git/packed-refs &&
> +		test_must_fail git refs verify 2>err &&
> +		cat >expect <<-EOF &&
> +		error: packed-refs line 2: packedRefUnsorted: refname '\''$refname3'\'' is not less than next refname '\''$refname2'\''
> +		EOF
> +		rm .git/packed-refs &&
> +		test_cmp expect err
> +	)
> +'
> +
> +test_expect_success 'packed-ref without sorted trait should not be checked' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	(
> +		cd repo &&
> +		test_commit default &&
> +		git branch branch-1 &&
> +		git branch branch-2 &&
> +		git tag -a annotated-tag-1 -m tag-1 &&
> +		branch_1_oid=$(git rev-parse branch-1) &&
> +		branch_2_oid=$(git rev-parse branch-2) &&
> +		tag_1_oid=$(git rev-parse annotated-tag-1) &&
> +		tag_1_peeled_oid=$(git rev-parse annotated-tag-1^{}) &&
> +		refname1="refs/heads/main" &&
> +		refname2="refs/heads/foo" &&
> +		refname3="refs/tags/foo" &&
> +		printf "# pack-refs with: peeled fully-peeled \n"  >.git/packed-refs &&
> +		printf "%s %s\n" "$branch_2_oid" "$refname1" >>.git/packed-refs &&
> +		printf "%s %s\n" "$branch_1_oid" "$refname2" >>.git/packed-refs &&

And here.

Patrick
