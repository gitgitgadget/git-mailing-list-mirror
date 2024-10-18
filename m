Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE43120E30D
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 05:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729229092; cv=none; b=EYL/wI8UX9+TYv9n594rQ86dG0NRqjEWUO1XCPaIYiMUOGc5ALbS+VlSztPjix3n+WepzsYJhsfNp3p0V6W/IrPcOKKHKMsxcTLF9jgaDqF4Cr8ZGRTQINvyTbIR6i5EvSexls4UlgaLUDEzMhZuvnDOmnoYFLc90zRr68m4hQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729229092; c=relaxed/simple;
	bh=Aa5KEzAiN/cttwtzq2BftokpJPy12rZYPJ8R3+5sn0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BBBbeVQiKCgEyg0Voc/V/b2LbJyLA70UzvjGJYeDGTR7PYAjCq62s5+ZDgG0AWLejysz4CJo2ldsItVSibEzAb0C8SBvIMsSBcixp7DW9ZWkZ4BPdu9iW1OgVV4+EvwUDwdIGch1zo5WxLa+CX6SzwItWqf+Y7TaVVrXEGPItis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TeFA5UHO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TeFA5UHO"
Received: (qmail 32340 invoked by uid 109); 18 Oct 2024 05:24:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Aa5KEzAiN/cttwtzq2BftokpJPy12rZYPJ8R3+5sn0E=; b=TeFA5UHO9+njBQYc9w5ZTTHoMouLNQFVezNwX5JoxqwSh8Ks/FoPm+Og5qn6DhfEAqQ0lD11lWH0xSrWDKdFw5HVAOLTVevvdoOHB+7fzat5ppPaRC6XFywVnpVtpZFvLh9h4S5srFFZ99Yi/hIVHiOyKs4xu9L+ze6eJG7SgprLm3SbKH3SXqzt6siudK5YDhFKZ/yI2lxDkhLtbB8AEplfhwoFsiuLetCDdeBXyHMUWnePxofdvTtDhxf3mTFUj65qCZDJsFWAST5QNXgb3/cUkXUtqCLX/UREQENBPtAFsfVIv4EWjQK4/Ss+s6bVW60rp+afDP6+iqBlPdN4Cg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 18 Oct 2024 05:24:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13108 invoked by uid 111); 18 Oct 2024 05:24:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 18 Oct 2024 01:24:49 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 18 Oct 2024 01:24:48 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <20241018052448.GD2408674@coredump.intra.peff.net>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
 <ZxGN9zzt55GcL4Qj@tapette.crustytoothpaste.net>
 <20241018045155.GC2408674@coredump.intra.peff.net>
 <ZxHrIBCdnwdRdXAv@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxHrIBCdnwdRdXAv@pks.im>

On Fri, Oct 18, 2024 at 06:59:17AM +0200, Patrick Steinhardt wrote:

> > But IMHO this is a good example of where the flexibility of the first
> > approach shines. We could accommodate this platform without any real
> > cost (and indeed, we should be able to _drop_ some clar code).
> 
> Well, dropping doesn't work as it breaks other projects that depend on
> the clar-features that depend on `wchar_t`. But other than that I agree
> and would like to fix this issue, also because it potentially benefits
> other users of the clar.

So that's a rabbit hole I didn't go down in my other message. ;)

But another traditional philosophy the Git project has had is to be very
conservative in our dependencies. And now we have this new dependency,
and already it is causing a portability problem.

I don't think that means we should throw away the dependency. But if we
are inheriting portability problems from imported code, I think we
should consider to what degree we can lightly tweak that code to match
our project. I don't care what clar does upstream. If _we_ don't need
wchar support, we can drop it or #ifdef it out.

Overall, I'm a little sad to see all of the #includes in clar.c. We have
spent 20 years building up git-compat-util.h to meet our needs for
portability, and there are lots of subtle bits in there about what is
included and when, along with various wrappers. And now we have a new
subsystem which doesn't use _any_ of that, and has its own set of
includes and wrappers. It seems inevitable that we are going to run into
cases where a platform we support isn't handled by clar, or that we'll
have to duplicate our solution in both places. I wish it were just using
git-compat-util.h. I know that means essentially forking, but I think I
may prefer that to inheriting some other project's portability problems.

> The only problem is that the platform seems to be severely broken. As
> mentioned elsewhere, we have this snippet in uclibc's "wchar.h":
> 
>     #ifndef __UCLIBC_HAS_WCHAR__
>     #error Attempted to include wchar.h when uClibc built without wide char support.
>     #endif

Yeah, I have no clue what's going on there. Certainly I have no problem
if you want to dig further to get confidence in the direction we choose.

-Peff
