Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01F32AE72
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 04:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753245142; cv=none; b=ekqVoUEbZKwG8NT0FSNgvTJ/3KQMfrSD3ou6QvUnYjGFcJ4lAkjWny8cFo9T4FMvK3xAaUES149XlXDJ3DKDfw01uKh9cBOQu82Q2Q9EHdHwcWtcm5Qj7GmhtzqHOH4e9tv0K/YadkpJsd19lx7WSDaKPtn6leNUVzz/SIlCL/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753245142; c=relaxed/simple;
	bh=NotvIub9vHnODVRfzLNMkkjNXN3JpStRwKwexqRDDgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWeHkmCiVhfJr3yFpOatpwb5nNLZ3sEIUSnJrBQlwGqoS48BBzl4meofCTkrZC9LZvbDYMKAH2+5bNqrwpP+w+HEuQhGDpFxn7bVJDK8toiwHBhhtdKLJvE00KrinrhS81eLRC2JRftTivWMuHT0poT/Zdp3J70TcIiKLXYRq/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uCmPe99e; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PxPu27Qc; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uCmPe99e";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PxPu27Qc"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id B387C1D000C6;
	Wed, 23 Jul 2025 00:32:18 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 23 Jul 2025 00:32:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753245138; x=1753331538; bh=RmFcEoc6g5
	sOM056axXLoidmlH0/Ky8tD3g04oVphvM=; b=uCmPe99e61YQkq8bIpXHNaucf0
	IPmQgtaAtg6+k+5CNKNEUHsMSxWjWRjGUB9Xu8E07CBEV+hxB3A917ZntPTFAFLS
	uSWSZm2iaFDCpBujCjrqyA/QB88LdujjQpbUzYg2Qy0IJ0ChILRkCK1qIbQKQfW1
	oq6Yxsqxxyuz+eDfRyhfV/zrtG7XvcwM+YMTiltVjR3gxF7wSqqIPmAklnxEVYq4
	KetypXiOjvuXd0hdRCvkVjSZVl29oFvGyQ3HPqGfd6RMwIFN67ba2S3TZhOd4W+E
	OHyH8gpa1EZwT8OIxVGtJe4xMMpdubysZWjYGpkX931qyO4Dtb4rCxf9RbEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753245138; x=1753331538; bh=RmFcEoc6g5sOM056axXLoidmlH0/Ky8tD3g
	04oVphvM=; b=PxPu27QcZQwl3NwhhaDecYPlXdDrICIjaQSlm8x3wennJw4Oq0a
	SVEp3f6smogBH90D0ZUHqa1eG/5UyW/xemcZo9L6+e+A8ZNjQiDnAswo7xFO3x0d
	KbmInHsohodBNGVm5PzQkKrVBXyReeLjy/23lbQ9yzfyvwcYnzbNQqcDwlckCFv9
	0RQEZsdNra7AxAGPRK2L/Eg97LyUyk/HhwG/iGxHKUFya6Q1FrCQ3aDiM6y1RWkD
	0iYXlMAtiuzgiq255iPVKjmWs1lhd8teJcRuhZgHmGsvVO5PZkIlxBoa3Vwyi8d8
	/Pc3jvUfEJJD+qgTDIhXJXBn6oti9gySX9Q==
X-ME-Sender: <xms:0WWAaOH9cjiqxrAXdJhGIUoQHYmxXqHcaOR6LEbuWKzjoTTYC7Lrhg>
    <xme:0WWAaLB3IPZ5UCOdERyBzHjtiSQtmKdUhynZYYO6Bx4tr5pVMCsUCUUtQtZ5CAahC
    O7-BQKEKSQCVivF3Q>
