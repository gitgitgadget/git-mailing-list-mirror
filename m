From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 4/6] refs.c: move static functions to close and commit refs
Date: Fri, 23 Jan 2015 12:04:00 -0800
Message-ID: <1422043442-30676-5-git-send-email-sbeller@google.com>
References: <54C0E76D.5070104@alum.mit.edu>
 <1422043442-30676-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: mhagger@alum.mit.edu, peff@peff.net, git@vger.kernel.org,
	gitster@pobox.com, loic@dachary.org
X-From: git-owner@vger.kernel.org Fri Jan 23 21:05:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEkTq-0007MZ-TI
	for gcvg-git-2@plane.gmane.org; Fri, 23 Jan 2015 21:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756242AbbAWUFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jan 2015 15:05:18 -0500
Received: from mail-ie0-f171.google.com ([209.85.223.171]:61807 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755947AbbAWUFK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jan 2015 15:05:10 -0500
Received: by mail-ie0-f171.google.com with SMTP id tr6so9131128ieb.2
        for <git@vger.kernel.org>; Fri, 23 Jan 2015 12:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LcfvTrZnEvcFOoXn6+Gs8Ft0LfA85g3P8LmaZ+ainQ0=;
        b=fhUkRYtgWRS966rLW8PSMzTr/K3qOYdsj52fyOFG+kp4q1CFAZkOGiGuyFE1pNHcJ3
         RS6NArINYIRzq0pq+oTEZ1m/H8HuVGkOuIHrHYaUC5/QYPbLCHigkE+XwgfycSCkDiCs
         zELEEH5BuP4nbpKfuHY85PM67JXyAvYeN0cBXRF2iAlmcNHGlWKLTDbpZIw3HaqlSmmb
         /msy4cjPYXF2hJ/q/t+RHsvoI1V0e3+hS3SJ5Sf8JxyNt4SceaSMn3GqlZhWgTiv+yKg
         CqUYyKrScNpTq4V+DoG8j1IZsyANcWli7mRoHT89CLPMWXSjqnNtfRu/1bzy0t2GEJWd
         JdLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LcfvTrZnEvcFOoXn6+Gs8Ft0LfA85g3P8LmaZ+ainQ0=;
        b=JcTKMAfAt5a6qBrzMCHHhVahobNdHgZpNo2aZ+7i+y8ww6J6A/3QoX4N+hR3RHcvb8
         JumOmnfdturkhvoh7J9B6L1eRDS2n7VmkktNm4BWfaruNbZx/SPof6VJTDMDNOaJYyoX
         osx7W0Lf+M72uzFlmlmgifRAMZmmvB1g0B1mOrVI8BKZyIeiPbIEJ7kgQg3oWLrtGMzD
         KKv/NbaL3/u6ObGQvRr9o4uyPPx8YNE0yUdDUFe/b+Un9GV49LJpbBbiO4W2VeXJTCG4
         iVzB7Il7xwdJRYks1mz2CxxAfkdBlbw/E76f3tNMs58o4o32FnhCATm57o36q4zCRdOS
         sRgg==
X-Gm-Message-State: ALoCoQkR6jyzlW2kwCzXhMUyne3wukoMbgaHvgE0ko6+2etMOVNsT9D2NCGgIkwVeDvRB8/b08t9
X-Received: by 10.50.108.83 with SMTP id hi19mr3895874igb.8.1422043509579;
        Fri, 23 Jan 2015 12:05:09 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:40d0:e4e:2e83:8781])
        by mx.google.com with ESMTPSA id e3sm1156583igg.16.2015.01.23.12.05.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 23 Jan 2015 12:05:09 -0800 (PST)
X-Mailer: git-send-email 2.2.1.62.g3f15098
In-Reply-To: <1422043442-30676-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262957>

By moving the functions up we don't need to have to declare them first
when using them in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---

Notes:
    new in v3

 refs.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index 4066752..f1eefc7 100644
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
@@ -2898,20 +2912,6 @@ int rename_ref(const char *oldrefname, const char *newrefname, const char *logms
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
