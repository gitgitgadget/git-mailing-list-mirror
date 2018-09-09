Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 219761F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:54:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbeIINny (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:54 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:41717 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726738AbeIINnx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:53 -0400
Received: by mail-lf1-f41.google.com with SMTP id l26-v6so15129832lfc.8
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HHjfl7MkPE9MzOHsnC5rgkZhSeA1bMcoXsxvh1yoQZc=;
        b=QHmVP59k3mq+e69+Hm24efjqcsf45x7Wes5aIQ8exqb+BcIyIILSzm3zMk5JdF3CLY
         gAggOk0G31dlxx6+n1xtzQLihDHp8FjAGtzv9UAs+tLdd7sSXWi+VkzdC682A6DUmAA9
         8DQjzPvNKpFeUyF2DuxIMx/GjKilcuRsksBrEzvSfcJ0pRAMaVPQwArgEf9dD0NHI6xi
         DOJpeXwFuMdGJQTqiWGerXDfyHN5PEY+3/9aNSDY7TiBveARMQa9XulkiDAOR2sMFa1l
         uAA2ymoHoGF2cM87qnBHa9GHkC+olY61FEFtWC3pZGvlrVRQGfHjGhM3fr6aQNMygI5E
         Im4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HHjfl7MkPE9MzOHsnC5rgkZhSeA1bMcoXsxvh1yoQZc=;
        b=GS1b/rtexrUlOisPFOSGnw8BfeuKtqttMIy2AiGUhhgxwkrDqPRr/A0MrnHNHOh6La
         +Dzs9He9Hn6/TaNmInabRS35lAr/kvB39hiKY/nvArs9Eh7O6cvzeApEehJ7nc/lNsd8
         mo5FnlM8iWrjowIQXH+hsW7+ItUg0+JZu/pXwzK072xE5/AmlymfpZZf58ffYHombrWt
         k9jTrri0J9fnEvrpHYcO/JUck9WerhxFGuGturSFN0vXewZJ9q6dVSxuYCgKC218H3Di
         qXBE1tE6DaoJNjLJovpAatkQdnQi5MEK9E3j+Bu91coPpIaW7T8+L5JU2kV71yfAdPSh
         PZuQ==
X-Gm-Message-State: APzg51BJlGhhzm0hZyJVn7vZO2bfQS138eKNcg1p3C6cBDi0ZVBtyJ6t
        UI+9vp/RvpFC7TMysGEzyQU=
X-Google-Smtp-Source: ANB0Vdb3IKhoVfGB18RgbgUhFXgqWXR1hGgDaV8cNV6bMst4EUA1Rn9U0q7XGO28kJK7aPErJpOcSg==
X-Received: by 2002:a19:a915:: with SMTP id s21-v6mr9884559lfe.92.1536483294951;
        Sun, 09 Sep 2018 01:54:54 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:54 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 21/23] ws.c: remove implicit dependency on the_index
Date:   Sun,  9 Sep 2018 10:54:16 +0200
Message-Id: <20180909085418.31531-22-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
References: <20180903180932.32260-1-pclouds@gmail.com>
 <20180909085418.31531-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.19.0.rc0.337.ge906d732e7

