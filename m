From: Pieter de Bie <pdebie@ai.rug.nl>
Subject: [PATCH] git-send-email: allow whitespace in addressee list
Date: Sat,  7 Jun 2008 15:34:36 +0200
Message-ID: <1212845676-80100-1-git-send-email-pdebie@ai.rug.nl>
Cc: Pieter de Bie <pdebie@ai.rug.nl>
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 07 15:35:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4ya4-0001fU-2h
	for gcvg-git-2@gmane.org; Sat, 07 Jun 2008 15:35:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754473AbYFGNei (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2008 09:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755677AbYFGNei
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Jun 2008 09:34:38 -0400
Received: from smtp-3.orange.nl ([193.252.22.243]:17992 "EHLO smtp-3.orange.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754310AbYFGNei (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2008 09:34:38 -0400
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6204.orange.nl (SMTP Server) with ESMTP id 482401C0008A;
	Sat,  7 Jun 2008 15:34:37 +0200 (CEST)
Received: from localhost.localdomain (s5591931c.adsl.wanadoo.nl [85.145.147.28])
	by mwinf6204.orange.nl (SMTP Server) with ESMTP id DD2D21C00082;
	Sat,  7 Jun 2008 15:34:36 +0200 (CEST)
X-ME-UUID: 20080607133436906.DD2D21C00082@mwinf6204.orange.nl
X-Mailer: git-send-email 1.5.6.rc0.165.ge08d6b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84202>

When interactively supplying addresses to send an email to with send-email,
whitespace after the separation comma (as in 'list, jc') wasn't ignored. This
meant that resolving of the alias ' jc' would fail, sending an email only to
list. With this patch, the optional trailing whitespace is ignored.

Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
---

This has been bothering me for a while now :)

 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index a598fdc..e53350a 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -441,7 +441,7 @@ if (!@to) {
 	}
 
 	my $to = $_;
-	push @to, split /,/, $to;
+	push @to, split /,\s*/, $to;
 	$prompting++;
 }
 
-- 
1.5.6.rc0.165.ge08d6b.dirty
