Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FEB62070C
	for <e@80x24.org>; Wed,  6 Jul 2016 20:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756AbcGFU0v (ORCPT <rfc822;e@80x24.org>);
	Wed, 6 Jul 2016 16:26:51 -0400
Received: from mail-pa0-f66.google.com ([209.85.220.66]:35966 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693AbcGFU0u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2016 16:26:50 -0400
Received: by mail-pa0-f66.google.com with SMTP id ib6so5804122pad.3
        for <git@vger.kernel.org>; Wed, 06 Jul 2016 13:26:49 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FaZsdWHkSMTWRVljl9VsOQNnHresblJhXSzhdAB1nXE=;
        b=kgF2BPbUoCNhA3GkNsVrhc7gqcPsKojnBWIHA0NMo/z8DkfAKwa3vnf90Hen7kYpd5
         QjUYGCGUYQnzUXBGIJQRryPLlJKkbgTQK6FuFoFoUgGTQQTaD6cYG7ureU7o5waQj13u
         lENDRtKmGwshNwJ7ZBwc8EmLozukQcPR+EOrZm2NMKapsOuoHKu0RVkcrH9iN3Z2oz0B
         vl1c+pfALv1CtrsvfggdZ5LwVJWB2vmf8neKi5Q/cVTeXtD2t1Hqg69zhGSS+SO+wpuc
         njh6TdXreg+dFDDnOeTkiX9VIvNzoQPP7bqjnGMbrW5s+ZqgOJ1i0+xb6cHTMiJ7zHVA
         47tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FaZsdWHkSMTWRVljl9VsOQNnHresblJhXSzhdAB1nXE=;
        b=jrwhV/ahtdEJc5enqWgfkzIx6ym5xG7PkV7DuJqW8/i2mD4rPAhR3wQEMI7o72NTih
         0kBysnfqLYqWmdxP7r7xI081WmqEiG2G1EQpPq+TJuOoR8e+xGci+nuJzShJAq8HmRqd
         hsKVgZwuVUuc5iPEWByohoA8ySVfOcrQ+9Z/RpXDIuOrhfdfndFiahLP0chvT2Closg7
         Va1g/o+bSf+e2yMwNJ+uKQOo+0tnWZqb+fNhORUDzELMBVkBPSoOTbEVerzDSbPeakfN
         ooseE65SPab1VUf9xkct1d53szew3m0NeAWXw1baCx54GZMiwn5BGhC8KYeCxpTPOCf/
         OOEQ==
X-Gm-Message-State: ALyK8tJfp+Uuwhloi/bvA/aAyYDBf6k5gdkfVgeqLoz2p7t8JKGQ85BmLsFTyplLAxe35Q==
X-Received: by 10.66.162.3 with SMTP id xw3mr44935940pab.82.1467836809421;
        Wed, 06 Jul 2016 13:26:49 -0700 (PDT)
Received: from localhost.localdomain ([27.106.54.176])
        by smtp.gmail.com with ESMTPSA id a87sm6272459pfc.63.2016.07.06.13.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 06 Jul 2016 13:26:48 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, larsxschneider@gmail.com,
	christian.couder@gmail.com, chriscool@tuxfamily.org,
	sunshine@sunshineco.com
Subject: [PATCH v4 3/6] wrapper: move is_empty_file() and rename it as is_empty_or_missing_file()
Date:	Thu,  7 Jul 2016 01:55:20 +0530
Message-Id: <20160706202523.9850-4-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160706202523.9850-1-pranit.bauva@gmail.com>
References: <20160626122356.28999-1-pranit.bauva@gmail.com>
 <20160706202523.9850-1-pranit.bauva@gmail.com>
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

