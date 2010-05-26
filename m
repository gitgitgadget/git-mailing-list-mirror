From: Sam Vilain <sam.vilain@catalyst.net.nz>
Subject: [PATCH 104/104] Documentation/SubmittingPatches: clarify GMail section and SMTP
Date: Wed, 26 May 2010 18:01:14 +1200
Message-ID: <1274853674-18521-104-git-send-email-sam.vilain@catalyst.net.nz>
References: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 26 08:07:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OH9m5-00051a-Pg
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 08:07:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934095Ab0EZGHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 May 2010 02:07:24 -0400
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:49306 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933977Ab0EZGGc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 May 2010 02:06:32 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 May 2010 02:06:22 EDT
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 1A45B338B4;
	Wed, 26 May 2010 18:02:17 +1200 (NZST)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tP7Gpc3mEwm7; Wed, 26 May 2010 18:02:08 +1200 (NZST)
Received: from wilber.wgtn.cat-it.co.nz (leibniz.catalyst.net.nz [202.78.240.7])
	by mail.catalyst.net.nz (Postfix) with ESMTP id E8F6F32C10;
	Wed, 26 May 2010 18:01:41 +1200 (NZST)
X-Mailer: git-send-email 1.7.1.rc2.333.gb2668
In-Reply-To: <1274853674-18521-1-git-send-email-sam.vilain@catalyst.net.nz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147766>

From: Michael J Gruber <git@drmicha.warpmail.net>

We keep getting mangled submissions from GMail's web interface. Try to
be more proactive in SubmittingPatches by

- pointing to MUA specific instructions early on,
- structuring the GMail section more clearly,
- putting send-email/SMTP before imap-send/IMAP.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/SubmittingPatches |   40 ++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index abc65de..22e3808 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -41,6 +41,7 @@ Checklist (and a short version for the impatient):
 	  maintainer (gitster@pobox.com) if (and only if) the patch
 	  is ready for inclusion. If you use git-send-email(1),
 	  please test it first by sending email to yourself.
+	- see below for instructions specific to your mailer
 
 Long version:
 
@@ -519,9 +520,27 @@ Gmail
 
 GMail does not appear to have any way to turn off line wrapping in the web
 interface, so this will mangle any emails that you send.  You can however
-use any IMAP email client to connect to the google imap server, and forward
+use "git send e-mail" and send your patches through the GMail SMTP server, or
+use any IMAP email client to connect to the google IMAP server and forward
 the emails through that.
 
+To use "git send-email" and send your patches through the GMail SMTP server,
+edit ~/.gitconfig to specify your account settings:
+
+[sendemail]
+	smtpencryption = tls
+	smtpserver = smtp.gmail.com
+	smtpuser = user@gmail.com
+	smtppass = p4ssw0rd
+	smtpserverport = 587
+
+Once your commits are ready to be sent to the mailing list, run the
+following commands:
+
+  $ git format-patch --cover-letter -M origin/master -o outgoing/
+  $ edit outgoing/0000-*
+  $ git send-email outgoing/*
+
 To submit using the IMAP interface, first, edit your ~/.gitconfig to specify your
 account settings:
 
@@ -537,8 +556,7 @@ You might need to instead use: folder = "[Google Mail]/Drafts" if you get an err
 that the "Folder doesn't exist".
 
 Once your commits are ready to be sent to the mailing list, run the
-following command to send the patch emails to your Gmail Drafts
-folder.
+following commands:
 
   $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
 
@@ -546,19 +564,3 @@ Just make sure to disable line wrapping in the email client (GMail web
 interface will line wrap no matter what, so you need to use a real
 IMAP client).
 
-Alternatively, you can use "git send-email" and send your patches
-through the GMail SMTP server.  edit ~/.gitconfig to specify your
-account settings:
-
-[sendemail]
-	smtpencryption = tls
-	smtpserver = smtp.gmail.com
-	smtpuser = user@gmail.com
-	smtppass = p4ssw0rd
-	smtpserverport = 587
-
-Once your commits are ready to be sent to the mailing list, run the
-following commands:
-
-  $ git format-patch --cover-letter -M origin/master -o outgoing/
-  $ git send-email outgoing/*
-- 
1.7.1.rc2.333.gb2668
