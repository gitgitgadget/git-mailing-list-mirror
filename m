Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AE202981
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742391017; cv=none; b=rDkKUunGyVmFTNkBLctECFjF+taACH3fxAAua1QRxQBFysuS1YbP2VXaL/vbkSbLX0+fvnZMjD84Q9A73g0ZDHOsISPmQcVXyuMvUbqKECL2lyEllMYgqCzm0xa7SLGVZ1aCQB1YVJDKIFRg/h/enuOVd4Tec7UYX90tqrncKvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742391017; c=relaxed/simple;
	bh=ORZnxHhGx/92SqaAhezcUd5+PKVNZ2d3bQzAEj4oMM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu/hbBo5pzGodNYXXJjSR6dDK2ScWPAoxwB4KWj6BbEkYRUUswwP5BE1EdwaJY7WyHV5KYeD7TufmPoj8ewRx6Ove0vICZAHQgGyiC3v4fn4ooUAtXHTQ0Bg8DgAByvtvv/wURf3Wf3jyx/+pxh34LgoFzjDCVh65+eW6fs+PHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A4zZbFwG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a3nOmbGu; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A4zZbFwG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a3nOmbGu"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 231DB11401D0;
	Wed, 19 Mar 2025 09:30:13 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 19 Mar 2025 09:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742391012; x=1742477412; bh=Lil7EW0SSR
	Q4l+ufXCXO+V+QFWg/V/Zn/LT1c/uoYWA=; b=A4zZbFwGktJU4Dvs1xN3bXY6mx
	e7QcbWtAnrN7MgU4X1GjvWQ0wph5aJsZq1SOQfyTSVDRONTzoPGC9s6MLonP5uDL
	UwVXuQDnJ6LeCNWlHw6mvyxqAFaUpS4hex7/Qfx8VMjcWuwOKRXLTgErTZlCIBdH
	PGARFyMg4l0Efa1a2aKlvBG9ZxqtrWyYJc6FsXrz5P7EfIMFMOUxkeJi6OCP/TkW
	ns3IVVmktxbg8yaOZ5hFJmvEezPkXjtOeIWFW7o+lQRwygQ0MjiqR6XHsLoqsBjp
	LrMaPTszUkLO4H5omD4xW4MKiG3uKt4d2vFkzVRd03kJlZImuy6QkEBh9T/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742391012; x=1742477412; bh=Lil7EW0SSRQ4l+ufXCXO+V+QFWg/V/Zn/LT
	1c/uoYWA=; b=a3nOmbGusms2YiPObPQibBtS+OzDYwpPSFFFBYOtfvDuIHcXgQN
	PMqL7MGnsBQDtLrmwMPIfe+m52ro/nBxgmav1JxqK1FNLEqFrtdUxGaPlfcGhQK3
	Z6y0W1mDe5zxAEWPlU1yBWay6POGg4HIO2Ekm3tmtHIaX1D4XLP48tbgJNTaDMhn
	E8+FamKB825CnMkVy+kY9uyUbncgfQhmhPy6MS4mMrqXcYrsCXzh5w9tl2DcCdHZ
	qPhUqZoMk1KwABSQlD4LQZeGoJvfe9M5cuyKAy9q/Lp1l0b3EhXUObVYq+2EYT6f
	pwHCOn4A7+y8kiAXWs2IO7VMsJp/UPdEsAA==
X-ME-Sender: <xms:48baZ0ncJVClB04JOnKfzpp_z-q0eXT-XiifzBHIhywbJyAqAyrxjw>
    <xme:48baZz19Ss2qzRRymJVMeB7Y2BIlqER4XvMzqw5fSHEZQuqC70cU6R_M8QZaNH-0a
    i-vvcBw1YgMqx8zzg>
X-ME-Received: <xmr:48baZyp52KZphdk9dgiqv7u8BTih5xs4UFsqCvRKWhJiQWhWiEDyqMEng4igUwHW7J9DOzabkXE80-_wMvFDW1PQRy1AUxpRJdxh3yi1X0GIF_ud0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepjeetuefghfdvfedujedutdekheejgfffiedvvdef
    ffdutdfhgfffieegleevtdfhnecuffhomhgrihhnpehphhhorhhonhhigidrtghomhdpsh
    houhhrtggvfigrrhgvrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhoug
    gvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpd
    hrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvght
    pdhrtghpthhtohepghhithesughinhifohhoughivgdrohhrghdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:5MbaZwm_ouou46czSly-a94JynwFtCJGH50AwRX37hfw6tLovXXn8A>
    <xmx:5MbaZy0xfUV4pC1MpuH7VLt150VJ_G25Ez3bQ4od6JGVrLMMiQUmaQ>
    <xmx:5MbaZ3v63uwToa1T8XdSXXNEhlRDONnj2HfmY4oJYFWfvrFMTf0cQQ>
    <xmx:5MbaZ-W5_DURhbKlkNHrwuMvhRkZ3E83U5ucf1RQvhFKrT_rY04vuw>
    <xmx:5MbaZ-9R7d8HkvUUUFQmalRRoddN68xM-OwLqpLyS6A8ShDwp_nWk_aO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 09:30:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5d52ec75 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Mar 2025 13:30:09 +0000 (UTC)
