Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 430791FBF4
	for <e@80x24.org>; Mon, 30 Oct 2017 17:22:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932683AbdJ3RWF (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Oct 2017 13:22:05 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:44093 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbdJ3RV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Oct 2017 13:21:59 -0400
Received: by mail-qk0-f196.google.com with SMTP id r64so17120907qkc.1
        for <git@vger.kernel.org>; Mon, 30 Oct 2017 10:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eTohLDxm7s5le41C4S3bfkdJ10QyHH84ghgzjd4cKbM=;
        b=WNk9JaTMiAlq7xXrFtasQK2Uu60ipmcSbkMnqiUQcf99Ri7qiPbAS7vJVw4Qj/8xcO
         yHUf2S3Tr6aNhXZd6fyhwYB2IilD2yYIYOALZh5ixn3H3udfDdCIK5y21cAWZ92A1dNO
         ZL6XwkVqi5EpjmVW39sWUeqx4FWO3ba8p6R2BUFzH6Ze5oFOb/7Ia/2kijAkOcsRrICy
         YdDK5s9Upx7EJ4NVZM8CInGJDOBN5Gy4MoTs77t9LCu9P4VZJ5LYq9mEhGTANPkfPTHy
         8k4MUyFXIYt2cqGjz+/dwxt56bBf7AB4VGwiwBKVyrP6RstdMJDbE/PUMXx7Ct73kVuj
         NOyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eTohLDxm7s5le41C4S3bfkdJ10QyHH84ghgzjd4cKbM=;
        b=FYgsvANAlfQsWxg6fXnnrYHoO7ViAsXWKmRFLPHjX3YpBovQHlOxc2WRMclB9rNSvo
         ImQsd8ORJUyCwnM5uICTyp/VMrvuESFYMITZYfRH5nAlzIxqfhQM3jijWc831qR2qhS7
         6JXUs32w47MVTSkAnY2Gf88daQ5PmP8UKwFQBHf8dMr3zSj3oWOYjCbdLHmPXZe1v7CF
         VuTNUP3CKELRmdnbTZOQqNLd6zJSxEumFnwMw0inI09/frNrEJjSUHXJN2rKiPX1UJIF
         sZJ0udbfQ0tzmc+U/8Y2L2S9k8QiX0pvKU0AKNZNukbw+jrViMlEVHYkeMJNQZkLBM0M
         gbKQ==
X-Gm-Message-State: AMCzsaU031V4SlSivrNNXKB3tkH/vXDAUWdx9VwZDY/m3xeD2ZoJcgzU
        o0chG8w5huJkzAdtNW9ZUoM=
X-Google-Smtp-Source: ABhQp+SNqI+DJULiETCR6+JK4UUk+scgYseEM2uRUdYwMXOcUtBYv437nnm+SXR8+Ht6YB5wCdEX2w==
X-Received: by 10.55.166.77 with SMTP id p74mr14442190qke.264.1509384118743;
        Mon, 30 Oct 2017 10:21:58 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id n23sm9670119qka.1.2017.10.30.10.21.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Oct 2017 10:21:58 -0700 (PDT)
From:   jameson.miller81@gmail.com
X-Google-Original-From: jamill@microsoft.com
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v5 4/4] status: test ignored modes
Date:   Mon, 30 Oct 2017 13:21:40 -0400
Message-Id: <20171030172140.235797-5-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171030172140.235797-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171030172140.235797-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

Add tests around status reporting ignord files that match an exclude
pattern for both --untracked-files=normal and --untracked-files=all.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 t/t7521-ignored-mode.sh | 233 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 233 insertions(+)
 create mode 100755 t/t7521-ignored-mode.sh

