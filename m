Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F885222580
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462294; cv=none; b=D4P14aZKFSbXv9UhDHgHkytIVpO8mIRHZ0IUEOVc5IIBl7WAdG3mLCiSn96BEqL4pK2KessLC5uAN51HTqVBlUW6ErK/LOgo+fe9RfoqBKQBSxGmhrsSi81bjLf7fGzkKH/p8iEEwtS8g2KdQFShPrsYCFE5Z25qS6PKc/65Hhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462294; c=relaxed/simple;
	bh=MlCMbR2S1tTBkgrrCnwtNqhbtOoYtdMVn13uv5bxNzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eNkxpaeLRudbjhukRNGLHT+toPY0Gw8igkuVkwL+FtGidOv5cXWgE6TfsX6yBSrXjCZbaYJLBVfLIPkjbo0VF53PSA+45lVELKqwcoR28R784741MSRTBnxc2pAIKR6E2YejGMLRvDMw2KFwbSow2t0aB98sbNIunDUPhfgrKMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AReR2FRT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zTKz5Pri; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AReR2FRT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zTKz5Pri"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id A6495114018F;
	Thu, 20 Mar 2025 05:18:11 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 20 Mar 2025 05:18:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742462291;
	 x=1742548691; bh=S9SBQrMrmMx4PFYEw2UwSeMQKpSjKMsm5VEJKjnXkZw=; b=
	AReR2FRTRTnockKMlYPVYnosceQSP+cCMOWX9dXZnI2zyZBIboSvqTvUctowjxSi
	fB2zzVA2NgudH49owm1SzDAw/TTpRK5TaK+IoTRaqh4KRQW2KzY4DWK1XFFX0huI
	MGepSuu5MK/QKo232SN49JIZhKVN/cMcmtrzQYcygjumNNv2+IFXfreCijpThdeJ
	KseCCWyLHGyuDpUr6m+tRIJANSWW35xsI7H5jTXFJFOLb1VWfTubQSst4inHvxfE
	GCfR4LFsD43EkeyDbNSBh8kKTZroL5bN8oF9jFNhvnLJBC1ahDMQ1dyoThJLeRNW
	r0hOjKjvNGNwESINcCd0+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742462291; x=
	1742548691; bh=S9SBQrMrmMx4PFYEw2UwSeMQKpSjKMsm5VEJKjnXkZw=; b=z
	TKz5PriwTc5p8Imfu97CERUMYPWQDUKU16diB/AtCGb4T82AtEUnGMd8SK6jsKIW
	NbET0LEXLPaBhdHT/zaQpAM+ZPIj+pfSXZMVFphY4kYUEvdj/Jg8IYpLc6I6qL+M
	pHjL2RxqgUpgRO6CuL3U/l8yaOR5rNvR445imX0IPzBJJ/snwqh3fPFGoYi112Ev
	JZqDtce91RjV22dORZNCics/QYV7V/WFOfymxUtHqXUlVMN2e0W7z4ZTTyqmYvDw
	K+jHaXeE8pcSQ2Fn/sGxh6jjWoh1ivNRFXptVfJqn8YXhWI5kURx3AEXgzM1dlPN
	zl63AxVz1mJ3wREfeQBXA==
X-ME-Sender: <xms:U93bZ37r4tP0ywF7tX4RF_aolEZ0edO2mzBvnN4X5vGeyOn9NSUSJg>
    <xme:U93bZ86UT7u9q6Oz6gHqr3Qf4e2iuO7ZNtCZ3PkMA945GyaSRdum82elhiFViMJKS
    soj2z_96gQRY8sIxw>
X-ME-Received: <xmr:U93bZ-fH2wn3Vd3HWQYTSqndFDYG-cZod_x9j-N6u5ydJ0HboGxlE480mY8XyCbkZjNBBY-fDOvKXJSXajlMHTff5gbWtckd3AmaPkmSqXM5j-U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepmhgrrhhtihhnrdgrghhrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtoheplhdrshdrrhesfigvsgdruggv
X-ME-Proxy: <xmx:U93bZ4ITBYhukJZk1G6fLG4fXGpenk7RxyeorDMTlvNvE-oH-IajWg>
    <xmx:U93bZ7Ley235_gMOFg5EdJlvEyTaTHJMQINCqMHDc_-Ez4TwFRGQPg>
    <xmx:U93bZxxa4BLzHuFejTt1vuhmw4mXEqE2bDaIl1ba_oaoNjPHtw9d3Q>
    <xmx:U93bZ3IX6Waqnpqb5znCRtMIqsG6S_0BiSJtHOOUPLuTgteqhuGuXQ>
    <xmx:U93bZz1nlxYg-Rz3hymAIGp0u03ADRnz8RR3PYeJwGqkvAsodKMWN3Jn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:18:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0cff5141 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:18:09 +0000 (UTC)
Date: Thu, 20 Mar 2025 10:18:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 6/8] pretty: refactor parsing of line-wrapping "%w"
 placeholder
Message-ID: <Z9vdUTQTnctm3965@pks.im>
References: <cover.1742367347.git.martin.agren@gmail.com>
 <465c91155eb30197b5eac00d294dc6e7ea2dd310.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <465c91155eb30197b5eac00d294dc6e7ea2dd310.1742367347.git.martin.agren@gmail.com>

