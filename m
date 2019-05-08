Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 527FA1F45F
	for <e@80x24.org>; Wed,  8 May 2019 11:13:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfEHLNl (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 07:13:41 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33096 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbfEHLNl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 07:13:41 -0400
Received: by mail-pg1-f196.google.com with SMTP id h17so3970109pgv.0
        for <git@vger.kernel.org>; Wed, 08 May 2019 04:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tWMYnawcyghwN3MkBi00ecMRIE023rx9MrKjlvLSlPQ=;
        b=BJOV9u8s2aXH4/22BNNZLvEBR7IPJznc+1rJzO9GdRI8YpP1t/xvo9IEJMY+KwMk5a
         W9r9sDoH990PHe2wPAuB9o9nPeP8a6GmZ/9yGbJuKTZ7Sb1yp6YkNRdmOUfiPq8oBXAI
         wbUJ4U9WAieWOYk0HpNkFEAteR5WGKo5QkcwexHSLJHBaFvrwTl56/CbM4E0Mw/ZBdDm
         bJiUPXYeNbfk8sbwv6BkBrrYt8UcQ/sLn+/9oUuZEpJFVEN7Sd4JBfVkrrfbxa3aPdgn
         cT9vSCHl3A4IUPbIzALKDWFxszxjTjVavBkHyWaB6+FjIN+Smgp79cZMArtsdIS4UITT
         L8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tWMYnawcyghwN3MkBi00ecMRIE023rx9MrKjlvLSlPQ=;
        b=R5uM35vsIOvX7E9TrpRSqAGOpeHoD6wx91cmB/ZyjSbxw49ZNrVWeN4tLir7X0NYC6
         drTT/jEdWSGDJvTUrATtHVLaTHtA0HVYfpnYnErpdAhtEBIgKswZKPs8hBvqGkQwOzs/
         1u171xosblUi9JT+3l4NMmAHCsH8J+hIggTnWOUu5/ORVpYRqJyYM0pKzxo/l9GBa36Y
         YK2ISSUtpWpxEj1GflcbMU60AI2mDRIZYvAYyPgBjdz8Ye9TUVhOOH+bCMsJs5LmZDP3
         KJgVQkRyoN+A6UlrUCl0cPyUd2v4xTsS7G8LxvpbzWRqJN7fNauzFcoF0WYcT6716AII
         g7bg==
X-Gm-Message-State: APjAAAU8Pz4J7raATheWNjJ/0dJXPrd+CSG3Vgv5njbyiiT1gjoETqyI
        mXea6dLo6jsXWYQmX0OoCNEog3kK
X-Google-Smtp-Source: APXvYqyqUDq67za0rf6YYNf7MxcqRKjraZJo2A9euj8THuBf/nWpldMAARE0vmm/hIiQzfti73XqQQ==
X-Received: by 2002:aa7:8e0d:: with SMTP id c13mr48858766pfr.193.1557314020386;
        Wed, 08 May 2019 04:13:40 -0700 (PDT)
Received: from ash ([115.72.28.243])
        by smtp.gmail.com with ESMTPSA id l129sm8084431pfc.61.2019.05.08.04.13.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 04:13:39 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 08 May 2019 18:13:36 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 04/19] rev-parseopt: convert --all
Date:   Wed,  8 May 2019 18:12:34 +0700
Message-Id: <20190508111249.15262-5-pclouds@gmail.com>
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 revision.c | 41 ++++++++++++++++++++++++++++++-----------
 revision.h |  2 ++
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/revision.c b/revision.c
index 65d40c9255..9a346577f6 100644
--- a/revision.c
+++ b/revision.c
@@ -30,6 +30,10 @@
 #include "prio-queue.h"
 #include "hashmap.h"
 
+#define OPT_REV_NOARG(s, l, h, cb) \
+	OPT_CALLBACK_F(s, l, revs, NULL, h, \
+		       PARSE_OPT_NONEG | PARSE_OPT_NOARG, cb)
+
 volatile show_early_output_fn_t show_early_output;
 
 static const char *term_bad;
@@ -2359,6 +2363,26 @@ static int for_each_good_bisect_ref(struct ref_store *refs, each_ref_fn fn, void
 	return for_each_bisect_ref(refs, fn, cb_data, term_good);
 }
 
+static int rev_opt_all(const struct option *opt, const char *arg, int unset)
+{
+	struct rev_info		*revs  = opt->value;
+	int			 flags = *revs->pseudo_flags;
+	struct ref_store	*refs  = revs->pseudo_refs;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+	handle_refs(refs, revs, flags, refs_for_each_ref);
+	handle_refs(refs, revs, flags, refs_head_ref);
+	if (!revs->single_worktree) {
+		struct all_refs_cb cb;
+
+		init_all_refs_cb(&cb, revs, flags);
+		other_head_refs(handle_one_ref, &cb);
+	}
+	clear_ref_exclusion(&revs->ref_excludes);
+	return 0;
+}
+
 static void make_pseudo_options(struct rev_info *revs)
 {
 	/*
@@ -2372,6 +2396,9 @@ static void make_pseudo_options(struct rev_info *revs)
 	 * register it in the list at the top of handle_revision_opt.
 	 */
 	struct option options[] = {
+		OPT_REV_NOARG(0, "all",
+			      N_("include all refs in refs/ and HEAD"),
+			      rev_opt_all),
 		OPT_END()
 	};
 	ALLOC_ARRAY(revs->pseudo_options, ARRAY_SIZE(options));
@@ -2400,6 +2427,8 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	} else
 		refs = get_main_ref_store(revs->repo);
 
+	revs->pseudo_flags = flags;
+	revs->pseudo_refs = refs;
 	argc = parse_options(argc, argv, revs->prefix,
 			     revs->pseudo_options, NULL,
 			     PARSE_OPT_KEEP_DASHDASH |
@@ -2410,17 +2439,7 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	if (argc)
 		return argc;
 
-	if (!strcmp(arg, "--all")) {
-		handle_refs(refs, revs, *flags, refs_for_each_ref);
-		handle_refs(refs, revs, *flags, refs_head_ref);
-		if (!revs->single_worktree) {
-			struct all_refs_cb cb;
-
-			init_all_refs_cb(&cb, revs, *flags);
-			other_head_refs(handle_one_ref, &cb);
-		}
-		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (!strcmp(arg, "--branches")) {
+	if (!strcmp(arg, "--branches")) {
 		handle_refs(refs, revs, *flags, refs_for_each_branch_ref);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--bisect")) {
diff --git a/revision.h b/revision.h
index 0769c97dee..cec5215c04 100644
--- a/revision.h
+++ b/revision.h
@@ -281,6 +281,8 @@ struct rev_info {
 
 	struct repository *repo;
 	struct option *pseudo_options;
+	int *pseudo_flags;
+	struct ref_store *pseudo_refs;
 };
 
 int ref_excluded(struct string_list *, const char *path);
-- 
2.21.0.1141.gd54ac2cb17

