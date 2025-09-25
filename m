Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3241280308
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 06:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758781517; cv=none; b=Qd/8x1v9LRwu2//PmsQottBwrA6d1F7apQXexeUYex8F/Se40H7yuwSLQ1JRDlHRvYFTlTQnjps7g9OksmxRxovIVmMg5EKfV2AduKHEwI0t9kBf6Jc0ZEWoTZAGWg4J2pHXdccHkFJRhuYtElHGzPclpCciuQbkbluBUSbMx0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758781517; c=relaxed/simple;
	bh=rJSoGc44zLH+Mu25F1v9//gReOuum9ng6ZI0vY6oVjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwqYpWqxWJt2+jUEmm+MyxLWgOrMr4YCDOjyvA+Z+oARS2Jlv/k9cqZBooSaNLbf3980x7NMS3DEUyfcTn7thQS/U8sRKYPGKlugYCaS/eWCL4YpLVCPWQMt/F49vfWJW1V8l/Vq9AbdWDpelCXAslC0BNtGpqRZ98p3B64P654=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D7PnIDqu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bywvcChG; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D7PnIDqu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bywvcChG"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B90F17A0088;
	Thu, 25 Sep 2025 02:25:14 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 25 Sep 2025 02:25:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758781514;
	 x=1758867914; bh=cqWhxVX6Skf6VgsN5CYUdb3B3PwyNtcNmDZbk0mkZUs=; b=
	D7PnIDqudiSo2l/bH6JcxSVU7aVyPFidVk5F6pZW+NBVZfWsHq2GJpP7Siv1tEV9
	6zrG75800C18NBwykSfvPKco9w2qJBIyi9uqojJ9Z8R3VGhv3UxCkSo6Ko37TEyA
	Yzu0c7fRPLinQ+4dgB5HdgiRGH+ZTSdsLmji9C7KNQpislAJRrBp0UX3/IoyKlgW
	6atC6OuFlgTTQB0it0nhaBv1lmAaxeFRXi0y/CkzCYOA1N0ule7y7eSfZzrsFKLM
	FpXKUx+NgdbvkNrs0QuZItD8F5DvCxPtheMrCpG1DcQBeXX6vPU8enfqU30n6j60
	9zOLY9ikzYiZqdohV43shw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758781514; x=
	1758867914; bh=cqWhxVX6Skf6VgsN5CYUdb3B3PwyNtcNmDZbk0mkZUs=; b=b
	ywvcChG9YiiX/hzHGp7NKKMNb+S5QOjIFmW1HVJll71ua5AecjC1zi2VwnYNfKr1
	KkwYNFSGUfjvEEaohNKs0fyRcx5VENXmEdPalSHeF07pmoR6QxaTJRSVeI7ljmep
	JYWBJQEVeynfSulS/7VwkWJVRLata/rY83F7dc6NPVFG12iNoucTF8xt00Qw077K
	Oao2rHRj1dyj6Y1U2UeurV9M1qZjUl3+Ru8dOoYXfvIgkIyGr1dbtqdlCQRFeAYK
	ICW65RozVggMqjLpPXzVjiXjQ9hUpBW8XgMOPsehJUBq5zzJD60aOI5zD16WZ4WO
	riH1r3CykjuaDg7f/y4xA==
X-ME-Sender: <xms:SuDUaOK88kCRhan0E38j7j00W5yE4Elt2T9k4Q0-xgV7R9ctWk53vA>
    <xme:SuDUaNBekvTxOMCX587cSs9W42qCFU9ofzQZ96NCV6Ln4rQADYIbbvJVK34nwanxb
    MMpXd126Hq_oG2KFtUCiSdYR08ERca-OgUPtYHCspU6edwcI9lt>
