From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v10 28/44] refs.c: make write_ref_sha1 static
Date: Fri, 16 May 2014 10:37:16 -0700
Message-ID: <1400261852-31303-29-git-send-email-sahlberg@google.com>
References: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Cc: mhagger@alum.mit.edu, Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 16 19:39:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlM6M-0001vJ-Jm
	for gcvg-git-2@plane.gmane.org; Fri, 16 May 2014 19:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758065AbaEPRjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 13:39:16 -0400
Received: from mail-pb0-f73.google.com ([209.85.160.73]:56904 "EHLO
	mail-pb0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757995AbaEPRhj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2014 13:37:39 -0400
Received: by mail-pb0-f73.google.com with SMTP id ma3so518797pbc.2
        for <git@vger.kernel.org>; Fri, 16 May 2014 10:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=67Xn8nOzTDWfax/uQFDJKkGdxQeCw7dXsIiB+/Yy4nk=;
        b=Sx+6nOjoKIwbR6/2pQjGAvo+xziRkNVvgiO3H8nSuD4oftT73fjKGZAJtZCoe5pGza
         fgnfM22ksFWW0/xpqkT02eBAHBb7jvdyujHVZRKKqFBSD5na9cYYLyFJQbolwZ17s4KC
         /BC3uaCSg5UTuJLr2AYacXMUUbm41bo/UrngwjBKHEX4y9rsz1nr2LR9T1govKML/cxC
         yN5XJYFJCNhbOMgem1j+PZ2vkXLoXoJefWZ2YMz7gwPRTqPuz7KRKXt4V42gUbsWMlTT
         yR4pQeRslR0TIDU15kw2A9iTt1R9UOodf6ORk0d6Fkud1KFSaVoBKFhj/wUQr0mn7oKQ
         8Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=67Xn8nOzTDWfax/uQFDJKkGdxQeCw7dXsIiB+/Yy4nk=;
        b=Gah/hG7PX658C3/0QildVDiulfp/5+ATb5ENsuCDLJNh+T3OveMlq1JUP7QvO/uWaD
         wYbE1Xu/tTK7okJ46Z8e635rGtUKDUD0kcjoM5OmY+K/Z88GYNkRJ/a7XN+W/NLAE4Ew
         pR7j3Wt1aAcJOWQFpsOHCQFtZ3R4gCg9/1f/dzx/F4G2XT3/O2OISdGIiTC6aIgZdD+b
         lF0AD/l4wC9SXkMdatprq80tc0cr+diU/EFGkqLLaES1NpESrqiz/4zoq0FF01Hq5oIn
         Erk62mwkMKpAJGg4s6wYiWhB1izotZEu0HaTgJHxuu1V7acv+hy6p0TZx5WBON9RlJIM
         /kFw==
X-Gm-Message-State: ALoCoQlPmCku7XvTnZXRG3QbVa9XsGNymuBaPLbo9aMxX60CQDlq2PHsMToWi5HDCP6HpfNlJiYo
X-Received: by 10.66.121.195 with SMTP id lm3mr9162930pab.24.1400261858175;
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n68si368516yhj.5.2014.05.16.10.37.38
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 039405A4292;
	Fri, 16 May 2014 10:37:38 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D1C8CE0C3A; Fri, 16 May 2014 10:37:37 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc3.510.g20c254b
In-Reply-To: <1400261852-31303-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249381>

No external users call write_ref_sha1 any more so lets declare it static.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs.c | 4 +++-
 refs.h | 3 ---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 266a792..93e2cd2 100644
--- a/refs.c
+++ b/refs.c
@@ -251,6 +251,8 @@ struct ref_entry {
 };
 
 static void read_loose_refs(const char *dirname, struct ref_dir *dir);
+static int write_ref_sha1(struct ref_lock *lock,
+			  const unsigned char *sha1, const char *logmsg);
 
 static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 {
@@ -2833,7 +2835,7 @@ static int is_branch(const char *refname)
 	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
 }
 
-int write_ref_sha1(struct ref_lock *lock,
+static int write_ref_sha1(struct ref_lock *lock,
 	const unsigned char *sha1, const char *logmsg)
 {
 	static char term = '\n';
diff --git a/refs.h b/refs.h
index e0f5f67..0c4d043 100644
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
2.0.0.rc3.510.g20c254b
