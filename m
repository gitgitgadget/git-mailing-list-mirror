From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] Documentation/SubmittingPatches: clarify GMail section and SMTP
Date: Tue, 25 May 2010 10:30:13 +0200
Message-ID: <40abcf5e5337f974e70a7b0bd6279a630b35ce19.1274776132.git.git@drmicha.warpmail.net>
References: <20100525072240.GA20408@coredump.intra.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 25 10:30:42 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OGpX3-0000vv-3g
	for gcvg-git-2@lo.gmane.org; Tue, 25 May 2010 10:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755911Ab0EYIaa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 May 2010 04:30:30 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:46950 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754707Ab0EYIa3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 May 2010 04:30:29 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id EC30EF82C5;
	Tue, 25 May 2010 04:30:26 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 25 May 2010 04:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references; s=smtpout; bh=C1GzQ5nEsxNzuDdLpZBlWN9YXZM=; b=ErNg48ZExQ+U6iQrWScNa9j4KG+5v4ECzoz1sX+/nNH1R1MZq8hrZWgcKPzhmy3KxF21ufFz4Uafog+XzUhXkxMgZ7pSHDVjFRVCTicWtjUMGIbf+vPefVDv+dNF0CaiBxIeQ26qhMs+qVFVTmPGZc6jON4DOajLcmHqa3RUujc=
X-Sasl-enc: ibwNpPvA6pKEaMw7SUAShIIQRzz+C05i0xc+lOywt2YA 1274776226
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 47AB14E2B3F;
	Tue, 25 May 2010 04:30:26 -0400 (EDT)
X-Mailer: git-send-email 1.7.1.342.g1c280
In-Reply-To: <20100525072240.GA20408@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147683>

We keep getting mangled submissions from GMail's web interface. Try to
be more proactive in SubmittingPatches by

- pointing to MUA specific instructions early on,
- structuring the GMail section more clearly,
- putting send-email/SMTP before imap-send/IMAP.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/SubmittingPatches |   40 ++++++++++++++++++++------------------
 1 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 8db22ef..b9204c7 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -41,6 +41,7 @@ Checklist (and a short version for the impatient):
 	  maintainer (gitster@pobox.com) if (and only if) the patch
 	  is ready for inclusion. If you use git-send-email(1),
 	  please test it first by sending email to yourself.
+	- see below for instructions specific to your mailer
 
 Long version:
 
@@ -546,9 +547,27 @@ Gmail
 
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
 
@@ -564,8 +583,7 @@ You might need to instead use: folder = "[Google Mail]/Drafts" if you get an err
 that the "Folder doesn't exist".
 
 Once your commits are ready to be sent to the mailing list, run the
-following command to send the patch emails to your Gmail Drafts
-folder.
+following commands:
 
   $ git format-patch --cover-letter -M --stdout origin/master | git imap-send
 
@@ -573,19 +591,3 @@ Just make sure to disable line wrapping in the email client (GMail web
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
1.7.1.342.g1c280
