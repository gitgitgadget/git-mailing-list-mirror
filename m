Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20332571B0
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 16:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754584731; cv=none; b=YSpmsjouAm4EPls8Lv4qHpnC+vwM3B4txv2/W6UUFnfBIp83YkrZ8pYxUuacs0UuUqYGUcESRfizMR6x4PWQwAVof5BMVaQQFnvcFWOLYhImcGYtb2SPc2aH1ssRBp6GXrg1ZEo0WyDrAcG3PcLSPbSdi/G7nZ3fsDrHD4TuSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754584731; c=relaxed/simple;
	bh=LhcOI5a/QXn7i5e9SIt63ZCj7mgT3zT0k+kFQp6HZXc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=audg0mzBKXgi/C1CFoQgU+1JDfSiCny1OlzsPiBQ62zlC88w3SMwg0790XTCLhMyahxmQx4829Re91y2ipOW6YF7SGbDM5Wm1lcMwMIR4n/gHio7IE3ZlOqrO0+drBYa2Ok22JtJ9V1u96b+M9enfuWywq++FYe5Pjt7le3XwSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k6nLkzVg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TXQzR3YZ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k6nLkzVg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TXQzR3YZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E14CF7A020B;
	Thu,  7 Aug 2025 12:38:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 07 Aug 2025 12:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754584728; x=1754671128; bh=0OEAz/SJ/D
	iHhaKl5Z0KTVs2Uz5lcouZ4ezBfbM9/5Y=; b=k6nLkzVgjuYyUQFImrWLg1TRni
	syYwdgEbxHgEsUfLjPUrLc19EFpLnuiMfYgh1pJfLafXCGDj982UyAZBrJMz281U
	Ovc3SOyM//BsY9e8X18t9GEck5WVwFjiAv822V2om5KPVXui0W+yeux1AsKX9HN7
	XgibR4OWfgwryB1k1mzES/1644C9yqlDXvxl199Jjms4kf2DZxgZok3cJIRLBuhB
	1fn4l68DMvB2br5PKMQGbXamAKZQ9AC7qTyWqBG/X08E1bO7IxTOVg9FlQj+sS2s
	/JNVaqd1PrsUiKWq646tE2844fjQOmEDF0svtRM65TyMbHa9i3CXK3mM2mag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754584728; x=1754671128; bh=0OEAz/SJ/DiHhaKl5Z0KTVs2Uz5lcouZ4ez
	BfbM9/5Y=; b=TXQzR3YZCflWUTvku2EKmFbGjbOTHhe4QWXdz6GRINQMxdRDunl
	cImZw7RVIkc6n6bLQ+u5o1EcIJhGkpL3scf2X2v3cOJcSpL+FEO2NERRCBOf6kEQ
	DGlQxc4opISoYsyCNaqkrIXPflBDZmgye2mPTXz4oTyoywADeZ5U1yjn6sTo9+Yt
	QcUKAuZCCslqIRRekA9dAYodIJUq/jLf9hlD/w2m2pu1fOLhAhyzPZ2mYXg3lknX
	0VuZoqJ77/MvljkA4b7pGmzqOd9BemRgPL5N6BwkYRw99DNPVHOlnmUeO5+nUrS1
	Ij5jGkDN37pnBNkkxWcSvZfeZA/z4708lhg==
X-ME-Sender: <xms:mNaUaPb_QtWJ0hnUaXh_GMHJdIgS0W4j6h6DBgFprfU2OdjDGOxPBg>
    <xme:mNaUaG1aCZONwjND1wbggwRaTWaA4Jl5mwWCoDKJAAU9vfMCBhQf-8aPPq-n9UHBg
    UW1yjQLiIjxEvsHuA>
