Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FACD46982D
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790176051; cv=none; b=HoAhOEutnxo9iTv2M8mBMEKbF86zjZtB8BCLVZ35OR35DHty83Tst8SAw23N/RiXhV1OBu//VoQKWEVxLckFUAaCkY816iqr4R130i/uuyog1gLeqFD/7znUIBIJxcYopnIy0yOv5f603Y+GzQ2ZbSZIDJ2+wLEyS7r6xWVL24g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790176051; c=relaxed/simple;
	bh=Ji74IDXX+ZEE8iOmC1eJQGaEh8Qwa9/iqHiuCXLm1A8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eb/OxHv6NGM9Tkq2fDgXPeLUUhJswYTTFFxjZorleBee+XmL2jnUHU0bR37bYhJ6i57XJ53f+xBm9XfsBnYnqINL3u3lXN+Xm5m68CylbBPqJJv1PGYUX8/98AKglR73dhnlPi09eKtMWSgu2LJ3cVEbqA6AzbVL3JFVMUspRvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4v2IDxL; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4v2IDxL"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f705536so193165366b.1
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790176047; x=1790780847; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tdDlHQiTRg5pvdxWf63j0kFwLOByAZfnmalyRreaDdM=;
        b=F4v2IDxL2nT6GWb0txC8U6szltOp/iQZq3X/dWd4K0+GpkWh2+w/eezxpE0wdH5qOa
         y/VPF+sv47GVOWIDlE/yVLPoLAS4LXarmSvwMbO2/ckg+Hurq5x2aDdfTlMr4fRzy88Y
         RmnB8y/mmhlu2WCexfl33ADyd6lAis9uRZpmVfaTFICgFZUR6ctGjdsVV6gIWknRr1Ht
         a1xha/ATIh1nYKaiBTAjZtGlFptI7HcXZkaZrZlvM7Uyjn7QIatnNEM9VNGgpeifS8Zz
         Nk3dwTlpfXNm8XTc5asOQRdZ/2z4bsBwNawKpprI9nzT/uk0sjYJ9Y4dUthYw53jWR/E
         6vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790176047; x=1790780847;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tdDlHQiTRg5pvdxWf63j0kFwLOByAZfnmalyRreaDdM=;
        b=wVHAl5s/b9N6pBCeovQ/BpOw2JXhoGt+GG0n/Rl+fETEy06kwJ352sBwXCvaY1tu7I
         rO/0M6cbyOMzP9u3OSJSSZ8APPhgUPAMa8jbQ+A3E0TC3xDexazn1O055jEnfsRKpsF6
         jyBbpqsu0/ye5EPXWFcFzHkO8lft7Elx04OxIubh6Ca+HtDESxHFzOO+r5lDQLLp2VPX
         T2d9fJSNWh8DJghJ/3reFGCICtkXNDYNiGXc7A/wOht3JNGltpmQq7j9TrVdCyJP4tk6
         h9SuZq0yFG/G4jT7rPBmhaAGaJ7p9eh4a/ucME6qcj/JYFr/3fRUBTTTD78f6wEqiOuE
         5xJg==
X-Forwarded-Encrypted: i=1; AKwUvBw0Ouz7XhN01UB54voiVqroJXdn3g+KT9Zi4mEtOJiaKSOLxbzALT68msTx7J558KLkkyk=@vger.kernel.org
X-Gm-Message-State: AFuF++ne8OppwgBABUH5YOsJ2R8uW8+GkuqYnpDKHKG0XgwhpxHQBDA8
	PeZyhwM91EIBYhPElIf2GoIQGbuNFh+BAMJVmM5PvX90UeCHMyURFf1s
X-Gm-Gg: AYBFou1zmgcrzJzDwdNuh5J9TVTRYwGyh2/pcdpN/MvqkmcDq2KPbIsn7PZKhgerWZV
	XZj640DOW4CjRJqLe/NB9pw8d/mphAjoW5DPIOeefgj6Tl4teY0MMeiizXfyM7fHlXXeXQ9iQ+z
	3rFW1Pp/4Y8BLs5Sx3kv82a/tLVUat/f5UFFjS1Z5vi4smGDosRStI4l+D/zI1b4f6Z+CwhAPGS
	8v4aEMbMSOEK+ZhzbJCGxmC1CdfEjZWj86yFwYVlSZb3GLfyA381oH5dfHhECZ5NtfqMW3Z5Lwx
	QMx3Y3AmdIYoPpUi4xgbcGojBe6UnFlQAQxCXQbUu6jfPo31wJ6nkWCqwB7W/QGtUw7MxVZxBau
	iII9y1RbM7q1bz/bxEK5IOffwVj4R0ZBi0i+MUDHzvPYTgZZfKix/eOSq4bpy35Qal4PkXLCtyp
	zVeTcXsuO8dA35SAOiZ9T9ebmoRaPPh40VgbM/do39qkjIc8VPRoKVFi225WWWzuhdI0ceUq2kJ
	BDJlhc967xH4lxw0h6qD7nidbVFg+vf12p9stxBagqBem70PaBbxA==
