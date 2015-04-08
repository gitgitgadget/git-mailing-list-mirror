From: Patrick Steinhardt <ps@pks.im>
Subject: [RFC/PATCH 3/4] submodules: update docs to reflect remotes.
Date: Wed,  8 Apr 2015 12:58:24 +0200
Message-ID: <1428490705-11586-4-git-send-email-ps@pks.im>
References: <1428490705-11586-1-git-send-email-ps@pks.im>
Cc: Patrick Steinhardt <ps@pks.im>, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 08 13:17:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfnzB-0007tk-Eb
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 13:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401AbbDHLRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 07:17:21 -0400
Received: from sender1.zohomail.com ([74.201.84.157]:50228 "EHLO
	sender1.zohomail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbbDHLRP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 07:17:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=mail; d=pks.im; 
  h=from:to:cc:subject:date:message-id:in-reply-to:references; 
  b=GRNwTa6q2ZngJNmvvBqFnhz9P2S+zMGc7OVorW1/AW+ewYwsdp5EkpWltdG759vyo8Zh29JUt6Ox
    ueLLxEh0Z6q83B0Ft7buKq3FIQUt/Wtd7OVrke77hM8sN3DdbavGEVuweCZ6TBc96P+K2MDm5qxf
    AaJfKxLTS9S2vBJnbpM=  
Received: from localhost (x5ce10f35.dyn.telefonica.de [92.225.15.53]) by mx.zohomail.com
	with SMTPS id 1428490769598614.6832758230394; Wed, 8 Apr 2015 03:59:29 -0700 (PDT)
X-Mailer: git-send-email 2.3.5
In-Reply-To: <1428490705-11586-1-git-send-email-ps@pks.im>
X-ZohoMail: Ss  SS_10 UW1 iCHF_KNW_WHT_EXT UW1 UB2468 iCHF_INT_SMD_EXT UW1 iSFP_NO_WHTCNT_EXT UW1 UB2468 iZSF-HLOLL_2  SGR3_0_01045_18
X-ZohoMail-Owner: <1428490705-11586-4-git-send-email-ps@pks.im>+zmo_0_<ps@pks.im>
X-ZohoMail-Sender: 92.225.15.53
X-Zoho-Virus-Status: 2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266956>

---
 Documentation/git-submodule.txt | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 2c25916..a49a2ad 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -21,6 +21,9 @@ SYNOPSIS
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
 'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
+'git submodule' [--quiet] remote add <path> <name> <url>
+'git submodule' [--quiet] remote rm <path> <name>
+'git submodule' [--quiet] remote set-url [--push] <path> <name> <url>"
 
 
 DESCRIPTION
@@ -233,6 +236,22 @@ As an example, +git submodule foreach \'echo $path {backtick}git
 rev-parse HEAD{backtick}'+ will show the path and currently checked out
 commit for each submodule.
 
+remote::
+	Modify a submodule's remote configuration. The command has subcommands that
+	mirror the commands of `git remote`. The change will be reflected inside
+	of the .gitmodules file the submodule is specified in. Changes will be
+	synchronized with the submodule by running `git submodule sync`.
++
+	`git submodule remote add <sm_path> <remote> <url>`;;
+		add a new remote with the URL specified to the submodule
+	`git submodule remote rm <sm_path> <remote>`;;
+		remove a remote with the given name for the specified submodule
+	`git submodule remote show [-v|--verbose] <sm_path>`;;
+		show configured remotes for the submodule. If `--verbose` is specified,
+		also print URLs.
+	`git submodule remote set-url [--push] <sm_path> <remote> <url>`;;
+		set the (push) URL for the given remote name and submodule.
+
 sync::
 	Synchronizes submodules' remote URL configuration setting
 	to the value specified in .gitmodules. It will only affect those
@@ -240,6 +259,10 @@ sync::
 	case when they are initialized or freshly added). This is useful when
 	submodule URLs change upstream and you need to update your local
 	repositories accordingly.
+
+	Also synchronizes all remotes that have been configured in .gitmodules.
+	Missing remotes will be added to the submodule while existing ones will be
+	updated according to the configured fetch or push URLs.
 +
 "git submodule sync" synchronizes all submodules while
 "git submodule sync \-- A" synchronizes submodule "A" only.
-- 
2.3.5
