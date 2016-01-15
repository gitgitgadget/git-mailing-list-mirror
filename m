From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 02/11] update-index: use enum for untracked cache options
Date: Fri, 15 Jan 2016 07:59:43 +0100
Message-ID: <1452841192-620-3-git-send-email-chriscool@tuxfamily.org>
References: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 15 08:00:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJyND-0004sS-Kk
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 08:00:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754957AbcAOHAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 02:00:33 -0500
Received: from mail-wm0-f47.google.com ([74.125.82.47]:32833 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753932AbcAOHA3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 02:00:29 -0500
Received: by mail-wm0-f47.google.com with SMTP id f206so11019359wmf.0
        for <git@vger.kernel.org>; Thu, 14 Jan 2016 23:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZXZYN6c/xUFw2GrM0c9iUC+9rtFnVndf+pFAEVF/9L8=;
        b=qMH8R+bULmmG6I/mdviVw8gtcv20b2VF6kbyXMeQWd4hnV88pojPK/OjXgCQk2mHOt
         6X4atibNekKYEy5ww0fT3LxwTyIwLyk7wNOthQaAPyAXGe7mT7JnOzXkEI0h6wMiSMDL
         zN+AFyiX8fT9Dp56jMUoc/6IoNcCIzULRX0qfvCrD7jGpwTe3rt8Ok/ZoVtysEDTrdqK
         gB/skpGenU64tPI6JY8XAkOLYrp1b++LbSRtUfV1waBmS/SGDvuyqp18ujJ1Ew6xKxYJ
         EwchumGucb2f7aP3ZP1nYDJiRR+DL8BgxHoybQL2pP7htoUevcqvEOKp2oErhxUMl2Qr
         oGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZXZYN6c/xUFw2GrM0c9iUC+9rtFnVndf+pFAEVF/9L8=;
        b=XmMmpjOJntA8PP9RQcSgFo6FHBfRWwlim3TkZkX6d0yQjb4mKR8aKmHe1lF28w8+c8
         +Z6pLkDl/cQKON9TbPjsyiOlSMmmNqb24RmgWU062v13NPupVcuwbJzmqFvJLkBaNdZp
         c2RmF+r+hGidgHoVPMzxDe+AuBFa8b1Ew9LCjEDcuNkNc5O++1lyWni3utEmOuIKco4m
         7pwa5qHn21GTEijHY/i5796fPKPvyUP8bQ9jqrqcyFog073IniBYEYKbVYbEx8iBhoFz
         +5+GilJa5IXkbjHRE7h5BAk+K+XiJOnn6CRYi+sNeZ5tb6awMa7lGQ/nSFgYKzZDtTDN
         ooBw==
X-Gm-Message-State: AG10YOTU7JgUSjVaKsLb0IV+63kDUwHF0VF4QwLSom7/kR7Quodjj6Qoo1iHtCHyoLn5jg==
X-Received: by 10.28.218.78 with SMTP id r75mr1574939wmg.7.1452841227710;
        Thu, 14 Jan 2016 23:00:27 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id f205sm1169733wme.4.2016.01.14.23.00.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Jan 2016 23:00:26 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.36.g20612a7
In-Reply-To: <1452841192-620-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284142>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Helped-by: Duy Nguyen <pclouds@gmail.com>
---
 builtin/update-index.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index a6fff87..1e546a3 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -35,6 +35,14 @@ static int mark_skip_worktree_only;
 #define UNMARK_FLAG 2
 static struct strbuf mtime_dir = STRBUF_INIT;
 
+/* Untracked cache mode */
+enum uc_mode {
+	UC_UNSPECIFIED = -1,
+	UC_DISABLE = 0,
+	UC_ENABLE,
+	UC_FORCE
+};
+
 __attribute__((format (printf, 1, 2)))
 static void report(const char *fmt, ...)
 {
@@ -902,7 +910,7 @@ static int reupdate_callback(struct parse_opt_ctx_t *ctx,
 int cmd_update_index(int argc, const char **argv, const char *prefix)
 {
 	int newfd, entries, has_errors = 0, line_termination = '\n';
-	int untracked_cache = -1;
+	enum uc_mode untracked_cache = UC_UNSPECIFIED;
 	int read_from_stdin = 0;
 	int prefix_length = prefix ? strlen(prefix) : 0;
 	int preferred_index_format = 0;
@@ -997,7 +1005,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "untracked-cache", &untracked_cache,
 			N_("enable/disable untracked cache")),
 		OPT_SET_INT(0, "force-untracked-cache", &untracked_cache,
-			    N_("enable untracked cache without testing the filesystem"), 2),
+			    N_("enable untracked cache without testing the filesystem"), UC_FORCE),
 		OPT_END()
 	};
 
@@ -1104,10 +1112,10 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		the_index.split_index = NULL;
 		the_index.cache_changed |= SOMETHING_CHANGED;
 	}
-	if (untracked_cache > 0) {
+	if (untracked_cache > UC_DISABLE) {
 		struct untracked_cache *uc;
 
-		if (untracked_cache < 2) {
+		if (untracked_cache < UC_FORCE) {
 			setup_work_tree();
 			if (!test_if_untracked_cache_is_supported())
 				return 1;
@@ -1122,7 +1130,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		}
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
-	} else if (!untracked_cache && the_index.untracked) {
+	} else if (untracked_cache == UC_DISABLE && the_index.untracked) {
 		free_untracked_cache(the_index.untracked);
 		the_index.untracked = NULL;
 		the_index.cache_changed |= UNTRACKED_CHANGED;
-- 
2.7.0.36.g20612a7
