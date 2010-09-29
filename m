From: Johan Herland <johan@herland.net>
Subject: [PATCH 02/18] notes.h: Make default_notes_ref() available in notes API
Date: Wed, 29 Sep 2010 02:23:15 +0200
Message-ID: <1285719811-10871-3-git-send-email-johan@herland.net>
References: <1285719811-10871-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 29 02:23:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0kSh-0000uw-BM
	for gcvg-git-2@lo.gmane.org; Wed, 29 Sep 2010 02:23:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753002Ab0I2AXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Sep 2010 20:23:47 -0400
Received: from smtp.getmail.no ([84.208.15.66]:44298 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751829Ab0I2AXp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Sep 2010 20:23:45 -0400
Received: from get-mta-scan04.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H003YDFRITS70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:42 +0200 (MEST)
Received: from get-mta-scan04.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id B2E551EEF85E_CA2870EB	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:42 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan04.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 7F8A81EEF852_CA2870EF	for <git@vger.kernel.org>; Wed,
 29 Sep 2010 00:23:41 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L9H00IQEFRHZC10@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 29 Sep 2010 02:23:41 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1285719811-10871-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157499>

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
1.7.3.98.g5ad7d9
