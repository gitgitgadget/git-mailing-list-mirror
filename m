Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-31.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B65C48BDF
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0036561153
	for <git@archiver.kernel.org>; Wed, 16 Jun 2021 00:45:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhFPArY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 20:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhFPArX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 20:47:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C916C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:45:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m205-20020a25d4d60000b029052a8de1fe41so471346ybf.23
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 17:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=9dNKI8/KGq0kHnZN4jUWXxwIdCWS1i8oTQ7byzTXKqI=;
        b=Nvj920lRbeYwVXBJqFriejRS648jlxA3FmsrWB6nKLT9fIcKTzvs18peH/A/9CYibg
         3TlIMYXElgARFiw8/e8aXECijl8jnOUaOi7Vk+wFBP/1/KjkXXc03WjSORsME+0+Jefr
         2tLYMbIP2S1aWfVUpgR9ICoMpvIGC502SjyKa+NaIr0kI8eJVoR1nS3NrEt5Yl8H1HY/
         ui5/hTeDG72ZjP1PVxEi59+tGB53YcNdBRqfVz2FLQ2EXL04ZBzgyBgKO6pJfGPJCPVz
         C99OM8HMTilyh833zriv/R2NkUbYuCH8+k5oJCtiU/XzKnktp66mhGtbQusbJppkI2lY
         ZMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=9dNKI8/KGq0kHnZN4jUWXxwIdCWS1i8oTQ7byzTXKqI=;
        b=WTqUK4CceTjvrvhaudRpztILGs4C7TUkw7fspPWxYZkBFNFH4A1gJqmHv2nBzZ9zfR
         +Aqq4CC8VgsA0im/ZAgor0/FWdNIhN97Ec480VJ8UPFl86/MzJM6FezWtENVVtJrpdAM
         2rUPIhaF+oBME18CyEG/YeJu+uW3OilpgX3XHLjh4tRT4+Yg/bt1ziwyp+lmwMhSXJcC
         YAkePl7VqBjomsT68bwmBbBkTCtY4zAEvafIy1gaD6Q+TuwZhcLGVpDETZInQUQosnY4
         KSjkLX/P/Z213uBC/Nf9ahBwiNd1K+4pHmWyjVfOWN0q+NtNxe7goqiH1jXekkf6zMNa
         IW9w==
X-Gm-Message-State: AOAM533T2/qiiX629/FGsFMj8chbJQ2zaBXXf3N7oChfS0Ga8W2EyoZx
        5SwSOlWOCbxJ05YwZ9Twk5S4uqjp48EuyZtXZBiVwAnjMr6dO4H+5zfkIM1mb1Byv6hPvYqebAf
        ILjxX9IHPZ7yZZR8yNEu5ot6iXP1J63LRFQrMOlE56lfGspX4dj/9Yle9P35jzUi/pTJCjaLC8Q
        ==
X-Google-Smtp-Source: ABdhPJxgOONptl0W1WHzGsp+tbm0b9J5a6ae8WNd3Ne1BCNLz3a87eJGnSk3Gi+CFeooje1bRYxwlzx8d1c58fRuzUI=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:d4cc:f4a9:b043:ff6e])
 (user=emilyshaffer job=sendgmr) by 2002:a25:ca0a:: with SMTP id
 a10mr2601981ybg.5.1623804316081; Tue, 15 Jun 2021 17:45:16 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:45:04 -0700
In-Reply-To: <20210611225428.1208973-1-emilyshaffer@google.com>
Message-Id: <20210616004508.87186-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v2 0/4] cache parent project's gitdir in submodules
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Albert Cui <albertcui@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Atharva Raykar <raykar.ath@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The reception for this series seemed pretty good in v1, so I'm dropping
the RFC.

Tested: https://github.com/nasamuffin/git/actions/runs/941100646

Sinec v1, mostly platform-friendliness fixes. Also added documentation
for the new config option - wordsmithing help is always welcome.

 - Emily

