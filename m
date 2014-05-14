From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 30/31] refs.c: move ref_update and other definitions to earlier in the file
Date: Wed, 14 May 2014 15:13:29 -0700
Message-ID: <1400105610-21194-31-git-send-email-sahlberg@google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 00:13:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkhQs-0006EC-IZ
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 00:13:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbaENWNq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2014 18:13:46 -0400
Received: from mail-pa0-f74.google.com ([209.85.220.74]:33818 "EHLO
	mail-pa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753526AbaENWNn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2014 18:13:43 -0400
Received: by mail-pa0-f74.google.com with SMTP id rd3so51990pab.1
        for <git@vger.kernel.org>; Wed, 14 May 2014 15:13:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IZjrZM1EDy/V0sNvq3sWfxO/qKhvsG74W9985FNHKjA=;
        b=gaDXumBj6rZ01DlxF54EhkE/jVnZ3Iw48+XQRfKgsCofRxhAMPrm4wk/DlavEWSFxy
         Hweiy4zTl5I3/JwiKbUkVztzGq/bUoNk6wkoNEn9rloxZEET263JAwrV5EbdIqEdz/pA
         cCrEbQuQtTQFk8ArXR1oF1f8ijkKi45AJNdjb84afF72I3f3SbMrdk/P5rGetR/6T6b0
         n8RITZo2K7uGE2LuIetpR25GlSqE9+5s8D3yh2HiE1AHeu9L7G5dBJ5BD4VSHLMS3CZ3
         RkqPM6lmffWF6B4snHFfzlPJndSa4iVgqhLlp/gOhUb78fl4DM0BNy+Y4g0x80ey9LQp
         DQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IZjrZM1EDy/V0sNvq3sWfxO/qKhvsG74W9985FNHKjA=;
        b=UpVeVHTb4dWLrwgFdfEQ1kfCJ3ryXLJMkJgVau8kyBWVRPT55iTICB3qRZJnFhTQ2o
         Uehfnx68x0f1e8aS9Y1v/8JmVaZLT5QyLmBYhHgLE6HIoWSAiIT3DVTLytvZS5X6hmFs
         fnk8xVbcgjH51WHDq9mRAqgSUVussGG8FlIugaorTBblahT3d6CLWMeQb1FOksnzXKpl
         7+aRYvmSDcRTUOHyZrQtmUEmJlJC8q4RZb9npDFPZFhK9Mt7HcG3l52+4ldj02C3h5hW
         XWch+fZ3jEgalGWbAXmd5ke/Gb3b4pTLumDmP/GWHPx10ncViZnMw1quGlazhVCksXU1
         YyvQ==
X-Gm-Message-State: ALoCoQlyatAKopYexW+54A+YEvhzKGGJsIQhE2z8vnntlSRj2WTUm7P3Iws8QPzqJvjpwkG6mAhY
X-Received: by 10.68.253.66 with SMTP id zy2mr3162343pbc.1.1400105622773;
        Wed, 14 May 2014 15:13:42 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id n68si78059yhj.5.2014.05.14.15.13.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 14 May 2014 15:13:42 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 9511A31C1F8;
	Wed, 14 May 2014 15:13:42 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 5A16FE0973; Wed, 14 May 2014 15:13:42 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.506.g3739a35
In-Reply-To: <1400105610-21194-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249013>

Move the struct ref_update definition and some enums to earlier in the file.
This does not change any actual code or definitions but just moves them
to a different place in the code since we will soon reference some of these
from the rename_ref function.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>

Conflicts:
	refs.c
---
 refs.c | 61 ++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 30 insertions(+), 31 deletions(-)

diff --git a/refs.c b/refs.c
index 46a31c1..bcce8fe 100644
--- a/refs.c
+++ b/refs.c
@@ -2603,6 +2603,36 @@ static int rename_tmp_log(const char *newrefname)
 	return 0;
 }
 
+enum transaction_update_type {
+       UPDATE_SHA1 = 0,
+       UPDATE_LOG = 1,
+};
+
+/**
+ * Information needed for a single ref update.  Set new_sha1 to the
+ * new value or to zero to delete the ref.  To check the old value
+ * while locking the ref, set have_old to 1 and set old_sha1 to the
+ * value or to zero to ensure the ref does not exist before update.
+ */
+struct ref_update {
+	enum transaction_update_type update_type;
+	unsigned char new_sha1[20];
+	unsigned char old_sha1[20];
+	int flags; /* REF_NODEREF? */
+	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
+	struct ref_lock *lock;
+	int type;
+	const char *msg;
+
+	/* used by reflog updates */
+	int reflog_fd;
+	struct lock_file *reflog_lock;
+	const char *committer;
+	struct ref_update *orig_update; /* For UPDATE_REFLOG_NOLOCK */
+
+	const char refname[FLEX_ARRAY];
+};
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20];
@@ -3254,37 +3284,6 @@ int for_each_reflog(each_ref_fn fn, void *cb_data)
 	return retval;
 }
 
-enum transaction_update_type {
-       UPDATE_SHA1 = 0,
-       UPDATE_LOG = 1,
-};
-
-
-/**
- * Information needed for a single ref update.  Set new_sha1 to the
- * new value or to zero to delete the ref.  To check the old value
- * while locking the ref, set have_old to 1 and set old_sha1 to the
- * value or to zero to ensure the ref does not exist before update.
- */
-struct ref_update {
-	enum transaction_update_type update_type;
-	unsigned char new_sha1[20];
-	unsigned char old_sha1[20];
-	int flags; /* REF_NODEREF? or private flags */
-	int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
-	struct ref_lock *lock;
-	int type;
-	const char *msg;
-
-	/* used by reflog updates */
-	int reflog_fd;
-	struct lock_file *reflog_lock;
-	const char *committer;
-	struct ref_update *orig_update; /* For UPDATE_REFLOG_NOLOCK */
-
-	const char refname[FLEX_ARRAY];
-};
-
 enum ref_transaction_status {
 	REF_TRANSACTION_OPEN   = 0,
 	REF_TRANSACTION_CLOSED = 1,
-- 
2.0.0.rc3.506.g3739a35
