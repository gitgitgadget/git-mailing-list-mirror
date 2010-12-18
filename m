From: Mark Lodato <lodatom@gmail.com>
Subject: [PATCH 3/8] docs: use <sha1> to mean unabbreviated ID
Date: Sat, 18 Dec 2010 00:38:40 -0500
Message-ID: <1292650725-21149-4-git-send-email-lodatom@gmail.com>
References: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Mark Lodato <lodatom@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 18 06:39:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTpVw-0006oi-0z
	for gcvg-git-2@lo.gmane.org; Sat, 18 Dec 2010 06:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751999Ab0LRFjK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Dec 2010 00:39:10 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48114 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751846Ab0LRFjD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Dec 2010 00:39:03 -0500
Received: by mail-qy0-f181.google.com with SMTP id 12so1529959qyk.19
        for <git@vger.kernel.org>; Fri, 17 Dec 2010 21:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=VWkarQSGz7JZ5VJvaF0j6/xSm/K9lvwpD8S38mxs37E=;
        b=HpDRukJ0ljfvwiCgs1SkXvgaCeCU/x14alIyRI6sQ/JyfKKkLj7V1J7a/EtAoQNmho
         Mn0gi6MX9TRQtlOVIo1LnAQxT91+G1uPJHuN/wkPBdYCPHe5FLtKNuAqgjIVeUfBbuAy
         aDt7h2Lbgo6JY1317A3VXaYrOULzPJJ7R+MUM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Jgq0H7jzyotGJi5kA/si9dl370OHhEGTc8fif7/c3RzQcdPw2CR7NDNhnB/iTtdmSX
         wvhMxSTcxvjUftCCa0beNfiGG7qpcmMCKz/ovbhRRkanABdwPdgFCN5M8nhDBGTqd+Do
         YYKIvk/bYCLB7TnK+3BfcTRVY7R8bzwHkmruI=
Received: by 10.229.95.19 with SMTP id b19mr1553671qcn.179.1292650742939;
        Fri, 17 Dec 2010 21:39:02 -0800 (PST)
Received: from localhost.localdomain (c-68-49-150-7.hsd1.dc.comcast.net [68.49.150.7])
        by mx.google.com with ESMTPS id n7sm683569qcu.28.2010.12.17.21.39.01
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 17 Dec 2010 21:39:02 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2
In-Reply-To: <1292650725-21149-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163898>

There are some places that literally require a full, 40-character SHA-1
ID, rather than a generic revision specifier.  Introduce in git(1) the
<sha1> terminology to mean this.  Use <sha1> in git-diff-tree(1) to note
that --stdin only takes <sha1>s, not generic <tree>s or <commit>s.
Use <tree> and <commit> in the usage statement for 'commit-tree'.

Signed-off-by: Mark Lodato <lodatom@gmail.com>
---
 Documentation/git-diff-tree.txt |    4 ++--
 Documentation/git.txt           |    5 +++++
 builtin/commit-tree.c           |    2 +-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index a7e37b8..6b357a5 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -49,8 +49,8 @@ include::diff-options.txt[]
 --stdin::
 	When '--stdin' is specified, the command does not take
 	<tree-ish> arguments from the command line.  Instead, it
-	reads lines containing either two <tree>, one <commit>, or a
-	list of <commit> from its standard input.  (Use a single space
+	reads lines containing <sha1>s: either two trees, one commit, or
+	multiple commits from its standard input.  (Use a single space
 	as separator.)
 +
 When two trees are given, it compares the first tree with the second.
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 0128371..7929739 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -457,6 +457,11 @@ list.
 
 Identifier Terminology
 ----------------------
+<sha1>::
+	Indicates a full, 40-character SHA-1 identifier of an object.
+	The type of the referenced object is unspecified.
+	Abbreviated or symbolic identifiers cannot be used.
+
 <object>::
 	Indicates the object name for any type of object.
 
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index d083795..da572c3 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -9,7 +9,7 @@
 #include "builtin.h"
 #include "utf8.h"
 
-static const char commit_tree_usage[] = "git commit-tree <sha1> [(-p <sha1>)...] < changelog";
+static const char commit_tree_usage[] = "git commit-tree <tree> [(-p <commit>)...] < changelog";
 
 static void new_parent(struct commit *parent, struct commit_list **parents_p)
 {
-- 
1.7.3.2
