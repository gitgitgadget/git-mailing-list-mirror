Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD5E201035
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 08:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127707; cv=none; b=mqi3HFapdXFF/GIQwHJZxD37WeEoJKxx5gfERXFKG+Wobil/5l+X2YzBCaxfLaLS7Ty66g0ADiNu3RKaL5mxygeDMNh10PR3sVCYAw9kD2U7zJg0Yzf7w+XycjKXhg381FgYcAYHS2iEvpKu4dQtntPfu9HQ8CfIt50szZRQxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127707; c=relaxed/simple;
	bh=mDLkiWEPSaBKPpEEcPzpVD3QaH9cqOEZdiugQ4xHGYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKZhaJ60efJHgX370pTjbDSaTSH187anCpYo8FekJ+M0oWaHyuyhb4WOX69RhkxhamCxCxbXygACqB4H/8vV8SmqOZjsZrpNKwl6ScEKGxg43T5JGaGVpv4MLPdCQmxLXLSzwMpAcFt/oO0/zKs3ipeEdY+h6fcCshGLBgr+k/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D8RIrC/q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xdOx0VkH; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D8RIrC/q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xdOx0VkH"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DEFA62540244;
	Fri, 21 Feb 2025 03:48:24 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 21 Feb 2025 03:48:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740127704;
	 x=1740214104; bh=k7NMV3AnzN60QLzyOB7XFLEuFciI/ufacxErXAevr6A=; b=
	D8RIrC/q1vdiQAseU7BvZajmc/OI4ygTgPvfi2WZde71bU/vgG8FFL7YMU9DrOcN
	lFaBykZ9wuVV4dTlBLLNqc0DcZYYR3eK+tD6Vw2oRJLKdNA8c2FyCoNBAHeS1hcG
	N+I6D6KX1ODg8Q8O/0bANrVToj2IIBos6oJe4uFQSjfR7kOAiKNPsq+A+JTAG1yM
	FLyL/KI7nIKtIu7664Gy6+z7cMFQ8o5aG7rFRg/saxKZGJHjIbHXikRqHqR47Pzy
	sD9H8WtPzBv3LdV7Jp9Ucyu2WzOZDV0jEU3wHUX6EH2sUN3jM+7oHqr1r080mzEK
	SsSNDm1aH91yfPRAxdsTdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740127704; x=
	1740214104; bh=k7NMV3AnzN60QLzyOB7XFLEuFciI/ufacxErXAevr6A=; b=x
	dOx0VkHQ3SzT+p3391gv8wQu/iTYKCfR4jNU64TgYGg8KiHm3uoTkWv6Nn90G25O
	1anAvtYgpf8TTZXOUP3BCVyZPO040+rVJ2ItYMGfY5IZ1+ZIjy3uFwUKbGIkaWJF
	/JtfmUyygIirPSxofCsNT5V7bv4mwWYUwMu3SIzLdMxr/tpbhpCO/AIpmtuBVzm7
	9oy6zx2Ob8YLdBNNy0i1tmNBDY0BRAb4mdHiRUPawBxYneY1IzsevPXW1Tw8yvfs
	4y6a8qy+bSwiWJjjtOLArhPV/1ZtVVyjnvQqmCp+AWjZEPsxiyCgK4+rWONS1Rmh
	Iu6z2yq39sJGCNk7O+33w==
X-ME-Sender: <xms:2D24Z6S8VZozVoVfwbCVGYaASI7psyGqzC-ePr23gD6vMZmwcLnqhQ>
    <xme:2D24Z_zFIiWB9lY5PPh8HIjFx-4u2oxOCufDT2q2mUmBdFJ1wzXg4JpdpClST-jaj
    TfPAMp1umvUy7Oykw>
X-ME-Received: <xmr:2D24Z30MXxFcemhK1hlEtoa3zCwDzCoMCPqdHd_RqIhbwbm9kX5trK3cgcJ9sTtJrxvwFvAOlQxOoQRDdmfl3KHVzUHWw02FVuVmie9KZwjeew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeileehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvf
    evuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfeejie
    dtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehnrghs
    rghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:2D24Z2AL0Pi18twJAj1UFlwCj69LGLggwf8FTpS2OOc8aayJ0AK33g>
    <xmx:2D24ZzjckNPYF_W-vcCxPGGcBr08Sl-j0r49i0c-iU6bCtqwjNAF2g>
    <xmx:2D24ZyqwDk-lOaBXLPBWQ2835F6Kx5C9mU8FwvJBdCE3WUyBHusTfA>
    <xmx:2D24Z2hP3CDSdtwF2NHmqmxVPoeob2LKQA9nKtYptMzhpRxlQZ-9wQ>
    <xmx:2D24Z2s4VpceNyvXU6KbRqDx_AQmnAwlX0nDW0WsuDVZKiEKsNG0kxBM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 03:48:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 332e26e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 21 Feb 2025 08:48:20 +0000 (UTC)
Date: Fri, 21 Feb 2025 09:48:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Emily Shaffer <nasamuffin@google.com>
Cc: git@vger.kernel.org
Subject: Re: Continuous Benchmarking
Message-ID: <Z7g90CMEiy-skRKK@pks.im>
References: <Z6CSc_vyGkn-ozUH@pks.im>
 <CAJoAoZmJAM--FVmhxs_0sL1A8yrLwNBFULPDYFgV=AtFhn67+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJoAoZmJAM--FVmhxs_0sL1A8yrLwNBFULPDYFgV=AtFhn67+g@mail.gmail.com>

