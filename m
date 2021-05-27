Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0F1C47088
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0062613CD
	for <git@archiver.kernel.org>; Thu, 27 May 2021 00:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbhE0ALU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 May 2021 20:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbhE0AK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 May 2021 20:10:59 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 256B2C0613CE
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:25 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id g21-20020ac870d50000b0290230013e97e6so1654931qtp.21
        for <git@vger.kernel.org>; Wed, 26 May 2021 17:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=EiorRrSyDgR1pu3YWn64sSiUsHH2SGNVEqe3tVzGYLE=;
        b=UPOSvGbnj4XZFuEOOsREN/ruVB4ss7oImM6PfrXYKFS4Yjuloi8vT2VaLPg+5g4PCS
         OODV9oi7K+RXj7W65nCoi0dDy5sKJYa25+tW50a7c4ecPkBzQeF0/j82FQa7nxTpGMBm
         BPoTJc1LLK195EE8RV/IuzPHvoIaefhqd7zlVP+FelioCHkHn04B+u3GN60AUqVqf/TH
         Bvg0gjQlsNltTlSi/H9j1EI7uyI1p7DryGFgPunBMCJrPO9RC6bvtGhT6U+zd1esZ+pq
         tIDIy/+UwfWC73htNIFVdSp4pVkLnluwUDFDm9xLAOEbze0BJYsUXWkSWpws3F2WQv7Z
         nK4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=EiorRrSyDgR1pu3YWn64sSiUsHH2SGNVEqe3tVzGYLE=;
        b=ARTG1nVenYEAbnxW1Uq0VNNN/1ZvBswXa3SuB2ZuEMVxVUHXHdw/+z0P0iScbmr37y
         RCo1RGwc733/1U9VNi2g3WdTW8EZWpiISMLC9ai/pfI0cVQmXq5QiWuSbBLGrHsbzQ7o
         +y8+tarDtrxGK6E00VDntQqqRVrIsCQc80NI9WUKDuXO5W/f0EjyoaDdwHciebnxShtx
         IEVsODRCYR8fZj+MgaZgQyYs4ctQuhvN7Zvcl+ggBA85ItgCIAjKoMJOJemvDqwLvWS/
         wQ4meT6q2IEfLW7uZ+6Q2+6ySBJzBJrRaRc8aaubcpjars/Ep6HdPtSeRbZPyRDUfuQ1
         pONw==
X-Gm-Message-State: AOAM530NhtaA4UJm0ChUC20nUw1mBAbA+2y1Nwdn/LLsFZBLwbsDhMlS
        xPSpHgr9XodXXzZubnOeUFrRHfudrwKXNXc+k1rdJ6XyAFoHNhF99au3NMFnaI3jye+LclrF/pm
        Ji8uDYVr6Z603CKz9KVZR8HZSQRnKttGWcvz4WHUoEwRWW0YCXmr/qj/G6PTHAkqj1U5ITDdQug
        ==
X-Google-Smtp-Source: ABdhPJy6q6csvpE3ZOqt+lDxsBk03OPm48nQuG9QPRK60znOwS47njw1F/b/s8vSAF0oACFapDjTMAFWDcvvfHw4cqM=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:c1a4:4d87:8b5a:d12c])
 (user=emilyshaffer job=sendgmr) by 2002:a05:6214:766:: with SMTP id
 f6mr537139qvz.17.1622074164244; Wed, 26 May 2021 17:09:24 -0700 (PDT)
Date:   Wed, 26 May 2021 17:08:31 -0700
In-Reply-To: <20210527000856.695702-1-emilyshaffer@google.com>
Message-Id: <20210527000856.695702-13-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210527000856.695702-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v9 12/37] hook: allow specifying working directory for hooks
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hooks like "post-checkout" require that hooks have a different working
directory than the initial process. Pipe that directly through to struct
child_process.

Because we can just run 'git -C <some-dir> hook run ...' it shouldn't be
necessary to pipe this option through the frontend. In fact, this
reduces the possibility of users running hooks which affect some part of
the filesystem outside of the repo in question.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    Needed later for "post-checkout" conversion.

 hook.c | 2 ++
 hook.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/hook.c b/hook.c
index 784529fe2b..920563607d 100644
--- a/hook.c
+++ b/hook.c
@@ -256,6 +256,7 @@ void run_hooks_opt_init_sync(struct run_hooks_opt *o)
 	o->path_to_stdin = NULL;
 	o->run_hookdir = configured_hookdir_opt();
 	o->jobs = 1;
+	o->dir = NULL;
 }
 
 void run_hooks_opt_init_async(struct run_hooks_opt *o)
@@ -311,6 +312,7 @@ static int pick_next_hook(struct child_process *cp,
 	cp->env = hook_cb->options->env.v;
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook_cb->hookname;
+	cp->dir = hook_cb->options->dir;
 
 	/*
 	 * Commands from the config could be oneliners, but we know
diff --git a/hook.h b/hook.h
index cdb1ac5510..218b9e1721 100644
--- a/hook.h
+++ b/hook.h
@@ -61,6 +61,9 @@ struct run_hooks_opt
 
 	/* Number of threads to parallelize across */
 	int jobs;
+
+	/* Path to initial working directory for subprocess */
+	const char *dir;
 };
 
 /*
-- 
2.31.1.818.g46aad6cb9e-goog

