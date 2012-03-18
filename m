From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 5/9 v2] difftool: eliminate setup_environment function
Date: Sat, 17 Mar 2012 21:55:30 -0400
Message-ID: <1332035734-5443-6-git-send-email-tim.henigan@gmail.com>
References: <1331949442-15039-1-git-send-email-tim.henigan@gmail.com>
 <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 18 02:56:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S95MX-0004Hw-NY
	for gcvg-git-2@plane.gmane.org; Sun, 18 Mar 2012 02:56:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757317Ab2CRB4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Mar 2012 21:56:38 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:55335 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757086Ab2CRB4S (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 21:56:18 -0400
Received: by mail-iy0-f174.google.com with SMTP id z16so7559135iag.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 18:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4Nqo125qJdaFvPLkr+O57Y0HSJMQNbFOXA/Mbns+kcs=;
        b=I7SprPzEiFfheATfdXjTVOBLYuqLhtmz9FhEZtnIoaro3kMnSKbY70tSPVpMd7wrtq
         Rc/j3AF6aGJrVYwc8jhATs6iGs0p+1tUCqFwczGs1tb37Wp4L3c8Uf8mzT+1YR2b5vsV
         q+2bngWHWngk+z+V7Mb65GHhRZ20mq84tX3z9i/Cs5arn5nKoQDJxKjUxUaz+booU6K4
         SKsALaxkqecDu/CIFarJyQppLuwyVFS7c7K4SG0K8UAIkcs5dl6+YPPgO0afS9h1FnUL
         /iQs3SWJqo14Heb6QnWN2ZFoER8Vh1CvgZ/+5k0Zuzrr97TnyUfj7S7+XzmH53RXSlXo
         3mdA==
Received: by 10.50.41.230 with SMTP id i6mr2970994igl.18.1332035778380;
        Sat, 17 Mar 2012 18:56:18 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id md6sm4322242igc.0.2012.03.17.18.56.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 18:56:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
In-Reply-To: <1332035734-5443-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193359>

Removing this function shortens the code and makes it easier to read.
Now all environment variables are set as part of procedural operation.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 99ff587..9495f14 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -27,12 +27,6 @@ USAGE
 	exit($exitcode);
 }
 
-sub setup_environment
-{
-	$ENV{GIT_PAGER} = '';
-	$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
-}
-
 # parse command-line options. all unrecognized options and arguments
 # are passed through to the 'git diff' command.
 my ($difftool_cmd, $extcmd, $gui, $help, $no_prompt, $prompt);
@@ -76,7 +70,8 @@ elsif (defined($no_prompt)) {
 	$ENV{GIT_DIFFTOOL_NO_PROMPT} = 'true';
 }
 
-setup_environment();
+$ENV{GIT_PAGER} = '';
+$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
 my @command = ('git', 'diff', @ARGV);
 
 # ActiveState Perl for Win32 does not implement POSIX semantics of
-- 
1.7.9.1.290.gbd444