X-ME-Received: <xmr:0WWAaEkXEB4i94mrGcn7JS5knH_P5DW-peYPrkb_FK9ZJsI8tg84Pasbhro-F347Z98zLa1huTyoe0Yi_sPURqCcAY3rtmLMxu-NC0Efy7ce>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejieekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtrodttd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjedttdegffekudejjeegudehgfehtdfgtdeiud
    elueelgfeuteehledugeeuueevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdr
    ohhrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdr
    nhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:0WWAaBNYL2MzqrYHEIRJgIlQ9thelf4bnR66BwXY_yJBidB4zqkT9A>
    <xmx:0WWAaJ8J0Eid7Gp2bRpxtwgwq4iKc4QYHO5jsy3keCIj9PthwFeHOA>
    <xmx:0WWAaLFbjT3cE4ogzOALXbWWF2JlCww1DayiheCrwueZDVXoCzpE0g>
    <xmx:0WWAaAghL_1w-fyVwX0cpaEj80r3T43twtfX4D9DwaP1cFL7HvWgZg>
    <xmx:0mWAaF6OF3wDSBLNhZNuLt-cmIU0Uydjk6aoAf_btZA6NuHkYgkxCn5X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 00:32:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0242498c (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 04:32:14 +0000 (UTC)
Date: Wed, 23 Jul 2025 06:32:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Sam James <sam@gentoo.org>
Cc: eschwartz@gentoo.org, ethomson@edwardthomson.com,
	ezekielnewren@gmail.com, git@vger.kernel.org,
	gitgitgadget@gmail.com, me@ttaylorr.com, newren@gmail.com,
	phillip.wood123@gmail.com, sandals@crustytoothpaste.net
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
Message-ID: <aIBlxnoOqwHhGzMd@pks.im>
References: <aH-fDEX7gdpALJ6w@pks.im>
 <874iv4gqxv.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874iv4gqxv.fsf@gentoo.org>

On Tue, Jul 22, 2025 at 04:56:12PM +0100, Sam James wrote:
> There's a few issues from our perspective:
> 
> * Old platforms which don't have LLVM can't yet have Rust either, as
>   rustc is based on LLVM.
> 
>   These need gccrs to be unblocked. I can understand not caring too much
>   about these, though it is unfortunate, because I think if git hadn't
>   supported many platforms to begin with, I doubt it'd have the adoption
>   it does today.
> 
>   (There is another effort which seeks to take rustc and bolt on
>   libgccjit as a replacement backend, but that isn't feasible for use
>   yet either.)

It would be great to know about the general timelines of these
alternative implementations. If e.g. gccrs were to achieve compatibility
with one of the editions of Rust next year it would be a good enough
reason to defer the rustification from my point of view so that we don't
break the ecosystem and have wider platform support. If the answer is
"They'll land in 10 years" then I don't know...

I sifted through their project sites and found various status reports,
and they do seem to be making steady progress. But as far as I see
critical language features are still missing as of now.

[snip]
> * rustc doesn't have LTS releases or the like.
> 
>   The only supported release is the latest one. Upgrading to the latest
>   release often means we have to deal with new portability problems
>   but we can't not upgrade because:
>   a) some software will start to require bleeding-edge Rust immediately,
>   and
>   b) it means we're missing out on bug fixes (miscompilations are
>   serious)

I'm not a big fan of this in the Rust ecosystem indeed. It feels like
every second project requires nightly features or at least a version of
the compiler that was released in the last couple months. This may work
for a language like Go, which is more targeted towards deploying server
applications. But for a system-level language like Rust I think it's
rather a sign of it being immature.

In any case, the burden would fall on us to ensure that we carefully
consider which version of Rust to target. And as it was said elsewhere
in the thread, we would need to make sure that things build on old
versions of Debian. Which may be easier said than done if we also rely
on lots of crates which may update to newer Rust versions at any point
in time.

> * Crate creep
> 
>   Rust projects tend to end up having a huge list of crates that they
>   pull-in which makes us worried about something nasty creeping in, but
>   there's also popular crates with serious portability problems like the
>   'ring' crate for TLS.

True. I think if we were to adopt Rust we ought to be as conservative as
we are now with picking up new dependencies. I don't want to have a big
open door for supply chain attacks. And neither do I want to be forced
into the situation where we cannot update a crate because they decided
to drop support for older Rust versions.

Patrick
