Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569104EBAF0
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788534197; cv=none; b=nXQu/4zzzlDts4tTGFUHTDoxP41Ju7bnZVukApg/JDDhbU5UdzRLj+ZfcjzOpQKWE2r/1rpeNh+gAeDxqRpnv/9iQVs33RDVRRM1vstH4PjOsLiZ5vFFYj8BDv34WNtc0YM/uwNC1zwnXpFKE3HEC1ArRhUqhMJgzzY73hZezVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788534197; c=relaxed/simple;
	bh=YG3wvglbKMmjT1qOGiQTZETSspnNx7aF1OSkQ/oZlAU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=B7YaITUnkc8jCvWEYt2bcIC6l80CEj7RqXxzFmWRhJ7rFen80AidR3dweM8cZ4tdN9c3EJkgSDxGw76naoi5507s5nGWRwxwW1/7fNun9moDx9+ugjg9GnTBU3rstjlu6yPgE7Y4HTiUxUr8j3MWf33f+3tepMntk058qtesb3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g90qBPTx; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g90qBPTx"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a5e971c970so4128094a12.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 08:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788534193; x=1789138993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tSw5f28QA0TQ5yXZi1649lAf3+Y1ktIPMdRoBhSwGXg=;
        b=g90qBPTxlZNB+cwOHfAF3NKZhcUjwu8J5CcmOHJTGTO6+KvZN/1HkoslroEXi2ruNi
         Akp4aNS7rW2dgG3rCZPyycbTC0V9oqV/k8hhs9AUfHS3ZuJMyY4qQJW7G13gqbFQa7Js
         Eu1rqkyBCsQV3AVcVSGCCSuPnckLpPvHygAr09tQyqQrGzUvRkZgTSZJhghZIQboAUfW
         La9lXfA+/z6Lb43lihcHUxki/0xlALb4TOnlL0raHou4krIvgbrS4m55vzO1XOyavo4q
         dBUJGXKgOVn2wSAGKnFEc8TlOdrkL3ExuOO9TFXktKDAILH+65a7JQfQWkp22iPKjL8K
         NCfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788534193; x=1789138993;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tSw5f28QA0TQ5yXZi1649lAf3+Y1ktIPMdRoBhSwGXg=;
        b=fcUddymY5MFkrDjPksuM672yhYs/FRUYZJhwEGvxhsqbU9CkTyuiSeK7v/Smrl46Bz
         c+0fTz7rGsCjUVdCnWGbB6ZbCZnS/aLRaICJgZz6zMyhYbbFRFAXicD0ZtEAW1EDq+NE
         h7dMcVT9bS9+gemmbOIUBLjbZc9pLwfYDbje8UBrgI8N+lzLGCcRblauJpJ0cyUhQGIN
         5Yv3FoaOrWUxt/tkSBg2znVJN5EHsCfidprUBoChjNvbvwLVMFod74QMb+GAjFwnUJzC
         lzzwyjff9+NOJt9UP9pfPDAVXSX+E6xci+poDa9/OqvbeHBJLi3MUKmQcWJlni5etrOd
         zrPg==
X-Forwarded-Encrypted: i=1; AKwUvBz/TUDjz55e7oZBm1K03Ij/NARn+a8ceg1icWQSQd7VuVqaDXyxgkv37WebbLd1bM6QgOc=@vger.kernel.org
X-Gm-Message-State: AFuF++nX7x77nER8dDcPRIwSZvG6PUFZKOsmuGdJhyiqU44VbZ2aE5y2
	sNn8CS+CZOW4lFIhzjJp95ZCGgTVbuB7f1BJXqpuN2/C/awOf0gDeVo4
