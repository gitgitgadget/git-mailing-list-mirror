Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887233DD874
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670538; cv=none; b=PbCE8qH0u9PDEt5oWRzvKo/gBJziQYdx+OktqrKG5eTGpbC0mK+u+T+dSYGfIMKtkypwbu2GiszQPpaVLM7pnt3zQwEbvsDH7Mn1JvCVLIYFZV1x/aKxs8d0PajaunRUFktvdUCE9tiUpegxNxRmUTgY3QTmLAVs0g2Qu70ldJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670538; c=relaxed/simple;
	bh=sdAG48haYaW/kp7QIJbcljC7jjjnufcTNczHQajLxyA=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=gC4De5DumrTpGJEo59e/nPwSZevITxxqmSYNd1yEwUswYHifSHRUvZTioqPLJSFcvktC/5TtkIYRPDY4V5Hi9ufoFhdYCJr73U+8on6rh4MYbz35H3aogOdu580y+tDuTV/8yIlP5g2a59ABy1VxruH7QWJkEy4iL7647JSDdsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBN5qSRU; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBN5qSRU"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so8652215ad.1
        for <git@vger.kernel.org>; Thu, 17 Sep 2026 11:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789670536; x=1790275336; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pVhwBOsMN304poBUjT53qgakPeYRsYWXwM2uI1+Sw7U=;
        b=iBN5qSRUa8jwFCuU6ixy+AetBPIvGcBJxwX36+Lu2BM1l78cmLghVc9GLDT5udiYbp
         dniMEkmb3BCMdmNrd8I1PdISy2k+DBTZrIoJhNOQ0Y30YhGbi+j1jxhgMc3nrxEWRAm5
         pKe+siZuJswVmjdnrSlGVBlCMvAkYKjKCtmNRNQj/lyXX1lwnyVRMi5UlHmqD1m1sP5W
         6p5UoZdOanj9IjYpqIWefBYviLLeGX9wMappMTLYJQg3fAFllvpSMySFqKJHpVEucJCj
         wxS3C20FtfUCOlHSywAxBJIDWmAiSpwhpGsnTpCBVF5nahAbpWOuJeoLRaO5WWnNUW06
         wYSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789670536; x=1790275336;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pVhwBOsMN304poBUjT53qgakPeYRsYWXwM2uI1+Sw7U=;
        b=R3Y6sm60vonyLC4N1hksBAKC0tJBwTOTXdy22Fre58Hwx3u/bR7dgwtgD5rAnAqnrx
         mYdC2ADL8GR6OBKIKRC7L+CJDhdFvVZjT+4YUggx9HjtncogVM9Jm0N3YG3eYaGPuV8u
         WQHqkSyd8zYIqk7eme1L+lPFwmCVOG+9YaIpDfc889/RfpWe4yNzmg+MVyz42FtwuDqG
         R0xkeGnQtqd9u5aP26uMTbLyFbjF+/dKlHzZA+o/65tjpCUrp/aFNGQdN+0k5oGsGPnA
         MZs6ksrUm9weIjqkUPAGotRYpjQGj7pf9UrbuKHdnyzfqKSZ64VV4q3Mfg81PXG92TQ+
         bZCg==
X-Gm-Message-State: AFuF++l0/bFhSdRfG8Gtqkhi5SZtsRIfiFjHQ3PgfSD5tPKrYmgqf1Kb
	e1Cc/xIaGeQJL4s3R5s4cRKw6LDBGmOYVIlOWk3zlawu+RcC/G3AIj1R+GwfKQ==
X-Gm-Gg: AYBFou166Hpm3JYRUA89ld9bOAkAjrAyMuRB42Lnzct6xdm3i42wKJlL/vxQRkIVWaZ
	vun+Rv+hDNrCGysWoYeZAoIlYcgfu3X9gTo36YahmpAFx2TO8xX1fXmyya+Y79jkr2AyAhB4CA+
	0O9yVi0faj6DJp+JaNi+e4z3B1OQ9b61uuM+SWTbmVlkex4KlQWGZTtw5l1EsoTn9LI1IeIxL/n
	K3OvOzCS9VqnFSc9PTKy8xjQaPx4luSCd4dAq4YVTJrpQT2ovdMfLAfFmiF2bX9RBR+urv1WwOx
	LtCKd9P4fYgGjRcusxBPH6Bj7Egtb04p4Sq/TLzXqoQD5zS1LE59R29DTzGb7LEA1erDhtkSKQw
	1cbVcB4gD2mLrjKEwDNuijgKbgPRz55vZmt43toFcTwIlJLv09kfy5A5oiuMFjsHdvggujakpVo
	od9Y8XGmYJmheilxdIgBPCIZ+xq0fmttbiiuCtDiAbBEnpDAVdun8BlwqQ9tO0+rfrs+tP36O0
