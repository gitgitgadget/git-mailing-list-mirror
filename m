From: Johan Herland <johan@herland.net>
Subject: [WIP/RFC 02/13] notes.h: Make default_notes_ref() available in notes
 API
Date: Fri, 23 Jul 2010 12:14:53 +0200
Message-ID: <1279880104-29796-3-git-send-email-johan@herland.net>
References: <1279880104-29796-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 23 12:15:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcFHl-0000nW-HR
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 12:15:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755696Ab0GWKPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 06:15:16 -0400
Received: from smtp.getmail.no ([84.208.15.66]:43952 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755477Ab0GWKPN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 06:15:13 -0400
Received: from get-mta-scan02.get.basefarm.net ([10.5.16.4])
 by get-mta-out03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L6000G9J9TAM390@get-mta-out03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:10 +0200 (MEST)
Received: from get-mta-scan02.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 330881EA5535_C496BAEB	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:10 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan02.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 92ED71EA3708_C496BADF	for <git@vger.kernel.org>; Fri,
 23 Jul 2010 10:15:09 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L60005R49T9TN00@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Fri, 23 Jul 2010 12:15:09 +0200 (MEST)
X-Mailer: git-send-email 1.7.2.220.gea1d3
In-reply-to: <1279880104-29796-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151512>

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |    2 +-
 notes.h |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/notes.c b/notes.c
index 1978244..79fd850 100644
--- a/notes.c
+++ b/notes.c
@@ -898,7 +898,7 @@ static int notes_display_config(const char *k, const char *v, void *cb)
 	return 0;
 }
 
-static const char *default_notes_ref(void)
+const char *default_notes_ref(void)
 {
 	const char *notes_ref = NULL;
 	if (!notes_ref)
diff --git a/notes.h b/notes.h
index c0288b0..20db42f 100644
--- a/notes.h
+++ b/notes.h
@@ -44,6 +44,20 @@ extern struct notes_tree {
 } default_notes_tree;
 
 /*
+ * Return the default notes ref.
+ *
+ * The default notes ref is the notes ref that is used when notes_ref == NULL
+ * is passed to init_notes().
+ *
+ * This the first of the following to be defined:
+ * 1. The '--ref' option to 'git notes', if given
+ * 2. The $GIT_NOTES_REF environment variable, if set
+ * 3. The value of the core.notesRef config variable, if set
+ * 4. GIT_NOTES_DEFAULT_REF (i.e. "refs/notes/commits")
+ */
+const char *default_notes_ref(void);
+
+/*
  * Flags controlling behaviour of notes tree initialization
  *
  * Default behaviour is to initialize the notes tree from the tree object
-- 
1.7.2.220.gea1d3
