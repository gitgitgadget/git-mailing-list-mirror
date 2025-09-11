Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A40A5238142
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 06:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757572849; cv=none; b=Xntk7XZeTFzRkN8gvSMoc/ekx7y2hHZ+HQUOZ6Sdk8mOcH6bOhsc0AsSa81JKaHtAVdC+J/H20USp8HtpzOW5tEfEbITaIlKpD71xYpz2TiXvm1DqAoTss1xL8MA2Cjay3+FUG+wBgtoTkcwBJ6QbbHZ2z/k5NHPGQvNnEJ0sv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757572849; c=relaxed/simple;
	bh=l7pii/BlcnC1uP6UpWZi5f8yW8nPB6o7IhGk2FqT6gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMfzOHb8jsjSxL4BTbfIgf1/rM6qe0piAe3l1TwJ0MEvGPuJFp+fbEWWr5a2COfQJ/TVl28A12mVvJ2Bo2XO9OaB6yBdLHzCjvK7sP/RSgUmv9NcOWV00FipxomDqBTcGUgRjkM5cacyp9+CRBl+EWl1bBOA0KhoSt9z/O04A8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ocCJBEa/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mHABE001; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ocCJBEa/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mHABE001"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 954D81D001C7;
	Thu, 11 Sep 2025 02:40:46 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 11 Sep 2025 02:40:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757572846; x=1757659246; bh=hTO9Rx0kcQ
	p/SydMSxPOjKsocHuxH34Z1mEIc3mr0tY=; b=ocCJBEa/9mtbg4Xu7PxdBvmHA/
	1W0JI6tohBIsVJkuoNTU3UcO21frNcIRsdzOf8eCK/6r30ziNeJDr0IQMfQ313Dp
	ecU/GOAnYxHRce+kzyK/ApalTNRIvavBXFCAJheJhRJd8G2tWZXMINhRkz7Paiq2
	eaUrw+G2m16rQ47ISUbqhDlZCtHs1XT3kfZ28maUOH8qBtcvwqp2T/hZ1CkNvojw
	xiUUMr6OlNZpG8WEuJnm4xTKixzU2I3AmwKxXIWb0xwo5j0mXRJaQQ8Lpt7SZnUB
	0HqOqkzFD/d83eEGEnYEMTgUAi9qsq0A3ndBxf1RFANcuka8qoysG1Ris3jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757572846; x=1757659246; bh=hTO9Rx0kcQp/SydMSxPOjKsocHuxH34Z1mE
	Ic3mr0tY=; b=mHABE001/kDQ2b6kIawfjUXT1F9ZQ0CxqIyBJuywGpwf606Y/Pm
	TcJUOaUeR5bseP7HtgsoWsQfienaAVI1qMr60F/55CdsLNvbVRSd4m+thOPqvF7V
	bvaUUzf2kCkiWF42p+1zT4vvmqJZPL9vajx7B87Ht16afi0ShrOWuf07jnoTDA29
	goex+cTh89zvl5cRVjeCDjoHMpwbuXSTZmU+2jsH5R5P/Rm9FqUlJ2gUPRK91rpT
	cNNOngcWww7F3IUjztm0sE+WVdTgwpJG7yMKCebb5sWy9VzoDYLT/2DDfyxEQsVS
	sShhWPs2j3gmrBloL0uek7LwuGzsacE+gWg==
X-ME-Sender: <xms:7m7CaDw8pZZ9gtbu8Xfev3Bb-sdUfYi9uBUnVrvafXqgwOxmz8mNIQ>
    <xme:7m7CaLeDEVzljSIJwktV1Ih3JG8S0oHqsDjMmH0zDH4vVCFuMiyHjRW8VOxOTkxVP
    _zni8MLIDECgj25vw>
X-ME-Received: <xmr:7m7CaPLHWTafpm1IvXWFyI5BTaJIafh_8R4GG4XicdI5yLnxHjD7ErE-lzoZSAra5gE5jn87bcB5kttB29GbIieFGR08Xq4KkGS0wAsu4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvheegjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7m7CaMELvOaHFxqpSUG959VEL7vHZuZCkOMnMtzMad7dIYpV5WTpjA>
    <xmx:7m7CaJpSJAKcP3ypjhXQuSJqd898-IoVV5yX6IWozzxDoTX5y0BHLw>
    <xmx:7m7CaFQ6OhkO25ebeZysbek9rM0MNOKYWJ1s2_ka-1qQG3_6aY39og>
    <xmx:7m7CaGNFdF2v-bbFtoaAB_Zv4JuHeDKZjZxHMpgwdpjy1_Np94WvvQ>
    <xmx:7m7CaNAsrpjr_6T6gM_Qr059HrFue03rdl6MCpHwBssBa2R-DfvQbiFN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Sep 2025 02:40:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0f70407d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 11 Sep 2025 06:40:44 +0000 (UTC)
Date: Thu, 11 Sep 2025 08:40:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/6] bulk-checkin: remove ODB transaction nesting
Message-ID: <aMJu4yoO5-Xp52oJ@pks.im>
References: <20250909191134.555689-1-jltobler@gmail.com>
 <20250909191134.555689-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909191134.555689-2-jltobler@gmail.com>

On Tue, Sep 09, 2025 at 02:11:29PM -0500, Justin Tobler wrote:
> ODB transactions support being nested. Only the outermost
> {begin,end}_odb_transaction() start and finish a transaction. This is
> done so that certain object write codepaths that occur internally can be
> optimized via ODB transactions without having to worry if a transaction
> has already been started or not. This can make the interface a bit
> awkward to use, as calling {begin,end}_odb_transaction() does not
> guarantee that a transaction is actually started or ended.
> 
> Instead, be more explicit and require callers who use ODB transactions
> internally to ensure there is not already a pending transaction before
> beginning or ending a transaction.

I think one bit missing in the commit message is to explain what this
buys us. Does it for example enable subsequent changes? Or is this
really only done to have clean ownership semantics for the transaction?

> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 124c4930676..0da5783090d 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -368,12 +367,11 @@ void fsync_loose_object_bulk_checkin(struct odb_transaction *transaction,
>  
>  struct odb_transaction *begin_odb_transaction(struct object_database *odb)
>  {
> -	if (!odb->transaction) {
> -		CALLOC_ARRAY(odb->transaction, 1);
> -		odb->transaction->odb = odb;
> -	}
> +	if (odb->transaction)
> +		BUG("ODB transaction already started");

Okay, good to see we have a `BUG()` here now.

> @@ -389,14 +387,6 @@ void flush_odb_transaction(struct odb_transaction *transaction)
>  
>  void end_odb_transaction(struct odb_transaction *transaction)
>  {
> -	if (!transaction || transaction->nesting == 0)
> -		BUG("Unbalanced ODB transaction nesting");
> -
> -	transaction->nesting -= 1;
> -
> -	if (transaction->nesting)
> -		return;
> -
>  	flush_odb_transaction(transaction);
>  	transaction->odb->transaction = NULL;
>  	free(transaction);

But I wonder whether we also want to make this function here a bit more
robust:

  - I think we should handle `NULL` pointers here and convert them into
    a no-op. This allows us to skip the `if (transaction)` checks in
    many places.

  - We probably should have an assert that if a pointer is given, then
    `transaction->odb->transaction == transaction`.

The conversions all look correct to me.

Patrick
