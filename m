Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237D3A874C
	for <git@vger.kernel.org>; Wed,  9 Sep 2026 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788942336; cv=none; b=Ur1DO6X0fq57MYhSDqdsKHmyjJfX+KqPhYjyh1EwgNWT6j7wqoNopayxxOHcILDtx5zEGt0CiH4xSarLinljl58efUNxuBWT0ZPNM2dBI/jILBKJqd+7AqTjdCFxmdHpu9sfM8hdrl1aNLw8wvFzvKiaIfulgaJoqcoUdHGbnO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788942336; c=relaxed/simple;
	bh=KanjmNjvT8Es8cYmTeHyb0uGXf5PnlLPm46ag2zyV4w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=S3K8GhVlnOb/qCySrBozPTrs28S0dwzGxtTDJ3cHFVKrxkSYzNyvXNpSOd8dGTlpKZJ1ihMOqTnhegxirbdPk/BkZGl49B+RtR9fcAUGM0wg9uXqFhAeAWa4onH/CMX3esoMq17Uvu142Uyvdkp0ltZmW1lg0xWSSb1DgQArpAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FE/Q/EVT; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FE/Q/EVT"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1c3d79b9bso4109870a12.3
        for <git@vger.kernel.org>; Wed, 09 Sep 2026 01:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788942334; x=1789547134; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WEZYibTjHlUvpezxEMul+AEbOcPqaZr9pfPm/lg8zVo=;
        b=FE/Q/EVTRZps0KphsYsqNPwudorP+MLVxNxq4wq+OF96aglbli+yVwHcRQdMfKoNZ2
         l8QNekeDswYs9j/qB4ExfWtPzLlHMxo/HImBR3jhyw6gmCjyWPNGbOEnI+I7CZ5yG8N1
         MVqe6PHZ82vT1skwwSxYoNnpmKPBye+oNrOdO0YnSR5YkyJOa1PBKT/p+g2r7a7HjQqW
         7ctdom06yiebTZJEyUf2XcjbokgmfHFZLortkY8SdsjhXTrv+OmZySqyNftM3tIdwvEa
         yjI9MTUEBLHBqZLaIt4pvnYkBk9a90BECOF0mS/mFGcihGhtQKiNBSAKiHYp12PRY33T
         bWaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788942334; x=1789547134;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WEZYibTjHlUvpezxEMul+AEbOcPqaZr9pfPm/lg8zVo=;
        b=V/uVm225cn74Dm9NPaqW2wANYqdjuB1ArXLoB259An7pP30ChbqVYgEDHQsu0Mq3P7
         rhrywulaCXfDyuygLj4775X6Fr37ebGAz+gKjeV1qQm8NqkB4UDWqXXqcvOq5y9pW9al
         d6czBINgRwFJ9xi7ITcmmPtUOKC1a3y3ilkaNGX402+6DPMeqTOYg/CtG2V8P7uQGbkg
         +27pjAwcFHhThrn7mzBxkjIm6lIh8JkrUlG/b4oIwdts+jUQnnb3HyFhwgpNQaFAnS6x
         ZVUz0qSPwTrb3aDU1XkHhuDa4ylHDOeM19u/0T2MD7s1io4XrSOViqe27hxVAb+PUi41
         3EZQ==
X-Gm-Message-State: AFuF++nm/4Ea/uGwDKJpH+hCEg9BPgKGrAoVHqZXDqnXloDvN3UlC4M1
	hlqvmGh90TInLrL/L6DT6LhnkzECv0p8DfUmN6LIOEprH8qAhYTDXD5575J1kQ==
X-Gm-Gg: AYBFou2z2TNRsOKjiJgfqjqObd1UthH7VVwEW5WjD8WRt14SIJd70ktWLnQyQb7QlOG
	+4ghnI7hD27JZaDfLFMAgXDO/efTl+IuHCcH+urwWvJOaLFLf2Suwae2PWAfHDKaahbzYxDld/Q
	g/7M0brlqSKB9Jl/WsrWMbf1niPOjPimLsQ1MfoJQUhO8ciz4JjXyLlNCqgBiwXh0LzUrPTwhs9
	dyRXIVshDrB+yXMGlA3rp59MXXQKc97ObfnIDFxBDkousK1YpWWIOWip8w7NkcFrwDgQ44JkxnL
	d1skVrKh2GCbyC9UeElYd2OCRuXosPF4bhJjxiQ00yJx/diOV2eQpx5AENu3kKpPKETjeCcDywV
	FgarsGf0R3BIJIzFf2yYhwrMFXJkj2N8/cXWpLCNYrX6k/9ND6uiKasi2zCVTIStzDD8/dJwZB6
	8QlO07wqJB98XaZb/Z9bik7KXTlyBqwzmFuIln1OTRGC0ZnDMbGkFVAMiEIVK1djS6+yD6iOI=
