Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5771C2E
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 04:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727843456; cv=none; b=N088gILQKYqqZeJ6tiWIsPzshTqHsddZdB060izWSruFlvI4xAmNHyHCkafuW2YWMr4/hQKismiz5yOfKlbgRIJbmCmavrTQQIxDSfJT0l2xS+wVpILGWFLe9J95bji3auIpmCsgmOIzPKvh7NOYpvtWPys/6Yi4ygNxb8LIUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727843456; c=relaxed/simple;
	bh=inA6ccOo1aWjwg0+jkLkw8+I5UaHUpDAEO0GOtxQARA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vvo+sy5V/t1K/jxwbBC6MUJaIOpxE5Wud6xR7yTRwSxRV8gqgn0DCkYajqzBy5M7bbS8C97oyt6+JKrC5qZTQeE/cY0ZLKHavrGBFdtQ5HlMjjIiN9h2GHtWjuEH+BS+e9F8IZOPJCS7wfHXOSgQ4toVzyE52eu5IqEHbCQEzng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=plgTfj6R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H2ZA8dST; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="plgTfj6R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H2ZA8dST"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 26DC211401E2;
	Wed,  2 Oct 2024 00:30:53 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 02 Oct 2024 00:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727843453; x=1727929853; bh=M9kc+HSqpu
	yYtKrAk4T9y4SeAWssUFD3xA7KHU76WEw=; b=plgTfj6RzEJTBgh14Nwy4tt+N7
	hgrQwxXqi88D6o08La09SDQZyrVQ0Ec5VG+SixTunH6t0B/beBfG0QwUuko9gdvQ
	zrP79ipq+o5zgZrfdhHfgoyzeU97TO5jgUx7qG0nO1coxMJfonNjR/kaQQjJh5Vd
	Hhm46Wf1m3dLooGlPAyrW7M8pQEbz1vJxvrRG7doFbeA2qbUhEQU/p3/aI+9k3jB
	xwhKQhO3rqZkCd+2ENVAwNcGkG3xuHPYa9GaSgWvN2nKQvcJp4wRs5ION2sVyMtM
	hlWMtC/3TJHzYjA6zZ9abjAJRfHr9Vchn8wKlb78YgEN4sXTnnipMrrmUTTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727843453; x=1727929853; bh=M9kc+HSqpuyYtKrAk4T9y4SeAWss
	UFD3xA7KHU76WEw=; b=H2ZA8dSTa2IGOZ86CQkcyImi/96z1Qw7Bfw6KK6Y00D+
	AAXk+rSOKaJ06MXrtBfmqe2Ls72U5raaE/oWw5KIxzQb+2T8bAZ0KPX1D4ilLZGL
	lzyDgPTPDlGyaSWB5sD5LalM1DuGQNy1Qrn8Tr4MnDF9CZliZoYiV5VfUi/8SvXj
	0IGRPEdOrA3xTKt0ymlBdHNg2t9VoYx+TOQUAgS4linwaJAPD98Jp8xuQ6Y4dI8o
	5sLnHg1tJl+A4p0ZBHojFwMMS6nA/mrscAlN8PO2AEyHHPQbvTs9b+JV+v1syjDx
	MeRnD1TaKZiPZreLNWsFunHu2fPATokW1bOsdgIHpg==
X-ME-Sender: <xms:fMz8ZtWfIPs8VCo6Ddwrcl9sQa5_41PNjeEzp0AIME9nFQhp6J-hmA>
    <xme:fMz8ZtmHz5JuJ8gZlm9eAm3OcGGnHJhxaJ7yrz-JpS5gzESdgTdFXo29ewwBg4Nya
    Lxh-fXX1HXMctyYiA>
X-ME-Received: <xmr:fMz8ZpYl1lf0MNJfa_H0Rth-ZidfEtYCrRlB2Cs3rTN7sPmLo0L0p73ZcSOKy3WCkzzNGsl7MPAmIaLQ3KzZzK10b56uqqYjtpW122pmZRFK8V8p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddukedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhm
X-ME-Proxy: <xmx:fcz8ZgUxHsuJA5hxQztIfArPIiYuTdASZydvmcx7aqAU_Jj-U0IX0g>
    <xmx:fcz8ZnkhxV7CQ_KMs6WEWrxWRcjBcaBYNp0BJ9MhAdjZGCJa70uy4A>
    <xmx:fcz8ZteSdMBOlGK2pNm__QQXjXNBLaVCeaRG5ZW1WPJoU-Dr4jkzNA>
    <xmx:fcz8ZhFBYfDb5PhpSTx87KmqfWSkCk1ZbflB1fYxJ4nsBZ9NciNRkQ>
    <xmx:fcz8ZgCBWa9dvfhhItq_rBXZdIhQSU1hPrmN3YBzVt4vMZvQ_YaxzGn8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 00:30:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4f0970b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 04:30:02 +0000 (UTC)
Date: Wed, 2 Oct 2024 06:30:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Edward Thomson <ethomson@edwardthomson.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v4 25/25] reftable/basics: ban standard allocator
 functions
Message-ID: <ZvzMbxdfRZU9pQ76@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
 <764961e6f02b8e5788bce75830559b70c2e6f231.1727774935.git.ps@pks.im>
 <xmqqh69vsail.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh69vsail.fsf@gitster.g>

On Tue, Oct 01, 2024 at 03:50:42PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +#ifndef REFTABLE_ALLOW_BANNED_ALLOCATORS
> > +# define REFTABLE_BANNED(func) use_reftable_##func##_instead
> 
> We'd need to mimic banned.h a bit better, by adding
> 
> #undef malloc
> #undef realloc
> #undef free
> #undef calloc
> #undef strdup
> 
> before (potentially re-)defining them.
> 
> > +# define malloc(sz) REFTABLE_BANNED(malloc)
> > +# define realloc(ptr, sz) REFTABLE_BANNED(realloc)
> > +# define free(ptr) REFTABLE_BANNED(free)
> > +# define calloc(nelem, elsize) REFTABLE_BANNED(calloc)
> > +# define strdup(str) REFTABLE_BANNED(strdup)
> > +#endif

Oh, indeed, that's something I missed. Will do for a hopefully last
reroll.

Patrick
