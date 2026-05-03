Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86903128CC
	for <git@vger.kernel.org>; Sun,  3 May 2026 22:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777847991; cv=none; b=ku89wPGvNvV/4WrI36+pmErIiIiYDbwv9bqPaElDvoCiYf1pJ3WTeSLaqBte63EupUfONFhe50cP3vYBYp5+rHkbYRrwkFNHa1Fdsti/JvqjCqWTrf2qdsc2MmYLXDUqibyVpeA7RUCDRfcroGtO7foED7wiFeGqSF1bl4MQxxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777847991; c=relaxed/simple;
	bh=b3/kbar33KAx5WtZRPf1C2HjfFx3mQf9N9jG5aG1Btc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UhCcJx5l1vALmlNKemDri7Rj1iu8U89B+p9LuUtlE3mqRBMoI0pxt0OwDp12L+DnRUvZifaEBfKPAqGalmauJZYFgQMDlNQJKTkgjZM4UpYVSKYMw3pfKQ3btiM5lb91YrZ9bS2h+nronG8deMfaX4gGY3VCiVe8jnCSlQ0L53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GIV3TOJn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rrzhKiF1; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GIV3TOJn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rrzhKiF1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E6501EC00B8;
	Sun,  3 May 2026 18:39:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 03 May 2026 18:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1777847988; x=1777934388; bh=sEgggg8CVb
	sGPlfAXSBPxFuHc8BmmMN7mT/xMh2WNIU=; b=GIV3TOJn8xY6GIUcsFWUWciJvz
	cFGavzGjgBuPK5KvJplzgI3I/nLmjgMVsDKk8FSewTKeXp1dEQ4jGNqmSNMT9PSN
	VGfy2DcVrcHRCGp8lKUS0HS/Dlx7pTBeABGstlCIQsTWN9pg7XtXVflxM8yjJbg2
	0ok8mhiK9rWNdCXfsKAtA6UkzpimACjOj+0HPWzNndB/mkvHtgd2r7ZrRibKJxKi
	kaZtkoP+4tdSiKvXqZptfRZieNItZo9nKNJ/hV8NNbm+4pJwnaQAY4CgtVtd6l4R
	fHfPY/J7hSj7k0ymQcG8l+J50SzT0AGJjbWZGYEI606/fbKT1cVztoAOORgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1777847988; x=1777934388; bh=sEgggg8CVbsGPlfAXSBPxFuHc8BmmMN7mT/
	xMh2WNIU=; b=rrzhKiF1J8yblLm2TGCHBtDWO0+/WsO4cq6oamWzvZRQ7Th52Gj
	T/OBDr4XjIh7KuXcVLPvv5NyzE7SkcEBpXlS4NadrbGHd9/SN2mB51Yjx83oXlci
	j+C45D1BpL0d1beqypjhn1AC6GxVtuciEwnrQ/FU7Dg8iecW/mfXrpa7coz9bC6m
	yLLk70gGvr9B+G68l6vvoK04HSbmt1DwCOtt9nAXovaGRZaTswuOIvS79hsGAGqs
	SWYtKcQ8MA7JsxlpllTtMPHitf+ArjoY488cAQT54AKPY6F3VgKY5lUAcxaoqtZ0
	KGonOCed8gwfd9R76HVKgxQXgbxRhw1AHGg==
X-ME-Sender: <xms:tM73aYn9cMPbWg3W9AO99_1JKg6hpOcET6Wa1C-AHO2nSxSsdW2A2g>
    <xme:tM73ae3JX6ZwAdeO-1uXpstLCeW-_sekLUQkH_qUzcEkvr18KCSuqH2Px_nFBGmdV
    eHC0IIaFKEz85x9iyoX2dPyyxmiiXIJz3zjTGABj7JddRKj7jqoruw>
