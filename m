Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1085F2111
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 16:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735403137; cv=none; b=ljrR6OP4NiQdti1hcLR7HJjeS4cRnm3FQxO1A02wVuCZGM8Hqqnhhu9DVJ3WIUyMtmrWy44cGkFVl3ADIGscsQrABWQL6u364ILx4QiD/TAESIV4KAw/S2riAlQc/Os0PRWkMZcqkGH6cmk+gQSkxIQfb60KtIsueQNnBoUqM8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735403137; c=relaxed/simple;
	bh=CrDfY0B+MbyrWsfnAUVYwWglioreeCsMGCKkdfon8J4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZAC7VddVzUlSiElSkl0GsbPe6gs2zdA/JqS1KUJCgOweW4R3vutMyKRad1lp854GFQh92VmAI4iKs825YxkBrke4JfWhQbQNkvooEIKY0x3wGv6sKbv8plm8ZOUn8Qk9mAQZ6E7D0CQ8G4WyrKpHZ+UioNPRhUl0n0KIZOssPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=bsrEyAxO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n8HCOAHl; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="bsrEyAxO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n8HCOAHl"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id EEC741380193;
	Sat, 28 Dec 2024 11:25:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sat, 28 Dec 2024 11:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1735403133;
	 x=1735489533; bh=CaDSiG76JzdBvWIbmRBNadnxvdqhuwJ3izT3ZwEumTk=; b=
	bsrEyAxOLkwp0YD9pDVJS8Qt1ZU66kjGr25yNcyS4HxdVf3VQiMzU1nwDJUCs9Nr
	uROj9gBTSXzPWzZkVrtam6O8ps1WyQGlNcBMN8fgFRFXx4n1MkfbyXGgN4vMKQWk
	xk0/sUU+G5eXonqa+8ZI2N1eVovy14/i/+KL3jQ1XBgcUm3SXAZ6jTTw5I1msQWp
	xxEoNhelNAp5ilb8VKPySkWlSoPNHcYZB4mIIU3yRs7UKjMwf4MwOSZywyy3glWl
	WwTBFufgo/w+Aevs5Wqmrb84QGQPAcoJVQxEw0dhZM6Q6WNG/zfCAESBEcFc2jp1
	FThNTd6l8gQzkq4j1k0gXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735403133; x=
	1735489533; bh=CaDSiG76JzdBvWIbmRBNadnxvdqhuwJ3izT3ZwEumTk=; b=n
	8HCOAHlzB6lBwQmOowL1nwaT/ySVbQEwzqiulVXsg1HafpvHh3pBnVnq2HHdg/Dn
	zdmetCbsd1Kq13WrKpzde+DU16rlFjcBZjk96DI5e0EAJBlBZVEFWwqQIHprt88p
	lotDeMW71WhiAkyzTOqU2xQzH5sCkwJWwh74AzdNdo0ajPxwzZujkBM45JIg3Wjp
	pAJWpfnh3fyDgm7OcgkOprE8Zu8+pboJNXAUV4G5AGqHIxo0YVdRo5IyZMpnmqAJ
	0T/iRBT+TI4x0zSxBZSWmFP1KOvvYr+WAUpljTz+znwZ7EkKGKubJ7i4sTCSlyRh
	9e2+PoFI60+zkvzj2s0Yg==
X-ME-Sender: <xms:fSZwZzlZnqytQyCmwtrTiQQser4EWuzaMY-WPGeSFLBNK_1chm7yqA>
    <xme:fSZwZ21PF7rarHFI_5PaXHN-iM-hDk9rFOzkXptmvLFoBUBvhC7qpzOKRcMmd31_S
    KlxDbckVOrVOzQsAQ>
X-ME-Received: <xmr:fSZwZ5oXJePmyQCDg_PcObZhTZLlAGHzRkjffjI_pi9_JE7LtBGd5yjZrYY9OszBHXrVWcaCq-IX9DaTi0Q5rf5RzHyVXOZ0-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvvddgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehshhhusg
    hhrghmrdhkrghnohguihgruddtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:fSZwZ7nU2pxgXM4WFI8Q9Wd9m8CcR7VVA4VN0ALESTakPY9PyiSMkg>
    <xmx:fSZwZx2NGikkLSLJg5TZV9vBRUZAjvqBZ3gUJP3XB7uA-Dq9LS73zg>
    <xmx:fSZwZ6u_uBjDe5C3Hcbu_7dX-YJiGHNXBXEcRHYFbDIvDpJDEw_99Q>
    <xmx:fSZwZ1XPHvHMvQUNU4EiPWvL13UogVuURkdhG7w0KiP29HVusaoQ5g>
    <xmx:fSZwZ594yMxxFessqbhGMg_BuwmgQpVjdXgNgBGCfW9CnCN6uHHeVKhK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Dec 2024 11:25:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Shubham Kanodia
 <shubham.kanodia10@gmail.com>
