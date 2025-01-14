Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CB022DC20
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846014; cv=none; b=mp+uodO9/W3Rl32PZ10zZdJEUpSpDhtez7/eJLep+vi3JP9y9rydl5vD/0tgJKRcWhssQ6vJ2UJE0VZhvhGaA52oZZcma689+4KmiZLdhT/yQe/1F8XUKoI0oOFb0weYCgTFxzfeALp2OTYZNUsjxFuPhbsPel9azjiRKqSMsBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846014; c=relaxed/simple;
	bh=w+3TjZuOrEPsvoiQMA3FZzO5Oc4mrl9Jyuwo5lhjHhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dmz+da+YRy9tzQHWidL73snPzfv6vZ731YCdsWtqaQ2cclf59idVWKoXMFiAZnnZWknLnbjaGf0XVjWZPd+P/t500jtxIfW4fjICtiAIqiQoAuCxz2otOq9DQm3Nc7Hfg7YHYQIpW8v76r7KPaL9HqoZvMvW6l7Z5QZoia8V6As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aISofL2/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kIPHwCqp; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aISofL2/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kIPHwCqp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id D5EBF13800AB;
	Tue, 14 Jan 2025 04:13:30 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 04:13:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736846010; x=1736932410; bh=OZmm0nQ6LD
	wejpC79sn+YRmQRnhltxGQb9jAN51qf6Y=; b=aISofL2/suR9cHoNPXOer5Ujlv
	8HuUB04qZUiatot4A+3nfEPrKoX7y1kFZOUDPrYiBwPYIOVZ0FaH/OdXFL604qks
	WMUggztncnn0LTYlC3udgW5HJmzFPIyCemXB8YY+91gpFRL9FofeVqx0OiWeHFJL
	mZ9jjCwLVY8CYOMph6iYd2cNskdbBeYS/LEG70f8I+dU3CS2Ni0/IcHAkSWM6bcO
	Qg8olrU5MUWcK8zIr8gxbXOxQAoMR9hpWjVKyzMjgHTnUzs7Z3pHqXQTxlxNZVD+
	bSN+Tsa9Ytc9Aq3lmvGBNkCT0WLBX1co7zuucRgo6aBVt3J35Lfz1aUIjBQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736846010; x=1736932410; bh=OZmm0nQ6LDwejpC79sn+YRmQRnhltxGQb9j
	AN51qf6Y=; b=kIPHwCqpF2UAeX54Go4Rgqj5lQ2zimPi9jIGu2+5sD4qJw9hsTq
	KYzLUBhZQdfpu2gf9BaqVg7y+UfmsxLwumIOFnBwadkBro/BWD+J7RIGBMl7x+U2
	9xcVzFhKBmDEW/dXWqXWw1jQSsFR79LPuN8+rSisoYcomnuD5XsSkqeaU2/y+ktm
	1LgNwhI2KVVcp2qNBwSibg7KzJouXg3rpZdreGTEqT2rH0Xg2lWdqEneNcEcrYRO
	cKx1BJMmjpR/HRIUW033jjc+8UETZkVbU6B458t6DAFWz101w/7Fcb2jOGw0QLdn
	YNiIWS84sZeqni/uaWS5gAEDp3XOWe/hozQ==
X-ME-Sender: <xms:uiqGZy7Ox18qc23ShY96ftebFfR_AuowEcVqbKKtYquAUxgdmRhFMg>
    <xme:uiqGZ745rom895DkFmSzNZc4yribVhHw21gl01O0m-UguqZZJdpW2ov_CvoJJ8_7F
    q0M38HV6imgtC5PJw>
X-ME-Received: <xmr:uiqGZxeilx067d0KQfxRWOFNXss0LYUW5sZtrE3vnmlm1wRbongvjFEe-umXnZEULQzXIIty-8ctE9AsxN-ZtUcXhewXfQ40_MS-uxlE9cfXbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiise
    hgvghnthhoohdrohhrgh
