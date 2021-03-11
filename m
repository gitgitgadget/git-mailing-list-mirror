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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03171C433E0
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D546164FD6
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhCKCLm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhCKCLW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:22 -0500
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2E2C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:22 -0800 (PST)
Received: by mail-qt1-x849.google.com with SMTP id e6so14447210qte.0
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6D12hEJKPM8vudlev8zqDXAnnbiOMjwhGlztJODSEmY=;
        b=cn9LDCHT9SlCRc34tzvqRa3Z6ZrD3Fstwqm4dv6RJ+pBerrCVQqpPv9NB8W6BQCQ1s
         PDch0fBOBpJXe9L5sDaIX9qjt69l/4J/6IyJDWVGehW2g2oef6ibcvNf5xP0rMLSCiO+
         cjfXFj4aTSCHzVR/7X8BUhvVy1Vt7uz+emFE5+Agdhpb2j0pZWF1hZ7xstBDJLs7AlFA
         I/b7pP/+NkRhPpIRWWNCgy+zHeX7wGOG2QtkPETFm1JWnOJC37W/n1skcGnf8qD0eN16
         U1FNF37bkh9pCshsYtwqRADYy7uZQ/SqQEUdYHnT3SW67O5X/pUzLiRWeoIbSsPVUO7w
         nGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6D12hEJKPM8vudlev8zqDXAnnbiOMjwhGlztJODSEmY=;
        b=Lp7dt7G7kcD829KmAkpSEN5bPVHJqChXD85ss0VYLxv9k2Z8tMKl/dKrm5mWNUSIYx
         A5kFfyq0h+Yp6YLyTwsl4ZdriqJE0xGbXjFruQAlutOO9Y1WB2/KUyixwMujk+W4Okxe
         FYnTdyYl6rfQHi05p7+rvPuwxfbt/GvXygQ4446UOdJiqOAiPzP6brMtIVZoOS9PGYxi
         JuaTsUUEqJeRQnPoK5Xx4KeUBUQ3SaVXawBYYCWpORaw4V8ssgMvgOlnhN3uEuXkr087
         nidwE1V0ODZh1lHw1jsH87/VN5e6H6yv131oIXczVElgDfExlw99fGo1JWAH8ydmgDMI
         54cA==
X-Gm-Message-State: AOAM531CVj8ZOn7Pim1y3YOKFEBGN+ZnoMgMP24uXc7zpseMFHGK5Qhq
        WFC5tRSdQZcGPaqr732PLUJc5shan/u/2CLlBqEkwqdtCzVPeurjKTzgEMswLlZ6/HwvfJJgAUT
        6gSK+VoUUHIU+sgstHvH7yS42difntT99gdM5PlminLJ7N0UjYNs2S5QcDBKEK4/hcFvabL7SMw
        ==
X-Google-Smtp-Source: ABdhPJwXcf5Y7ZtXYWRwk8sYNAD6tDBqmdU2nIo4y9YH7HoN1LPaIdEtuYZZMPKNo05FDVw87D1iskpxtLtwafVbRgs=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a0c:e1c7:: with SMTP id
 v7mr5764706qvl.30.1615428681322; Wed, 10 Mar 2021 18:11:21 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:17 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-18-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 17/37] hooks: allow callers to capture output
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some server-side hooks will require capturing output to send over
sideband instead of printing directly to stderr. Expose that capability.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    You can see this in practice in the conversions for some of the push hooks,
    like 'receive-pack'.

 hook.c | 3 ++-
 hook.h | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index e16b082cbd..2322720ffe 100644
--- a/hook.c
+++ b/hook.c
@@ -256,6 +256,7 @@ void run_hooks_opt_init_sync(struct run_hooks_opt *o)
 	o->dir = NULL;
 	o->feed_pipe = NULL;
 	o->feed_pipe_ctx = NULL;
+	o->consume_sideband = NULL;
 }
 
 void run_hooks_opt_init_async(struct run_hooks_opt *o)
@@ -434,7 +435,7 @@ int run_hooks(const char *hookname, struct run_hooks_opt *options)
 				   pick_next_hook,
 				   notify_start_failure,
 				   options->feed_pipe,
-				   NULL,
+				   options->consume_sideband,
 				   notify_hook_finished,
 				   &cb_data,
 				   "hook",
diff --git a/hook.h b/hook.h
index ecf0228a46..4ff9999b04 100644
--- a/hook.h
+++ b/hook.h
@@ -78,6 +78,14 @@ struct run_hooks_opt
 	feed_pipe_fn feed_pipe;
 	void *feed_pipe_ctx;
 
+	/*
+	 * Populate this to capture output and prevent it from being printed to
+	 * stderr. This will be passed directly through to
+	 * run_command:run_parallel_processes(). See t/helper/test-run-command.c
+	 * for an example.
+	 */
+	consume_sideband_fn consume_sideband;
+
 	/* Number of threads to parallelize across */
 	int jobs;
 
-- 
2.31.0.rc2.261.g7f71774620-goog