X-Received: by 2002:a17:906:6a27:b0:c29:d31f:7d73 with SMTP id a640c23a62f3a-c2aadc98c81mr267982966b.9.1790176047169;
        Wed, 23 Sep 2026 08:07:27 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae60b5f3sm141337166b.25.2026.09.23.08.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 08:07:26 -0700 (PDT)
Message-ID: <c67ed25c-e54b-4289-bfb4-67f86beb6df6@gmail.com>
Date: Wed, 23 Sep 2026 16:07:23 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/3] sequencer: leave auto maintenance to the end of a
 sequence
To: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>, Patrick Steinhardt
 <ps@pks.im>, Junio C Hamano <gitster@pobox.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Thomas Bachem <mail@thomasbachem.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v5.git.1789670534.gitgitgadget@gmail.com>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.2217.v5.git.1789670534.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Thomas

On 17/09/2026 19:42, Thomas Bachem via GitGitGadget wrote:
> Changes since v4:
> 
>   * 2/3 takes Patrick's wording, with two corrections: the sequencer itself
>     spawns the "git commit" for a resolved conflict, and the apply backend
>     belongs to "git rebase", not to the sequencer.
>   * 3/3 opens with Phillip's sentence.
>   * The header comment of git_config_append_parameter() is Patrick's, plus
>     one sentence on a NULL value.
>   * Both tests got a comment on which picks conflict and where the sequence
>     stops (Phillip).

Thanks for adding that, it is easier to understand what the tests are 
doing now. This looks ready for next to me.

Thanks for working on it

Phillip