X-ME-Received: <xmr:tM73abr1mQD0w-jd9We4bRqsjpnFpR9dcmOJta9jc6FiOjNsPnlhgyZ-GrdF-gjccRIfh3CSoOf8_MI03sib8E4vicalZQl7Bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeljedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    hhgrrhgrlhgunhhorhgughhrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tM73aTfK6kDLaW_JUuFrxzInOofSYBZqogZxO7t8gZdcQK8AyEADng>
    <xmx:tM73aSq5ml8Y3wssYVjZyn_Te-2-sQv_NBfLQMX5zo23QzCp7FF41w>
    <xmx:tM73acHgiiSj7g5jCZUWNVImdPhDmclCXsZmsoZbu9df9JNnvtNTAw>
    <xmx:tM73aasr5mxjweyUK2Jiu1OO_5gWm9dA84rFgNNQFuK25GhQF_-_8w>
    <xmx:tM73acFCMb7uv2R2VMG2B1by7YTqC4dweyBtYfbpReUk6NK24LK_Ounn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 May 2026 18:39:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] fetch: add fetch.pruneLocalBranches config
In-Reply-To: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Fri, 01 May 2026 21:35:37
	+0000")
References: <pull.2285.git.git.1777671337839.gitgitgadget@gmail.com>
Date: Mon, 04 May 2026 07:39:47 +0900
Message-ID: <xmqqfr48rubw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Introduce a tri-state config option that, when --prune (or
> fetch.prune / remote.<name>.prune) removes a remote-tracking
> ref, also deletes local branches whose configured upstream is
> that ref.
>
> Values:
> - false (default): no change in behavior.
> - safe: delete only if the local tip is reachable from the
>   upstream tip, preserving any unpushed work.
> - force: delete unconditionally; recoverable only via reflog.
>
> The currently checked-out branch is always preserved.

I do like the feature that allows you to identify which local
branches are already merged and prune them.  It will help users keep
their local branch namespace clean.

I however do not like to see the feature tied to "fetch".  By this,
I do not mean I do not want an option to trigger the feature when
"git fetch" is run.  What I mean is that users should have an option
to prune merged branches without having to fetch first.  And you can
then optionally trigger that machinery from "git fetch".

Of course they aleady can do something silly like

    $ git branch -d $(git branch --list | sed -e 's/^..//')

and remove all the merged branches, but compared to what is
presented here, one thing missing is that you allow pruning the
local branches that are merged only to remote-tracking branches from
a single remote.

To break the feature down to make it easier to use by our users with
various needs and workflows, we would benefit from having a
collection of smaller features that can be composed, like these:

 * "git branch --forked <remote>" lists local branches that build on
   something taken from <remote>s.  The option can be given multiple
   times to make a union of the results from individual "--forked
   <remote>".

   - <remote> may be a name of a remote, e.g., "origin" to mean all
     the remote-tracking branches "refs/remotes/origin/*", 

   - <remote> may be "origin/master" to name a specific
     remote-tracking branch.

   - There may be other handy things to cover with <remote>, like
     "--all" that may act as if you listed all the available
     <remote> on the command line.

 * "git branch --prune-merged <remote>..." is a short-hand for "git
   branch -d $(git branch --forked <remote>...".

 * "git fetch/pull --prune-merged <remote>" can trigger "git branch
   --prune-merged <remote>" after "git fetch" successfully updates
   the remote-tracking branches, which should be equivalent to what
   you have here..

Some local branches that fork from remote and have their initial
round already merged may not want to be pruned, however.  You may
have multi-stage development plans for that topic, and you know
already the second phase would want to build on top of the initial
round, not a random version of the mainline with many topics from
other folks merged in.  So you'd rather want to keep the topic
branch around after your initial round has been merged to the
upstream before you start the second phase.  This is especially true
if your topic is designed to apply to an existing release (in other
words, a bugfix) and you want to keep the second and subsequent
rounds of the topic to be applicable to the same target version
without contaminating the topic with irrelevant features from others
that happened to have been developed and merged upstream around the
same time.

And we'd need to cater to their needs.  By this, I do not mean "they
do not have to use --prune-merged", but by giving them a way to say
"this branch should not be auto-pruned with --prune-merged".
