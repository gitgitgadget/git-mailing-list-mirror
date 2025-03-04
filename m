Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0711FC7EE
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 09:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741079281; cv=none; b=lFU0neFej2XUygK99ogJg8xRzNx1XFTPQn2nFwkabNEz48I7o5Nu3M1ZyYs5Z7lrsgWO+e2m3LRBfqiy/bd6eWHWlx3ygi3eVkFaZhKqCMTLetuWcvZdg4hANHGERii5pZWUdD2MRsh0ve5PzQRN+xHOPsv3Per2jRzoF8cG8Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741079281; c=relaxed/simple;
	bh=4Iy+RYC/2fZKuXzIyEvWFgtz0GouQcHycJMQ580bciU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oVoWXyWFD5KgqRweX+IIEYFYbXDUBUDl9cYr6q/APFVcQdgrpeAcbaRACbmL/UoHovkw7I4X4cOIxE/6ArbvQCdNbUWaYjOUgeCrIkEVAPTYELiI37gey+3yEJdp7SKVj7FYFTcDImpKy7dEAvGtcE9QVHSW3GOws+Gl5fDQ/cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DU73JwKA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vxzWmYgI; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DU73JwKA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vxzWmYgI"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 46BB81380B39;
	Tue,  4 Mar 2025 04:07:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 04 Mar 2025 04:07:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741079278; x=1741165678; bh=ILIn44vWdM
	YQ1AJ0C9r2n4+S2euz5cLg6PX7g6Lk7dk=; b=DU73JwKASd5tRz9yMGuBOZqEX3
	zoZNGQvqe9X3flm4fpgAZ86GeA7/lINLr93CM/Vz5NSUi7hZZUftOocVtt+FSuIQ
	mM7sZFFbzg7TOVEUfs5n7cr6XEFTqQn87rbwOWiBQL4GihTXeEtwp3E9awantsYL
	ZkHQ2u9UnynsIc3pUBuhcxnCAZeyZGlGHgC82hLvKZrrmrhDoj/K17lVM+6Kern7
	NqrJ4KXZX/NPrEza/9I9dn43p2xjFw9DYyfLY0GBQy/RquBXBxbD9rPbRAdiMMMv
	vmMesjX3Jy5C5iPKk6cx26kkBIkMxS6utD4oCmdSxIRW/J1NjcP5hKfs20/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741079278; x=1741165678; bh=ILIn44vWdMYQ1AJ0C9r2n4+S2euz5cLg6PX
	7g6Lk7dk=; b=vxzWmYgIctW4BzsFxIGwXppUfIM9YfrqdQI+6JxzpMdG+iEbbOB
	oGaSDmmudKo+KIEAm5P46Zze4SVr76LZeaHWpBCG07dI64P9fypr0flIHgir4tol
	/a/E+heYrUtO3dcVdZRPi/WRPjb82G2mc9viNtdz9Jarrk1ncJJr0nqLPh5izsPq
	p8rcuoZQt0jEUJDWiHFrKtmiuLldCQirwQ0jhvps4M7KqYb/7HFPBoeDCPwSa+Yn
	XYIMLTjuk4hSQVjyqfGeTKJlW5X24ffUi6Hija4liC3AJ8M/c5pXmwljbJsE8oHD
	p5nmzqSCRk0xeYwgwa7FAqR1/tez3+kIafA==
X-ME-Sender: <xms:7cLGZ249cvoEcPJrfJj6xItkboh89T27OGaDD1hz3FT_Be0Hp15ldQ>
    <xme:7cLGZ_4XM5NcXKr-233OS7Oo91HN_DzbyrLLMAl8NCG_69pERf_QZ-f9tmA92NLKP
    ElkKPScIlZVGvwkuA>
X-ME-Received: <xmr:7cLGZ1fD1-2dE7z7kPITldxOsfZeIOrDy4HNXrp6dzjibl8uEui_VgM06_lsMFMhpm_ro6tWtpqaRTCblzCjoNhkMb3ZGgoRcq8CKnIUAXIIvIc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdduiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprh
    gtphhtthhopehpshdrrhgvphhorhhtsehgmhigrdhnvghtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvg
    hnthhoohdrohhrgh
X-ME-Proxy: <xmx:7cLGZzLCdembt61ykp5C87De45fMGIHbXEU6ynspt-c2AFWklFlWUg>
    <xmx:7cLGZ6Jf-NHJ3kqXn3kd4UcybEWKDTw7WwyEmJ6rPhzG4C-5zOo9Uw>
    <xmx:7cLGZ0zg6rIki_W6vYR4za_IiMwSLECZSmQNfwVWEOsuHWuWLMyeRQ>
    <xmx:7cLGZ-JZM1THfT3BarNj_0jzXbLWmEsKKzZOcgrCWrfREcGNDTjgyQ>
    <xmx:7sLGZ_GCDXDHaYOLONdTvW3c5y_LD2t1Ecl032EicNcg2je0RGZTO12E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 04:07:56 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 222f2901 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Mar 2025 09:07:54 +0000 (UTC)
Date: Tue, 4 Mar 2025 10:07:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Peter Seiderer <ps.report@gmx.net>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] meson: distinguish build and target host binaries
Message-ID: <Z8bC5LINEPmoarRy@pks.im>
References: <20250303-pks-meson-cross-compiling-v1-1-73002ef6432e@pks.im>
 <20250303150956.24a1815e@gmx.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303150956.24a1815e@gmx.net>

On Mon, Mar 03, 2025 at 03:09:56PM +0100, Peter Seiderer wrote:
> > this patch addresses the issue reported at [1], where it is impossible
> > to specify the shell, Python and Perl paths during cross-compilation
> > when using Meson.
> 
> I still believe that is is a 'misuse' of the cross-file (as stated already
> here [1]) the given programs in cross-file are to be meant to run while
> cross-compiling (at compile time) and not on the target (e.g. it would be
> impossible to find a program (as the name find_program indicates) at
> compile/configure where the target layout is yet unknown....
> 
> I believe the correct solution is an extra configure option for cross-compile
> and a sane default (or find_program) in case of native build...

I'm mostly going by Eli's assessment [1]:

On Tue, Feb 18, 2025 at 09:41:23AM -0500, Eli Schwartz wrote:
> Overriding it via the cross file would be fine -- if your goal is to
> only ever find_program(..., native: false) in order to detect a path and
> embed it, then it doesn't matter whether cross files are for running
> cross tools on the build machine or for looking up cross tools to detect
> a path and embed it, since the two goals would never *come into
> conflict*. And that's what actually matters -- if you are concerned that
> cross files will be wrong as they specify the cross-compile environment
> not the install environment, then you shouldn't be using find_program()
> either, you should be exclusively using build options.

So this makes me assume that this usage is okay.

The reason why I prefer using a cross-file is that it makes it possible
to specify the complete environment for a cross-compilation in a single
file. This would include both the toolchain, but also target-specific
options like the shell/Python/Perl path. In theory, this would make it
possible to eventually start shipping machine files as part of the Git
project that are completely sufficient to set up cross-compilation for
e.g. Windows.

That being said, this is only my opinion and it's not set into stone. I
just don't quite see the cross-file as abuse and think it has merit to
do it that way. If there is another good argument why having a build
option is preferable then I'm all ears and happy to revise my opinion.

Patrick

[1]: 24df8aa2-760f-4da3-88b0-ab97796373fd@gentoo.org
