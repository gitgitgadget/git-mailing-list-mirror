X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: [PATCH] Documentation: Define symref and update HEAD description
Date: Sat, 18 Nov 2006 20:44:08 +0100
Message-ID: <20061118194408.27106.65771.stgit@machine.or.cz>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
NNTP-Posting-Date: Sat, 18 Nov 2006 19:44:21 +0000 (UTC)
Cc: <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: StGIT/0.11
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31796>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlW6o-0002c7-83 for gcvg-git@gmane.org; Sat, 18 Nov
 2006 20:44:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756406AbWKRToL (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 14:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756407AbWKRToL
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 14:44:11 -0500
Received: from w241.dkm.cz ([62.24.88.241]:50867 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1756405AbWKRToK (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 14:44:10 -0500
Received: (qmail 27116 invoked from network); 18 Nov 2006 20:44:08 +0100
Received: from localhost (HELO machine.or.cz) (xpasky@127.0.0.1) by localhost
 with SMTP; 18 Nov 2006 20:44:08 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

HEAD was still described as a symlink instead of a symref.

Signed-off-by: Petr Baudis <pasky@suse.cz>
---

 Documentation/glossary.txt          |    7 +++++++
 Documentation/repository-layout.txt |   14 +++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 7e560b0..894883d 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -282,6 +282,13 @@ SCM::
 SHA1::
 	Synonym for object name.
 
+symref::
+	Symbolic reference: instead of containing the SHA1 id itself, it
+	is of the format 'ref: refs/some/thing' and when referenced, it
+	recursively dereferences to this reference. 'HEAD' is a prime
+	example of a symref. Symbolic references are manipulated with
+	the gitlink:git-symbolic-ref[1] command.
+
 topic branch::
 	A regular git branch that is used by a developer to
 	identify a conceptual line of development.  Since branches
diff --git a/Documentation/repository-layout.txt b/Documentation/repository-layout.txt
index 275d18b..fd9f406 100644
--- a/Documentation/repository-layout.txt
+++ b/Documentation/repository-layout.txt
@@ -70,12 +70,16 @@ refs/tags/`name`::
 	object, or a tag object that points at a commit object).
 
 HEAD::
-	A symlink of the form `refs/heads/'name'` to point at
-	the current branch, if exists.  It does not mean much if
-	the repository is not associated with any working tree
+	A symref (see glossary) to the `refs/heads/` namespace
+	describing the currently active branch.  It does not mean
+	much if the repository is not associated with any working tree
 	(i.e. a 'bare' repository), but a valid git repository
-	*must* have such a symlink here.  It is legal if the
-	named branch 'name' does not (yet) exist.
+	*must* have the HEAD file; some porcelains may use it to
+	guess the designated "default" branch of the repository
+	(usually 'master').  It is legal if the named branch
+	'name' does not (yet) exist.  In some legacy setups, it is
+	a symbolic link instead of a symref, but this has been
+	deprecated long ago.
 
 branches::
