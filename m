Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45BBB3451D4
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 13:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770384954; cv=none; b=SNDYSevFiYCbEM38j2ajrNb8rbzDeNhuXPU6RYL1QO5tJ5ZrRp5sjr7aeao9VVU3cce7La0VyGv41my245RLyPP7Tk59PeuXzTqegr9KMO9xeC0aBGIQVeSVAtJKpadcpyIodLe+9/W6kI2PJegRUFi9Q9QjJ1a3ssLRFoFNwpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770384954; c=relaxed/simple;
	bh=ckD8aq5fT3ozWSsDxUJIM4fQEnY0VUnwMANga1xyOJg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lAsor4RjFmq4Rr9qYHxpFTUpmgcSsAWv2WiCf6l5zoF+HLsX5wGeA7fgXUrEGGZTuZ4BkpOfZudsuGA7pWIN3fJY3NvplWyIfQlt6jM3PT1bE7iHf/npKSo4bPgjEYsiDiIX01kuBf73AOVLHhwFmptTokIntnCXrPccyGNKlOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=s/LV6tFs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eiHbx3lz; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="s/LV6tFs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eiHbx3lz"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8344514001BD;
	Fri,  6 Feb 2026 08:35:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 06 Feb 2026 08:35:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770384953; x=1770471353; bh=nDJmi3xkG9
	YKgoiJIkbvZSPrI1xyJS+dfiCPbEMSRrg=; b=s/LV6tFsWx3pQj03kuT8dgWe89
	vaPb+n9lO0WoSlFgYrGUeL0IGERaWLdVSudlRR32LNNrx4vee5XSlDYAwvDwtIJ5
	yhObiPgMu7VuFVMVYTLk5dytOcd6fEDGT8XucAZRuY6P+CBdN2TX88uw7TyFqW1C
	+mukUY2uClYS4wMKK6G6SC6DqICa6oz6RUdBMEyeGDo0rJmwrveQd3aM997rSW2c
	DnHIR3g1lCcFTh1sleuOnSevmBYUCnDZXE+dL7w4/CgRqjTIqo9FWAsEVTHgDX8N
	pS6iZvSfjAnDL/PoXko5EvDzMe4b722Trl90C/nXP3HObT9RwwYOT6TCeuBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770384953; x=1770471353; bh=nDJmi3xkG9YKgoiJIkbvZSPrI1xyJS+dfiC
	PbEMSRrg=; b=eiHbx3lzfp3G/T1C5kP0xsq56S47c4NPHwcGOgcD1AgP9K/8svR
	B+XKD35NATVY9ZK8x3fI3TybRom7YyT1SKLmWnl2cY6DFV7MBxzqJvoiMqGtjaaw
	Q7MT2XMIsI3ij1VZn4fV04DwnPhWxvWZ6iVlk0vZfrrXmbJZXaKD+KMa7kplG5tL
	QxamNIv/fRKdtcq24atuRhKtS6bhIm5S8/3xTyyOOTKob6y6P3XME4hW7g8Y9UPG
	AOUTe/nJ1AtEjcHdQjhcyKqBLIG4NVwn6YeQRf9EZ28trbwUFrNbSWNkYIq8Zl0u
	egLtHESBjwuqfMcFm2zYDyEOg+QSL2b0gxA==
X-ME-Sender: <xms:Oe6FaYGwsYrbclff2-kbJmZEtI8k3mtcqriizHm2Wq3y_aa7EZBdtg>
    <xme:Oe6FaYXNVqrdmRUisoGGzh-xmSAYLz2cFOWJiT48u-fZdsZNINMf04S2OR9iQF9oI
    xgTVtSahoSots39rwmuL4jd1vhWY2R5Yx8zH9abNnb_4Hws_sQYDA>
X-ME-Received: <xmr:Oe6FaXINIb5Li1nuSzL3Vf2TCuh47a9FPhuvSay-6xJH4g_Pli1JwDjL5PMjmp7kLASYWXPRdlUk4dIl8JoP1jjB9p4Z3dOy6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekfedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehsrghmsehsrghmsghoshhtohgtkhdrtggrpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:Oe6FaY8zX8BTbo2zgdQjEIHZ4az1dhVA7au6aUxJOkATs99RkH2gWQ>
    <xmx:Oe6FaaKj8KdA1FNFAFc9mZbccKc7vWs7NFntXYI5n9qFeM06jCTTKg>
    <xmx:Oe6FadmFZ1jC86NiifVIANGyLlco7pLXj6v4n_SC6olHXu7dVcsQhQ>
    <xmx:Oe6FaeMGTMDkGT9C--PDP2Z1UWHor2ym0-DowQZKXpoxwTmcAU-0BQ>
    <xmx:Oe6FaRLUIp5oAmUa6l9DKGAbqmQ24rEabS4po8x9YXXcwDYK6QK-k6wd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 08:35:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Sam Bostock <sam@sambostock.ca>
