Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FBD16CD33
	for <git@vger.kernel.org>; Sun,  3 May 2026 20:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777841991; cv=none; b=h8VO8l04XrJVFRZSsEznuViTJkfPIRqFtD+FH66b3hTSn4+oWbAPX04FyrU/xnf4S13+5xIg7uQA6SEAxLzK+wqP9OZZeLAOxo5K185ldhEKOISgwdAeYITkYWU6sWW08/8mAGKgWXqKJ7dY/+rEKMReKEGMtp3Mjtq8RPgkma8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777841991; c=relaxed/simple;
	bh=PmJtJsCZm9HE2c4wn5VV5pPny7mQbAvFWgqkBm0hbec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ciFABbc9veNpUvwkhNj3Iq9vmuQSuw87lpHUixMsr7RbgeK1gzgLZLzQ+WWB/FoPWUZRvtH87Bm9OKj/GoyvBVyflSxqOgnrGp78GYmUT5WvDnWrfKJD3b5/6k3jTg/2/qagxN/vp1JeivRk9xSOt8p1jdxvkdHRGVQ71Y2xqpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B5cVqyd1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jtHSBliK; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B5cVqyd1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jtHSBliK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 156FF140006D;
	Sun,  3 May 2026 16:59:49 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 03 May 2026 16:59:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777841989; x=1777928389; bh=7h3EUIvQdt
	0ju74iBWO/l7zuCwUNrDvYKe4EydfDFzo=; b=B5cVqyd101oz3xjw+hWOoj3JL4
	DdjvQ+Q9I5J9UpU0ZsZl84N0P2T3eXKK+658KmN5AGpCMdDiME79/R9W/NHDYSZK
	oRbrMFWRz9JcC6sIGa1UaGkfhKqGwspjCZ5jvPJZcTS444AO6X8LXaUzVGel3ZDd
	AD8nWTzxtbb7LSgOV2s7pPckm2UQr+/fGTH/6i5PKUTIj/XtbWQHFbf+wpwW797V
	Nl1lJtIND1UgSEX0a8/Q/x8tbUJEXPp7Rk4lacIih5FjPU+T2bIEA5/jK3OD+h/b
	riir0cbsK822HacPOp1X4BqQth2FuLYm/2fGDLL8fb4GX46WwSnRhZIXaNnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777841989; x=1777928389; bh=7h3EUIvQdt0ju74iBWO/l7zuCwUNrDvYKe4
	EydfDFzo=; b=jtHSBliKQIxz/sG4ZYdgKRJEjtiqKMw3VDqDPS4oNEW0Tbx2kGX
	EHQXRoB/GrNydpxwuorCe30YdfMTa4hTx4h7cYQYyXjOm4fPsu9iKMr7euINTTrw
	qvLElTV6BUANKSwIQ27XYds+WhGex+6PLqro89u2GQtU9T+bScUMRiJqC4oit8fv
	azEqKaFZzuodwwFZLj21tt7vDN5WC5twh6NAi0/kiV4gKeOjmB9+dMnu+ALCjmcz
	KU2R+takDPAtqVWZWBO3JWVaGti8TYxSnVQKBQguuz58fGTldF9MVpygiiDlFB0j
	vswf8drq104nqumV2HGPU1mSbVKtXYhzj6Q==
X-ME-Sender: <xms:RLf3aZrmUghiCc7M3Luuw-CkXIJJd8e0kzGrYg-BFLwT4SFn3SarQA>
    <xme:RLf3aVqpW50PZF_yVv4WnD-tIv51Ww4Jrx-zGlssop73-myPjSbyCAC7rr0i08TEL
    zMiqJIkPV1SQvPAqgNMdGnIkSaJDGmRWK0It0Z3QTQevTJ-7lUY2Bg>
X-ME-Received: <xmr:RLf3ac2FZK1ZnTw7JJpVX_kMaDFAem-6KToefS3q4KupomyrnZtEswL17AAS5QsA2h-yt2LGkZwz3C7yTNQHubPq86tmUbdqDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdelieelkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhope
    gsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmrg
    hrtghnrghrtgesghhmrghilhdrtghomhdprhgtphhtthhopehhrghrrghlughnohhrughg
    rhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:RLf3aTEktyPQjcOAfDd_-nmuUu81jMEK2Jsoe8fgf1p4b0Sp68kvJg>
    <xmx:RLf3aXG_bR0VOYn7swcGEbvASiZ9I--I8BAOvKKT3BYBf-e1MtEKWw>
    <xmx:RLf3aW7pmc6TmhJ1TPgCuhD2JzzFEphE_PzSum3QMYqC7lzgTgKCrw>
    <xmx:RLf3acwMx1tdeC0PA_JzjLA_92xRxj5maN5jOFYG1QmLNn3LPQHMnQ>
    <xmx:Rbf3aXIu3OOGUUwdjWUtqr_niXotdruT_msRgJIAR_EP5adSBi9v4IRV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 May 2026 16:59:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Ramsay Jones <ramsay@ramsayjones.plus.com>,  "D.
 Ben Knoble" <ben.knoble@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Marc Branchaud <marcnarc@gmail.com>,
  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v5] checkout: extend --track with a "fetch" mode to
 refresh start-point
In-Reply-To: <pull.2281.v5.git.git.1777367012441.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Tue, 28 Apr 2026
	09:03:32 +0000")
References: <pull.2281.v4.git.git.1777228346809.gitgitgadget@gmail.com>
	<pull.2281.v5.git.git.1777367012441.gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 05:59:47 +0900
Message-ID: <xmqqse88ryyk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> A common workflow is:
>
>     git fetch origin
>     git checkout -b new_branch --track origin/some-branch
>
> The first command exists so the second sees an up-to-date view of the
> remote. If it is forgotten, origin/some-branch points at a stale
> commit and the new local branch is created from the wrong start
> point.

As I pointed out multiple times, I prefer not to see this called
"wrong".  Even if you did not "forget", somebody may be pushing
after you fetched and you may end up forking from a "stale" commit.
So not fetching is not inherently "wrong", simply because that is
how real world works.  Multiple people working in a distributed
environment does not give you absolute garantee that you will be "up
to date", ever, which makes it wrong to call anything that is not
"up to date" a "wrong starting point".

> This only matters when the user is setting up tracking and
> expects the new branch to start at the freshest tip; for a one-off
> checkout of an arbitrary commit there is no reason to "freshen" the
> start-point.

I do not think "arbitrary" fits in this workflow description.

If anything, "I'd take anything that the remote repository happens
to have at the tip, even without having a chance to sanity checke if
that is a good starting point" is more appropriate workflow to be
described with a word "arbitrary commit".

If you are checking out without forking from there, you'd more
likely be checking out the "latest" you have fetched from the other
side, often knowing exactly what it is after checking it with "git
show origin/$topic".

> Tie the new behavior to --track for that reason:

Notice that the reader hasn't heard what "the new behaviour" is up
to this point yet?

How about rewriting everything up to and including this "Tie the new
..." line perhaps like so:

    If you want to fork your topic branch from the very latest of
    the tip of a branch your remote has, you would do:

	git fetch origin some-branch
	git checkout -b new_branch --track origin/some-branch

    Extend the "--track" option of "git checkout" and allow users to
    write

	git checkout --track=fetch -b new_branch origin/some_branch

    to (1) fetch 'some-branch' from the remote 'origin', updating
    the remote-tracking branch 'origin/some-branch', (2) arrange
    subsequent 'git pull' on 'new_branch' to interact with
    'origin/some_branch' and (3) fork 'new_branch' from it.
   
    In the value of the '--track' option, 'fetch' can be combined
    with ...