X-Gm-Gg: AYBFou0OuHKnwckMbk0mYxEFhkDrtreaQj1SXcm+e1ooI/uMK7rZ+ZtpKixjSauqdV1
	64IL+rWTMySfrj7FNhum5jKBeKMrgkyCswY7ibnPeJBXClQLDPRTMdQQrZD+Czl2ilVN0cn1cYe
	x9DE8y3LM2BlGjrBWVKKIlMAl/5NNIvGAi+TfbyfE8L0U3vwDDFiZFW2mhcO5NYDr0+H20JET9S
	/4ecQbbI7ab6cE9g6n2psqTFBRIAYvKrXoLUxV0cUUMHIKA5AagA5YhZLfMnWhv6RCIQczEbMJb
	axjvYVdYBBlC5MBBvTIQifz2foWV2XpR87D17DmUbPz5MTIcH+3qfD8bpq4xEJB+y2qZX2BegtT
	1/dgUGlXeflTx5Sa+2vKT2LKCND0DtEAgkVM9HX+zz7UmkkRtkjl4rIROPRhtZzA8VWha4Zl6by
	dP/NT+DYOKnowMP/NdtkU0vvIxmdgYGR1ZaApfIt0JXVjBIGdjTaoyUslbWXohb6KhjmSJhYLSW
	FmWDWdq0GagibPxcJNU4/NgkVo8TP7AT4kxl1PMSBI=
X-Received: by 2002:a17:907:d2a:b0:c25:f7db:4bf0 with SMTP id a640c23a62f3a-c2610747c3emr210060366b.22.1788534192802;
        Fri, 04 Sep 2026 08:03:12 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d575fe6sm120648366b.38.2026.09.04.08.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 08:03:11 -0700 (PDT)
Message-ID: <f44765f2-d04f-4adc-b5f0-56a22658626b@gmail.com>
Date: Fri, 4 Sep 2026 16:03:09 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 2/2] sequencer: keep auto maintenance out of the commands
 a rebase spawns
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <06d2f0f484e2e22178c6a956ec153e3d84ee073c.1788508426.git.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <06d2f0f484e2e22178c6a956ec153e3d84ee073c.1788508426.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 04/09/2026 08:53, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> The commands a rebase with the merge backend spawns, the "git commit"
> for a resolved, reworded or squashed pick, the "git merge" of a
> "rebase -r" for an octopus merge or with a strategy, and whatever an
> exec command runs, each kick off "git maintenance run --auto --detach",
> a background process the rebase then races for the repository: the
> "rerere gc" spawned by the commit of one "git rebase --continue" holds
> MERGE_RR.lock while the next pick wants it, and a repack wants to
> delete packs the sequencer still had open, which 65cda10d5b
> (sequencer: release the ODB before spawning git commit, 2026-08-12)
> had to fix for Windows.

This entire paragraph is a single sentence and is very hard to understand.
> Nothing a rebase creates is old enough to be pruned by the time it

s/Nothing/The objects/?

> ends, and repacking what it created can wait until then,

That's what we'll find out when this is merged. In principle it is 
possible someone is doing enormous rebases where the number of loose 
objects impacts the performance if we don't repack mid-rebase but I 
don't think we can know that without disabling auto maintenance and 
seeing if anyone complians.

> so
> maintenance in the middle of a rebase has nothing to do that a run at
> its end cannot, and a rebase to get in the way of.

That last clause is hard to parse.

> Pass
> maintenance.auto=false and gc.auto=0 to the commands a rebase spawns,
> through GIT_CONFIG_PARAMETERS so that the shell of an exec command
> passes them on too, appended to whatever -c the user gave, since the
> last entry wins. What the user runs while the rebase is stopped, say
> "git commit --amend" at an edit, is not the rebase's to control and
> still runs it. 

s/runs/run/

> "git commit" and "git merge" could skip it themselves
> while a rebase is in progress, which would cover that too, but that
> spreads the rebase's business over every command that runs
> maintenance and defers theirs for as long as a rebase is left lying
> around, so keep the decision with the rebase, in what it spawns. Both
> backends run maintenance once the rebase is done, the merge backend
> since the previous commit, so nothing is lost.
> 
> Cherry-pick and revert are left alone: they never ran maintenance at
> the end of a sequence, and the "git commit" they spawn for a
> --continue or an edited message is the only place they run it at all.

I'm inclined to think that the reasoning for running maintenance at the 
end of a rebase applies to cherry-pick and probably revert as well.

