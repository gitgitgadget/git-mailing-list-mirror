Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D8CC8CE
	for <git@vger.kernel.org>; Sun,  4 Jan 2026 04:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767500286; cv=none; b=C8nSSonrWXTWDibO+0qVZdCRNy5cOl42rqwajUOd13SUPXmpgNuuGErUSt7bJgTzVVnv0FHQe+JnQpg1MYvU3HwftaDliGokcI1Egy0SOtfM+3NzPIgSOe4q867uQ5sx9btIoGmmTAS+PTgBMq/QpQ74Hmjx7aGlkhlXn5eA+rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767500286; c=relaxed/simple;
	bh=87hcNXNUo1aLivmZw1/Ze9StzrbvZWHYdRnS1LNH5q0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m3gq4mgUmeOlDB7Yt6X4LA1ZcoWyB7AHFq8W4wp/dN0zmMAlQXTr8rMtNDqfhW4bkEc1vTHQMtHxxzZKT81zfLfHpVChR14Biuouc7y7JhXHxEyrZ2mnXZlacZ8bGB9TzrUjgMzednoLwueB86Pv7jNwepXUl+ZUElkZmJI/Z+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=feYz96YF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bgcf7OQ3; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="feYz96YF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bgcf7OQ3"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8F4B77A00C1;
	Sat,  3 Jan 2026 23:18:01 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sat, 03 Jan 2026 23:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1767500281; x=1767586681; bh=Xw/ka80AsI
	vEj+OJqrA8e2gj6EdJ5QPRv7dWnG94QjM=; b=feYz96YFV0AHrkQO0GqWuHghQ/
	Uo050mBLJqgNt2fstLuSmXDjQWmottbwcUI7jmalaPnxR2tKLrdl+XRzgrayJ1Fe
	KjH+qADQGjfdZZUiqENDi1PXIiWE/2IQwUwJT4disMBFaWnTlwelZdpXfpUeBgpQ
	x6ZwvwvGfZF/PLdkFgO6hWfYZM1gf8zbUfeTEGJRjt62MAAG6lX5rCGzqWkM4znd
	zUfwdAd4Re15pvQSxY6sTutFZ/GofD5QqCnkpZfCZAr1uJbxeKakvLcLQ1eR2uTG
	gsSXVlrU87xxUq5Kv6C7cMK68ym/I4iHo3elI5UFy2Gw+FVse9A3hxx8O3zw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1767500281; x=1767586681; bh=Xw/ka80AsIvEj+OJqrA8e2gj6EdJ5QPRv7d
	WnG94QjM=; b=bgcf7OQ3tAnvKSVNFgsqFpCL4P+CmyhZf6AIGYqM+U4oxMYvPpe
	dC7WvPNk6Rgy8eoWZHaPaT2tNzpHh7LWJ9F/PpV0vaAChRD8jT/Z53Ic9Uk1aHGz
	kmZPclcMWnLkXz+lpqvk1vEcMrNLL88uyMX/UClP5DyD8lOsfptuaGQbxB1xbYwn
	15LVQgqLVyK2LtIwLdySB/KZdXwSzvvdt8WSgJ1bNNebXrzIMQ7pFJCbY6CWhMX8
	wA00akW5RBqgCBtxu452lo/azWbgedaSgJ4zSA4TyOXnWorzlhtddpd1LsAuMnyj
	SYqg0hUOcfxg0v/sZUrzbzhql7TI9PwZECQ==
X-ME-Sender: <xms:-elZaR-jp6ILNgiYaGrLyCbYsJqNe3U3FUOnO4W62Nmt9cFQeRqt4Q>
    <xme:-elZack0rztvQPjmbgWWkXmEYVL635e9wu_jypFJnM8ApDH51MGZaSbJFd8rPdCQ2
    yuNV5DEj8uS3rgK-glaCMdgoNt9yzWtMgyvkLZ1BoyPQ-IVIjo69oo>
X-ME-Received: <xmr:-elZaXWiZG3_T87OX6Mbf994gpZjo_H6aied4X1FT7B-vHeOgGiTVhUTl38cZGQSZ5P5onsVICHUHeeip9DHx4h9l0OWYvPre-iThWE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfeeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehnihgtohestghrhihpthhonhgvtghtohhrrdgtohhmpd
    hrtghpthhtohephhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehp
    ohgsohigrdgtohhm
X-ME-Proxy: <xmx:-elZaRF0S70-e-zrPZITap2DO-5NIjiHCOrPYlCrE2QlvcoLEC6AvA>
    <xmx:-elZaTduKVYbrOWL5XOiUdG6r8aKdZts6DvA_NLzonzvtpMu5zesyg>
    <xmx:-elZaSKxWTl9CjDoNopDtZOH4hZsx5d25Bnhx0jl6bZ9ubC6b9Iiag>
    <xmx:-elZaYE_5h2wn5LFIiHCVBrUKMGA_EoOXLBrOKgO88KIjBaNxbE2HQ>
    <xmx:-elZaXgeE1qjx3xdj50GMA-Y8ABA5U4tXV1vMVxLv9qZTo5h3prBgTbL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Jan 2026 23:18:00 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Nico Williams <nico@cryptonector.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  git@vger.kernel.org,
  gitgitgadget@gmail.com
Subject: Re: Another look?
In-Reply-To: <aVnTc8GmqH+5Ui3M@ubby> (Nico Williams's message of "Sat, 3 Jan
	2026 20:41:55 -0600")
References: <xmqqh5t5c4lj.fsf@gitster.g>
	<20260101233839.17639-1-haraldnordgren@gmail.com>
	<xmqq7btyqfxy.fsf@gitster.g> <aVnTc8GmqH+5Ui3M@ubby>
Date: Sun, 04 Jan 2026 13:17:59 +0900
Message-ID: <xmqqo6nanh8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nico Williams <nico@cryptonector.com> writes:

> Sun Microsystems, Inc. used a rebase workflow from 1992 to its end
> ...
> It worked like a charm.

That's good for you.  But I do not necessarily think merge workflows
are bad, and my advice was certainly *not* about avoiding merges.

A linear logical progression of commits that is about a single theme
is much nicer than drunken-man's walk that is also a linear sequence
of commits.  The distinction between them has nothing to do with
merges.

And a history that bundles together a collection of linear logical
progressions with merges of these topics one by one is much easier
than rebasing these unrelated topics into a strictly linear single
strand of pearls, by making it much clear where each of these topics
concludes.

