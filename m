Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797B1311C1B
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 07:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768289456; cv=none; b=utLQGGDoFYQdUeEdw3Oxctm8YeVpwG1jS2MMEazmDrWsMdcx3sm8k6K8S1qtZd/1FyqADKVeEYPIY5zcUtreLZ310Ixo9J8Aa0mqF3nSm4RoXSAG6K2kAupD/d62TJ0Dd/c9zYGqSur42Ug6Nx6anQ7BgZiIqpPzLWXUfKzACdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768289456; c=relaxed/simple;
	bh=Rh7P29JZlCPCeYcBJZwDdWq8OEnkRBFQlNi+fyUDdqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5YoC1wvNPfZYrRnK7+4xkqxeyVuXejenUsqYVlHBO+ShdYIil/Lxi8W8hIxGIDGc11ETLXW82nF0laOYEwvNIgMy/vUqGM6lrDxB0ruUDYIEvbg+dSusd4BT8tEE5AzQrFcORqM7Kl1sIlGVdVVRN2CTy7x2aQB71oHvzhe67w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WzULR5wQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rtv8rXul; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WzULR5wQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rtv8rXul"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A57741400045;
	Tue, 13 Jan 2026 02:30:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 13 Jan 2026 02:30:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768289454;
	 x=1768375854; bh=UAn2xWD34y8C07D3jt8pBf1hPu1R0DpTYgetYaC2Fck=; b=
	WzULR5wQH9UChpK3ZXIFYrXBImoIbhZDZq7e6k7f8I9X/GI8wa20/jkmtpWqIjzh
	Xgo5I2TdDLSIUgWHsuFqtynH0RXbqEVfjI1TaHWUzX0Qe5BjVZJnvx77AFcAOnYl
	QCKJiqQZFOjvSho36MVmnE8Zn8KUKdCAXJFSFevz87e9N493roES9soC82qcS8+9
	7VLuPpLjQxHN51bHVEZN3WuDqGb+zfv86X6xZ18ZC3Glj0nVdnkGn482UtYFoqis
	UYHxa7IlBFtF2kpJVwA9Bl2RIoPxzHhqWj5VKbohFS3/f6Jvn1ELBjsWdm5tNVxh
	bvf9BBHBlsvkiv/dHiBw5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768289454; x=
	1768375854; bh=UAn2xWD34y8C07D3jt8pBf1hPu1R0DpTYgetYaC2Fck=; b=r
	tv8rXulOayl2L8uqzoT+IqQBhhZgiJ5mvgJonAT16UoaKWKUmdgfn35pxH4+rni+
	Lu6djSznyb8sJYcP/uRk8+zoVVs1/eCAhjgDpMT36bS4KctEok2gqy4T/tOfO5Vg
	5fh0Ll+ca3dIQuoz56Ptig66O0pV9+15uMNB+Nodn8isuFqvzjpAshUTk7FPfrpB
	WdTSZBLc1HT9ejITp7hwvOwNpa5JAFWz30z6rEgohcI088cMcgmBARPMZMQgnqdv
	hN0VSJ53kqHQEqEYHRNqxFYDJkxURtM8OeNNU9XoQbSaia8u4fV0oYy3SNGpMFO8
	nybjJnINtc3eZnERj4UBQ==
X-ME-Sender: <xms:rvRlaQp3k2vXs-swNU-2QhoqFIyPE-ghVw1798lD__IHPPuuQAGYYA>
    <xme:rvRlaScWJnHIPjiF2Slw6uMtkOp6xg7Xrtl1jjUQDf-5XmwId-wtxtXFpn3h2DBYH
    2zfduDutO3dU8UAD5XufWWhs_5Y7dqbBUiMkLsMxJzNya_7ZUMn>
X-ME-Received: <xmr:rvRlaQmyY2vl6K-d3E6G0-hNW_UYqZAfHUHfe1fj-whjEZ9lqgJKaSrOzK0p4NxqknCjN4p5KYrCDV0uio07nwv2iQ5AvbUcGHJjfJt3Lg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudeljedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehmrghilhessggvhigvrhhmrghtthhhihgr
    shdruggvpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtoh
    epkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrdgu
    vghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:rvRlaRYhYWysS81faBtuiJXOTCvgcnlbQnlLpl1sFuWfRa3H5Kigkg>
    <xmx:rvRlad5w50P9_qlLb4HilxO_qb6nb0NPmXr9N8Vl2k_4iNTPYJ4cqg>
    <xmx:rvRlaTBUmZRE_CZ7C9a-DTL17PPuI_r63nXEqUYSBMJ1WX5GTBT-jA>
    <xmx:rvRlaT8GxQwuLefW6-3PdUmrh_cImfhQwzD7Y3SheifmXFy3eGGSNg>
    <xmx:rvRlaWqBebW4aIShKoKUMHI3_agjjImZb4N-eUbcanige-nl-7WenGXj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 02:30:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e664d7bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 07:30:52 +0000 (UTC)
Date: Tue, 13 Jan 2026 08:30:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Elijah Newren <newren@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v10 4/8] replay: support empty commit ranges
Message-ID: <aWX0qcDrBoeN64WI@pks.im>
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
 <20260112-b4-pks-history-builtin-v10-4-e3c6aa5b4cec@pks.im>
 <CABPp-BGhtPyiVT=32NXz3k8m=+ZgPziXueM4Y8+g4dAUtN9osw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BGhtPyiVT=32NXz3k8m=+ZgPziXueM4Y8+g4dAUtN9osw@mail.gmail.com>

On Mon, Jan 12, 2026 at 10:00:27PM -0800, Elijah Newren wrote:
> On Mon, Jan 12, 2026 at 6:17 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > In a subsequent commit we're about to introduce a new user of the replay
> > subsystem. With that new user, the range of commits that we'll want to
> > replay will be identified implicitly via "HEAD". With such implicit
> > ranges it becomes likely that the range of revisions that we're asked to
> > replay becomes empty. This case does not make sense with git-replay(1),
> > but with the new command it will.
> 
> I think I know what you were trying to say, but this feels misleading;
> it could be the commit at the tip of any branch, not just HEAD.
> Perhaps:
> 
> In a subsequent commit we're about to introduce a new user of the replay
> subsystem. With that new user, the range of commits that we'll want to
> replay will be identified implicitly via a single commit, and will
> include all descendants of that commit to any branch. If that commit has
> no descendants (because it's the tip of some branch), then the range of
> revisions that we're asked to replay becomes empty. This case does not
> make sense with git-replay(1), but with the new command it will.

That reads better indeed, thanks!

Patrick
