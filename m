Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F021D3F2
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 08:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770883842; cv=none; b=J91IdLt9BCm/GHhf7NYc79lRDou//U91EXDdR9Bc2GcVFIS1V1iQYe3H4gBlyhBzo4E9GGC2SZU+8aPu47iccCwjFE3vkU2/4wqP36ZuPNERIjCAHmG++wvIsSqL8TjmwQoobFdKqNlg+CygVcdUI6IXgrOA0sIZ1WdKQCcJ7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770883842; c=relaxed/simple;
	bh=35sFaHG61edTYXMEPTlTZ4YYVJyy4tKGaF8QHwcAUVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nx3yiz69eY5UqYp3dmv7iGQbRHpUFGWweS+licIVhA+ONj/+yzYEMzB/yNpY1epDhxReF7TDWwb7vIG1idRd3CpU6H6R+WGVcI5ghDNRkZ8j5dR3gfha3fUkLgkm3gJpTWHSPkqNdiOvDmku/v8iPooSqcpM/HTKvd9YDuHNGeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mk58b0W7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Id9hRe8z; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mk58b0W7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Id9hRe8z"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7E1DDEC0057;
	Thu, 12 Feb 2026 03:10:40 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 12 Feb 2026 03:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770883840;
	 x=1770970240; bh=kzROCZhQYB0/q18ZlEeyWaRvvOcIIkG2tEbAecLxs4c=; b=
	mk58b0W7WH4ucKzP5XCbs5nePnlgWuViNVilEBr4DkKmr85C8HUPxQ82v/TPjdPw
	G5AYv5WFHxzO++Qdv4dFTH24QK2FOezz2ZKscCbxrHfau5VrsGO7vc+wos9i3V3x
	lT4BmpJxKH1cCbiy17Hh9fzVnMN+STy+ZixInyLk4MnomEHOv3Y7KENiomST82u+
	Uh2JEq3QiEcG8ZN3JrqWzpFgQ0YKe8VJm2wA+8NsZpZtZqjwTLbhc32R4GPGiVF0
	WzXQIMwCp0VRlniyzNZL0s2ERtzVzZ1Co7T3PyJi7xtrZE2MGkCQEcd8FqoHqOLS
	D6rHLykq/zCUt/YYO7H4hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770883840; x=
	1770970240; bh=kzROCZhQYB0/q18ZlEeyWaRvvOcIIkG2tEbAecLxs4c=; b=I
	d9hRe8zJpS/YVD1F9F+rNQhb8FA3aGFH06ZHWP4OiNVDydO2I/11HtREvq2REvaW
	vtinYIk+DXG590lOmzll3OLpNY1Y1HxZNcbPidsH7y0uNKyp6EziogYd8+aXgzV6
	AU8vnlvPonjHl3APn6zTl8PHrA16YKGJa5Ov3arpruEguieMgEH3V5+ytnVnoVYp
	uqLlTbKuF2Z2POqSRdqdzflqc39SbbrPYPoBZaEk8eaaEfoTWKmTrECGsTxLAYk1
	MoTesDtEt4hYUV5YG+PeF6Y7Yew6LKdY0MiD8FwcE6BulsPOvqMw+pRlM2uK9jbd
	8WWTro19zeuBcAzWkePfg==
X-ME-Sender: <xms:AIuNabECKQjV-axUejkLwONAq7geInLVc5BbkqXUxepL5Pz-vKn7Xg>
    <xme:AIuNafMROmY91b0483Q19AMLbHJPOQVYE7QAvsLM93WMM7Q6kL3wfAw2PHIs7bj_N
    pCRgydcKIJakIz5-jauodqi24Mi5FrHv4tauBrZV1QvugRFcIpXnQ>
X-ME-Received: <xmr:AIuNaVeJ8JszWa65VtwOifRHSZgjwPV-ZHZTmSYvsbp33KdOx4asicOLbwp06U_-ti0gtow-xlIf-m2puhe6pv9gKPSJZa8vVpfojHUI8dk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvvhgrnhdrmhgrrhhtihhnsehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:AIuNaUvOoxTAhwkX4pwXNRZ0Q13_X0sAihceq4IFlVf561sRImUm4Q>
    <xmx:AIuNaen0T2HKuz9t92kI3F_ANsVja9fHG0XfJxoQguq0-vnHjr6RGA>
    <xmx:AIuNaez23B1dV18QStEjc-Gs_naGTb_RWiUW3T9l6DwWw8cQ0S_alw>
    <xmx:AIuNaYNyttySEUlLVHv1-_IUmhkBNBWM2eQJShRe9zLHrGQnDz1tDA>
    <xmx:AIuNaT_cCyJUTVJ6pCMdmkOAFxlJiyOV-OFQVJDuP18uPNlvkasZKzfD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Feb 2026 03:10:39 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 563c390a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Feb 2026 08:10:38 +0000 (UTC)
