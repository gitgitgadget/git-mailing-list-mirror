Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5150D1FA21
	for <e@80x24.org>; Wed, 11 Oct 2017 13:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbdJKNf2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Oct 2017 09:35:28 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:51452 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752123AbdJKNfW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2017 09:35:22 -0400
Received: by mail-qt0-f193.google.com with SMTP id q4so5132661qtq.8
        for <git@vger.kernel.org>; Wed, 11 Oct 2017 06:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o5GoKLMSpcMUVb80Dy55XU8m5tf0yVmufX2y7/CvJTs=;
        b=ebRV4fws91p10YMdWj9GO5ntpzTjLSnyQVk9HgZhpC+vAEdqOaYfVT0pOxPq8N5gGp
         VBcoFYlrQCWhW+5SSwicVK/ISMPJjsR1CuawccHUGcXBIu8jUeSc3hk/XRfyiyRTdvnj
         t616+4hrJ3g7zaMlWWmhdySGbbaWQwrTBeb9dThGu5bA5Z5iv5rBLHTaCwZMK+3H++z2
         CB1FQlhpRLZ8injtzUEwV0lieAO2VpcIQ25R17RpY5EAvtUK2U1NR6lN0041R4BQt47N
         sLRdGWgdqdgKnytKo7WzlFOw+XJg3ehsJCHmRdM4exGO/nr3SKjHOOlEA1XaXpD5X4T1
         A2OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o5GoKLMSpcMUVb80Dy55XU8m5tf0yVmufX2y7/CvJTs=;
        b=c/W+G4C7b5/n467owcmg93C3ktd14+jhCI2xBkhMW091Y0pDvLL2cdjxdmcDTZ9D12
         IeU5MuHsIox90g9IPSTuqZQUvrBKQKsut2ymHlNlO46/dmhiLs76YTlyBH3dsmOcKDQN
         sdwn7X03fTkOk1AS4eKmuxl0+fi/dOBgFvAFJMF/+kaZGRoUhelZrvG1i3LGkyshfwax
         TEkXlxZlMq7T/lzdlGpSwbUjG0ePmMJcSp1A3bJ5JYQFqEprQ5JMVFRZ3bgJOgJK7kPa
         UvXaHeimV/7xxR4sp17BGrgaZztUpCW+kFEAhDCHK7dmiJXkwJvE9bKJaX4TlUm+Eluu
         sWig==
X-Gm-Message-State: AMCzsaW5QL7tArPNxjNSb49pztrYvrK7DbJQWqaP1VYxNQgWc50eX9/v
        MG/PGzO8+ByUlXaGA3rIeb4=
X-Google-Smtp-Source: AOwi7QCsMJd1AzJMHvCtiuzctIj3K2cQI0SbNVDfvUiHtYXtW4I3/ZTADE7H8+yBbTBYuiUm/HVJ2g==
X-Received: by 10.200.50.90 with SMTP id y26mr17354383qta.292.1507728921794;
        Wed, 11 Oct 2017 06:35:21 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id i1sm8192685qta.19.2017.10.11.06.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Oct 2017 06:35:21 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v2 3/5] Add tests for git status `--ignored=matching`
Date:   Wed, 11 Oct 2017 09:35:02 -0400
Message-Id: <20171011133504.15049-4-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171011133504.15049-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171011133504.15049-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for new ignored mode (matching) when showing all untracked
files.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 t/t7519-ignored-mode.sh | 125 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 125 insertions(+)
 create mode 100755 t/t7519-ignored-mode.sh

diff --git a/t/t7519-ignored-mode.sh b/t/t7519-ignored-mode.sh
new file mode 100755
index 0000000000..76e91427b0
--- /dev/null
+++ b/t/t7519-ignored-mode.sh
@@ -0,0 +1,125 @@
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
+	git commit -m "Initial commit"
+'
+
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
+test_expect_success 'Verify status behavior on folder with tracked & ignored files' '
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
+test_expect_success 'Verify status behavior on folder with untracked and ignored files' '
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

