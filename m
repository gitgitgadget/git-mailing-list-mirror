Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178D92010E5
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740125810; cv=none; b=h6cV/rtIJoKWSaOjgTC9nqSkNJDO1hdwrtneXqXFHlYCwXrzu7wRdMhJwYrS4esEyTdg2mIYMYUAHAdZxWtdJ9e0hB+tR4y+DgJR9P67c7rlAj8vJ96yeVEALdiyQKGJyoP8E73s7hS2SYLYwrMTWVKazklo8NvPNfwUevP+Vn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740125810; c=relaxed/simple;
	bh=weJUJ3fPuJU9DLeRP0j6W3tRrrskH48SbMl4m5cAnhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EmGBmlNFJ7pysUzQhWVypzaN1abedLwzqrG9Y+5TwWxrKFx4BXfJiJyOlc39i9r+ZhzKovKzcfiMlOYa+yctIduJO5v5uJD06w3aAT2Bvzxu2JW/RKV8C3kvy/s+dqZjfZws3X/03EldyELw3iQUCaBaWD8lV0/+cE/xrtHWV7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QNYB9Bbs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uykmNX56; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QNYB9Bbs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uykmNX56"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B0E1114013A;
	Fri, 21 Feb 2025 03:16:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 21 Feb 2025 03:16:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740125808;
	 x=1740212208; bh=Y+3vYtdSMjoe+06f0Ccq0R+75EluMylVjwGbBmm2Hj4=; b=
	QNYB9BbszPL7iDT5b3SYrUcfPNpz63GRAzxOr1aiGER3x94/4RkFP9BasHncDXy9
	NIrWOMTOfzkTlEfTQLUU/LTjkzDTZafr5KDPK1oK1pL6mJeSMlmCigSVDL2BmE5J
	Y2viOr6KSJquwo49jhJ9uIpiUTKUPvXIZjPrQODntwsgLLESBaBkMUDt4Cw9L3uP
	m63WqIwnSkyyrOkLifT+5nF5XIm/p8zWfgIVpFh8KO2SAMZUcGMMwcT0brb5lc4z
	rrKJqnCch9vqnCcNg5Ac/fo8K2MOtPKoqUV/T6QM5KxDS2kkU4fO2pOEccVelOVq
	0z5WWLhz2FjxUaGZr+eXPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740125808; x=
	1740212208; bh=Y+3vYtdSMjoe+06f0Ccq0R+75EluMylVjwGbBmm2Hj4=; b=u
	ykmNX566UvgxxIIRrki1YLN7Noz867aMpJNW4jMVMvHmcbi45MunxoUK+RqWoyLp
	ZbZwxWxdBKBPnF6km5/69weLe9djruEeR51igExk8UxbJNIrhA1CYvs8XuL1mglZ
	QnM0bsgypgkCZHBSPWm6D34SnkSa2A1gElDglC9CrXnzSblrLCarS1gwcbRbUJOT
	FTiXDFqNwWCAzC/pIM35cFJlIBcmgilvHSY066OBoZGw0+3PMFMBVyLQfIaT8FFb
	1TEpHtAUq0fxB251pMUT7TseuWhDOZxLxCP6irE/Bikyp7SRgWhEA8GGVoLUjIM1
	T3ggAWWNO+l3w1x6n0Szg==
X-ME-Sender: <xms:bza4Z5z_WBfWWUfqz1nEdnynC3wladsohC86xYtcfBoxBo-kWog0Nw>
    <xme:bza4Z5QZURrr062Siamx3Wp_B8VYWOzQP3SEKumw73iWhX3N3mp-ZgWUEEWpyj_i1
    7LBJoUX0tyZ9NyqQg>
X-ME-Received: <xmr:bza4ZzU0U_UhV1LD60CYGZSgQY364LoZaMzaRLvC46Wq0dGLinUO-HOU9EcM9-UO0BVcocK5yfdkoTPtF6Wg1oVi3uKhnc87L3nbqJoZCfxFfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepteehffdvtdeltedtteeuueekudegteetuddtgeeu
    ueekteehfeeuvedviedttdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsshhmrghnsegt
    vghnughiohdrshgvpdhrtghpthhtohephhgrnhihrghnghdrthhonhihsegshihtvggurg
    hntggvrdgtohhm
