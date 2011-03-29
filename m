From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-notes.txt: clarify -C vs. copy and -F
Date: Tue, 29 Mar 2011 10:45:03 +0200
Message-ID: <09668994f10284cfa5243789a627dce8c2325bc6.1301388217.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 10:48:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4UbZ-0005m3-VV
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 10:48:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448Ab1C2Iso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 04:48:44 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:37668 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751164Ab1C2Isn (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2011 04:48:43 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3918820CCA;
	Tue, 29 Mar 2011 04:48:43 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 29 Mar 2011 04:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id; s=smtpout; bh=o+P4p/A+nLe+JSfRCmuWhEBjDig=; b=tu3w728YmjSDrAZFTUSooX9lgOEeWEfE+exfvPMsjIvFD3lTnGO/Pc+nm522U9mwvrQSP2vgf8t4Y4bNlcR2wwnP7ZxnsWLwKzxR51fKcW3W73+Qxk/4PL/dPQRGEYCQXkdbziV5FQZzypfR/99xIAHrJBrQdSNVmduoHGf7coc=
X-Sasl-enc: Qw48X4pRJm7lLLIC3kx0hES6qMqGHWnCC76MbA49NAQF 1301388522
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id B069A404DB8;
	Tue, 29 Mar 2011 04:48:42 -0400 (EDT)
X-Mailer: git-send-email 1.7.4.1.607.g888da
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170246>

The current description of '-C' together with the analogy to 'git commit
-C' can lead to the wrong conclusion that '-C' copies notes between
objects. Make this clearer by rewording and pointing to 'copy'.

The example for attaching binary notes with 'git hash-object' followed
by 'git notes add -C' immediately raises the question: "Why not use 'git
notes add -F'?". Answer it (the latter is not binary-safe).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
In fact, the long name '--reuse-message' is really misleading, but I've been
around long enough to refrain from trying to change it ;)

 Documentation/git-notes.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 296f314..c63b593 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -138,8 +138,9 @@ OPTIONS
 
 -C <object>::
 --reuse-message=<object>::
-	Take the note message from the given blob object (for
-	example, another note).
+	Take the given blob object (for	example, another note) as the
+	note message. (Use `git notes copy <object>` instead to
+	copy notes between objects.) 
 
 -c <object>::
 --reedit-message=<object>::
@@ -272,6 +273,8 @@ $ blob=$(git hash-object -w a.out)
 $ git notes --ref=built add -C "$blob" HEAD
 ------------
 
+(You cannot simply use `git notes --ref=built add -F a.out HEAD`
+because that is not binary-safe.)
 Of course, it doesn't make much sense to display non-text-format notes
 with 'git log', so if you use such notes, you'll probably need to write
 some special-purpose tools to do something useful with them.
-- 
1.7.4.1.607.g888da
