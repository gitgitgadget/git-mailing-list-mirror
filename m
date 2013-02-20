From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2 4/4] t7800: "defaults" is no longer a builtin tool name
Date: Tue, 19 Feb 2013 21:35:28 -0800
Message-ID: <1361338528-17835-4-git-send-email-davvid@gmail.com>
References: <1361338528-17835-1-git-send-email-davvid@gmail.com>
 <1361338528-17835-2-git-send-email-davvid@gmail.com>
 <1361338528-17835-3-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 20 06:36:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U82Lr-00010i-9B
	for gcvg-git-2@plane.gmane.org; Wed, 20 Feb 2013 06:36:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756476Ab3BTFfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Feb 2013 00:35:51 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:59441 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756376Ab3BTFfu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Feb 2013 00:35:50 -0500
Received: by mail-pa0-f50.google.com with SMTP id fa11so3835199pad.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2013 21:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=7O74ePdqLLzW34tYx2Kc1wsLse0rDG51svva0uR4WIw=;
        b=Iy68czdnppkFKNs5JksT0gR8bi14dKYidGJYjC5ycb6Bwh4hFutMbYfY1YsSurSnJZ
         S4yttB5sQ8j7E9dLbJufxgmuUcUBXSv3tt4RxhtMZT/ziFqXgGGG1t6OBCmrxQd8uCGc
         +1oGcKJPlEzcCA91Hye5U4MSgpzlPNBn7Q6d4XAJ9hlUeW7mju31oc+bmuUYb4WmcKwe
         MQpMmaijpqWcVf2gcBB8d8oByYzQl/MwTxDnVghjigPkxoZAKO4nKUBTSOfMMWy61H4v
         WSOELARgSzCWbq3UPWgpuPWyOwwDK02PDqg3HFmq1o12Yv+vdH6W+jL/PdcPoWOTBYKH
         WB/w==
X-Received: by 10.66.147.39 with SMTP id th7mr586763pab.136.1361338550197;
        Tue, 19 Feb 2013 21:35:50 -0800 (PST)
Received: from lustrous.fas.fa.disney.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPS id s9sm26625100pav.7.2013.02.19.21.35.48
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 19 Feb 2013 21:35:49 -0800 (PST)
X-Mailer: git-send-email 1.8.2.rc0.20.gf548dd7
In-Reply-To: <1361338528-17835-3-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216679>

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
Rebased for the new parent patch.

 t/t7800-difftool.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index b577c01..18df2c8 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -60,9 +60,9 @@ test_expect_success PERL 'custom commands' '
 '
 
 test_expect_success PERL 'custom tool commands override built-ins' '
-	test_config difftool.defaults.cmd "cat \$REMOTE" &&
+	test_config difftool.vimdiff.cmd "cat \$REMOTE" &&
 	echo master >expect &&
-	git difftool --tool defaults --no-prompt branch >actual &&
+	git difftool --tool vimdiff --no-prompt branch >actual &&
 	test_cmp expect actual
 '
 
-- 
1.8.2.rc0.20.gf548dd7
