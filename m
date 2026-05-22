Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0509E30677D
	for <git@vger.kernel.org>; Fri, 22 May 2026 07:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779435209; cv=none; b=oXw/Z/2c42Z0cMmh7uT3HW/k1T/83M7kE+nk9wSrunrK2i0Yh4CGEAqLb3qsjGm5TNjCq2fiq9WrxvkV/NDE3B9oRu+r1lLAqbsbiuTtK2YhOhr1AGVgfc+5lkiOsN+wotK2SwjwaInGYtAEUzBBKugeCeaE4wh3sAoSkofCGO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779435209; c=relaxed/simple;
	bh=Ps+g0zZHvJJ89YaB0IGa5WzUDbzW6gf5Xs4wMCTWqmI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=AEV6w3v1MCQwUl0TDbYwRbPZRFE25d+ZVFKxFHt8/FCx4clBGuAGwLAGrUM4MFUqmmUKuYv1UQ0s1HAdGdIuZdAuHaSizzFs8llw9Xtnk6zoKUz+WjRymdkozpSWJg/vA8qO7sPyJ9mLKvQMl7XzQpkf7YzE0Sfge5QqlRhGPVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hurrell.net; spf=pass smtp.mailfrom=hurrell.net; dkim=pass (2048-bit key) header.d=hurrell.net header.i=@hurrell.net header.b=QHvhUSCp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tO2Su4fp; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hurrell.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hurrell.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hurrell.net header.i=@hurrell.net header.b="QHvhUSCp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tO2Su4fp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id E627F1D00010;
	Fri, 22 May 2026 03:33:25 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Fri, 22 May 2026 03:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1779435205;
	 x=1779521605; bh=rZmHwu9fU9aCWWq5NGh/EG9kuE/LToj+8IG0V7gr8VE=; b=
	QHvhUSCpJiWpZ3QYiHZKjk6tmgT5wXqlxfH9INw9MBX5E91SBk8b67UflI981/Zj
	EVAitYqwBH4livwx+nnvElj/jNCLB/5Xfmhpfp0xKtbOHKl/FvIYOmYCI8JksRpD
	/J428iqcxc8ZrEk1JXrK8XQiMnBATgInu+WBpDPVj0dF1B2HKpX1DGAhLnS9OZRq
	Vh0V+3Gfr9OlLRG3UzSZqdrqKbaSyPu0FHh5WyfMgiFBLUBpde7lwQZhm4Helps9
	c4tKtJkV7usYQ9y3Ig0UaqnaIc1tneeFb4xivPeEGM/2EXcTSDUXOdsoZMoiUw8i
	666zGWBrrCuW3wOsSkFToA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779435205; x=
	1779521605; bh=rZmHwu9fU9aCWWq5NGh/EG9kuE/LToj+8IG0V7gr8VE=; b=t
	O2Su4fp9U6k9soyeBUn9SaF6yQBkzh8ZpTvrZJHM8JiYxMiPfWIK25LIbiivy+T0
	ciwSg5uuyMD/bBypD+OYZv2safMSWH5WIbXhQN1OvGlfSFwqnIP46ip9HNVo6iAU
	aRVbQdK1JpTBNv1I9cZ8cZE3tYMaCa7RU5a7w12KmgtZx7Wg3jjmSi881qqDmwj2
	xcrRuXpxtG2Q1hsgwUjuDgAXCyh4larEFb3vmo+0PYx0M1MfWewp8/8rfJTj4xvo
	QV4OwEmaQrfsztMOKqLbnQDmTbmOd8ZUYLCFW5680bcQTtGOvtsi11m0Z05+9M6I
	0XbGlFUK29RHBvwH1mVwA==
X-ME-Sender: <xms:xQYQasoaEglJQAEpEgKu8KyChFOTOnffaJEIxhxf1dyDQm4ua9sFLQ>
    <xme:xQYQate3jdrt8oqhoQRNqFZpVQ9sK3j10egbDgUsp8gLXpF1BcNf7zdGt92pAMToa
    cvB7GZEfQZ4ZGVFMkpNEPFjcz4SPJJf-HwEaNgSxIixSh_nRnoWPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeljeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfifhrvghg
    ucfjuhhrrhgvlhhlfdcuoehgrhgvgheshhhurhhrvghllhdrnhgvtheqnecuggftrfgrth
    htvghrnhepjeeluedujeefudeludffueegleeitedufeeuheeutdfggeeuudektdejveel
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvghgsehhuhhrrhgvlhhlrdhnvghtpdhnsggprhgtphhtthhopeeipdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegvrhhikhestggvrhhvihhnvggurdhinhdprhgtphhtth
    hopehgrhgvghdrhhhurhhrvghllhesuggrthgrughoghhhqhdrtghomhdprhgtphhtthho
    pehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xQYQasVbRm5gp9Q_xsULScIyULu2uF3Z2XqaN3URMxmXS67O-PImLg>
    <xmx:xQYQap6A8X3gygGQ2N-pT07Y5J5UxE2rEqhxHNxqILNLaeWE-IF1hg>
    <xmx:xQYQanqGf5X3-p2P8HMinvnaY99O1ekX-UTTOExH70S_hrTE8WwR5g>
    <xmx:xQYQasn8xY26hMkfoine2TEOFfNnnylTZQSvHqapwQ9PyeGnpPLbEQ>
    <xmx:xQYQaiAgbK-8hBPomwpcHxO5hUv_49AZyFq1MAitUb2Lo7j03G4JWABp>
Feedback-ID: i12114735:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 5ECAF2CE0072; Fri, 22 May 2026 03:33:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A-iWxsR32d1o
Date: Fri, 22 May 2026 09:33:04 +0200
From: "Greg Hurrell" <greg@hurrell.net>
To: "Jeff King" <peff@peff.net>, "Greg Hurrell" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Erik Cervin Edin" <erik@cervined.in>,
 "Junio C Hamano" <gitster@pobox.com>,
 "Gregory Luke Hurrell Stewart" <greg.hurrell@datadoghq.com>
Message-Id: <3c0edf5a-761a-4b79-bf3a-fcf336a986e8@app.fastmail.com>
In-Reply-To: <20260522052821.GC861761@coredump.intra.peff.net>
References: <pull.2108.v2.git.1779280307112.gitgitgadget@gmail.com>
 <pull.2108.v3.git.1779371110195.gitgitgadget@gmail.com>
 <20260522052821.GC861761@coredump.intra.peff.net>
Subject: Re: [PATCH v3] git-jump: pick a mode automatically when invoked without
 arguments
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, May 22, 2026, at 7:28 AM, Jeff King wrote:
> 
> My impression of the "auto" feature is: I am too lazy to type, so just
> take me to the interesting bits. And interesting in my experience with
> git-jump is either "I am merging, take me to the conflict" or "I am
> writing new code, take me to what I already did". Limiting the second
> case just to whitespace violations (assuming there is at least one)
> would probably be more confusing than helpful.

> If sounds like Greg has been living with "auto" and finding it useful
> for a while. So I'm mostly inclined to take the patch as-is, and people
> can experiment with it and suggest changes after using it in practice.

Yes, the "take me to the interesting bits" is very much the mental model
I've been operating with, using the simplest definition of "interesting"
("merge conflicts", followed by "changes in the worktree"). I think that
starting simple, but leaving the door open to possibly introducing more
subtleties in the future makes the most sense.

- Greg
