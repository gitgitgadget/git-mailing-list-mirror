Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D3B36A03F
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 10:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770807489; cv=none; b=HDgFD9q2VxA3GCXxjwaCJkxrEHdDgJC9vJEpQldeFy/IPnrFfEetH812WkmtrYErUHRu1mjY/nKV+qS6pQwK3i6OMk5bxzssRju5FSzl6H47bSTarQ0SNV5Kgqjq9lNC1N2tZi6jCudaGrSSqaFrIgbYcNUqIPjaZVEuWwe6+AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770807489; c=relaxed/simple;
	bh=w1UWI/Dj7e1I9o3U6LfPa/JVyh4bYLfeVeq3xUXpjis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fSkq61B/PRNoK5vHf2TjAPR0e9kZdf2WPlEz/gTIxaUHJoPAd1RgAAv+tUrgO2jX/3//13OzEd/oemLl72xE5TjopaQ4SqD4+FGKBHK4LEVCaksgyudbBKc3SWKsMTRMzu9shQBOZXxG2fSQ54mQRGpGxmYkkogQun8OH8bTZEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RW62JmN3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Bjff+eH7; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RW62JmN3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Bjff+eH7"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4396A1D00248;
	Wed, 11 Feb 2026 05:58:07 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 11 Feb 2026 05:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770807487;
	 x=1770893887; bh=OmjlHZ9qT4fMS0twCEQxyr0yYZA9DmKSnXCYs6FNr/4=; b=
	RW62JmN3lsqdZbbN/OcggQn13FL7Gshlh8DLZGDQYj3lwztvdE46YqSUsdM6myVL
	LbBCp7pbksmdOSZLZB+1gvQ5XEZcuuv9asw/AD7J8Tp0ICvovLjQ3WNSVIVfAM4S
	rz6zOBXxnTOQq+cXr7pEqkpeEwBr1hbSvdM3PAJvod4d+mi8eihH9k7f4zElzUL9
	ruNINgJZ1Rzy4PERXTCAQJnFEfdjnkB10DMzuPwRsgP5WbYX4vI4X0+MLGp3uZry
	jSWHdfomGDrbEOr3e+5hIrAL/8FrC4OzRwHHD+vjXnE4fisWFTlfExf+Rsk1X72B
	tFbTVBkKJaIDwns44XSsAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770807487; x=
	1770893887; bh=OmjlHZ9qT4fMS0twCEQxyr0yYZA9DmKSnXCYs6FNr/4=; b=B
	jff+eH7YjTIcWNoj/bXrMWeiniweXL1CRouBVmZnqBvb0qQ96hrImIf9jl0uhU/X
	N1SrJA/wQbQvlZxCK1Cqp87I7eBIk10T5AHObByGqdJnXcAjYsxGMNcx2r9xfVYV
	sJrBnt6r4KDrjhGQKiGdLbWQrAqZd3crqErP4kwLz1zmntJjQk/es+Zk1yDjpE0l
	28smpoGuyBXxMW0GWvrLrm7UXsMsnFZewMr5Vog/F5T/HKBRLdbkhuje0Pwg3OjI
	PdQelmPTxBO7Gtf/rXjcNXrjfmLzNvXKWI8YgvHrWtndyc+md2oU9nTO51zjpHXo
	hMCdxlPPCZFaHl473p+PA==
X-ME-Sender: <xms:vmCMaWS7KF-d8dBr_kCocYZl4XihophLUaviF42XbIynhd9_w9QQcw>
    <xme:vmCMadTLhBrpzMjAN_mYyYhs0MHkFpKEjfjKGX1629NB_mbR6aGjGz86uSV58tXb_
    HLri_r4sCiCG-TsSAcQDcyYsUYw29grwyWNt7Qd2f23EaD-mMqVVg>
