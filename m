From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v8 28/44] refs.c: make write_ref_sha1 static
Date: Thu, 15 May 2014 10:29:43 -0700
Message-ID: <1400174999-26786-29-git-send-email-sahlberg@google.com>
References: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 19:30:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkzUC-0006nO-Jq
	for gcvg-git-2@plane.gmane.org; Thu, 15 May 2014 19:30:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727AbaEORaX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2014 13:30:23 -0400
Received: from mail-ob0-f202.google.com ([209.85.214.202]:41377 "EHLO
	mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677AbaEORaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2014 13:30:09 -0400
Received: by mail-ob0-f202.google.com with SMTP id wm4so288869obc.3
        for <git@vger.kernel.org>; Thu, 15 May 2014 10:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vSW01Wabe64kyiF7L8FkGvLVV+jbkEfwORfoePI4k5o=;
        b=nWU3Q0r/W3fPjiZI/lW2WUZMG2qFreZG6jJBXvIAchYVf2E+2ESUyABY4sTu+4W8PX
         bJuMKtyYdzxQBF2A+vzE991NsloudTnpgsXJYSpKjNpNISmpjQLVjQRx11nt5xSp1dsH
         vRyKCOZxgAgLuS1pUs02MRnJQE29kbBfRTIeIew9xLE2XwHawtKr/mrELOklAEveXV2Y
         IQiv96bfj8xwGlyqo+SpDt4h6xpmHmnhFRYNpGYuoLoeEO18+jCbxJEd5q4SvkDIWljB
         V/o+STg/GQE1iPbwtrBPhp/mm138xZW2+3tdE+CE5LLoEN5sK2h/AmlVQo3qIa3Papea
         2IqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vSW01Wabe64kyiF7L8FkGvLVV+jbkEfwORfoePI4k5o=;
        b=Po/A4Og+rsNKzZSUgb7nr8QgqJOPRrMhxPP09zKf/418hUNmN9D3pUaTTWemCKzqOn
         6ERfTB5NIK7qv9SB0GSsh/fbWngRuugpuT/jdCXZc+4rcL3jUwiXQwiYT/w+tI3hLu7B
         GECwCqTlNxVc9AnNZU3P4Eldc4KVNkNdECVKpI9/FtpjAF2l8DjreT3L/5Y/dUW7j1w3
         N/ZYn3GZDWMpFJIoFV7oGFSbHY8epFYolHrhVxtvmfSqeS1BFUSXfezdAkIvZPb4acWy
         qxysLlzk0ytIDwLkWT/fwmeYkicgiUFEewjjZLvlJWc2025QWy4JQncV9IQIfWcDvHdz
         TMDQ==
X-Gm-Message-State: ALoCoQnwnIidjWMoQ8arnDx8lnKjF2HvlSYANgwbv186VM9rGyEZmEkPG/qnXf6eEt4JDw8rZNmW
X-Received: by 10.182.105.1 with SMTP id gi1mr5513411obb.6.1400175006984;
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a44si272583yhb.6.2014.05.15.10.30.06
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id D03CE5A428A;
	Thu, 15 May 2014 10:30:06 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id ACA04E1207; Thu, 15 May 2014 10:30:06 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.477.g0f8edf7
In-Reply-To: <1400174999-26786-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249124>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 +++-
 refs.h | 3 ---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 82a8d4e..e5729ad 100644
--- a/refs.c
+++ b/refs.c
@@ -251,6 +251,8 @@ struct ref_entry {
 };
 
 static void read_loose_refs(const char *dirname, struct ref_dir *dir);
+static int write_ref_sha1(struct ref_lock *lock,
+			  const unsigned char *sha1, const char *logmsg);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
@@ -2805,7 +2807,7 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-int write_ref_sha1(struct ref_lock *lock,
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index b94e1ac..796e396 100644
--- a/refs.h
+++ b/refs.h
@@ -150,9 +150,6 @@ extern int commit_ref(struct ref_lock *lock);
 /** Release any lock taken but not written. **/
 extern void unlock_ref(struct ref_lock *lock);
 
-/** Writes sha1 into the ref specified by the lock. **/
-extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
-
 /** Setup reflog before using. **/
 int log_ref_setup(const char *refname, char *logfile, int bufsize);
 
-- 
2.0.0.rc3.477.g0f8edf7
