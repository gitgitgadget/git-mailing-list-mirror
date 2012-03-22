From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 6/9 v6] difftool: eliminate setup_environment function
Date: Thu, 22 Mar 2012 15:52:21 -0400
Message-ID: <1332445944-10944-7-git-send-email-tim.henigan@gmail.com>
References: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 22 20:53:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAo4x-0005b1-PS
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:53:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895Ab2CVTxn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:53:43 -0400
Received: from mail-qa0-f46.google.com ([209.85.216.46]:35572 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932110Ab2CVTxm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:53:42 -0400
Received: by mail-qa0-f46.google.com with SMTP id b19so544975qae.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ToaNAoFFrq0ls18kqqSPQXX/7Ft49RZH3qjwYgkHjxE=;
        b=e/J7EvklDl1FXZFZfim0LWee2w15hcETTRb8ov2pTDiUrycrXHcnmH8rvsRcfAd9+1
         CI1COP1fh/c1OMFqATuXUz2CPLeiUcwYJ92fmmTu/46deVZ2z0ks23gXpE6hm69xNBLn
         FYCvFhfC80gmNNGtbKP/dmYoMo+WzhlFh5Qetixt6Zi+mD/KJjX24eiAxctX3RS+Z+xy
         VuOg7SXVI6izsWCdegNB1CEN6qUT2LRO3gJrhh4VPVAIjpI0/osR/TMKau6FUTJ5rfq7
         wWwRHi+EIasArzPKQOJvxYX/FLDyuQyz6WyDHxiz7yNBGNdPjybX3uoGiDPQI4o0BqqY
         N1xQ==
Received: by 10.224.33.18 with SMTP id f18mr9179598qad.39.1332446021947;
        Thu, 22 Mar 2012 12:53:41 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id hr2sm10007770qab.8.2012.03.22.12.53.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 12:53:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.36.g15e879
In-Reply-To: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193705>

Removing this function shortens the code and makes it easier to read.
Now all environment variables are set as part of procedural operation.

Signed-off-by: Tim Henigan <tim.henigan@gmail.com>
---
 git-difftool.perl |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/git-difftool.perl b/git-difftool.perl
index 493260d..d4fe998 100755
--- a/git-difftool.perl
+++ b/git-difftool.perl
@@ -29,12 +29,6 @@ USAGE
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
 my ($difftool_cmd, $extcmd, $gui, $help, $prompt);
@@ -79,7 +73,8 @@ if (defined($prompt)) {
 	}
 }
 
-setup_environment();
+$ENV{GIT_PAGER} = '';
+$ENV{GIT_EXTERNAL_DIFF} = 'git-difftool--helper';
 my @command = ('git', 'diff', @ARGV);
 
 # ActiveState Perl for Win32 does not implement POSIX semantics of
-- 
1.7.10.rc1.36.g15e879