X-ME-Received: <xmr:vmCMaT7-MI4TOTKlmSR9tzVMW8p57i4naZJzm353k7RdN-i6uFz8IahZGbePDRFv3F_39lOZgW-0T7e0TaNHc4EcqqzzkZXSoyOb7iI4BTiq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgdoghhithhhuhgssehgmhgrihhlrdgtohhmpdhrtghpth
    htohepvghvrghnrdhmrghrthhinhesghhmrghilhdrtghomhdprhgtphhtthhopehphhhi
    lhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:vmCMaR1ObLjcxPF-Y4cFE-BAAupTjmlufwwk9-CUwzFPQC4gIXJemA>
    <xmx:vmCMaWCYQFNsdCjmaBafV71amCAukCXUf3cqyuofY4j88s_hbOObIQ>
    <xmx:vmCMaUNiWCupg2eEFWDeIJVsh2cZvRdq0FeBGIK7ue3EN0whTH5MPA>
    <xmx:vmCMaTZjcdUe-PiZscb4Z4dYdMUDEbIB5xbTuHfCvq-WepURAdkabQ>
    <xmx:v2CMaZE9A-SqRwCen6AcyfmNa4Hrf94xeWqP-Xz3VYD7cmXkGS8_dwZX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 05:58:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2a5670d7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 10:58:04 +0000 (UTC)
Date: Wed, 11 Feb 2026 11:58:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Evan Martin <evan.martin@gmail.com>
Subject: Re: [PATCH] meson: regenerate config-list.h when Documentation
 changes
Message-ID: <aYxguUQ6A1cuphCe@pks.im>
References: <aYn8XKv2hH2HX2xO@pks.im>
 <20260209215015.25867-1-ben.knoble+github@gmail.com>
 <aYwzAt-dugh_acj9@pks.im>
 <4a566010-821b-4078-9563-9ca00ada55a0@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a566010-821b-4078-9563-9ca00ada55a0@gmail.com>

On Wed, Feb 11, 2026 at 09:44:48AM +0000, Phillip Wood wrote:
> On 11/02/2026 07:42, Patrick Steinhardt wrote:
> > On Mon, Feb 09, 2026 at 04:50:06PM -0500, D. Ben Knoble wrote:
> > > > On Sat, Feb 07, 2026 at 04:59:17PM -0500, D. Ben Knoble wrote:
> > [snip]
> > > Only, things are behaving oddly. For example:
> > > 
> > >      λ meson setup build2
> > >      λ ninja -C build2
> > > 
> > > works fine, but
> > > 
> > >      λ ls -l build2/config*
> > >      -rw-r--r-- 1 benknoble benknoble 17169  9 févr. 16:39 build2/config-list.h
> > > 
> > > I don't see the dependency file.
> > 
> > > Further, re-building seems to get stuck (I get
> > > similar symptoms if I add or remove a relevant config.adoc file, but let's keep
> > > it simple for now):
> > > 
> > >      λ ninja -C build2
> > >      ninja: Entering directory `build2'
> > >      [1/28] Generating GIT-VERSION-FILE with a custom command (wrapped by meson to set env)
> > 
> > With "stuck" you mean that it doesn't do anything, or that it doesn't
> > actually rebuild?
> > 
> > I guess it kind of makes sense that a new file wouldn't trigger a
> > rebuild, even though I would have expected a removed one to trigger one.
> > After all, the dependency file only tracks the set of _existing_ files
> > so that we know when to rebuild, and of course the dependency file only
> > gets regenerated in case any of those files changes.
> 
> If anyone adds a new file under Documentation/config/ they will need to
> update Documentation/config.adoc which should then trigger the rebuild. That
> rebuld will then add the new file to the list of dependencies. If they
> remove a file we should pick that up with the dependencies that are already
> listed.

Oh? Well, if that's the case then the additional changes should indeed
not be required.

> Do we need to create the depfile when meson is setup? What does meson do
> when the depfile is missing?

The first diff I sent already takes care of generating the depfile. I
guess the complaint was that simply removing/adding a file didn't cause
a rebuild, but based on your finding that's not an issue if folks would
have to modify "config.adoc" anyway.

> > The thing is that build systems like Meson really want to know the list
> > of files ahead of time so that they can have an optimal build graph. So
> > we could of course list all the files that we actually depend on. But I
> > guess that's something we want to avoid?
> > 
> > There's another, alternative approach: you can have a separate build
> > step that's marked as `build_always_stale: true` that lists all the
> > config files. This step would then always run, and it would only update
> > its target file in case any of the files has changed.
> 
> It would be really nice if we can avoid regenerating the depfile with every
> build.

Agreed. So maybe the first patch I sent is sufficient after all?

Thanks!

Patrick
