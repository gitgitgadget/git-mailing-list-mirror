From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH 4/4] switch cg-commit -N to use --missing-ok instead of --no-check
Date: Sun, 10 Jul 2005 23:53:55 -0400
Message-ID: <20050711035349.22229.2989.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050711035305.22229.87752.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: junkio@cox.net, torvalds@osdl.org,
	Bryan Larsen <bryanlarsen@yahoo.com>, pasky@suse.cz,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 11 05:54:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DrpMm-0008Fz-FG
	for gcvg-git@gmane.org; Mon, 11 Jul 2005 05:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262220AbVGKDx4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jul 2005 23:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262221AbVGKDx4
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jul 2005 23:53:56 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:28596 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262220AbVGKDxz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jul 2005 23:53:55 -0400
Received: (qmail 39588 invoked from network); 11 Jul 2005 03:53:55 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=aTpV8I49ewzOFs1BtuYen6RBlvHoz2CRrnt7lh7knovllSOqbu/Pxr3cOzdLtocOJKpvFN2zncjwMMjak9YrF7NTcC3ug0HGXPUI/CwHr/Pqa3aWNaUDiaimNg6m/VMY4iIerbQguqZ5ZPmE9CtI77rvlGIuPnoKnNQ1YSSir0I=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@70.26.43.137 with plain)
  by smtp107.mail.sc5.yahoo.com with SMTP; 11 Jul 2005 03:53:54 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050711035305.22229.87752.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Make cg-commit aware of the rename of git-write-tree --no-check to --missing-ok.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -111,13 +111,13 @@ forceeditor=
 ignorecache=
 infoonly=
 commitalways=
-nocheck=
+missingok=
 msgs=()
 while optparse; do
 	if optparse -C; then
 		ignorecache=1
 	elif optparse -N; then
-		nocheck=--no-check
+		missingok=--missing-ok
 		infoonly=--info-only
 	elif optparse -e; then
 		forceeditor=1
@@ -311,7 +311,7 @@ if [ -s "$_git/HEAD" ]; then
 	oldheadstr="-p $oldhead"
 fi
 
-treeid=$(git-write-tree ${nocheck})
+treeid=$(git-write-tree ${missingok})
 [ "$treeid" ] || die "git-write-tree failed"
 if [ ! "$force" ] && [ ! "$merging" ] && [ "$oldhead" ] &&
    [ "$treeid" = "$(tree-id)" ]; then
