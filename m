Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289461F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:58:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390661AbeIUVro (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:44 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:45441 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390633AbeIUVro (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:44 -0400
Received: by mail-lf1-f46.google.com with SMTP id m80-v6so1354542lfi.12
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mzsSSCprKQVG3f8CvYYxL0ze3N6/lawGinHV5oKdDBM=;
        b=E9o9ZOkyQllJPDLKE53pVbPw09edr1egsYETkwFZ1u0vbgCbn8YfDs6YfIFofoBjFu
         SSyM/LSytB4d+bmS42+tbu9QWak4bUe+UzemylNHMnAPQTRON0Z04koyPN+S5R56vwzN
         hEa61MOWxumcl+vm/0PMBlgkTVklJ6aJH4C11CpWVJabJVe1FArjcUI8Ef7Nn0GqLNWo
         3Tr8toWNGY/PYqVErnZwJYdwJ9jEEPfeuOdDtvZj7qGyN4yn0MTTkbY3p/Z8kMR3qbau
         NzAJeDJfRKKtGpJ+kHpYilb90kgemZ8GoobtbBZJqBx9780JR5En3/vUXIaAngatKb0I
         BSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mzsSSCprKQVG3f8CvYYxL0ze3N6/lawGinHV5oKdDBM=;
        b=n37uG7c+JopFOeoFLgtLctjVEYKWPWUscgiA1SyWXvRDpSzJ29b1u3ZpD5tQagqbV5
         ieR6L8ZWnUR+8pMpYguLzijw1DyES1PoEmgoGpiZN1bZXZTpRFrE+l4bauZ4hbSZAg4i
         ad7EXinMTPEIoxuM+Sdxcfj2Nawha4fg8UJfts5wp4ITsItqRYYyyBCPY/g3HzWfmykc
         a8EEI50oWudJ/EuKhhc/cpSSJstKJJuJ/7iebu+RNpDGbl6O/weJLo7i+ZYPt8Ukq8s0
         OR0ZiWFfg8a0BIXUkcsnZ5HH6rDutXYNMUgL5M4cP/YcXuDC9k1q1jdRf6pV/zfjdVWv
         qkXQ==
X-Gm-Message-State: APzg51BCeViQXRKPCOFLTIvXWDB7+byFLyWSQdaP5q9RiF1S6FvTrMK5
        qTBA/0d+xNGxRcIilZ3OdiQ=
X-Google-Smtp-Source: ANB0VdbN+RUXv5EaK81WRalOLusq3ivWQJg/aQi4z4Gpyazn6ZAQG2tepRXTrZss9OpOgH9cnyO0PA==
X-Received: by 2002:a19:290c:: with SMTP id p12-v6mr29646554lfp.124.1537545492255;
        Fri, 21 Sep 2018 08:58:12 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.58.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:58:11 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 21/23] ws.c: remove implicit dependency on the_index
Date:   Fri, 21 Sep 2018 17:57:37 +0200
Message-Id: <20180921155739.14407-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.640.gcd3aa10a8a
In-Reply-To: <20180921155739.14407-1-pclouds@gmail.com>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c | 8 +++++---
 cache.h | 2 +-
 diff.c  | 6 +++---
 ws.c    | 5 ++---
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/apply.c b/apply.c
index 571b89c2e0..fdae1d423b 100644
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
index 5256b9eabc..c5b5e7ac41 100644
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
2.19.0.640.gcd3aa10a8a

