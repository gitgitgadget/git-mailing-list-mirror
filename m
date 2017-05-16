Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2096B201A7
	for <e@80x24.org>; Tue, 16 May 2017 04:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750964AbdEPEBB (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 00:01:01 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:35804 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbdEPEBA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 00:01:00 -0400
Received: by mail-qk0-f196.google.com with SMTP id k74so20739717qke.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 21:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tGOte+Z4E9aZEkoZSaX1Kgl8iLaUdyLwsYsOYnBhKM8=;
        b=YJEm6hgWedYvN6koETLj09Wtbn00M5q591P33qJd2gs5jt61Y5M5O5GASv1mHshh+F
         3rGLT8ktfxQjoaeTSwibuULKuQZwL46fAqm7VHM+8Elbj8j9KXr/QMeZZMuZhcDIeDt/
         5mx4cTHycqGOJs0MNO3lY5yKIwU3pgotykHXAn57/rqDy5QrHdQpBO8xxFWIIuSu2Bcd
         AZXb00W/muervWzlEWd//d6b/UlO4up0wG+oz4gk8to5q2dMUI6R2Gvq4irrgIqBXjAG
         TTzs+GBZfuDAKIu4hJmtrMsbNicEUAlOg6CvGptenqKPMIHrq81zUdOE8dut1ErFkH1G
         hU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tGOte+Z4E9aZEkoZSaX1Kgl8iLaUdyLwsYsOYnBhKM8=;
        b=W4kBm899+p3+lAkIQ5XlCFUxa4wbcYLVOLEadMorX+BIdT4333g1okqGZJ00vmasbi
         BCBFbRwRSeyS3n3KqliXR8qbWDqP48iaGCcMG2d93xb2Spkov+ceUnUucYkGxoN3qHPw
         bDLkHI+CgHdx+phJRDQCjUGlG+lbnTGe2C53QmcKUiCoY+McKNA5WXV6EXRfaa7A2NGM
         06Joy148CnxNPvJ9eGkMeow/puD+07pem2yJSrAt+JnNCGvWi6xWeZJVNrHGqfNBhkpq
         mC/CzirNq1etA/VtMy8AaJ/ZDNLQ3BlJ7CvKcWLNSIUThDMnCyzDxp3wI9AJsEkVOR6S
         /ZAw==
X-Gm-Message-State: AODbwcAuGkYMTe30nnM75X2rB+6ftKBnahxoPrWV9QOb9YEep6tBXi5D
        S5nspQ013eQ85NK1aLM=
X-Received: by 10.55.132.196 with SMTP id g187mr3549295qkd.12.1494907257741;
        Mon, 15 May 2017 21:00:57 -0700 (PDT)
Received: from localhost.localdomain ([189.62.40.36])
        by smtp.gmail.com with ESMTPSA id h14sm10068049qta.18.2017.05.15.21.00.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 15 May 2017 21:00:57 -0700 (PDT)
From:   Daniel Ferreira <bnmvco@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, avarab@gmail.com,
        jrnieder@gmail.com, Daniel Ferreira <bnmvco@gmail.com>
Subject: [PATCH v2 2/4] add--helper: create builtin helper for interactive add
Date:   Tue, 16 May 2017 01:00:32 -0300
Message-Id: <1494907234-28903-3-git-send-email-bnmvco@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <1494907234-28903-1-git-send-email-bnmvco@gmail.com>
References: <1494907234-28903-1-git-send-email-bnmvco@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a builtin helper for git-add--interactive, which right now is not
able to do anything.

This is the first step in an effort to convert git-add--interactive.perl
to a C builtin, in search for better portability, expressibility and
performance (specially on non-POSIX systems like Windows).

Additionally, an eventual complete port of git-add--interactive would
remove the last "big" Git script to have Perl as a dependency, allowing
most Git users to have a NOPERL build running without big losses.

Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
---
 .gitignore            | 1 +
 Makefile              | 1 +
 builtin.h             | 1 +
 builtin/add--helper.c | 6 ++++++
 git.c                 | 1 +
 5 files changed, 10 insertions(+)
 create mode 100644 builtin/add--helper.c

diff --git a/.gitignore b/.gitignore
index 833ef3b..11cec05 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,6 +11,7 @@
 /git
 /git-add
 /git-add--interactive
+/git-add--helper
 /git-am
 /git-annotate
 /git-apply
diff --git a/Makefile b/Makefile
index e35542e..b7f49b6 100644
--- a/Makefile
+++ b/Makefile
@@ -873,6 +873,7 @@ LIB_OBJS += xdiff-interface.o
 LIB_OBJS += zlib.o
 
 BUILTIN_OBJS += builtin/add.o
+BUILTIN_OBJS += builtin/add--helper.o
 BUILTIN_OBJS += builtin/am.o
 BUILTIN_OBJS += builtin/annotate.o
 BUILTIN_OBJS += builtin/apply.o
diff --git a/builtin.h b/builtin.h
index 9e4a898..85b4c55 100644
--- a/builtin.h
+++ b/builtin.h
@@ -30,6 +30,7 @@ extern int textconv_object(const char *path, unsigned mode, const struct object_
 extern int is_builtin(const char *s);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
+extern int cmd_add__helper(int argc, const char **argv, const char *prefix);
 extern int cmd_am(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
 extern int cmd_apply(int argc, const char **argv, const char *prefix);
diff --git a/builtin/add--helper.c b/builtin/add--helper.c
new file mode 100644
index 0000000..6a97f0e
--- /dev/null
+++ b/builtin/add--helper.c
@@ -0,0 +1,6 @@
+#include "builtin.h"
+
+int cmd_add__helper(int argc, const char **argv, const char *prefix)
+{
+	return 0;
+}
diff --git a/git.c b/git.c
index 8ff44f0..47ee257 100644
--- a/git.c
+++ b/git.c
@@ -391,6 +391,7 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 
 static struct cmd_struct commands[] = {
 	{ "add", cmd_add, RUN_SETUP | NEED_WORK_TREE },
+	{ "add--helper", cmd_add__helper, RUN_SETUP | NEED_WORK_TREE },
 	{ "am", cmd_am, RUN_SETUP | NEED_WORK_TREE },
 	{ "annotate", cmd_annotate, RUN_SETUP },
 	{ "apply", cmd_apply, RUN_SETUP_GENTLY },
-- 
2.7.4 (Apple Git-66)

