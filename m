From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v6 13/25] refs: move is_branch to the common code
Date: Tue,  3 Nov 2015 08:39:57 +0100
Message-ID: <ec95aecb12255f1382c22fac0012856a275ec3b5.1446534991.git.mhagger@alum.mit.edu>
References: <cover.1446534991.git.mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	David Turner <dturner@twopensource.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 08:40:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZtWCv-0007Pz-9R
	for gcvg-git-2@plane.gmane.org; Tue, 03 Nov 2015 08:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752958AbbKCHkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Nov 2015 02:40:36 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:56104 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752865AbbKCHkc (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2015 02:40:32 -0500
X-AuditID: 12074413-f79bd6d000007ac2-74-563864efcc1e
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 42.03.31426.FE468365; Tue,  3 Nov 2015 02:40:31 -0500 (EST)
Received: from michael.fritz.box (p5DDB0E27.dip0.t-ipconnect.de [93.219.14.39])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id tA37eDdA016391
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Tue, 3 Nov 2015 02:40:30 -0500
X-Mailer: git-send-email 2.6.2
In-Reply-To: <cover.1446534991.git.mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsUixO6iqPs+xSLMoHuzjsX8TScYLbqudDNZ
	NPReYba4vWI+s8W/CTUOrB5/339g8liwqdTj4iVljwXP77N7fN4kF8AaxW2TlFhSFpyZnqdv
	l8CdceHNM7aCyVwVO9omsDcwbuboYuTkkBAwkej7uY4FwhaTuHBvPVsXIxeHkMBlRolL39qZ
	IZxjTBKfN+9jA6liE9CVWNTTzARiiwioSUxsO8QCUsQssIhRovXNdLCEsICjxPrGB+wgNouA
	qsTJ48fA4rwCURJTu1+xQ6yTk5hyvx0szilgIfHg7h+wuJCAucSme8vYJjDyLmBkWMUol5hT
	mqubm5iZU5yarFucnJiXl1qka66Xm1mil5pSuokRElLCOxh3nZQ7xCjAwajEw7tgiXmYEGti
	WXFl7iFGSQ4mJVHedTEWYUJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeAsCgXK8KYmVValF+TAp
	aQ4WJXFetSXqfkIC6YklqdmpqQWpRTBZGQ4OJQneCGDsCAkWpaanVqRl5pQgpJk4OEGGc0mJ
	FKfmpaQWJZaWZMSDoiO+GBgfICkeoL0JIO28xQWJuUBRiNZTjIpS4ryTk4ESAiCJjNI8uLGw
	RPGKURzoS2HeCyBVPMAkA9f9CmgwE9Dg8G2mIINLEhFSUg2Mk5Uthb0VMj/Jp7wO3d+0qvbh
	um1/XrCsjhOoNU7zYPgfskY4pG6XNOfsdw+XhzM1mL5Ma/jsWl/gvueqb9ORC8IZ9TL/GWxn
	fuuJ3t3Zopjds+Tet45tt7JMenM12c6Y//D9zP3HvH3GTHPNxGkzryo6Kgn1Vx3Z 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280759>

From: Ronnie Sahlberg <sahlberg@google.com>

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs/files-backend.c | 5 -----
 refs/refs.c          | 5 +++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 545075f..468758a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3002,11 +3002,6 @@ static int log_ref_write(const char *refname, const unsigned char *old_sha1,
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
diff --git a/refs/refs.c b/refs/refs.c
index bc7e159..fb0e5df 100644
--- a/refs/refs.c
+++ b/refs/refs.c
@@ -731,3 +731,8 @@ int check_refname_format(const char *refname, int flags)
 		return -1; /* Refname has only one component. */
 	return 0;
 }
+
+int is_branch(const char *refname)
+{
+	return !strcmp(refname, "HEAD") || starts_with(refname, "refs/heads/");
+}
-- 
2.6.2