> 
> Assisted-by: Claude Fable 5.1
> Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
> ---
>   sequencer.c                | 27 +++++++++++++++++++++++++++
>   t/t3418-rebase-continue.sh | 18 ++++++++++++++++++
>   2 files changed, 45 insertions(+)
> 
> diff --git a/sequencer.c b/sequencer.c
> index f58ad254be..30c1a799cc 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -1107,6 +1107,29 @@ static int run_command_silent_on_success(struct child_process *cmd)
>   	return rc;
>   }
>   
> +/*
> + * A rebase runs auto maintenance once it is done, not from every command
> + * it spawns along the way: their background "rerere gc" or repack would
> + * race the rebase for locks and files it still holds.
> + */
> +static void disable_auto_maintenance(struct child_process *cmd)
> +{
> +	struct strbuf value = STRBUF_INIT;
> +	const char *old = getenv(CONFIG_DATA_ENVIRONMENT);
> +
> +	if (old && *old)
> +		strbuf_addf(&value, "%s ", old);
> +	sq_quote_buf(&value, "maintenance.auto");
> +	strbuf_addch(&value, '=');
> +	sq_quote_buf(&value, "false");
> +	strbuf_addch(&value, ' ');
> +	sq_quote_buf(&value, "gc.auto");
> +	strbuf_addch(&value, '=');
> +	sq_quote_buf(&value, "0");
> +	strvec_pushf(&cmd->env, "%s=%s", CONFIG_DATA_ENVIRONMENT, value.buf);
> +	strbuf_release(&value);
> +}

We already have a function in config.c to append parameters, but it sets 
them in the callers environment which we don't want to do here. I wonder 
if we could factor out a helper append the parameters to an strbuf 
passed by the caller so we don't need to know about the quoting scheme 
here. Also it would be nice to cache this in replay_ctx so we don't have 
to construct the string each time we want to disable auto maintenance.

Other than that this looks good

Thanks

Phillip


> +
>   /*
>    * If we are cherry-pick, and if the merge did not result in
>    * hand-editing, we will hit this commit and inherit the original
> @@ -1148,6 +1171,8 @@ static int run_git_commit(const char *defmsg,
>   			     author_date_from_env(&cmd.env));
>   	if (opts->ignore_date)
>   		strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
> +	if (is_rebase_i(opts))
> +		disable_auto_maintenance(&cmd);
>   
>   	strvec_push(&cmd.args, "commit");
>   
> @@ -3934,6 +3959,7 @@ static int do_exec(struct repository *r, const char *command_line, int quiet)
>   	cmd.use_shell = 1;
>   	strvec_push(&cmd.args, command_line);
>   	strvec_push(&cmd.env, "GIT_CHERRY_PICK_HELP");
> +	disable_auto_maintenance(&cmd);
>   	status = run_command(&cmd);
>   
>   	/* force re-reading of the cache */
> @@ -4342,6 +4368,7 @@ static int do_merge(struct repository *r,
>   				     author_date_from_env(&cmd.env));
>   		if (opts->ignore_date)
>   			strvec_push(&cmd.env, "GIT_AUTHOR_DATE=");
> +		disable_auto_maintenance(&cmd);
>   
>   		cmd.git_cmd = 1;
>   		strvec_push(&cmd.args, "merge");
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 2c34cf8a01..cf6d20ce79 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -403,4 +403,22 @@ test_expect_success 'rebase runs auto maintenance at its end' '
>   	test_subcommand_flex git maintenance run --auto <finish.txt
>   '
>   
> +test_expect_success 'rebase spawns no auto maintenance before its end' '
> +	git checkout -b two-conflicts topic &&
> +	test_commit F2-again F2 222 &&
> +	test_must_fail git rebase -x "git commit --allow-empty -m exec" main &&
> +	echo resolved >F2 &&
> +	git add F2 &&
> +	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/mid.txt" \
> +		git rebase --continue &&
> +	test_subcommand_flex git commit <mid.txt &&
> +	test_subcommand_flex ! git maintenance run --auto <mid.txt &&
> +	echo resolved >F2 &&
> +	git add F2 &&
> +	GIT_TRACE2_EVENT="$(pwd)/end.txt" git rebase --continue &&
> +	test_subcommand_flex git maintenance run --auto <end.txt &&
> +	grep "\"child_start\".*\"maintenance\"" end.txt >maintenance &&
> +	test_line_count = 1 maintenance
> +'
> +
>   test_done