X-Received: by 2002:a05:6a20:9c8e:b0:3da:bea4:6219 with SMTP id adf61e73a8af0-3dabea46d66mr6005628637.20.1788942333775;
        Wed, 09 Sep 2026 01:25:33 -0700 (PDT)
Received: from [127.0.0.1] ([52.234.2.56])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339aa37dbdsm36425379eec.11.2026.09.09.01.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 01:25:32 -0700 (PDT)
Message-Id: <pull.2217.v4.git.1788942331.gitgitgadget@gmail.com>
In-Reply-To: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
From: "Thomas Bachem via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 09 Sep 2026 08:25:28 +0000
Subject: [PATCH v4 0/3] sequencer: leave auto maintenance to the end of a sequence
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

Changes since v3:

 * Commit messages condensed to about a third (Junio). 3/3 takes Junio's
   wording, except that the setting goes to the commit, merge and exec
   commands the sequencer spawns, not to all of them.

No code change.

Based on master. Independent of the rerere lock fix in [1].

[1] <pull.2214.v3.git.1788537081930.gitgitgadget@gmail.com>

Thomas Bachem (3):
  config: add git_config_append_parameter()
  rebase, cherry-pick, revert: run auto maintenance when done
  sequencer: disable auto maintenance in spawned commands

 builtin/rebase.c                | 13 ++++++++---
 builtin/revert.c                | 19 +++++++++++------
 config.c                        | 20 +++++++++++------
 config.h                        | 13 +++++++++++
 sequencer.c                     | 38 ++++++++++++++++++++++++++++++---
 t/t3418-rebase-continue.sh      | 17 +++++++++++++++
 t/t3510-cherry-pick-sequence.sh | 31 +++++++++++++++++++++++++++
 7 files changed, 131 insertions(+), 20 deletions(-)


base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2217%2Fthomasbachem%2Frebase-auto-maintenance-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2217/thomasbachem/rebase-auto-maintenance-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2217

