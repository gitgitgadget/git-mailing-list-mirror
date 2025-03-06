Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6CB16D9AA
	for <git@vger.kernel.org>; Thu,  6 Mar 2025 14:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741272247; cv=none; b=CeadyPl2C5sk+SbPMvAtnJDYWHC3Xxbc3Qz+NXd3bf8uP6iWMsHIok6DSA+Fl90YAUfb4LOI5iuK1exlO+AA9A6hoqhSVj3tp0s3DCnTdKrx6w5UgreYnpHI7SrSQTSOe5MoM68kBtNjpflXlHlosLRk1i86jMhRTxzlk3ycuE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741272247; c=relaxed/simple;
	bh=T9KmC+DYFf4drj7OxVl1x6Xrc8d7xBE662VYKlU2cgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOinbxMQFtPgVQDswjrQrF7Qts4Z82c5RyMpKHGwsHqMhmYXgsm2Lt9jzWjvmIy6DiBH0ptV91kNn5oFh5PfhlNuT9ge2GSdhcgOKllQuz2H2QRNsUqqjFHeTN3DhnPFNvh+qyLA/o5BhnZgW3URp3w6rIUo1aj+LMGcngN7usc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JrUAGnLF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SvUb5M3b; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JrUAGnLF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SvUb5M3b"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id B797511401BE;
	Thu,  6 Mar 2025 09:44:03 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 06 Mar 2025 09:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741272243; x=1741358643; bh=wmxuzQXg9R
	GVYNRu9CYZAmrPikKGI9HSzT/cVoHooig=; b=JrUAGnLFQL7rUkzun/UeWSQ3OG
	DJx4Dqwor0BaZTKZrWVtP3+P7pCCQuaXjbFmEYjjM1ZVkD7zLI4RUr76EtmhshFZ
	OZRpcDA5pXVQcDL551Z3W+i0msBfvuVOM2LLMvqAkYWowCdVevSB7/sRPapt1VEK
	JBqkPTDidNl2Az35qwsxCvzdTsuE6NsKCWbI/Hb8Lb6uP1Zbc9YFy+dPSvkiRXFm
	+0pBzapcg3BEv9OMcNWCihXKQWi+hIG/lSYQtOxa6gKIppsveSNfvGF/E5umouhq
	IIg8yz4uPPlJt6WWTS/xuXoC7jfFChbdgKb9T7hVrHJIG6DsTQDxeo1/uzaw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741272243; x=1741358643; bh=wmxuzQXg9RGVYNRu9CYZAmrPikKGI9HSzT/
	cVoHooig=; b=SvUb5M3bV0FiFq07NbW3DmtTiS3oJfAWtqj8BVpFT/28lc6mJeH
	2cscH8MZQfsu8koyjeQfvcg7loN9KLfQDyjbQm/RrrrvV4+RVqJGprVirxr6wj+C
	ER3oBN6csRjHZhJsvdBIWN9EnG5HSPrKTew9eKtlVppQrlSvNbqQANGNlDPMkz+0
	dMKNQ4OlHrArhWE1b9NQAL05ENaexpT32ERs2qXCVaKRghtA86SLLjtWiM/87Y19
	/ZtS6WJaGVBJEQw74HGMSyuuMv7SghOMyOSlj9eYPn9M9EwlrLJkYUv5y1wWKvco
	s1TT7hhgUAeU047ItWg9gWaVaMumJRws1Rw==
X-ME-Sender: <xms:s7TJZyCnJkCScpIp8I0pSk0t2W5CletxtdLZXkidcxd04U3lMeibOw>
    <xme:s7TJZ8gEEiQ7NOvOuiCjGN2T4GMfqGABQ-uDTdnVzaniBTm1QgLJ-FgA16pv0aGkX
    MpqZXfVBWNSP-6f0w>
X-ME-Received: <xmr:s7TJZ1kRuFv8ukAylj9TZI-iYkMeTTJS8jV7blvDezyqjEFV3QD1ahClT9uvHRgy9Jai23Pm5gYpr4Y_67OoMzw2FFQx7cJPpsl7h7A6UAvrrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdektdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehhrghnfigvnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhgv
    vghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:s7TJZwzF5N05-a9_oShkW_bM4k4F-kI8GmiG_LQD57XHgQxjAYNuPg>
    <xmx:s7TJZ3RyxE7Fb6BEn1IGU5I4eJ4vFK4iV6N6M3XqjnO4rQY_-1NjEg>
    <xmx:s7TJZ7aPT6RAPZuxhHPaV_TGd9ynqfvLv7HCIudug0ym8A9FKaawTQ>
    <xmx:s7TJZwRGYzMsYJAKZtC_-9vJyvBr1WF9UwXjaFSnuNn6uGf51GLQcQ>
    <xmx:s7TJZ1MRzjc_iHfg9Gxjec2iQlAmnhWE75ST0XFSfmiPb6B1xwxMTyHq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Mar 2025 09:44:02 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1af85c58 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Mar 2025 14:43:59 +0000 (UTC)