> 
> The code is unchanged.
> 
> Patrick, my answer to your question on 2/3 went out under the 1/3 subject by
> mistake [1]. The single picks are another exception: a "git cherry-pick
> <commit>" or "git revert <commit>" never reaches pick_commits(), and neither
> does its "--continue" or "--skip". So inside the sequencer the call would go
> to the end of pick_commits() and to those three places, plus the aborts if
> you want them. I kept it in the two builtins, which Phillip preferred, and
> 2/3 now says why. Say if you'd rather have it in the sequencer and I'll move
> it.
> 
> Based on master. Independent of the rerere series in [2].
> 
> [1] <CAA0xjtoW3JfSbuBot0ANFiDEhEv1N-Di4mSd5tYfgkFEeh07Nw@mail.gmail.com>
> 
> [2] <pull.2214.v4.git.1789373061.gitgitgadget@gmail.com>
> 
> Thomas Bachem (3):
>    config: add git_config_append_parameter()
>    rebase, cherry-pick, revert: run auto maintenance when done
>    sequencer: disable auto maintenance in spawned commands
> 
>   builtin/rebase.c                | 13 ++++++++---
>   builtin/revert.c                | 19 +++++++++++------
>   config.c                        | 20 +++++++++++------
>   config.h                        | 12 +++++++++++
>   sequencer.c                     | 38 ++++++++++++++++++++++++++++++---
>   t/t3418-rebase-continue.sh      | 20 +++++++++++++++++
>   t/t3510-cherry-pick-sequence.sh | 33 ++++++++++++++++++++++++++++
>   7 files changed, 135 insertions(+), 20 deletions(-)
> 
> 
> base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2217%2Fthomasbachem%2Frebase-auto-maintenance-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2217/thomasbachem/rebase-auto-maintenance-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/2217
> 
> Range-diff vs v4:
> 
>   1:  0472fadbc5 ! 1:  724baf2789 config: add git_config_append_parameter()
>       @@ config.h: int git_config_from_blob_oid(config_fn_t fn, const char *name,
>         void git_config_push_env(const char *spec);
>        +
>        +/*
>       -+ * Append a "-c key=value" setting to a GIT_CONFIG_PARAMETERS value in
>       -+ * `env`. The variable carries such settings from a git process to the
>       -+ * git commands it spawns, as a space separated list of 'key'='value'
>       -+ * pairs with both sides single quoted, which git_config_from_parameters()
>       -+ * reads back. A NULL `value` appends 'key'= with nothing after the equals
>       -+ * sign, which stands for a boolean true, like "-c key" on the command
>       -+ * line.
>       ++ * Append a config option to the buffer that can be exported via the
>       ++ * GIT_CONFIG_PARAMETERS environment variable, which allows us to
>       ++ * propagate configuration across Git processes. The format of the
>       ++ * variable is a space-separated list of quoted "'<key>'='<value>'"
>       ++ * pairs. With a NULL `value`, only 'key'= is appended, which git reads
>       ++ * back as a boolean true, like "-c key" on the command line.
>        + */
>        +void git_config_append_parameter(struct strbuf *env, const char *key,
>        +				 const char *value);
>   2:  b7b97262f2 ! 2:  f0ec8f1f41 rebase, cherry-pick, revert: run auto maintenance when done
>       @@ Metadata
>         ## Commit message ##
>            rebase, cherry-pick, revert: run auto maintenance when done
>        
>       -    "git cherry-pick", "git revert" and the merge backend of "git rebase"
>       -    create their commits in process, so auto maintenance runs only when
>       -    they spawn a command that runs it, like the "git commit" for a
>       -    resolved conflict. A sequence thus runs it in the middle, after each
>       -    resolution, or never.
>       +    Commands that use the sequencer with the "merge" backend, like
>       +    git-cherry-pick(1) or git-rebase(1) with "--merge", create their
>       +    commits in-process. Consequently, these commands typically don't
>       +    execute auto maintenance at all. Only the commands they spawn on the
>       +    way run it, like git-commit(1) for a resolved conflict or an edited
>       +    message.
>        
>       -    Run it once when the sequence is done, like the apply backend does.
>       +    In contrast to that, the "apply" backend of git-rebase(1) _does_ run
>       +    auto maintenance after it has processed the sequence of commits. And
>       +    this is a sensible thing to do: after all, we may just have written
>       +    lots of objects, so chances are high that we have something to clean
>       +    up now.
>        
>       -    The sequencer has no single place where every sequence ends: a
>       -    sequence of several commits ends in pick_commits(), a single pick
>       -    returns as soon as its commit is made, and "--continue" and "--skip"
>       -    have entry points of their own. Run it from the two builtins that
>       -    start or continue a sequence instead: run_specific_rebase() once the
>       -    sequencer has returned and removed its state directory, and
>       -    run_sequencer() after a successful pick, "--continue" or "--skip".
>       +    Adapt users of the "merge" backend to do the same.
>       +
>       +    The sequencer has no single exit where a call to run_auto_maintenance()
>       +    could go. A sequence ends in pick_commits(), but a single pick never
>       +    gets there: it returns from sequencer_pick_revisions() via
>       +    single_pick(), its "--continue" from sequencer_continue() via
>       +    continue_single_pick(), and its "--skip" from sequencer_skip(). So
>       +    call it from the sequencer's two callers instead: run_specific_rebase()
>       +    for the merge backend, once its state directory is gone, and
>       +    run_sequencer() in builtin/revert.c after a successful pick,
>       +    "--continue" or "--skip".
>        
>            Assisted-by: Claude Fable 5.1
>            Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
>       @@ t/t3418-rebase-continue.sh: test_orig_head () {
>         test_orig_head --merge
>         
>        +test_expect_success 'rebase runs auto maintenance once it is done' '
>       ++	# topic and main both add F2, so the pick conflicts and the rebase
>       ++	# stops before the exec runs, and once more when the exec fails
>        +	git checkout -b auto-maintenance topic &&
>        +	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
>        +		git rebase -x false main &&
>       @@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'commit descriptions in ins
>        +'
>        +
>        +test_expect_success 'cherry-pick runs auto maintenance once a stopped sequence is done' '
>       ++	# both picked and anotherpick conflict on foo, so "--continue" stops
>       ++	# once more before "--skip" ends the sequence
>        +	pristine_detach initial &&
>        +	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
>        +		git cherry-pick base..anotherpick &&
>   3:  031b3bd498 ! 3:  c51ea031ea sequencer: disable auto maintenance in spawned commands
>       @@ Metadata
>         ## Commit message ##
>            sequencer: disable auto maintenance in spawned commands
>        
>       -    Sequencer-spawned commands like 'commit' and 'merge' run
>       -    background auto maintenance, which interferes with ongoing
>       -    operations (e.g. 'rerere gc' holding MERGE_RR.lock or repacks
>       -    deleting active packs).
>       +    When the sequencer spawns "git commit" or "git merge", those commands
>       +    run "git maintenance run --auto" in the background, which can
>       +    interfere with the sequencer (e.g. 'rerere gc' holding MERGE_RR.lock
>       +    or repacks deleting active packs).
>        
>            Pass maintenance.auto=false via GIT_CONFIG_PARAMETERS to the
>            spawned commit, merge and exec commands. Appending it after the
>       @@ sequencer.c: static int continue_single_pick(struct repository *r, struct replay
>        
>         ## t/t3418-rebase-continue.sh ##
>        @@ t/t3418-rebase-continue.sh: test_orig_head --merge
>       +
>         test_expect_success 'rebase runs auto maintenance once it is done' '
>       + 	# topic and main both add F2, so the pick conflicts and the rebase
>       +-	# stops before the exec runs, and once more when the exec fails
>       ++	# stops before the exec runs. "--continue" commits the resolution
>       ++	# first, then runs the exec, which fails and stops it again.
>         	git checkout -b auto-maintenance topic &&
>         	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
>        -		git rebase -x false main &&
> 

