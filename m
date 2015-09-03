From: David Turner <dturner@twopensource.com>
Subject: [PATCH 14/43] refs.c: move is_branch to the common code
Date: Wed,  2 Sep 2015 21:54:44 -0400
Message-ID: <1441245313-11907-15-git-send-email-dturner@twopensource.com>
References: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twitter.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Sep 03 03:57:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXJmM-0007FF-Cc
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 03:57:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932435AbbICB51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Sep 2015 21:57:27 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:35982 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756327AbbICBzk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Sep 2015 21:55:40 -0400
Received: by qgx61 with SMTP id 61so18634870qgx.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2015 18:55:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oY/8I1TOtUBOpNcKjnmJdKGm+fXAAMW6hAuxU23yD0I=;
        b=VpIuTTHVChlxJtvuzF03zdX0DQm3/VHX3StdY5dEv3VmKBr3PWionhm0PZlZ1P8gvW
         4vHyGmKhbDdA+coK9oodVa4IEhsDieOLJhwG7qOOWM94PwEgjaWpUo57ljUQu7RczP19
         Yf7ZTmgGFT1bki58X939ElE6FYqO/sbl6nzRXTVX8PnuzvhUzAeJjUYOncF+zCUCSMdT
         7lHsHDDFB5Xn6otbtmQo/hzaU+UjRVTV8PTggGDEi+VUQnOtzb8wXGDxNLBocNs7Mb1R
         hjH42zpF5wXB8OEsxN6ehemlbyCN0/MNjExDFboxmZY3OXtf2Tg+g+1fi31lFAEca4FC
         S/Tw==
X-Gm-Message-State: ALoCoQlqR2DFLOMuISMaraUj98IPe6WZfXv8fFIjvQYkHpZue8KQK5ZK5IHl5ENghc4ImonCueUF
X-Received: by 10.140.88.112 with SMTP id s103mr2304230qgd.63.1441245339442;
        Wed, 02 Sep 2015 18:55:39 -0700 (PDT)
Received: from ubuntu.jfk4.office.twttr.net ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 95sm11108155qgt.12.2015.09.02.18.55.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 02 Sep 2015 18:55:38 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
In-Reply-To: <1441245313-11907-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277172>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twitter.com>
---
 refs-be-files.c | 5 -----
 refs.c          | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 3b06714..a346629 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -2967,11 +2967,6 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
 	return ret;
 }
 
-int is_branch(const char *refname)
-{
-	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
-}
-
 /*
  * Write sha1 into the open lockfile, then close the lockfile. On
  * errors, rollback the lockfile, fill in *err and
diff --git a/refs.c b/refs.c
index e9cc2d4..bc8750c 100644
--- a/refs.c
+++ b/refs.c
@@ -767,3 +767,8 @@ int check_refname_format(const char *refname, int flags)
 		return -1; /* Refname has only one component. */
 	return 0;
 }
+
+int is_branch(const char *refname)
+{
+	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
+}
-- 
2.0.4.315.gad8727a-twtrsrc
