From: Mehul Jain <mehul.jain2029@gmail.com>
Subject: [RFC/PATCH 1/2] log: add "log.showsignature" configuration variable
Date: Thu, 26 May 2016 18:36:46 +0530
Message-ID: <20160526130647.27001-2-mehul.jain2029@gmail.com>
References: <20160526130647.27001-1-mehul.jain2029@gmail.com>
Cc: Austin English <austinenglish@gmail.com>,
	Mehul Jain <mehul.jain2029@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 26 15:08:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5v1x-0006Vt-Pw
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 15:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753962AbcEZNIv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 09:08:51 -0400
Received: from mail-pa0-f67.google.com ([209.85.220.67]:34834 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753843AbcEZNIu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 09:08:50 -0400
Received: by mail-pa0-f67.google.com with SMTP id gp3so2254754pac.2
        for <git@vger.kernel.org>; Thu, 26 May 2016 06:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1uQAxHpcvAST3l0yp9cBusGsTKRyVvSkyKngQwMb3cQ=;
        b=rptCTP3ZZV96RZ122YTjhdtsG3r5+bJEr5yKgbJtSV72b6+tYoIZ2cBALb8N4W81BQ
         PQZoJfg8IPX4pATSyJAYeGEZUWXwIYJd54t9Aw5whJBQfm6HmITNm57hm/pGWy7sEGRV
         b+VVCCZW79KgHsLYqXC2eJIW7nzXesIVvYBYXX5dgLIxbOP2I6Nq+NpHRo6Zg1IDuKQP
         1ETI1HFeSHk/gkvHNa5qSyl6K4paDOyMdBaVU7cGLlSiC/r02TDFmNdLcJV1JNYJSlGO
         mfUaS/Is5kHjI0kZ6brFMSf3HROz7kXdFIZY0XKpHNjGuvUq3pypfBBroJpIbatNfUZn
         u8kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1uQAxHpcvAST3l0yp9cBusGsTKRyVvSkyKngQwMb3cQ=;
        b=eBh3PPVNPf+7mfQo+mXynb/kdBdG2Z+NCZFG7L7FDaekMYcFDkZug0ujW2uxXFikiu
         wgm9/TDnPyTbsPbv6nswJZ6nGu/dkHwv6aDlHwUAn6vEJPpJdRHOD+4OhyyEdfEimNB5
         BjfmOE+5zDM6mFmpd8ldkBAZhD5zxi5K6gjQg+gfYdqQk1EevW5CePOPUHsRi0Pjq3ix
         ui5+FZD73jH5T1fUXw4kCy7AOca460BTTy68Y2ZyUHVyE2uHpEmr9tqDXX/nQyF4DPDr
         wK/P5cOkBUZQCdkg5Rbpdv8i9tvAYey2uKuL5YNKJ04bv7bb5pKPTDKkJeS0dJ3vCBi3
         pK6A==
X-Gm-Message-State: ALyK8tKV6f+x4lAjxVK6bZlEgBysVH+efqlREFiFe5Ey/mCZFO+7gBHs3FwmsgqnmXXiBg==
X-Received: by 10.66.26.16 with SMTP id h16mr13755932pag.154.1464268129141;
        Thu, 26 May 2016 06:08:49 -0700 (PDT)
Received: from localhost.localdomain ([223.176.135.41])
        by smtp.gmail.com with ESMTPSA id vi6sm20547504pab.21.2016.05.26.06.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 26 May 2016 06:08:48 -0700 (PDT)
X-Mailer: git-send-email 2.9.0.rc0.dirty
In-Reply-To: <20160526130647.27001-1-mehul.jain2029@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295648>

People may want to always use "--show-signature" while using "git log"
or "git show".

When log.showsignature set true, "git log" and "git show" will behave
as "--show-signature" was given to them.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 Documentation/git-log.txt |  4 ++++
 builtin/log.c             |  6 ++++++
 t/t4202-log.sh            | 19 +++++++++++++++++++
 t/t7510-signed-commit.sh  |  7 +++++++
 4 files changed, 36 insertions(+)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 03f9580..f39f800 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -196,6 +196,10 @@ log.showRoot::
 	`git log -p` output would be shown without a diff attached.
 	The default is `true`.
 
+log.showSignature::
+	If `true`, `git log` and `git show` will act as if `--show-signature`
+	option was passed to them.
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
index 128ba93..36be9a1 100755
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
+	test_i18ngrep "gpg: Signature made" actual &&
+	test_i18ngrep "gpg: Good signature" actual
+'
+
+test_expect_success GPG '--show-signature overrides log.showsignature=false' '
+	test_when_finished "git reset --hard && git checkout master" &&
+	git config log.showsignature false &&
+	git log -1 --show-signature signed >actual &&
+	test_i18ngrep "gpg: Signature made" actual &&
+	test_i18ngrep "gpg: Good signature" actual
+'
+
 test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 4177a86..326dcc8 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -210,4 +210,11 @@ test_expect_success GPG 'show lack of signature with custom format' '
 	test_cmp expect actual
 '
 
+test_expect_success GPG 'log.showsignature behaves like --show-signature' '
+	git config log.showsignature true &&
+	git show initial > actual &&
+	test_i18ngrep "gpg: Signature made" actual &&
+	test_i18ngrep "gpg: Good signature" actual
+'
+
 test_done
-- 
2.9.0.rc0.dirty
