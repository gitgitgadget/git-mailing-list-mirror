Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C844F25760
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731922260; cv=none; b=E2TOT2lSK5m2O6TJmPuVTBbHehVPLWHZqE4iBX1jBPCXfAvtNRt21dWYZbc550njIM8wqup+ThrxRXDCR2ltAe/R1K3t1X4ZV6bS+BrW1jUujB5Cc+XF6s9w5ls/vCRNnvKZCtR6eObmblGoaNxLd5CvSr0AMC5N48iLmJ47Bww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731922260; c=relaxed/simple;
	bh=+f6b/yLRI8/PypVqp1hEjPxI7nt+o/JlG8/KRbjb7LM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8dy/EUiUl/lFvJqEtCv/5Ywef2yUGafKlSNj+PiO8KpuKTNpVp8ecJ5M6Yn9rkB80rFg4VXVbDNLE1OmURq69d9SmqPHpC5tDYh4g5q3IJlSRMhgyQYKv//Zx+NoAGrJEJQStw0kEMw9+V5QjiGeaDrZNmFXNFFg6VHg9fDWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OoNJt8I9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=boB1bReM; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OoNJt8I9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="boB1bReM"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 94A282540111;
	Mon, 18 Nov 2024 04:30:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Mon, 18 Nov 2024 04:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731922257; x=1732008657; bh=Xd2nMuQabC
	2ahS8pOCoC+rJzMlNIaPd1b0ijQakFQlM=; b=OoNJt8I9GHxqSwspwW/RqJ3JXU
	P0l6Z/6WFQKcIqzQ4ogMYUCtMhlWwhqPFu0TlaIo0quw0CtHqpLXDmZ+3I8lnyJ6
	Vko/zlDGIqE9cRNkpGfkoB4Kop11eXUaD/V03QpZl4u7JXfpPvuKSyRPGqJDuGe6
	VKFG2Lvfg4R5/sf1c2KCBMEHvIOoiGbNc47RxV/aDozNcNyxTbFhUkELVPiJDdSo
	r7ka8xePk8p+XTZy4YWzZ6nY2h6Lnk9xQueUKJ5dVH2KF7IVnblvQas7fLsKaUDp
	MyhS1bY1/B4AzKpd/l3sbCfqBXc13JB9TaVAoObbd/ouplUwaqlSIfPuL6iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731922257; x=1732008657; bh=Xd2nMuQabC2ahS8pOCoC+rJzMlNIaPd1b0i
	jQakFQlM=; b=boB1bReMyZMgRKvHqd1naxlM226dEnihrWmGeLNhJ0OTWjkyua9
	Iv5I42tgKssjptjvz/5JsajQ59khzNMQKq7yST1EENadhZNEI6Z5zpgSUTHX8gO0
	Zj72sTFYSB/L60/jHIZELk3m3c1W+P/CTBIM8Ng8iw1ek773h94IcqAQJkaBvN18
	W4bMsp1VNFKx5RU3bzXVpZfuF/stbT4415w38o/UKbETBscsEEp0ypBdDuZzttr+
	+7s3DlavwDe4ScjJ3USoNu452QsHDTKiITwDgrJCoBBkdBXZBFITPFQ4FxsOfA4S
	tSkp5cMSMqIXNxvtuPbK7RMoxNA04BVZ8YA==
X-ME-Sender: <xms:UAk7Z8XU5F_bTB-yNasqDsLLoW1bKHSU5sDWGVffDPC2h-XMqmuXDw>
    <xme:UAk7ZwmyKa86ITbqJUHdVGFQ9QRL-2XcLIa0e_IB223OlGXyqTUHtIrm_30FlHh9-
    3v9dCy6LNRsG_sc3g>
X-ME-Received: <xmr:UAk7ZwY8YfDMi7hKv7ZSUPAnGAJXyTxluJhj7IwRwOMLO-LU9HgNPmt5zQWKUl21RBiOqxaGUcODyAK0pBzkgXHL_OByRJjnh8UWM3Czrwv1Fo68>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrghdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgv
    fhhfrdhnvghtpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpth
    htohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehrrghmshgrhiesrhgr
    mhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:UAk7Z7Vev4P7wYXoXPrB8ufBLazLERg_Uj2mwbxNthBS1l6B1urNwQ>
    <xmx:UAk7Z2m1sYgZenbg1ofFw7N18AQx740Rc9vNlilgkCC8vU5pZX2Hig>
    <xmx:UAk7ZwcwWagN7ez5dW0yl2YlFPWJiv2eg2WPog34dJ_dOM46yjK3Cg>
    <xmx:UAk7Z4FOMZp84DKnykZA34y6iL_zPfc6OU3MWuBkDTanSEEfy6rTmw>
    <xmx:UQk7Z_dzhDy7pG9GZpW0BhzzwJ2_CX5x2FLQ4n-X26-zFjzuvmLAG5bT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 04:30:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7bcdedad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Nov 2024 09:30:07 +0000 (UTC)
