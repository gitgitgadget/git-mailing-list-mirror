From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 09/15] t3418 (rebase-continue): fix && chaining
Date: Thu,  8 Dec 2011 01:06:45 +0530
Message-ID: <1323286611-4806-10-git-send-email-artagnon@gmail.com>
References: <20111207100858.GB13374@elie.hsd1.il.comcast.net>
 <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 20:38:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYNKB-0001GW-LH
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 20:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757482Ab1LGTib (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 14:38:31 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48222 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757154Ab1LGTia (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 14:38:30 -0500
Received: by mail-qy0-f174.google.com with SMTP id z2so701321qcq.19
        for <git@vger.kernel.org>; Wed, 07 Dec 2011 11:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=koJ6Y4BvmsDdMQyuClfBBOFPgLizXa/t4wRlMO8oVtI=;
        b=q6UtLX86FFtdFVjra2cQ4WxK9LwVrnkE30tmRdkcpmMDk+I7T0G6aaLPcjx0ino7/y
         8VDusf/l+iCyBpr3PTJPPH3YoNm1Xye62j30IEcoC6wj9msFgkxVeYPKkUI8jt1g25Q3
         vPVhhgZFWpoZ92F8TyJKUISEY0l8rlLrLAwP0=
Received: by 10.50.40.198 with SMTP id z6mr217540igk.39.1323286710153;
        Wed, 07 Dec 2011 11:38:30 -0800 (PST)
Received: from localhost.localdomain ([203.110.240.205])
        by mx.google.com with ESMTPS id ds5sm10016838ibb.5.2011.12.07.11.38.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 11:38:29 -0800 (PST)
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1323286611-4806-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186490>

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 t/t3418-rebase-continue.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 1e855cd..2680375 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -51,7 +51,7 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test_commit "commit-new-file-F3-on-topic-branch" F3 32 &&
 	test_when_finished "rm -fr test-bin funny.was.run" &&
 	mkdir test-bin &&
-	cat >test-bin/git-merge-funny <<-EOF
+	cat >test-bin/git-merge-funny <<-EOF &&
 	#!$SHELL_PATH
 	case "\$1" in --opt) ;; *) exit 2 ;; esac
 	shift &&
@@ -77,7 +77,7 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 test_expect_success 'rebase --continue remembers --rerere-autoupdate' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-	git checkout master
+	git checkout master &&
 	test_commit "commit-new-file-F3" F3 3 &&
 	git config rerere.enabled true &&
 	test_must_fail git rebase -m master topic &&
-- 
1.7.7.3