On Wed, Feb 05, 2025 at 03:14:21PM -0800, Emily Shaffer wrote:
> On Mon, Feb 3, 2025 at 1:55 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > Hi,
> >
> > due to a couple performance regressions that we have hit over the last
> > couple Git releases at GitLab, we have started to set up an effort to
> > implement continuous benchmarking for the Git project. The intent is to
> > have regular (daily) benchmarking runs against Git's `master` and `next`
> > branches to be able to spot any performance regressions before they make
> > it into the next release.
> >
> > I have started with a relatively simple setup:
> >
> >   - I have started collection benchmarks that I myself do regularly [1].
> >     These benchmarks are built on hyperfine and are thus not part of the
> >     Git repository itself.
> >
> >   - GitLab CI runs on a nightly basis, executing a subset of these
> >     benchmarks [2].
> >
> >   - Results are uploaded with a hyperfine adaptor to Bencher and are
> >     summarized in dashboards.
> >
> > This at least gives us some visibility in severe performance outliers,
> > whether these are improvements or regressions. Some statistics are
> > applied on this data to automatically generate alerts when things are
> > significantly changing.
> >
> > The setup is of course not perfect. It's built on top of CI jobs, which
> > are by their very nature not really performing consistent. The scripts
> > are hosted outside of Git. And I'm the only one running this.
> 
> For the CI "noisy neighbors" problem at least, it could be an option
> to try to host in GCE (or some other compute that isn't shared). I
> asked around a little inside Google and it seems like it's possible,
> I'll keep pushing on it and see just how hard it would be. I'd even be
> happy to trade on-push runs with noisy neighbors for nightly runs with
> no neighbors, which makes it not really a CI thing - guess I will find
> out if that's easier or harder for us to implement. :)

That would be awesome.

> > So I wonder whether there is a wider interest in the Git community to
> > have this infrastructure part of the Git project itself. This may
> > include steps like the following:
> >
> >   - Extending our performance tests we have in "t/perf" to cover more
> >     benchmarks.
> 
> Folks may be aware that our biggest (in terms of scale) internal
> customer at Google is Android project. They are the ones who complain
> to me and my team the most about performance; they are also open to
> setting up nightly performance regression test. Would it be appealing
> to get reports from such a test upstream? I think it's more compelling
> to our customer team if we run it against the closed-source Android
> repo, which means the Git project doesn't get to see as much about the
> shape and content of the repos the performance tests are running
> against, but we might be able to publish info about the shape without
> the contents. Would that be useful? What would help to know (# of
> commits, size of largest object, distribution of object size, # of
> branches, size of worktree...?) If not having the specifics of the
> repo-under-test is a dealbreaker we could explore running performance
> tests in public with Android Open Source Project as the
> repo-under-test instead, but it's much more manageable than full
> Android.

The biggest question is whether such regression reports would be
actionable by the Git community. I often found performance issues to be
very specific to the repository at hand, and reconstructing the exact
situation tends to be extremely tedious or completely infeasible. I run
into the situation way too often where customers come knock at my door
with a performance issue, but don't want to provide the underlying data.
More often than not I end up not being able to reproduce, so I have to
push back on such reports.

Ideally, any report should be accompanied by a trivial reproducer that
any developer can execute on their local machine.

> Maybe in the long term it would be even better to have some toy
> repo-under-test, like "sample repo with massive object store", "sample
> repo with massive history", etc. to help us pinpoint which ways we're
> scaling well and which ways we aren't. But having a ready made
> repo-under-test, and a team who's got a very large stake in Git
> performing well with it (so they can invest their time in setting up
> tests), might be a good enough place to start.

That would be great. I guess this wouldn't be a single repository, but a
set of repositories that have different kinds of characteristics.

> >   - Writing an adaptor that is able to upload the data generated from
> >     our perf scripts to Bencher.
> >
> >   - Setting up proper infrastructure to do the benchmarking. We may for
> >     now also continue to use GitLab CI, but as said they are quite noisy
> >     overall. Dedicated servers would help here.
> >
> >   - Sending alerts to the Git mailing list.
> 
> Yeah, I'd love to see reports coming to Git mailing list, or at least
> bad news reports (maybe we don't need "everything ran great!" every
> night, but would appreciate "last night the performance suite ran 50%
> slower than last-6-months average"). That seems the easiest to
> integrate with the way the project runs now, and I think we are used
> to list noise :)

Oh, totally, I certainly don't think there's any benefit in reporting
anything when there is no information. Right now there still are semi-
frequent outliers where an alert is generated only because of a flake,
not a real performance regression. But my hope would be that we can
address this issue once we address the noisy neighbour problem.

> > I'm happy to hear your thoughts on this. Any ideas are welcome,
> > including "we're not interested at all". In that case, we'd simply
> > continue to maintain the setup ourselves at GitLab.
> 
> In general, though, yes! I am very interested! Google had trouble with
> performance regressions over the last 3 months or so, I'd love to see
> the community noticing it more. I think in general we have a sense
> that performance matters, during code review, but aren't always sure
> where it matters most, and a regular performance test that anybody can
> see the results of would help a lot.

Thanks for your input!

Patrick