X-Received: by 2002:a17:902:f710:b0:2d7:1b20:e98f with SMTP id d9443c01a7336-2dd9c6b8f71mr60040125ad.2.1789670535685;
        Thu, 17 Sep 2026 11:42:15 -0700 (PDT)
Received: from [127.0.0.1] ([20.168.125.98])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5b2753csm33131241eec.31.2026.09.17.11.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:42:15 -0700 (PDT)
Message-Id: <pull.2217.v5.git.1789670534.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 17 Sep 2026 18:42:11 +0000
Subject: [PATCH v5 0/3] sequencer: leave auto maintenance to the end of a sequence
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Thomas Bachem <mail@thomasbachem.com>

Changes since v4:

 * 2/3 takes Patrick's wording, with two corrections: the sequencer itself
   spawns the "git commit" for a resolved conflict, and the apply backend
   belongs to "git rebase", not to the sequencer.
 * 3/3 opens with Phillip's sentence.
 * The header comment of git_config_append_parameter() is Patrick's, plus
   one sentence on a NULL value.
 * Both tests got a comment on which picks conflict and where the sequence
   stops (Phillip).

The code is unchanged.

Patrick, my answer to your question on 2/3 went out under the 1/3 subject by
mistake [1]. The single picks are another exception: a "git cherry-pick
<commit>" or "git revert <commit>" never reaches pick_commits(), and neither
does its "--continue" or "--skip". So inside the sequencer the call would go
to the end of pick_commits() and to those three places, plus the aborts if
you want them. I kept it in the two builtins, which Phillip preferred, and
2/3 now says why. Say if you'd rather have it in the sequencer and I'll move
it.

Based on master. Independent of the rerere series in [2].

[1] <CAA0xjtoW3JfSbuBot0ANFiDEhEv1N-Di4mSd5tYfgkFEeh07Nw@mail.gmail.com>

[2] <pull.2214.v4.git.1789373061.gitgitgadget@gmail.com>

Thomas Bachem (3):
  config: add git_config_append_parameter()
  rebase, cherry-pick, revert: run auto maintenance when done
  sequencer: disable auto maintenance in spawned commands

 builtin/rebase.c                | 13 ++++++++---
 builtin/revert.c                | 19 +++++++++++------
 config.c                        | 20 +++++++++++------
 config.h                        | 12 +++++++++++
 sequencer.c                     | 38 ++++++++++++++++++++++++++++++---
 t/t3418-rebase-continue.sh      | 20 +++++++++++++++++
 t/t3510-cherry-pick-sequence.sh | 33 ++++++++++++++++++++++++++++
 7 files changed, 135 insertions(+), 20 deletions(-)


base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2217%2Fthomasbachem%2Frebase-auto-maintenance-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2217/thomasbachem/rebase-auto-maintenance-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/2217

