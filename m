Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636E31B0F23
	for <git@vger.kernel.org>; Sat, 14 Jun 2025 23:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749944139; cv=none; b=KLspPxlBGuSaS1yTt/OTCO1Ul/taC2PEmDpsaulh2ItwpMxOVcb/mGpOoEEReSV5cqXYrzcF6OO0sYeESpt13Bd9PVE/oEcN/a+Jkd/g9FeAL188A/k/HL0oWW36d48q8rNtayWYi9Dp5mdBP70mqyYeRYn+xh1ONxa2vTKcWrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749944139; c=relaxed/simple;
	bh=4DA11HFIZd32Hssv87J1E/xC53M/EhlqWFsKvtk4A70=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k0dGtz+AWqlmYLa/NotFQH4neggKjoSlEhdqAUJ2gVi03t/yMTnagqI28QvqZDrLHNvFk0AkqRjnbFQb1IFYqFyF84giJtPE0+brzivVhcnVAQA8EVENDslh0DC/NHSTbGFVLqLSmoMYAplQCeu34LFyLxCHGbWgUGkJBvySLPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iWXAnEDu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bDRORMCu; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iWXAnEDu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bDRORMCu"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id DF52011400E8;
	Sat, 14 Jun 2025 19:35:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Sat, 14 Jun 2025 19:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749944134; x=1750030534; bh=3FBCxzsskD
	ElVob96P82P1m6LTZPCCZ35HXgy/WIFTA=; b=iWXAnEDuRNyCd+HQa1L9h0wlxU
	jXaVFEKArSit2kcjZbO/gRZ+sR6q5DyLYqxBYmOhqBOWogL5k4bUXRxEHy0x8wN6
	GBA8noG2g6WGtTfYLEVIs4zzmT55F5lS468auCkGNjRom/gXWS5/zDOldc+g12qh
	d79Zv6Be5XKn/3J3TuBe949Oa+KCMG6j6U9lQBwadZQ6VLJh98VMoFZS4RfLdxeD
	CiOWg8XSzMkWjp321a3T6b1fTUlOBj9eZMVkwhw8uPtHvK//3LvlaeFIWmz4eYrb
	JRR4OqjPh8kHhW179ivYbBozgrXA61fyZzqrAaboCJwizyXcqn42wDdeWpyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749944134; x=1750030534; bh=3FBCxzsskDElVob96P82P1m6LTZPCCZ35HX
	gy/WIFTA=; b=bDRORMCuvfxqsXhvNK/bA2N7Ct0SrYZIfMQ2dEMfGMOx7Bf2bp3
	ANFN6SsFe4JfpUPSc+1pmnXJ9uysitaLRgRpCCo0Lb/aMaDLAI3HUWV1pOgD+AkY
	lEDq92DDcLHxLh8OmZuMJB5qXUNOoOP3sTOO8rTQokNysOXxF9mf8HT1tIuTPXIP
	fHTxxRBsSXFg0FHllV3wwjwTz9qswkBPyVuV1npGOfIXVWY4DB02/JIkkOmIf39S
	Fn4zpAhDGPP9r20RXY57CVB2/f8htchKm4DDHBLtgq/QnBcL0gtQ8k4lcv092N7u
	pXn+36s09YZ6KX+YJjgzu8hCt9neNDte4rA==
X-ME-Sender: <xms:RQdOaGRq8cck0vibx9pnxC-_fi8aPJrR0We2B5VlXGtBhO4bMp64Xw>
    <xme:RQdOaLxAhhvA-nFTZW3oSPI11bZ54aMEwN2DZgzVfVfoo95pcHslaILJlxbn9zfRe
    ZdxihEGhjgMuIcFxg>
