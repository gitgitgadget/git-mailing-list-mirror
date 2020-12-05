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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C688C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D0A322DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbgLEBrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbgLEBrr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:47:47 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9671C08E860
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:46:35 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z29so9214097ybi.23
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xksZ8TN+Bx5zxuwy/jMdxbToJEO3CXMa1+UlyOml024=;
        b=BBu0jpX+Oxo6lcgFxpiasDApHEuNsnoq4r4VFN8Xl3vxcJZuNiMdfVfN4N0GEBtjoY
         3iIMKU54LjRf2N94HbYadA/eTnKwCfJiD53lkYt4ROPfCVP0CclYEcqVKErVlGtXEuos
         cXqMb77INliFu43biEREGiT5iMO2Tb0p7EKm+SgFX5qQBrNChk6eIEgW2mXMobiji/Ae
         sQDbSau6WWND0U1kdBLpCsY18GORgGDsR7eOdjP7TNHW8YeF9qii22+HZYhvPKPz+zrr
         3m8+PMhDdS7K7cxNKTesuwMMVuf83GI0T+0h7e6DWaQ4kpWsc1zTKgcZbBp0Hq5msecl
         iTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xksZ8TN+Bx5zxuwy/jMdxbToJEO3CXMa1+UlyOml024=;
        b=pr+xpNeWR1ktZf9FUYM3fd3zeOUpDycqkhyVuP1I62wNG8HVp1/qbOMYI9XCfuu0rZ
         Gu+I0T3uMZUUw0ULYDEZhngNDgTME8Glom6QkF7qrxHmHvkRRNr6sjPQja6mju7fZhqS
         8RBr+T3rH/tBC67FSSAK9TNg/nl5/3PiXzMn6YrkLA6VtKKuM5FWQ6S5eN3VypFnUOqg
         sVq7I8GSJHN9LI2cRkGAtOnDLRnS5HomxUPN4Le4R1cJrMhQMFiKvLBgpiciLPC59Zuo
         YY8CLRHJQGq4ZhECnyV+bXEtjxRjpmvhOkzL4HMR5g4sdExwqme/TEjtyoJoehNmMHY/
         hB9Q==
X-Gm-Message-State: AOAM532tdTyO4bJ9nzVVIu/iOycrZR+7SZPjGjBoumqnTsWoXinsHwcR
        O6dlLAKJGR/a1Yy29KaPCCAfHrUjZlNW8nqRsg+uGOkEIPovpA89jsGa9skqn8WsqbqtI86DOK+
        aWY6e4dxnOiwcWXWtlXy0asoyoV4lqQmGpTpU6VKQaKZUWLayOXejhjwzFFZoHmNs6JWapZlVzQ
        ==
X-Google-Smtp-Source: ABdhPJzE2axp34nWc+SsmBAkpIWEAbz/toBmOe2ZCe8J8IykrHeMhhBdWmPQgWfZdvTi6ftbQN/rzA0UuoJom3Ee+do=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:f512:: with SMTP id
 a18mr10163204ybe.159.1607132794984; Fri, 04 Dec 2020 17:46:34 -0800 (PST)
Date:   Fri,  4 Dec 2020 17:46:01 -0800
In-Reply-To: <20201205014607.1464119-1-emilyshaffer@google.com>
Message-Id: <20201205014607.1464119-12-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201205014607.1464119-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.226.g0268cb6820
Subject: [PATCH 11/17] run-command: allow stdin for run_processes_parallel
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
 run-command.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index ea4d0fb4b1..80c8c97bc1 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1683,6 +1683,9 @@ static int pp_start_one(struct parallel_processes *pp)
 	if (i == pp->max_processes)
 		BUG("bookkeeping is hard");
 
+	/* disallow by default, but allow users to set up stdin if they wish */
+	pp->children[i].process.no_stdin = 1;
+
 	code = pp->get_next_task(&pp->children[i].process,
 				 &pp->children[i].err,
 				 pp->data,
@@ -1694,7 +1697,6 @@ static int pp_start_one(struct parallel_processes *pp)
 	}
 	pp->children[i].process.err = -1;
 	pp->children[i].process.stdout_to_stderr = 1;
-	pp->children[i].process.no_stdin = 1;
 
 	if (start_command(&pp->children[i].process)) {
 		code = pp->start_failure(&pp->children[i].err,
-- 
2.28.0.rc0.142.g3c755180ce-goog

