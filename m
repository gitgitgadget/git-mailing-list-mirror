Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB7E30497C
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767786184; cv=none; b=VZXOg7/ge+Zy7z5xYVaW40NOf/0l7N/zwuSrztQuzQfoz37vSbwvgtMjbX3YJA1bU4bngwMA7aeP+zPBzx4Qn298FRB1AR3Wpwut35K58DpK73KiWcO23L3haCE3GwVOjj9x5HOm5C9iuxPyutt/mPG/YS7VuQC08Z76dYOOykk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767786184; c=relaxed/simple;
	bh=PH+NuRm3FMsavaOBwYO0PUHBI2Tt/G9cWyTBwGwCcLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gvFbTiyOfEHTd2POnnjvETj2Rq38ci9KN7R8hEddd0Mp4EeA4ZSxgFZ/yIhHQ5fHDTLSJ3yaceY8KWx9WTXVY60qQ/zB8sUw++CTNs2Llnauvp/2QaSTfPFeK3VkOqigefrsd6HgaeaN/C0E8NgQOWQsrf8UAKRJGYCllqJu7yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XkunrYjT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EvP25I1v; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XkunrYjT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EvP25I1v"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 7035BEC0064;
	Wed,  7 Jan 2026 06:43:01 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 07 Jan 2026 06:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767786181;
	 x=1767872581; bh=W/bwMOxZ0793i2psDZNWr61KIicl+HQF8RZp05QV8rk=; b=
	XkunrYjTJryfUw2hrBBlaMoMQXzWoFGcYLTrKSYcPb0MeAny/x8weW7p8i/jFWLn
	O+sc9eepquInE2AtcTWbD1unSMvvtVBN4NQda85L+MruWs/LnUjBaMvR0UXpxaH7
	zzIrbktaF9yW9l1pqRWfReae4Gxz1aF+ZvoLF2A85x4kjNG1KibOlbUPoSuM4f2J
	IE2ZLZ0YNW9dCiJMCXehPUWmnuPnaDtIkJ50uJ+xd5o4Gd+5AIcSvgJVYoIIJ2X9
	NJYWPiW+zdFUnQG/TsPwSYugwUp487kAr5007XKfwsXrQopEvtIA1Cz03tokS1OM
	jwy54lzlX7c7kY6Oo/tayg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767786181; x=
	1767872581; bh=W/bwMOxZ0793i2psDZNWr61KIicl+HQF8RZp05QV8rk=; b=E
	vP25I1veBHXFjZ8qrK7omRKRzavxQUtaFeaIQuW2NsnDZlKzMMm6KJ/q4JVhfwH6
	yvZ0SeYWh6NgBniA5Sy6LFhUvcVxTODNTVpkEcqttEWjUO6tA2QA4/nN3OLQWG/y
	sqswJsQg5LB9HLq3yx4qI8jmuPMTMXjBif3a8UFxoD/44uTrKYHj8YhssWWAb0Kb
	qgo0voGpaFvYzcOGJfV0f8CCTdewWGbBNAP3JmOHF7NDwVNGoy6rOvJFGR+azLwL
	/u5mnIOsZKi81tUddrPmu+g+Yp14orNMjoQGGwAk/WggDHAxiuayLhIkhxQXiI5w
	nrc7f231/wmnIdUCQbkjw==
X-ME-Sender: <xms:xUZeabKYjYz9xU65Sw3p5eOa-0uHbccGziCinSAoTu8nQ9HOdXvUPw>
    <xme:xUZeaWKwwJL4NMDo04HLiMwFfSSZwxdeVC-0gkEPIUqt6xmFL3KFrgvyeLBiC8hXn
    Y1MmLW4A-Zsh8-H0ug2qd6u1e_ipd3xkzm8FjIZmagkiHrmFVuR>
X-ME-Received: <xmr:xUZeaYszxZ4g4jFYs2yskxv5vZ4C3it0qdxrXv3MX3HtB7q-XWBlfoEZN3mzfZiCVUGZxVaJIpkLg2YgminqU7KI2oBIHm4jGJTRZhE1UO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmfhhitghksehnvhhiughirgdrtghomhdprhgtphhtthhopehsrghnuggrlhhsse
    gtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:xUZeaTTiia3hq0iTtpBlontaTi1OD0VSmFU18e3r7JDX-398R4WdFQ>
    <xmx:xUZeaeM9IRLnOF9IePzIIft7g1MFFaUk1-6MBlXtQ5hs1zCr1rePtA>
    <xmx:xUZeaYaZm8tN-XJZIYzyoUDO96BySjZInAH5fokl001LIK4vFAB14Q>
    <xmx:xUZeaYzVocDHmS6ob-YM-M94yFlFn7ikug2aEqu4OtTLYeo7PIlPaQ>
    <xmx:xUZeaWrh2R70t6GMdf4mOrZ9uKe2UUo1BWs5xgfb8ru61duaeuSXOS61>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 06:43:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f4ef591c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 11:42:58 +0000 (UTC)
