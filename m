Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCEA3B8BBB
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 17:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755561; cv=none; b=twT7qphmwYEyu1WC8r0mHIOXCjoBOpwD0OLHkmRA5LGBbBVGnww8AM+cJdoINTdM/ArMCkgR77NtIZJPcgDyrtaIuWjg6vO3rhxGCeP1/Q5vyFJBYZmYYL0nDDuQ5AvAaDkn1i495Ow/rQLxl7XbktjsgprV6Eo0B8/nOiRDY48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755561; c=relaxed/simple;
	bh=/9x4crskL1LlP7aImg63ywi5LjIvobE/yB9aeT80vRg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AdwhAx79Id6O7zZsWHU3vDsRkz6+kNbk8+GkUNKDvVgqFLuEuZ7GRTl7HsEHxuTAK5RpJR1OZGjnbMRY50e/Yz5qOn4r8/bnDLkglEQGHFaftrODi4unJv0JHQbMiMIOYmjYeECFddaEalIsJ4y4M7Hf1Lgpy9PMQbaPxKQI3Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MF0Q4Io0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S+s9LuUu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MF0Q4Io0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S+s9LuUu"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id D2ECEEC0426;
	Thu,  9 Apr 2026 13:25:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 09 Apr 2026 13:25:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775755556; x=1775841956; bh=Mzr+SJEn54
	06e1qGTzFAniGPfehsjPm/dlYf+2uyNgg=; b=MF0Q4Io05zqXo/9aMXEQ0+z796
	3UygVqYluvkww8lwywoa0phuMpbUdycLLMdfcCHzsfubNDKrknRP3tIs5g0Dvud+
	AaEWzyvNvLzisY5p0xi8EM8CSu/Hsiql8wpSOqzrGQXV5O6N+LoaAqHakowwnV6h
	TDhvl7ENjRjr5FBSZC61CkwXXmR3Uzf04DiqLkR2TgSQ7Hi06Sf7HyJ8gktuE+iJ
	6GBF2/igomX8fyn7bt+5TpDFWd6v2jWpjxIR/sYliAo4Y1eO6AIFDBk9Z1MWVsgO
	kXseicks9k4Exl6hcfumQF+WrG1VbR9IdrWy/M5hjLrH1ENRGqkgFM60DTbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775755556; x=1775841956; bh=Mzr+SJEn5406e1qGTzFAniGPfehsjPm/dlY
	f+2uyNgg=; b=S+s9LuUu/VjBHOP9wqUvMOqZLUkyKZoW5V8NQ8CY9IZbtrSACjk
	sIsTrCzzc0bwNXNjxRAEo/PQkmjy9/JC54/xeqSeWDIF7N0nxORSsgVdpezKkNpg
	HbQPNo0CEfyKwvrJwwBhm1ng6s9Ex9KaDT1qGYwvy9EkvJ3ciM+rOwMZSwKUZRbp
	0JxsESEmiW6glmXpdoEmWz7puKjlaHfyMQFLPmBj4Xd7zRYaNFG1+N7xG8K7aFKi
	YrmRMNDdTxjruGje5136k4k8QlQrNaG48pcfm1ISfShHDG2ymPrrhZZfrU5db3cK
	b5vsIdQR6iyuRDUwMIFoAZGuBaM+j14db5g==
X-ME-Sender: <xms:JOHXaWPymDDaYVydFxskLwquUsAE186bbr5YKhTmnwFfye3dX1SK2A>
    <xme:JOHXab0MVYPujqnaIFq6WbpZ5h6Yq8mWIouMJw5tKR_gAfgx6N74073vniatIi7rO
    8z8TD7ebdvJmqYlKag6C6wtZETfMqClryq2Ns5MfGAT3CL7CQ8ZPQ>
X-ME-Received: <xmr:JOHXaVnN9puN077nE0wfB1wSf6l2i5MiWK3HyO1RtmcMGzXCz-ZSma5tbCLkozt1jbZZmCc0j7oOl7yiBCehyoY5-Ikw7ec29g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehhrg
    hrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JOHXaSWPQCaAhUy_1cgcqWtho3pxE8BDc48vt84aZf3fzFBnYbX8zw>
    <xmx:JOHXabvtSYtqrBXLebAVrLO9abDnOJE6UYapiK5UrjNPWEFxlJ_Gfw>
    <xmx:JOHXaVaUcBC5GvgYHMtzAmBmx-CGV31keR2YbpvNRPMUU2x_5fxjIQ>
    <xmx:JOHXaaW0tc7gyx3oBlD1XFaEMcIPbudFFMmwNkZGhoACPNVOd-yWxw>
    <xmx:JOHXafGGiajkyRMwKSrUJL9bisSXUS518q9I79iVMfAuNCqLkShJOLoG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 13:25:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Phillip Wood <phillip.wood123@gmail.com>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v7 1/4] stash: add --ours-label, --theirs-label,
 --base-label for apply
