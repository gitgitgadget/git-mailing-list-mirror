From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 09/11] Document git read-tree --trivial
Date: Sat, 16 Jun 2007 21:03:45 +0200
Message-ID: <1182020635187-git-send-email-jnareb@gmail.com>
References: <11820206272990-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 16 20:58:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzdU5-0007JN-2P
	for gcvg-git@gmane.org; Sat, 16 Jun 2007 20:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbXFPS62 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 14:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754046AbXFPS61
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 14:58:27 -0400
Received: from mu-out-0910.google.com ([209.85.134.187]:13023 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753946AbXFPS6P (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 14:58:15 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1608082mue
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 11:58:14 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZiUABsCWoUK6WnY0HXWG15SNam3ZUqOa1Gx6v9p6iBQx81icW/u0urXu3J5x7bya/Ypp7+W5haUKGzZInisUzac9TZQYRv1k7omMlhfiOexVVv3GJDUmJhoBqVJnczVmhHUEUYHBb4JUVp4riehqUD5usoAV6J2oiT43xPoxJ/U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=K6xFOqwj0KkVSzFQJyp1mABQP5IJOJcX91hy4w5ymzUuMqprmHMKkuRlyiAo3bpM+ZQMiJYOcTikzshPrLjFPM+XubHnJ/Q15o+WvymCN8fPFbea4iv90WtJGxxQTWOhfWwxHyTuGT+hhViJg//N7V7Eul5Ah17D8b/Xh9hDGv8=
Received: by 10.82.108.9 with SMTP id g9mr8133132buc.1182020294561;
        Sat, 16 Jun 2007 11:58:14 -0700 (PDT)
Received: from roke.D-201 ( [89.229.25.173])
        by mx.google.com with ESMTP id d24sm6237862nfh.2007.06.16.11.58.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 11:58:13 -0700 (PDT)
Received: from roke.D-201 (localhost.localdomain [127.0.0.1])
	by roke.D-201 (8.13.4/8.13.4) with ESMTP id l5GJ3tip004258;
	Sat, 16 Jun 2007 21:03:55 +0200
Received: (from jnareb@localhost)
	by roke.D-201 (8.13.4/8.13.4/Submit) id l5GJ3t0M004257;
	Sat, 16 Jun 2007 21:03:55 +0200
X-Mailer: git-send-email 1.5.2
In-Reply-To: <11820206272990-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50300>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-read-tree.txt |    8 +++++++-
 builtin-read-tree.c             |    2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index 84184d6..74c5478 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -8,7 +8,7 @@ git-read-tree - Reads tree information into the index
 
 SYNOPSIS
 --------
-'git-read-tree' (<tree-ish> | [[-m [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]])
+'git-read-tree' (<tree-ish> | [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <tree-ish1> [<tree-ish2> [<tree-ish3>]])
 
 
 DESCRIPTION
@@ -50,6 +50,12 @@ OPTIONS
 	trees that are not directly related to the current
 	working tree status into a temporary index file.
 
+--trivial::
+	Restrict three-way merge by `git-read-tree` to happen
+	only if there is no file-level merging required, instead
+	of resolving merge for trivial cases and leaving
+	conflicting files unresolved in the index.
+
 --aggressive::
 	Usually a three-way merge by `git-read-tree` resolves
 	the merge for really trivial cases and leaves other
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index 316fb0f..41f8110 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -84,7 +84,7 @@ static void prime_cache_tree(void)
 
 }
 
-static const char read_tree_usage[] = "git-read-tree (<sha> | [[-m [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <sha1> [<sha2> [<sha3>]])";
+static const char read_tree_usage[] = "git-read-tree (<sha> | [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>] [-u | -i]] [--exclude-per-directory=<gitignore>] [--index-output=<file>] <sha1> [<sha2> [<sha3>]])";
 
 static struct lock_file lock_file;
 
-- 
1.5.2
