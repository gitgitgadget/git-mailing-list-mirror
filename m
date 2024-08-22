Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41BE1779BC
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315059; cv=none; b=eqCQPOOvsUoSRfygkd3CEPvb9qjArYIKzr4wA6/eRhLw02Y2CLkpZ9SXWNiTzbiAriwzAObJ8k0E2rlvR3ro8CT3Ukl3aAv31CfFgfaDiDMExEI55t0TpyZziVI+nv1hsNPZ9SCLtbllLEDj9nWzzRqpND5ti2nmUt2Ojc6Qcf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315059; c=relaxed/simple;
	bh=bcnuhyq5xSXONYH1U/tM2tJnkukodaH6PGeb4GJYsTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCguV3rIN01ri6N1vrj0M/3+35Lq5kz9Sls3rKqpTArdblymMnk+p7zmhkd5CswPrVMXfr6OwsID99pGOWFF4NkWHzQjnntzxwsX5G6H4yYilAn6TNKefVFC3mhYcCbo7idLSetrQnJ/yQ/ncRzVTgV3FBuRAEbVw5K+j3aas5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F1NgnYwy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bHT1jhn2; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F1NgnYwy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bHT1jhn2"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id F3DCC1387EB5;
	Thu, 22 Aug 2024 04:24:16 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 22 Aug 2024 04:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724315056; x=1724401456; bh=fws+p6oeCG
	vYxJjZ33cD5zBACNdLEmzIaJd9oxJC0bg=; b=F1NgnYwyjUIgU09J3jg8ad189o
	0QPVZ5iyJR7SLHmSypUhir7wiriMga3RU2g5pfuyfVmOLYIEEh3iW8qX2umE9tb/
	Iulwa4JJROwFEl0TU3VSynpKgEJmBlKEJrKdPYfnoRQx0jQ3nosA7fa74YSqnz+b
	b8EKI/EizUpx+4MADVyaMIiKg0EWnXF75M/9AeliINhaJ6qkywtaN0S6Pd0cKYIv
	xPKXJHgw6uoUjzeO6yuunF967iEFI/tObL8BlYoMpB7nZJ53VrU5zhO2ffJLCRw/
	t1KJDXacBenD4Qtm5cQtGKBBD+WGb2PoJRrm0GJpCxQ4nZ8AzAa//58LxC8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724315056; x=1724401456; bh=fws+p6oeCGvYxJjZ33cD5zBACNdL
	EmzIaJd9oxJC0bg=; b=bHT1jhn2UJVNQVPeQP/4i4fqU86qSHM7YH1hqiLNah8D
	CJQTUQPrFouoV7emnyQT043o9hTJbYbFfqLJlJ9PhoSHLpdjQfd81ayl9FofnGfD
	xTl+NfCjwvhw7y6a9SrSJDTR2LWXfYvnf5+BRrFrxKXaCSIQ+JjtiPiAmb0SUb2f
	v/wBekvoaaBYBgvgqK1WLuCVVWEt/yu16ilvvuZlHaXFkaexITc1dXlFvUrHNaO8
	P8r75nJrCMnuixYLBYvsAKBxgR1eHlsZIL68AdOXVAVENWGfvfms/WIXtKfpNdCh
	9f2Eo465x1IwFlaqqHWLwti/Ag/mckVg9vryxhU4Mw==
X-ME-Sender: <xms:sPXGZhOjaUcYOJSQ1PN4lOGQ_cs1VL3UqzTNQqVr470qD9Mbk0VhLw>
    <xme:sPXGZj-d92c21bJUkpVS-5M-vwVOvHKJFE1mdsfWUnBj6SLJJm2fAFhBC1srF3I7o
    exmvLQEBij3_6uBlw>
X-ME-Received: <xmr:sPXGZgTmKEuYUFrCW-7fy5J1LMD0Jg41iEB7GjDCm7v0Kw4u9QxAg9LgFDqcKWTHkq6o-kvUWTuyBkz36Luc4jLIGYBvHyjWyfFLwMTOuIUaZJ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvieehkefhke
    dvleejvdduueejveduuefgieegveefleehieekjeegleekveduleenucffohhmrghinhep
    mhgrihhlihhnfhhordgtfienucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:sPXGZtvzpIfr6Focy4-9necbvtQ5BI3NvWZhaqIRnzbGlihFdOvNtA>
    <xmx:sPXGZpdaeuhzSE_QmlKyKU8-lpaMZNfoPwkRMrb2aztC0tgUlpfmEw>
    <xmx:sPXGZp3Ylt9nysUd32pbvxiG8iR0ZcFa9A32NDPOcGMlo3Y7T7Z2zw>
    <xmx:sPXGZl_aMAOtcOl7bvS3uooOrr9qwzcFl1itr7CQy6nCO_AyTJ7aRQ>
    <xmx:sPXGZqqDp5PQTXAh6rD8jfPum34AfObBE0rvXGOhgfhreXu2jiDH6GBa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 04:24:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e61cda47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 08:23:41 +0000 (UTC)
Date: Thu, 22 Aug 2024 10:24:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: we parse fixed headers
Message-ID: <Zsb1rGQbglHMiBHI@tanuki>
References: <xmqq1q2i6gw7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1q2i6gw7.fsf@gitster.g>

On Tue, Aug 20, 2024 at 02:09:12PM -0700, Junio C Hamano wrote:
> diff --git c/mailinfo.c w/mailinfo.c
> index 94b9b0abf2..17d7c3b594 100644
> --- c/mailinfo.c
> +++ w/mailinfo.c
> @@ -346,10 +346,10 @@ static void cleanup_subject(struct mailinfo *mi, struct strbuf *subject)
>  	strbuf_trim(subject);
>  }
>  
> -#define MAX_HDR_PARSED 10
> -static const char *header[MAX_HDR_PARSED] = {
> -	"From","Subject","Date",
> +static const char * const header[] = {
> +	"From", "Subject", "Date",
>  };
> +#define MAX_HDR_PARSED (ARRAY_SIZE(header) + 1)
>  
>  static inline int skip_header(const struct strbuf *line, const char *hdr,
>  			      const char **outval)

I was briefly wondering whether changing MAX_HDR_PARSED is going to
cause negative fallout. But the only place where it is used is to
allocate both the `mi->p_hdr_data` and `mi->s_hdr_data` arrays. And
these are only populated via non-NULL `header`s.

> @@ -583,7 +583,7 @@ static int check_header(struct mailinfo *mi,
>  	struct strbuf sb = STRBUF_INIT;
>  
>  	/* search for the interesting parts */
> -	for (i = 0; header[i]; i++) {
> +	for (i = 0; i < ARRAY_SIZE(header); i++) {
>  		if ((!hdr_data[i] || overwrite) &&
>  		    parse_header(line, header[i], mi, &sb)) {
>  			handle_header(&hdr_data[i], &sb);

This is also a welcome change, as it makes it way easier to spot intent
and to notice that `header` is indeed a static array of string
constants.

So this change looks sensible to me, thanks!

Patrick
