Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78D71F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 08:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfJKIgr (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 04:36:47 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39996 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbfJKIgq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 04:36:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id h4so10902608wrv.7
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 01:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fA2/E8HHC+cpK3GTSbSesZItRx+MnJHZzV0+oKp6okY=;
        b=Tzsyk+YWLX2tja4c5GoFOtX2WjWUiKDTGfXtwN3JkrZteHeFEf4oJ80mF2uHjq53FU
         ARL6kBVfoIe580TCkCyzXd4bgG2/J6gViS92oinm1JoohbI7Qyj1gCgak29sLsNJfdew
         6tiNNVSOZ9KQeb92y7Mk8s6VA4zmh88lP+pjzHLjcrVrjeVJLAzTAQmvJW1DOP9ipXVK
         mNi1vpiepgzKpbhGtJLvAP5Hqh61AGiCgwzi8IfiXVqkQECzpTIAMs5t0N7R2PIGwKEk
         c0s6400333UDUkkP+dgjGbbDkFVcftJn14wjnH7GQifDVFZwpCgeomVQ7IAcIhHFikoQ
         TEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fA2/E8HHC+cpK3GTSbSesZItRx+MnJHZzV0+oKp6okY=;
        b=ekd/1X3EAiGCXDzpl4So8q1/Vn0vY8epW4RjR4kVpUTShL8DuNYZQu/fvJYHUCwSCI
         voUIJHyexJ71FDlcif1U0pttz0UX4ZARtUN7RSBckUB/F2TxCA2XZ6S7R/pD9mAKq3HX
         jdyp86jyQ1O3G51sIVEPeYXpfoTi1ImLZ3eMq2tMNZJR7BazIjEXgJWN8dq3tIVUn3F3
         qGAKH329i3sNnoveBuwR3UHA9dXsuuhJ+gkuTPC9k/CiRngNBjHqDF3mDeGfIZyouxiJ
         Lt5DdOYB2M2x33l+2pGQHdy70w/W66TB2Clha9TWj9z0qRLQYuCs65MsxDS5EDq25AaP
         tE7g==
X-Gm-Message-State: APjAAAV7YmaSWOPl9XW1AIdL95injCn7ujCu6A9wRzoe8gDpQ6l5cCVX
        JrK25Mxs7K+nfx2UkJQ=
X-Google-Smtp-Source: APXvYqxNSIOERRMKNEo95LT32ARt9WpAwvL62Qh1onRAec/rZb+TQMp/JX5eMsf1U+HO8M/BSCrsbw==
X-Received: by 2002:a5d:4341:: with SMTP id u1mr12332225wrr.306.1570783003623;
        Fri, 11 Oct 2019 01:36:43 -0700 (PDT)
Received: from localhost (m221.zih.tu-dresden.de. [141.30.68.221])
        by smtp.gmail.com with ESMTPSA id b7sm9697234wrx.56.2019.10.11.01.36.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Oct 2019 01:36:43 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v4 1/2] format-patch: create leading components of output directory
Date:   Fri, 11 Oct 2019 10:36:41 +0200
Message-Id: <b172eba0b748c3f0f638786a5cfba905aca385cc.1570782773.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.13.g28bc381d7c
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git format-patch -o <outdir>' did an equivalent of 'mkdir <outdir>'
not 'mkdir -p <outdir>', which is being corrected.

Avoid the usage of 'adjust_shared_perm' on the leading directories which
may have security implications. Achieved by temporarily disabling of
'config.sharedRepository' like 'git init' does.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

Changes in v2:
 * squashed and base new tests on 'dl/format-patch-doc-test-cleanup'

Changes in v3:
 * avoid applying adjust_shared_perm

Changes in v4:
 * based on dl/format-patch-doc-test-cleanup and adopt it

Cc: Denton Liu <liu.denton@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: SZEDER Gábor <szeder.dev@gmail.com>
---
 Documentation/config/format.txt    |  2 +-
 Documentation/git-format-patch.txt |  3 ++-
 builtin/log.c                      | 16 ++++++++++++++++
 t/t4014-format-patch.sh            | 23 +++++++++++++++++++++++
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index cb629fa769..40cad9278f 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -81,7 +81,7 @@ format.coverLetter::
 
 format.outputDirectory::
 	Set a custom directory to store the resulting files instead of the
-	current working directory.
+	current working directory. All directory components will be created.
 
 format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 0ac56f4b70..2035d4d5d5 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -66,7 +66,8 @@ they are created in the current working directory. The default path
 can be set with the `format.outputDirectory` configuration option.
 The `-o` option takes precedence over `format.outputDirectory`.
 To store patches in the current working directory even when
-`format.outputDirectory` points elsewhere, use `-o .`.
+`format.outputDirectory` points elsewhere, use `-o .`. All directory
+components will be created.
 
 By default, the subject of a single patch is "[PATCH] " followed by
 the concatenation of lines from the commit message up to the first blank
diff --git a/builtin/log.c b/builtin/log.c
index 44b10b3415..8d08632858 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1765,10 +1765,26 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		setup_pager();
 
 	if (output_directory) {
+		int saved;
 		if (rev.diffopt.use_color != GIT_COLOR_ALWAYS)
 			rev.diffopt.use_color = GIT_COLOR_NEVER;
 		if (use_stdout)
 			die(_("standard output, or directory, which one?"));
+		/*
+		 * We consider <outdir> as 'outside of gitdir', therefore avoid
+		 * applying adjust_shared_perm in s-c-l-d.
+		 */
+		saved = get_shared_repository();
+		set_shared_repository(0);
+		switch (safe_create_leading_directories_const(output_directory)) {
+		case SCLD_OK:
+		case SCLD_EXISTS:
+			break;
+		default:
+			die(_("could not create leading directories "
+			      "of '%s'"), output_directory);
+		}
+		set_shared_repository(saved);
 		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
 			die_errno(_("could not create directory '%s'"),
 				  output_directory);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 72b09896cf..9facc3a79e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1606,6 +1606,29 @@ test_expect_success 'From line has expected format' '
 	test_cmp from filtered
 '
 
+test_expect_success 'format-patch -o with no leading directories' '
+	rm -fr patches &&
+	git format-patch -o patches master..side &&
+	count=$(git rev-list --count master..side) &&
+	ls patches >list &&
+	test_line_count = $count list
+'
+
+test_expect_success 'format-patch -o with leading existing directories' '
+	git format-patch -o patches/side master..side &&
+	count=$(git rev-list --count master..side) &&
+	ls patches/side >list &&
+	test_line_count = $count list
+'
+
+test_expect_success 'format-patch -o with leading non-existing directories' '
+	rm -fr patches &&
+	git format-patch -o patches/side master..side &&
+	count=$(git rev-list --count master..side) &&
+	ls patches/side >list &&
+	test_line_count = $count list
+'
+
 test_expect_success 'format-patch format.outputDirectory option' '
 	test_config format.outputDirectory patches &&
 	rm -fr patches &&
-- 
2.23.0.13.g28bc381d7c

