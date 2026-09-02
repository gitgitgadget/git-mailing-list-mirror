Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69B84A015E
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788355671; cv=none; b=IBd4uS/2Ln5/6HCSHOU1AKO459dPvOEZnSgv2UQtMru0N86oVu2mJgFhN6lgFhsNEQM20qS4vCGYCO/IfZZ73gt3mtRBqvHCuS4XrAXLeNr5A/SV48Fs5MMdw5WUXn5a4Ae1WUW05tWK5DDpF1U6GflOThk2ytF57TSHacxVrWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788355671; c=relaxed/simple;
	bh=IGBHf7wNlq8ZEU1dEzJcWEiC7lJ6LUtsZbD2NB9BEYw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Qon82WQcr5VHnc+C1Ajl0c5beuIgIRuPdkLCPodRG9kZJuYusuWJr8941ooL6k8VkaPEIMjd87BoTImVFj1XRXvsWvVw8VPBp862q73FJWYemGZ3SiheIQVcC779QDRed/sP5azKnt6bIOvuvjkPxVEMppO16P+kQnZ7QVOcSJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu4DQccH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu4DQccH"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1c52d920b8so134502466b.2
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 06:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788355663; x=1788960463; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C4yoo25SQS4aV9W5ZqZhI7ehltHeNTerAlBoQAxcgmQ=;
        b=fu4DQccHdwdr3hfi3KKKg44XBwqDH978q+yKdo/IRFHl8So28qW72hKHHY9caQaStG
         KSWgC/5yoMibgFmEX7qA/8o+zXJGJTJ+tQLZx4sElAZHmUGvZ4Qt1E+WZmdOQyoyzMRB
         rb2fYcIlEpKWyc/SLdQfy25QZIoJLtc5JWSOQcy1bPW6vH4e7tfDAqdE0S4ZWoy7Bd9F
         LUn7jyNyy6LQIlpvL7TU3/T++rIp0oyorsckk2yBRxV9owYRtGlMOipxkUV7CWZofFSP
         1Uyl0BMJ63VOTxn7d1p5tCNEHoo6BtwJCaTJvR/jxEosZ44Yi+aKvvZu3ME0uBoLfAyD
         b82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788355663; x=1788960463;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C4yoo25SQS4aV9W5ZqZhI7ehltHeNTerAlBoQAxcgmQ=;
        b=ktKsfDT3en6/D3je3a6bh+rAUsSWczppn3B49mV6Zh5CtjPBi2J8v7Lbr3Ev7FuD++
         k4mD49l7gpFjxHiSPna1Snoi58ZNlJ01CdKfOB69pSM2dK0CnoY68W67x/jw7zpl6BQt
         IKyAwzwKOnxJQqFsWGVDxJYZNxw6Ih4XrLDUO1kUDSSO7g+iHtp6Sxsy4ppEh7JllF7R
         iJfBkpX8q0YFdJfHEkqkOmjF6Be/Pj96j1PeDVbXhMnWzg1Aj8jerHot1GqMhVnkouTv
         06fC/dx2pmWvuzMsY8DvmbjappUne8keL0F8KOUxUHhU5KPIvfS9QY5qTXvnV54tEfVt
         FfRA==
X-Forwarded-Encrypted: i=1; AKwUvBzIbSm+o8+llkuDp+UO82jsZqK9Qk9OREfftip5CmFhxPkC15Qu8IY2m4+tvstiCV351Jo=@vger.kernel.org
X-Gm-Message-State: AFuF++lDOKJosG71B1O6QnV6Cs9ef3DC831E/lWDfItK/ygNL4VzT8wP
	ytwLK+x+SbYPkyK0c5pD0eD/puYFz18GzMc+2vPugbsXPhbz52YGuqGa
X-Gm-Gg: AYBFou3aKQwYhJS8OgjOdWFngF+ZNgcpJNdCKrtHVzFoFFAu8m8FDop84WEUWKdyFA5
	nDY+lSRQjVeCwD6oXUgW2KrmWUnYRdBoRUUAHfD8W28KewtOQdKPZmeUm4u66aUI4EpsVC934Od
	mp+yeRZgNPKWB2GokaUrzY3sNNRM0HAlW1knsNYVGTApdMjwpwxESTdd39hWkumPNprj/Dj9Ald
	B5ycOLaogBfUTUjpxq6aVouI7PTh4TV3w1trCPRzILKrNni6yT0J8JVT4kyu7MjJJWeBnlYa2tS
	ypL5UAPhCbkJqgkVZv1PZ2BEAjYDZhXFWzcw00zTmSRz7n7SrCdQvvVarty+qYjj/bvtq1XTs4C
	N6GDRmahkJY2Md2aNCDo94Rp43c1f0B9mjOPqQ5ykbDY2GW/2fyAdU485XJFxvanry8/RqSsppf
	Hil5zT9eFWNL15Ht479OaSMogwCuXvqxACAFl7ltmXc1lP4sB8CdCC6zTjaOcyfEg2ohF6VRkdM
	XUvc7CAqiw49ZBOss6l+Zf5g8xyqAgT6kQMgI4txMk=