Subject: Re: [PATCH 2/2] merge-ours: integrate with sparse-index
In-Reply-To: <20b9e0bf6e2b12eea1ff50b14d0d2809c601a943.1770345124.git.gitgitgadget@gmail.com>
	(Sam Bostock via GitGitGadget's message of "Fri, 06 Feb 2026 02:32:04
	+0000")
References: <pull.2189.git.git.1770345124.gitgitgadget@gmail.com>
	<20b9e0bf6e2b12eea1ff50b14d0d2809c601a943.1770345124.git.gitgitgadget@gmail.com>
Date: Fri, 06 Feb 2026 05:35:51 -0800
Message-ID: <xmqq343ehu4o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Sam Bostock via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Sam Bostock <sam@sambostock.ca>
>
> The merge-ours builtin reads the index only to compare it against HEAD
> via index_differs_from(), whose diff machinery (run_diff_index) is
> already sparse-aware.
>
> Teach merge-ours to opt out of requiring a full index by setting
> command_requires_full_index to 0.

> Because merge-ours is invoked as a
> subprocess by "git merge -s ours"

It may be correct but I do not see a relevance

> and never previously read config,
> the global variables core_apply_sparse_checkout and
> core_sparse_checkout_cone remained unset,

This may be correct, but it only becomes relevant after somebody
decides to do something to cause is_sparse_index_allowed() to say
Yes.

> causing
> is_sparse_index_allowed() to return false and the index to be expanded
> anyway. Add a repo_config() call with git_default_config to populate
> these globals.

In total, while individual sentences in the above may tell correct
things, the order of presentation makes it hard to understand, at
least to me.

The usual way to compose a log message of this project is to

 - Give an observation on how the current system works in the
   present tense (so no need to say "Currently X is Y", or
   "Previously X was Y" to describe the state before your change;
   just "X is Y" is enough), and discuss what you perceive as a
   problem in it.

 - Propose a solution (optional---often, problem description
   trivially leads to an obvious solution in reader's minds).

 - Give commands to somebody editing the codebase to "make it so",
   instead of saying "This commit does X".

in this order.

So perhaps

    The merge-ours built-in opens the index to compare it against
    HEAD.  The machinery used to do this (i.e. run_diff_index()) is
    capable of working with sparse index, but because of the start
    up sequence of this command does not take necessary steps, we
    end up first expanding the index fully before doing this
    comparison.

    In order to convince sparse-index.c:is_sparse_index_allowed() to
    return true, we need to:

    - enable the global switch "core_apply_sparse_checkout" via
      the core.sparsecheckout configuration variable.  merge-ours
      currently do not even read basic configuration, so we need to
      make the configuration call ourselves.

    - set command_requires_full_index to 0.

    With that, the command can work without expanding the index
    fully before doing its work.

or something.

Thanks.

> Add tests to t1092 verifying that "git merge -s ours" produces
> identical results across full-checkout, sparse-checkout, and
> sparse-index modes, including verifying the resulting merge commit
> structure, and that the sparse index is not expanded during the
> operation.
>
> Signed-off-by: Sam Bostock <sam@sambostock.ca>
> ---
>  builtin/merge-ours.c                     |  6 ++++++
>  t/t1092-sparse-checkout-compatibility.sh | 14 ++++++++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
> index 2312e58ab3..405b2989f7 100644
> --- a/builtin/merge-ours.c
> +++ b/builtin/merge-ours.c
> @@ -10,6 +10,8 @@
>  
>  #include "git-compat-util.h"
>  #include "builtin.h"
> +#include "config.h"
> +#include "environment.h"
>  #include "diff.h"
>  
>  static const char builtin_merge_ours_usage[] =
> @@ -22,6 +24,10 @@ int cmd_merge_ours(int argc,
>  {
>  	show_usage_if_asked(argc, argv, builtin_merge_ours_usage);
>  
> +	repo_config(repo, git_default_config, NULL);
> +	prepare_repo_settings(repo);
> +	repo->settings.command_requires_full_index = 0;
> +
>  	/*
>  	 * The contents of the current index becomes the tree we
>  	 * commit.  The index must match HEAD, or this merge cannot go
> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
> index b0f691c151..d98cb4ac11 100755
> --- a/t/t1092-sparse-checkout-compatibility.sh
> +++ b/t/t1092-sparse-checkout-compatibility.sh
> @@ -2559,4 +2559,18 @@ test_expect_success 'cat-file --batch' '
>  	ensure_expanded cat-file --batch <in
>  '
>  
> +test_expect_success 'merge -s ours' '
> +	init_repos &&
> +
> +	test_all_match git rev-parse HEAD^{tree} &&
> +	test_all_match git merge -s ours merge-right &&
> +	test_all_match git rev-parse HEAD^{tree} &&
> +	test_all_match git rev-parse HEAD^2
> +'
> +
> +test_expect_success 'sparse-index is not expanded: merge-ours' '
> +	init_repos &&
> +	ensure_not_expanded merge -s ours merge-right
> +'
> +
>  test_done
