Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A2B72047F
	for <e@80x24.org>; Mon,  7 Aug 2017 21:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752156AbdHGVTi (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 17:19:38 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33543 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752094AbdHGVTh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 17:19:37 -0400
Received: by mail-pf0-f195.google.com with SMTP id c65so1468206pfl.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yNWbM+OGFMn+OzDqkzQE8PE/rNaVr3iHin5xYCipqAQ=;
        b=CcH+ZR8T1S4DQU+U5igkX94Vy10zq2VYWWUVJyJfm/r6zUOYrEBvILxqRytCg/MyuW
         UxM8LgUCsikPlTgm8RSSH+T326BqEXiBJJNXV/wIbN36EQbGyO+Agu1JMCwebVA9L+70
         m03ODUXttaNxaeYCR7QNPia51reEEsbjcJBp6gpDypMU88oniekl/+GGvb54sye9orsi
         25AL3DTa0uxxoOAtLJH7VPFZnql9jyZYJv6qOkPxFfrFgWNnmWLgHjv8SNVn+4aromtP
         K8v7gne9WdePhdkSITYAblx64dH7VXqfz17Xwnk39hcIeMJww2I+FfNOuyfjnu2w9X8O
         wioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yNWbM+OGFMn+OzDqkzQE8PE/rNaVr3iHin5xYCipqAQ=;
        b=fluZtw5Y4ei6Z3TOWJW5PXe77HQFwWi+zl+iFeyY215CloCG2edKRRNTYZUIOEbKt7
         GU4oCl4Tip/GzbHq5hCDhHA370SAnF8vGi82i8ETYxZvZE86xiW7nkufbjk1gzGalW7m
         N6Bl7BlELFjg3mWFiGk9QkhjsVhhLI1MY9/3akCjra3TELxfMEIj1+aciNeVdueFuHR4
         9wGoUn792hqkNbGrtZCNQG8CJNWwXmzzR4cwVYt9SpU0GK+6Brrxqi3REFM5eCXHwxFp
         0ZMPPhZypAlSXdtY4J1ZYhh9lA2Z5cP2BZO0+DkzLZIs+cadlt/HJlAibajFXlllheT4
         bCPA==
X-Gm-Message-State: AHYfb5gdX2okAppsRN+MVpmBSpCXRHD/nB6MEdJymVTu2ynYgdL76jJ9
        XPcPAuFHKvDTW8WQcjw=
X-Received: by 10.84.229.130 with SMTP id c2mr2050802plk.215.1502140776673;
        Mon, 07 Aug 2017 14:19:36 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6016:3285:fd77:5453:49e2:f3b5])
        by smtp.gmail.com with ESMTPSA id z127sm15141084pfb.64.2017.08.07.14.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 14:19:36 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 07/13] diff: change scope of the function count_lines()
Date:   Tue,  8 Aug 2017 02:48:54 +0530
Message-Id: <20170807211900.15001-8-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170807211900.15001-1-pc44800@gmail.com>
References: <20170807211900.15001-1-pc44800@gmail.com>
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

