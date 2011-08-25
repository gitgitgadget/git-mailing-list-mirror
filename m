From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] git-notes.txt: clarify -C vs. copy and -F
Date: Thu, 25 Aug 2011 12:26:37 +0200
Message-ID: <0b124a705cf63d7c531a3a097a158dbaeaf6d298.1314267281.git.git@drmicha.warpmail.net>
References: <7v1v1pr97x.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 12:26:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwX94-0001Jm-1L
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 12:26:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326Ab1HYK0k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Aug 2011 06:26:40 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:60951 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751049Ab1HYK0k (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2011 06:26:40 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 8E76F205AB;
	Thu, 25 Aug 2011 06:26:39 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute4.internal (MEProxy); Thu, 25 Aug 2011 06:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references; s=smtpout; bh=2c10Q4OJEbBYDTZi1oppM9dSb
	ZE=; b=hFuUsV0JIAxZHP+LpBsK9JTY9snpuJfUfUG9qbGANY5plUBRKA3toFV0S
	YDo2i0yJsvGoO9SI42DFN6jLLeRoybP1UVeRbxSj/bu5NhFxX773yrdbTWq9Bw53
	Zwc4duFnNNRJtEXjwxJzct0gM9uQjG0qxVfNzO+Q0j6arhlpNQ=
X-Sasl-enc: Si5+gWW7K21QJICvAFI3rk4B40Pfo4PQLdFI6OvaRDP5 1314267999
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1203E920154;
	Thu, 25 Aug 2011 06:26:38 -0400 (EDT)
X-Mailer: git-send-email 1.7.6.845.gc3c05
In-Reply-To: <7v1v1pr97x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180074>

The current description of '-C' together with the analogy to 'git commit
-C' can lead to the wrong conclusion that '-C' copies notes between
objects. Make this clearer by rewording and pointing to 'copy'.

The example for attaching binary notes with 'git hash-object' followed
by 'git notes add -C' immediately raises the question: "Why not use 'git
notes add -F'?". Answer it (the latter is not binary-safe).

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
This one has been lying around and fell under the rugs of the discussion
for a ui redesign which never happened. So I think it's still worth it.
---
 Documentation/git-notes.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 6a187f2..e8319ea 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -142,8 +142,9 @@ OPTIONS
 
 -C <object>::
 --reuse-message=<object>::
-	Take the note message from the given blob object (for
-	example, another note).
+	Take the given blob object (for	example, another note) as the
+	note message. (Use `git notes copy <object>` instead to
+	copy notes between objects.)
 
 -c <object>::
 --reedit-message=<object>::
@@ -285,6 +286,8 @@ $ blob=$(git hash-object -w a.out)
 $ git notes --ref=built add -C "$blob" HEAD
 ------------
 
+(You cannot simply use `git notes --ref=built add -F a.out HEAD`
+because that is not binary-safe.)
 Of course, it doesn't make much sense to display non-text-format notes
 with 'git log', so if you use such notes, you'll probably need to write
 some special-purpose tools to do something useful with them.
-- 
1.7.6.845.gc3c05
