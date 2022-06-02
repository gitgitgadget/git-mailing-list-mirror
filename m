Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0437BC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 09:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbiFBJKT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 05:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiFBJKR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 05:10:17 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9222C2A893B
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 02:10:15 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u3so5621469wrg.3
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 02:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YFwPe+7eiX2euGtnylXKJggUONxfaCJ7jr86e3fDwp8=;
        b=Wxxe79rYHdY+f+90VMQiQWst21apHaqN1wS+7eIkS5DISrhwX4WEkkFxCqeOJPxht0
         5NJhF267aifLzCIUJ0CjeTcAiIUcWFuISo213+7s6JTstBfjbkdkrBZDHxSxEf7XGr1u
         xXpndextQBNyJcqEF0+xOYeG9wiQyZnRtiSvbP5n/HSOFrzIQo/Wji+gQiJufyVNWF/5
         06XCBjJOpHz6s9vT3ZVzEXGNkFnKO+oAUxvRiQl+79K0ccXKMog7YSjUOVK2luNLc5Yz
         BahTpdA4MaCbNI2UhCoqhejkjq3Ux7Gp1x7GIRhWD3jAhrF3qK0A8uVz/OZO7r8KTOLK
         wKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YFwPe+7eiX2euGtnylXKJggUONxfaCJ7jr86e3fDwp8=;
        b=rcv9CkqUehTLEpkYPGtjrzlraXrCgCq4v8etAaQ5Q3b3vrbkfTMRskc1C/E3Abvgit
         i82atBsdVYkbXPcs5aGo4OQeVTig/A7rGfNnPTItEwy57Db3b6H0rZgyoIDZg0WgAmT7
         /vWo58vbhimkP663x8zGHm1DiALEfMd9shFwqD5BPd6I7cN8ZVQ8Q02ARl52ekbXgt3d
         Ik1bVDWAt/JVxuvtlBS75iKlSXyxgorU5btY//f1YoWwZYnPaAhsRlAOFVm9BR1mGcb4
         D+sI8wNUnujQakgfF6GW0OTeavhWMrNoYziL/rfyy8DFbG5BmLqhqpezuws3uB3wSGZc
         Y3dg==
X-Gm-Message-State: AOAM530ZOhXeH1leyO2VhvIgC6lPyYJixWbAI2l08dd5/AY6XAJJGBYw
        l3Jn8dkGkUKy6eiJ6Z29ziX398GaGdM=
X-Google-Smtp-Source: ABdhPJysV33640wTG+kHjChhnirYNUwNfFgaGJhjf4MVQ9UaiCjmmoM6LlX/pcNVVQUgVPDBBZxOYw==
X-Received: by 2002:a05:6000:160c:b0:210:2a80:195 with SMTP id u12-20020a056000160c00b002102a800195mr2827234wrb.251.1654161013791;
        Thu, 02 Jun 2022 02:10:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h42-20020a05600c49aa00b003973d425a7fsm4833088wmp.41.2022.06.02.02.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 02:10:13 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/2] run-command.h: rename "env_array" to "env"
Date:   Thu,  2 Jun 2022 11:09:49 +0200
Message-Id: <cover-v3-0.2-00000000000-20220602T090745Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1103.gb3ecdfb3e6a
In-Reply-To: <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Follow-up 32ec72c3e1 (Merge branch 'ab/run-command', 2021-12-15) and
rename the "env_array" member to simply "env" in the "struct
child_process".

Changes since v2[1]:

 * Rebased on "master" (there was one small conflict).
 * Squashed the first 3 commits into one. Now the coccinelle rule is
   mentionid in the 1/2 commit message, instead of adding & removing
   it before/after the change itself.

1. https://lore.kernel.org/git/cover-v2-0.4-00000000000-20220520T072122Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (2):
  run-command API: rename "env_array" to "env"
  run-command API users: use "env" not "env_array" in comments & names

 add-patch.c                 |  2 +-
 branch.c                    |  2 +-
 builtin/difftool.c          |  6 ++---
 builtin/receive-pack.c      | 32 +++++++++++++--------------
 builtin/stash.c             | 16 +++++++-------
 builtin/submodule--helper.c | 44 ++++++++++++++++++-------------------
 builtin/worktree.c          |  8 +++----
 connect.c                   |  9 ++++----
 connected.c                 |  2 +-
 daemon.c                    | 14 ++++++------
 editor.c                    |  2 +-
 hook.c                      |  2 +-
 http-backend.c              |  4 ++--
 object-file.c               |  2 +-
 pager.c                     |  4 ++--
 promisor-remote.c           |  2 +-
 run-command.c               | 19 ++++++++--------
 run-command.h               | 14 ++++++------
 sequencer.c                 | 18 +++++++--------
 submodule.c                 | 38 ++++++++++++++++----------------
 submodule.h                 |  4 ++--
 t/helper/test-run-command.c |  2 +-
 trailer.c                   |  2 +-
 transport-helper.c          |  2 +-
 wt-status.c                 |  2 +-
 25 files changed, 127 insertions(+), 125 deletions(-)