Range-diff vs v3:

 1:  70db5ad084 ! 1:  0472fadbc5 config: add git_config_append_parameter()
     @@ Metadata
       ## Commit message ##
          config: add git_config_append_parameter()
      
     -    "git -c key=value" passes its settings on to the git commands it
     -    spawns through the environment variable GIT_CONFIG_PARAMETERS. The
     -    value is a space separated list of 'key'='value' pairs with both
     -    sides single quoted, which git_config_from_parameters() reads back in
     -    the child. The only place we write such an entry is
     -    git_config_push_split_parameter(), and it writes straight into our
     -    own environment.
     +    "git -c" passes its settings to the commands it spawns through
     +    GIT_CONFIG_PARAMETERS, a list of quoted 'key'='value' pairs. The only
     +    place that formats such an entry is git_config_push_split_parameter(),
     +    which writes straight into our own environment.
      
          Split the formatting out into git_config_append_parameter(), which
     -    appends one entry to a strbuf, so that we can build such a value for
     -    a child's environment without repeating the quoting. The sequencer
     -    will use it in a later commit to pass settings to the commands it
     -    spawns.
     +    appends one entry to a strbuf, so that a caller can build the value
     +    for a child's environment. The sequencer will use it in a later
     +    commit.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
 2:  68a728c5f4 ! 2:  b7b97262f2 rebase, cherry-pick, revert: run auto maintenance when done
     @@ Metadata
       ## Commit message ##
          rebase, cherry-pick, revert: run auto maintenance when done
      
     -    "git commit", "git merge", "git fetch" and "git am" run "git
     -    maintenance run --auto" when they are done, and so does the apply
     -    backend of "git rebase". That repacks the loose objects they wrote
     -    once there are enough of them, expires old rerere entries and does
     -    whatever other housekeeping is due.
     -
     -    The merge backend of "git rebase", "git cherry-pick" and "git revert"
     -    do not. They create their commits in process, so auto maintenance
     -    runs only when they spawn a command that runs it on its own. That is
     -    the "git commit" for a resolved conflict or an edited message, the
     -    "git merge" that "--rebase-merges" spawns for an octopus merge, a
     -    strategy other than ort or any strategy option, and whatever an exec
     -    runs. A sequence that needs none of these never runs auto
     -    maintenance. One that stops for conflicts runs it after each
     -    resolution, in the middle of the sequence.
     +    "git cherry-pick", "git revert" and the merge backend of "git rebase"
     +    create their commits in process, so auto maintenance runs only when
     +    they spawn a command that runs it, like the "git commit" for a
     +    resolved conflict. A sequence thus runs it in the middle, after each
     +    resolution, or never.
      
          Run it once when the sequence is done, like the apply backend does.
      
     -    The apply backend leaves that to builtin/rebase.c: "git am" skips
     -    auto maintenance in rebasing mode, and finish_rebase() runs it once
     -    the patches are applied. Do the same for the sequencer, from
     -    builtin/rebase.c and builtin/revert.c, because the sequencer itself
     -    has no single place where every sequence ends. A sequence of several
     -    commits ends inside pick_commits(). A single cherry-pick or revert
     -    never creates the sequencer's state directory and returns to its
     -    caller as soon as its commit is made. "--continue" and "--skip" have
     -    entry points of their own. Nothing but those two builtins starts or
     -    continues a sequence, so that is where we run auto maintenance.
     -    run_specific_rebase() runs it for the merge backend once the
     -    sequencer has returned successfully and removed its state directory,
     -    which it keeps while the rebase is stopped. run_sequencer() runs it
     -    for cherry-pick and revert when a pick, a "--continue" or a "--skip"
     -    returns successfully.
     -
     -    For the user, a sequence that never stops now runs auto maintenance
     -    once when it is done, where it never ran it before. That is the same
     -    "git maintenance run --auto --detach" as after "git commit": it
     -    detaches into the background by default and does nothing unless one
     -    of its tasks is due. The runs from the commands a sequence spawns
     -    stay for now. The next commit removes them, so that a sequence runs
     -    auto maintenance exactly once.
     +    The sequencer has no single place where every sequence ends: a
     +    sequence of several commits ends in pick_commits(), a single pick
     +    returns as soon as its commit is made, and "--continue" and "--skip"
     +    have entry points of their own. Run it from the two builtins that
     +    start or continue a sequence instead: run_specific_rebase() once the
     +    sequencer has returned and removed its state directory, and
     +    run_sequencer() after a successful pick, "--continue" or "--skip".
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>
 3:  7a353df3d9 ! 3:  031b3bd498 sequencer: disable auto maintenance in spawned commands
     @@ Metadata
       ## Commit message ##
          sequencer: disable auto maintenance in spawned commands
      
     -    The "git commit" and "git merge" the sequencer spawns run "git
     -    maintenance run --auto --detach" as they finish, and so does any
     -    such command an exec runs. That maintenance then works in the
     -    background while the sequencer goes on with the sequence, and the
     -    two get in each other's way. With rerere enabled, the maintenance
     -    started by the "git commit" of a "git rebase --continue" runs
     -    "rerere gc", which can still hold MERGE_RR.lock when the next pick
     -    conflicts. The rebase then dies with "Unable to create
     -    '.../MERGE_RR.lock': File exists" instead of stopping for the user
     -    to resolve the conflict. And a repack can delete a pack the
     -    sequencer still has open, which 65cda10d5b (sequencer: release the
     -    ODB before spawning git commit, 2026-08-12) works around.
     +    Sequencer-spawned commands like 'commit' and 'merge' run
     +    background auto maintenance, which interferes with ongoing
     +    operations (e.g. 'rerere gc' holding MERGE_RR.lock or repacks
     +    deleting active packs).
      
     -    Pass maintenance.auto=false to these commands through
     -    GIT_CONFIG_PARAMETERS, as "git -c" would. We build the value once
     -    from the one we inherited and append our setting after the user's
     -    own -c settings so that it wins. The environment also reaches
     -    everything the command spawns in turn, so a git command run from an
     -    exec is covered as well. The sequencer also spawns "git stash", "git
     -    reset" and "git notes", which never run auto maintenance.
     +    Pass maintenance.auto=false via GIT_CONFIG_PARAMETERS to the
     +    spawned commit, merge and exec commands. Appending it after the
     +    user's own settings ensures it wins, and the environment reaches
     +    whatever they spawn in turn.
      
     -    With the previous commit, rebase, cherry-pick and revert run auto
     -    maintenance once when they are done, so a sequence now runs it
     -    exactly once, at the end. A sequence that stops for conflicts used
     -    to run it at every resolution and now piles up its loose objects
     -    until the end, as a sequence without conflicts always has.
     -
     -    A command the user runs while the sequence is stopped, like "git
     -    commit --amend" at an edit, still runs auto maintenance. The
     -    sequencer does not spawn it and has no say in it.
     +    Auto maintenance now runs exactly once when the sequence
     +    completes. Commands run manually by the user while stopped are
     +    unaffected and continue to run auto maintenance normally.
      
          Assisted-by: Claude Fable 5.1
          Signed-off-by: Thomas Bachem <mail@thomasbachem.com>

-- 
gitgitgadget
