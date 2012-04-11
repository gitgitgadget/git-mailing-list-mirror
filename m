From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 1/2] git p4: Fixing script editor checks
Date: Wed, 11 Apr 2012 17:21:23 +0200
Message-ID: <1334157684-31402-2-git-send-email-luke@diamand.org>
References: <1334157684-31402-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 11 17:21:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHzMh-0003YH-Eb
	for gcvg-git-2@plane.gmane.org; Wed, 11 Apr 2012 17:21:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760317Ab2DKPVl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Apr 2012 11:21:41 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33648 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753550Ab2DKPVl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2012 11:21:41 -0400
Received: by mail-bk0-f46.google.com with SMTP id ik5so773110bkc.19
        for <git@vger.kernel.org>; Wed, 11 Apr 2012 08:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=vXe4rNIxwqSVsVPgVOE5h5Up41qBebTZPcU1DnIZQwo=;
        b=TgOROFF8H3FuFEuDe7vVKCht8fLnbq2JVqCQD+n+1O5RiTFFQETcY1gtf5ZltrApng
         uIiIWtCLUt+THyfpgUIvZX241Xon7rO8arMAoPoa6ZGSygjTJgc0NYcYhjAJpyXYC4gN
         30L7gxgMn7uBWI7pXMDLwSzvo+D3pQzR0/gEZiHWJFeXj7xIgmYI/6VfY/ijtpQU5c7O
         iVFb0bwCzA4PiCNHe6nnmPsHFhpXz9r4L0xB+RrT68sUUunruaXXrwTQNmrbTxo9AJqD
         AsF43JVABRmV+TCECSvFsNVQZyTT1p5v+McBUBpldR9gIzk5mNpM/QZeFurDgzi7CuwU
         AnFw==
Received: by 10.205.121.138 with SMTP id gc10mr6439735bkc.23.1334157700339;
        Wed, 11 Apr 2012 08:21:40 -0700 (PDT)
Received: from halilbut.cam.broadcom.com ([212.183.128.225])
        by mx.google.com with ESMTPS id gw19sm5547474bkc.8.2012.04.11.08.21.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 11 Apr 2012 08:21:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc0.161.gdb6eba
In-Reply-To: <1334157684-31402-1-git-send-email-luke@diamand.org>
X-Gm-Message-State: ALoCoQlERmRmzNJ35gCzoKAWleHIPpMniUYgkpjxAZ2Xwv7XG7TBVv9qhtNS2gYMVDSaMqIuGnWo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195189>

If P4EDITOR is defined, the tests will fail when "git p4" starts an
editor.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 t/t9800-git-p4-basic.sh |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index 13be144..b2f0869 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -335,7 +335,7 @@ test_expect_success 'detect renames' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		git config git-p4.skipSubmitEditCheck true &&
+		git config git-p4.skipSubmitEdit true &&
 
 		git mv file1 file4 &&
 		git commit -a -m "Rename file1 to file4" &&
@@ -394,7 +394,7 @@ test_expect_success 'detect copies' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		git config git-p4.skipSubmitEditCheck true &&
+		git config git-p4.skipSubmitEdit true &&
 
 		cp file2 file8 &&
 		git add file8 &&
-- 
1.7.10.rc0.161.gdb6eba
