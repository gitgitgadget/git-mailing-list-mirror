From: Avery Pennarun <apenwarr@gmail.com>
Subject: [PATCH 3/3] Update documentation to describe git filter-branch --blob-filter.
Date: Wed, 23 Apr 2008 15:42:37 -0400
Message-ID: <1208979757-30860-3-git-send-email-apenwarr@gmail.com>
References: <>
 <1208979757-30860-1-git-send-email-apenwarr@gmail.com>
 <1208979757-30860-2-git-send-email-apenwarr@gmail.com>
Cc: Avery Pennarun <apenwarr@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 23 21:44:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Joksn-00067F-6i
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 21:43:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752761AbYDWTnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 15:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752566AbYDWTnJ
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 15:43:09 -0400
Received: from static-216-18-85-234.gtcust.grouptelecom.net ([216.18.85.234]:38967
	"EHLO mailhost.pwcorp.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751987AbYDWTnI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Apr 2008 15:43:08 -0400
Received: from weaver.open.versabanq.com ([10.65.1.2]) by mailhost.pwcorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 23 Apr 2008 15:42:39 -0400
Received: (qmail 12458 invoked from network); 23 Apr 2008 19:42:38 -0000
Received: from unknown (HELO weaver.open.versabanq.com) (10.65.1.2)
  by weaver.open.versabanq.com with SMTP; 23 Apr 2008 19:42:38 -0000
Received: (qmail 12418 invoked from network); 23 Apr 2008 19:42:37 -0000
Received: from unknown (HELO averyp-server.pwcorp.com) (10.65.1.129)
  by weaver.open.versabanq.com with SMTP; 23 Apr 2008 19:42:37 -0000
Received: by averyp-server.pwcorp.com (Postfix, from userid 1000)
	id 4B62D8C4C8; Wed, 23 Apr 2008 15:42:37 -0400 (EDT)
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <1208979757-30860-2-git-send-email-apenwarr@gmail.com>
X-OriginalArrivalTime: 23 Apr 2008 19:42:39.0422 (UTC) FILETIME=[304105E0:01C8A57A]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80251>

Signed-off-by: Avery Pennarun <apenwarr@gmail.com>
---
 Documentation/git-filter-branch.txt |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 2a78549..367f119 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 	[--index-filter <command>] [--parent-filter <command>]
 	[--msg-filter <command>] [--commit-filter <command>]
 	[--tag-name-filter <command>] [--subdirectory-filter <directory>]
+	[--blob-filter <command]
 	[--original <namespace>] [-d <directory>] [-f | --force]
 	[<rev-list options>...]
 
@@ -143,6 +144,15 @@ definition impossible to preserve signatures at any rate.)
 	The result will contain that directory (and only that) as its
 	project root.
 
+--blob-filter <command>::
+	This is the filter for modifying the contents of each file (blob)
+	in the tree.  The contents of a file are provided on stdin, and
+	the new file contents should be provided on stdout.  For efficiency,
+	the before/after results of a given blob are only calculated once
+	and then cached, so your filter must always return the same output
+	blob for any given input blob.  You might use this filter for
+	converting CRLF to LF in all your files, for example.
+
 --original <namespace>::
 	Use this option to set the namespace where the original commits
 	will be stored. The default value is 'refs/original'.
@@ -185,6 +195,13 @@ git filter-branch --index-filter 'git update-index --remove filename' HEAD
 
 Now, you will get the rewritten history saved in HEAD.
 
+To convert CRLF to LF in all your files using the "fromdos" program (be
+careful: this will attempt to modify binary files too!):
+
+----------------------------------------------
+git filter-branch --blob-filter 'fromdos' HEAD
+----------------------------------------------
+
 To set a commit (which typically is at the tip of another
 history) to be the parent of the current initial commit, in
 order to paste the other history behind the current history:
-- 
1.5.4.3
