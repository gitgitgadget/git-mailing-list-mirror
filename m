Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CDFC43334
	for <git@archiver.kernel.org>; Sun, 19 Jun 2022 06:50:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbiFSGuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Jun 2022 02:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234053AbiFSGuh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Jun 2022 02:50:37 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07EFE0E2
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id g4so10585617wrh.11
        for <git@vger.kernel.org>; Sat, 18 Jun 2022 23:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yjOZrvuBpyzsHEWRQuFab+xPmXI5ogEOTch0eMzF0fk=;
        b=dCDq4kafsheay63onrlyzW3dFL3oHcniKdcq5YkdMNZrcublJrtJKIAbtkI8ISkzcL
         S68kchehYh7tMNMyLR83wuB9mP2F0lfTf7hfDfzFAiTRNtiVu1/c72zXSNWrak9Zg0Kp
         CmgVSptM/B5v4SY9chjFuXsQ7emCMPdFY4WX8CliLz7C3TBFG9BfT2NSY8QWjpTRqcBu
         fNR6K9qo7xgZSRDo7K305BQk8NY3t8sxNaDNjwIsuTZ2VhYdT2hzNsC7XmgfBeJYyl4k
         DKcXFwxXO8Ou8TAuVdgoiWiDIi0MugEWxsyEvgwwQ4eBnp/hK1eHQ3gf3hYzsCuF8LvP
         TlkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yjOZrvuBpyzsHEWRQuFab+xPmXI5ogEOTch0eMzF0fk=;
        b=MPfHbIoQv9YOCVx0JXw8im9KBlBES5P7cx08LYfvHA3c6vZwkWSANkuvoVSMGUWeFd
         b07q/lWoDGTVneXKdXEcUdst/puSAipkskd24EJfsBDOOFncknHArHVOCIxnJLrfYJ0E
         mHJcUQ2suG1370xhmqmCR+Y2pF2d4PN/xjMybUgUyiT1hPFEE+RB53ttqpHG2xMQe7/l
         oTc9WPM13xrR5bQUFV1Ncqsc4hVrPscQ7/AcUC0uyLsOnRvVNEzLHjWIqRh2uCCoftWa
         0hFP6zWcCc82lbWQ4Gs5GesFDtJ5G1rR/aR8YCfALXdVo1PG39r6eNDYRtIdLmipbogm
         VLpw==
X-Gm-Message-State: AJIora9J096N2cTr7/s9ARB3FaFZbSyrszIoUu62qV3Fs9W2t9ApAwxl
        Mx233N6btZaPESlTz3+H/XNYpbr77NXoHA==
X-Google-Smtp-Source: AGRyM1uAfHC8asy8yNtTKb+38SULqZGIp/fZtAhGB5CI54zwsQsu9fLJW3zk+zC73YmZ2zBOQ49vOw==
X-Received: by 2002:a05:6000:1862:b0:216:3c40:6708 with SMTP id d2-20020a056000186200b002163c406708mr16852454wri.101.1655621432117;
        Sat, 18 Jun 2022 23:50:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d4b0b000000b0020d07d90b71sm9200599wrq.66.2022.06.18.23.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jun 2022 23:50:31 -0700 (PDT)
Message-Id: <89e5e633241e45a0c4b18289ab2fafdaabc8191e.1655621424.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
References: <pull.1231.git.1652977582.gitgitgadget@gmail.com>
        <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 19 Jun 2022 06:50:21 +0000
Subject: [PATCH v2 3/6] merge: fix save_state() to work when there are
 racy-dirty files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When there are racy-dirty files, but no files are modified,
`git stash create` exits with unsuccessful status.  This causes merge
to fail.  Refresh the index first to avoid this problem.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 00de224a2da..8ce4336dd3f 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -313,8 +313,16 @@ static int save_state(struct object_id *stash)
 	int len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buffer = STRBUF_INIT;
+	struct lock_file lock_file = LOCK_INIT;
+	int fd;
 	int rc = -1;
 
+	fd = repo_hold_locked_index(the_repository, &lock_file, 0);
+	refresh_cache(REFRESH_QUIET);
+	if (0 <= fd)
+		repo_update_index_if_able(the_repository, &lock_file);
+	rollback_lock_file(&lock_file);
+
 	strvec_pushl(&cp.args, "stash", "create", NULL);
 	cp.out = -1;
 	cp.git_cmd = 1;
-- 
gitgitgadget