X-ME-Proxy: <xmx:bza4Z7hEFJHo32Aep_rLLHPjx654utBiFSG422G3G4Bq7fV0iv5crQ>
    <xmx:bza4Z7BWQiHYLCFXGh-ngU1U8Ermc3NWQjGnsQxM4tBLeRnwCnU1dQ>
    <xmx:bza4Z0KlR87hBuNxAF5f-O__GkAW6FJ-a5uHqE5e1ntgqoQw0pbDjg>
    <xmx:bza4Z6A6cDpyTA9ICdFAK3EvOqI5_RCmNwYXHfJkD_8HFoXEYxLP1A>
    <xmx:bza4ZyOxEt18clF1ZXBzy7UVrwmE478HhGBDVBwH4-hylnSKxgKWOgkW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 03:16:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5e5676af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Feb 2025 08:16:44 +0000 (UTC)
Date: Fri, 21 Feb 2025 09:16:40 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Pierre Ossman <ossman@cendio.se>
Cc: Han Young <hanyang.tony@bytedance.com>, git@vger.kernel.org
Subject: Re: [External] git keeps recreating packs, exploding backup
 increments
Message-ID: <Z7g2aEpEboL5mvRa@pks.im>
References: <1524b9a5-6f8b-4537-ba6b-bdfdd4b1bdcb@cendio.se>
 <CAG1j3zGmA30w545+-6qFV6x+3HvM+fueYH-rv-_gaSTpZStMHg@mail.gmail.com>
 <ba212d4e-32c5-472a-8604-2a2653bde17c@cendio.se>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba212d4e-32c5-472a-8604-2a2653bde17c@cendio.se>

On Thu, Feb 20, 2025 at 09:26:38AM +0100, Pierre Ossman wrote:
> On 20/02/2025 04:03, Han Young wrote:
> > On Wed, Feb 19, 2025 at 5:58 PM Pierre Ossman <ossman@cendio.se> wrote:
> > > We tried gc.bigPackThreshold in the hope it would force it to reuse
> > > packs better. But all we got instead was duplication. It still creates
> > > new packs with everything. It just stopped removing the old ones.
> > 
> > Is the repo partially cloned? git-repack will always pack promisor
> > packs even if it's a keep pack. This patch would fix it
> > https://lore.kernel.org/git/2728513.vuYhMxLoTh@mintaka.ncbr.muni.cz/
> > 
> 
> Yes, the big offender is often partially cloned. So that could be part of
> it, thanks.
> 
> But we're seeing it in other repositories as well. E.g. I have a long-lived
> TigerVNC repository where the biggest pack file is just one week old. In
> that case, it's merely 21 MiB, so it's not a practical issue. But it does
> show that git keeps replacing it.
> 
> Anything I/we can do to shed more light on the issue?

Well, one of the interesting things to learn would be how often you end
up updating those repositories. You have discovered "gc.autoPackLimit"
already, which determines when exactly Git is going to repack existing
packfiles into one, and mentioned that it doesn't seem to help you. But
whether it does or doesn't help really depends on how frequently you
gain new packfiles in the impacted repositories.

When you have fast-moving repositories and developers fetch several
times per day, then it is quite likely that they accumulate multiple new
packfiles per day. And thus, it's not all that unexpected that you will
have to repack the whole repository rather regularly. If so, this is
working as designed. You can tune the parameters for how often Git will
do an all-into-one repack, but also have to keep in mind that the more
packfiles there are, the less efficient Git will in general be.

That being said, there is an alternative: Git nowadays doesn't use
git-gc(1) anymore to perform auto-maintenance, but instead it invokes
git-maintenance(1). And that command allows the user to pick what tasks
should be performed. By default it uses git-gc(1) under the hood indeed,
but you also ask it to not do so and instead use an alternative
mechanism to pack your objects.

The alternative would be the "incremental-repack" task. This task does
not use git-gc(1) with its incremental/all-into-one repack split, but it
instead uses git-multi-pack-index(1). git-maintenance(1) tweaks the
`--batch-size` parameter of `git multi-pack-index repack` so that it
typically doesn't have to repack the one large packfile, but combines at
least two smaller ones. I use a mechanism like that, which I've
configured as follows:

    [maintenance "commit-graph"]
        enabled = true
    [maintenance "gc"]
        enabled = false
    [maintenance "incremental-repack"]
        enabled = true
    [maintenance "loose-objects"]
        enabled = true
    [maintenance "pack-refs"]
        enabled = true

I think this strategy still isn't quite optimal, as nowadays we should
probably make use of `git repack --geometric` instead of manually
computing batch sizes. This would ensure that the packfiles present in
the repository form a geometric sequence regarding their size, so you
end up repacking the biggest packfile very infrequently. Such a task has
not been implemented yet, but it shouldn't be all that hard to do,
either.

Patrick
