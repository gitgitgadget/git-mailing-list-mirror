Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF92820196
	for <e@80x24.org>; Tue, 12 Jul 2016 22:41:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981AbcGLWjk (ORCPT <rfc822;e@80x24.org>);
	Tue, 12 Jul 2016 18:39:40 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:32860 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbcGLWjd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2016 18:39:33 -0400
Received: by mail-pa0-f67.google.com with SMTP id q2so1822838pap.0
        for <git@vger.kernel.org>; Tue, 12 Jul 2016 15:39:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FaZsdWHkSMTWRVljl9VsOQNnHresblJhXSzhdAB1nXE=;
        b=lYGaU+6KSyISOJpUFzy9WBEiGXc1tiH2g5FnVQ6ANRtlwAUlrGKrh0pnfpU0uYjLvB
         gAy8hLvPtbYU5+Om9O6jv6Tr4S4so1wTzNeH+5fGmqEe2/a+KuGJdNMwv7gHv1a251Ga
         jLUsEINFhMu7G8uUWaXS2wbArMeH10sas5r8QcA0PfgdBJfD7JTmBWy1OxCZmqXvJjaW
         6octl04giUt5/7OVHv6nA7Mrh5hAL/e8wyh+QMGVw4KY+GYLDAePywHlccCyqSyq8y1G
         8k2NRVTdCCkDUdw8WonoIZ5wn9Mq09Qln6NsXRh8oFMWOihkIADAslU40m8w9wRK8YMd
         wL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaZsdWHkSMTWRVljl9VsOQNnHresblJhXSzhdAB1nXE=;
        b=aVMdvjQnuUFaCmecvPEnKCZpoPrPb7ZM7N3EAjEaUuX3gSmhewodNEKk6JCl26m/Ri
         XvMo9Fy5hgIGILlRFri6H5ubp5NIyZNhtN2VQxCAZz2O2O64T2T2T/ili1wBPJSIpSKM
         pYiexdaQjfCVspJlZ7pNGinvR3jAppIX0ytVl7eZCFCLQqXFlffhw64sXaD4L651Wrr2
         CxMJybGzeBMXFV9D6Bn6MHTS3fYhOthAPJAOnwWXN9IxiM5MPELiRwLe0A9QJUXuIlUU
         MrWEv3wvW6xZJu0If7qsZQVIXN7jX/3mp5E726BO9zCEOupMb2HSiM3iIRkGYH70VKHi
         Ndng==
X-Gm-Message-State: ALyK8tKhu44c3WpzIez7cx4owo+qByfO9z544ykOuy2aDx+RXzos+DS3mTa9TEFb9a/B2A==
X-Received: by 10.66.76.226 with SMTP id n2mr8155368paw.17.1468363158326;
        Tue, 12 Jul 2016 15:39:18 -0700 (PDT)
Received: from localhost.localdomain ([103.57.70.227])
        by smtp.gmail.com with ESMTPSA id g26sm6723796pfj.82.2016.07.12.15.39.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 12 Jul 2016 15:39:17 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	gitster@pobox.com
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	git@vger.kernel.org
Subject: [PATCH 6/9] wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
Date:	Wed, 13 Jul 2016 04:05:35 +0530
Message-Id: <20160712223538.28508-7-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160712223538.28508-1-pranit.bauva@gmail.com>
References: <20160712223538.28508-1-pranit.bauva@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

is_empty_file() can help to refactor a lot of code. This will be very
helpful in porting "git bisect" to C.

Suggested-by: Torsten Bögershausen <tboegi@web.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/am.c | 20 ++------------------
 cache.h      |  3 +++
 wrapper.c    | 13 +++++++++++++
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 3dfe70b..6ee158f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -30,22 +30,6 @@
 #include "mailinfo.h"
 
 /**
- * Returns 1 if the file is empty or does not exist, 0 otherwise.
- */
-static int is_empty_file(const char *filename)
-{
-	struct stat st;
-
-	if (stat(filename, &st) < 0) {
-		if (errno == ENOENT)
-			return 1;
-		die_errno(_("could not stat %s"), filename);
-	}
-
-	return !st.st_size;
-}
-
-/**
  * Returns the length of the first line of msg.
  */
 static int linelen(const char *msg)
@@ -1323,7 +1307,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 		goto finish;
 	}
 
-	if (is_empty_file(am_path(state, "patch"))) {
+	if (is_empty_or_missing_file(am_path(state, "patch"))) {
 		printf_ln(_("Patch is empty. Was it split wrong?"));
 		die_user_resolve(state);
 	}
@@ -1911,7 +1895,7 @@ next:
 		resume = 0;
 	}
 
-	if (!is_empty_file(am_path(state, "rewritten"))) {
+	if (!is_empty_or_missing_file(am_path(state, "rewritten"))) {
 		assert(state->rebasing);
 		copy_notes_for_rebase(state);
 		run_post_rewrite_hook(state);
diff --git a/cache.h b/cache.h
index 6049f86..91e2f81 100644
--- a/cache.h
+++ b/cache.h
@@ -1870,4 +1870,7 @@ void sleep_millisec(int millisec);
  */
 void safe_create_dir(const char *dir, int share);
 
+/* Return 1 if the file is empty or does not exists, 0 otherwise. */
+extern int is_empty_or_missing_file(const char *filename);
+
 #endif /* CACHE_H */
diff --git a/wrapper.c b/wrapper.c
index 5dc4e15..e70e4d1 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -696,3 +696,16 @@ void sleep_millisec(int millisec)
 {
 	poll(NULL, 0, millisec);
 }
+
+int is_empty_or_missing_file(const char *filename)
+{
+	struct stat st;
+
+	if (stat(filename, &st) < 0) {
+		if (errno == ENOENT)
+			return 1;
+		die_errno(_("could not stat %s"), filename);
+	}
+
+	return !st.st_size;
+}
-- 
2.9.0

