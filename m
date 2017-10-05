Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0ED81FA21
	for <e@80x24.org>; Thu,  5 Oct 2017 20:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbdJEUzE (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Oct 2017 16:55:04 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:38175 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752241AbdJEUzD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2017 16:55:03 -0400
Received: by mail-qk0-f196.google.com with SMTP id 17so3799747qkq.5
        for <git@vger.kernel.org>; Thu, 05 Oct 2017 13:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z1arj2mN2wafsxUldaGAw9QkbSScgd/uyaLARXj7dmQ=;
        b=Qvb9IAV3TgbItaFmQe7i1YXK2fjAI+k1ZGpR54mGd6iO9PmMCcpUI19vM/Oi3coqOe
         t+XRvgm6C7Qw7/GR5qS4sIAOUPStkQxOQBQyuTvEKSEQvKySBCCff5XlQhNpMQRtIXHa
         KeyoOmgPfaI2Z3KYZfhmBiXV3xOpEq3dQfUYUNk3USVUb+fF+CiPMF9FbF1RiFmYjSHU
         utm0QwlGmQN7aeS/HlGWawpHlt5EqJDFB4H3CO20RO+gDXyCvSX6kugaIOGT/gC3gdzs
         TuH4/SiR3x6HYUvc4mKIZZQPd4EtJW8ISxneQNsxl9/up8xiKqvlCEVeYl7jGcMbEC5x
         9D+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z1arj2mN2wafsxUldaGAw9QkbSScgd/uyaLARXj7dmQ=;
        b=ocUTf1/J0zuPjnix9JR42vcD2X0DDb35W2VWEEorCTzlOQ43VzlbyfMvklsbZUL64c
         XDGbBaIRNvMXm8OkVO+hy5z2ut4Ftl8HSL/uiyLCmVGGx4ZCnE42YimXhv2nNxt5nab8
         YbrmrUw7JAhtRO0IFx2PRyIA548w968QaZ6FK9JllEblnrz0wWoWzGpCztnzt5GYyDZb
         EctAgXxUFAxTBcJTWJVjv5mWJ/sbYhUvchg5TzXoc4faZTr8/m60C8oX97adwL2wYHP9
         iU1XROr6yyN7UwfIXZjSHkiJYIbe6FE1sVlFuVre7QEDaKVyq+3JwjQ36Q3KvVYO18gP
         W+ow==
X-Gm-Message-State: AMCzsaWUNms6tHDCb5xZL301ku5wECk/2WGWfYmfQ7e3lU0ijV97shc8
        O/jNiUxcrb20V0LLORniMZmr2ly79UI=
X-Google-Smtp-Source: AOwi7QALB0hO4CIB4R6l7I1mJYjogPrnQn4dLx+jtcLJrJavm0VBS3GZQycCpHSsKt+3L6ddVZNvpw==
X-Received: by 10.55.212.70 with SMTP id l67mr4266549qki.140.1507236902340;
        Thu, 05 Oct 2017 13:55:02 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id x127sm11871596qkd.3.2017.10.05.13.55.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Oct 2017 13:55:01 -0700 (PDT)
From:   jameson.miller81@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, bmwill@google.com,
        sbeller@google.com, Jameson Miller <jamill@microsoft.com>
Subject: [PATCH 3/6] Add tests for git status `--ignored=matching`
Date:   Thu,  5 Oct 2017 16:54:40 -0400
Message-Id: <20171005205443.206900-4-jameson.miller81@gmail.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171005205443.206900-1-jameson.miller81@gmail.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jameson Miller <jamill@microsoft.com>

Add tests for new ignored mode (matching) when showing all untracked
files.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 t/t7519-ignored-mode.sh | 132 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 132 insertions(+)
 create mode 100755 t/t7519-ignored-mode.sh

diff --git a/t/t7519-ignored-mode.sh b/t/t7519-ignored-mode.sh
new file mode 100755
index 0000000000..a8c35d1cbc
--- /dev/null
+++ b/t/t7519-ignored-mode.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+
+test_description='git status collapse ignored'
+
+. ./test-lib.sh
+
+# commit initial ignore file
+test_expect_success 'setup initial commit and ignore file' '
+	cat >.gitignore <<-\EOF &&
+	*.ign
+	ignored_dir/
+	!*.unignore
+	EOF
+	git add . &&
+	test_tick &&
+	git commit -m "Initial commit"
+'
+
+# Test status behavior on folder with ignored files
+test_expect_success 'Verify behavior of status on folders with ignored files' '
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
+# Test status behavior on folder with tracked and ignored files
+test_expect_success 'Verify status on folder with tracked & ignored files' '
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
+	test_tick &&
+	git commit -m "commit tracked files" &&
+
+	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
+	test_i18ncmp expect output
+'
+
+# Test status behavior on folder with untracked and ignored files
+test_expect_success 'Verify status matching ignored files on folder with tracked & ignored files' '
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
+# Test status behavior on ignored folder
+test_expect_success 'Verify status matching ignored files on ignored folder' '
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
+# Test status behavior on ignored folder with tracked file
+test_expect_success 'Verify status behavior on ignored folder containing tracked file' '
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
+	test_tick &&
+	git commit -m "Force add file in ignored directory" &&
+	git status --porcelain=v2 --ignored=matching --untracked-files=all >output &&
+	test_i18ncmp expect output
+'
+
+test_done
-- 
2.13.6