Range-diff against v2:
1:  e3f33fce566 < -:  ----------- cocci: add a rename of "struct child_process"'s "env_array" to "env"
2:  5aeb6ec9117 ! 1:  80ef05d5b0a run-command API: rename "env_array" to "env"
    @@ Metadata
      ## Commit message ##
         run-command API: rename "env_array" to "env"
     
    -    As noted in the preceding commit it would be nice to not deal with the
    -    oddity of having an "_array" suffix for the "env" strvec, but not for
    -    its "args" sibling.
    +    Start following-up on the rename mentioned in c7c4bdeccf3 (run-command
    +    API: remove "env" member, always use "env_array", 2021-11-25) of
    +    "env_array" to "env".
     
    -    We can do that with coccinelle in a way that's easy to review. The
    -    only manual changes in this commit are:
    +    The "env_array" name was picked in 19a583dc39e (run-command: add
    +    env_array, an optional argv_array for env, 2014-10-19) because "env"
    +    was taken. Let's not forever keep the oddity of "*_array" for this
    +    "struct strvec", but not for its "args" sibling.
     
    -     * git mv contrib/coccinelle/run_command{.pending,}.cocci
    -     * The change in run-command.h to rename the struct member itself, and
    -       to change its initializer.
    +    This commit is almost entirely made with a coccinelle rule[1]. The
    +    only manual change here is in run-command.h to rename the struct
    +    member itself and to change "env_array" to "env" in the
    +    CHILD_PROCESS_INIT initializer.
     
    -    The rest of this is all the result of a subsequent:
    +    The rest of this is all a result of applying [1]:
     
          * make contrib/coccinelle/run_command.cocci.patch
          * patch -p1 <contrib/coccinelle/run_command.cocci.patch
          * git add -u
     
    +    1. cat contrib/coccinelle/run_command.pending.cocci
    +       @@
    +       struct child_process E;
    +       @@
    +       - E.env_array
    +       + E.env
    +
    +       @@
    +       struct child_process *E;
    +       @@
    +       - E->env_array
    +       + E->env
    +
         I've avoided changing any comments and derived variable names here,
         that will all be done in the next commit.
     
    @@ builtin/receive-pack.c: static const char *push_to_deploy(unsigned char *sha1,
      	child.no_stdin = 1;
      	child.no_stdout = 1;
     @@ builtin/receive-pack.c: static const char *unpack(int err_fd, struct shallow_info *si)
    + 			close(err_fd);
      		return "unable to create temporary object directory";
      	}
    - 	if (tmp_objdir)
    --		strvec_pushv(&child.env_array, tmp_objdir_env(tmp_objdir));
    -+		strvec_pushv(&child.env, tmp_objdir_env(tmp_objdir));
    +-	strvec_pushv(&child.env_array, tmp_objdir_env(tmp_objdir));
    ++	strvec_pushv(&child.env, tmp_objdir_env(tmp_objdir));
      
      	/*
      	 * Normally we just pass the tmp_objdir environment to the child
    @@ connected.c: int check_connected(oid_iterate_fn fn, void *cb_data,
      	rev_list.no_stdout = 1;
      	if (opt->err_fd)
     
    - ## contrib/coccinelle/run_command.pending.cocci => contrib/coccinelle/run_command.cocci ##
    -
      ## daemon.c ##
     @@ daemon.c: static int upload_pack(const struct strvec *env)
      	strvec_pushl(&cld.args, "upload-pack", "--strict", NULL);
3:  ca09da570ef < -:  ----------- cocci: remove env_array -> env migration
4:  5419f839c74 = 2:  4039fec4f29 run-command API users: use "env" not "env_array" in comments & names
-- 
2.36.1.1103.gb3ecdfb3e6a

