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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E52C432C3
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A79EE64FD6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbhCKCLk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhCKCLO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:14 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5470C061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a63so23853250yba.2
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=y5KEi9LP/xaggFvLKu3f7FcevOOqeTYz4zzf4x58B74=;
        b=fAZtIswBXYBjuHTMq1Q4f1XJD9ej3rWAaYtdaNRMi55/D6ueu8LT+VoYSXkPeC/bux
         0yVDy2E3EY+xEJpK0Ak8k7oIXvR8z0ntdtHFM/Wj6AZrKwEaALqibcigZPdxYIzkvrmq
         nwmy+a2lD4H8bEhMeVYrGOJV2J8or2ozg1MEVWtB0L30aQpQ3+FFLMYLihpXwX5y+hRa
         CZjLgZ05zPAa4Q1Ldtq/wMKow2cifK3OvBOBeSd6U1tr2syf5yQsv9OfRwyUAzoCE8yD
         zxXoUXSd7SByp5CpJMoFVqxftzCFybVq2Q20TSLjY/oJ31zIp7iFLKWPiJY4QGV9D9mr
         bY9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=y5KEi9LP/xaggFvLKu3f7FcevOOqeTYz4zzf4x58B74=;
        b=N2aThHiLaOKWKXDqfQw6XLVjJ9cL+rxl1GlyV2O4XGM3R6HAVMkD6l4HiosU98DhuY
         Zy+WumAdqIcLPp4sYe+9D7+wVmwnB/g5HbZ1xn8tuixsHsx+Wx0sIPYugsUL3ujUODXN
         5zdIOaKuzriGMK84H9d+wjBI8Nnb1+lg4HMPCiQaZOiR7nk/2hvbuwULRKpToMmWqZIo
         oXncp8PKaRdClNGnjfBC3ryWLkB5FQhzY4VDWl3S6P7SHKYF0kLNh1rlg8yH04K9Wo1v
         95eqhFDPvD7dFzjdh7+rgWA7EfOzlG8YJpIscMxj++Aa04qDMH7F8lkGCmEQU64/1cPB
         FfkQ==
X-Gm-Message-State: AOAM530nuyHh5kgA2rWbPm3NP2IA1TSsLg85qEQOAXDRLa4H+lUpTY1O
        Vp8FidncsJ1F73tYoj1RNlMzSUFN4vrQ89SKfHYPdtN5mbEAhF1hif7Tkfm/gM3nLCUIGx/0lTf
        o7wyehAVBssUjfPaFU9ljot8+ARdMGHFsaoStzAhnxMx0VSmPMHZr9pMrUe6C0ruJqGmiD5N33Q
        ==
X-Google-Smtp-Source: ABdhPJxlUQjuKafhmmaCVawA6CYgeIwtGcMaZyxfTr/Qs3DCRNQa+ZPcL/Azb8A3UPzXB3k40UZS+gCr4WPrS8kil34=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a25:c106:: with SMTP id
 r6mr7559235ybf.136.1615428674036; Wed, 10 Mar 2021 18:11:14 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:13 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-14-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 13/37] hook: allow specifying working directory for hooks
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
index fe8860860b..67ad3aa747 100644
--- a/hook.c
+++ b/hook.c
@@ -251,6 +251,7 @@ void run_hooks_opt_init_sync(struct run_hooks_opt *o)
 	o->path_to_stdin = NULL;
 	o->run_hookdir = configured_hookdir_opt();
 	o->jobs = 1;
+	o->dir = NULL;
 }
 
 void run_hooks_opt_init_async(struct run_hooks_opt *o)
@@ -306,6 +307,7 @@ static int pick_next_hook(struct child_process *cp,
 	cp->env = hook_cb->options->env.v;
 	cp->stdout_to_stderr = 1;
 	cp->trace2_hook_name = hook->command.buf;
+	cp->dir = hook_cb->options->dir;
 
 	/*
 	 * Commands from the config could be oneliners, but we know
diff --git a/hook.h b/hook.h
index 2593f932c0..fcd8e99e39 100644
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
2.31.0.rc2.261.g7f71774620-goog

