From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH 1/2] log: add "log.showsignature" configuration variable
Date: Sun,  5 Jun 2016 21:09:32 +0530
Message-ID: <20160605153933.15231-2-mehul.jain2029@gmail.com>
References: <20160605153933.15231-1-mehul.jain2029@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 05 17:40:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b9aAL-0008Q1-Lo
	for gcvg-git-2@plane.gmane.org; Sun, 05 Jun 2016 17:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbcFEPkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2016 11:40:37 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33562 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbcFEPkg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2016 11:40:36 -0400
Received: by mail-pa0-f68.google.com with SMTP id di3so9911745pab.0
        for <git@vger.kernel.org>; Sun, 05 Jun 2016 08:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ePZ9ZolaOOV09Q4nVVw3+PmXnuAKMJraKRevFOdKf2U=;
        b=Wa0MZ1s6lRw87C049d+jMDSuIyFPznUyK0nWmM856sCzWEIBJfyd2nF64yKCI11T8c
         gYzkKVbHYQyzr9H5MM3x9ZdBHhOg7lzssTuBPMjJ0I0EjBNx7BuDjHkq07t0D1boJcyu
         qNw/3GsI9GsXYWpXrkf6HtWvGNL52vHSU9ZgnL027UNZRuC15q0/mKUNtmSWz3Kbzkgy
         9KDUmwNoVm0xf0hS8ODvAdXpVqhkfuKhoM+NQ+/xXTHsC9xZc4tGpJgoq+qkzMwAqR/M
         7iAa00M3Ub5yXBQwoQFa+P4HHe3MbpD67j+wQBk+1BELF6M/sdUa2/lsmdijmzdKqfL5
         hMEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ePZ9ZolaOOV09Q4nVVw3+PmXnuAKMJraKRevFOdKf2U=;
        b=ki7V1ER2f2lO/S3TI1l15RAzXiZb/MulxtaU29PIY+O7Izql69YBzz8LuxV+iSyTOV
         IT1NPhf6DE2I5vMcyqXzdvSLDqy/DFWl1almYOutzfCeUN8OBDzW2a1plPPw/wyMjfci
         kHOzY5H3WTbEocjC5jPFKcJ2sOx3uDQJebgSYjoHCXYM0SIDFv0YQ7qYU6VuRUurW4x3
         rB/bWRNLJ1T8RZtLX0RJjKwIAS6CPxePMmiVBAsf7RAliAozW10+DASr1ckK7DlxBquf
         vibCOFPnsmSHuNAWMAbo0bukRtwek/q520P2IyV8EXrg4Q2YJWwt9w9HGGUzd607BiIp
         kTbA==
X-Gm-Message-State: ALyK8tK4+F1ty7Ljk2YdwI/ZUoKB6Q7rnu4pse9Az3GgDmsb4zQQYW16z1EApGrgDzy4uw==
X-Received: by 10.66.65.109 with SMTP id w13mr18756138pas.142.1465141235154;
        Sun, 05 Jun 2016 08:40:35 -0700 (PDT)
Received: from localhost.localdomain ([182.67.205.35])
        by smtp.gmail.com with ESMTPSA id p1sm21307814pfb.73.2016.06.05.08.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 05 Jun 2016 08:40:34 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.dirty
In-Reply-To: <20160605153933.15231-1-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296475>

People may want to always use "--show-signature" while using "git log"
and related commands.

When log.showSignature is set to true, "git log" and related commands
will behave as if "--show-signature" was given to them.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 Documentation/git-log.txt |  4 ++++
 builtin/log.c             |  6 ++++++
 t/t4202-log.sh            | 19 +++++++++++++++++++
 t/t7510-signed-commit.sh  |  7 +++++++
 4 files changed, 36 insertions(+)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 03f9580..bbb5adc 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -196,6 +196,10 @@ log.showRoot::
 	`git log -p` output would be shown without a diff attached.
 	The default is `true`.
 
+log.showSignature::
+	If `true`, `git log` and related commands will act as if the
+	`--show-signature` option was passed to them.
+
 mailmap.*::
 	See linkgit:git-shortlog[1].
 
diff --git a/builtin/log.c b/builtin/log.c
index 099f4f7..7103217 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -33,6 +33,7 @@ static const char *default_date_mode = NULL;
 static int default_abbrev_commit;
 static int default_show_root = 1;
 static int default_follow;
+static int default_show_signature;
 static int decoration_style;
 static int decoration_given;
 static int use_mailmap_config;
@@ -119,6 +120,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->abbrev_commit = default_abbrev_commit;
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
+	rev->show_signature = default_show_signature;
 	DIFF_OPT_SET(&rev->diffopt, ALLOW_TEXTCONV);
 
 	if (default_date_mode)
@@ -409,6 +411,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		use_mailmap_config = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "log.showsignature")) {
+		default_show_signature = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (grep_config(var, value, cb) < 0)
 		return -1;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 128ba93..3e4a4ac 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -890,6 +890,25 @@ test_expect_success GPG 'log --graph --show-signature for merged tag' '
 	grep "^| | gpg: Good signature" actual
 '
 
+test_expect_success GPG 'log.showsignature=true behaves like --show-signature' '
+	git checkout -b test_sign master &&
+	echo foo >foo &&
+	git add foo &&
+	git commit -S -m signed_commit &&
+	test_config log.showsignature true &&
+	git log -1 signed >actual &&
+	grep "gpg: Signature made" actual &&
+	grep "gpg: Good signature" actual
+'
+
+test_expect_success GPG '--show-signature overrides log.showsignature=false' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	test_config log.showsignature false &&
+	git log -1 --show-signature signed >actual &&
+	grep "gpg: Signature made" actual &&
+	grep "gpg: Good signature" actual
+'
+
 test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 4177a86..6e839f5 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -210,4 +210,11 @@ test_expect_success GPG 'show lack of signature with custom format' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'log.showsignature behaves like --show-signature' '
+	test_config log.showsignature true &&
+	git show initial >actual &&
+	grep "gpg: Signature made" actual &&
+	grep "gpg: Good signature" actual
+'
+
 test_done
-- 
2.9.0.rc0.dirty
