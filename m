From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 5/9] difftool: eliminate setup_environment function
Date: Fri, 16 Mar 2012 21:58:54 -0400
Message-ID: <1331949534-15100-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, davvid@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 17 02:59:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8ivF-0006KE-Q6
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 02:59:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032990Ab2CQB7F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Mar 2012 21:59:05 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61404 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030239Ab2CQB7D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Mar 2012 21:59:03 -0400
Received: by iagz16 with SMTP id z16so6234576iag.19
        for <git@vger.kernel.org>; Fri, 16 Mar 2012 18:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=4Nqo125qJdaFvPLkr+O57Y0HSJMQNbFOXA/Mbns+kcs=;
        b=JmKs2zKyhNAavYPpRs1kL9EvysTDfS0XD4aNDbNHkfbIijIXw8gmsAtbvx76nixOYt
         YVu8mI17mYKSnLLIBFqot0Huylvpje/3KAXV4Wz9xHI6lN2NJFv+0PrIxgSBqqFLD24W
         tb9uIgKqqNwrvH4KI5izA8S9N1qfaMCZt6oJ7/+9Djeu8e0gja8WqC1zIQDGM7T0CB2M
         AaW9rJ0RCO2sUWXDMCf3nfq4uNwUVcAANqWPgQa+uvDAyptWwTWUFh/fA2ApH33cVyjH
         WH/atLix2FZqNeQRJjKnnVYp9aDR47BMgPskrrj/WfXT+XWKvvnSgec4wMrU9h5vkfth
         im5w==
Received: by 10.50.179.71 with SMTP id de7mr896430igc.73.1331949543052;
        Fri, 16 Mar 2012 18:59:03 -0700 (PDT)
Received: from localhost ([75.38.216.51])
        by mx.google.com with ESMTPS id cv10sm1220686igc.13.2012.03.16.18.59.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 16 Mar 2012 18:59:02 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.1.290.gbd444
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193294>

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
