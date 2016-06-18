Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7170F20189
	for <e@80x24.org>; Sat, 18 Jun 2016 12:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751679AbcFRMZo (ORCPT <rfc822;e@80x24.org>);
	Sat, 18 Jun 2016 08:25:44 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33335 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751674AbcFRMZn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jun 2016 08:25:43 -0400
Received: by mail-pa0-f68.google.com with SMTP id ts6so7569004pac.0
        for <git@vger.kernel.org>; Sat, 18 Jun 2016 05:25:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SyOoDFo6OnrXHMYq98zA5AgyvgsFrHIKGAqxJv4cVT4=;
        b=pa9wflFSXSKK1IcXMo95OXGDpHY5PYCOpIOSpZYMZFQRHBCjwv/BjPsCT+ugDLFCAa
         u30dkP8v8Xt7VtuEl4wqgp1VS5XfZMgyfFd/qjwuKGXxH5bCf9KXRfoMpArRs8pVQdOa
         jDgjKuRTMR6fp9+j3gQzqv6m2RoG9gmfOiy0UuwXZEneYLeRbpY005n6/eQGMp0fyVzr
         JOUQidtOGQ0fiSGYK+WrKluExQJA/hG1/qGwKbj7KQ+RMdViJwT5Fl6MZxnrt8P34uxF
         Khe5xDsx0XOfMAZ5yGWkzeh2T2cC0/pkyCqUsB+4Ka+iu3aZ2aLdRmTSFRnWmh/Si7cq
         ITJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SyOoDFo6OnrXHMYq98zA5AgyvgsFrHIKGAqxJv4cVT4=;
        b=IlMDFiifZ4dbpNJVrL6ABuHGAZvd/KDNjkVynz/ACl2+6wJkUvrB9iQSV8CAjjOh6M
         tDAV4LiLSmS3kYOX6uWF1YA6PEuKSx8b0swOmm3iROLYCjN5D2ke8Q2dXRmFvozzGJ+7
         SUNJn3aWt0Mg4EFNzxBjB0/zNj9VTrixK86j31mXwTU7+nBV/DfTvY9jMvfTk8jYctUg
         vqSfGO6QOICgXf5QqxWuk6wyb8gno2ChfDu4jtDRoE9MmhHUqIQMRS4vPgYcvn8XYDQr
         3Fv/yycZrzQtL2wThxPtMe0hH6tjTjxlkMacTEsM2FwgRxJdBu/WUHSLKFGddkB8jG1v
         QYMQ==
X-Gm-Message-State: ALyK8tKqPYv8a/+VfF+YdbbVtVhiimXoHnymW7o3Jz4lMWBpKQLMflBzDB/EIFZnEnOb0g==
X-Received: by 10.66.122.196 with SMTP id lu4mr8694025pab.52.1466252742536;
        Sat, 18 Jun 2016 05:25:42 -0700 (PDT)
Received: from localhost.localdomain ([223.176.148.194])
        by smtp.gmail.com with ESMTPSA id y63sm48966279pfb.13.2016.06.18.05.25.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Jun 2016 05:25:41 -0700 (PDT)
From:	Mehul Jain <mehul.jain2029@gmail.com>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	Mehul Jain <mehul.jain2029@gmail.com>
Subject: [PATCH v2 2/2] log: add log.showSignature configuration variable
Date:	Sat, 18 Jun 2016 17:55:10 +0530
Message-Id: <20160618122510.5105-3-mehul.jain2029@gmail.com>
X-Mailer: git-send-email 2.9.0.rc0.dirty
In-Reply-To: <20160618122510.5105-1-mehul.jain2029@gmail.com>
References: <20160618122510.5105-1-mehul.jain2029@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Users may want to always use "--show-signature" while using git-log and
related commands.

When log.showSignature is set to true, git-log and related commands will
behave as if "--show-signature" was given to them.

Note that this config variable is meant to affect git-log, git-show,
git-whatchanged and git-reflog. Other commands like git-format-patch,
git-rev-list are not to be affected by this config variable.

Signed-off-by: Mehul Jain <mehul.jain2029@gmail.com>
---
 Documentation/git-log.txt |  4 ++++
 builtin/log.c             |  6 ++++++
 t/t4202-log.sh            | 25 +++++++++++++++++++++++++
 t/t7510-signed-commit.sh  |  7 +++++++
 4 files changed, 42 insertions(+)

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
index 02384a3..63ed863 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -900,6 +900,31 @@ test_expect_success GPG '--no-show-signature overrides --show-signature' '
 	! grep "^gpg:" actual
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
+test_expect_success GPG '--no-show-signature overrides log.showsignature=true' '
+	test_config log.showsignature true &&
+	git log -1 --no-show-signature signed >actual &&
+	! grep "^gpg:" actual
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

