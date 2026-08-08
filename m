Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D54389452
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208431; cv=none; b=lk39+wo24qXH5LyleNp2hJQM8L6bWTmvXCewC+Re3fBDddSQ7YqI2gp4a29msV7mba3JqavcA1gCIusNe/GYJIQhGf8Fpp5RqwDJcA/MmhRGjYEQHicMBL1IG0ZRtnXpGudX/LlyEYD5XuBAd6xDT8Eo3y6e4Lr5WTaTmylRmYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208431; c=relaxed/simple;
	bh=P0Wfu3lLj4EWKY2NmCb/GoetJlevmIGqA2Ex61u7AZE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aqNrWny15pBAHMAZUCzkZZFV54aqdhWBXkiakREDjRwWYcsjLsmBGEyT0iyylBhT7NyOY3K2Jb7KK4veTgeM5BwxXykJ03+VrA4j3nRHRtCs6jJJbHk15VOfGCxj47ysYJrd5SZZLkL5bN+hSMWTP7GOOx58A6RJfePt00u15BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=iIawwhcc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RTF1Pk54; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="iIawwhcc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RTF1Pk54"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3E2047A0063;
	Sat,  8 Aug 2026 13:00:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sat, 08 Aug 2026 13:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786208429; x=1786294829; bh=/bKm6EPctd
	vAGR+53Rd6J11lVCABwkn2h189ey7sePo=; b=iIawwhcc/cD0AMMOABzWO7Q+RS
	y+/pGSvC0gYpt5n8nwBaK2j1BFbqoGeKgT6JJjZnLBaVgNEzveGzOp6XPSsgHPyp
	9wTFiplGK14TgkHOMwhfzVWcYIe0KekPpuKDeOJpQISx3q31OjjY/I6e+7ot8jz5
	NU/NAiQMlIeCuxA6qWBPPzpw+XhTz4tjl2J7fPgIvXy2U2sHzKOxMMvK6msm7J6t
	YdqFYt3oHZ6MCTWQbjBDwJrX4AIm9+PuSGL6GVlAFpYJHecu/wkbN84z+TPeeaIN
	IgfAMJN3DyM48TjEOF3fu4/j0xcbDlRWSAJZciAdDrwxfctTKLFUFkz/DvUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786208429; x=1786294829; bh=/bKm6EPctdvAGR+53Rd6J11lVCABwkn2h18
	9ey7sePo=; b=RTF1Pk54DAAqQPeRfl/v7t8aoNyPMli/BZbMd/wuRQxa5V1uQ3K
	+ewrxtsDLa6YDmxXmygFFCkUV5SXIJ8Xxx/ddEGRnowlg+qQlqNHb57iWcvxQiKU
	j7YJR+m5Tpv2C4Q+XC/7FuHDBcTUwXPBLOaGRk7s7dHB0Nvjo8RjxsX1T0r9yTsx
	G0ZO9vL8X3GraGL+GLpbkOX9YsRbpAKmxxTyRxOYmuDVBNeZSXJE0JszWjyDqa1x
	zlzhlpDFuOWUZkiJugpw0NIfHljWzeyB1iB9RWAUx2e6m7yE+0VtsFtIovAAKMhj
	y3CH1H/eUV0wTfC5tyoRwarkiOWxGiKGbvA==
X-ME-Sender: <xms:rGB3atJZyvwEOn6yMseVo2S7wEcnGLCYwZdiE5BLihmeqUHIU9Jstg>
    <xme:rGB3agKrobvoacsyIXlz0PP3HACoNUe_YoZSfEMqawed8IVZUDwGpWN0eCXuxw0An
    YsOKNbkCl2CZVkJIEALlSpGcEGp8yosqrYYcrGz6J-P8GUrtPRH9Sw>
X-ME-Received: <xmr:rGB3aqupO_Mnu0wr3ZDAX4R568PkI6Sp1jQn5-XYzyPloshxFueJOpyc78CS24CLe_RZlmHPs_YIMXwwmJiGZSP56qqm2Gbh4Q>
X-ME-Proxy-Cause: dmFkZTGfEB2893Ul3GZ4R8ok0PAouGCD4baE0AbbHoe3C8CVNXP35WgjIugqcH3OuwBosB
    7cfTmcrh2hqsBoz8vUrJMdQb9ixgZMVUoldZMKjQlaT5oki2FFUeNgf0ZzL1nj88JwJQbQ
    hJfCuxtnh1eYaO+M1NzRH9IrQFWsuVeImHv2jSb6tJ86UdQIPXwCe27GO66OxMuQDiHpqz
    X1XZyu9H7TDryxkAkVW8sjB5HdUClF6rH6bYjYhgNeAZI8QZPrz61KIeCgvYNhO82e1xsi
    g7IUELIAj71ndsp7VSWWGJ0fHuxEegjKB2x7ZwYemzR4wYfUGIuLnj8F+hqwUikcrZMAdq
    RQbrzTAJfcAZ8GJSLMoiC1/jaYP1UR1mFPFqXY0YnhrE+R3wPi4sOqxm8QHJTtmRzge8/K
    u8NZuHuPVHlxUJ2qEFE96dk6XFLMYmWNsWJquGEB3tD4ZG1RNpySQUmQE8o1lhCfsNSHgX
    rJAvIzsW2aslsxUw+svdieLik5yp+jdL1t+azJ79Pz0sr1su3kaiU0Vt8W9EeC4dFW9DVq
    IAUvwdtN7uFR6wXMshPM45SRODpITANKUnhhgxoATvmSTiFNd7UsCq8IkM5+tl2RbyOP19
    a9JD3EomqVxgFm2o7H2DKRBk8ynk8rC0oOx0AInio7FpR2Ugmd551oME+7kA
