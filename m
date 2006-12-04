X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] git-clone: Rename --use-immingled-remote option to --no-separate-remote
Date: Mon, 4 Dec 2006 14:29:09 +0100
Message-ID: <200612041429.09835.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 4 Dec 2006 13:27:24 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=mbI0JQSkAI3c63cPZXeZqvXSAa6Oz/gykSe2vchcI2o+N+lbjwSUt5Bkj1UyPMiy7hiGZCglkT2uMb+2hTqPH59pBwxG9Eqbark/v6MsEL8Hep4SflfNDAvKxtVwl7HBx2h2v7MubFOWxEHMIWHa7+DZFq7PXhZXA0KAiL0WZx8=
User-Agent: KMail/1.9.3
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33195>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrDqk-00065z-AZ for gcvg-git@gmane.org; Mon, 04 Dec
 2006 14:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936832AbWLDN1L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 08:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936831AbWLDN1L
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 08:27:11 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:58259 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S936830AbWLDN1K
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006 08:27:10 -0500
Received: by ug-out-1314.google.com with SMTP id 44so2993505uga for
 <git@vger.kernel.org>; Mon, 04 Dec 2006 05:27:08 -0800 (PST)
Received: by 10.66.232.10 with SMTP id e10mr12020650ugh.1165238828013; Mon,
 04 Dec 2006 05:27:08 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id u1sm2086640uge.2006.12.04.05.27.06; Mon, 04 Dec
 2006 05:27:06 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

With making --use-separate-remote default when creating non-bare
clone, there was need for the flag which would turn off this behavior.
It was called --use-immingled-remote.

Immingle means to blend, to combine into one, to intermingle, but it
is a bit obscure word. I think it would be better to use simply
--no-separate-remote as the opposite to --use-separate-remote
option to git clone.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/git-clone.txt |    4 ++--
 git-clone.sh                |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 4cb4223..d5efa00 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git-clone' [--template=<template_directory>] [-l [-s]] [-q] [-n] [--bare]
 	  [-o <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--use-separate-remote | --use-immingled-remote] <repository>
+	  [--use-separate-remote | --no-separate-remote] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -105,7 +105,7 @@ OPTIONS
 	of `$GIT_DIR/refs/heads/`.  Only the local master branch is
 	saved in the latter. This is the default.
 
---use-immingled-remote::
+--no-separate-remote::
 	Save remotes heads in the same namespace as the local
 	heads, `$GIT_DIR/refs/heads/'.  In regular repositories,
 	this is a legacy setup git-clone created by default in
diff --git a/git-clone.sh b/git-clone.sh
index d4ee93f..8964039 100755
--- a/git-clone.sh
+++ b/git-clone.sh
@@ -14,7 +14,7 @@ die() {
 }
 
 usage() {
-	die "Usage: $0 [--template=<template_directory>] [--use-immingled-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
+	die "Usage: $0 [--template=<template_directory>] [--no-separate-remote] [--reference <reference-repo>] [--bare] [-l [-s]] [-q] [-u <upload-pack>] [--origin <name>] [-n] <repo> [<dir>]"
 }
 
 get_repo_base() {
@@ -140,7 +140,7 @@ while
 	*,--use-separate-remote)
 		# default
 		use_separate_remote=t ;;
-	*,--use-immingled-remote)
+	*,--no-separate-remote)
 		use_separate_remote= ;;
 	1,--reference) usage ;;
 	*,--reference)
@@ -176,7 +176,7 @@ repo="$1"
 test -n "$repo" ||
     die 'you must specify a repository to clone.'
 
-# --bare implies --no-checkout and --use-immingled-remote
+# --bare implies --no-checkout and --no-separate-remote
 if test yes = "$bare"
 then
 	if test yes = "$origin_override"
-- 
1.4.4.1