X-ME-Received: <xmr:RQdOaD3QAgNQ1r_Tmdss6foPbwtBCR6uL10FzqXEruN3o7rtNwIkNZFt7lWMw-91Zcav7RC0wyd5LwjUH_kd5TfeVGWgLpg0oWyO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvvddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgr
    nhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfe
    evteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrh
    esphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohephihlughhohhmvgdvugdvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeehtddvtddvgeef
    fedttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtoheprgihuhdrtg
    hhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghn
    rdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehshhihrghmthhhrghkkh
    grrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:RQdOaCDkaPKGF71rhsyf-f1mKi8oVQFq-0BA_td7zjHe9H7SkuctDw>
    <xmx:RQdOaPilYb3KTzrW-PVQJ6a35gj_5U_NeM2TCguRKRO9TjTycJPMsQ>
    <xmx:RQdOaOoWN--tZlhm4uexRz4qDKshBwLvUCYINru8RT8CFPeuWBJjcw>
    <xmx:RQdOaCiPYNfiM0e-Maifx7ksRyQ2HnOkkDxQNbDtE8EwW8dC7opXBw>
    <xmx:RgdOaASMscWV35dcWluArlm_hWuIhe-f6TotkVupYmxkPgXcqmFHfHdL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Jun 2025 19:35:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: git@vger.kernel.org,  502024330056@smail.nju.edu.cn,
  ayu.chandekar@gmail.com,  christian.couder@gmail.com,
  shyamthakkar001@gmail.com
Subject: Re: [PATCH v2] git.c: remove the_repository dependence in
 run_builtin()
In-Reply-To: <20250614050331.304405-1-502024330056@smail.nju.edu.cn> (Lidong
	Yan's message of "Sat, 14 Jun 2025 13:03:31 +0800")
References: <20250612045905.3023227-1-502024330056@smail.nju.edu.cn>
	<20250614050331.304405-1-502024330056@smail.nju.edu.cn>
Date: Sat, 14 Jun 2025 16:35:31 -0700
Message-ID: <xmqqwm9d6gn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> The comment preceding trace_repo_setup() was originally introduced
> in commit a9ca8a85. Since get_git_dir() modifies global variables
> such as git_dir and git_objects_dir which only valid when inside a git
> repository. The intention of the comment was to emphasize that
> get_git_dir() should not be called before confirming that the current
> directory is indeed part of a git repository. However, get_git_dir()
> has since been renamed to repo_get_git_dir(), and repo_get_git_dir()
> no longer modifies the global the_repository state. As a result,
> the original comment is no longer relevant and can be safely removed.

Sorry, but the above makes it sound as if 246deeac (environment:
make `get_git_dir()` accept a repository, 2024-09-12) that retired
get_git_dir() and introduced repo_get_git_dir() was the culprit that
made their semantics change, but is that really true?  It appears
that in the version immediately before that commit, get_git_dir()
was also a reference to a variable, without any lazy initialization
the above message says that the code tries to avoid, so I am even
more confused after reading the above.

Perhaps you have 73f192c9 (setup: don't perform lazy initialization
of repository state, 2017-06-20) in mind?  That one did stop calling
setup_git_env() and instead force a hard BUG("") when git_dir is not
set up yet.  And that BUG("") still survives in repo_get_git_dir()
we have today.

So the call to repo_get_git_dir() may still not be made from this
code path.  It may not attempt to set up, but instead it would die
if we haven't successfully set up the repository before.  The
relevance of the comment was not changed by 246deeac that moved this
code from get_git_dir() to repo_get_git_dir(), and more importantly,
it was not changed by this patch we are reviewing here.

But stepping back a bit, is it what a9ca8a85 originally wanted to
achieve with this comment to "avoid calling get_git_dir()" in the
first place?  Once the guarding condition is satisfied, it calls
trace_repo_setup(), which in turn calls get_git_dir() anyway.
Perhaps it wanted to explain why startup_info->have_repository is
checked here?

> Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
> ---
>  git.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/git.c b/git.c
> index 77c4359522..429ad1c2fb 100644
> --- a/git.c
> +++ b/git.c
> @@ -462,12 +462,11 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv, struct
>  	precompose_argv_prefix(argc, argv, NULL);
>  	if (use_pager == -1 && run_setup &&
>  		!(p->option & DELAY_PAGER_CONFIG))
> -		use_pager = check_pager_config(the_repository, p->cmd);
> +		use_pager = check_pager_config(repo, p->cmd);
>  	if (use_pager == -1 && p->option & USE_PAGER)
>  		use_pager = 1;
>  	if (run_setup && startup_info->have_repository)
> -		/* get_git_dir() may set up repo, avoid that */
> -		trace_repo_setup(the_repository);
> +		trace_repo_setup(repo);
>  	commit_pager_choice();
>  
>  	if (!help && p->option & NEED_WORK_TREE)
