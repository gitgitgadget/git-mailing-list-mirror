Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA104299A94
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763459955; cv=none; b=r3SE8Dk6+Eub9jOEY6362gwHtTNBEfdreJ4N1Vl4l4JisykLnwIZkyFMBsx6JaDpYJPTYRbz/Sx1g6GhsgewXe0PiPVgxhLydYuIdjzTN6hJq4UQQZFRhGJNSlFOPevryBzwSch1mK8F037i2Akp9VcgJPJEwRcj61Io/Ulh1oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763459955; c=relaxed/simple;
	bh=AMjImCpgKYNRLfaXCUQTR+J6Mim7tqi7UwnU7ElaBaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRhLX04TsDWlPnUAuozfMIUTKNkYVNlnWExKKxR6pj5G/Dw/irwYonE8c2X7vU/kROqBmU/SKhoSWYvKugav0gQiZa55sRzahSmqR0Y+B0/ue8YqzxhMuS+tGgick1ZBZdU8wqPEl7bM6WI4hK9B8618I62KnKIdNDjCLsV0508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JWFHnydc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JwG3FrEI; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JWFHnydc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JwG3FrEI"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C3F0A7A010C;
	Tue, 18 Nov 2025 04:59:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 18 Nov 2025 04:59:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1763459951;
	 x=1763546351; bh=MlSS8gYITG8hO7pwkbjqKRC2VZQZVUFYd1xmR5tXJBY=; b=
	JWFHnydcueiQkgR1PzTrvoCk6mqutV3p8UB2LFSd50QiMF2G06Og7h0kcQygcleY
	CQ/2OL1A97mJcHkHrpZXp7BQnR5VSXsmFPayUCfM+mVjORSscsgEsUZT535qgzE2
	ATVXGA2js3o0KuIcWbiCryYd1pp0lq8Xr0tXlJiQ0Cy+6o2RDmAdsJN36NSEMQ5H
	L1mpS2Wd6Wi77i/BLNMKXqA44OIYMqqxoz34dDcgDj36p4/3LVYlKEO5tIwjSo7n
	4IlOpl4Lv6A+ZEKiaQycWj9JosYHPJKlWJfV4cSuXkeW1MeD+xQwiqJWT57snRTx
	dDUeF3vqsGp+AHaqp4Dtwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1763459951; x=
	1763546351; bh=MlSS8gYITG8hO7pwkbjqKRC2VZQZVUFYd1xmR5tXJBY=; b=J
	wG3FrEIhXj7rm2D2BIYIqD7SQdtkBzmDYIjYC5PeXFRHNCSkfKElIX2DLI+SK2+n
	VOENvZUZz7XW60AMVGJ70L/9LvYgKEk/Sf4yi17QJxr0uxpe8q40o5xbTQRlmhCp
	UfHIJpwbi9QUjmCMZH94E8UPLKRxKXUMMvFf3cI6Gd0OHB0i4zngR6IUsBASDPYb
	qvNDarcfSLF0QYDagyEkWpfw2XkC50MiSM/8EpiPP29LBr9xRwdGh65oqSJBW+U9
	GCaDEa1qv+/OQOQbP3OSchBa/HSMvgWbKCIA9xnhxwCPSZJFFhaUe7vcXL94xknk
	+4qOdChMXbarHNOiVfdvw==
X-ME-Sender: <xms:b0McaUlsSul_UOJASk25Fk5iUYzAELHG1Bq-walZk7AqnajLWsLk2A>
    <xme:b0McaRq_ZSzGWOimsP2uBVOZOrHT8DsjxWJXmlJgZvAYgnmV2lxVY7smmfqt6G9jt
    dOhIHcOh4_oHDp43uTKqKM0Mmv6Ml5uLhOJn5S2MVEdGaUP-j-ir-o>
X-ME-Received: <xmr:b0McadHvPLbKloHiFzIPNxZhrBTlZ8iR1pHwhp1L-tLhL3_Oez58Xtu6nfC3pwRBLkQCVVSzvPuD-YTmSz64xPXvtNxnBFHVvMlCS5dD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddutdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedvfeejiedtteelheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:b0McadwvqviU_SaPmGZCHgcBVk9uWxPaBgxceOCKA9IJQ8XCglU8kg>
    <xmx:b0McaSocMTagpZSFsGGECkTfBJlxLj4SIL87oGB2KgFAgWrf4VqLuQ>
    <xmx:b0McaXigG7B_N1swt9jtU2MGpUlodH2LMiYrwmCVxvSyA3L6eyV06A>
    <xmx:b0Mcafi1oW-otDbhBPRciDlonOOIh7bzkTL4iBiDHfL8tWkcG8X-nA>
    <xmx:b0McafC_lhTGP_SN57RpYMbRGIpiPh6tHVYEhLLi9mudAbQ7H-6yb5vq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 04:59:10 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cb5b7a69 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 18 Nov 2025 09:59:08 +0000 (UTC)
Date: Tue, 18 Nov 2025 10:58:58 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2025, #04; Fri, 14)
Message-ID: <aRxDYkeAi8T-HH8M@pks.im>
References: <xmqqcy5kgsjk.fsf@gitster.g>
 <CALnO6CDCzNbYFC4BGmqC5bhou5rtie7K5OhR_cP1CXJfChim=A@mail.gmail.com>
 <a407a793-9636-42ea-afe8-1283b1e220b7@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a407a793-9636-42ea-afe8-1283b1e220b7@gmail.com>

On Mon, Nov 17, 2025 at 04:31:00PM +0000, Phillip Wood wrote:
> On 15/11/2025 16:51, D. Ben Knoble wrote:
> > On Fri, Nov 14, 2025 at 5:27 PM Junio C Hamano <gitster@pobox.com> wrote:
> > > 
> > > * ps/history (2025-10-27) 12 commits
> > >   - builtin/history: implement "split" subcommand
> > >   - cache-tree: allow writing in-memory index as tree
> > >   - add-patch: add support for in-memory index patching
> > >   - add-patch: remove dependency on "add-interactive" subsystem
> > >   - add-patch: split out `struct interactive_options`
> > >   - add-patch: split out header from "add-interactive.h"
> > >   - builtin/history: implement "reword" subcommand
> > >   - builtin: add new "history" command
> > >   - replay: stop using `the_repository`
> > >   - replay: extract logic to pick commits
> > >   - wt-status: provide function to expose status for trees
> > >   - Merge branch 'sa/replay-atomic-ref-updates' into ps/history
> > >   (this branch uses sa/replay-atomic-ref-updates.)
> > > 
> > >   "git history" history rewriting UI.
> > > 
> > >   Comments?
> > >   source: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
> > 
> > But otherwise I generally am in favor of the idea and find it useful.
> 
> I agree with this and I'm pleased it is reusing some of the internals of
> "git replay" now. I've just reviewed the first half, I'll try and do the
> rest sometime this week.

Perfect, thanks! I won't be able to address the feedback this or next
week, but will do it once I'm back in office.

Patrick
