Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 688E52089A
	for <e@80x24.org>; Mon, 24 Jul 2017 20:35:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754429AbdGXUfp (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:35:45 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35882 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752582AbdGXUfn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:35:43 -0400
Received: by mail-pf0-f193.google.com with SMTP id 1so3211258pfi.3
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 13:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yNWbM+OGFMn+OzDqkzQE8PE/rNaVr3iHin5xYCipqAQ=;
        b=lwIINb2WgTCTGN7KV6RRC40uk6sId5NK8Dnaq4lB88RRjyVtJbdrCqWRHA2QEHoayy
         4fP6EV1b06Je4atc0nB5SGVr/5jasL0WJKGLyTjFckcUXVupGBESji7BG0xiruePYp/K
         w22HqDi4BF3CaifZJjHHq1ENdGyI0UpTvbsF8PtTkfchDjVUSv9FaLHqwozbqL0bgUzo
         Ie0MBg3eUqjEXBm2mPyCi6DFvLDnZRAtw8HFxvojPnYxOzWSIrjAgibvcBAeW1+of+fu
         nwC3MTC90dl02eaZUNhho51e6QCpe4jL5pzCtnLsgsg82zGvmtcd/BRHZIMBvoEOpSxX
         knxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yNWbM+OGFMn+OzDqkzQE8PE/rNaVr3iHin5xYCipqAQ=;
        b=Ydo+nDgsEsxXHVUqKeVjUvfNqQwGEdISwcX0TySMj2kiMrJ21Nz6j512HIRvlgsQO5
         S11ZPL1LdJRpHopwYqfxz7cFIEbXUF1GHaCQpWkh+klVPdXnfU4xVbt2X14V95+iyJCr
         ApgtKlBKkn+fHZ2JQmyPSXWawf1M6C+ikPtZrcL/0mGAnlTW3aOiwjjh9v/6U9uImRd/
         qdNHUmoYN7a8Kgz0LFqYIaLEeAiUKVx/aznVISk2Aa55aUWP0HddZ1b93eYV7Z4FRbRS
         659YE3HdT+zo9c5JM7vftkTAL1PRJ1bFm//sVl8EpHIZXMww1+E196U6aAXgZE9s5CST
         V5sg==
X-Gm-Message-State: AIVw111G1PXDC/vUYWcY8m/+5LZk3JtFZBa2IyXxMu1gdwMs/VZUA184
        cWfHbBXvVhjV6l3vulM=
X-Received: by 10.84.209.165 with SMTP id y34mr18739891plh.396.1500928542694;
        Mon, 24 Jul 2017 13:35:42 -0700 (PDT)
Received: from localhost.localdomain ([47.11.10.170])
        by smtp.gmail.com with ESMTPSA id d19sm24313984pfe.24.2017.07.24.13.35.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 13:35:42 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 07/13] diff: change scope of the function count_lines()
Date:   Tue, 25 Jul 2017 02:04:48 +0530
Message-Id: <20170724203454.13947-8-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170724203454.13947-1-pc44800@gmail.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
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

