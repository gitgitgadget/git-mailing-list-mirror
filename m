Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8D0274B43
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 09:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924731; cv=none; b=V1gAHsf1T1yGMXbLIS40fPtgfB8rXru6wIV0Rqk4ryUuUg3evmvk7ao6Qp8gnXHMVPUZ1LyHmNJKSwdO8Xg5QiaulgeUrbYB+UbrJAsdNHgUA8UR6iQhmOruBjZEDlkDdKUx3J+/a69WgE7/Wjo+Q5yMLfQ13EJkZrSqvJn/ovU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924731; c=relaxed/simple;
	bh=NXpgUk7YbsHI9NzdfWemK0UDLTVZ0xkFitw8w5sLbVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H796QzdUVbZ14t4A1/L9VUJZaZb0HkAfE6XNqG4sVaSQz5gyz4Rp1BQ/wpH6mVhwZYCAm6rTj3PQmvXdZ/0Pux9dJVGXtCv5mkxLJ/7igBosraM3+VjvydFNiENePGRtjNIfrvSM9M5Bg7Ru3NpM2bL/jXJPxON5X8nem0ouusE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g/0vjswo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CG2YEeB/; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g/0vjswo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CG2YEeB/"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 08AC4EC0559;
	Tue, 24 Feb 2026 04:18:49 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 24 Feb 2026 04:18:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771924729;
	 x=1772011129; bh=tA1ChCilx+WnlxbMraTGxb0jMSA1oWf9FdQLSwGINEs=; b=
	g/0vjswomnW9e9/0W+qfbI/bbxP+5/1m9VPM+VyWaa+2nd2vA/N2ohgj6s0U/pEV
	c5WGZxG4E3NtgyM2cQ/z5eh/y2zv1Rpc1a5zI/KOr/V2rXrL8o1hqnAeIVQSLaVr
	p5L1X8LHQB+VYQKA4fefYYfeRP/4zce/srjmnmJaUheFMVx9ktyJDRXkVIfXVJVN
	fJYr0gXUTYlF8TE7mUwFoClX8xb7GkxdohRfzXXy1XRNHf8iWp7DdW57tgsFMbPF
	7SwMhUkMz9+3hkHHhzWZtZAfsv2wApHfWyDJvs+gbWQvw+Tq3uRjqYNQ8dPiL8ro
	kre+la+cYT8am2AbQ1Qq5w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771924729; x=
	1772011129; bh=tA1ChCilx+WnlxbMraTGxb0jMSA1oWf9FdQLSwGINEs=; b=C
	G2YEeB/C63FZsq+dLpOXje++9LrBGgB96hBMAuI1SEw5FMGncuPEcEME9AdC/z5I
	dqQWMuo2lemeAwp1NGIUgQCoBVYzS1Wk2vrox3E3Dzx9y/Fqmjv4HqnXMmQtGtys
	hXhqesW2/MT0gBdTeDl9u3OVVun3yLklnj1TEcabO+kKUZ3+hWzRYHndVjDhX9+r
	+04bFMGFGUHQoPTkSwR0V+4PGJIpF8Y5LJ80yC68HUB4CN4mfbeHr3XE95vtj6FQ
	fSEEStmj1iibP+SO7PHEbYTM7A1iDjdiKFkMBzZVR2DYBtbljbMXcA6td23VMilg
	4UXPE8dReIM97p9PzbPgg==
X-ME-Sender: <xms:-GydabgTxSoW5A_4fd0Wnk-uNyeny9oCCZQ3d3NWgC4OnLpCdxW-4g>
    <xme:-GydaaS5DgLVQ8cbGJdFes7nR7aSmy-BHSKJDNifsn87h-2A-Xgh1Pmg9Olr53ErQ
    TLWy-pC7yqBt5vjcBhrZPJNRRRtrq89QFKnHuEm9cSJSCyUODb5jA>
X-ME-Received: <xmr:-GydadU-gmHwxcIPEo9gtXChhWuJV6j4JXYIczdVkWz-2YkylWSp-9huHyko5sL4Idq3VAOPoHJFKkuHe6gWTZFScwXleJ0pcGSpL-wWeuyR2Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeeljeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehfrghsthgtrghtsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:-GydaeSM87lAC2HL-spHTpvS2pMRu05aatf8_hIcPf52EFctUg43lw>
    <xmx:-GydaXmpLN_Fy93nkRJJZGqceoxnrRLF9JTt6KAiBupFQUdbRXXAag>
    <xmx:-GydaU4-IKLChK3EBd5cmltyFJ84-xtQPdpSnZoNGXkxmch0gh3_Og>
    <xmx:-Gydadj2dociZ2JxB-EE2r8fAbVjaBWPMcq_VWoUNiHh0CkBX_oQaQ>
    <xmx:-WydabJBLJrRRKr5Qyxm2o3K-PC1y_wGufzGXJhOLRnqDxESq8K7orYw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 04:18:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b5da0b63 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 24 Feb 2026 09:18:46 +0000 (UTC)
Date: Tue, 24 Feb 2026 10:18:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, gitster@pobox.com, fastcat@gmail.com,
	Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] for-each-repo: work correctly in a worktree
Message-ID: <aZ1s8y7f7PS7FVOG@pks.im>
References: <pull.2056.git.1771903950.gitgitgadget@gmail.com>
 <a47f9e9386badd83f0f5820f33f5eed68ca5fd82.1771903950.git.gitgitgadget@gmail.com>
 <CAPig+cQcpJu_Z6VXbn5cee2AHmPHQaOLG39HFRG1SGnnY1cWFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cQcpJu_Z6VXbn5cee2AHmPHQaOLG39HFRG1SGnnY1cWFA@mail.gmail.com>

On Mon, Feb 23, 2026 at 10:34:30PM -0500, Eric Sunshine wrote:
> [Cc:+peff]
> 
> On Mon, Feb 23, 2026 at 10:32 PM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > When run in a worktree, the GIT_DIR directory is set in a different way
> > than in a typical repository. Show this by updating t0068 to include a
> > worktree and add a test that runs from that worktree. This requires
> > moving the repo.key config into a global config instead of the base test
> > repository's local config (demonstrating that it worked with
> > non-worktree Git repositories).
> >
> > The fix is simple: unset the environment variable before looping over
> > the repos.
> >
> > Signed-off-by: Derrick Stolee <stolee@gmail.com>
> > ---
> > diff --git a/builtin/for-each-repo.c b/builtin/for-each-repo.c
> > @@ -60,6 +61,9 @@ int cmd_for_each_repo(int argc,
> > +       /* Be sure to not pass GIT_DIR to children. */
> > +       unsetenv(GIT_DIR_ENVIRONMENT);
> 
> This only unsets GIT_DIR. Is that sufficient in the general case?
> Elsewhere, we recommend[*] unsetting all of Git's local environment
> variables.

Good question indeed. We have the `local_repo_env` array that contains
all the environment variables that may influence repository discovery.

Patrick
