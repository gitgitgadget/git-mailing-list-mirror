Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 869B2350A14
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 20:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769718218; cv=none; b=GIpiY9MijSkbSkS4YO5tgPsKehprm76SxlNoHsZXJydushjReXm5QNi0y/k0rh3fUZmdRmzCcZHJTlj+xIafz2sVBaHS3tE48ehyp2N+Y7twlkeGgI9UT7PUV2ek1RXSQtYEt+xOnPZyhDUKZFnxGCjCrSR0988IU/4IAs5zNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769718218; c=relaxed/simple;
	bh=zY4OEl9xEE0R79MqjzdHVVadlljP8xrFv4oRWaQwIck=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UoXeAcCXQufa3tquagNwmvjE+iHMhsxFR9LRD/+nRJG6cgoGbOg49F0QV/yz4YePPqNhPlDXbvXoINAFce/4J2GhA4C2xMlzJ7gn9iqet4zTQV7P4b0uxFACn0yG1siBhD65n0Jq391FYpAoLnlAy/8RvX4+eA60jkPPSH9XGb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q5OKBY3q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EQg5lOX8; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q5OKBY3q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EQg5lOX8"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id BCE0DEC0265;
	Thu, 29 Jan 2026 15:23:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 29 Jan 2026 15:23:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769718215; x=1769804615; bh=567pmsxHl6
	0aKs2pmL+WrHcu48W5D4VLOzNb6LVrAKc=; b=Q5OKBY3qIRH01At9cfxaOm1mcT
	Nwy0ArvODBuRFYeHEMHCYi9qDRsejV2GJcJbMuBgYioYftIQ3tC7Kp+z4rjAmLuI
	qojLAZ9QslMqo6THP/WtKeYaW2TryTMofDHpif0FnfRE6dx9k1/QT6oDk/gAPwR1
	ZSnz2Fql6oCce4rbBzjDNRozvNPspnoOJ0WQpuo5wuwh8gdlD5LsWZzfTj7zhlvc
	tGUfmKC1I7GT696qK0PaN+71pq8AECyXQCaSo29jfktFi9vaS02LDZrpxvg5ladg
	ydWmfVgOfUdy7a2hLpbNCXIhb6Ao/0eOj7JL1ZbRwaqAlhVBhsG7WRJ3EaLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769718215; x=1769804615; bh=567pmsxHl60aKs2pmL+WrHcu48W5D4VLOzN
	b6LVrAKc=; b=EQg5lOX8bgA1lyfxz9b7L6Yv5dHUfu4faEpP5LKMtCQDdchWOYR
	5mnuf9BRcCoM4E3IvS97KhffN32lyOkKE57sgCW5QU0LIBWRiPYzGTocseRWs2Ve
	O6sW2UAxHa8lpjQKtqcot1M1lqf/un9SE7xDTVjKkVcaYD1p+j44b1WjHVq2CmVY
	UPolgpnsf23JZ14c1k5qNCECTVTy0dnuN5onAXkRIzsLRnYxl5O1KVzbRptmObqR
	MYRt4+U7dqKZxIyH4Lh0lnDYwNU5lz6Cro42Z+HJ4PWc+51LYDScH30wgdzXnG34
	zXq67QOeN/XK3UPC2aIetgCU/r3jnrUqUkQ==
X-ME-Sender: <xms:x8F7aV4o9-j-1hzEXrocg30CoG93R9rB3BDX6fx6koNumRAMjGrEVg>
    <xme:x8F7aZ5kV11EWxCMp_uFa_YJXD2oVswHk-KjPMgN9ZuOjDMpMG5Nc2uRMv5ppVh1m
    kiU0zs5c4UnWqq92MtkLpbxnIFSMdHu2WgZCHX6cy1slBhmSA8p4sw>
X-ME-Received: <xmr:x8F7aRfZLXYCfdFjdFDh17APePFFgM8LtoFDVZejomJOBbO8oahNBPmUYCpboj4nuQFk8nHEurZsTFQ1iZgWiRlt4RHzLs3NmHwS7-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieejudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:x8F7adAm5G5z81e0Y4yDfzTuonkpqDoNSufXnXCfEThupz-Hqz1z7w>
    <xmx:x8F7aU-cBAeN102vJHbujHVyCo-yJ4ASIa_mcBd6icUx6-9n2TyKeg>
    <xmx:x8F7aYLVzwrgucs_hOVHUsxTQsUhH4LuuJiacubg_pMaPsRu9811ug>
    <xmx:x8F7adjHE2w96NI8COEuG89127TB4JWlv6AFvJyScR4tFC_n0tYfaQ>
    <xmx:x8F7aQ-iu81UvphSOLLLbfSsm-Jd-k867NpYBEbQmF9HqlZ_-ctp8pOQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Jan 2026 15:23:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
In-Reply-To: <pull.2183.git.git.1769700352081.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Thu, 29 Jan 2026 15:25:52
	+0000")
References: <pull.2183.git.git.1769700352081.gitgitgadget@gmail.com>
Date: Thu, 29 Jan 2026 12:23:34 -0800
Message-ID: <xmqq1pj8b22h.fsf@gitster.g>
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
> Git already has shorthands like @{upstream} and @{push} to refer to
> tracking branches, but there is no convenient way to refer to the
> default branch of a repository (typically "main" or "master").
>
> Users often want to switch to the default branch regardless of its
> name, especially when working across repositories with different
> default branch names. Currently they must either hardcode the branch
> name or query it via configuration, which is cumbersome.
>
> Add a new @{default} shorthand that resolves to the default branch
> as determined by init.defaultBranch (or falls back to "main" or
> "master" depending on Git version). This allows users to write:
>
>   git checkout @{default}
>
> instead of having to know or look up the default branch name.
>
> The implementation follows the same pattern as @{upstream} and @{push},
> using a new branch_get_default() function that queries the default
> branch name and verifies it exists in the repository.

But @{upstream} and @{push} are inherently very different from what
you are adding, aren't they?  Asking for topic1@{upstream} and
topic2@{upstream} makes quite a lot of sense, because the meaning of
@{upstream} depends on "which branch's upstream are you talking
about???".  But I suspect that asking for topic1@{default} and
expect it would be different from topic2@{default} is nonsense, as
"the default" is not per branch but is an attribute of a repository.
In other words, <branch>@{default} may by itself be a nonsense
query.  Are you rejecting a non-empty <branch> that may appear
before @{default} as an error?

After cloning an upstream project, those who dislike the local
branch name 'master' often rename it to something else, like 

    $ git branch -m master main

and be happy, without configuring "init.defaultbranch".  After all,
that configuration variable affects newly created repositories, so
after renaming 'master' to 'main', it is too late anyway.  In such a
repository, if you say @{default}, what should happen?  As 'master'
branch no longer exist, even though it is the @{default}, should it
error out?  Does your implementation error out?

Also I do not quite see how this would be useful in practice.  Given
that the names of local branches are under control of the local end
user and not upstream projects, I would imagine that the primary
branch used by a user is of per-user nature, not per repository.  In
other words, instead of having to do "git branch -m" after cloning,
you may do "git config --global init.defaultBranch" just once and
keep using the same default name.  Under that condition, "can I ask
what default branch name this repository uses, so that I can work on
that branch" is rarely needed, if you are writing a script to use in
many of your repositories, isn't it?

So, I am not sure.  I wouldn't mind too terribly if <name>@{default}
is rejected, but I do not imagine many people using it.
