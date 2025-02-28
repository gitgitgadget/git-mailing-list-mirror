Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318A7276046
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 17:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740762409; cv=none; b=OFdirj3dzPh/sna054kAqzMA8MO/7vpaa4Aadegilw/lo1ifU17j7vFZlMQ8jyZQfHY+LgmIi2gJpV1SWT8hxHqQ+3TCnRO1UGl2yAPZnP6WF4MpZCaM3K193me+KLQDHcFa5aUYyeFajESkdOh814jN44+yhvuqobKa5HnyUkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740762409; c=relaxed/simple;
	bh=TiAPZ5CXNKPVatufpEDGMlIPmrKmOf9AV7yMAMZjXUA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ivg5xpkBJwVofDkoVGMuOZFReJJ46UR29QH56SDKMiA68fF20BnoaAYdny6xFD1deUKjC97rQ9dqJryU+vUs+3EYR2amPuCFsWXe79RX8U6xCmu2rC7R+AwX2ODNcfZg/n9dBLbrckasee/djMvJomQ4CfiH+QgCW7xUO8UT+Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZdxavDdp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QV76SXd+; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZdxavDdp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QV76SXd+"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2CAC11140083;
	Fri, 28 Feb 2025 12:06:45 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 28 Feb 2025 12:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1740762405; x=1740848805; bh=n/iJG00l/v
	eTO5UwPuHIVP+fHHYmMLnAwtbqpGIy4/0=; b=ZdxavDdpSsXNsWU9fy6gKDwMrL
	qtGf01VPtdH7ZOLA5aZxqdYHW0ygrkFhpUjEdIkdufT0uFUzKMy5G9/dXxeeB06J
	lgwOMljl7LuFteUJy0ySpjU2P+00jCrIUEUxc5ZY+C/0XGzRxULqZDJjAXotZtQk
	aKUyR0eUBsCt52f547mLLBaTefIdXaghGXxYPE3Xz9bgW4CCf+Y1q4icvqo8/pYj
	OpS82sD4/QHsNzqP01XoxA4eIQGx/xlAXuK4zSAT9ViL/mMpBEOXkBINckibGl9H
	+2GUX5HV0N+cLC44v4NwlD4ZmDwT4UVom5NBQ4nj6P49BG0W0d/6coEC8I8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740762405; x=1740848805; bh=n/iJG00l/veTO5UwPuHIVP+fHHYmMLnAwtb
	qpGIy4/0=; b=QV76SXd+MOyqpEs0MGSDzKqlaJwk5jtYwYv55PhC7ApVVZOKEkH
	yX/jXye3rMutPhNkPNlHFbS16TuCQcQKRGRs5Rcv7J/J4ZSm6Vn8h2sqXko4Wjcr
	d806m5LVFkaBabldtoarfCAyAkUAZPEj5H5BKOIFGW4E2HI7zd5IUHMlb9scTqhb
	4IM0V7uEH70wT7Mndjv8/mR1khsiN/qG5kBZ6ldi8denLEUlqBfRjll60GKWpzL9
	1ZRyzxjy33kNDszC1YHr9NMm/jdjcCGG97e5OBH10raHyu6swFdYi4XATiF7qOw4
	54fa1YDfsADXm0prlgeZNdSuINQJHqxCgOw==
X-ME-Sender: <xms:JO3BZwN-ufldkW8bXouj8t7K9vibpFtRRFnvpOe5EHdkiRFv_ZO4kA>
    <xme:JO3BZ2916wfD5F-34Yfn2J-FeOFgT-NJSKcM71KN4ORfWlyK2CizojmtBpjn0WIkE
    RpYADOuvClmGuW-_A>
X-ME-Received: <xmr:JO3BZ3QSd2ZhKWJqTalKou2ZSLYUR6Ujpv4CS6UWlgJllnW6fxNhjP2NxAiz3jJO85JNwJQc1T7Amr-lH85sUmpKraQPhmPV55Uj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeltdelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughg
    vghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhg
    rdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JO3BZ4t_GnvY141kYtIC-z0G6zHENuQmpKFg3C00JZ4FjRr0mmCIMg>
    <xmx:JO3BZ4f0RpOaCqZ6FraCGFxYhOi6_GHDVbpIkPWfP-80kHOKf0gqCw>
    <xmx:JO3BZ80DQnR6NAF4kE9Uj8Cj5weH7YPsV0iIST2GZXkFjR5-O36TeQ>
    <xmx:JO3BZ89dH4lW0l1vnOyI4xa_udHVhafjXQQg1Sx5LCLHCUCgZ2oh5g>
    <xmx:Je3BZ9HKsl8HgZjVjn5dx5uicJRl-lodDgLIAVoEsLeKKBVlb-uY2sLJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Feb 2025 12:06:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] add -p: mark split hunks as undecided
In-Reply-To: <d2c934cc-72be-4aae-8661-3331d3936219@gmail.com> (Phillip Wood's
	message of "Fri, 28 Feb 2025 16:19:11 +0000")
References: <pull.1863.git.1740149837.gitgitgadget@gmail.com>
	<43a0592a462cf68bcfdc54373da2319431c3c1ca.1740149837.git.gitgitgadget@gmail.com>
	<xmqq34g79e8k.fsf@gitster.g>
	<618d4a61-7480-46b7-8563-221264290ed1@gmail.com>
	<xmqqikowejmb.fsf@gitster.g>
	<180271a6-eb0e-4c15-9916-b2ab5760f4ec@gmail.com>
	<xmqqjz9b6xr1.fsf@gitster.g>
	<d2c934cc-72be-4aae-8661-3331d3936219@gmail.com>
Date: Fri, 28 Feb 2025 09:06:42 -0800
Message-ID: <xmqqh64e3snx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> ... There was some talk a while ago about
> adding a mechanism to select "git 3.0" features at build or run
> time. If we add something like that I'll resubmit with this change
> guarded by that feature.

Documentation/BreakingChanges says that we can hide it behind
WITH_BREAKING_CHANGES compile-time switch, and that is part of
2.49-rc0 already.  The linux-breaking-changes GitHub Actions CI job
runs with it defined.

> Perhaps we should make the confirm-before-quitting thing a "git 3.0"
> feature as well?

I do not feel too strongly either way.  Sometimes I wish it asked
for the final confirmation after all hunks are decided.  Most of the
time I do not feel that way, which almost always is after saying 'q'
to finish the selection.  So I dunno, but my thinking right now is
that I lean a bit toward negative than positive.

In any case, I think we should indicate the (selected, deselected,
undecided) for the current hunk the user is being asked about, which
we talked about. As a workaround, we can do 'g' command to see the
list of hunks and check the indicator (+/ /-) for each hunk.
