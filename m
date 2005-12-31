From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] git-init-db(1): Describe --shared and the idempotent nature of init-db
Date: Sat, 31 Dec 2005 18:30:25 +0100
Message-ID: <20051231173025.GA30134@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 31 18:30:33 2005
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EskYq-0007NN-23
	for gcvg-git@gmane.org; Sat, 31 Dec 2005 18:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbVLaRa3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Dec 2005 12:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVLaRa3
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Dec 2005 12:30:29 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:19107 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S965031AbVLaRa2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Dec 2005 12:30:28 -0500
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id B4D5152D152;
	Sat, 31 Dec 2005 18:30:27 +0100 (CET)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31112-02; Sat, 31 Dec 2005 18:30:26 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 152C052D14D;
	Sat, 31 Dec 2005 18:30:26 +0100 (CET)
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id DFCA46DF89F; Sat, 31 Dec 2005 18:30:03 +0100 (CET)
Received: from brok.diku.dk (brok.diku.dk [130.225.96.163])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A02FC6DF88D; Sat, 31 Dec 2005 18:30:03 +0100 (CET)
Received: by brok.diku.dk (Postfix, from userid 3873)
	id 918DF61AC9; Sat, 31 Dec 2005 18:30:25 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14125>

Based on the recent discussion on the mailing list.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit dbad4968a3d1f518e5102a241196380ba0bcce75
tree f8f0d7ed79046ec316d26b0ba84034b571416533
parent 58e3fb40f7ca1c28f9105c15166884f80bb22e55
author Jonas Fonseca <fonseca@diku.dk> Sat, 31 Dec 2005 18:06:33 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Sat, 31 Dec 2005 18:06:33 +0100

 Documentation/git-init-db.txt |   16 ++++++++++++++--
 1 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 6deef92..9cf9499 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -8,7 +8,7 @@ git-init-db - Creates an empty git repos
 
 SYNOPSIS
 --------
-'git-init-db' [--template=<template_directory>]
+'git-init-db' [--template=<template_directory>] [--shared]
 
 
 OPTIONS
@@ -16,6 +16,9 @@ OPTIONS
 --template=<template_directory>::
 	Provide the directory in from which templates will be used.
 
+--shared::
+	Specify that the git repository is to be shared amongst several users.
+
 
 DESCRIPTION
 -----------
@@ -30,7 +33,16 @@ If the object storage directory is speci
 environment variable then the sha1 directories are created underneath -
 otherwise the default `$GIT_DIR/objects` directory is used.
 
-`git-init-db` won't hurt an existing repository.
+A shared repository allows users belonging to the same group to push into that
+repository. When specifying `--shared` the config variable "core.sharedRepository" 
+is set to 'true' so that directories under `$GIT_DIR` are made group writable
+(and g+sx, since the git group may be not the primary group of all users).
+
+
+Running `git-init-db` in an existing repository is safe. It will not overwrite
+things that are already there. The primary reason for rerunning `git-init-db`
+is to pick up newly added templates.
+
 
 
 EXAMPLES
-- 
Jonas Fonseca
