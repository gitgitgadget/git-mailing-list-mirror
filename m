Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
	SPF_NONE shortcircuit=no autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC2231F454
	for <e@80x24.org>; Fri,  1 Nov 2019 14:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfKAOBh (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 10:01:37 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42653 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727746AbfKAOBg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 10:01:36 -0400
Received: by mail-pf1-f195.google.com with SMTP id 21so7134838pfj.9
        for <git@vger.kernel.org>; Fri, 01 Nov 2019 07:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZ/lpcSTKUqtPEpL7ypP627hMTR0tPDnWG7BfP5lnG8=;
        b=lITR8eeEXAunr+4nItGQG1vx1yY392MAECFAP9EUZNT963I1zGyvFd/ktQ8OqQ6MFJ
         KJoy74t5+JWoDo7GeJGRh5OAYJTCQ+2SD26gu/qda1ZpxJlZ7sBMUxdfvVTrKX8YiSD6
         dwCxPhT5e7qe1iXd0T5pBRx0cCQdTWYTAwcKx6QupxSkpD4e6bYRMzpivJSIiDOg2r6x
         Ep+DODsfBiXuY2aNCrc2HVQQOyodG/34wCgZYy/aC2ms3a4BK6dpKBF9dVADVeSR/cbQ
         NXtPpNkgPtw4jLUULDlwT2zyndMLaWkHvXkWFNFY2FRzYFwJXSaEdoqdRyba/tBxIfdZ
         ztXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZ/lpcSTKUqtPEpL7ypP627hMTR0tPDnWG7BfP5lnG8=;
        b=tks9cte2lHdo79EST52f+5nVxe8d7bMEuHqDxGduZzSSTr5MvqUxo8oFAyRvgZ3Bpa
         +sRDpjpleIFABYUR6W2Ogy8y+zwFHtJS3YmuZPDvpG6YfIbiuXso1f8L5CsrZ/KnR2GD
         JhmjkGpo8gNtOzn/Nx2U/b4zrI0qjGjAEk/+DR1sRsCYdrxAlioDPTvBMrN3hTaXFGlp
         KpF63zDGQO74DHdHBeQQakSyC9dilQn1hjSS75tk8YfHNnSZbr/8JilUS59lJUSZVV35
         n0WP1Z4i54Uu/M3CPDYBO94xe5DR4IL5vAPFFHkz6e1SDkvwaw+GqAE1SrZEXRPBhWqt
         MBLQ==
X-Gm-Message-State: APjAAAVTktRc8mj0hXshrC9UcRJ6pELlHPbIZynZNh3oqNGXL8Rr/f7S
        sKTDcawGo4e29b0quXJBTyoCLpAHZDE=
X-Google-Smtp-Source: APXvYqy77hAKXfLtubFH305Wk0COb39wiwWQ8nY4tm+V8sMQSDHfgC4Vq3WauEXiMY3Q2I6CrZvhHw==
X-Received: by 2002:a65:49c9:: with SMTP id t9mr14148151pgs.61.1572616895725;
        Fri, 01 Nov 2019 07:01:35 -0700 (PDT)
Received: from ar135.mshome.net ([103.37.200.214])
        by smtp.gmail.com with ESMTPSA id z4sm7806816pjt.20.2019.11.01.07.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 07:01:34 -0700 (PDT)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org, gitster@pobox.com,
        martin.agren@gmail.com, newren@gmail.com,
        phillip.wood123@gmail.com, t.gummerer@gmail.com
Subject: [PATCH v5 6/6] rebase: add --reset-author-date
Date:   Fri,  1 Nov 2019 19:30:03 +0530
Message-Id: <20191101140003.13960-7-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20191101140003.13960-1-rohit.ashiwal265@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit introduced --ignore-date flag to interactive
rebase, but the name is actually very vague in context of rebase -i
since there are two dates we can work with. Add an alias to convey
the precise purpose.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 Documentation/git-rebase.txt | 1 +
 builtin/rebase.c             | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 3580447f2f..cb4ab43998 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -413,6 +413,7 @@ See also INCOMPATIBLE OPTIONS below.
 	as the committer date. This implies --force-rebase.
 
 --ignore-date::
+--reset-author-date::
 	Instead of using the given author date, reset it to the
 	current time. This implies --force-rebase.
 +
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 7edae668f8..edefdd016b 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1455,6 +1455,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "committer-date-is-author-date",
 			 &options.committer_date_is_author_date,
 			 N_("make committer date match author date")),
+		OPT_BOOL(0, "reset-author-date", &options.ignore_date,
+			 "ignore author date and use current date"),
 		OPT_BOOL(0, "ignore-date", &options.ignore_date,
 			 "ignore author date and use current date"),
 		OPT_PASSTHRU_ARGV('C', NULL, &options.git_am_opts, N_("n"),
-- 
2.21.0

