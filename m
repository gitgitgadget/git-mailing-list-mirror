Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A6E22258E
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742462297; cv=none; b=ZTzr6ye3JvljsAuxeYXlBA57LYMg69Qb4VaDSNzIMjIAOdYun8WNsU48JsdOOvHrSXA2xrZrGZwLvzR+f4M4Zsy+AgWPVg9JHFTkfCiQ2uOA8RuuQwBCVgVyRShNojyAnWXIzk0Isf0Xt2wFV9hw0/WSg0zEBDnsh+SHibcFttM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742462297; c=relaxed/simple;
	bh=CtV/PTwyfeaHR1J8l+ehHvzqEtx7aoqWbuVK8U9QoOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZuP6ykQWBEjA+40wg4DdWQdhGc4ZeS3/dTzENPDhGt/fiFgsm9inCIHmfrYPo/EHqSvHMalFrzt6Vn/ZjFi/BeNO3tSuvnDP4nPhNMB6JLPBQHmF4ZXTUUIyz5oLb3tUAVlWmtXLG5zFX5EC86GX+P41ixo2M/T1XjZKdnFGP+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VOBjROfi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LEqw4PKm; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VOBjROfi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LEqw4PKm"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EEF702540192;
	Thu, 20 Mar 2025 05:18:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 20 Mar 2025 05:18:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742462294;
	 x=1742548694; bh=iaLg2CBOtEnM62I0BSXorjwgeyjQc1vvWkhP6SKjvm4=; b=
	VOBjROfihriSSm8Go2XcKp4oEIMG+haFGhySloQFac30nbAxTygbqDkVIm7EKSuP
	ncSxmJ0kGgDZSoUp7BWIOswlTX+67ygUJ+ecdoZbRCaWkWS/aDLE2YcqikVNV1oX
	WDMcDjSzEOILGC2NXHHr+rPnCeV8MDgwIBk5GKo+slZD9JUV8B9engoanxJviJjL
	4vmEj887zT2Y+XzumB3sOjYOer71tcUkYLefVKIgKI8o1LhucD2lGAuUslsZgLOO
	Z6AiaZbpHwLUMvdzW6TfOZ7YydMEQHbNxbi+3xO9F4qgBuekhatV1h7Z/TPIh9Ie
	8HlAWcvXsas85KKOhXLIkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742462294; x=
	1742548694; bh=iaLg2CBOtEnM62I0BSXorjwgeyjQc1vvWkhP6SKjvm4=; b=L
	Eqw4PKmnphbwCZ6522qlJfwrvmEAYl1VR7efokZX/cMQzFHzjLczbNQVoXaUSl82
	ahsn+0rrAvtIClxQsznJ9m1iMpcFPaBGP5aEFMEyuTfOIwwgkFxSxrFSfowbdZNz
	sXwKbnm/VNfvOiatNTB8WttYBpJsiOIdxgzCqqR2JbnBtDdZfRylBD5KqO1Fyznd
	qB+lv67WPRV10Sa2KiMoLJt8cdOvd70iwn5sfCUF7OYhqQUig2rA0bbbalTcydL5
	baMXQR4Re6QCyMnbR/xEEPOSdPRzBEIjeHITlRRghz9rgjs7F95Q4qx41ieQf5At
	EJ+I4Slud/NQ5lUO5TCKA==
X-ME-Sender: <xms:Vt3bZ8RgyT3_Sr7qeVkJmma3goG3mcQIqKGk_7bO8He_8E_RtVlKIQ>
    <xme:Vt3bZ5xnVLB6wlaECxy2x88M5DZcC5gMuucIwC8esOMyfWMmlCNj-BPRgYt5rOHQ_
    B8aBD_oAUjRAxnZRw>
X-ME-Received: <xmr:Vt3bZ52dNqxThaRZ29D8afWZEzLk5FvuMluA1VDMuAQR82MDvLTnbertv-wqpNylbFtki6tHXUtsA8Nxy1PXszdzkAlTFYvdclJbSFUkpDesbQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddt
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedv
    veetffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehm
    rghrthhinhdrrghgrhgvnhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Vt3bZwCWexzEP9ffbyZ1TReb1OIAUq9Wl3MMalQeq6Cb7licJq38lA>
    <xmx:Vt3bZ1iipq2G-xrkl9kEvK934co1kGo-PSiB6l9-RpwDWMcwlaqC3A>
    <xmx:Vt3bZ8rL1B-1O-HVqoox9O-sNFFVN4uvwxqRVqkyTUJK62BEKfPAzw>
    <xmx:Vt3bZ4jShzlRVcTkeSpq92cbQJcJRkMKPJmFo4IiX9BqS3NpSympqw>
    <xmx:Vt3bZ6sg2xSmrcRdgRArdinP_B2bB0CPy1j2abS5PLNbBDt0dJqwNdY3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:18:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aa832f46 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:18:13 +0000 (UTC)
Date: Thu, 20 Mar 2025 10:18:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] pretty: refactor parsing of magic
Message-ID: <Z9vdVP4edeaRawsz@pks.im>
References: <cover.1742367347.git.martin.agren@gmail.com>
 <7c96899bb520ab945a650205982f54d65461d5bd.1742367347.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c96899bb520ab945a650205982f54d65461d5bd.1742367347.git.martin.agren@gmail.com>

