From: Matt Whiteley <mattwhiteley@gmail.com>
Subject: [PATCH 1/2] clone: add disassociate alias to dissociate option
Date: Fri, 20 Feb 2015 11:10:22 -0800
Message-ID: <1424459423-11727-2-git-send-email-mattwhiteley@gmail.com>
References: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>
Cc: Matt Whiteley <mattwhiteley@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 20 20:11:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOsyV-0000Uq-SI
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 20:10:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754756AbbBTTKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 14:10:50 -0500
Received: from mail-pd0-f170.google.com ([209.85.192.170]:39428 "EHLO
	mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbbBTTKr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Feb 2015 14:10:47 -0500
Received: by pdjy10 with SMTP id y10so9574438pdj.6
        for <git@vger.kernel.org>; Fri, 20 Feb 2015 11:10:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ffYSFEH4EeokmhC1GulkEa+ncFYT2DMz41qj9cd2lsY=;
        b=V9gK6uS/daYbeGRLDjhRXGmFdfnUg/gCmSOnNPcovDDxt55pHTkiM1pP+ASJKkTsBf
         PAj48/pCy+VrUJlblJ84gz12jMbJYswOOcxaqE6ad4gydSBMVjQoGFUQsqJ24DGS6uvu
         qZcuMRivkPA/XLHfl4zunRFtwZLRyAv6t7xv6FXT6VyeUt+QCRpEiIvvWgVuhkv8KxqU
         tWNPj5zYCeHTug7s7i9DLN8pB3xUREFwbg6RAjxMtQ9gtyQdd6hdORUqIsriJu+LiG3r
         8v/rD61ZLx2QaJb9htycch/Mox7MQm/qCPI6Oq5YkAX1TKqXkx0KKLMxSMAEQaqdrn1z
         /o/g==
X-Received: by 10.70.23.5 with SMTP id i5mr18772522pdf.119.1424459447224;
        Fri, 20 Feb 2015 11:10:47 -0800 (PST)
Received: from localhost.localdomain ([67.204.180.114])
        by mx.google.com with ESMTPSA id ak7sm7474955pad.47.2015.02.20.11.10.46
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 20 Feb 2015 11:10:46 -0800 (PST)
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1424459423-11727-1-git-send-email-mattwhiteley@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264177>

Enable clone to accept alternate spelling for dissociate option. Add
alias to documentation following existing recursive/recurse-submodules
convention.

Signed-off-by: Matt Whiteley <mattwhiteley@gmail.com>
---
 Documentation/git-clone.txt | 3 ++-
 builtin/clone.c             | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index f1f2a3f..0b4c1b2 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 'git clone' [--template=<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
-	  [--dissociate] [--separate-git-dir <git dir>]
+	  [--dissociate | --disassociate] [--separate-git-dir <git dir>]
 	  [--depth <depth>] [--[no-]single-branch]
 	  [--recursive | --recurse-submodules] [--] <repository>
 	  [<directory>]
@@ -102,6 +102,7 @@ objects from the source repository into a pack in the cloned repository.
 `--dissociate` option.
 
 --dissociate::
+--disassociate::
 	Borrow the objects from reference repositories specified
 	with the `--reference` options only to reduce network
 	transfer and stop borrowing from them after a clone is made
diff --git a/builtin/clone.c b/builtin/clone.c
index 316c75d..7e193ae 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -97,6 +97,8 @@ static struct option builtin_clone_options[] = {
 		    N_("clone only one branch, HEAD or --branch")),
 	OPT_BOOL(0, "dissociate", &option_dissociate,
 		 N_("use --reference only while cloning")),
+	OPT_BOOL(0, "disassociate", &option_dissociate,
+		 N_("use --reference only while cloning")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
-- 
2.3.0