Date: Thu, 6 Mar 2025 15:43:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Meet Soni <meetsoni3017@gmail.com>
Cc: git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC PATCH] reftable: return proper error code from
 block_writer_add()
Message-ID: <Z8m0rnTr2PrqBUKQ@pks.im>
References: <20250306121324.1315290-1-meetsoni3017@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250306121324.1315290-1-meetsoni3017@gmail.com>

On Thu, Mar 06, 2025 at 05:43:24PM +0530, Meet Soni wrote:
> @@ -115,8 +115,9 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
>  	int err;
>  
>  	err = reftable_record_key(rec, &w->scratch);
> -	if (err < 0)
> +	if (err < 0) {
>  		goto done;
> +	}
>  
>  	if (!w->scratch.len) {
>  		err = REFTABLE_API_ERROR;

This change probably shouldn't be here. Our style guide mentions that we
prefer to not have curly braces around single-line statements.

> @@ -126,14 +127,14 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
>  	n = reftable_encode_key(&is_restart, out, last, w->scratch,
>  				reftable_record_val_type(rec));
>  	if (n < 0) {
> -		err = -1;
> +		err = n;
>  		goto done;
>  	}
>  	string_view_consume(&out, n);
>  
>  	n = reftable_record_encode(rec, out, w->hash_size);
>  	if (n < 0) {
> -		err = -1;
> +		err = n;
>  		goto done;
>  	}
>  	string_view_consume(&out, n);

Okay. `reftable_encode_key()` right now only knows to return generic
errors, but you fix that further down, and you also adapt
`reftable_record_encode()`.

> diff --git a/reftable/record.c b/reftable/record.c
> index 8919df8a4d..5523804a0c 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -148,18 +148,18 @@ int reftable_encode_key(int *restart, struct string_view dest,
>  	uint64_t suffix_len = key.len - prefix_len;
>  	int n = put_var_int(&dest, prefix_len);
>  	if (n < 0)
> -		return -1;
> +		return REFTABLE_ENTRY_TOO_BIG_ERROR;
>  	string_view_consume(&dest, n);
>  
>  	*restart = (prefix_len == 0);
>  
>  	n = put_var_int(&dest, suffix_len << 3 | (uint64_t)extra);
>  	if (n < 0)
> -		return -1;
> +		return REFTABLE_ENTRY_TOO_BIG_ERROR;
>  	string_view_consume(&dest, n);
>  
>  	if (dest.len < suffix_len)
> -		return -1;
> +		return REFTABLE_ENTRY_TOO_BIG_ERROR;
>  	memcpy(dest.buf, key.buf + prefix_len, suffix_len);
>  	string_view_consume(&dest, suffix_len);
>  

Makes sense.

> @@ -1144,14 +1144,20 @@ static struct reftable_record_vtable reftable_index_record_vtable = {
>  
>  int reftable_record_key(struct reftable_record *rec, struct reftable_buf *dest)
>  {
> -	return reftable_record_vtable(rec)->key(reftable_record_data(rec), dest);
> +	int key_len = reftable_record_vtable(rec)->key(reftable_record_data(rec), dest);
> +	if (key_len < 0)
> +		return REFTABLE_ENTRY_TOO_BIG_ERROR;
> +	return key_len;
>  }

This here is incorrect. We don't know why the `->key()` function has
failed, so we shouldn't assume `TOO_BIG_ERROR`. We'd have to vet all the
implementations of that function and then should bubble up their
respective error codes.

>  int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
>  			   uint32_t hash_size)
>  {
> -	return reftable_record_vtable(rec)->encode(reftable_record_data(rec),
> +	int encode_len = reftable_record_vtable(rec)->encode(reftable_record_data(rec),
>  						   dest, hash_size);
> +	if (encode_len < 0)
> +		return REFTABLE_ENTRY_TOO_BIG_ERROR;
> +	return encode_len;
>  }
>  
>  int reftable_record_copy_from(struct reftable_record *rec,

Same remark here.

Thanks!

Patrick