X-ME-Received: <xmr:SuDUaHDRUw5UfiaKm-bpIp6MYexBrgWPsfdOjCijX3ORIFmUCHe1QeK-BMz9ZCY1pG7HCF1ToW7AQAl5l0-L6Q4VdvDU1HGk4YLgJAb3JKM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeiheejjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeejfefgieejleetvdfhjeffkefghedvffegjedvieefgfevhfdugfeggefgteefnecu
    ffhomhgrihhnpeigkhgtugdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepmhgvvghtshhonhhifedtudejsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:SuDUaPD2uyBAjlbPVmw44e1FB1zYoC1eRTxOZYb0RtVwraYZHlhxmw>
    <xmx:SuDUaCqBOcoYsoSGkAzN0migjHnHhU8U7xCeISSJK8D3PIpp14bN0w>
    <xmx:SuDUaJkUPEeZi6KUERdwXXPX5K7EV_iWk1r4cqJgMaawMhC37g9sPQ>
    <xmx:SuDUaCyDW1Dbm-NPW6k9XioNHSc9MZUc_0tIqDpkJgQXSg4la7bFqA>
    <xmx:SuDUaCRl6nQZeHlkW3--kkO6k-WsGGqDQQ0LAxcO4QFrPmZFJ54Dg49t>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 02:25:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71c7f532 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 25 Sep 2025 06:25:11 +0000 (UTC)
Date: Thu, 25 Sep 2025 08:25:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ben Knoble <ben.knoble@gmail.com>, Meet Soni <meetsoni3017@gmail.com>,
	git@vger.kernel.org, shejialuo@gmail.com
Subject: Re: [GSoC][PATCH] builtin/refs: add 'get' subcommand
Message-ID: <aNTgRGeaPajVz1dv@pks.im>
References: <aNOQhncjwYCwCaZ3@pks.im>
 <4FEB2B85-FC32-4076-9DA6-F47AAB096CB0@gmail.com>
 <xmqq7bxnn5cj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq7bxnn5cj.fsf@gitster.g>

On Wed, Sep 24, 2025 at 10:11:08AM -0700, Junio C Hamano wrote:
> Ben Knoble <ben.knoble@gmail.com> writes:
> 
> >>> Perhaps "show-ref --verify --no-deref" or something that does not
> >>> dereference but works directly on a symbolic ref?
> >> 
> >> For now: yes, it's more difficult to discover for sure. But users will
> >> adjust over time as they get more familiar with git-refs(1), and from
> >> thereon I think it will become significantly easier to discover that
> >> subcommand.
> 
> But unfortunately, that is a tautology, isn't it?  With the same
> effort to advertise git-refs to make it more familiar to the
> "users", you can make "show-ref" familiar to the same "users", and
> problem solved, without a need to do anything to "git-refs"?

I don't quite think so. The problem is that we have so many different
tools that relate to refs, and you have to remember all of them:

  - `git show-refs --verify` to read a single reference, unless it's a
    symbolic reference.

  - `git symbolic-ref` to read symbolic refs.

  - `git show-refs --exists` to check a reference for existence.

  - `git show-ref` and `git for-each-ref` to list references.

  - `git pack-refs` to optimize references.

  - `git update-refs` to update references`

I'd claim that this is quite hard to remember. So...

> > I think this goes to perhaps some of my unasked questions: who is
> > the target audience? My experience suggest that most
> > mostly-porcelain users don’t acquire familiarity with scripting
> > commands, so it sounds like we’re talking about script-writers
> > here (and in the commit message).
> >
> > But how do we encourage script writers to discover these things? 🤔 Hm. 
> 
> Great question.  I understand what the patch author is trying to
> achieve (i.e. "consolidate ref-related functionality into git-refs",
> which is the title of GSoC project [*]), but what are we, as Git
> project, trying to achive by "consolidating"?  I often cannot shake
> the feeling that it may a make-work job without a clear answer to
> that question.  Or perhps xkcd.com/927/?
> 
> Perhaps the hope is to have a single kitchen sink "git refs" command
> that does anything related to "refs", so that they only need to
> learn this single command (and unlearn all the previous experiences
> they gained) and after that, they do not have to "discover" more
> things?

... yes, this is exactly the goal of this exercise. You basically only
need to know about the entrypoint git-refs(1). Once you know about it,
you don't have to discover all the other commands, as it is now way
easier to discover what ref-related functionality you have available.
You can easily use tab completion (well, once it's wired up), type `git
refs -h` to learn about evertyhing refs, and we now have a single
manpage that will tell you everything about ref-related use commands.

You could partially address that problem by providing a gitrefs(5)
manpage that gives an overview. And maybe that's still something one
could do, also to paint a bit of a broader picture. But documentation is
only part of the solution -- with git-refs(1) we get some "natural"
discoverability.

That's also where the "git refs get" proposal comes from. Sure, you can
use `git show-refs --verify`, potentially with a `--no-dereference` flag
if you want to read normal refs. But I would claim that this is almost
impossible to discover without searching through our manpages.

Patrick
