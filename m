From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 1/2] pack-objects: document --delta-base-offset option
Date: Thu, 12 Oct 2006 22:35:00 -0700
Message-ID: <11607177011745-git-send-email-junkio@cox.net>
Cc: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Oct 13 07:35:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYFhZ-00035j-8p
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 07:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbWJMFfO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 01:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWJMFfN
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 01:35:13 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:17114 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750964AbWJMFfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 01:35:07 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061013053502.BKMT16798.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Fri, 13 Oct 2006 01:35:02 -0400
Received: from localhost.localdomain ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Zhb41V0141kojtg0000000
	Fri, 13 Oct 2006 01:35:05 -0400
To: GIT Mailing List <git@vger.kernel.org>
X-Mailer: git-send-email 1.4.3.rc2.g51ca
Date: Tue, 10 Oct 2006 01:06:20 -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28828>

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-pack-objects.txt |   13 ++++++++++++-
 builtin-pack-objects.c             |    2 +-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index d4661dd..5788709 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -9,7 +9,7 @@ git-pack-objects - Create a packed archi
 SYNOPSIS
 --------
 [verse]
-'git-pack-objects' [-q] [--no-reuse-delta] [--non-empty]
+'git-pack-objects' [-q] [--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=N] [--depth=N]
 	[--revs [--unpacked | --all]*] [--stdout | base-name] < object-list
 
@@ -110,6 +110,17 @@ base-name::
 	This flag tells the command not to reuse existing deltas
 	but compute them from scratch.
 
+--delta-base-offset::
+	A packed archive can express base object of a delta as
+	either 20-byte object name or as an offset in the
+	stream, but older version of git does not understand the
+	latter.  By default, git-pack-objects only uses the
+	former format for better compatibility.  This option
+	allows the command to use the latter format for
+	compactness.  Depending on the average delta chain
+	length, this option typically shrinks the resulting
+	packfile by 3-5 per-cent.
+
 
 Author
 ------
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index ee5f031..41e1e74 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -15,7 +15,7 @@ #include "list-objects.h"
 #include <sys/time.h>
 #include <signal.h>
 
-static const char pack_usage[] = "git-pack-objects [-q] [--no-reuse-delta] [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] [--revs [--unpacked | --all]*] [--stdout | base-name] <ref-list | <object-list]";
+static const char pack_usage[] = "git-pack-objects [-q] [--no-reuse-delta] [--delta-base-offset] [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] [--revs [--unpacked | --all]*] [--stdout | base-name] <ref-list | <object-list]";
 
 struct object_entry {
 	unsigned char sha1[20];
-- 
1.4.3.rc2.g51ca
