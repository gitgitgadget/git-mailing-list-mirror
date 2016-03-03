From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v3 2/3] test: add test for --[no-]autostash flag
Date: Thu,  3 Mar 2016 21:43:20 +0530
Message-ID: <1457021601-9099-2-git-send-email-mehul.jain2029@gmail.com>
References: <1456594902-21182-1-git-send-email-mehul.jain2029@gmail.com>
 <1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
Cc: pyokagan@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 17:14:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abVtk-0004Xf-9U
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 17:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932527AbcCCQOj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 11:14:39 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34147 "EHLO
	mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932169AbcCCQOi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 11:14:38 -0500
Received: by mail-pf0-f194.google.com with SMTP id 184so1518436pff.1
        for <git@vger.kernel.org>; Thu, 03 Mar 2016 08:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qaPhJtEhmrqmjdidlgP+Ijjaevt/JW2KdK4reIJrprs=;
        b=BZ5uIKuw02GAq58uIdksI4Q+3c7P/bGhliWC4gu+jlRmC1egE5IqQ4ZizkqlGD+vRQ
         aaBXl5UM5wXYMsyks88f8qCFzy+iNlEwOubANu+gdx3FMOLz1DnQBxUSB2ErXB31fiOO
         uvXMCvlxh6JYkBOaJDUWytCUnb89n44b86Fu/iSLIdFf8Jy6TM/rkdNii1/oEiZPtSli
         lUCMYw9S8q5qIGz6SkmKopj/z/DM7Do/E4ksS++q2dqCHpJJxljgUOP5Iz2Zun2kF8Ri
         anx9Bl4gzfsqx95kdGHKBcNiR8OR+yrS5JZO3YQbled46qUJ6tCeiqLsz5AF0/dptQOP
         uZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qaPhJtEhmrqmjdidlgP+Ijjaevt/JW2KdK4reIJrprs=;
        b=Qqwx7UgvU2uAwAqZ4fA8W2CDsdEFmQpDEY4nyVCB56WKI9cyJU9+1ZxuLCtpdaQThM
         VGxhQOkH7qmipPBqCjnZK+AhyV5dBFfLPtIWYbwOoRW8L2o/3dOOParHWTydKOOzW21y
         LJcIGaSxJqbVjd8Arnzd/Rofur0NqcQ5UXqewDgD/sPUY/KqlVOipkwraZtjmjyyBz0L
         KnqLd3T3kJpL5KB3xrAum3FkyYVLK3gpzyKg0p6AgTohlZ5CNCi1tKI2DShTNm88r+x0
         QZxwa65QutvNe+cmvFugKUrzFFrm8j3M+3PD8PzxmgEurLIwa2InxTB5Mg+l9yB9UnLA
         6iGQ==
X-Gm-Message-State: AD7BkJKCAAHiOMW6rv34DvdyeSlSg7MCOdW/xuE2kaSZN8zAhVcWoDseMt1VUlRYqIN1gw==
X-Received: by 10.98.7.219 with SMTP id 88mr4779984pfh.49.1457021677952;
        Thu, 03 Mar 2016 08:14:37 -0800 (PST)
Received: from localhost.localdomain ([1.39.36.239])
        by smtp.gmail.com with ESMTPSA id z5sm30337230par.21.2016.03.03.08.14.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Mar 2016 08:14:37 -0800 (PST)
X-Mailer: git-send-email 2.7.1.340.g69eb491.dirty
In-Reply-To: <1457021601-9099-1-git-send-email-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288187>

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 t/t5520-pull.sh         | 19 +++++++++++++++++++
 t/t5521-pull-options.sh | 16 ++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c952d5e..f5d1d31 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -245,6 +245,25 @@ test_expect_success '--rebase fails with multiple branches' '
 	test modified = "$(git show HEAD:file)"
 '
 
+test_expect_success 'pull --rebase --no-autostash fails with dirty working directory and rebase.autstash set true' '
+	test_config rebase.autostash true &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	test_must_fail git pull --rebase --no-autostash . copy
+'
+
+test_expect_success 'pull --rebase --autostash succeeds with dirty working directory and rebase.autstash set false' '
+	test_config rebase.autostash false &&
+	git reset --hard before-rebase &&
+	echo dirty >new_file &&
+	git add new_file &&
+	git pull --rebase --autostash . copy &&
+	test_cmp_rev HEAD^ copy &&
+	test "$(cat new_file)" = dirty &&
+	test "$(cat file)" = "modified again"
+'
+
 test_expect_success 'pull --rebase succeeds with dirty working directory and rebase.autostash set' '
 	test_config rebase.autostash true &&
 	git reset --hard before-rebase &&
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 18372ca..3930e45 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -62,6 +62,22 @@ test_expect_success 'git pull -v --rebase' '
 	test_must_be_empty out)
 '
 
+test_expect_success 'git pull --rebase --autostash' '
+	mkdir clonedrbas &&
+	(cd clonedrbas  && git init &&
+	git pull --rebase --autostash "../parent" >out 2>err &&
+	test -s err &&
+	test_must_be_empty out)
+'
+
+test_expect_success 'git pull --rebase --no-autostash' '
+	mkdir clonedrbnas &&
+	(cd clonedrbnas  && git init &&
+	git pull --rebase --no-autostash "../parent" >out 2>err &&
+	test -s err &&
+	test_must_be_empty out)
+'
+
 test_expect_success 'git pull -v -q' '
 	mkdir clonedvq &&
 	(cd clonedvq && git init &&
-- 
2.7.1.340.g69eb491.dirty
