Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4122ECE8D
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 14:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948405; cv=none; b=aAImLpgOJjlVDUZG0x46ZiAyUB+F9zllmsTWB6jOQyW2UeYZeBFKLnJIK5AOmQLIRGQF9ApGVf9QqWzbs9DLpQoHCEktga/y83EzPoD8PPKtOo4y3SD2GEWocJVSxfSHAQ5px/SKZIDIcLbyC9/mb60cBlmlolTfem0RSL6XZfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948405; c=relaxed/simple;
	bh=NrWCtUv6IqDvgTIDuLoByqQ3+QigejNMjp3nXx4szY8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RlpGK6+MUPBsGZ2lv3hsiYOap8qEhRaE+HxKSN0pCrkhjcHgYXqgRNXKVFffbZ2jRBeKssfhNRV6FJNhzbEdofwIGrwlQ8rlfwpWcnLSkTfUIic20Vt1eJcWkRVxeLdcl/ShtRgMK1Wu4mjIP8awWw0/OghHjt6rDASB8fa2heM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=CMp7OWJl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ktPPpAte; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="CMp7OWJl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ktPPpAte"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id ABAD1EC01D8;
	Thu, 26 Jun 2025 10:33:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Thu, 26 Jun 2025 10:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1750948402; x=1751034802; bh=xmZVe0VvUI
	SMlHsgo5JaVtxw3y2RYS1QCHMjhtVAkPU=; b=CMp7OWJlFdZHNVks0fhkcmjOKo
	GQ8xEZAjEwgPA4n6gwbbZW+xabBWQPY73FpMrvP7zt6qGdDfwrtfPn4s7CC68JHU
	JBi8sKjcyrdReWH1Bpfz2K9izhXZ6EyCptML4SmPNgvIFre9L/TmxWkf+IeJVk8L
	2vYAlztnAoqpXSScbRM6g105XNV1+FVuMkLwPObenfzTAMKdcgcyKqvqYrMAI2ef
	AcBO7zcUPamG+pGWxeHpYJf7d6YarzzNB21DJrTeDE34W2XnTAucJEGNen+X3tFm
	7NpnrDSnFevfkA527/GiIW9rE5vXTK1lT9XWTP4XBRBMtp4YxdimDOFgBtPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1750948402; x=1751034802; bh=xmZVe0VvUISMlHsgo5JaVtxw3y2RYS1QCHM
	jhtVAkPU=; b=ktPPpAteGSLoV9XctOk+uI9+TR/kuyMPBv0ezoxyJ1WXVk4z9OE
	XopdCDVA+/UP8tJvjKu8HZxk6miru3duozdTdahjnhmuFQdywqmMY+Tx7zhakNnu
	ixaeEV82hcGMGfmUTXmmmXUl+u1YkEkj+TawPEEefToFZHd8kXzErJZm3n6oCBSm
	sVWYLF1++UUjrA7GnZTeWyRjBSFaI5PiBH5xTCBpPywqxjkz9eHB9oO5SPJch1Do
	Zk0tHEBhNZdugypcplvZV1OIs/xkD4gWbpsHY80yQUIF2LGp1J0/HEgXVvSAeY/5
	UvQJP4iwYu0xbMZwnIpRVtyqtmjFIDF5jJA==
X-ME-Sender: <xms:MlpdaK3o9CjmbDi9n8dbPvApG1AI2Uw-jM9N2N3ciGuyccSgnXGTQw>
    <xme:MlpdaNGbxEb6RmzoJmvCQMhwcUxe39MZM2YByK2iyGIQgAIA9k6SxlLgYvlHhuGtp
    PKyMMoFSOYoIvta8g>
X-ME-Received: <xmr:MlpdaC52wJ8qklrKOqMNVkX6Xm8Q8Vcd59u8EOgmAQqejuxze4wFAZx6oSMv7U8J_7QB-oSOAoVXIbNrKnO9ApuU0kjNUygHaD8ptlE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegrihhl
    ohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpe
    fhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfj
    rghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrh
    hnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegt
    hhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshh
    ihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhl
    lhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MlpdaL0RawpJrbTrbFCB3dZ2ewTacOGygYNK9vg-nGJoSyWAQsnaAQ>
    <xmx:MlpdaNEfBh7DhN1JCx8ztqQOQcy2Mw-bGHly6N0T7dqfL3MF98G6xg>
    <xmx:MlpdaE_uw1zOUplZnT-ObAlwPs7Jk4fPhK7QedANthhtr5k-zYZdXA>
    <xmx:MlpdaCkD-Sy5BrtWRTRhQ94i0gNh9AzXiPcM_wvNGSDyNma1-eBAgw>
    <xmx:MlpdaNRZM7Dgm1dtnyTbWb7vZt9J_rS2sl-touuKgeGWAx7JpTAhVjZy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Jun 2025 10:33:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  shyamthakkar001@gmail.com,  phillip.wood123@gmail.com
Subject: Re: [GSOC PATCH] commit: avoid scanning trailing comments when
 'core.commentChar' is "auto"
In-Reply-To: <20250626132233.414789-1-ayu.chandekar@gmail.com> (Ayush
	Chandekar's message of "Thu, 26 Jun 2025 18:52:33 +0530")
References: <20250626132233.414789-1-ayu.chandekar@gmail.com>
Date: Thu, 26 Jun 2025 07:33:21 -0700
Message-ID: <xmqq5xgir2ry.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ayush Chandekar <ayu.chandekar@gmail.com> writes:

> When core.commentChar is set to "auto", Git selects a comment character
> by scanning the commit message contents and avoiding any character
> already present in the message.
>
> If the message still contains old conflict comments (starting with a
> comment character), Git assumes that character is in use and chooses a
> different one. As a result, those existing comment lines are no longer
> recognized as comments and end up being included in the final commit
> message.
>
> To avoid this, skip scanning the trailing comment block when selecting
> the comment character. This allows Git to safely reuse the original
> character when appropriate, keeping the commit message clean and free of
> leftover conflict information.
>
> Background:
>
> The "auto" value for core.commentchar was introduced in the commit
> `84c9dc2` (commit: allow core.commentChar=auto for character auto
> selection) but did not exhibt this issue at that time.

Use "git log -1 --format=reference", i.e.

84c9dc2c (commit: allow core.commentChar=auto for character auto
selection, 2014-05-17)

> The bug was introduced in commit `a6c2654` (rebase -m: fix --signoff
> with conflicts) where Git started writing conflict comments to the file
> at 'rebase_path_message()'.

Ditto.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index fba0dded64..63e7158e98 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -688,6 +688,10 @@ static void adjust_comment_line_char(const struct strbuf *sb)
>  	char candidates[] = "#;@!$%^&|:";
>  	char *candidate;
>  	const char *p;
> +	size_t cutoff;
> +
> +	/* Ignore comment chars in trailing comments (e.g., Conflicts:) */
> +	cutoff = sb->len - ignored_log_message_bytes(sb->buf, sb->len);
>  
>  	if (!memchr(sb->buf, candidates[0], sb->len)) {
>  		free(comment_line_str_to_free);
> @@ -700,7 +704,7 @@ static void adjust_comment_line_char(const struct strbuf *sb)
>  	candidate = strchr(candidates, *p);
>  	if (candidate)
>  		*candidate = ' ';
> -	for (p = sb->buf; *p; p++) {
> +	for (p = sb->buf; p + 1 < sb->buf + cutoff; p++) {
>  		if ((p[0] == '\n' || p[0] == '\r') && p[1]) {
>  			candidate = strchr(candidates, p[1]);
>  			if (candidate)

Looks quite straight-forward.  Nice.

Thanks.
