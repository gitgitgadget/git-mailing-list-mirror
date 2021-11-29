Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A845C433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237427AbhK2XNe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbhK2XMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:12:54 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AD9C041F4A
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:22 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id o13so39953655wrs.12
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+1Vd72nqUwAjp8Ij0OkEUfFYOlWXcJTJ3SLTyN4clHg=;
        b=QZMCueOSKzfOBsuL7fPbyLDZqel9n3IVvon1/Zuo1PpWLuj6aiBFAdf+M0w3mhlYSG
         RL0RSzmkA8mHNKfBO5/UqA+PGtyhZctaFWQHg+AgQqVCDf4uDENEN2xqrbk02bFih5Zp
         Gvm5P4dqYe3Mi5vpjgmszxanrwG45B0wBg/6ZKzhV+RoUPHJjVTdQvshpKVj5SJzojLF
         pQtWu0K2Dt7A/pRpkaw54oegR0puMtYfpbQCS/esJWsTJU4GZzMfn9BhEI2qbl1JFA+8
         q4T/T/oRtWWUAabekR0l8dvrvp3TpnaZiAdE7KBWxHWQf9i4/plYPnwZs1u2CYP+UZC9
         6iLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+1Vd72nqUwAjp8Ij0OkEUfFYOlWXcJTJ3SLTyN4clHg=;
        b=WXVp5PfV6t73SnOh39uxGMg5vhzSeq47SdaV/UuR5n5yUBu1WxWhX6hKLvW+VqFzoh
         PDtkYi+UYDMV7c2wOum7pLoW/3lYN0aMTqyRGfztahrY0vdBc+t+/XqpuL+tWI2PxyYT
         xEGSUTFp/M3u6C5hFZdLQO6p1+otUqvd6XfzLEytixhObIpC8foPsD86N5/3lasJ9veb
         fiMHSbggsOp3sCxLxz8o8xvyEt9pG/5Kq9QMO9A801opJ6sQgFhSHrVvY97AByHI2M/t
         LdKmfXfoAmpLiqsyMnnFFy0rkpDOIs+0RL+LCiwLL4FgZHZ/HyDdroW207W6raNLkALa
         vd0Q==
X-Gm-Message-State: AOAM530AjPHL/jBy/LxAgQfDy4IvPmvnYBfgpb5c9ZRI6GJkdBTr3QcC
        tYTMzmKJnctTEVBJlIC4et/jJ+SrqsM=
X-Google-Smtp-Source: ABdhPJwGUDBGaFeuEVWpyI9UcDB9ve1VyXsnnNOaN2Dl0dQh/MhgOO4QvYUzEfVMZva/wE+FEMaQ8g==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr36717017wrt.31.1638225441039;
        Mon, 29 Nov 2021 14:37:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15sm562961wmq.13.2021.11.29.14.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:37:20 -0800 (PST)
Message-Id: <1035ee7f9ce174279b8065edf948b76b82281268.1638225434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
        <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 22:37:10 +0000
Subject: [PATCH v4 07/11] rebase: do not attempt to remove
 startup_info->original_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Since rebase spawns a `checkout` subprocess, make sure we run that from
the startup_info->original_cwd directory, so that the checkout process
knows to protect that directory.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 sequencer.c          | 2 ++
 t/t2501-cwd-empty.sh | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ea96837cde3..83f257e7fa4 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4228,6 +4228,8 @@ static int run_git_checkout(struct repository *r, struct replay_opts *opts,
 
 	cmd.git_cmd = 1;
 
+	if (startup_info->original_cwd)
+		cmd.dir = startup_info->original_cwd;
 	strvec_push(&cmd.args, "checkout");
 	strvec_push(&cmd.args, commit);
 	strvec_pushf(&cmd.env_array, GIT_REFLOG_ACTION "=%s", action);
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 6ab82e05d98..4f7dba9ab3d 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -166,11 +166,11 @@ test_expect_success 'cherry-pick fails if cwd needs to be removed' '
 '
 
 test_expect_success 'rebase does not clean cwd incidentally' '
-	test_incidental_dir_removal failure git rebase reverted
+	test_incidental_dir_removal success git rebase reverted
 '
 
 test_expect_success 'rebase fails if cwd needs to be removed' '
-	test_required_dir_removal failure git rebase fd_conflict
+	test_required_dir_removal success git rebase fd_conflict
 '
 
 test_expect_success 'revert does not clean cwd incidentally' '
-- 
gitgitgadget

