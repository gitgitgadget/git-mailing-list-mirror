Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 733F2202A2
	for <e@80x24.org>; Mon, 23 Oct 2017 17:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751732AbdJWRGD (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 13:06:03 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:57038 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbdJWRGA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 13:06:00 -0400
Received: by mail-qk0-f194.google.com with SMTP id l194so22835169qke.13
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 10:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UlBPyFrrOPwv00RYYWJzv0Bu1GMV0UpYo8mmoxEaBpI=;
        b=pILCAHnw/W3WhRbdIcosjblzRt1WHnuGGyHjyrWL013QFTJa3fKuzhz1FyLng3HunU
         S/TSBtX87v1ndcCmXG8FvKxQsl1qm3ilLEBEMPusijEp86+E/CiSpWM6GSg4GoQI7T/0
         5T/RpkCM9Ua9ZE7gcrpkmNWgpp1/VRpuWyRJKW3jdPme2g1N/SjrHvNFRVQL5vZGQ7aD
         B6nYVBSarFAsLkm7aYoub4PIBITcJCgbRr2xbiYv61YqguWwdxA9Lh2hsUfz+R/TgOLv
         HwuLWd59qP8SgnUoM72ZKWIC07KKiuL9xWF5H/v3cayn91TfNrVz6M34tl9IqABUGzPu
         4O8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UlBPyFrrOPwv00RYYWJzv0Bu1GMV0UpYo8mmoxEaBpI=;
        b=gUK+7ctaHmd4ukHlRTgzKzmYlzFVtklELfzb93+YNTjZ61RcV1q7diA6RenMq+5EGQ
         c7sYxX2pHBSvuRq9IQ2CXhK+jhhqoSp5Aa+Ke2qNhOAy2LedzQsldIqNS6gf8jaH+bMF
         4n2B8loMXAE0YHpKK2PBV9A+4ce4T6+ZnCb5nYBBYMJKle+uSuic1rcQ4xWm5hqvPV0N
         54LM913Vkop0GKSG0qwNkfjcO5W5QotIY1jlKQsICaAGPt3OLGOB4O2nDrj1y9VDvDjr
         rshdw+roQdKraSxG70NsHwOFVZD4a9HnROLNygl5rN6XnsLmAosLutlcKK1i8GxAA9Fs
         /+iA==
X-Gm-Message-State: AMCzsaUYD98/Sn7wyqOWhHnzt/HIExFbRYoOzds7IG+K/bAmERoVtdrz
        qwOI9Na81T5N+SlEJjIa0qI=
X-Google-Smtp-Source: ABhQp+TTrxEt35Vi8J9YOdfSTj9x0fCwhUg3SpAd0WJKUJybC6HftFmU6KFzJ5juxo7m3/74i2B0jw==
X-Received: by 10.55.31.77 with SMTP id f74mr18743981qkf.201.1508778359786;
        Mon, 23 Oct 2017 10:05:59 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id p64sm4885397qkd.67.2017.10.23.10.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 10:05:59 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v4 4/4] status: test ignored modes
Date:   Mon, 23 Oct 2017 13:05:34 -0400
Message-Id: <20171023170534.157740-5-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171023170534.157740-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171023170534.157740-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