Range-diff vs v4:

 1:  0472fadbc5 ! 1:  724baf2789 config: add git_config_append_parameter()
     @@ config.h: int git_config_from_blob_oid(config_fn_t fn, const char *name,
       void git_config_push_env(const char *spec);
      +
      +/*
     -+ * Append a "-c key=value" setting to a GIT_CONFIG_PARAMETERS value in
     -+ * `env`. The variable carries such settings from a git process to the
     -+ * git commands it spawns, as a space separated list of 'key'='value'
     -+ * pairs with both sides single quoted, which git_config_from_parameters()
     -+ * reads back. A NULL `value` appends 'key'= with nothing after the equals
     -+ * sign, which stands for a boolean true, like "-c key" on the command
     -+ * line.
     ++ * Append a config option to the buffer that can be exported via the
     ++ * GIT_CONFIG_PARAMETERS environment variable, which allows us to
     ++ * propagate configuration across Git processes. The format of the
     ++ * variable is a space-separated list of quoted "'<key>'='<value>'"
     ++ * pairs. With a NULL `value`, only 'key'= is appended, which git reads
     ++ * back as a boolean true, like "-c key" on the command line.
      + */
      +void git_config_append_parameter(struct strbuf *env, const char *key,
      +				 const char *value);
 2:  b7b97262f2 ! 2:  f0ec8f1f41 rebase, cherry-pick, revert: run auto maintenance when done
     @@ Metadata
       ## Commit message ##
          rebase, cherry-pick, revert: run auto maintenance when done
      
     -    "git cherry-pick", "git revert" and the merge backend of "git rebase"
     -    create their commits in process, so auto maintenance runs only when
     -    they spawn a command that runs it, like the "git commit" for a
     -    resolved conflict. A sequence thus runs it in the middle, after each
     -    resolution, or never.
     +    Commands that use the sequencer with the "merge" backend, like
     +    git-cherry-pick(1) or git-rebase(1) with "--merge", create their
     +    commits in-process. Consequently, these commands typically don't
     +    execute auto maintenance at all. Only the commands they spawn on the
     +    way run it, like git-commit(1) for a resolved conflict or an edited
     +    message.
      
     -    Run it once when the sequence is done, like the apply backend does.
     +    In contrast to that, the "apply" backend of git-rebase(1) _does_ run
     +    auto maintenance after it has processed the sequence of commits. And
     +    this is a sensible thing to do: after all, we may just have written
     +    lots of objects, so chances are high that we have something to clean
     +    up now.
      
     -    The sequencer has no single place where every sequence ends: a
     -    sequence of several commits ends in pick_commits(), a single pick
     -    returns as soon as its commit is made, and "--continue" and "--skip"
     -    have entry points of their own. Run it from the two builtins that
     -    start or continue a sequence instead: run_specific_rebase() once the
     -    sequencer has returned and removed its state directory, and
     -    run_sequencer() after a successful pick, "--continue" or "--skip".
     +    Adapt users of the "merge" backend to do the same.
     +
     +    The sequencer has no single exit where a call to run_auto_maintenance()
     +    could go. A sequence ends in pick_commits(), but a single pick never
     +    gets there: it returns from sequencer_pick_revisions() via
     +    single_pick(), its "--continue" from sequencer_continue() via
     +    continue_single_pick(), and its "--skip" from sequencer_skip(). So
     +    call it from the sequencer's two callers instead: run_specific_rebase()
     +    for the merge backend, once its state directory is gone, and
     +    run_sequencer() in builtin/revert.c after a successful pick,
     +    "--continue" or "--skip".
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
     @@ t/t3418-rebase-continue.sh: test_orig_head () {
       test_orig_head --merge
       
      +test_expect_success 'rebase runs auto maintenance once it is done' '
     ++	# topic and main both add F2, so the pick conflicts and the rebase
     ++	# stops before the exec runs, and once more when the exec fails
      +	git checkout -b auto-maintenance topic &&
      +	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
      +		git rebase -x false main &&
     @@ t/t3510-cherry-pick-sequence.sh: test_expect_success 'commit descriptions in ins
      +'
      +
      +test_expect_success 'cherry-pick runs auto maintenance once a stopped sequence is done' '
     ++	# both picked and anotherpick conflict on foo, so "--continue" stops
     ++	# once more before "--skip" ends the sequence
      +	pristine_detach initial &&
      +	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
      +		git cherry-pick base..anotherpick &&
 3:  031b3bd498 ! 3:  c51ea031ea sequencer: disable auto maintenance in spawned commands
     @@ Metadata
       ## Commit message ##
          sequencer: disable auto maintenance in spawned commands
      
     -    Sequencer-spawned commands like 'commit' and 'merge' run
     -    background auto maintenance, which interferes with ongoing
     -    operations (e.g. 'rerere gc' holding MERGE_RR.lock or repacks
     -    deleting active packs).
     +    When the sequencer spawns "git commit" or "git merge", those commands
     +    run "git maintenance run --auto" in the background, which can
     +    interfere with the sequencer (e.g. 'rerere gc' holding MERGE_RR.lock
     +    or repacks deleting active packs).
      
          Pass maintenance.auto=false via GIT_CONFIG_PARAMETERS to the
          spawned commit, merge and exec commands. Appending it after the
     @@ sequencer.c: static int continue_single_pick(struct repository *r, struct replay
      
       ## t/t3418-rebase-continue.sh ##
      @@ t/t3418-rebase-continue.sh: test_orig_head --merge
     + 
       test_expect_success 'rebase runs auto maintenance once it is done' '
     + 	# topic and main both add F2, so the pick conflicts and the rebase
     +-	# stops before the exec runs, and once more when the exec fails
     ++	# stops before the exec runs. "--continue" commits the resolution
     ++	# first, then runs the exec, which fails and stops it again.
       	git checkout -b auto-maintenance topic &&
       	test_must_fail env GIT_TRACE2_EVENT="$(pwd)/stop.txt" \
      -		git rebase -x false main &&

-- 
gitgitgadget
