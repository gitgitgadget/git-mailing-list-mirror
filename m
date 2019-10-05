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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F2881F4BD
	for <e@80x24.org>; Sat,  5 Oct 2019 08:43:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfJEIn4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 04:43:56 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41757 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbfJEIn4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 04:43:56 -0400
Received: by mail-ed1-f67.google.com with SMTP id f20so8067286edv.8
        for <git@vger.kernel.org>; Sat, 05 Oct 2019 01:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQL7En6aaQYk5Sd8eemK9WMc5xmNRPeL5XNIa1lxEgM=;
        b=e3UQWGuI6ShYsu9S7eTz3uyu5ztj5ccE0Khxv+ELIDji9TjgTR6SfPjBAohCET98Uw
         7rpOqSSlDNAS7SfrHMySroF4RZGgRLwWUPwVcvmTOj1GuFdbjwlgtCzUq1/KH/qYv3z5
         Cc4X/oheqvRikQXwLw7zUSLazREa/4IDJI7INUcpGIbQKrS4MfICj6WPCA6ThK/71StA
         YGBAAFEZKr6PJvTjtvC/LcC+MS9tkMVm4T7H8XmoH7szoGmQCoKKpOeWl8QbQCviSjIB
         MOifPviXUQs0MW+EU8gE4lb4DUOZYbsxqmYh+k2FyJG2NgwAMxMwbsy6nGMYRm6Whfsy
         5x/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NQL7En6aaQYk5Sd8eemK9WMc5xmNRPeL5XNIa1lxEgM=;
        b=Bm7KmKyOtSXDU8Xn69kX+KLHds8Hmm2XdHq3DIiiGEhQBZn7wQiZ/7J7O58Yu+ta99
         iAj0dOUFrxXIveKhUWbySbQwYJ9bdINMtWssuM/mpM/gE2B3uT38DY18K8GA+m0fySV/
         JutYEj5EEjtd6r2IOmuKv3HrfUyDCCrXiZK/ZkLpIrADuV4R2Y6r0zxHFxyNJc0vMgWw
         mBMGEpl4e7eDkkGNJ5L6k1a6wqGfgoqBHHxx45sH0Af0BQA7qdIrt5VKEAdm9lQC+SLJ
         cJqlrJetWeEbUTuqTH/7XVZnLk+6hF0GCaJ1NVRhcHGaY9VqBWTl6ak2Vk4W5X0v3fk6
         AuUw==
X-Gm-Message-State: APjAAAUUDQDe877bWe0/n8YxmsKCf69Lag9+Bosp9WygdzJhJy3rsMJP
        o2ejdH4J/a0kLYZEYSw=
X-Google-Smtp-Source: APXvYqxfxbmkrKEvwKo0uwt3jsFJuqCduhp7Jvv/jVKlMqA/aUwPwU+UeYBh/CvIR6knemNjlzeBaA==
X-Received: by 2002:a17:906:839a:: with SMTP id p26mr15574467ejx.94.1570265034082;
        Sat, 05 Oct 2019 01:43:54 -0700 (PDT)
Received: from localhost ([2a02:810a:8c80:d2c:4d89:574b:af6e:1a3])
        by smtp.gmail.com with ESMTPSA id nd2sm928507ejb.8.2019.10.05.01.43.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 05 Oct 2019 01:43:53 -0700 (PDT)
From:   Bert Wesarg <bert.wesarg@googlemail.com>
To:     git@vger.kernel.org
Cc:     Bert Wesarg <bert.wesarg@googlemail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v2 1/2] format-patch: create leading components of output directory
Date:   Sat,  5 Oct 2019 10:43:51 +0200
Message-Id: <2b8b000d76a20349f1f9e09260eff91429beebfb.1570264824.git.bert.wesarg@googlemail.com>
X-Mailer: git-send-email 2.23.0.11.g242cf7f110
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

--- 

ChangeLog:

v2:
 * squashed and base new tests on 'dl/format-patch-doc-test-cleanup'

Cc: Denton Liu <liu.denton@gmail.com>
---
 Documentation/config/format.txt    |  2 +-
 Documentation/git-format-patch.txt |  3 ++-
 builtin/log.c                      |  8 ++++++++
 t/t4014-format-patch.sh            | 20 ++++++++++++++++++++
 4 files changed, 31 insertions(+), 2 deletions(-)

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
index c4b35fdaf9..294534aacb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1770,6 +1770,14 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			rev.diffopt.use_color = GIT_COLOR_NEVER;
 		if (use_stdout)
 			die(_("standard output, or directory, which one?"));
+		switch (safe_create_leading_directories_const(output_directory)) {
+		case SCLD_OK:
+		case SCLD_EXISTS:
+			break;
+		default:
+			die(_("could not create leading directories "
+			      "of '%s'"), output_directory);
+		}
 		if (mkdir(output_directory, 0777) < 0 && errno != EEXIST)
 			die_errno(_("could not create directory '%s'"),
 				  output_directory);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 83f52614d3..2f2cd6fea6 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1606,6 +1606,26 @@ test_expect_success 'From line has expected format' '
 	test_cmp from filtered
 '
 
+test_expect_success 'format-patch -o with no leading directories' '
+	rm -fr patches &&
+	git format-patch -o patches master..side &&
+	git rev-list master..side >list &&
+	test_line_count = $(ls patches | wc -l) list
+'
+
+test_expect_success 'format-patch -o with leading existing directories' '
+	git format-patch -o patches/side master..side &&
+	git rev-list master..side >list &&
+	test_line_count = $(ls patches/side | wc -l) list
+'
+
+test_expect_success 'format-patch -o with leading non-existing directories' '
+	rm -fr patches &&
+	git format-patch -o patches/side master..side &&
+	git rev-list master..side >list &&
+	test_line_count = $(ls patches/side | wc -l) list
+'
+
 test_expect_success 'format-patch format.outputDirectory option' '
 	test_config format.outputDirectory patches &&
 	rm -fr patches &&
-- 
2.23.0.11.g242cf7f110