X-Received: by 2002:a17:906:c103:b0:c25:31b4:5f15 with SMTP id a640c23a62f3a-c25d5206284mr331958966b.1.1788355662531;
        Wed, 02 Sep 2026 06:27:42 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc5a77sm135673866b.8.2026.09.02.06.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2026 06:27:41 -0700 (PDT)
Message-ID: <fc8b288c-3d77-4cf6-adff-f981e6a7a7d2@gmail.com>
Date: Wed, 2 Sep 2026 14:27:40 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rerere: keep a background gc from killing a rebase
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, Phillip Wood
 <phillip.wood@dunelm.org.uk>, Junio C Hamano <gitster@pobox.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
Content-Language: en-US
In-Reply-To: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 02/09/2026 09:31, Thomas Bachem via GitGitGadget wrote:
> From: Thomas Bachem <mail@thomasbachem.com>
> 
> Since 2.54 unscheduled maintenance uses the "geometric" strategy, so

That change really is the gift that keeps on giving

> the "git maintenance run --auto --detach" behind every "git commit"
> runs "git rerere gc" in the background whenever rr-cache has an entry.
> That includes the "git commit" the sequencer runs for a resolved pick
> on "git rebase --continue".
> 
> rerere_gc() takes MERGE_RR.lock through setup_rerere(), which uses
> LOCK_DIE_ON_ERROR, and so does the sequencer's repo_rerere() at the
> next conflict a few milliseconds later. Whichever comes second dies.

To me this is another reason why we should disable gc.auto while 
rebasing. To do that we need to pass "-c gc.auto=false -c 
maintenance.auto=false" when running "git commit" in run_git_commit() 
and also when running "git merge" in do_merge(). We should also pass 
those settings via GIT_CONFIG_PARAMETERS when running a exec command in 
do_exec(). That is largly papering over the cracks but until we have a 
systematic solution it does at least stop exposing users to this bug.

> When it is the rebase, it dies in do_pick_commit() 

That's a bug us well - we should be returning errors, not dying 
-rerere_setup() should be returning an error, so we can clean up and 
reschedule the pick.

There is a lot of detail here about what causes the problem which is 
helpful, but there is very little discussion about the fix. As I 
understand it we now block the sequencer until the background 
maintenance has completed, or continue to die in an inconvenient state 
we timeout before the background maintenance finishes. That seems rather 
unfortunate as the idea of running the maintenance in the background is 
to prevent it from interfering with other commands.

I think my preferred solution is to disable gc while rebasing. Returning 
an error from rerere_setup() would also help in the case where the user 
runs "git commit" and then continues the rebase. I'd be interested to 
hear what Junio and Patrick think about that. I'm also not clear why 
gc.auto has to fork a separate process just to check if it needs to run 
or not, I've not been following closely but my impression is that that 
is the cause of quite a lot of the lock contention bugs we've seen.

Thanks

Phillip