X-ME-Proxy: <xmx:uiqGZ_IZSHlYL4MY_sAtp7BeKb3laF8nTdeYyf7MEgnE1fHL1CbdKA>
    <xmx:uiqGZ2I8Xm5dEgyskpmrGGNjZC2Xy0VCuo9JmO2BzUhp7e-JnakONg>
    <xmx:uiqGZwxens-JDIjr0p-mDMb-O52gs5iJK7gBRlkA1RSnTAkG-J_t8Q>
    <xmx:uiqGZ6Jkmjxb13MJCGzl7aG9i3pqTOechFjKbxssBKhdSpL3EB5QIQ>
    <xmx:uiqGZ7ElwzIMiX2NIHS-Eljq9rrNjyCqGLup9e2v-IZZ0xuBp7yr3m2Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 04:13:29 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f825c102 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 09:13:27 +0000 (UTC)
Date: Tue, 14 Jan 2025 10:13:26 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Evan Martin <evan.martin@gmail.com>,
	Eli Schwartz <eschwartz@gentoo.org>
Subject: Re: [PATCH 7/9] meson: make the CSPRNG backend configurable
Message-ID: <Z4YqtlfxIh4p6qPx@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
 <20250113-b4-pks-meson-additions-v1-7-97f6a93f691d@pks.im>
 <xmqqr0568uhy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr0568uhy.fsf@gitster.g>

On Mon, Jan 13, 2025 at 09:59:53AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > +if csprng_backend in ['auto', 'arc4random'] and compiler.has_header_symbol('stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random')
> >    libgit_c_args += '-DHAVE_ARC4RANDOM'
> > -elif compiler.has_header_symbol('bsd/stdlib.h', 'arc4random_buf')
> > +  csprng_backend = 'arc4random'
> > +elif csprng_backend in ['auto', 'arc4random_bsd'] and compiler.has_header_symbol('bsd/stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random_bsd')
> >    libgit_c_args += '-DHAVE_ARC4RANDOM_BSD'
> > -elif compiler.has_function('getrandom', prefix: '#include <sys/random.h>')
> > +  csprng_backend = 'arc4random_bsd'
> > +elif csprng_backend in ['auto', 'getrandom'] and compiler.has_function('getrandom', prefix: '#include <sys/random.h>', required: csprng_backend == 'getrandom')
> >    libgit_c_args += '-DHAVE_GETRANDOM'
> > -elif compiler.has_function('getentropy', prefix: '#include <unistd.h>')
> > +  csprng_backend = 'getrandom'
> > +elif csprng_backend in ['auto', 'getentropy'] and compiler.has_function('getentropy', prefix: '#include <unistd.h>', required: csprng_backend == 'getentropy')
> >    libgit_c_args += '-DHAVE_GETENTROPY'
> > -elif compiler.has_function('RtlGenRandom', prefix: '#include <windows.h>\n#include <ntsecapi.h>')
> > +  csprng_backend = 'getentropy'
> > +elif csprng_backend in ['auto', 'rtlgenrandom'] and compiler.has_function('RtlGenRandom', prefix: '#include <windows.h>\n#include <ntsecapi.h>', required: csprng_backend == 'rtlgenrandom')
> >    libgit_c_args += '-DHAVE_RTLGENRANDOM'
> > -elif openssl.found()
> > +  csprng_backend = 'rtlgenrandom'
> > +elif csprng_backend in ['auto', 'openssl'] and openssl.found()
> >    libgit_c_args += '-DHAVE_OPENSSL_CSPRNG'
> > +  csprng_backend = 'openssl'
> > +elif csprng_backend in ['auto', 'urandom']
> > +  csprng_backend = 'urandom'
> > +else
> > +  error('Unsupported CSPRNG backend: ' + csprng_backend)
> >  endif
> 
> IIRC, the precedence order of CPP macros related to csprng backends
> were chosen to reflect our preference for more secure and faster
> ones over the ones that are less so.  Does the above list recreate
> the same order, and do we want to somehow make sure future
> developers would not break that order without knowing our intention,
> saying "when all things are equal, we should sort in alphabetical
> order" or something?

Yup, it's the exact same order as we have in our Makefile and as in
"wrapper.c". And yes, good idea, I'll add a comment.

Patrick