X-ME-Received: <xmr:mNaUaCbeoshKLFbQHtJufwhmJlTEdIjZBpM7e4s-SYyyyRmonjnJFssO-mDTi55JT-PbNtIRsvHc76_0KHQsEnVq4i2Km80EoxKRqGY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddugeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggv
    nhhhrghgvghnsehgmhigrdguvgdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtoh
    hmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:mNaUaGKJbOZSE2fo1MsUDXCib-jbXaBr0O7tnwoYj5LH5Nyo6eeiIQ>
    <xmx:mNaUaJGpLNExUwL6x7z2jj4LoGTSkkGA50jNLmoOmM7uPz9Xs4jMqA>
    <xmx:mNaUaFvvEE65JNg0fvtMjp7-WUk0PbYS9Cva07Rkigxrg1TQtojsYg>
    <xmx:mNaUaAuw8wS7lgNyIzMtJxO8nJuBbRzpgwbMbD2ZsyPS_CNdlFwzDw>
    <xmx:mNaUaG6rQwbt-QNuV8lQgIDCs0cS6hw6KsVsGzTNdcH_Re6Mhiuv3VxB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 12:38:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
  Taylor Blau <me@ttaylorr.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-compat-util: introduce `count_t` typedef
In-Reply-To: <20250807-pks-introduce-count-t-v1-1-e96be52d8db1@pks.im>
	(Patrick Steinhardt's message of "Thu, 07 Aug 2025 11:22:56 +0200")
References: <20250807-pks-introduce-count-t-v1-1-e96be52d8db1@pks.im>
Date: Thu, 07 Aug 2025 09:38:46 -0700
Message-ID: <xmqqa54bqe7d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>  For C programs:
>  
> + - We use `size_t` to count the number of bytes and `count_t` to count the
> +   number of entities of a given type.

I am not interested in this specific implementation at all for a
number of reasons, but I am excited to see people thinking about the
issues.  The following is a random list of things, both positive and
negative, that came to my mind after skimming the changes.

 * We do not want to pretend that one size fits all.  If it were a
   good idea for developers to express "This variable is a simple
   counter that counts up from 0 and never goes negative" by using
   an unsigned type (which is dubious), it should be equally, or not
   more, a good idea to allow them to say "We will not have more
   than 256 fan-out directories under .git/objects/ and this is a
   counter to count them, so I know 'unsigned short' is big enough
   on any platforms".

 * As far as I can tell, the patch does not seem to address the
   biggest concern of unsigned integer wraparound.  We often see

	ALLOC_GROW(thing.entry, thing.nr + 1, thing.alloc);
    
   with the arithmetic "thing.nr + 1" checked by nobody.
   ALLOC_GROW_BY() is slightly better in this regard, but nobody
   uses it with only small exceptions.  And of course, alloc_nr()
   does even riskier arithmetic that is unchecked.

 * Standardising the names used for <item[], item_nr, item_alloc>
   somehow is very much welcome (we can see an example in the change
   to builtin/rm.c below).  Such a naming convention would allow us
   to write

	#define ALLOC_INCR(thing) ALLOC_INCR_BY(thing, 1)
	ALLOC_INCR_BY(thing, increment)

   that do ALLOC_GROW(thing, thing_nr + increment, thing_alloc) more
   safely than what the current code does, perhaps?  Also, we should
   be able to use any unsigned integral type and perform sensible
   bound checking with typeof().

 * The codebase avoids inventing a new type with typedef, with the
   exception of callback function type, following old tradition we
   inherited from the Linux kernel project.  And even when we create
   a new type, of course, we do not want to give it a name that ends
   with "_t".

> diff --git a/builtin/rm.c b/builtin/rm.c
> index 05d89e98c3..99b845cf34 100644
> --- a/builtin/rm.c
> +++ b/builtin/rm.c
> @@ -33,11 +33,11 @@ static const char * const builtin_rm_usage[] = {
>  };
>  
>  static struct {
> -	int nr, alloc;
>  	struct {
>  		const char *name;
>  		char is_submodule;
>  	} *entry;
> +	count_t entry_nr, entry_alloc;
>  } list;
