From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH 5/5] t/t5520: test --[no-]autostash with pull.rebase=true
Date: Tue, 29 Mar 2016 19:00:00 +0530
Message-ID: <1459258200-32444-6-git-send-email-mehul.jain2029@gmail.com>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
Cc: sunshine@sunshineco.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 15:32:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aktkv-0005W7-Uc
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 15:32:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732AbcC2NcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2016 09:32:21 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:34175 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756068AbcC2NcK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2016 09:32:10 -0400
Received: by mail-pa0-f68.google.com with SMTP id hj7so2086464pac.1
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 06:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6pwTvpfPl4BAGlBfirW2fBppZ9sShUo2xlQXx0y7dvA=;
        b=wf3CZTpbYo42Q0RATADbqrpmBN+z+zDMNjDqkR1GcE9YX30dKz54gszHE/DAs8sHxz
         T6nFhaWUdG/tIt15BA1LC9Sp96jZMPCwEMBrv+RUA82MhuETaSj3a2pvDmXGB2Abf3AK
         KI4DPVGMfOsHVGF3tM9anj2Vz7LiaPrKgbl4kOqgP0WknrLpbk8JsYxANPmBz0uiRPWn
         lFn5D/hzGqS3LFeeJDBSW/cepvXf2DFq0jkGCtT3M2yqb/Ue5z+2dflp5QR9sUgRSYQS
         UUt3UQrww+KGp2fPCuXUlaJGdknzIAUp+oIQIMd7o/whLuPblUEN/O5aBtQaAWlO7zjK
         YfEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6pwTvpfPl4BAGlBfirW2fBppZ9sShUo2xlQXx0y7dvA=;
        b=HCEJ6fjAHab0q/xXkH1PK0CFc5poJe34dxepgaB/9VlB94At+1bAzh/+cZGftBamg4
         z0yR0vjVybSPuMghEheTCcELRolcKSxMq8UdZ4mJMIpUuu8T6GX+37BW1StvhMR7Q7sP
         quMjTGyPm3fzDdLA1levaiTPNS+QHq9WC/yy8zJCniH1/mGqDNSJtg5WcwC6D+Jl5OM2
         lti0uO+bYGljqwSHZBAfrtxtQUNdEpR22a+l7Xg3MSwaOwjrWSK/yY81dcB2b3tzjxyo
         fgWXjZQDEUf9ASsIt6Xxrf0JoqeKJDQCZIlkNKwioc2N5ligL8brKlcfIKdOrf6h2zSy
         aZFA==
X-Gm-Message-State: AD7BkJKux3Am0XqKlltKxSwNjUyiYtN4YBRAsc7+pag/COIk327Ig6dGaReTijOPCk3Kyw==
X-Received: by 10.66.191.202 with SMTP id ha10mr3533526pac.8.1459258329324;
        Tue, 29 Mar 2016 06:32:09 -0700 (PDT)
Received: from localhost.localdomain ([1.39.38.29])
        by smtp.gmail.com with ESMTPSA id s66sm43430514pfi.3.2016.03.29.06.31.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 29 Mar 2016 06:32:08 -0700 (PDT)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290140>

"--[no-]autostash" option for git-pull is only valid in rebase mode.
That is, either --rebase is used or pull.rebase=true. Existing tests
already check the cases when --rebase is used but fails to check for
pull.rebase=true case.

Add two new tests to check that --[no-]autostash option works with
pull.rebase=true.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t5520-pull.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 2611170..4da9e52 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -316,6 +316,26 @@ test_expect_success 'pull.rebase' '
 	test new = "$(git show HEAD:file2)"
 '
 
+test_expect_success 'pull --autostash & pull.rebase=true' '
+	test_config pull.rebase true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull --autostash . copy &&
+	test_cmp_rev HEAD^ copy &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified again"
+'
+
+test_expect_success 'pull --no-autostash & pull.rebase=true' '
+	test_config pull.rebase true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --no-autostash . copy 2>err &&
+	test_i18ngrep "Cannot pull with rebase: Your index contains uncommitted changes." err
+'
+
 test_expect_success 'branch.to-rebase.rebase' '
 	git reset --hard before-rebase &&
 	test_config branch.to-rebase.rebase true &&
-- 
2.7.1.340.g69eb491.dirty
