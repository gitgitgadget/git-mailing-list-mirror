Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B43CE2047F
	for <e@80x24.org>; Sat, 29 Jul 2017 22:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752384AbdG2WYw (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 18:24:52 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:37690 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753172AbdG2WYv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jul 2017 18:24:51 -0400
Received: by mail-pg0-f68.google.com with SMTP id k190so11206774pgk.4
        for <git@vger.kernel.org>; Sat, 29 Jul 2017 15:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yNWbM+OGFMn+OzDqkzQE8PE/rNaVr3iHin5xYCipqAQ=;
        b=Vp8JB90/EyxYNJxhn6CqqYUmU7cC72AB13qaiYYl4prR8xfbvEBF93PkKo2O50OfUM
         wJ/j6MWdhp48m1IoCtybB47PBgoz2qwrJv+6ykgX7pBehiTkTgmIDEyMc7DFYHjMCgkg
         V+KB49LjY0yXc7+BDiQU5c0jSkw2jrO+LsOh/C9k67xmVQzA7g131taEBPN5dY0Lrmwv
         hCQVdH2MBvIjNijj2YKSbhsLi5a/D/gtGTG0fikHK3IOmm04jFqDAnsBVBF4NLvFVw6f
         7zuGMLz6hzC3vfouUZpdFEs5J802EKCKl+0C8SQoULNYnttXUu1PV7TqRnDv+FpkoWFO
         EU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yNWbM+OGFMn+OzDqkzQE8PE/rNaVr3iHin5xYCipqAQ=;
        b=ErBw9MEO9Ql76IA8epcbUPr8GI42AM9tCEUs5KnZ6RzSBEaoO6IzzR+Ib2zS2SdSoI
         wDyrD6Em4w+ZmIqfYkZv1i02GbcF/MzU2DbohGqucnNwokSz/q7iqIBpVuwugMOnJAnY
         +fvQ+uFuKqNo+wWyv9M0g8YFoEvTytv+oa+A41NaZQLFtWPIg94wxjyipJAqhIFZNbyL
         gHiHG4Ta7iN5rq4AXurbg/kEz9lVt6oe/bHNi7zeP9vAaMhBgn9UCcKbzPtKBZ8vUrST
         Lr2UzLnII1Uth3QrGWtuCs0JeWx1/ErxoG15EKCTaKkgKm1Rkkwr988o1Ob4bKlvhxHO
         HKVw==
X-Gm-Message-State: AIVw110HOecd5vT/fS+ywBX02mtoIHCC69CosXF0IrUDOCDh1M9L1V9k
        h4pZ+S1nJTfJj7zSl6I=
X-Received: by 10.84.229.71 with SMTP id d7mr12336040pln.274.1501367091021;
        Sat, 29 Jul 2017 15:24:51 -0700 (PDT)
Received: from localhost.localdomain ([47.11.7.4])
        by smtp.gmail.com with ESMTPSA id w125sm43476409pfb.117.2017.07.29.15.24.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Jul 2017 15:24:50 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com, bmwill@google.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH v2 07/13] diff: change scope of the function count_lines()
Date:   Sun, 30 Jul 2017 03:53:55 +0530
Message-Id: <20170729222401.12381-8-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170729222401.12381-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170729222401.12381-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the scope of function count_lines for allowing the function
to be reused in other parts of the code as well.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 diff.c | 2 +-
 diff.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 85e714f6c..03ed64f93 100644
--- a/diff.c
+++ b/diff.c
@@ -425,7 +425,7 @@ struct emit_callback {
 	struct strbuf *header;
 };
 
-static int count_lines(const char *data, int size)
+int count_lines(const char *data, int size)
 {
 	int count, ch, completely_empty = 1, nl_just_seen = 0;
 	count = 0;
diff --git a/diff.h b/diff.h
index 2d442e296..8522514e9 100644
--- a/diff.h
+++ b/diff.h
@@ -273,6 +273,7 @@ extern struct diff_filepair *diff_unmerge(struct diff_options *, const char *pat
 extern int parse_long_opt(const char *opt, const char **argv,
 			 const char **optarg);
 
+extern int count_lines(const char *data, int size);
 extern int git_diff_basic_config(const char *var, const char *value, void *cb);
 extern int git_diff_heuristic_config(const char *var, const char *value, void *cb);
 extern void init_diff_ui_defaults(void);
-- 
2.13.0

