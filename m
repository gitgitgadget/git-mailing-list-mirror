Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82543F0A8D
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 17:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776188562; cv=none; b=h65aV/2CHtuHiOB3vhQV6/Zu963tC4sSe3QJmMW2pgYhHB7O0NKoK07hWoNnOhzjJeBSsWN7Nm8jCBnFvVrzRN3BzDZDcrkCIIMCM0msbR2PbYwxq9WmNCIPXa86368WAlEEvjA2yVB0MzrrJv3o0zpXSk6+Z505YdVq1TNZ220=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776188562; c=relaxed/simple;
	bh=AzZK4PKEL/3jPQouku8nwcxT6Ph330wTYDpJfITypjQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QBxiRxTHW7BFTgTfS71pQ4tZqSSurLPZRK5MwQHmjOM+FfqI/cD2qDt88NyRSs3De+v/DqBP07T8hHlCKo/tl6Him7GLM8WWXm8v4uQl8266/tN2lib7Pmu+lEYvnBocXqOC78TQrOSDbKSQzM3XEI6or1t/6VcBPFVDrCSlfLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=m1pxaocm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j8eLAh6d; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="m1pxaocm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j8eLAh6d"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2AA797A00D1;
	Tue, 14 Apr 2026 13:42:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 14 Apr 2026 13:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776188560; x=1776274960; bh=6H4gD0n0Jn
	Hsnqrvuzp1C1jCVkPAvYEw01hj9Enn5cw=; b=m1pxaocmTfdNwUCiG6FOjgo7st
	2zK5x983Rij6dWFtrrhKtKVtptX71FFeYK+FWUUx9Y+x+HlNJGDMly/VrBKkR7PK
	nvT3pzlmMxuZBy6hwZKw+pB9J7bVbgE7gHR7RVSnFrC0ccBSJ0Oh6Ow+pY+CY+KX
	ErObCbWi54LUxIDGwX9ZbohrjUhp5teeOb0YbNbaOmX523Qio5jEv3GHxNinABDJ
	O+EgJX9V1wEccOgjO20Kr93OGg9x6ghXV5IzTvV1fmR83Wu0J/W1rXVSRrfkm+lM
	q0TFoSc2EBdSkTAmbi7uGlit/qnvDBtF2FaqoWx2TfJx1egBPxx4GFTwPYdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776188560; x=1776274960; bh=6H4gD0n0JnHsnqrvuzp1C1jCVkPAvYEw01h
	j9Enn5cw=; b=j8eLAh6dNeUjMMG/UcqC0FIXbBLz6l6Vg5Cc2ef0l+7XZa6Xn6q
	QI72qt730/h8RyxruMquWNIBoDu7sHBZtZDYPnKCSS8if5/3PGv17mdOigJaAT1u
	EjWmNBNziQ06I689QjuYU934rfhUb/PwITbCxdgG0Twa7dXwEZcgTSfs959xXkWj
	Pu+K8V/96y3deUmlmnLUQNfnBMP2uBJsw0k8ensxtBtkC4SEJGQOyMTbMlCAKFfk
	u4A5JcnDF/W9RtEYxOgG5x8cFlShVG7xl0r+qDX679KPHZCdZ5RQb2xG5hPLCgqx
	3zHm5kVdZbCMFp7YtYEXiYQQy3XuEp7YAug==
X-ME-Sender: <xms:j3zeaXIDhBxZtoOuFWhJFEBIaKXUO7i59Itnu_gfL-3cK4AT5edk5w>
    <xme:j3zeadbnM8eh_jzinnK9NpJK0YZXsGHFOr-8QQXFdgn-a-JUca58mJnMFwvMUOlbx
    JXdyIB_kuUSvhkUHAFocQqGyYDdt74xim-kjhMuUYkibSDJ62AUzD0>
X-ME-Received: <xmr:j3zeaR_W76uIuIyHSe2ffvdNI-Wve6isteuAksDA-WgKruS3JBQ0TBFFFbiA2LnsH8nrTgWxpeaTXbDPNUAkuluHdRsIQRIyKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtg
    homhdprhgtphhtthhopegthhhrihhsrdhtohhrvghksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtgh
    hithhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:j3zeaWZzwYT5ld0ogzBYdVfwMPu00NpZ6U2KGXjFAEdPSNUmgpNPqQ>
    <xmx:j3zeadOayHGLiVB1AJD63JRWoCEj8KonmCnCcvPrnmGxANEeHI7EHA>
    <xmx:j3zeaaDdVLSVTpVFWzCZ6oxzdxFA-LUhxZQzwQ13UXXkq9iZBTn9KQ>
    <xmx:j3zeacJ4mooaAIN7Vq2YynxI_993mxmR1MT488OkqkgDync65kfr5g>
    <xmx:kHzeaRc8vgzc4YQjHHneM_liUT5-N05EK7Fa98ZNNM5j3m_99MGkdXeB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 13:42:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
Cc: chris.torek@gmail.com,  git@vger.kernel.org,  gitgitgadget@gmail.com,
  peff@peff.net,  phillip.wood123@gmail.com
Subject: Re: [PATCH] checkout: add --autostash option for branch switching
In-Reply-To: <xmqqmrz5eklt.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	14 Apr 2026 06:29:18 -0700")
References: <xmqqa4v6fpj6.fsf@gitster.g>
	<20260414072950.61240-1-haraldnordgren@gmail.com>
	<xmqqmrz5eklt.fsf@gitster.g>
Date: Tue, 14 Apr 2026 10:42:38 -0700
Message-ID: <xmqqy0ipa169.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Harald Nordgren <haraldnordgren@gmail.com> writes:
>
>> Sounds reasonable, but wouldn't it make more sense to call it "autostash
>> from master". We should still be able to abort the merge and merge it to
>> some other branch. I feel like the source is more relevant than the
>> destination, no?
>
> The new comment is for reminder, so "I made this while switching
> from 'master' to this new 'topic'" theoretically has more reminding
> value than "I made this while switching to this new 'topic'".  As I
> outlined my workflow, I usually am on 'master' or 'next' when I end
> up needing "co -m" option, so "I was on 'master' when I stashed
> this" has a much weaker reminding value.  Just like a series of
> "autostash" without any context comment irritated me, I'll see many
> "autostash on master" that I cannot quite distinguish.
>
> But that may be just me.

Thinking about it a bit more, I doubt it would be just me.

The whole point of "git checkout -m other-branch" is "oops, I
started working on this thing while I am on <this> branch, but all
of this changes are irrelevant in the context of this branch and I
realize that they are better done in the context of that other
branch".  So as a name that reminds readers of "git stash list" what
this particular stash entry is about, the name of that other branch
you were switching to is much more relevant than the branch you were
on when you started working on.