Subject: Re: [PATCH v2] maintenance: add prune-remote-refs task
In-Reply-To: <pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com> (Shubham
	Kanodia via GitGitGadget's message of "Sat, 28 Dec 2024 10:07:41
	+0000")
References: <pull.1838.git.1734946566885.gitgitgadget@gmail.com>
	<pull.1838.v2.git.1735380461980.gitgitgadget@gmail.com>
Date: Sat, 28 Dec 2024 08:25:32 -0800
Message-ID: <xmqq8qrz4vwj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Shubham Kanodia via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Shubham Kanodia <shubham.kanodia10@gmail.com>
>
> Remote-tracking refs can accumulate in local repositories even as branches
> are deleted on remotes, impacting git performance negatively. Existing
> alternatives to keep refs pruned have a few issues — 
>
> 1. Running `git fetch` with either `--prune` or `fetch.prune=true` set will
> prune stale refs, but requires a manual operation and also pulls in new
> refs from remote which can be an undesirable side-effect.

It is only true if you cloned without any tweaks.  For example, if
you cloned with the single-branch option, you would not pull in new
refs, wouldn't you?  Also "requires a manual operation" is not quite
a good rationale, as you could have placed such a "git fetch"
instead of "git remote prune", in the maintenance schedule.

For this to become an issue, the condition we saw in earlier
discussion, i.e.

    while having the *default* refspec
    "+refs/heads/*:refs/remotes/$name/*" configured in
    remote.$name.fetch

is crucial.  Since that is the default refspec "git clone" gives
you, your "git fetch --prune" would give you full set of refs while
pruning, and the end result is that you have up-to-date set of
remote-tracking branches (which you may not want).

> 2.`git remote prune` cleans up refs without adding to the existing list
> but requires periodic user intervention.

You have a SP after "1." but not after "2.".

> This adds a new maintenance task 'prune-remote-refs' that runs
> 'git remote prune' for each configured remote daily. This provides an
> automated way to clean up stale remote-tracking refs — especially when
> users may not do a full fetch.

"This adds" -> "Add".

I'd strike the latter sentence.  Regardless of what users do or do
not do, the automated clean-up is performed.

> This task is disabled by default.
>
> Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
> ---

> +NOTE: This task is opt-in to prevent unexpected removal of remote refs
> +for users of git-maintenance. For most users, configuring `fetch.prune=true`
> +is a acceptable solution, as it will automatically clean up stale remote-tracking

"a acceptable" -> "an acceptable".

> +branches during normal fetch operations. However, this task can be useful in
> +specific scenarios:
> ++
> +--
> +* When using selective fetching (e.g., `git fetch origin +foo:refs/remotes/origin/foo`)
> +  where `fetch.prune` would only affect refs that are explicitly fetched.
> +* When third-party tools might perform unexpected full fetches, and you want
> +  periodic cleanup independently of fetch operations.
> +--

Very well written.

> @@ -913,6 +914,30 @@ static int maintenance_opt_schedule(const struct option *opt, const char *arg,
>  	return 0;
>  }
>  
> +static int prune_remote(struct remote *remote, void *cb_data UNUSED)
> +{
> +	struct child_process child = CHILD_PROCESS_INIT;
> +
> +	if (!remote->url.nr)
> +		return 0;
> +
> +	child.git_cmd = 1;
> +	strvec_pushl(&child.args, "remote", "prune", remote->name, NULL);
> +
> +	return !!run_command(&child);
> +}
> +
> +static int maintenance_task_prune_remote(struct maintenance_run_opts *opts,
> +					 struct gc_config *cfg UNUSED)
> +{
> +	if (for_each_remote(prune_remote, opts)) {
> +		error(_("failed to prune remotes"));
> +		return 1;
> +	}
> +
> +	return 0;
> +}

Nice reuse of the program structure, which is very clean and easy to read.

Overall very well written.  Will queue, with attached range-diff.
Thanks.


--- >8 ---
1:  0ae9668b5c ! 1:  8a40f8b319 maintenance: add prune-remote-refs task
    @@ Commit message
     
         Remote-tracking refs can accumulate in local repositories even as branches
         are deleted on remotes, impacting git performance negatively. Existing
    -    alternatives to keep refs pruned have a few issues — 
    +    alternatives to keep refs pruned have a few issues:
     
    -    1. Running `git fetch` with either `--prune` or `fetch.prune=true` set will
    -    prune stale refs, but requires a manual operation and also pulls in new
    -    refs from remote which can be an undesirable side-effect.
    +      1. Running `git fetch` with either `--prune` or `fetch.prune=true`
    +         set, with the default refspec to copy all their branches into
    +         our remote-tracking branches, will prune stale refs, but also
    +         pulls in new branches from remote.  That is undesirable if the
    +         user wants to only work with a selected few remote branches.
     
    -    2.`git remote prune` cleans up refs without adding to the existing list
    -    but requires periodic user intervention.
    +      2. `git remote prune` cleans up refs without adding to the
    +         existing list but requires periodic user intervention.
     
    -    This adds a new maintenance task 'prune-remote-refs' that runs
    -    'git remote prune' for each configured remote daily. This provides an
    -    automated way to clean up stale remote-tracking refs — especially when
    -    users may not do a full fetch.
    -
    -    This task is disabled by default.
    +    Add a new maintenance task 'prune-remote-refs' that runs 'git remote
    +    prune' for each configured remote daily.  Leave the task disabled by
    +    default, as it may be unexpected to see their remote-tracking
    +    branches to disappear while they are not watching for unsuspecting
    +    users.
     
         Signed-off-by: Shubham Kanodia <shubham.kanodia10@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
    @@ Documentation/git-maintenance.txt: pack-refs::
     ++
     +NOTE: This task is opt-in to prevent unexpected removal of remote refs
     +for users of git-maintenance. For most users, configuring `fetch.prune=true`
    -+is a acceptable solution, as it will automatically clean up stale remote-tracking
    ++is an acceptable solution, as it will automatically clean up stale remote-tracking
     +branches during normal fetch operations. However, this task can be useful in
     +specific scenarios:
     ++

