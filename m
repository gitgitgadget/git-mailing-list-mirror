From: Brandon Casey <drafnel@gmail.com>
Subject: [PATCH 1/2] t/t4131-apply-fake-ancestor.sh: fix broken test
Date: Sat,  3 Dec 2011 14:35:49 -0600
Message-ID: <1322944550-27344-1-git-send-email-drafnel@gmail.com>
Cc: artem.bityutskiy@linux.intel.com, Brandon Casey <drafnel@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 03 21:36:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWwKG-0003jF-Ce
	for gcvg-git-2@lo.gmane.org; Sat, 03 Dec 2011 21:36:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753173Ab1LCUf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Dec 2011 15:35:58 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:39455 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752896Ab1LCUf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Dec 2011 15:35:57 -0500
Received: by ghrr1 with SMTP id r1so3661071ghr.19
        for <git@vger.kernel.org>; Sat, 03 Dec 2011 12:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=9RaVWW6XvsYmqEYJk7wijX6qddBJSuwhDwrfvbOV064=;
        b=S1uz3bNymlORczeVMpwUkxpVIKdAuzKOddjokPwSZIFCwW3TjwNay/IfG+YBgDyw1+
         PwX92ft8i5KW/loRbc0V4t7qKmyyJ+3xxtzLtFJX2ebYMvviXYLP8W/8N+ctizSCbvou
         YIknXMDLleJXSwIMQPBwg/si2Pueihniwsjzw=
Received: by 10.101.184.14 with SMTP id l14mr667284anp.127.1322944556663;
        Sat, 03 Dec 2011 12:35:56 -0800 (PST)
Received: from localhost.localdomain (adsl-74-243-58-53.bix.bellsouth.net. [74.243.58.53])
        by mx.google.com with ESMTPS id q16sm13442727anb.19.2011.12.03.12.35.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Dec 2011 12:35:56 -0800 (PST)
X-Mailer: git-send-email 1.7.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186259>

The third test "apply --build-fake-ancestor in a subdirectory" has been
broken since it was introduced.  It intended to modify a tracked file named
'sub/3.t' and then produce a diff which could be git apply'ed, but the file
named 'sub/3.t' does not exist.  The file that exists in the repo is called
'sub/3'.  Since no tracked files were modified, an empty diff was produced,
and the test succeeded.

Correct this test by supplying the intended name of the tracked file,
'sub/3.t', to test_commit in the first test.

Signed-off-by: Brandon Casey <drafnel@gmail.com>
---
 t/t4131-apply-fake-ancestor.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/t/t4131-apply-fake-ancestor.sh b/t/t4131-apply-fake-ancestor.sh
index 94373ca..b1361ce 100755
--- a/t/t4131-apply-fake-ancestor.sh
+++ b/t/t4131-apply-fake-ancestor.sh
@@ -11,7 +11,7 @@ test_expect_success 'setup' '
 	test_commit 1 &&
 	test_commit 2 &&
 	mkdir sub &&
-	test_commit 3 sub/3 &&
+	test_commit 3 sub/3.t &&
 	test_commit 4
 '
 
-- 
1.7.8