On Wed, Mar 19, 2025 at 08:23:40AM +0100, Martin Ågren wrote:
> Similar to the previous commit, pull out our parsing of initial
> placeholder magic into a separate function. This helps make it a bit
> easier to get an overview of `format_commit_item()`. It also represents
> another small step towards separating the parsing of placeholders from
> subsequent usage of the parsed information.
> 
> This diff might be a bit easier to read with `-w`.
> 
> Signed-off-by: Martin Ågren <martin.agren@gmail.com>
> ---
>  pretty.c | 69 ++++++++++++++++++++++++++++++++++----------------------
>  1 file changed, 42 insertions(+), 27 deletions(-)
> 
> diff --git a/pretty.c b/pretty.c
> index c44ff87481..ddc7fd6aab 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1929,17 +1929,17 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
>  	return total_consumed;
>  }
>  
> -static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
> -				 const char *placeholder,
> -				 struct format_commit_context *context)
> +enum magic {
> +	NO_MAGIC,
> +	ADD_LF_BEFORE_NON_EMPTY,
> +	DEL_LF_BEFORE_EMPTY,
> +	ADD_SP_BEFORE_NON_EMPTY
> +};
> +

It would be nice to give all of these enums a common prefix, e.g.:

    enum magic {
            MAGIC_NONE,
            MAGIC_ADD_LF_BEFORE_NON_EMPTY,
            MAGIC_DEL_LF_BEFORE_EMPTY,
            MAGIC_ADD_SP_BEFORE_NON_EMPTY
    };

Makes it easier to see that things belong together and it provides
proper namespacing.

> +/* 2 for 'bad magic', otherwise whether we consumed 0 or 1 chars. */
> +static size_t parse_magic(const char *placeholder, enum magic *ret)
>  {
> -	size_t consumed, orig_len;
> -	enum {
> -		NO_MAGIC,
> -		ADD_LF_BEFORE_NON_EMPTY,
> -		DEL_LF_BEFORE_EMPTY,
> -		ADD_SP_BEFORE_NON_EMPTY
> -	} magic = NO_MAGIC;
> +	enum magic magic;
>  
>  	switch (placeholder[0]) {
>  	case '-':

On the other hand you simply retain existing names. I don't insist on
the refactoring, but still thing it would be nice as the enum has wider
scope now.

> @@ -1952,28 +1952,43 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
>  		magic = ADD_SP_BEFORE_NON_EMPTY;
>  		break;
>  	default:
> -		break;
> +		*ret = NO_MAGIC;
> +		return 0;
>  	}
> -	if (magic != NO_MAGIC) {
> -		placeholder++;
>  
> -		switch (placeholder[0]) {
> -		case 'w':
> -			/*
> -			 * `%+w()` cannot ever expand to a non-empty string,
> -			 * and it potentially changes the layout of preceding
> -			 * contents. We're thus not able to handle the magic in
> -			 * this combination and refuse the pattern.
> -			 */
> -			return 0;
> -		};
> -	}
> +	switch (placeholder[1]) {
> +	case 'w':
> +		/*
> +		 * `%+w()` cannot ever expand to a non-empty string,
> +		 * and it potentially changes the layout of preceding
> +		 * contents. We're thus not able to handle the magic in
> +		 * this combination and refuse the pattern.
> +		 */
> +		*ret = NO_MAGIC;
> +		return 2;
> +	};
> +
> +	*ret = magic;
> +	return 1;
> +}
> +
> +static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
> +				 const char *placeholder,
> +				 struct format_commit_context *context)
> +{
> +	size_t consumed, orig_len;
> +	enum magic magic;
> +
> +	consumed = parse_magic(placeholder, &magic);
> +	if (consumed > 1)
> +		return 0;
> +	placeholder += consumed;
>  
>  	orig_len = sb->len;
>  	if (context->pad.flush_type == no_flush)
> -		consumed = format_commit_one(sb, placeholder, context);
> +		consumed += format_commit_one(sb, placeholder, context);
>  	else
> -		consumed = format_and_pad_commit(sb, placeholder, context);
> +		consumed += format_and_pad_commit(sb, placeholder, context);
>  	if (magic == NO_MAGIC)
>  		return consumed;
>  
> @@ -1986,7 +2001,7 @@ static size_t format_commit_item(struct strbuf *sb, /* in UTF-8 */
>  		else if (magic == ADD_SP_BEFORE_NON_EMPTY)
>  			strbuf_insertstr(sb, orig_len, " ");
>  	}
> -	return consumed + 1;
> +	return consumed;

It took me a bit to figure out why this is equivalent to what we had
before. But:

  - If `parse_magic()` returns bigger than 1 we'd have exited early, so
    this return here is never hit.

  - If it returns `0` we have hit `NO_MAGIC`, and we have another early
    return for this case.

So we only end up here in case `consumed = parse_magic(...)` is 1, and
then we add the result from `format_and_pad_commit()` to that value.
Which means that the refactoring is true to the original spirit.

Patrick
