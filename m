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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B95C43381
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8426864FBF
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 02:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCKCLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 21:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbhCKCLL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 21:11:11 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23ADAC061574
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:11 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a63so23852711yba.2
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 18:11:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=9OCy3vXtF54gXMJlKk7YyB6MxtyztYa4LcpqDc08UtY=;
        b=eoIRxh9ApeN80U23D9LW+YmOZTCXQ5rR4J9Mbk+oMr+JGEaqsl9vMXTxGk27rHmphB
         /9eDp5jlwhwLfL2vLEkyQlddi3uz8RDAvSvqo8ii/lRmWPdgms8SC3NWy5MUjEJWcPGR
         W8qNyQhBm6+3J0PZ8EBhzdAUMVlvh1gyIbd+e8Cv+IqBfHr8jAFgThWGlgtcWcq6YHUg
         4YMlFag+xtOHJraPQdbDOUg+srqfbXsJNn24Pcu9sRZC2aAJwes4SZPAxXcqtLowPSNE
         nFZ94+hmfbWoanBvSsCE+HgZS16fM1WccTcfABS9E4/CROTt8yV5fC2ltMG8UKQAeIZy
         l9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=9OCy3vXtF54gXMJlKk7YyB6MxtyztYa4LcpqDc08UtY=;
        b=ea392ojSJG2Mc83V2bMTcJrpc4V28l3WKskPoyQ3kPomsqbqJt4dmj74VkE69udaxh
         OCRs8kVUXCkV/re6guzThadeTzJIjEoqbCDtLlAa0L4LDmFL58Ys8qHhM38vD5pDe6fq
         rm2SGrJ7mGeA0MEsY6Ksyjp6ajHgwCi94Ti/ev111xrgJU7koXH4uD73+r6V2YcaxF+P
         +xcRRcajzLbeXQdxbCEhM9xi2aK22zlhvt/+YmIEszOmO4ro74bnUiWnr23UGvOYGgqB
         8gQgmL+0RTepI9+FZvNAR+kK5weVcb3o3k1YRC0vXx3PJtLDTq5iwen1WZTb6S17sXT4
         67Tg==
X-Gm-Message-State: AOAM531XILWERTUZUKGOhDTVuVE8th0fHsfTzTqW3XstRfh+V4Tzk0VW
        /HEs4Wf/9DB1IXjm/Vi5rxO1ZNBl5tFe1hbYS0QlA4izAxSpRI/KO5snLw2S3FtO0sfdQRQUGbM
        yD03hIlpiaKiIBKiYCPUQBDWw7iK3XiHPyfFmRCCitEBfP8q+ZAwV/4iZoyEkkjZTDaMlVBQcHg
        ==
X-Google-Smtp-Source: ABdhPJwWTrMHi9ZizFqUknXUi6ZML29SpUVt7fTxiRlRE1PG3r5MXOebhiXLGBX3+xbAqjRafDygCm90A1wgT4T45no=
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:3521:9495:983c:f6d5])
 (user=emilyshaffer job=sendgmr) by 2002:a25:cfc5:: with SMTP id
 f188mr8369771ybg.485.1615428670361; Wed, 10 Mar 2021 18:11:10 -0800 (PST)
Date:   Wed, 10 Mar 2021 18:10:11 -0800
In-Reply-To: <20210311021037.3001235-1-emilyshaffer@google.com>
Message-Id: <20210311021037.3001235-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20210311021037.3001235-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v8 11/37] run-command: allow stdin for run_processes_parallel
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While it makes sense not to inherit stdin from the parent process to
avoid deadlocking, it's not necessary to completely ban stdin to
children. An informed user should be able to configure stdin safely. By
setting `some_child.process.no_stdin=1` before calling `get_next_task()`
we provide a reasonable default behavior but enable users to set up
stdin streaming for themselves during the callback.

`some_child.process.stdout_to_stderr`, however, remains unmodifiable by
`get_next_task()` - the rest of the run_processes_parallel() API depends
on child output in stderr.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
 run-command.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 4e34623e2e..e6d7541b84 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1693,6 +1693,14 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (i == pp->max_processes)
 		BUG("bookkeeping is hard");
 
+	/*
+	 * By default, do not inherit stdin from the parent process - otherwise,
+	 * all children would share stdin! Users may overwrite this to provide
+	 * something to the child's stdin by having their 'get_next_task'
+	 * callback assign 0 to .no_stdin and an appropriate integer to .in.
+	 */
+	pp->children[i].process.no_stdin = 1;
+
 	code = pp->get_next_task(&pp->children[i].process,
 				 &pp->children[i].err,
 				 pp->data,
@@ -1704,7 +1712,6 @@ static int pp_start_one(struct parallel_processes *pp)
 	}
 	pp->children[i].process.err = -1;
 	pp->children[i].process.stdout_to_stderr = 1;
-	pp->children[i].process.no_stdin = 1;
 
 	if (start_command(&pp->children[i].process)) {
 		code = pp->start_failure(&pp->children[i].err,
-- 
2.31.0.rc2.261.g7f71774620-goog

