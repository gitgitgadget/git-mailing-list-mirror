Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73DB6202A2
	for <e@80x24.org>; Thu, 19 Oct 2017 16:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754197AbdJSQG1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 12:06:27 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46784 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753864AbdJSQGU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 12:06:20 -0400
Received: by mail-qt0-f195.google.com with SMTP id 1so15075377qtn.3
        for <git@vger.kernel.org>; Thu, 19 Oct 2017 09:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nfIOWMPSu1DUMinztibvpNQoze0Fl5UP1G1xv2fYf2o=;
        b=NhvQgJ0uVg7ZJ2cSD1+QivWz5bErZ54zWAS+MLoFFDVd2hJXaBdj4amKWjbPla6zow
         E1M/0k0TItnr0YxnMaef5NGUToPg18ZXk3yulw8HwOQ3+fShgCVHFsZP2JaptwQvP5ZH
         JWvaOXh5Fu89Ds/2dS9O3fDRPtI0/XUE5hHf8kG3K7K8regD/O6keroYB6mGi0f+8pB5
         7jG72i1JuXXARVeCdTxJ45mV/Y4eprhcdUwgw6aeYj7rgp/uvLWRX7Ub326xqTEAOZTG
         JgqIisYdAdSwsscVAGzTOSJ3+MmRe+gZ/3+yQ1tCluBvKJ060lAVqjNq5uMGeYjXARoS
         wC+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nfIOWMPSu1DUMinztibvpNQoze0Fl5UP1G1xv2fYf2o=;
        b=M8M1r4YjzONP2i7VNVOKk2693BdBb+9rIgdajQZFMGGhSVeH7Y93SzqJsBhFRyB1os
         No7wsD38+EW5wWIdSdPkVNXn1xslzwYWnKocnTA8P81iF3cWOOAADB5JBEv27OanYuiG
         L/UK4JQZX+jqtLmk4C6WEcjlUnLPpQvmd08F5Jm67Nh4i1veTDHCmVZvNBxdRsDPWJwB
         X42TQqLJLmt3n5E7JPIHP/RcstLKz6T4pPFh5bwpzC/ESBo4Ir1wefRH2cBRtwn+wq23
         TsCw4RDBRI29RG8N8NUN3UPqnnskBynKiE9VGJJipO9pwElRUd8JgfagMr4kXdCiQ0Tw
         uc9g==
X-Gm-Message-State: AMCzsaU6Juk107jwb7QZNWN5Ml6r9lMWPYImz7pvuRDgaDFdWvfWZvh0
        gki1wqpjd/1rct8LbP/lkyA=
X-Google-Smtp-Source: ABhQp+SsFuB6td0ABqC+7IrpB54SquIMYTzaXQgQhqX1rjEv4464A9X5/sSGCAIptMd8EW44PU1UNg==
X-Received: by 10.200.35.90 with SMTP id b26mr2787555qtb.324.1508429179976;
        Thu, 19 Oct 2017 09:06:19 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([2001:4898:8010::76e])
        by smtp.gmail.com with ESMTPSA id c13sm9377085qka.50.2017.10.19.09.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 19 Oct 2017 09:06:19 -0700 (PDT)
From:   Jameson Miller <jameson.miller81@gmail.com>
X-Google-Original-From: Jameson Miller <jamill@microsoft.com>
To:     jameson.miller81@gmail.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jamill@microsoft.com, peff@peff.net, sbeller@google.com
Subject: [PATCH v3 4/4] status: test --ignored=matching
Date:   Thu, 19 Oct 2017 12:06:01 -0400
Message-Id: <20171019160601.9382-5-jamill@microsoft.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20171019160601.9382-1-jamill@microsoft.com>
References: <20171005205443.206900-1-jameson.miller81@gmail.com>
 <20171019160601.9382-1-jamill@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests around status reporting ignord files that match an exclude
pattern for both --untracked-files=normal and --untracked-files=all.

Signed-off-by: Jameson Miller <jamill@microsoft.com>
---
 t/t7519-ignored-mode.sh | 183 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 183 insertions(+)
 create mode 100755 t/t7519-ignored-mode.sh

diff --git a/t/t7519-ignored-mode.sh b/t/t7519-ignored-mode.sh
new file mode 100755
index 0000000000..6be7701d79
--- /dev/null
+++ b/t/t7519-ignored-mode.sh
@@ -0,0 +1,183 @@
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
+	git commit -m "Force add file in ignored directory" &&
+	git status --porcelain=v2 --ignored=matching --untracked-files=normal >output &&
+	test_i18ncmp expect output
+'
+
+test_done
-- 
2.13.6