Date: Wed, 7 Jan 2026 12:42:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Martin Fick <mfick@nvidia.com>
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Slow git pack-refs --all
Message-ID: <aV5GwOS_N2jyIFaz@pks.im>
References: <CH3PR12MB9026B5872FD42F031970074BC2B3A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aU3K9lGbHw68Vv5U@fruit.crustytoothpaste.net>
 <20251226044507.GA1971832@coredump.intra.peff.net>
 <CH3PR12MB9026DFCF7AF4ED1A249B16A5C2BDA@CH3PR12MB9026.namprd12.prod.outlook.com>
 <20260102074901.GD2581074@coredump.intra.peff.net>
 <CH3PR12MB90260C4887067C88629BBE52C286A@CH3PR12MB9026.namprd12.prod.outlook.com>
 <aVyxbqk-2QQIgDXK@pks.im>
 <CH3PR12MB9026F1E4B99D32E138800EEBC287A@CH3PR12MB9026.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB9026F1E4B99D32E138800EEBC287A@CH3PR12MB9026.namprd12.prod.outlook.com>

On Tue, Jan 06, 2026 at 11:02:19PM +0000, Martin Fick wrote:
> > From: Patrick Steinhardt <ps@pks.im> Sent: Monday, January 5, 2026 11:53 PM
> > On Mon, Jan 05, 2026 at 11:45:41PM +0000, Martin Fick wrote:
> > > OK, after discovering the strace -r and -T options, I have determined that
> > > the 29K writes were all very fast in themselves. However, most of the
> > > writes seem to follow each other with no other system calls in between.
> > > This explains why it looks like the writes are slow, even though they aren't.
> > >
> > > If I tally up the time between the previous system call, and each write(),
> > > it adds up to the bulk of the time (4mins out of 4m15s) that it takes to
> > > pack refs. This tells me that no visible I/O or system calls are the problem,
> > > but rather that the program itself is taking a long time between writes.
> > > I very much doubt that this is heavy CPU time, but rather I am going to
> > > guess that this is hidden system time spent accessing mmaped memory.
> > > Could it be really slow reading the packed-refs file? I can see the
> > > packed-refs file is mmaped() before the writes start, and then
> > > munmapped after the writes are completed. If I had to guess, that likely
> > > means that the packed-refs file is being read in small increments by the
> > > kernel via mmap, and that is what is making things very slow over NFS.
> > 
> > I wouldn't be surprised if NFS was the culprit. At GitLab we found it to
> > be a constant source of issues, which is why we eventually sunsetted the
> > use of it completely. Do you use any special flags for mounting the NFS
> > filesystem?
> 
> I am open to alternatives to NFS. Do you know of any NFS alternatives that 
> provides instantaneous replication to potentially hundreds of mirrors? I 
> have used Gerrit and git-daemon for many years on NFS, and it generally 
> has performed very well for us, and it solves many real performance issues 
> which I have yet to find a viable alternative able to even come close to
> matching. NFS with all it warts it is for us (and likely will be for many) until 
> there is a viable enterprise ready alternative with low (zero) replication 
> latency and high throughput.

Yeah, agreed, NFS can get you a long way, until you eventually start to
hit some road blocks once you reach a certain scale. Unfortunately
though, there isn't really a ready-made alternative solution that serves
your needs, or at least none that I know of. That's why GitLab
eventually settled on Gitaly Cluster with Praefect handling replication,
and why GitHub has its Spokes architecture that does basically the same
thing.

> That being said, NFS can cause many issues. In this case, I would say that
> something is particularly "broken" here with git, and I believe that it
> would be helpful to the git community to be aware of this fairly specific 
> broken case which clearly has a lot of room for improvement (as seen
> by the fact that jgit, in java, can do essentially the same thing more 
> than 10Xs faster). While I have been mostly assuming that this is a 
> particularly specific bad case since git daemon generally is fast for most
> users, this might actually be something that if improved would greatly 
> improve many parts of git (not just this use case).

Chances are that if we can improve the case for NFS, other filesystems
might benefit, as well. So if this is something that we can improve I
agree that we should. It's too early to tell though, as we don't really
know what the actual root cause is just yet.

> It would be nice to improve git to not hold the packed-refs.lock so long 
> to avoid this blocking behavior on servers. Of course, to be fair, this 
> likely only blocks Gerrit servers since Gerrit uses the packed-refs file to 
> perform atomic updates for many things, and most other servers use 
> loose refs instead. It would be great if git were optimized to avoid any 
> unnecessary reads while the lock is held.  In theory, almost all of the 
> data that git needs to read here (including tags for peeling) could be 
> read before acquiring the lock, and it would only need to double 
> check certain reads after it acquires the lock in case things changed. 
> That wouldn't make git pack-refs faster, but it would drastically 
> reduce the impact of any problematic I/O by not holding the lock for 
> almost the entire operation.

It can probably be improved, true. I think that it's a bit of a wasted
effort, as I'd rather invest the time into improving reftables as a more
future-proof solution. But as you are well aware I'm quite biased here,
and I'd welcome any efforts to also improve the files backend. I am just
unlikely to work on it myself :)

> > Did you try using perf(1) to profile the process and generate a flame
> > graph from it? That should likely make it immediately obvious where Git
> > is spending all of its time.
> 
> I will pursue this. Unfortunately this might be difficult on this 
> particular server.

True, on the server side this can be a bit tricky.

Patrick