X-ME-Proxy: <xmx:rWB3atTtmrfCcDQoHn0aWeOR_YnBeYNRPq0UbxA70FiBVCfsiOaVKw>
    <xmx:rWB3agPxVCNxUwO7F52OegtFCiS7siGQ8mrI_HQS32CdoBEJp4UzvA>
    <xmx:rWB3aiaeDXMz0ZEu1bhEF0Jet395gOHW0Ce00Elzyw0FwKBRr0e55w>
    <xmx:rWB3aqyN1X9Gyx8gQW-J1S1rpNNtfnSt1PZEkr2h44DOUxMLaSgYZQ>
    <xmx:rWB3aqNz6CLM4UPthHSTfDe8CommhBPTN_EMtLuK_OPTwJt_8YljY5Mj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Aug 2026 13:00:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
Subject: Re: [PATCH] worktree add: improve message for ambiguous remote
 branch name
In-Reply-To: <pull.2197.git.1786177301832.gitgitgadget@gmail.com> (Yoichi
	NAKAYAMA via GitGitGadget's message of "Sat, 08 Aug 2026 08:21:41
	+0000")
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
Date: Sat, 08 Aug 2026 10:00:26 -0700
Message-ID: <xmqqzeywa6ol.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
>
> Display a descriptive message when DWIM fails.
>
> Add advice on how to work around this by specifying the fully
> qualified name or by setting checkout.defaultRemote.
>
> Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
> ---
>     worktree add: improve message for ambiguous remote branch name
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2197%2Fyoichi%2Fimprove-worktree-add-error-message-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2197/yoichi/improve-worktree-add-error-message-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2197
>
>  builtin/worktree.c      | 30 ++++++++++++++++++++++++++----
>  t/t2400-worktree-add.sh | 21 +++++++++++++++++++--
>  2 files changed, 45 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 654d27c3e1..46bc305116 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -116,6 +116,16 @@ static const char * const git_worktree_unlock_usage[] = {
>  	NULL
>  };
>  
> +static const char message_advice_ambiguous_remote_tracking_branch[] =
> +	N_("If you meant to create a worktree from a remote tracking branch on,\n"
> +	   "e.g. 'origin', you can do so by fully qualifying the name:\n"
> +	   "\n"
> +	   "    git worktree add <path> origin/<name>\n"
> +	   "\n"

This is shown in two places, but what did the user exactly type in
these two situations?  Can their intent be different, in which case
different suggestions might be more appropriate to each of them?

Let's see.

> @@ -781,8 +791,14 @@ static char *dwim_branch(const char *path, char **new_branch)
>  
>  	*new_branch = branchname;
>  	if (guess_remote) {
> +		int num_matches = 0;
>  		struct object_id oid;
> -		char *remote = unique_tracking_name(*new_branch, &oid, NULL);
> +		char *remote = unique_tracking_name(*new_branch, &oid, &num_matches);
> +		if (!opts->quiet && !remote && num_matches > 1) {
> +			if (advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME))
> +				advise(_(message_advice_ambiguous_remote_tracking_branch));
> +			warning(_("'%s' matched multiple (%d) remote tracking branches\n"), branchname, num_matches);
> +		}
>  		return remote;
>  	}

The worktree.guessremote configuration is set.  dwim_branch() is
called when "git worktree add A/B/X" is run with a single argument
"A/B/X", which comes here as "path", and that is munged into the
branchname "X".

We used to pass NULL as the second parameter to unique_tracking_name(),
so we were only interested in the case where we have exactly one
matching remote, and if there is 0 or multiple remotes with the
named branch, we returned NULL from here.

The patch does not change that, but using the branch name, we try to
see if there are multiple matches, in that case, we give the advice
message to say "hey, don't be so lazy, as X appears in more than one
remote, so tell me which one you mean".

> @@ -890,7 +906,7 @@ static int add(int ac, const char **av, const char *prefix,
>  		opts.orphan = dwim_orphan(&opts, !!opt_track, 0);
>  	} else if (ac < 2) {
>  		/* DWIM: Guess branch name from path. */
> -		char *s = dwim_branch(path, &new_branch_to_free);
> +		char *s = dwim_branch(&opts, path, &new_branch_to_free);
>  		if (s)
>  			branch = branch_to_free = s;
>  		new_branch = new_branch_to_free;

But shouldn't we do a bit better than 

    git worktree add <path> origin/<name>

The above makes the user think that just like 'git', 'worktree' and
'add', 'origin/' is a fixed part, and they would need to substitute
<path> and <name>, but that is not really what we want to tell them.
The most crucial part to correct is 'origin/', as that is what we
could not guess from the given information.

We know that the user gave us "A/B/X" (path) and probably they want
to create local "X" from it.  Or not.  We also should know, in
caller's opt_track and used_new_branch_options, that the user gave
us "-t -b Y" from the command line.

> @@ -904,10 +920,16 @@ static int add(int ac, const char **av, const char *prefix,
>  
>  		commit = lookup_commit_reference_by_name(branch);
>  		if (!commit) {
> -			remote = unique_tracking_name(branch, &oid, NULL);
> +			int num_matches = 0;
> +			remote = unique_tracking_name(branch, &oid, &num_matches);
>  			if (remote) {
>  				new_branch = branch;
>  				branch = new_branch_to_free = remote;
> +			} else if (num_matches > 1) {
> +				if (!opts.quiet && advice_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME)) {
> +					advise(_(message_advice_ambiguous_remote_tracking_branch));
> +				}
> +				die(_("'%s' matched multiple (%d) remote tracking branches"), branch, num_matches);

Style: overly long line, with {braces} around a single statement block.

What does this case handle?  Can you make a similar analysis to come
up with the list of things we know the user gave us, to give a bit
better command line to suggest here?

>  			}
>  		}

Thanks.
