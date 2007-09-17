From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 5/8] git-gc --auto: add documentation.
Date: Mon, 17 Sep 2007 01:27:10 -0700
Message-ID: <11900176353572-git-send-email-gitster@pobox.com>
References: <1190017633436-git-send-email-gitster@pobox.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 17 11:43:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXD8b-0006vM-G3
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 11:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754003AbXIQJnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 05:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753927AbXIQJnP
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 05:43:15 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42683 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905AbXIQJnM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 05:43:12 -0400
X-Greylist: delayed 4537 seconds by postgrey-1.27 at vger.kernel.org; Mon, 17 Sep 2007 05:42:51 EDT
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070917082715.EPYQ11237.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 17 Sep 2007 04:27:15 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo02.cox.net with bizsmtp
	id pLTF1X00E1gtr5g0000000; Mon, 17 Sep 2007 04:27:15 -0400
X-Mailer: git-send-email 1.5.3.1.967.g6bb01
In-Reply-To: <1190017633436-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58420>

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
