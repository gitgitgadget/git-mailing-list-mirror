From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv3 05/11] log: document use of multiple commit limiting options
Date: Fri, 14 Sep 2012 11:46:37 +0200
Message-ID: <b7958362b037c298344a03f2657456b3809c3239.1347615361.git.git@drmicha.warpmail.net>
References: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 14 11:47:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCSUe-0007Hv-AF
	for gcvg-git-2@plane.gmane.org; Fri, 14 Sep 2012 11:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754480Ab2INJq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Sep 2012 05:46:56 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60396 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754118Ab2INJqx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Sep 2012 05:46:53 -0400
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5002C209D9;
	Fri, 14 Sep 2012 05:46:53 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute5.internal (MEProxy); Fri, 14 Sep 2012 05:46:53 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Iq
	IN8XwNu8mMPaFupP1gRhouf1c=; b=qw3cPfGDiiS2u7jJY13QQis9VgtjEzY/ra
	F+g7lNTOeNFxK1dy/MtLFKAIS0ng05CjkOsujZEIQXDdTkbePY0GiOjfDqMiaz7J
	PJRy0ndSVsq/IjkLACSuyz++4w1uJhD7z/RHvaT9zXERq1Uk+8JEUjeiH0d39xVs
	Ccb9gTY40=
X-Sasl-enc: /UuJvlviVam0wuCDHu5y057fTSFobxiialvJ4u/6Q9Zq 1347616012
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E484F8E03DA;
	Fri, 14 Sep 2012 05:46:52 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.592.g41e7905
In-Reply-To: <7vfw6l9x7i.fsf@alter.siamese.dyndns.org>
In-Reply-To: <cover.1347615361.git.git@drmicha.warpmail.net>
References: <cover.1347615361.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205472>

From: Junio C Hamano <gitster@pobox.com>

Generally speaking, using more options will further narrow the
selection, but there are a few exceptions.  Document them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 Documentation/rev-list-options.txt | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 1ae3c89..57d6c90 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -3,7 +3,14 @@ Commit Limiting
 
 Besides specifying a range of commits that should be listed using the
 special notations explained in the description, additional commit
-limiting may be applied. Note that they are applied before commit
+limiting may be applied.
+
+Using more options generally further limits the output (e.g.
+"--since=<date1>" limits to commits newer than <date1>, and using it
+with "--grep=<pattern>" further limits to commits whose log message
+has a line that match <pattern>), unless otherwise noted.
+
+Note that these are applied before commit
 ordering and formatting options, such as '--reverse'.
 
 --
@@ -38,16 +45,22 @@ endif::git-rev-list[]
 --committer=<pattern>::
 
 	Limit the commits output to ones with author/committer
-	header lines that match the specified pattern (regular expression).
+	header lines that match the specified pattern (regular
+	expression).  With more than one `--author=<pattern>`,
+	commits whose author match any of the given patterns are
+	chosen (similarly for multiple `--committer=<pattern>`).
 
 --grep=<pattern>::
 
 	Limit the commits output to ones with log message that
-	matches the specified pattern (regular expression).
+	matches the specified pattern (regular expression).  With
+	more than one `--grep=<pattern>`, commits whose message
+	match any of the given patterns are chosen (but see
+	`--all-match`).
 
 --all-match::
 	Limit the commits output to ones that match all given --grep,
-	--author and --committer instead of ones that match at least one.
+	instead of ones that match at least one.
 
 -i::
 --regexp-ignore-case::
-- 
1.7.12.592.g41e7905
