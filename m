From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/5] refs.c: move static functions to close and commit refs
Date: Thu, 22 Jan 2015 15:11:35 -0800
Message-ID: <1421968297-25407-4-git-send-email-sbeller@google.com>
References: <54C0DDE7.8030708@alum.mit.edu>
 <1421968297-25407-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: peff@peff.net, git@vger.kernel.org, gitster@pobox.com,
	mhagger@alum.mit.edu, loic@dachary.org, ramsay@ramsay1.demon.co.uk
X-From: git-owner@vger.kernel.org Fri Jan 23 00:11:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEQuq-0001Wa-43
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 00:11:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbbAVXLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 18:11:49 -0500
Received: from mail-ie0-f176.google.com ([209.85.223.176]:35093 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670AbbAVXLp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 18:11:45 -0500
Received: by mail-ie0-f176.google.com with SMTP id rd18so4285629iec.7
        for <git@vger.kernel.org>; Thu, 22 Jan 2015 15:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bm7eV3uEOWQi4JlL/JkGzvKRX7B/4Oe914L6wt4DwbY=;
        b=STqo9Dsyf5BisUHabTyp3p+7b6aW6HB2WrBd+PZ2ebQKyY9joqIZPz8VPb9TfCeH+n
         65v91BaPAhKr/QAsLrX+idjYowmMu+IvEVktGgUoslIa1CP9S7hSoxzLEG9kf0OLD+U4
         3J7IRlhO1dnWWr85eEzB1D8MOsB0yixsQlsZvKSoftGV++Fm8Zk351EJAlnTuWYM7YeA
         zycxChq7LX9wI9Z4+LCCXW48lnvvO0MgOcCWADw/8LPNDIO4pOPIyyBFdVRWdyod/YCI
         ShcQ37uA4BESr/MZXFcE0ONw7HdBEbW5M7F1C8qAFP7p+Y0nbSCAeO7N4cuWYciDGkK0
         XOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bm7eV3uEOWQi4JlL/JkGzvKRX7B/4Oe914L6wt4DwbY=;
        b=VwNqDg2vKzUn9QSeu6KDfX9J5xmVtmxkbQdkmBRfqRNFONHLRYgmULmtdoOV+KiAj5
         m1ZeQ94HX1zzk5wUhG+j7jzr2Jd6O38bXnh7wIdAtGW+wdWOuCtneh3SDsRyNAoWm3dN
         6H7rikzUzpZKhXWOggdxk4Jk2znX1NI6nNWrI16JgpAHIN/mcC04aiHXsziYzTnwcSoo
         8fh0cdvK6ZlncK5wHBV+SLXevmxv1yfHZdEtONeMYw8pP7ygUnM4sVw+jyqizsS1wZZY
         PuImW9d5dnCu6ohzyDB5jSRheFtlES28mugSvAeDBMEevmQdKsoOOIgkhUsLcoVoetZO
         E+xg==
X-Gm-Message-State: ALoCoQkOIYdHBBnuFYTmkFsaJ0I06CWv/uTVSqZ4cqyuA2Mqrt5yziiMEVb8docsMDRXbNZBuOzl
X-Received: by 10.42.62.71 with SMTP id x7mr5923572ich.61.1421968304253;
        Thu, 22 Jan 2015 15:11:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:e0f4:42de:391f:3cc5])
        by mx.google.com with ESMTPSA id 185sm241840iof.43.2015.01.22.15.11.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 Jan 2015 15:11:43 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1421968297-25407-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262890>

By moving the functions up we don't need to have to declare them first
when using them in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 4580919..6f3cd7b 100644
--- a/refs.c
+++ b/refs.c
@@ -2808,6 +2808,20 @@ static int rename_ref_available(const char *oldname, const char *newname)
 static int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1,
 			  const char *logmsg);
 
+static int close_ref(struct ref_lock *lock)
+{
+	if (close_lock_file(lock->lk))
+		return -1;
+	return 0;
+}
+
+static int commit_ref(struct ref_lock *lock)
+{
+	if (commit_lock_file(lock->lk))
+		return -1;
+	return 0;
+}
+
 int rename_ref(const char *oldrefname, const char *newrefname, const char *logmsg)
 {
 	unsigned char sha1[20], orig_sha1[20];
@@ -2901,20 +2915,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
 	return 1;
 }
 
-static int close_ref(struct ref_lock *lock)
-{
-	if (close_lock_file(lock->lk))
-		return -1;
-	return 0;
-}
-
-static int commit_ref(struct ref_lock *lock)
-{
-	if (commit_lock_file(lock->lk))
-		return -1;
-	return 0;
-}
-
 /*
  * copy the reflog message msg to buf, which has been allocated sufficiently
  * large, while cleaning up the whitespaces.  Especially, convert LF to space,
-- 
2.2.1.62.g3f15098
