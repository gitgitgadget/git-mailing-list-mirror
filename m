From: Stefan Beller <sbeller@google.com>
Subject: [PATCH v3 12/14] refs.c: Remove unlock_ref/close_ref/commit_ref from the refs api
Date: Mon, 17 Nov 2014 17:35:48 -0800
Message-ID: <1416274550-2827-13-git-send-email-sbeller@google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue Nov 18 02:36:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqXid-0000PJ-9M
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 02:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753550AbaKRBgb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Nov 2014 20:36:31 -0500
Received: from mail-ig0-f177.google.com ([209.85.213.177]:59522 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbaKRBgK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Nov 2014 20:36:10 -0500
Received: by mail-ig0-f177.google.com with SMTP id uq10so4999555igb.10
        for <git@vger.kernel.org>; Mon, 17 Nov 2014 17:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IS/7QB+kFvXLQYYTD18VD7YYSTHYGZIwRWwCdZZCjmE=;
        b=hsMP7jdytLIjzghI1F9PO+sEZS2+0tX+dSd1TkcABkVwSLI4xcF5v/aXWpf0+bPBwF
         UKBq7LTurhv7b9S95uWNq7ih0ks9lIBUOCk1xgh/tyQD0mO9WBbDVOvK1+B4KiR+rolZ
         b3IcTRyym/yyZ9mnCQXQqhmvdPfOyL73TuD2UY+E1kjjZGyRvTSeCt9hLo/BwOlz1+l8
         AzCV8cMoIg8Cg4sw5oQVhL+TVPNaWk/dvEpiV3zYAImXvEUtBjkuEe6nSvLMJtoj2xM1
         BRyqJqq8x4K3hQqnhjE/BxBsyTzKYsKf0Fz4bXyFfpd77XQojmShZmXY7KwTLTr2NHp6
         4aVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IS/7QB+kFvXLQYYTD18VD7YYSTHYGZIwRWwCdZZCjmE=;
        b=cfrAYRrbl+0DL3W6mvSlg5SoEMS/LviIZY7dKtDry9ED3Kx1UoTCiu0c3l674nm7XO
         tCjbd6kS3R7OB559q1majCsG56adytGz9GFFmy/ALV8fclv7YHrq9iHH4sEr/h6e3EQY
         HBrrvR7DGeBZ2Pf8slHLn6qRWi2PU7svU2diuIJDSLm+LvvfoMimAXwf8kHX8kBcUmAA
         uvXbrPyB9ghNxaKgPMgre/ugbEX3o9YvHIQDqBeAHOsMkL2uY7eF0hA/ifX03WqeX9Cn
         DgZ7f4XEK0AUb9Th1Gutgkh62qI6mvk2QU8AjvVL9WFWS3aZ3GogayMUihVwXPbO760h
         3baw==
X-Gm-Message-State: ALoCoQkAE8q18e4gHnHoQNjQgI+VT3gdEoEzVar0+35DN0PfNVho+tDHoxgpTwCZ+i8nhrkADXRJ
X-Received: by 10.42.137.9 with SMTP id w9mr31805087ict.20.1416274569994;
        Mon, 17 Nov 2014 17:36:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:c9d9:b6de:cff4:3fc7])
        by mx.google.com with ESMTPSA id h199sm19793288ioh.0.2014.11.17.17.36.09
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 17 Nov 2014 17:36:09 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc2.5.gf7b9fb2
In-Reply-To: <1416274550-2827-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ronnie Sahlberg <sahlberg@google.com>

unlock|close|commit_ref can be made static since there are no more external
callers.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 24 ++++++++++++------------
 refs.h |  9 ---------
 2 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/refs.c b/refs.c
index 11cf26b..e49ae11 100644
--- a/refs.c
+++ b/refs.c
@@ -2096,6 +2096,16 @@ int refname_match(const char *abbrev_name, const char *full_name)
 	return 0;
 }
 
+static void unlock_ref(struct ref_lock *lock)
+{
+	/* Do not free lock->lk -- atexit() still looks at them */
+	if (lock->lk)
+		rollback_lock_file(lock->lk);
+	free(lock->ref_name);
+	free(lock->orig_ref_name);
+	free(lock);
+}
+
 /* This function should make sure errno is meaningful on error */
 static struct ref_lock *verify_lock(struct ref_lock *lock,
 	const unsigned char *old_sha1, int mustexist)
@@ -2894,7 +2904,7 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 1;
 }
 
-int close_ref(struct ref_lock *lock)
+static int close_ref(struct ref_lock *lock)
 {
 	if (close_lock_file(lock->lk))
 		return -1;
@@ -2902,7 +2912,7 @@ int close_ref(struct ref_lock *lock)
 	return 0;
 }
 
-int commit_ref(struct ref_lock *lock)
+static int commit_ref(struct ref_lock *lock)
 {
 	if (commit_lock_file(lock->lk))
 		return -1;
@@ -2910,16 +2920,6 @@ int commit_ref(struct ref_lock *lock)
 	return 0;
 }
 
-void unlock_ref(struct ref_lock *lock)
-{
-	/* Do not free lock->lk -- atexit() still looks at them */
-	if (lock->lk)
-		rollback_lock_file(lock->lk);
-	free(lock->ref_name);
-	free(lock->orig_ref_name);
-	free(lock);
-}
-
 /*
  * copy the reflog message msg to buf, which has been allocated sufficiently
  * large, while cleaning up the whitespaces.  Especially, convert LF to space,
diff --git a/refs.h b/refs.h
index 17e3a3c..025e2cb 100644
--- a/refs.h
+++ b/refs.h
@@ -198,15 +198,6 @@ extern struct ref_lock *lock_any_ref_for_update(const char *refname,
 						const unsigned char *old_sha1,
 						int flags, int *type_p);
 
-/** Close the file descriptor owned by a lock and return the status */
-extern int close_ref(struct ref_lock *lock);
-
-/** Close and commit the ref locked by the lock */
-extern int commit_ref(struct ref_lock *lock);
-
-/** Release any lock taken but not written. **/
-extern void unlock_ref(struct ref_lock *lock);
-
 /** Reads log for the value of ref during at_time. **/
 extern int read_ref_at(const char *refname, unsigned int flags,
 		       unsigned long at_time, int cnt,
-- 
2.2.0.rc2.5.gf7b9fb2
