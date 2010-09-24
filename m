From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 15/16] t7800 (difftool): add missing &&
Date: Fri, 24 Sep 2010 16:22:55 -0600
Message-ID: <1285366976-22216-16-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:22:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGer-0000n6-5h
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:22:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113Ab0IXWVv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:51 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:45492 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758285Ab0IXWVs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:48 -0400
Received: by mail-qy0-f181.google.com with SMTP id 33so4608692qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=5yN+ozsROpPJeieYx8D43vNzN61M9Nt5J6guNYcSPgU=;
        b=HnsPDMoRqzod+WOvOYLr3pOOxtgkJvSJSSMjKPq1pRIi9+4U8tPEfkX3Dd9hhWyFpp
         KoM42WISkPqZXx+G48CyMSR4tRgjsei/RZFQ+yRk5N+Esq5WFa6b8lKtP544knZ8u5Js
         x59KGw3dunpnfUR/WOe3Q07KVg6SGl/AGrG1c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=YdMAB5MJjESP2I9iW5EDQoKHNR7d1YHJluX27x5yc1Qp2LjsF76GFnoagKCjYx4/0q
         AuXeoad3L2mY8Mq82d5lZT4tWAUwH2DLVykQUeKlsLkhHUFXtrC6rbuuztuZmIAIsD+V
         LYUSexLPvXFYtHHgPkDc245vIfrnRmk6xROuc=
Received: by 10.220.124.106 with SMTP id t42mr457846vcr.249.1285366908114;
        Fri, 24 Sep 2010 15:21:48 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.46
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157086>

FIXME: Is it okay for the 'git config --unset difftool.prompt' to fail?  I
had to add a test_might_fail in front of it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7800-difftool.sh |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 58dc6f6..7e3551f 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -98,7 +98,7 @@ test_expect_success PERL 'difftool --gui works without configured diff.guitool'
 
 # Specify the diff tool using $GIT_DIFF_TOOL
 test_expect_success PERL 'GIT_DIFF_TOOL variable' '
-	git config --unset diff.tool
+	git config --unset diff.tool &&
 	GIT_DIFF_TOOL=test-tool &&
 	export GIT_DIFF_TOOL &&
 
@@ -166,7 +166,7 @@ test_expect_success PERL 'difftool.prompt config variable is false' '
 
 # Test that we don't have to pass --no-prompt when mergetool.prompt is false
 test_expect_success PERL 'difftool merge.prompt = false' '
-	git config --unset difftool.prompt
+	test_might_fail git config --unset difftool.prompt &&
 	git config mergetool.prompt false &&
 
 	diff=$(git difftool branch) &&
@@ -211,7 +211,7 @@ test_expect_success PERL 'difftool last flag wins' '
 # git-difftool falls back to git-mergetool config variables
 # so test that behavior here
 test_expect_success PERL 'difftool + mergetool config variables' '
-	remove_config_vars
+	remove_config_vars &&
 	git config merge.tool test-tool &&
 	git config mergetool.test-tool.cmd "cat \$LOCAL" &&
 
@@ -254,17 +254,17 @@ test_expect_success PERL 'difftool -x cat' '
 '
 
 test_expect_success PERL 'difftool --extcmd echo arg1' '
-	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"echo\ \$1\" branch)
+	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"echo\ \$1\" branch) &&
 	test "$diff" = file
 '
 
 test_expect_success PERL 'difftool --extcmd cat arg1' '
-	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$1\" branch)
+	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$1\" branch) &&
 	test "$diff" = master
 '
 
 test_expect_success PERL 'difftool --extcmd cat arg2' '
-	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$2\" branch)
+	diff=$(git difftool --no-prompt --extcmd sh\ -c\ \"cat\ \$2\" branch) &&
 	test "$diff" = branch
 '
 
-- 
1.7.3.95.g14291