In-Reply-To: <284075600aeb1fc2711be72ca201de3efd81e365.1775741265.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Thu, 09 Apr 2026
	13:27:42 +0000")
References: <pull.2234.v6.git.git.1773740139.gitgitgadget@gmail.com>
	<pull.2234.v7.git.git.1775741265.gitgitgadget@gmail.com>
	<284075600aeb1fc2711be72ca201de3efd81e365.1775741265.git.gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 10:25:55 -0700
Message-ID: <xmqq7bqgujto.fsf@gitster.g>
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
> Allow callers of "git stash apply" to pass custom labels for conflict
> markers instead of the default "Updated upstream" and "Stashed changes".
> Document the new options and add a test.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>  Documentation/git-stash.adoc | 11 ++++++++++-
>  builtin/stash.c              |  2 +-
>  t/t3903-stash.sh             | 18 ++++++++++++++++++
>  3 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-stash.adoc b/Documentation/git-stash.adoc
> index b05c990ecd..6829ba1140 100644
> --- a/Documentation/git-stash.adoc
> +++ b/Documentation/git-stash.adoc
> @@ -12,7 +12,7 @@ git stash list [<log-options>]
>  git stash show [-u | --include-untracked | --only-untracked] [<diff-options>] [<stash>]
>  git stash drop [-q | --quiet] [<stash>]
>  git stash pop [--index] [-q | --quiet] [<stash>]
> -git stash apply [--index] [-q | --quiet] [<stash>]
> +git stash apply [--index] [-q | --quiet] [--ours-label=<label>] [--theirs-label=<label>] [--base-label=<label>] [<stash>]
>  git stash branch <branchname> [<stash>]
>  git stash [push] [-p | --patch] [-S | --staged] [-k | --[no-]keep-index] [-q | --quiet]
>  	     [-u | --include-untracked] [-a | --all] [(-m | --message) <message>]
> @@ -195,6 +195,15 @@ the index's ones. However, this can fail, when you have conflicts
>  (which are stored in the index, where you therefore can no longer
>  apply the changes as they were originally).
>  
> +`--ours-label=<label>`::
> +`--theirs-label=<label>`::
> +`--base-label=<label>`::
> +	These options are only valid for the `apply` command.
> ++
> +Use the given labels in conflict markers instead of the default
> +"Updated upstream", "Stashed changes", and "Stash base".
> +`--base-label` only has an effect with merge.conflictStyle=diff3.
> +
>  `-k`::
>  `--keep-index`::
>  `--no-keep-index`::
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 0d27b2fb1f..54bcb6ac73 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -44,7 +44,7 @@
>  #define BUILTIN_STASH_POP_USAGE \
>  	N_("git stash pop [--index] [-q | --quiet] [<stash>]")
>  #define BUILTIN_STASH_APPLY_USAGE \
> -	N_("git stash apply [--index] [-q | --quiet] [<stash>]")
> +	N_("git stash apply [--index] [-q | --quiet] [--ours-label=<label>] [--theirs-label=<label>] [--base-label=<label>] [<stash>]")
>  #define BUILTIN_STASH_BRANCH_USAGE \
>  	N_("git stash branch <branchname> [<stash>]")
>  #define BUILTIN_STASH_STORE_USAGE \
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 70879941c2..dd47c1322a 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -1666,6 +1666,24 @@ test_expect_success 'restore untracked files even when we hit conflicts' '
>  	)
>  '
>  
> +test_expect_success 'apply with custom conflict labels' '
> +	git init conflict_labels &&
> +	(
> +		cd conflict_labels &&
> +		echo base >file &&
> +		git add file &&
> +		git commit -m base &&
> +		echo stashed >file &&
> +		git stash push -m "stashed" &&
> +		echo upstream >file &&
> +		git add file &&
> +		git commit -m upstream &&
> +		test_must_fail git stash apply --ours-label=UP --theirs-label=STASH &&
> +		grep "^<<<<<<< UP" file &&
> +		grep "^>>>>>>> STASH" file
> +	)
> +'

Two and a half things I noticed.

 * use "test_grep" to validate the result, like you did in other
   patches to the tests.  t3903 is rather old and has uses of raw
   "grep" but majority of the tests should already be using
   test_grep.

 * Not validating the base line is a bit unexpected.  Even without
   giving --base-label to the "stash apply" command, we could make
   sure that the output says "|||||||" (and nothing else) for the
   base label.

 * When these labels are set to an empty string, I think we should
   refrain from adding a trailing " " after these marker characters.
   Should we add a test case for that, e.g.

	test_must_fail git stash apply --ours-l= --theirs-l= &&
	test_grep "^<<<<<<<$" file &&
	test_grep "^>>>>>>>$" file

>  test_expect_success 'stash create reports a locked index' '
>  	test_when_finished "rm -rf repo" &&
>  	git init repo &&
