Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E942B73A
	for <git@vger.kernel.org>; Thu, 26 Feb 2026 20:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772137766; cv=none; b=oEXe9hNHkWtCOAc4unHWnV0A6CRwj+fm5SLkgVxkiJ8bbIRCQALPs+3JDMYJabAVDQpxGubgvsjt1WiGmzSmhI7FKCTDjrGpHoSuAKECIkujGe5YFp/3oQ+XEYP98rd7TCwBN+6i9fhFRShZQEh85E2gFZ05NKUQCC11eZhGsHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772137766; c=relaxed/simple;
	bh=EiKmDf5/+Di6n0WVG5AM1QJ5FJNlGT9w1X3Hmp0ckNw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BmsFg1V+4NrZ7F/qBK6eZi1/TCnddnMboutzBu5D6wid/SlpWntmwmREoQMRTv+bkwSOnqZTsknhp2v1pYRQgPkbFjtBKfsh9pomjxnWxbONG89tM87QWxKZiEKT+oS5232UF53QrOWjnq7J7VKKY53Kv5GDriW06Rr4laRkYJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Na7b/0aS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CCKtIBHk; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Na7b/0aS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CCKtIBHk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 379177A0125;
	Thu, 26 Feb 2026 15:29:24 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 26 Feb 2026 15:29:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1772137764; x=1772224164; bh=VGxQ4kzR0I
	CwqGTVBd96fnukr+5DHKuqFSlTFxTXZ+A=; b=Na7b/0aSvFqwrznEjYExrbtvck
	ieHY31vLLXag/OrmpLp2v+wxDDAkQYPBpjoIjyF3V9LbOghFDdoLedprXcKVaKyF
	xkbbuA5j+r7SX7f6zwVukb5soDDLL6oAz/2mq112H5yef+lP3tLJLneyGt3g9c/9
	tNm2MdgZPpPSg2fadlDQNw1VgzpWNhGOJNNhlQT2AUZ1g9JYbbOcPN+7h12U+pqS
	c7K+ZEu6EwObbzVS3aatOzzkWHAASXdk8EmkO/kLULK5UFRCpr+46iKDzSacepDF
	+7DcW708cdrbM4K1D+i3+7bYx/u3ksw5rAqMMVeRwa1Tn49mbtxPZVvbqPEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1772137764; x=1772224164; bh=VGxQ4kzR0ICwqGTVBd96fnukr+5DHKuqFSl
	TFxTXZ+A=; b=CCKtIBHk9UTNtQlCMxLrVju/Cckhd8uNvoav9C7wF5avTlFSfBg
	4FqsPqBCDjqXYueHQFhnqO4iRGYqqWqgEKoSWvTYDgiPoPZBxSGy3leNcqabDD3d
	Hp4xCeUnjXElacVRIr1/uH4rXrHEeQ1srCq6CdwOunsMRaEXYc5aF8qtUZDGCAP7
	PEuWDiRu9bNsnly52NENAEWydiNPJFI7LgvnnLEHH7f8cuyCO1ACumtSb09mL8GV
	OwDMEwgDhElGpIpdZhcFBAGQUwVuD0PXTLRi1uElQhryDnEIn+ov2FZ30F4gmft2
	cT5K/FxqqZ/y+dotLuv3dpQnqP+nq574+0w==
X-ME-Sender: <xms:I62gaeW4wMt6p440PMfuIqHxWNFOqMC0UyIp-trOrJu1KbNy88WCVA>
    <xme:I62gaeS4uect7dhFyPe5E67L6T7yqaUf87tGX1SeUoVsMNR0AVKAK-ukkxl7TVF5O
    SpYKGL68LCyiNdBH3TRURU-_kMPZiR3aXRuWwU2snY6R15Vb65MNw>
X-ME-Received: <xmr:I62gacPrI_kXgTrDJlzwxox04gwx9-vH5vlwGhqOH3uoovduaj1WGf768UIKwR47sWmShFW1d2K8-WL7Ovq-WL6Aqvem7WDEWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehp
    vghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtph
    htthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:I62gacQDzq9Af8_DW-aYaGY-sRVAVQOxzaKhOImql59rIf_oSH43cw>
    <xmx:I62gaaiBP8kobXkK8G1rCiSJHescStdIPaNAGFghe5M-ouHMrb2i_w>
    <xmx:I62gaV9Dl4S_viXNbf1tUao3909PToneVUWDpD_hbRvwKQ2Ix72tnQ>
    <xmx:I62gaRGAi-adjb8XcvvFw5uaU2PBpH8W7ae5TXe4SV-5-0tHTa2I-A>
    <xmx:JK2gaYwbhHvb6LHwkiy1rTxzFakJjOgMm5LcfuamFp9sKX_MpMCG0JD_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Feb 2026 15:29:23 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Elijah Newren
 <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 01/14] midx: use `string_list` for retained MIDX files