Date: Thu, 12 Feb 2026 09:10:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Evan Martin <evan.martin@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] meson: regenerate config-list.h when Documentation
 changes
Message-ID: <aY2K-_ZHyDBBh3_B@pks.im>
References: <aYn8XKv2hH2HX2xO@pks.im>
 <20260209215015.25867-1-ben.knoble+github@gmail.com>
 <aYwzAt-dugh_acj9@pks.im>
 <CALnO6CB2KXUKdJ2nOOGLAe2fxkj+c5yF-f34dao=p6nTAEQwfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALnO6CB2KXUKdJ2nOOGLAe2fxkj+c5yF-f34dao=p6nTAEQwfQ@mail.gmail.com>

On Wed, Feb 11, 2026 at 02:58:27PM -0500, D. Ben Knoble wrote:
> I'm not totally sure where the discussion ended up (what's actionable
> isn't clear to me), but let me respond to at least this bit:
> 
> On Wed, Feb 11, 2026 at 2:43 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Mon, Feb 09, 2026 at 04:50:06PM -0500, D. Ben Knoble wrote:
> > > > On Sat, Feb 07, 2026 at 04:59:17PM -0500, D. Ben Knoble wrote:
> > [snip]
> > > Only, things are behaving oddly. For example:
> > >
> > >     λ meson setup build2
> > >     λ ninja -C build2
> > >
> > > works fine, but
> > >
> > >     λ ls -l build2/config*
> > >     -rw-r--r-- 1 benknoble benknoble 17169  9 févr. 16:39 build2/config-list.h
> > >
> > > I don't see the dependency file.
> >
> > > Further, re-building seems to get stuck (I get
> > > similar symptoms if I add or remove a relevant config.adoc file, but let's keep
> > > it simple for now):
> > >
> > >     λ ninja -C build2
> > >     ninja: Entering directory `build2'
> > >     [1/28] Generating GIT-VERSION-FILE with a custom command (wrapped by meson to set env)
> >
> > With "stuck" you mean that it doesn't do anything, or that it doesn't
> > actually rebuild?
> 
> I mean, that's all the output I get, and the build seems unable to
> make progress without the depfile present. Maybe I'm misreading the
> above output, so let me try again with a different kind of change that
> would cause recompilation:

I think you're simply getting confused by Ninja's output.

Ninja knows to short-circuit compilation in case regenerating a target
that is used as input for another target will not cause the file to
change. So what the "[1/28]" says is that we're regenerating the
"GIT-VERSION-FILE", and if it would change we would have to recompile a
bunch of other targets. But we see that it didn't change, and as a
consequence we can skip compiling remaining targets.

> > I guess it kind of makes sense that a new file wouldn't trigger a
> > rebuild, even though I would have expected a removed one to trigger one.
> > After all, the dependency file only tracks the set of _existing_ files
> > so that we know when to rebuild, and of course the dependency file only
> > gets regenerated in case any of those files changes.
> 
> Trying this bit again, yeah, config-list.h doesn't get rebuilt if I do
> `touch Documentation/fooconfig.adoc` (I think make would rebuild
> though). And I can't tell if that's due to the weird [1/28] output or
> due to something else, since I can't "see" if Meson recomputed the
> depfile or not; with the depfile gone, it seems like there's nothing
> present to tell Meson (ninja) when to rebuild, which is weird to me.
> It seems this is expected, but it makes it difficult for me to tell
> what's going on here.
> 
> After `touch Documentation/config.adoc`, ninja executes 7 steps,
> including rebuilding the config-list.h, at which point it also knows
> to rebuild after touching "fooconfig.adoc" again. So maybe that's
> expected?

I assume that you simply didn't have a depfile yet initially, and
because the script itself isn't part of the deps Meson didn't know to
reexecute it as it changed to gain support for the depfile.

Not sure though, but from all I can see things work as expected now with
the current patch that you've sent.

Patrick