Date: Mon, 18 Nov 2024 10:30:44 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: git@vger.kernel.org, Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
	David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [-SPAM-] [PATCH RFC v7 00/22] Modernize the build system
Message-ID: <ZzsJRFQ2KaJCiOyG@pks.im>
References: <cover.1727881164.git.ps@pks.im>
 <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
 <b9e0f631-b2a3-4c48-8745-a4b1e3f58ad0@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9e0f631-b2a3-4c48-8745-a4b1e3f58ad0@ramsayjones.plus.com>

On Sat, Nov 16, 2024 at 01:23:19AM +0000, Ramsay Jones wrote:
> On 15/11/2024 07:21, Patrick Steinhardt wrote:
> [snip]
> > Changes in v7:
> > 
> >   - Fix overriding TEST_OUTPUT_DIRECTORY via the environment.
> > 
> >   - Rework generation of version information. GIT-VERSION-GEN now knows
> >     to replace @PLACEHOLDERS@ in other files, and this gets used across
> >     Makefiles, CMake and Meson now. This makes us properly rebuild when
> >     the version info changes and fixes the version numbers in "git.rc".
> > 
> >   - The CMake build instructions are now doing a proper out-of-tree
> >     build.
> > 
> >   - We now generate and install gitweb.js, which gets built via a new
> >     "generate-gitweb-js.sh".
> > 
> >   - Some improvements to the Meson documentation.
> > 
> >   - Wire up DEVELOPER=1 style warnings via `--warnlevel 2` and above.
> > 
> >   - Wire up sanitizers properly.
> > 
> >   - Provide a new "regex" option to disable the platform-provided
> >     version of regcomp() et al.
> 
> Hmm, OK, but what about all the other 'configurations'?

I don't think it makes sense to introduce a separate option for every
single bit of the build process that can be changed. One of the biggest
differences compared to our Makefile is that Meson should be able to
automatically figure out the build environment and set up the build
accordingly, without any user interaction. So in the best case, whenever
we learn that a system does not work out of the box we'd not introduce
an option for this, but instead adapt the autoconfiguration logic to
detect that.

Now there will be exceptions where it does make sense to make something
a build option, due to whatever reason. But I'm in the camp of adding
them as-needed and not proactively so that we don't end up with hundreds
of options.

> >   - Stop installing git-http-backend into bindir.
> > 
> >   - Install Perl scripts into libexecdir.
> > 
> >   - Install git-cvsserver into bindir and libexecdir.
> > 
> >   - Install template directory into datadir.
> > 
> > As before, the tip of this patch series catches up with what is
> > happening in "seen". If you want to test it without topics in "seen" you
> > have to revert it.
> > 
> 
> Just a quick note to say that I tested this on Linux and Cygwin (just build)
> and noticed a few things:
> 
>   - 'make clean' does not delete the 'version-def.h' file.

This works now with the latest option.

>   - the RUNTIME_PREFIX set in the GIT-BUILD-OPTIONS file on the master
>     branch is not the same as on this 'meson-v7' branch (patches 1-21
>     based on current master branch):
> 
[snip]
> 
> Note that master has RUNTIME_PREFIX='false' rather than being un-set.
> (Indeed, the Makefile on the master branch normalizes the value of
> RUNTIME_PREFIX to 'true' or 'false').

Ah, good catch, corrected.

>     - The format of the GIT-BUILD-OPTIONS file generated by the Makefile
>       and meson are formatted differently, so you have to massage the
>       top-level file to be able to diff them:
> 
[snip]
> 
> Note that the Makefile build on Linux does not, by default, build with
> libpcre, even if the library is installed on the system (as it is for me).

I think building with libpcre by default does make sense though. I guess
that we don't with our Makefile because it's not doing autodetection of
available features in the first place, so it was safer to not compile
with the library by default.

> Also, note the values of BROKEN_PATH_FIX.

I've wired up the SANE_TOOL_PATH option properly now.

Thanks for your feedback!

Patrick