In-Reply-To: <d64a799afd620363c1940d7c2e634e78ea553cb6.1771978829.git.me@ttaylorr.com>
	(Taylor Blau's message of "Tue, 24 Feb 2026 19:20:56 -0500")
References: <cover.1771978829.git.me@ttaylorr.com>
	<d64a799afd620363c1940d7c2e634e78ea553cb6.1771978829.git.me@ttaylorr.com>
Date: Thu, 26 Feb 2026 12:29:22 -0800
Message-ID: <xmqqldgf1c65.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> Both `clear_midx_files_ext()` and `clear_incremental_midx_files_ext()`
> build a list of filenames to keep while pruning stale MIDX files. Today
> they hand-roll an array instead of using a `string_list`, thus requiring
> us to pass an additional length parameter, and makes lookups linear.
>
> Replace the bare array with a `string_list` which can be passed around
> as a single parameter. Though it improves lookup performance, the
> difference is likely immeasurable given how small the keep_hashes array
> typically is.

And if it the lookup performance turns out to be an issue, we can
switch to strmap or something more appropriate.

>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx.c | 56 ++++++++++++++++++++++----------------------------------
>  1 file changed, 22 insertions(+), 34 deletions(-)
>
> diff --git a/midx.c b/midx.c
> index c1b9658240d..c5e3553e2bb 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -755,8 +755,7 @@ int midx_checksum_valid(struct multi_pack_index *m)
>  }
>  
>  struct clear_midx_data {
> -	char **keep;
> -	uint32_t keep_nr;
> +	struct string_list keep;
>  	const char *ext;
>  };
>  
> @@ -764,15 +763,12 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUS
>  				const char *file_name, void *_data)
>  {
>  	struct clear_midx_data *data = _data;
> -	uint32_t i;
>  
>  	if (!(starts_with(file_name, "multi-pack-index-") &&
>  	      ends_with(file_name, data->ext)))
>  		return;
> -	for (i = 0; i < data->keep_nr; i++) {
> -		if (!strcmp(data->keep[i], file_name))
> -			return;
> -	}
> +	if (string_list_has_string(&data->keep, file_name))
> +		return;
>  	if (unlink(full_path))
>  		die_errno(_("failed to remove %s"), full_path);
>  }
> @@ -780,48 +776,40 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUS
>  void clear_midx_files_ext(struct odb_source *source, const char *ext,
>  			  const char *keep_hash)
>  {
> -	struct clear_midx_data data;
> -	memset(&data, 0, sizeof(struct clear_midx_data));
> -
> -	if (keep_hash) {
> -		ALLOC_ARRAY(data.keep, 1);
> -
> -		data.keep[0] = xstrfmt("multi-pack-index-%s.%s", keep_hash, ext);
> -		data.keep_nr = 1;
> -	}
> -	data.ext = ext;
> -
> -	for_each_file_in_pack_dir(source->path,
> -				  clear_midx_file_ext,
> -				  &data);
> +	struct clear_midx_data data = {
> +		.keep = STRING_LIST_INIT_NODUP,
> +		.ext = ext,
> +	};
>  
>  	if (keep_hash)
> -		free(data.keep[0]);
> -	free(data.keep);
> +		string_list_insert(&data.keep, xstrfmt("multi-pack-index-%s.%s",
> +						       keep_hash, ext));
> +
> +	for_each_file_in_pack_dir(source->path, clear_midx_file_ext, &data);
> +
> +	string_list_clear(&data.keep, 0);
>  }
>  
>  void clear_incremental_midx_files_ext(struct odb_source *source, const char *ext,
>  				      char **keep_hashes,
>  				      uint32_t hashes_nr)
>  {
> -	struct clear_midx_data data;
> +	struct clear_midx_data data = {
> +		.keep = STRING_LIST_INIT_NODUP,
> +		.ext = ext,
> +	};
>  	uint32_t i;
>  
> -	memset(&data, 0, sizeof(struct clear_midx_data));
> -
> -	ALLOC_ARRAY(data.keep, hashes_nr);
>  	for (i = 0; i < hashes_nr; i++)
> -		data.keep[i] = xstrfmt("multi-pack-index-%s.%s", keep_hashes[i],
> -				       ext);
> -	data.keep_nr = hashes_nr;
> -	data.ext = ext;
> +		string_list_append(&data.keep,
> +				   xstrfmt("multi-pack-index-%s.%s",
> +					   keep_hashes[i], ext));
> +	string_list_sort(&data.keep);
>  
>  	for_each_file_in_pack_subdir(source->path, "multi-pack-index.d",
>  				     clear_midx_file_ext, &data);
>  
> -	for (i = 0; i < hashes_nr; i++)
> -		free(data.keep[i]);
> -	free(data.keep);
> +	string_list_clear(&data.keep, 0);
>  }
>  
>  void clear_midx_file(struct repository *r)
