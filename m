Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BA911F407
	for <e@80x24.org>; Sat,  9 Dec 2017 09:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbdLIJGE (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Dec 2017 04:06:04 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37790 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbdLIJGA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Dec 2017 04:06:00 -0500
Received: by mail-wm0-f66.google.com with SMTP id f140so6477949wmd.2
        for <git@vger.kernel.org>; Sat, 09 Dec 2017 01:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dyntopia-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=GrKIuroWCFMkZNw6C0aUGNn5lVplPnc65qW2gJ+JCOs=;
        b=TtgF02qvwf4ZH4bVVZQ+Rljy1lCT4cmsIlAS9UF+tkkAH3p5qIQZsqXe5ptWKtZolW
         +IBYSkZkIbdEe9Yq4/u9jIVPI+sDEflVSFVMDZFnVdmhOPviQYJC6sZjcRTViRSCBps8
         ekW3bD/ioxTbu6jTemPoOp7fR26NsX1TE7Chn95j4nAUGiztIyDt2P2UiQhTQiFwdh8J
         77sztSSpz8Y8WZjw5BzjVsxlAzQpiq0AvfzTLpUUI0z0HBjkOFgXr56ZsYV3wPNdGPxZ
         y6l3E8bRckkmcdOeBbm3SfuqY8GS2oQ4zxvYa06tCMEeWBfXJJIUqr4OW/Kan6YsdTLd
         vS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=GrKIuroWCFMkZNw6C0aUGNn5lVplPnc65qW2gJ+JCOs=;
        b=hDCMeehjIH6/rRRmNPDL5Y3FqG1WD4EXQxjvXS4iSrHQyHFmBY/aUjzXXIe3qSXUNg
         gnp86pR2ahlKOwO93+OEM3ezYvnO08+VaH1DAoUTZgzcY+tMUZnt0ExOZDj366nUS1jw
         L2iIpKafNsSTSYWx4MP6SSzNTED/fqKT3KRa7TXZ7ZUff22Wai4bnWADhAVK3AD3fMZj
         22wUt6EcxRZgb4/PRX/9NswEutgZdJJjS+orZeP1Z+sxn4spBwvJkDE8uldru+isz0e7
         +2zT+wry8+23I2ghojz+lTp4gyO07O7wJtQQXDvkjY8gqVlCH/JVpp5f4sfoi6hkPFck
         X8Zw==
X-Gm-Message-State: AJaThX7WYZKYw27V3hY/MZy6WM+1bCY4Q3TRCRhNvNbqUFhx1h3o5+pM
        PP9ebIA7cmwRUWKxqRwMBtAVbtiKCWU=
X-Google-Smtp-Source: AGs4zMYlaHV1RJIFoLoj1JFs+3u7y31OjqddJXhDrkKiaHn1q4aL+HgsGwB0qX+4Ote5RVS7ostxBQ==
X-Received: by 10.80.208.195 with SMTP id g3mr53095076edf.246.1512810358675;
        Sat, 09 Dec 2017 01:05:58 -0800 (PST)
Received: from localhost (se3x.mullvad.net. [193.138.219.228])
        by smtp.gmail.com with ESMTPSA id h4sm4163942edb.16.2017.12.09.01.05.57
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Dec 2017 01:05:58 -0800 (PST)
From:   Hans Jerry Illikainen <hji@dyntopia.com>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] t: add tests for pull --verify-signatures
Date:   Sat,  9 Dec 2017 09:05:29 +0000
Message-Id: <20171209090530.6747-2-hji@dyntopia.com>
In-Reply-To: <20171209090530.6747-1-hji@dyntopia.com>
References: <20171209090530.6747-1-hji@dyntopia.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for `pull --verify-signatures` with untrusted, bad and no
signatures.  Previously the only test for `--verify-signatures` was to
make sure that `pull --rebase --verify-signatures` result in a warning
(t5520-pull.sh).

Signed-off-by: Hans Jerry Illikainen <hji@dyntopia.com>
---
 t/t5573-pull-verify-signatures.sh | 78 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)
 create mode 100755 t/t5573-pull-verify-signatures.sh

diff --git a/t/t5573-pull-verify-signatures.sh b/t/t5573-pull-verify-signatures.sh
new file mode 100755
index 000000000..700247910
--- /dev/null
+++ b/t/t5573-pull-verify-signatures.sh
@@ -0,0 +1,78 @@
+#!/bin/sh
+
+test_description='pull signature verification tests'
+. ./test-lib.sh
+. "$TEST_DIRECTORY/lib-gpg.sh"
+
+test_expect_success GPG 'create repositories with signed commits' '
+	echo 1 >a && git add a &&
+	test_tick && git commit -m initial &&
+	git tag initial &&
+
+	git clone . signed &&
+	(
+		cd signed &&
+		echo 2 >b && git add b &&
+		test_tick && git commit -S -m "signed"
+	) &&
+
+	git clone . unsigned &&
+	(
+		cd unsigned &&
+		echo 3 >c && git add c &&
+		test_tick && git commit -m "unsigned"
+	) &&
+
+	git clone . bad &&
+	(
+		cd bad &&
+		echo 4 >d && git add d &&
+		test_tick && git commit -S -m "bad" &&
+		git cat-file commit HEAD >raw &&
+		sed -e "s/bad/forged bad/" raw >forged &&
+		git hash-object -w -t commit forged >forged.commit &&
+		git checkout $(cat forged.commit)
+	) &&
+
+	git clone . untrusted &&
+	(
+		cd untrusted &&
+		echo 5 >e && git add e &&
+		test_tick && git commit -SB7227189 -m "untrusted"
+	)
+'
+
+test_expect_success GPG 'pull unsigned commit with --verify-signatures' '
+	test_must_fail git pull --ff-only --verify-signatures unsigned 2>pullerror &&
+	test_i18ngrep "does not have a GPG signature" pullerror
+'
+
+test_expect_success GPG 'pull commit with bad signature with --verify-signatures' '
+	test_must_fail git pull --ff-only --verify-signatures bad 2>pullerror &&
+	test_i18ngrep "has a bad GPG signature" pullerror
+'
+
+test_expect_success GPG 'pull commit with untrusted signature with --verify-signatures' '
+	test_must_fail git pull --ff-only --verify-signatures untrusted 2>pullerror &&
+	test_i18ngrep "has an untrusted GPG signature" pullerror
+'
+
+test_expect_success GPG 'pull signed commit with --verify-signatures' '
+	git pull --verify-signatures signed >pulloutput &&
+	test_i18ngrep "has a good GPG signature" pulloutput &&
+	git checkout initial
+'
+
+test_expect_success GPG 'pull commit with bad signature without verification' '
+	git pull --ff-only bad 2>pullerror &&
+	git checkout initial
+'
+
+test_expect_success GPG 'pull commit with bad signature with --no-verify-signatures' '
+	test_config merge.verifySignatures true &&
+	test_config pull.verifySignatures true &&
+	git pull --ff-only --no-verify-signatures bad 2>pullerror &&
+	git checkout initial
+'
+
+test_done
-- 
2.11.0