Date: Wed, 19 Mar 2025 14:30:04 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	GIT Mailing-list <git@vger.kernel.org>,
	Adam Dinwoodie <git@dinwoodie.org>
Subject: Re: [PATCH 12/12] config.mak.uname: add a note about CSPRNG_METHOD
 for Linux
Message-ID: <Z9rG3JVA5vSoYynt@pks.im>
References: <8c8e16ae-87a2-44bf-a87b-7422eb04fec2@ramsayjones.plus.com>
 <Z9YbJFJjtXNYnTzk@tapette.crustytoothpaste.net>
 <xmqqr02wbtdn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr02wbtdn.fsf@gitster.g>

On Sun, Mar 16, 2025 at 01:41:40PM -0700, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> 
> > When arc4random was added to glibc, the Linux kernel CSPRNG maintainer
> > argued that it was not a secure approach (I disagree), and convinced the
> > glibc maintainers to just make it a wrapper around the Linux kernel
> > CSPRNG, which it now is.  So there's no actual benefit to calling
> > arc4random versus getrandom, and since it's newer and less commonly
> > available than getrandom, as well as slightly slower (because of an
> > extra function call), getrandom should be preferred.
> 
> This
> 
> https://www.phoronix.com/news/GNU-Glibc-arc4random-Functions
> 
> was the first hit of my search in the area, but I think you are
> referring to
> 
> https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=eaad4f9
> 
> that happened 5 days after the thing got in and the code there tells
> me that your summary of the situation is quite accurate.
> 
> So I agree that dropping this patch makes sense, but do we want to
> do a bit more to improve the situation?
> 
> Here is an attempt to improve what we have in Makefile (and possibly
> the Linux section in config.mak.uname, but that is improving what we
> do not have) to tell folks that arc4random in glibc is only for
> compatibility and they should pick getrandom() until the situation
> changes.
> 
> --- >8 ---
> Subject: config/Makefile: a note on CSPRNG_METHOD choice for Linux
> 
> arc4random() was added to glibc in July 2022, but quickly replaced
> by a stub implementation that wraps around getrandom().  Hence there
> is no actual benefit to calling arc4random() over getrandom() on
> glibc based systems, at least for now.
> 
> To avoid enticing Linux users to choose arc4random(), leave a note
> that their arc4random() in glibc is not the same as what their
> friends use on other platforms, and guide them to use getrandom()
> instead in the meantime.

Makes me wonder whether we should also change the order in which Meson
auto-detects functions. That is, do we want the following patch that
favors getrandom over arc4random?

Patrick

diff --git a/meson.build b/meson.build
index d6e27b236fa..501b2becabb 100644
--- a/meson.build
+++ b/meson.build
@@ -1481,15 +1481,15 @@ endif
 
 # Backends are ordered to reflect our preference for more secure and faster
 # ones over the ones that are less so.
-if csprng_backend in ['auto', 'arc4random'] and compiler.has_header_symbol('stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random')
+if csprng_backend in ['auto', 'getrandom'] and compiler.has_header_symbol('sys/random.h', 'getrandom', required: csprng_backend == 'getrandom')
+  libgit_c_args += '-DHAVE_GETRANDOM'
+  csprng_backend = 'getrandom'
+elif csprng_backend in ['auto', 'arc4random'] and compiler.has_header_symbol('stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random')
   libgit_c_args += '-DHAVE_ARC4RANDOM'
   csprng_backend = 'arc4random'
 elif csprng_backend in ['auto', 'arc4random_bsd'] and compiler.has_header_symbol('bsd/stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random_bsd')
   libgit_c_args += '-DHAVE_ARC4RANDOM_BSD'
   csprng_backend = 'arc4random_bsd'
-elif csprng_backend in ['auto', 'getrandom'] and compiler.has_header_symbol('sys/random.h', 'getrandom', required: csprng_backend == 'getrandom')
-  libgit_c_args += '-DHAVE_GETRANDOM'
-  csprng_backend = 'getrandom'
 elif csprng_backend in ['auto', 'getentropy'] and compiler.has_header_symbol('unistd.h', 'getentropy', required: csprng_backend == 'getentropy')
   libgit_c_args += '-DHAVE_GETENTROPY'
   csprng_backend = 'getentropy'