On Wed, Mar 19, 2025 at 08:23:39AM +0100, Martin Ågren wrote:
> Our parsing of a "%w" placeholder is quite a big chunk of code in
> the middle of our switch for handling a few different placeholders. We
> parse into three different variables, then use them to compare to and
> update existing values in the big `struct format_commit_context`.
> 
> Pull out a helper function for parsing such a "%w" placeholder. Define a
> struct for collecting the three variables.
> 
> Unlike recent commits, parsing and subsequent use are already a bit more
> separated in the sense that we don't parse directly into the big context
> struct. Thus, unlike the preceding commits, this does not fix any bugs
> that I'm aware of. There's still value in separating parsing and usage
> more clearly and simplifying `format_commit_one()`.
> 
> Note that we use two different types for these values, `unsigned long`
> when parsing, `size_t` when eventually applying. Let's go for `size_t`
> in our struct. I don't know if there are platforms where assigning an
> `unsigned long` to a `size_t` could truncate the value, but since we
> already verify the values to be at most 16 KiB, we should be able to fit
> them into any sane `size_t`s.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  pretty.c | 120 +++++++++++++++++++++++++++++++++++--------------------
>  1 file changed, 76 insertions(+), 44 deletions(-)
> 
> diff --git a/pretty.c b/pretty.c
> index f53e77ed86..c44ff87481 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -893,6 +893,10 @@ struct padding_args {
>  	int padding;
>  };
>  
> +struct rewrap_args {
> +	size_t width, indent1, indent2;
> +};
> +
>  struct format_commit_context {
>  	struct repository *repository;
>  	const struct commit *commit;
> @@ -902,7 +906,7 @@ struct format_commit_context {
>  	struct signature_check signature_check;
>  	const char *message;
>  	char *commit_encoding;
> -	size_t width, indent1, indent2;
> +	struct rewrap_args rewrap;
>  	int auto_color;
>  	struct padding_args pad;
>  
> @@ -1034,18 +1038,21 @@ static void strbuf_wrap(struct strbuf *sb, size_t pos,
>  
>  static void rewrap_message_tail(struct strbuf *sb,
>  				struct format_commit_context *c,
> -				size_t new_width, size_t new_indent1,
> -				size_t new_indent2)
> +				const struct rewrap_args *new_rewrap)
>  {
> -	if (c->width == new_width && c->indent1 == new_indent1 &&
> -	    c->indent2 == new_indent2)
> +	const struct rewrap_args *old_rewrap = &c->rewrap;
> +
> +	if (old_rewrap->width == new_rewrap->width &&
> +	    old_rewrap->indent1 == new_rewrap->indent1 &&
> +	    old_rewrap->indent2 == new_rewrap->indent2)
>  		return;
> +
>  	if (c->wrap_start < sb->len)
> -		strbuf_wrap(sb, c->wrap_start, c->width, c->indent1, c->indent2);
> +		strbuf_wrap(sb, c->wrap_start, old_rewrap->width,
> +			    old_rewrap->indent1, old_rewrap->indent2);
> +
>  	c->wrap_start = sb->len;
> -	c->width = new_width;
> -	c->indent1 = new_indent1;
> -	c->indent2 = new_indent2;
> +	c->rewrap = *new_rewrap;
>  }
>  
>  static int format_reflog_person(struct strbuf *sb,
> @@ -1443,6 +1450,57 @@ static void free_decoration_options(const struct decoration_options *opts)
>  	free(opts->tag);
>  }
>  
> +static size_t parse_rewrap(const char *placeholder, struct rewrap_args *rewrap)
> +{
> +	unsigned long width = 0, indent1 = 0, indent2 = 0;
> +	char *next;
> +	const char *start;
> +	const char *end;
> +
> +	memset(rewrap, 0, sizeof(*rewrap));

The `memset()` feels rather unnecessary as we only use the result at our
single caller in case we return successfully. And if we do, we know to
initialize all struct fields.

> +	if (placeholder[1] != '(')
> +		return 0;

This matches the `else` branch. It's nice that it's converted into an
early return.

> +	start = placeholder + 2;
> +	end = strchr(start, ')');
> +
> +	if (!end)
> +		return 0;
> +	if (end > start) {
> +		width = strtoul(start, &next, 10);
> +		if (*next == ',') {
> +			indent1 = strtoul(next + 1, &next, 10);
> +			if (*next == ',') {
> +				indent2 = strtoul(next + 1,
> +						 &next, 10);
> +			}
> +		}
> +		if (*next != ')')
> +			return 0;
> +	}
> +
> +	/*
> +	 * We need to limit the format here as it allows the
> +	 * user to prepend arbitrarily many bytes to the buffer
> +	 * when rewrapping.
> +	 */
> +	if (width > FORMATTING_LIMIT ||
> +	    indent1 > FORMATTING_LIMIT ||
> +	    indent2 > FORMATTING_LIMIT)
> +		return 0;

And all of the above matches the `if` branch, except that we don't
perform the rewrap itself.

Looks good.

Patrick
