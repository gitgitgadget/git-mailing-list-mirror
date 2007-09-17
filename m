From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/8] git-gc --auto: add documentation.
Date: Mon, 17 Sep 2007 01:44:51 -0700
Message-ID: <11900187073420-git-send-email-gitster@pobox.com>
References: <11900186941912-git-send-email-gitster@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 10:45:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXCER-00089U-HN
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 10:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756791AbXIQIpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 04:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756910AbXIQIpO
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 04:45:14 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55320 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755849AbXIQIpL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 04:45:11 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A0B601368AD;
	Mon, 17 Sep 2007 04:45:30 -0400 (EDT)
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
In-Reply-To: <11900186941912-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58398>

This documents the auto-packing of loose objects performed by
git-gc --auto.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config.txt |    7 +++++++
 Documentation/git-gc.txt |   11 ++++++++++-
 2 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 866e053..3643c0b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -439,6 +439,13 @@ gc.aggressiveWindow::
 	algorithm used by 'git gc --aggressive'.  This defaults
 	to 10.
 
+gc.auto::
+	When there are approximately more than this many loose
+	objects in the repository, `git gc --auto` that is
+	invoked by some Porcelain commands will create a new
+	pack and prune them.  Setting this to 0 disables the
+	auto garbage collection.
+
 gc.packrefs::
 	`git gc` does not run `git pack-refs` in a bare repository by
 	default so that older dumb-transport clients can still fetch
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index c7742ca..40c1ce4 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -8,7 +8,7 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 
 SYNOPSIS
 --------
-'git-gc' [--prune] [--aggressive]
+'git-gc' [--prune] [--aggressive] [--auto]
 
 DESCRIPTION
 -----------
@@ -43,6 +43,15 @@ OPTIONS
 	persistent, so this option only needs to be used occasionally; every
 	few hundred changesets or so.
 
+--auto::
+	With this option, `git gc` checks if there are too many
+	loose objects in the repository and runs
+	gitlink:git-repack[1] with `-d -l` option to pack them.
+	The threshold is set with `gc.auto` configuration
+	variable, and can be disabled by setting it to 0.  Some
+	Porcelain commands use this after they perform operation
+	that could create many loose objects automatically.
+
 Configuration
 -------------
 
-- 
1.5.3.1.967.g6bb01
