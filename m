From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 4/4] t7800: "defaults" is no longer a builtin tool name
Date: Fri, 15 Feb 2013 21:47:46 -0800
Message-ID: <1360993666-81308-4-git-send-email-davvid@gmail.com>
References: <1360993666-81308-1-git-send-email-davvid@gmail.com>
 <1360993666-81308-2-git-send-email-davvid@gmail.com>
 <1360993666-81308-3-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 06:48:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6adP-0001e6-Nj
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 06:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751430Ab3BPFsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2013 00:48:00 -0500
Received: from mail-ie0-f181.google.com ([209.85.223.181]:59855 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751305Ab3BPFr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2013 00:47:59 -0500
Received: by mail-ie0-f181.google.com with SMTP id 17so5603786iea.26
        for <git@vger.kernel.org>; Fri, 15 Feb 2013 21:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=esyMV9vttCd6Fj6zEUsGW0GuxRXA/xavgN7e8REBNpg=;
        b=sGRJmwaBW1ZOVQHE2Ljmz9cQ43hnrPLeDNbpW2Jx7luCWtY0u5BfBDHs6SaLqZqkBG
         Dpkb5v/+Im2c3xjb0LECap8+p4/6HNVzth8+Ml6x7m8Va6LianR+qcwAZ14wi28iyXrC
         i52xc1s6EHw/rVmitFHXsnFO/9vFgxpuYOqVQLY2s5SyLXp+cctV7NIuRsKBhko79RQ1
         cPk6YCx2R9wCpyUJXRFvBmBXnvCsSWu3v6c0tHEduwjUfwxAeaBAKjpe/3AAkKq+lK4R
         uMvudl1KsVlEHzQ5/DPwkRN32SlGJrqv29ZGN5l+MczkPPhaMR/ZEUu0wHWZlpofts8x
         FLpQ==
X-Received: by 10.50.57.133 with SMTP id i5mr3370213igq.67.1360993678796;
        Fri, 15 Feb 2013 21:47:58 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id z1sm6255743igc.1.2013.02.15.21.47.57
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 15 Feb 2013 21:47:57 -0800 (PST)
X-Mailer: git-send-email 1.8.1.3.623.g622c8fc
In-Reply-To: <1360993666-81308-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216375>

073678b8e6324a155fa99f40eee0637941a70a34 reworked the
mergetools/ directory so that every file corresponds to a
difftool-supported tool.  When this happened the "defaults"
file went away as it was no longer needed by mergetool--lib.

t7800 tests that configured commands can override builtins,
but this test was not adjusted when the "defaults" file was
removed because the test continued to pass.

Adjust the test to use the everlasting "vimdiff" tool name
instead of "defaults" so that it correctly tests against a tool
that is known by mergetool--lib.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7800-difftool.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index 2d1ba8d..6307c36 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -59,9 +59,9 @@ test_expect_success PERL 'custom commands' '
 
 # Ensures that a custom difftool.<tool>.cmd overrides built-ins
 test_expect_success PERL 'custom commands override built-ins' '
-	test_config difftool.defaults.cmd "cat \$REMOTE" &&
+	test_config difftool.vimdiff.cmd "cat \$REMOTE" &&
 
-	diff=$(git difftool --tool defaults --no-prompt branch) &&
+	diff=$(git difftool --tool vimdiff --no-prompt branch) &&
 	test "$diff" = "master"
 '
 
-- 
1.8.1.3.623.g622c8fc
