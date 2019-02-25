Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF51F20248
	for <e@80x24.org>; Mon, 25 Feb 2019 23:16:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbfBYXQ5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Feb 2019 18:16:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38221 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728848AbfBYXQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Feb 2019 18:16:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id v26so561173wmh.3
        for <git@vger.kernel.org>; Mon, 25 Feb 2019 15:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=okybrwm0gaXCkknN8n71EHayh86klCTFjgpYIR+qcf8=;
        b=iAh3gWYMY34pun50rByYnGaWYhTKiv9Zk40dGpcmrNsbrrwjggSuC9fpRKBqxKvKTn
         fpsp9IT9YwZWGkKM5aMFRDX8zFYdCEfk+PTLbSaz1M/MKphd1tePPjk2SjBQkPIdEYcZ
         tziZCM5j3a/mb03/X58Jl3oDL7mX9BiSHMff2yBYlgkKXRLX/nzG3t7bpqJQbh7a/TTw
         sU/Zv7YT7p44ywpaUhhHg142ne75du+7Opp99gyYYatCvb0tzZqrj3hBQME+eZqWO/Cr
         zgSpP4IIFCbiBWGbLjxxZePD+SGs08FVFjgwMrgE/7FQmlyX7Q3LOEboUik39/nUcK/F
         +KVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=okybrwm0gaXCkknN8n71EHayh86klCTFjgpYIR+qcf8=;
        b=WHTaCikm68E3c46wFd9qgssJ0wnMab5ZETyNqOVFFh3g4eI3Y/Snrp1XUdcMwwcLt2
         noTj81YOwCjB+pN5GuS9VhuSXwCVhNw8LscdkDkFDZ7h1CqJKf2dGet3+S3LhtIcj/4q
         w3swNQFOi79558KRVia1VSJDUTlA4MY+plXgJb2iOXU6OThrWmaM2txUrzxtvWSQx9XW
         vegiFUyDNdsAxo3dZnb8JrzN+dNC7B0DKpC5suNunQTLWY5V8rlRzK5FXLjMDYu+Liq4
         mbYzQD+C5QTpPqwpygWuLQsZQQ8O9cY35+LKJ9YZ0shvcq5UR+ZxBZFgwJCeIxG04qRC
         aifw==
X-Gm-Message-State: AHQUAuZ8IoV8djTdh3mhvvj/fUzu3bft+mWz41cYDOp8tLAUhMaUM7lQ
        1Tmv3Waq/2EP9TTekNl0RbbeQ8YW
X-Google-Smtp-Source: AHgI3IbSf4dyWD9uGx/rO8xzcmOffPhY8xAYB4pOOTmqqJT+2sOvPDuyY0vsMAlvSq10I3Sx2tFEtg==
X-Received: by 2002:a1c:449:: with SMTP id 70mr695237wme.118.1551136614289;
        Mon, 25 Feb 2019 15:16:54 -0800 (PST)
Received: from localhost ([95.149.189.205])
        by smtp.gmail.com with ESMTPSA id z15sm22955033wrh.18.2019.02.25.15.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 15:16:53 -0800 (PST)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Joel Teichroeb <joel@teichroeb.net>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v13 05/27] stash: improve option parsing test coverage
Date:   Mon, 25 Feb 2019 23:16:09 +0000
Message-Id: <20190225231631.30507-6-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.21.0.rc2.291.g17236886c5
In-Reply-To: <20190225231631.30507-1-t.gummerer@gmail.com>
References: <nycvar.QRO.7.76.6.1902191127420.41@tvgsbejvaqbjf.bet>
 <20190225231631.30507-1-t.gummerer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joel Teichroeb <joel@teichroeb.net>

In preparation for converting the stash command incrementally to
a builtin command, this patch improves test coverage of the option
parsing. Both for having too many parameters, or too few.

Signed-off-by: Joel Teichroeb <joel@teichroeb.net>
Signed-off-by: Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 t/t3903-stash.sh | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 5f8272b6f9..ac55629737 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -444,6 +444,36 @@ test_expect_failure 'stash file to directory' '
 	test foo = "$(cat file/file)"
 '
 
+test_expect_success 'giving too many ref arguments does not modify files' '
+	git stash clear &&
+	test_when_finished "git reset --hard HEAD" &&
+	echo foo >file2 &&
+	git stash &&
+	echo bar >file2 &&
+	git stash &&
+	test-tool chmtime =123456789 file2 &&
+	for type in apply pop "branch stash-branch"
+	do
+		test_must_fail git stash $type stash@{0} stash@{1} 2>err &&
+		test_i18ngrep "Too many revisions" err &&
+		test 123456789 = $(test-tool chmtime -g file2) || return 1
+	done
+'
+
+test_expect_success 'drop: too many arguments errors out (does nothing)' '
+	git stash list >expect &&
+	test_must_fail git stash drop stash@{0} stash@{1} 2>err &&
+	test_i18ngrep "Too many revisions" err &&
+	git stash list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'show: too many arguments errors out (does nothing)' '
+	test_must_fail git stash show stash@{0} stash@{1} 2>err 1>out &&
+	test_i18ngrep "Too many revisions" err &&
+	test_must_be_empty out
+'
+
 test_expect_success 'stash create - no changes' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
@@ -479,6 +509,11 @@ test_expect_success 'stash branch - stashes on stack, stash-like argument' '
 	test $(git ls-files --modified | wc -l) -eq 1
 '
 
+test_expect_success 'stash branch complains with no arguments' '
+	test_must_fail git stash branch 2>err &&
+	test_i18ngrep "No branch name specified" err
+'
+
 test_expect_success 'stash show format defaults to --stat' '
 	git stash clear &&
 	test_when_finished "git reset --hard HEAD" &&
-- 
2.21.0.rc2.291.g17236886c5

