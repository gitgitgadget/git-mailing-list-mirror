Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C0EC2BA17
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA10520737
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 20:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC5qZYGI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgDCUs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 16:48:28 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46829 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbgDCUs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 16:48:26 -0400
Received: by mail-wr1-f48.google.com with SMTP id j17so10027190wru.13
        for <git@vger.kernel.org>; Fri, 03 Apr 2020 13:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EMuCE8Wpkcm/9HDiuuXGeeA8/8PLGU8hxaMUO7tsTVc=;
        b=HC5qZYGIDD/n7HE1v7/khRNrxs2LKtDzozO9Iwj5HBqG5CSaE6n4X2OwduaJ2eV1nl
         GD+z6/QB9sErWD9o2uNzDN+artCqmttBtkUSBbYHPSMSMLHczeDyor32jjyNUiyKkz0m
         tT8S2zBqgeqsweWhFii7sPFKmCFon1QPxGFGnyGQR6fQ5BxNqEkS+DiKfOU32O482BAe
         1lhGZR08awXBHu+t0FsMaQw9so6mzjZRIWfFOTmVDw1Pr96kZOUoIsiwg+babclkVEkU
         0hir0qnUJ9P5KXmF7jIV88a9Nwh4taSMbjCkrO+TvDPJW/SNWVlhp1tAe8sqq/noMI24
         jexQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EMuCE8Wpkcm/9HDiuuXGeeA8/8PLGU8hxaMUO7tsTVc=;
        b=ay/gWpxIqFYL60wmiZy7O7yeSxx4AWPBcPvtEXUUbVlxI+qewsXX8F4J9EmZlFypT1
         wPjchnFKNJotic6Kh1SNGX8o6YjI+lMHjcRImr8OnSedt94WyISKFDslRHp7i5bPIYsC
         9Ki2yMuzAuCG2aN9PDcsXhphPDtmO8z6Fyt4qAVR5dCPFuRlLiqLlxfy7BgmxCvdcyzL
         gvWnKixuonEENqLTjoDB44BCYZYLylKqqtVzWUQZ4MDd68JU1FrqzsR+l0fwIhOKvBJA
         /DdYTCXBBIRbfEr1q7fVpYAQ1p06hLcr4xbw9//XRoRd2UdsZO1MZ6gQCcWO9asoDf+f
         sJkw==
X-Gm-Message-State: AGi0PuYcrpIBWYkGfezJs5gqKzeseNOJ+peMgI/1y5Mc1UF6UBs8mJ3N
        9gbwZhT7luS7n/hSXKq7h2mF+ilH
X-Google-Smtp-Source: APiQypIsAcP8AmXFUbVk8KtbKTJ9ucocz901PKVz06btJwLVIMQtIKmLFUsgO1RzwlyMS0zSR0kldw==
X-Received: by 2002:a5d:4611:: with SMTP id t17mr11449584wrq.16.1585946904156;
        Fri, 03 Apr 2020 13:48:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x18sm13467389wrr.2.2020.04.03.13.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 13:48:23 -0700 (PDT)
Message-Id: <2c3c9d28a903e23c37e44f9783299f3c001f574e.1585946894.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.597.git.1585946894.gitgitgadget@gmail.com>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 03 Apr 2020 20:48:10 +0000
Subject: [PATCH 11/15] job-runner: use config for loop interval
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@google.com, stolee@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git job-runner' process uses a sleep(X) call to pause its
operation between iterations of the job loop. This defaults to 30
minutes, but is now available to be done with longer or shorter
intervals according to the job.loopInterval config option. For
example, a user may want the job loop to run once every five
minutes while another wants the job loop to run once every six
hours.

This config value is checked immediately before the sleep(X) call,
which allows users to see the effect without restarting the
job-runner process. However, the process will be paused until the
previous sleep(X) call returns and the job loop is executed.

RFC QUESITON: Is this use of sleep(X) the best way to do this?
Is there a better way to delay the process for a time interval, or
until a specified time? This just seemed like the simplest option.
The job-runner is doing low-priority work on an unpredictable
schedule by design, so sleep(X) seemd appropriate.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/job.txt | 4 ++++
 builtin/job-runner.c         | 6 +++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/job.txt b/Documentation/config/job.txt
index 7c799d66221..772001e6744 100644
--- a/Documentation/config/job.txt
+++ b/Documentation/config/job.txt
@@ -1,3 +1,7 @@
+job.loopInterval::
+	The number of seconds to sleep between rounds of running
+	background jobs in `git job-runner`.
+
 job.<job-name>.interval::
 	The minimum number of seconds between runs of
 	`git run-job <job-name>` when running `git job-runner`.
diff --git a/builtin/job-runner.c b/builtin/job-runner.c
index aee55c106e8..7e37b122d99 100644
--- a/builtin/job-runner.c
+++ b/builtin/job-runner.c
@@ -261,7 +261,11 @@ static int run_job_loop_step(struct string_list *list)
 static unsigned int get_loop_interval(void)
 {
 	/* Default: 30 minutes */
-	return 30 * 60;
+	timestamp_t interval = 30 * 60;
+
+	try_get_timestamp(NULL, ".", "loopinterval", &interval);
+
+	return interval;
 }
 
 static int initialize_jobs(struct string_list *list)
-- 
gitgitgadget