Emily Shaffer (4):
  t7400-submodule-basic: modernize inspect() helper
  introduce submodule.superprojectGitDir cache
  submodule: cache superproject gitdir during absorbgitdirs
  submodule: cache superproject gitdir during 'update'

 Documentation/config/submodule.txt | 12 ++++++++
 builtin/submodule--helper.c        |  4 +++
 git-submodule.sh                   | 10 ++++++
 submodule.c                        | 10 ++++++
 t/t7400-submodule-basic.sh         | 49 ++++++++++++++----------------
 t/t7406-submodule-update.sh        | 10 ++++++
 t/t7412-submodule-absorbgitdirs.sh |  9 +++++-
 7 files changed, 77 insertions(+), 27 deletions(-)

Range-diff against v1:
1:  d6284438fb = 1:  a6718eea80 t7400-submodule-basic: modernize inspect() helper
2:  56470e2eab ! 2:  4cebe7bcb5 introduce submodule.superprojectGitDir cache
    @@ Commit message
     
         Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
     
    + ## Documentation/config/submodule.txt ##
    +@@ Documentation/config/submodule.txt: submodule.alternateErrorStrategy::
    + 	`ignore`, `info`, `die`. Default is `die`. Note that if set to `ignore`
    + 	or `info`, and if there is an error with the computed alternate, the
    + 	clone proceeds as if no alternate was specified.
    ++
    ++submodule.superprojectGitDir::
    ++	The relative path from the submodule's worktree  to the superproject's
    ++	gitdir. This config should only be present in projects which are
    ++	submodules, but is not guaranteed to be present in every submodule. It
    ++	is set automatically during submodule creation.
    +++
    ++	In situations where more than one superproject references the same
    ++	submodule worktree, the value of this config and the behavior of
    ++	operations which use it are undefined. To reference a single project
    ++	from multiple superprojects, it is better to create a worktree of the
    ++	submodule for each superproject.
    +
      ## builtin/submodule--helper.c ##
     @@ builtin/submodule--helper.c: static int module_clone(int argc, const char **argv, const char *prefix)
      		git_config_set_in_file(p, "submodule.alternateErrorStrategy",
3:  42f954f523 ! 3:  df97a9c2bb submodule: cache superproject gitdir during absorbgitdirs
    @@ submodule.c: static void relocate_single_git_dir_into_superproject(const char *p
     
      ## t/t7412-submodule-absorbgitdirs.sh ##
     @@ t/t7412-submodule-absorbgitdirs.sh: test_expect_success 'absorb the git dir' '
    - 	test -d .git/modules/sub1 &&
      	git status >actual.1 &&
      	git -C sub1 rev-parse HEAD >actual.2 &&
    -+	test . -ef "$(git -C sub1 config submodule.superprojectGitDir)" &&
      	test_cmp expect.1 actual.1 &&
    - 	test_cmp expect.2 actual.2
    +-	test_cmp expect.2 actual.2
    ++	test_cmp expect.2 actual.2 &&
    ++
    ++	# make sure the submodule cached the superproject gitdir correctly
    ++	test-tool path-utils real_path . >expect &&
    ++	test-tool path-utils real_path \
    ++		"$(git -C sub1 config submodule.superprojectGitDir)" >actual &&
    ++
    ++	test_cmp expect actual
      '
    + 
    + test_expect_success 'absorbing does not fail for deinitialized submodules' '
4:  4f55ab42c7 ! 4:  a3f3be58ad submodule: cache superproject gitdir during 'update'
    @@ git-submodule.sh: cmd_update()
     +		# Cache a pointer to the superproject's gitdir. This may have
     +		# changed, so rewrite it unconditionally. Writes it to worktree
     +		# if applicable, otherwise to local.
    ++		relative_gitdir="$(git rev-parse --path-format=relative \
    ++						 --prefix "${sm_path}" \
    ++						 --git-dir)"
     +
    -+		sp_gitdir="$(git rev-parse --absolute-git-dir)"
    -+		relative_gitdir="$(realpath --relative-to "$sm_path" "$sp_gitdir")"
     +		git -C "$sm_path" config --worktree \
     +			submodule.superprojectgitdir "$relative_gitdir"
     +
    @@ git-submodule.sh: cmd_update()
      			(
     
      ## t/t7406-submodule-update.sh ##
    -@@ t/t7406-submodule-update.sh: test_expect_success 'submodule update --quiet passes quietness to merge/rebase'
    +@@ t/t7406-submodule-update.sh: test_expect_success 'submodule update --quiet passes quietness to fetch with a s
      	)
      '
      
-- 
2.32.0.272.g935e593368-goog