> with the index
> written but before make_patch() writes rebase-merge/{message,patch,
> stopped-sha}, and every later "git rebase --continue" refuses with
> "you have staged changes in your working tree". When it is the "git
> commit" of a later continue, that one dies in its post-commit
> repo_rerere() after the commit was made. Before 2.54 the same
> collision needed an auto gc to actually run, since gc runs
> "rerere gc" at its end.
> 
> A rebase with two conflicts in a row shows it. The filler makes the
> pick slower than the ~5 ms the background task needs to take the
> lock, and keeps the lock held for about 0.4 s. It hit 6 of 6 runs
> here on 2.55.0, and a test suite driving rebases on toy repositories
> with a single rr-cache entry hit it in both runs that were traced:
> 
>      git init -q -b main r && cd r
>      git config rerere.enabled true
>      git config maintenance.auto false
>      mkdir pad && seq 20000 | (cd pad && split -l 1 -a 5)
>      echo base >f && git add -A && git commit -qm base
>      git checkout -q -b topic
>      echo b >f && git commit -qam B
>      echo c >f && git commit -qam C
>      git checkout -q main
>      echo a >f && git commit -qam A
>      git repack -adq
>      seq 20000 | awk '{printf ".git/rr-cache/%040x\n", $1}' \
>          | xargs mkdir -p
>      for d in .git/rr-cache/*/; do echo x >$d/preimage; done
>      git config --unset maintenance.auto
>      git checkout -q topic
>      git rebase main
>      echo ab >f && git add f
>      GIT_EDITOR=true git rebase --continue
> 
> The second continue dies with "Unable to create '.git/MERGE_RR.lock':
> File exists" while the gc spawned by its own commit holds the lock,
> and after resolving C every further continue refuses. Maintenance
> stays off during the setup so that no repack is pending: a repack due
> at that commit runs ahead of rerere-gc in the task list and would
> spend the window.
> 
> The gc needs the lock: it removes every rr-cache directory it finds
> empty, and a rerere that has just created its directory but not yet
> written the preimage looks exactly like that. So keep the lock and fix
> both orders. When the gc finds the lock busy, let it warn and do
> nothing this time, the way "maintenance run" treats its own lock, so a
> manual "git rerere gc" sees the warning and the maintenance task and
> "git gc" see a clean exit. When the gc holds the lock, let every other
> caller wait it out instead of dying at once, for rerere.lockTimeout
> milliseconds with the semantics of core.packedRefsTimeout: 1000 by
> default, 0 for the old behaviour, -1 for an unbounded wait. Walking a
> 20000-entry rr-cache takes about 0.4 s here.
> 
> That rebase now completes. The tests cover the gc under a held lock,
> directly and through the maintenance task, a merge that waits a lock
> out within a five second rerere.lockTimeout, and one that fails at
> once with a timeout of 0.
> 
> Assisted-by: Claude Fable 5.1
> Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
> ---
>      rerere: keep a background gc from killing a rebase
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2214%2Fthomasbachem%2Frerere-gc-lock-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2214/thomasbachem/rerere-gc-lock-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/2214
> 
>   Documentation/config/rerere.adoc |  8 +++++++
>   Documentation/git-rerere.adoc    |  4 +++-
>   rerere.c                         | 27 +++++++++++++++++----
>   rerere.h                         |  1 +
>   t/t4200-rerere.sh                | 40 ++++++++++++++++++++++++++++++++
>   t/t7900-maintenance.sh           |  8 +++++++
>   6 files changed, 82 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/config/rerere.adoc b/Documentation/config/rerere.adoc
> index 3a78b5ebb1..8041a1587b 100644
> --- a/Documentation/config/rerere.adoc
> +++ b/Documentation/config/rerere.adoc
> @@ -10,3 +10,11 @@ rerere.enabled::
>   	enabled if there is an `rr-cache` directory under the
>   	`$GIT_DIR`, e.g. if "rerere" was previously used in the
>   	repository.
> +
> +rerere.lockTimeout::
> +	The length of time, in milliseconds, to retry when trying to
> +	take the rerere lock while another process holds it, typically
> +	a background `git rerere gc`.  Value 0 means not to retry at
> +	all; -1 means to try indefinitely.  Default is 1000 (i.e.,
> +	retry for 1 second).  `git rerere gc` itself does not wait and
> +	skips its run instead.
> diff --git a/Documentation/git-rerere.adoc b/Documentation/git-rerere.adoc
> index 4e6ab9a27c..05935b0603 100644
> --- a/Documentation/git-rerere.adoc
> +++ b/Documentation/git-rerere.adoc
> @@ -70,7 +70,9 @@ occurred a long time ago.  By default, unresolved conflicts older
>   than 15 days and resolved conflicts older than 60
>   days are pruned.  These defaults are controlled via the
>   `gc.rerereUnresolved` and `gc.rerereResolved` configuration
> -variables respectively.
> +variables respectively.  If another process holds the lock on the
> +recorded resolutions, for example a merge or rebase that is recording
> +a conflict, `gc` does nothing and reports so.
>   
>   
>   DISCUSSION
> diff --git a/rerere.c b/rerere.c
> index 8232542585..22d114262b 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -32,6 +32,7 @@ static int rerere_enabled = -1;
>   
>   /* automatically update cleanly resolved paths to the index */
>   static int rerere_autoupdate;
> +static int rerere_lock_timeout_ms = 1000;
>   
>   #define RR_HAS_POSTIMAGE 1
>   #define RR_HAS_PREIMAGE 2
> @@ -876,6 +877,8 @@ static void git_rerere_config(void)
>   {
>   	repo_config_get_bool(the_repository, "rerere.enabled", &rerere_enabled);
>   	repo_config_get_bool(the_repository, "rerere.autoupdate", &rerere_autoupdate);
> +	repo_config_get_int(the_repository, "rerere.locktimeout",
> +			    &rerere_lock_timeout_ms);
>   	repo_config(the_repository, git_default_config, NULL);
>   }
>   
> @@ -908,12 +911,26 @@ int setup_rerere(struct repository *r, struct string_list *merge_rr, int flags)
>   
>   	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
>   		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
> -	if (flags & RERERE_READONLY)
> +	if (flags & RERERE_READONLY) {
>   		fd = 0;
> -	else
> +	} else if (flags & RERERE_SKIP_LOCKED) {
>   		fd = hold_lock_file_for_update(&write_lock,
> -					       git_path_merge_rr(r),
> -					       LOCK_DIE_ON_ERROR);
> +					       git_path_merge_rr(r), 0);
> +		if (fd < 0) {
> +			warning_errno(_("unable to lock '%s', skipping"),
> +				      git_path_merge_rr(r));
> +			return -1;
> +		}
> +	} else {
> +		/*
> +		 * A background "rerere gc" holds the lock for as long as it
> +		 * takes to walk rr-cache, so wait it out rather than die.
> +		 */
> +		fd = hold_lock_file_for_update_timeout(&write_lock,
> +						       git_path_merge_rr(r),
> +						       LOCK_DIE_ON_ERROR,
> +						       rerere_lock_timeout_ms);
> +	}
>   	read_rr(r, merge_rr);
>   	return fd;
>   }
> @@ -1237,7 +1254,7 @@ void rerere_gc(struct repository *r, struct string_list *rr)
>   	timestamp_t cutoff_resolve = now - 60 * 86400;
>   	struct strbuf buf = STRBUF_INIT;
>   
> -	if (setup_rerere(r, rr, 0) < 0)
> +	if (setup_rerere(r, rr, RERERE_SKIP_LOCKED) < 0)
>   		return;
>   
>   	repo_config_get_expiry_in_days(the_repository, "gc.rerereresolved",
> diff --git a/rerere.h b/rerere.h
> index d4b5f7c932..87964bb3c5 100644
> --- a/rerere.h
> +++ b/rerere.h
> @@ -10,6 +10,7 @@ struct repository;
>   #define RERERE_AUTOUPDATE   01
>   #define RERERE_NOAUTOUPDATE 02
>   #define RERERE_READONLY     04
> +#define RERERE_SKIP_LOCKED  010
>   
>   /*
>    * Marks paths that have been hand-resolved and added to the
> diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
> index 1717f407c8..6b90294435 100755
> --- a/t/t4200-rerere.sh
> +++ b/t/t4200-rerere.sh
> @@ -242,6 +242,46 @@ test_expect_success 'old records rest in peace' '
>   	test_path_is_missing $rr2/preimage
>   '
>   
> +test_expect_success 'gc does nothing while MERGE_RR is locked' '
> +	mkdir -p $rr2 &&
> +	echo Hello >$rr2/preimage &&
> +	test-tool chmtime =$just_over_15_days_ago $rr2/preimage &&
> +
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	git rerere gc 2>err &&
> +	test_grep "MERGE_RR" err &&
> +	test_path_is_file $rr2/preimage &&
> +
> +	rm .git/MERGE_RR.lock &&
> +	git rerere gc &&
> +	test_path_is_missing $rr2/preimage
> +'
> +
> +test_expect_success 'a held lock is waited out within rerere.lockTimeout' '
> +	git reset --hard &&
> +	rm -rf $rr &&
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	{
> +		(sleep 1 && rm -f .git/MERGE_RR.lock) &
> +	} &&
> +	test_must_fail git -c rerere.lockTimeout=5000 merge first 2>err &&
> +	wait &&
> +	test_grep ! "Unable to create" err &&
> +	grep "^=======\$" $rr/preimage
> +'
> +
> +test_expect_success 'rerere.lockTimeout=0 fails at once on a held lock' '
> +	git reset --hard &&
> +	rm -rf $rr &&
> +	test_when_finished "rm -f .git/MERGE_RR.lock" &&
> +	>.git/MERGE_RR.lock &&
> +	test_must_fail git -c rerere.lockTimeout=0 merge first 2>err &&
> +	test_grep "Unable to create" err &&
> +	test_path_is_missing $rr/preimage
> +'
> +
>   rerere_gc_custom_expiry_test () {
>   	five_days="$1" right_now="$2"
>   	test_expect_success "rerere gc with custom expiry ($five_days, $right_now)" '
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index d7f82e1bec..a55ca2e829 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -885,6 +885,14 @@ test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
>   	test_expect_rerere_gc ! git -c maintenance.rerere-gc.auto=0 maintenance run --auto --task=rerere-gc
>   '
>   
> +test_expect_success 'rerere-gc task succeeds while MERGE_RR is locked' '
> +	test_when_finished "rm -rf .git/rr-cache .git/MERGE_RR.lock" &&
> +	mkdir .git/rr-cache &&
> +	: >.git/rr-cache/entry &&
> +	>.git/MERGE_RR.lock &&
> +	test_expect_rerere_gc git maintenance run --task=rerere-gc
> +'
> +
>   test_expect_success '--auto and --schedule incompatible' '
>   	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
>   	test_grep "cannot be used together" err
> 
> base-commit: e9019fcafe0040228b8631c30f97ae1adb61bcdc

