Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 404661F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbeICWb5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:57 -0400
Received: from mail-lf1-f52.google.com ([209.85.167.52]:46547 "EHLO
        mail-lf1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727422AbeICWb5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:57 -0400
Received: by mail-lf1-f52.google.com with SMTP id e23-v6so996875lfc.13
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5P04yIovQjtfIfOba4IK/TxyupjLV0h48/8IThC6ABE=;
        b=a7vzI5Ayn6qfg2mmMUW3GkkSJDfWbof6ImELNL6ETSwhrzG5wZAmTBjO+a9c/Kgc7r
         7rzbnoj+iawrz9E169w25WD5bpKPBzcdNsDrw2qL+LVLes1xyT54TNwiOtgLA6kE/dcp
         pyt6nC5tsB4Yb7+zxZ4RhyvoUUueqNBr0he7RIglvrbXX7vu27UmrLLVnhNPWfgHtXse
         ABEt/XzHfDr7eg24mrDSdR3NAS1uU9JV6grponzEhU3o2tIOlSgskpsqTPx5djL2uJL8
         LOYDC44/rmOZdNarwLJx2o7kVkAYbsHyUOiBsDfLVRi0Bmm/Pisy+iC2wS7f3zjF0DMz
         CYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5P04yIovQjtfIfOba4IK/TxyupjLV0h48/8IThC6ABE=;
        b=L4jhxyM0jfCX7RXah5rFd75TSU7bv4VkEnhD+WcGc3cSa0j3Mr0ApQwAGHEUTcz4kl
         +ssIL01SnMxwloEdD1irLv1EMEqJsTIZEOQo6UdCpG/MD8IMfBFOmd6ogvwk+0Aqo5U2
         Wh5P8BkvFNC8LhTOml7lIjYN6ui1E9hIqOPjVP89Ia2rdMvvoVHDrZZQ6vWyUJQNIK7/
         QBAMFdgHm9WKweTamYOeWBQXuLjgBEFU0Q7Mz+yr5tG2SsChhIyo/cjGzPPTIgBnKSsh
         Kpf+q1QxskbVw5lrK4cNo1dwbf6wrDQ6ERV0m8YXTiGfxCV8c2d2gz9dz3O6nuOp6UAq
         9s3w==
X-Gm-Message-State: APzg51C+5KXXSvvTCK43WRdVM2FEmF/YvVzBCtv+t8K+c0AhfzOSgiDG
        MuRnGorcU3VLHEcdq8w7AkU=
X-Google-Smtp-Source: ANB0VdaK8+wkGWKlJSmJ+Y8W7jmo1udToiQj9vGiEJYTF2oCIy9klfLTMKFo06blv6CZNyyj79qP9w==
X-Received: by 2002:a19:9710:: with SMTP id z16-v6mr19484482lfd.17.1535998235468;
        Mon, 03 Sep 2018 11:10:35 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:34 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 21/24] ws.c: remove implicit dependency on the_index
Date:   Mon,  3 Sep 2018 20:09:29 +0200
Message-Id: <20180903180932.32260-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 apply.c | 8 +++++---
 cache.h | 2 +-
 diff.c  | 6 +++---
 ws.c    | 5 ++---
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/apply.c b/apply.c
index d80b3547c2..fc52993548 100644
--- a/apply.c
+++ b/apply.c
@@ -2131,10 +2131,12 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 
 	if (!use_patch(state, patch))
 		patch->ws_rule = 0;
+	else if (patch->new_name)
+		patch->ws_rule = whitespace_rule(state->repo->index,
+						 patch->new_name);
 	else
-		patch->ws_rule = whitespace_rule(patch->new_name
-						 ? patch->new_name
-						 : patch->old_name);
+		patch->ws_rule = whitespace_rule(state->repo->index,
+						 patch->old_name);
 
 	patchsize = parse_single_patch(state,
 				       buffer + offset + hdrsize,
diff --git a/cache.h b/cache.h
index 094652a503..eb0f7d5470 100644
--- a/cache.h
+++ b/cache.h
@@ -1694,7 +1694,7 @@ void shift_tree_by(const struct object_id *, const struct object_id *, struct ob
 /* All WS_* -- when extended, adapt diff.c emit_symbol */
 #define WS_RULE_MASK           07777
 extern unsigned whitespace_rule_cfg;
-extern unsigned whitespace_rule(const char *);
+extern unsigned whitespace_rule(struct index_state *, const char *);
 extern unsigned parse_whitespace_rule(const char *);
 extern unsigned ws_check(const char *line, int len, unsigned ws_rule);
 extern void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws);
diff --git a/diff.c b/diff.c
index 88ebe06c2c..bb51833d8b 100644
--- a/diff.c
+++ b/diff.c
@@ -1705,7 +1705,7 @@ static void emit_rewrite_diff(const char *name_a,
 
 	memset(&ecbdata, 0, sizeof(ecbdata));
 	ecbdata.color_diff = want_color(o->use_color);
-	ecbdata.ws_rule = whitespace_rule(name_b);
+	ecbdata.ws_rule = whitespace_rule(o->repo->index, name_b);
 	ecbdata.opt = o;
 	if (ecbdata.ws_rule & WS_BLANK_AT_EOF) {
 		mmfile_t mf1, mf2;
@@ -3480,7 +3480,7 @@ static void builtin_diff(const char *name_a,
 			lbl[0] = NULL;
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = want_color(o->use_color);
-		ecbdata.ws_rule = whitespace_rule(name_b);
+		ecbdata.ws_rule = whitespace_rule(o->repo->index, name_b);
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.opt = o;
@@ -3640,7 +3640,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	data.filename = name_b ? name_b : name_a;
 	data.lineno = 0;
 	data.o = o;
-	data.ws_rule = whitespace_rule(attr_path);
+	data.ws_rule = whitespace_rule(o->repo->index, attr_path);
 	data.conflict_marker_size = ll_merge_marker_size(o->repo->index, attr_path);
 
 	if (fill_mmfile(o->repo, &mf1, one) < 0 ||
diff --git a/ws.c b/ws.c
index 5b67b426e7..55349b4c5d 100644
--- a/ws.c
+++ b/ws.c
@@ -3,7 +3,6 @@
  *
  * Copyright (c) 2007 Junio C Hamano
  */
-
 #include "cache.h"
 #include "attr.h"
 
@@ -71,14 +70,14 @@ unsigned parse_whitespace_rule(const char *string)
 	return rule;
 }
 
-unsigned whitespace_rule(const char *pathname)
+unsigned whitespace_rule(struct index_state *istate, const char *pathname)
 {
 	static struct attr_check *attr_whitespace_rule;
 
 	if (!attr_whitespace_rule)
 		attr_whitespace_rule = attr_check_initl("whitespace", NULL);
 
-	if (!git_check_attr(&the_index, pathname, attr_whitespace_rule)) {
+	if (!git_check_attr(istate, pathname, attr_whitespace_rule)) {
 		const char *value;
 
 		value = attr_whitespace_rule->items[0].value;
-- 
2.19.0.rc0.337.ge906d732e7

