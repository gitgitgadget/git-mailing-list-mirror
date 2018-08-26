Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 513CE1F436
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbeHZNpq (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:46 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:38900 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeHZNpp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:45 -0400
Received: by mail-lf1-f42.google.com with SMTP id i7-v6so9730161lfh.5
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5JlTgByiXs0/gGSjeuwAoXfn8ijZwHECjCgWNjBkllg=;
        b=Wj/S9cxZ7+ipsa/2zKUUyXG2GvCy5VJE6P9+yOD2R+RYU6/AZD8jas73SppJBdP8v4
         t1hyiZEOVfwUwAr9LegvxhN4jwd6LkSJ5IT4hOWdCNxO4QJJtF13k3swa43LDZontUAT
         FPewyW33dp319UIan92KzjfBpJk8GTZJ78ePSXVP/Os2wxv7PwaPCbThPTJgWRemA4F5
         x5OWS7ftmkWhfQqxLw4hCbiRrhpU1BITOzVXLrTuwrb7grVhkKPfoKc8Dlh7nmRPfUJw
         xjX2bnVHMeyISq/6KRWdlwiZ/RFRJ9zOpLFFfvhOSGbBfNbG61lBwLrYRDWuVl8iQ91e
         N+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5JlTgByiXs0/gGSjeuwAoXfn8ijZwHECjCgWNjBkllg=;
        b=A4EFqD4ILXTvhD93eewztYTl/DEfxHXMkOk6m2+hj6PcXn5DBaDQSg2rBD7dmfOJHx
         surekbLTuNI6XXDu3wOXQ3QnX5B3jvA38zkBpdGhf7r0fYkPyuZLW4eToRO/Ue/W0TDT
         XKHel9En28qcGeYMI115saggKgSJSj+O/B2xDe72D/JkA/5DLqip0B8tehwg3vFLnqN3
         h1yAo74B9vSBhbJGHD5lEOcxBFtyEUsJE5oTugpGAjrQTg8Z/a4CFdxuqspWrGduID08
         8Dly+FCsGjx1IlcFFhIv5Gw7xXFHIsUUURLMrsIrV9EA8VUmPajCYtdS2pfSxPloxE3Y
         ziAA==
X-Gm-Message-State: APzg51DNqHLtoOG6teTDXHgJQYON7GzH/fQrIj9NZv7GhFlawmjLzBvM
        1FVs7o/74FCpOKJevKuRy6m7FYUH
X-Google-Smtp-Source: ANB0VdaloGw33C0GyVPH+yvigEq1gwlq/vYWFPIquwGZMhAKmlIXAmazTwUskm9ggF+hFhDKJdNROA==
X-Received: by 2002:a19:5911:: with SMTP id n17-v6mr5967573lfb.102.1535277817353;
        Sun, 26 Aug 2018 03:03:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:36 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 19/21] ws.c: remove implicit dependency on the_index
Date:   Sun, 26 Aug 2018 12:03:12 +0200
Message-Id: <20180826100314.5137-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
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
index 0964611997..e697402396 100644
--- a/cache.h
+++ b/cache.h
@@ -1684,7 +1684,7 @@ void shift_tree_by(const struct object_id *, const struct object_id *, struct ob
 /* All WS_* -- when extended, adapt diff.c emit_symbol */
 #define WS_RULE_MASK           07777
 extern unsigned whitespace_rule_cfg;
-extern unsigned whitespace_rule(const char *);
+extern unsigned whitespace_rule(struct index_state *, const char *);
 extern unsigned parse_whitespace_rule(const char *);
 extern unsigned ws_check(const char *line, int len, unsigned ws_rule);
 extern void ws_check_emit(const char *line, int len, unsigned ws_rule, FILE *stream, const char *set, const char *reset, const char *ws);
diff --git a/diff.c b/diff.c
index 5a5f91480b..b28de7a246 100644
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