diff --git a/t/t7521-ignored-mode.sh b/t/t7521-ignored-mode.sh
new file mode 100755
index 0000000000..91790943c3
--- /dev/null
+++ b/t/t7521-ignored-mode.sh
@@ -0,0 +1,233 @@
+#!/bin/sh
+
+test_description='git status ignored modes'
+
+. ./test-lib.sh
+
+test_expect_success 'setup initial commit and ignore file' '
+	cat >.gitignore <<-\EOF &&
+	*.ign
+	ignored_dir/
+	!*.unignore
+	EOF
+	git add . &&
+	git commit -m "Initial commit"
+'
+
+test_expect_success 'Verify behavior of status on directories with ignored files' '
+	test_when_finished "git clean -fdx" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	! dir/ignored/ignored_1.ign
+	! dir/ignored/ignored_2.ign
+	! ignored/ignored_1.ign
+	! ignored/ignored_2.ign
+	EOF
+
+	mkdir -p ignored dir/ignored &&
+	touch ignored/ignored_1.ign ignored/ignored_2.ign \
+		dir/ignored/ignored_1.ign dir/ignored/ignored_2.ign &&
+
+	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'Verify status behavior on directory with tracked & ignored files' '
+	test_when_finished "git clean -fdx && git reset HEAD~1 --hard" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	! dir/tracked_ignored/ignored_1.ign
+	! dir/tracked_ignored/ignored_2.ign
+	! tracked_ignored/ignored_1.ign
+	! tracked_ignored/ignored_2.ign
+	EOF
+
+	mkdir -p tracked_ignored dir/tracked_ignored &&
+	touch tracked_ignored/tracked_1 tracked_ignored/tracked_2 \
+		tracked_ignored/ignored_1.ign tracked_ignored/ignored_2.ign \
+		dir/tracked_ignored/tracked_1 dir/tracked_ignored/tracked_2 \
+		dir/tracked_ignored/ignored_1.ign dir/tracked_ignored/ignored_2.ign &&
+
+	git add tracked_ignored/tracked_1 tracked_ignored/tracked_2 \
+		dir/tracked_ignored/tracked_1 dir/tracked_ignored/tracked_2 &&
+	git commit -m "commit tracked files" &&
+
+	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'Verify status behavior on directory with untracked and ignored files' '
+	test_when_finished "git clean -fdx" &&
+	cat >expect <<-\EOF &&
+	? dir/untracked_ignored/untracked_1
+	? dir/untracked_ignored/untracked_2
+	? expect
+	? output
+	? untracked_ignored/untracked_1
+	? untracked_ignored/untracked_2
+	! dir/untracked_ignored/ignored_1.ign
+	! dir/untracked_ignored/ignored_2.ign
+	! untracked_ignored/ignored_1.ign
+	! untracked_ignored/ignored_2.ign
+	EOF
+
+	mkdir -p untracked_ignored dir/untracked_ignored &&
+	touch untracked_ignored/untracked_1 untracked_ignored/untracked_2 \
+		untracked_ignored/ignored_1.ign untracked_ignored/ignored_2.ign \
+		dir/untracked_ignored/untracked_1 dir/untracked_ignored/untracked_2 \
+		dir/untracked_ignored/ignored_1.ign dir/untracked_ignored/ignored_2.ign &&
+
+	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'Verify status matching ignored files on ignored directory' '
+	test_when_finished "git clean -fdx" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	! ignored_dir/
+	EOF
+
+	mkdir ignored_dir &&
+	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
+		ignored_dir/ignored_1.ign ignored_dir/ignored_2.ign &&
+
+	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'Verify status behavior on ignored directory containing tracked file' '
+	test_when_finished "git clean -fdx && git reset HEAD~1 --hard" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	! ignored_dir/ignored_1
+	! ignored_dir/ignored_1.ign
+	! ignored_dir/ignored_2
+	! ignored_dir/ignored_2.ign
+	EOF
+
+	mkdir ignored_dir &&
+	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
+		ignored_dir/ignored_1.ign ignored_dir/ignored_2.ign \
+		ignored_dir/tracked &&
+	git add -f ignored_dir/tracked &&
+	git commit -m "Force add file in ignored directory" &&
+	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'Verify matching ignored files with --untracked-files=normal' '
+	test_when_finished "git clean -fdx" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	? untracked_dir/
+	! ignored_dir/
+	! ignored_files/ignored_1.ign
+	! ignored_files/ignored_2.ign
+	EOF
+
+	mkdir ignored_dir ignored_files untracked_dir &&
+	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
+		ignored_files/ignored_1.ign ignored_files/ignored_2.ign \
+		untracked_dir/untracked &&
+	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'Verify matching ignored files with --untracked-files=normal' '
+	test_when_finished "git clean -fdx" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	? untracked_dir/
+	! ignored_dir/
+	! ignored_files/ignored_1.ign
+	! ignored_files/ignored_2.ign
+	EOF
+
+	mkdir ignored_dir ignored_files untracked_dir &&
+	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
+		ignored_files/ignored_1.ign ignored_files/ignored_2.ign \
+		untracked_dir/untracked &&
+	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'Verify status behavior on ignored directory containing tracked file' '
+	test_when_finished "git clean -fdx && git reset HEAD~1 --hard" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	! ignored_dir/ignored_1
+	! ignored_dir/ignored_1.ign
+	! ignored_dir/ignored_2
+	! ignored_dir/ignored_2.ign
+	EOF
+
+	mkdir ignored_dir &&
+	touch ignored_dir/ignored_1 ignored_dir/ignored_2 \
+		ignored_dir/ignored_1.ign ignored_dir/ignored_2.ign \
+		ignored_dir/tracked &&
+	git add -f ignored_dir/tracked &&
+	git commit -m "Force add file in ignored directory" &&
+	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'Verify behavior of status with --ignored=no' '
+	test_when_finished "git clean -fdx" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	EOF
+
+	mkdir -p ignored dir/ignored &&
+	touch ignored/ignored_1.ign ignored/ignored_2.ign \
+		dir/ignored/ignored_1.ign dir/ignored/ignored_2.ign &&
+
+	git status --porcelain=v2 --ignored=no --untracked-files=all >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'Verify behavior of status with --ignored=traditional and --untracked-files=all' '
+	test_when_finished "git clean -fdx" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	! dir/ignored/ignored_1.ign
+	! dir/ignored/ignored_2.ign
+	! ignored/ignored_1.ign
+	! ignored/ignored_2.ign
+	EOF
+
+	mkdir -p ignored dir/ignored &&
+	touch ignored/ignored_1.ign ignored/ignored_2.ign \
+		dir/ignored/ignored_1.ign dir/ignored/ignored_2.ign &&
+
+	git status --porcelain=v2 --ignored=traditional --untracked-files=all >output &&
+	test_i18ncmp expect output
+'
+
+test_expect_success 'Verify behavior of status with --ignored=traditional and --untracked-files=normal' '
+	test_when_finished "git clean -fdx" &&
+	cat >expect <<-\EOF &&
+	? expect
+	? output
+	! dir/
+	! ignored/
+	EOF
+
+	mkdir -p ignored dir/ignored &&
+	touch ignored/ignored_1.ign ignored/ignored_2.ign \
+		dir/ignored/ignored_1.ign dir/ignored/ignored_2.ign &&
+
+	git status --porcelain=v2 --ignored=traditional --untracked-files=normal >output &&
+	test_i18ncmp expect output
+'
+
+test_done
-- 
2.13.6

