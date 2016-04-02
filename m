From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 3/7] t5520: use better test to check stderr output
Date: Sat,  2 Apr 2016 23:28:28 +0530
Message-ID: <1459619912-5445-4-git-send-email-mehul.jain2029@gmail.com>
References: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 02 20:00:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1amPql-0000CB-ED
	for gcvg-git-2@plane.gmane.org; Sat, 02 Apr 2016 20:00:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752117AbcDBSAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Apr 2016 14:00:39 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35597 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbcDBSAj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Apr 2016 14:00:39 -0400
Received: by mail-pa0-f68.google.com with SMTP id hn5so14293392pac.2
        for <git@vger.kernel.org>; Sat, 02 Apr 2016 11:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OUOJNM4bSw7n0q2Er+3koyR9zc5lfcrbyqW0tP7wYhQ=;
        b=kA75SFo5P3o5vRdTDOl5s5g6I/Po+UpPwVCJD2eEl32nhlYVSVZ034EYnZzgmQmL9c
         T6xtwWfTiMd2BVDDkcN37fbsYGniY/oW9XhjhmuLKw7mS9dG9oy1uprwux1uJeZp/Kqu
         /PVzNFEiCYp0mQ9w4Jeg4I5DrOs2kJX7krc0B3EWlD8h/z1X4mDcAp2UsbRk2kL3YTkJ
         6FcsOJV5q6UY2Oh2EApL/qiHqxFIeT7wr5un5JpOXzJrmPXd4+cod2XTV6Xu1V7l/xDB
         wvbYDkQgKijsO63YJ9uEHJ23js2A1GARPiRKUmcrjcrrsy1ZukMdCUKxwwKbZlaVKUjn
         j+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OUOJNM4bSw7n0q2Er+3koyR9zc5lfcrbyqW0tP7wYhQ=;
        b=Q+I3KkmlGQ/UFAuDNYM/uAT+vJPXLatZRjD42XAwPV0MnxG94WFg6kbcCLRJjaJ9Pu
         LFPg5Ff78xYHAysM1cwFWHFWwxovZ+L41GZJfrexgMWhqV4C+Z8Y7i7nhv7TrCsz4qO1
         H6GVa9v2UHNNFE4eJWFbm0aBjICklrcGnhgxh8dipljjCRoP71x36xmFyNrUjdvx4/qr
         MNsk3d/Mast47N3d7o1kwGLQOStKKzJL568K13ffxiTVxL9ow7jzHY1fVv2Ev0IKe21M
         RX7Yra2d96yDZjLWaPfKVNbToY8X+RT6JmkQOZJYFLJLRNjZlyZOVWLTvfD0psh9qdw0
         R6Bg==
X-Gm-Message-State: AD7BkJJwE71lkzWTlXebhnzyswQ06gNeDBXp4tbFYd0pCsbc+OiExXJsJPZUkMknOpjeww==
X-Received: by 10.66.221.167 with SMTP id qf7mr40453218pac.94.1459620037906;
        Sat, 02 Apr 2016 11:00:37 -0700 (PDT)
Received: from localhost.localdomain ([1.39.37.116])
        by smtp.gmail.com with ESMTPSA id v3sm30495734par.17.2016.04.02.11.00.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 02 Apr 2016 11:00:37 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1459619912-5445-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290599>

Checking stderr output using test_i18ncmp may lead to test failure as
some shells write trace output to stderr when run under 'set -x'.

Use test_i18ngrep instead of test_i18ncmp.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t5520-pull.sh | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 9ee2218..d03cb84 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -317,15 +317,13 @@ test_expect_success 'pull --rebase --no-autostash & rebase.autostash unset' '
 '
 
 test_expect_success 'pull --autostash (without --rebase) should error out' '
-	test_must_fail git pull --autostash . copy 2>actual &&
-	echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
-	test_i18ncmp actual expect
+	test_must_fail git pull --autostash . copy 2>err &&
+	test_i18ngrep "only valid with --rebase" err
 '
 
 test_expect_success 'pull --no-autostash (without --rebase) should error out' '
-	test_must_fail git pull --no-autostash . copy 2>actual &&
-	echo "fatal: --[no-]autostash option is only valid with --rebase." >expect &&
-	test_i18ncmp actual expect
+	test_must_fail git pull --no-autostash . copy 2>err &&
+	test_i18ngrep "only valid with --rebase" err
 '
 
 test_expect_success 'pull.rebase' '
-- 
2.7.1.340.g69eb491.dirty
