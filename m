From: Johan Herland <johan@herland.net>
Subject: [PATCHv3 03/21] notes.h: Make default_notes_ref() available in notes API
Date: Sat,  9 Oct 2010 03:08:30 +0200
Message-ID: <1286586528-3473-4-git-send-email-johan@herland.net>
References: <1286586528-3473-1-git-send-email-johan@herland.net>
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 09 03:09:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4Nw9-0001XH-FB
	for gcvg-git-2@lo.gmane.org; Sat, 09 Oct 2010 03:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760101Ab0JIBJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Oct 2010 21:09:12 -0400
Received: from mail.mailgateway.no ([82.117.37.108]:52264 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759990Ab0JIBJL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Oct 2010 21:09:11 -0400
Received: from pd9587e9f.dip.t-dialin.net ([217.88.126.159] helo=localhost.localdomain)
	by mail.mailgateway.no with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.60 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1P4Nvw-00011L-VB; Sat, 09 Oct 2010 03:09:09 +0200
X-Mailer: git-send-email 1.7.3.1.104.g92b87a
In-Reply-To: <1286586528-3473-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158550>

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
1.7.3.1.104.g92b87a
