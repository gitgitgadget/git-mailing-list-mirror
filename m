From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: [PATCH] docs: add filter-branch note about The BFG
Date: Tue, 17 Dec 2013 10:53:19 +0000
Message-ID: <1387277599-69719-1-git-send-email-roberto.tyley@gmail.com>
Cc: peff@peff.net, tr@thomasrast.ch,
	Roberto Tyley <roberto.tyley@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 17 11:53:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VssHZ-0001LD-GD
	for gcvg-git-2@plane.gmane.org; Tue, 17 Dec 2013 11:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab3LQKxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Dec 2013 05:53:42 -0500
Received: from mail-wg0-f48.google.com ([74.125.82.48]:44365 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751410Ab3LQKxl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Dec 2013 05:53:41 -0500
Received: by mail-wg0-f48.google.com with SMTP id z12so5767467wgg.15
        for <git@vger.kernel.org>; Tue, 17 Dec 2013 02:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3Ssf3ZAt37K4YpZx/Fw+dXjxFcwTF239X7gCwnzFVdw=;
        b=sdI0k4n/v+G1f09nynhwwFgcfB9NWiwUOXNaMTMiisE/E1o9h8XzXj9sLmMle9ruLy
         ZwRX/jnPJf/jZ8cKJFJ6IgzizMPqEXNr0D7wEShK+NHmt9/PXJ5ay0R5HfdRT4JpC56R
         PSrICu9C8A06FVMHpSWd/Ycd0WS9J4JN2qbLO1fv/YvdRTR9Vh2rZz7fK29IgEP8ELPm
         Dx4/L9MQYFxSqj/Psbn+H1F0GjM1XO4Mkv/+Vcied58953xqY9wbL6hBA0dSL9z7F0A8
         DnMWHyHT3pIlDB/VrAlvWE55vbmqn4ntpHcWzimfqMiESKzCA5Y7dXUHoyeB6CXZZfeT
         ltqw==
X-Received: by 10.195.18.34 with SMTP id gj2mr7442969wjd.82.1387277619645;
        Tue, 17 Dec 2013 02:53:39 -0800 (PST)
Received: from localhost.localdomain (nat-123-249.guardian.co.uk. [77.91.249.123])
        by mx.google.com with ESMTPSA id s2sm33915754wiy.7.2013.12.17.02.53.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 17 Dec 2013 02:53:38 -0800 (PST)
X-Mailer: git-send-email 1.8.3.4 (Apple Git-47)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239378>

The BFG is a tool specifically designed for the task of removing
unwanted data from Git repository history - a common use-case for which
git-filter-branch has been the traditional workhorse.

It's beneficial to let users know that filter-branch has an alternative
here:

* speed : The BFG is 10-50x faster
  http://rtyley.github.io/bfg-repo-cleaner/#speed
* complexity of configuration : filter-branch is a very flexible tool,
  but demands very careful usage in order to get the desired results
  http://rtyley.github.io/bfg-repo-cleaner/#examples

Obviously, filter-branch has it's advantages too - it permits very
complex rewrites, and doesn't require a JVM - but for the common
use-case of deleting unwanted data, it's helpful to users to be aware
that an alternative exists.

The BFG was released under the GPL in February 2013, and has since seen
widespread production use (The Guardian, RedHat, Google, UK Government
Digital Service), been tested against large repos (~300K commits, ~5GB
packfiles) and received significant positive feedback from users:

http://rtyley.github.io/bfg-repo-cleaner/#feedback

Signed-off-by: Roberto Tyley <roberto.tyley@gmail.com>
---
 Documentation/git-filter-branch.txt | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index e4c8e82..918e965 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -18,6 +18,12 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
+
+NOTE: For simply removing unwanted data from repository history, you may
+want to use link:http://rtyley.github.io/bfg-repo-cleaner/[The BFG Repo-Cleaner]
+instead - it's generally faster and simpler for eliminating large files
+or private data.
+
 Lets you rewrite Git revision history by rewriting the branches mentioned
 in the <rev-list options>, applying custom filters on each revision.
 Those filters can modify each tree (e.g. removing a file or running
@@ -393,7 +399,7 @@ git filter-branch --index-filter \
 Checklist for Shrinking a Repository
 ------------------------------------
 
-git-filter-branch is often used to get rid of a subset of files,
+git-filter-branch can be used to get rid of a subset of files,
 usually with some combination of `--index-filter` and
 `--subdirectory-filter`.  People expect the resulting repository to
 be smaller than the original, but you need a few more steps to
@@ -429,6 +435,12 @@ warned.
   (or if your git-gc is not new enough to support arguments to
   `--prune`, use `git repack -ad; git prune` instead).
 
+SEE ALSO
+--------
+link:http://rtyley.github.io/bfg-repo-cleaner/[The BFG Repo-Cleaner]
+- a tool specifically designed for removing unwanted data from Git
+repository history.
+
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
1.8.3.4 (Apple Git-47)
