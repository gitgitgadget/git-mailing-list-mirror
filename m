Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE5C1F3D54
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 19:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750707387; cv=none; b=POXdOzy5BFGsHngVdr+/ER8mewLxEYqvOOm9E2S5osOhDDGQvKo/Ihil692hNrn/7E/3EDyklTACRkAoTu8k9YJBO2SFI8kEfCkxv37Pmy2pwoXzUQ7r+nlfGrOYUCdTZPP8m9MktrRMgoqAWvpPeKYi3eARd+FCXm+H9JDwxKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750707387; c=relaxed/simple;
	bh=Uez0VRMquFVjqAXH6TNXSgUQGJQtUlowUkbn/g5pmRs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=enkMhcoGF5Y97Ehix2W86PVzuzwlFed7yiSoRRgzZK8TGkdIpAGyi2Ay6JqXoP+cTftcxdt4+7fyekIMcz3AxKpicF0oG2mZPI1MUqQdT/Y1vWoJQa9rWT5+FALHPNITp5KWDKzGkU+Y5JOeIvav+cArXRJzdvmBQZym4gf4wpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rcchwWvh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HN08Liaz; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rcchwWvh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HN08Liaz"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 55AD7138035C;
	Mon, 23 Jun 2025 15:36:23 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 23 Jun 2025 15:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1750707383; x=1750793783; bh=T6neApy3MD
	B5FKv8F6XzzqrsYzoNJQ3MxPajvfKjnm8=; b=rcchwWvhMEN0aqDBfy/QA9lCal
	QVvpmNiLALHbj699H4NE2Zjbx/AIbVEp+izMm55QVEqGyQzxQjcZXy+ySsCFVSnB
	trQEXmLZHyDqt8KrEQL+2X77D8P5CNtVeW+sjirdMCoRk0G24oC81Ktz7PK7BdQC
	Hu3yPNryKoMnhkA500G4uMwz+RCuku9oGfN2QTo35kpmbDILpwKGP+0a7Drcq6de
	Btm8ZwEeuqMy1flItJQe8qfdoaXtKCvImLzgVC4lfCHX/1y3Qo+ZVsTXmIj5OFjT
	ZxDClSu5Hyk2iaGQl8ti9iIYHu15iWrYp3kdqX2vmj7WuYq73T9yRgbmG6yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1750707383; x=1750793783; bh=T6neApy3MDB5FKv8F6XzzqrsYzoNJQ3MxPa
	jvfKjnm8=; b=HN08LiazVMfKeY06hSKfTqnX/iT3w7tRJfP74jLMUfOlkMxIxQO
	fluimCxUpVa/pag2D72V38edw1Y3uRFCAhz2KTdLq9WfO2oW927N9b6ItdQm95wW
	VmaMwDLJtxMAiJiRYDzQjC+A3X1r6VFo7whCX58eLv43T6D1JJuyJp2Vlpfe/Jkt
	k58WdV5dFaCF0oJ27/Xaqt+VEd4rJBqjWkCsYX0hYh4H0c+NXSh6/Rl4OQyWEte5
	i8h7utVFIWvjtJTLa/t00YU3H7P6UKRjYIr3XwEJxciBWgXmO2nb0DeyCSCX3ngh
	+7Z1ohGc6eJxbVArmlbKcdr09S8fEeFMm8w==
X-ME-Sender: <xms:t6xZaEf8EYYvXQH2TFEkqeNqo6X6ucMInGQeMqCVFCNI1sLPNmMkZg>
    <xme:t6xZaGNQuql1_nK0EU8AFEBlvqiwQTcL6xEHUzGdWgkRAwyWMRPfOwI7tI2lDK0Fx
    rWPgDnONjCvNi4ujA>
X-ME-Received: <xmr:t6xZaFiEMZWC4e4S9ZOaj1Mz-n8-AX7QWfrNEDXZFYqvI2tZmnIGt9eRRSiKAshawv8pF7xKMMpUG5mde89kTiHYLk9HHYTAmN4H4JI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpefffeelgfdugfehgeeiveeigeeifeeuhfekgfeuueegjeeffeekheeugeelffdv
    tdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdguvggvphifihhkihdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehkrghikhhophhonhgvnhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:t6xZaJ_V_5jy0rkb2HeTzANLGBtb6nYYvD0f_fzGuqRIUXDRaw4WWA>
    <xmx:t6xZaAuTsguScBHSmqP6TxeU_YBBFfn049lE1dURqElVD_foVpDlkg>
    <xmx:t6xZaAEaLwT5m8e7jyTs_ywfFqE2YpdVZ15dHiZTVtp1s3jLozdYFw>
    <xmx:t6xZaPOJ9GKet5NIAnuO2D6l6JEhp0sXRNKbluVA4uxt5ZcUcD7kZg>
    <xmx:t6xZaPVZgP5fFyEZVZ8zhIt6NeYrthkWk4WWfFZSYiVL75164GTe1K5m>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 15:36:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Kai Koponen <kaikoponen@google.com>
Cc: git@vger.kernel.org
Subject: Re: Perf bug: rev-list w/ 2+ paths relatively slow with commit-graph
In-Reply-To: <CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com>
	(Kai Koponen's message of "Mon, 23 Jun 2025 13:58:03 -0400")
References: <CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com>
Date: Mon, 23 Jun 2025 12:36:21 -0700
Message-ID: <xmqq8qli5jyi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kai Koponen <kaikoponen@google.com> writes:

> Reproduce steps:
> ```
> git clone https://github.com/golang/go.git
> cd go
> git config core.commitGraph true
> git commit-graph write --split --reachable --changed-paths  # Without
> this, all calls equally slow (~1s)
> time git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 --
> src/clean.bash > /dev/null  # ~90ms
> time git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 --
> src/Make.dist > /dev/null  # ~100ms
> time git rev-list -10 3730814f2f2bf24550920c39a16841583de2dac1 --
> src/clean.bash src/Make.dist > /dev/null  # ~650ms
> ```
>
> The rev-list call with multiple paths takes over 3x longer than the
> sum of individual calls to it for the same files.
>
> Expectation: rev-list with multiple paths should take <= the sum of
> the time it takes to call it with each path individually (ideally <,
> since with the count limit it should be able to early-exit and search
> less commits for either path).
>
> Also reproduces without the -10 arg, or with a lower count (double
> instead of triple w/ -1), but these results are perhaps most
> surprising with a count present.

I asked 

    How does "git log -- path" use the changed-paths bloom filter
    stored in the commit-graph file?

to https://deepwiki.com/git/git (there is a text field in the bottom
of the page), and an early part of its answer explains why in a
fairly convincing way ;-)

    When you run git log -- path, Git first prepares to use bloom
    filters in the prepare_to_use_bloom_filter function. This function:

     1. Validates the pathspec - It calls forbid_bloom_filters to check
        if bloom filters can be used revision.c:674-686 . Bloom filters
        are disabled for wildcards, multiple paths, or complex pathspec
        magic.

     ...

In short, the changed-path filter is used only when following
pathspec with a single element that is not a wildcard.  So the
observed result is (unfortunately) quite expected.

