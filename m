Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BD89520387
	for <e@80x24.org>; Tue, 18 Jul 2017 20:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752219AbdGRUtx (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jul 2017 16:49:53 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34798 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752193AbdGRUtw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jul 2017 16:49:52 -0400
Received: by mail-pg0-f68.google.com with SMTP id v190so4208332pgv.1
        for <git@vger.kernel.org>; Tue, 18 Jul 2017 13:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yNWbM+OGFMn+OzDqkzQE8PE/rNaVr3iHin5xYCipqAQ=;
        b=bLqNw5L6hnpMT441yFEf7OBLCrGORuQMA687zI6lR3XPgbApag19Pn2a5vR0k/px91
         jDodqFGlE+9JlB2o7YGfs7YRbPD/rHpltaNBtpOQKLxgQY/v3cHYVlOLCCa1EpJBTGCm
         /tpMFzsVe1AYh2t6PMk1YM7Jj4FrqO7ZQzzqE4zMpduYtNZ3Me9+PsjZOQV09GjTkT0j
         +swcGH4xJ/hcm5DVNlirj54KeYUg5mGckNvF+zs8O7yXfVHAgMmGta2Vx1xMSabrjX3W
         6pwQ6GJY3rLHoKHta85ujV74kGDmj5kE14Qb+unCXXCZgt+1tKNVtdzeK9QB8H4QvW8p
         QfFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yNWbM+OGFMn+OzDqkzQE8PE/rNaVr3iHin5xYCipqAQ=;
        b=VUNq6UbLGNWnsyCfswwbgnzevc5DLF0CCvIxxtNruB2M/OJGbRuzae6q/vxUpHCDCK
         xawgAMjkZpJPl/dugbumrmjRJhQ5fLs5hto3Qxumqbu3mYrf8JQvlYuTBk5jud9EfBt0
         kfv/ag4uOqU1rL8XddV5G19yl6Y2/Pe4Xqh9aHyayYY9WGGrM0DXhzzdKltWiZygpk0B
         aygN7RRPJh9Nx4ZMnBcGtNyjYmOFMv26cp2OGnUMmrdPYGfFNcMjkgD6Z9zCBCam24aS
         HVCNpWoDmX1vLWr6X5yiRWPSkzLJlsE4o7KtneCNszLEZQuD6gbnKcjnMVLxqgX1QecG
         BrTg==
X-Gm-Message-State: AIVw111x9CqITOw+kH8t618C55RxkAEhRU3H/RjMy2LeKvlruCb2z175
        VKwhJTdKPXcHoBNUpmQ=
X-Received: by 10.98.223.151 with SMTP id d23mr2763178pfl.108.1500410992257;
        Tue, 18 Jul 2017 13:49:52 -0700 (PDT)
Received: from localhost.localdomain ([47.11.2.197])
        by smtp.gmail.com with ESMTPSA id e5sm402742pfd.41.2017.07.18.13.49.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Jul 2017 13:49:51 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 7/8] diff: change scope of the function count_lines()
Date:   Wed, 19 Jul 2017 02:19:03 +0530
Message-Id: <20170718204904.3768-8-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170718204904.3768-1-pc44800@gmail.com>
References: <20170718204904.3768-1-pc44800@gmail.com>
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

