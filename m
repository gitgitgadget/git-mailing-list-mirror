Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33DDD20179
	for <e@80x24.org>; Sun, 26 Jun 2016 12:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbcFZMZX (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 08:25:23 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:36341 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205AbcFZMZR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 08:25:17 -0400
Received: by mail-pa0-f66.google.com with SMTP id av7so6919956pac.3
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 05:25:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FaZsdWHkSMTWRVljl9VsOQNnHresblJhXSzhdAB1nXE=;
        b=0ua/HPQZ3wK/jlPWqrO2OEAsY/e4TG0W95k5bdn9InVq+OAlUqa4CoaDhepP2VC9QW
         Z1YK4M8937MMilHC7hP60wyx1rpBwaspqlrPhzGE0HEG8nMQC+Pv7SyJPvqSHAdAaDwG
         t57+jam4N7NcUZBgEsKnmTPqEozbrqSj82TOFoCMrxdwHVsdcSl5ZOfcTBSnvwT/huKu
         AncgT6q6qVWwH5IQ4slEshHzpmuxCx6jEKsLT/gBvedzQKM+A5g7YUoV4DIlaMov6fXt
         K8ryBcGR0gtxFnvzMCptm1oIe18ukdYmJTZoT1jaehHPwyK1EjxVuJKNez5O/a3pUHtz
         +ZGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=FaZsdWHkSMTWRVljl9VsOQNnHresblJhXSzhdAB1nXE=;
        b=fXe4Q0ZkChKekSnPamj4BYjC9JHrUQrxrZ+nlIu4P2m1KcdAdJ73vRriiRqic/567o
         aVEptM6D2X5VI+llD1RGXLp9BQ90/I2Wo9VTfAsBVHke7rdJjVpG4DA5RgwAZH/SFmT+
         E/IMEIreRl1ut/jCipDkXOkua5d2LeAPLG9Arq0vwqOhnQT+Ky+175FsHyxY87r3MgZr
         yiiSVtjzv4BfQdKGyOfWfHhUof+KprgPjkZLKl8XrTY4mpUTv0cusm9LEDsXvKp/8G3V
         GpdI7mWQ7kpsMvZlXFQSGRWdeQMWUARxMUrkJxj4+bCafgNsZJRP6fJwPOj6tbrxzBtc
         6ynA==
X-Gm-Message-State: ALyK8tIZkMObJvpukMx5rVNqb7WsCOTod39038KOfZdgXgOsrxU8wDOJ5V2RJIzVdPINyw==
X-Received: by 10.66.255.7 with SMTP id am7mr24870681pad.75.1466943916465;
        Sun, 26 Jun 2016 05:25:16 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id e9sm4633670pfg.2.2016.06.26.05.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 05:25:16 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	sunshine@sunshineco.com
Subject: [PATCH v3 3/6] wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
Date:	Sun, 26 Jun 2016 17:53:53 +0530
Message-Id: <20160626122356.28999-4-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160626122356.28999-1-pranit.bauva@gmail.com>
References: <20160626122356.28999-1-pranit.bauva@gmail.com>
In-Reply-To: <20160607205454.22576-1-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
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

