X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] document the <tree ish> <file> blob reference syntax
Date: Wed, 25 Oct 2006 11:42:31 +0100
Message-ID: <38fafea491402334df335c486270ebe9@pinky>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 10:43:21 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30048>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcgE5-0001gd-L7 for gcvg-git@gmane.org; Wed, 25 Oct
 2006 12:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423245AbWJYKnK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 06:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423247AbWJYKnK
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 06:43:10 -0400
Received: from 85-210-250-36.dsl.pipex.com ([85.210.250.36]:30592 "EHLO
 localhost.localdomain") by vger.kernel.org with ESMTP id S1423245AbWJYKnI
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 06:43:08 -0400
Received: from apw by localhost.localdomain with local (Exim 4.63)
 (envelope-from <apw@shadowen.org>) id 1GcgDP-0003Z0-He; Wed, 25 Oct 2006
 11:42:31 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

It is possible to specify a specific file within a tree-ish
symbolically.  For example you can find the contents of
a specific file in a specific commit as below:

	git cat-file -p v1.2.4:git-prune.sh

Document this syntax in the Symbolic Identifiers section
of the main git documentation and reference it from
git-cat-file's documentation.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 5e9cbf8..9f2138d 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -19,7 +19,9 @@ or '-s' is used to find the object size.
 OPTIONS
 -------
 <object>::
-	The sha1 identifier of the object.
+	The sha1 identifier of the object or a symbolic object
+	reference.  See the Symbolic Identifiers section of the
+	main git manual page.
 
 -t::
 	Instead of the content, show the object type identified by
@@ -58,6 +60,18 @@ Otherwise the raw (though uncompressed) 
 be returned.
 
 
+EXAMPLES
+--------
+git cat-file -p c5a5d29aaacf753b70e715169cbb7f74f0193e4a::
+	Pretty print the object directly using an sha1, perhaps
+	from a git ls-tree output.
+
+git cat-file -p v1.2.4:git-prune.sh::
+	Output the file git-prune.sh from the branch or tag v1.2.4.
+	Note that where the name is ambigious a heads/ or tags/
+	prefix may be used to disambiguate the name.
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 7074e32..e9f99e2 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -565,6 +565,13 @@ HEAD::
 	a valid head 'name'
 	(i.e. the contents of `$GIT_DIR/refs/heads/<head>`).
 
+Some commands will also accept the following extended syntax:
+
+<tree-ish>:<file>::
+	indicating a specific blob for that file within the tree
+	object specified, which may also be symbolic.  For example
+	'v1.2.4:git-prune.sh'.
+
 
 File/Directory Structure
