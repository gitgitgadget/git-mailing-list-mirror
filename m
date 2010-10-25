From: Johan Herland <johan@herland.net>
Subject: [PATCHv5 03/23] notes.h: Make default_notes_ref() available in notes
 API
Date: Mon, 25 Oct 2010 02:08:33 +0200
Message-ID: <1287965333-5099-4-git-send-email-johan@herland.net>
References: <1287965333-5099-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 25 02:09:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PAAcs-0000Uz-KF
	for gcvg-git-2@lo.gmane.org; Mon, 25 Oct 2010 02:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751742Ab0JYAJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Oct 2010 20:09:17 -0400
Received: from smtp.getmail.no ([84.208.15.66]:59867 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751597Ab0JYAJP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Oct 2010 20:09:15 -0400
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT005YWKFCGG40@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:12 +0200 (MEST)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 787BD17991EA_CC4CAA8B	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:12 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 60D371796C21_CC4CAA8F	for <git@vger.kernel.org>; Mon,
 25 Oct 2010 00:09:11 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in03.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LAT004SRKFAVB20@get-mta-in03.get.basefarm.net> for
 git@vger.kernel.org; Mon, 25 Oct 2010 02:09:11 +0200 (MEST)
X-Mailer: git-send-email 1.7.3.98.g5ad7d9
In-reply-to: <1287965333-5099-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159899>

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |    2 +-
 notes.h |   14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletions(-)

diff --git a/notes.c b/notes.c
index bb03eb0..d71c0a3 100644
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
