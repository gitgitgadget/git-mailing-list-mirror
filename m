From: shd@jolt.modeemi.cs.tut.fi (Heikki Orsila)
Subject: (unknown)
Date: Thu,  1 Nov 2007 16:23:31 +0200 (EET)
Message-ID: <20071101142332.2096B4F95F@jolt.modeemi.cs.tut.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 01 15:38:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InbBR-0005PE-Au
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 15:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755405AbXKAOhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 10:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755829AbXKAOhz
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 10:37:55 -0400
Received: from mail.cs.tut.fi ([130.230.4.42]:32920 "EHLO mail.cs.tut.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755320AbXKAOhz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 10:37:55 -0400
X-Greylist: delayed 630 seconds by postgrey-1.27 at vger.kernel.org; Thu, 01 Nov 2007 10:37:54 EDT
Received: from amavis1.cs.tut.fi (amavis1.cs.tut.fi [130.230.4.69])
	by mail.cs.tut.fi (Postfix) with ESMTP id B6C182FD0
	for <git@vger.kernel.org>; Thu,  1 Nov 2007 16:27:23 +0200 (EET)
Received: from mail.cs.tut.fi ([130.230.4.42])
 by amavis1.cs.tut.fi (amavis1.cs.tut.fi [130.230.4.69]) (amavisd-maia, port 10024)
 with ESMTP id 21505-03-2 for <git@vger.kernel.org>;
 Thu,  1 Nov 2007 16:27:23 +0200 (EET)
Received: from modeemi.modeemi.cs.tut.fi (modeemi.modeemi.cs.tut.fi [130.230.72.134])
	by mail.cs.tut.fi (Postfix) with ESMTP id 8A1ED2813
	for <git@vger.kernel.org>; Thu,  1 Nov 2007 16:23:32 +0200 (EET)
Received: from jolt.modeemi.cs.tut.fi (jolt.modeemi.cs.tut.fi [130.230.72.144])
	by modeemi.modeemi.cs.tut.fi (Postfix) with ESMTP id 767914E344
	for <git@vger.kernel.org>; Thu,  1 Nov 2007 16:23:32 +0200 (EET)
Received: by jolt.modeemi.cs.tut.fi (Postfix, from userid 16311)
	id 2096B4F95F; Thu,  1 Nov 2007 16:23:31 +0200 (EET)
X-Virus-Scanned: Maia Mailguard 1.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62967>

>From bd2d661c565062eacc80dda90f3978303308f9bb Mon Sep 17 00:00:00 2001
From: Heikki Orsila <heikki.orsila@iki.fi>
Date: Thu, 1 Nov 2007 16:21:39 +0200
Subject: [PATCH] Make git-clone obey "--" (end argument parsing)

---
 Documentation/git-clone.txt |    2 +-
 git-clone.sh                |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 253f4f0..7fdcd42 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git-clone' [--template=<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--depth <depth>] <repository> [<directory>]
+	  [--depth <depth>] [--] <repository> [<directory>]
 
 DESCRIPTION
 -----------
diff --git a/git-clone.sh b/git-clone.sh
index 0ea3c24..3f00693 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -14,7 +14,7 @@ die() {
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] <repo> [<dir>]"
+	die "Usage: $0 [--template=<template_directory>] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [--depth <n>] [-n] [--] <repo> [<dir>]"
 }
 
 get_repo_base() {
@@ -160,6 +160,9 @@ while
 	*,--depth)
 		shift
 		depth="--depth=$1";;
+	*,--)
+		shift
+		break ;;
 	*,-*) usage ;;
 	*) break ;;
 	esac
-- 
1.5.3.4.498.g9c514-dirty
