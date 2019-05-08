Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36A51F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbfEHLNh (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:13:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39969 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLNg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:13:36 -0400
Received: by mail-pf1-f196.google.com with SMTP id u17so10331426pfn.7
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s/u+NfQtbX6ekNTSEF21UGawUBtM5yEWW6NhUAob68Q=;
        b=VfDO2wqftDTCHpANZLS9SFuuwY/CC+FnWdOncSmd057cHHovP3uFLib22JPI4kc4yP
         vxXbEobFNQSQZxNBvUP7+yG7pD8+n/Pf+9OYrfjsl21UdG1/pKed3avJIARBkcLOryWV
         BOai0MaE06BaDjRrA4lzDKYjUC0emoyAiERGQRjHxGL2dgASRK5lr6oIAlOg1WC9/kbB
         QxFfTz377SP7HSlzt6Ig7HZ4jfQCNkGxmvdRf5We1bjE3jOkoLPuNbkm+YlQjB02gIDj
         x69A+8Fwv2HHwdAOJFGKAsh5qmr9V5DTyPApKtsUCK5PxhKOsPHtc68AdL+Ws7yyVq1N
         gddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s/u+NfQtbX6ekNTSEF21UGawUBtM5yEWW6NhUAob68Q=;
        b=hT1MuWM64S2kWooZ+ZKWFUVVmd+UMRG1uVqC6r46zprX+mXvNPuywmwY/OutXyUIv9
         LhPEjROmDojf0EZLvX/mIs4nQlBySXR6qgKioazhZlbw+PIAYPZZtfgEuMk6QrMEyaEw
         qVy9Y+GOqGJ/q6DuhD7fQHtcObaiuMMA0MomayEvoeUGiJU4SiodVkR+UbhQ+sMQGY9W
         KzDSl36U2ZrHc0JTVOjDV8utsj1gY7thsKpw4LWH5mBtacddyGYqyGKLCD1fyEH/gZnw
         qx+WJh5ASGcB+1/X9XFed1MYXG3zaJTacW41orNyUCGNwtMZIi85SjyxQVKVJziohwIP
         C8jQ==
X-Gm-Message-State: APjAAAUf0ARja8Lu69Hld3dOPbH9uuWoy8ZC2ppMpbiC4WEDpxwI/7Ze
        wkBVOou1TEaSZwcFNY0bAyxbKpLJ
X-Google-Smtp-Source: APXvYqywrPawI0oy6FvHpUvvr/wafjGhDcCiPbHGldiY5E66SeZzZ7fWjLmRyhIwGxZcPkIQzC+YXw==
X-Received: by 2002:a65:5647:: with SMTP id m7mr36128407pgs.348.1557314016006;
        Wed, 08 May 2019 04:13:36 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id q17sm41554915pfi.185.2019.05.08.04.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:13:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:13:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 03/19] revision.c: prepare to convert handle_revision_pseudo_opt()
Date:   Wed,  8 May 2019 18:12:33 +0700
Message-Id: <20190508111249.15262-4-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.1141.gd54ac2cb17
In-Reply-To: <20190508111249.15262-1-pclouds@gmail.com>
References: <20190508111249.15262-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch is essentially no-op. It allows to parse_options() to handle
some options. But the new option list remains empty. The option will be
moved one by one from the old manual parsing code to this list.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 44 ++++++++++++++++++++++++++++++++++----------
 revision.h |  2 ++
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/revision.c b/revision.c
index d4aaf0ef25..65d40c9255 100644
--- a/revision.c
+++ b/revision.c
@@ -26,6 +26,7 @@
 #include "argv-array.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
+#include "parse-options.h"
 #include "prio-queue.h"
 #include "hashmap.h"
 
@@ -1598,6 +1599,8 @@ static int add_parents_only(struct rev_info *revs, const char *arg_, int flags,
 	return 1;
 }
 
+static void make_pseudo_options(struct rev_info *revs);
+
 void repo_init_revisions(struct repository *r,
 			 struct rev_info *revs,
 			 const char *prefix)
@@ -1638,6 +1641,7 @@ void repo_init_revisions(struct repository *r,
 	}
 
 	revs->notes_opt.use_default_notes = -1;
+	make_pseudo_options(revs);
 }
 
 static void add_pending_commit_list(struct rev_info *revs,
@@ -2355,6 +2359,25 @@ static int for_each_good_bisect_ref(struct ref_store *refs, each_ref_fn fn, void
 	return for_each_bisect_ref(refs, fn, cb_data, term_good);
 }
 
+static void make_pseudo_options(struct rev_info *revs)
+{
+	/*
+	 * NOTE!
+	 *
+	 * Commands like "git shortlog" will not accept the options below
+	 * unless parse_revision_opt queues them (as opposed to erroring
+	 * out).
+	 *
+	 * When implementing your new pseudo-option, remember to
+	 * register it in the list at the top of handle_revision_opt.
+	 */
+	struct option options[] = {
+		OPT_END()
+	};
+	ALLOC_ARRAY(revs->pseudo_options, ARRAY_SIZE(options));
+	memcpy(revs->pseudo_options, options, sizeof(options));
+}
+
 static int handle_revision_pseudo_opt(const char *submodule,
 				struct rev_info *revs,
 				int argc, const char **argv, int *flags)
@@ -2377,16 +2400,16 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	} else
 		refs = get_main_ref_store(revs->repo);
 
-	/*
-	 * NOTE!
-	 *
-	 * Commands like "git shortlog" will not accept the options below
-	 * unless parse_revision_opt queues them (as opposed to erroring
-	 * out).
-	 *
-	 * When implementing your new pseudo-option, remember to
-	 * register it in the list at the top of handle_revision_opt.
-	 */
+	argc = parse_options(argc, argv, revs->prefix,
+			     revs->pseudo_options, NULL,
+			     PARSE_OPT_KEEP_DASHDASH |
+			     PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_NO_INTERNAL_HELP |
+			     PARSE_OPT_ONE_SHOT |
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc)
+		return argc;
+
 	if (!strcmp(arg, "--all")) {
 		handle_refs(refs, revs, *flags, refs_for_each_ref);
 		handle_refs(refs, revs, *flags, refs_head_ref);
@@ -2685,6 +2708,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->expand_tabs_in_log < 0)
 		revs->expand_tabs_in_log = revs->expand_tabs_in_log_default;
 
+	FREE_AND_NULL(revs->pseudo_options);
 	return left;
 }
 
diff --git a/revision.h b/revision.h
index 71e724c59c..0769c97dee 100644
--- a/revision.h
+++ b/revision.h
@@ -39,6 +39,7 @@
 #define DECORATE_FULL_REFS	2
 
 struct log_info;
+struct option;
 struct repository;
 struct rev_info;
 struct string_list;
@@ -279,6 +280,7 @@ struct rev_info {
 	struct topo_walk_info *topo_walk_info;
 
 	struct repository *repo;
+	struct option *pseudo_options;
 };
 
 int ref_excluded(struct string_list *, const char *path);
-- 
2.21.0.1141.gd54ac2cb17

