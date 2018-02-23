Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE76F1F404
	for <e@80x24.org>; Fri, 23 Feb 2018 23:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752533AbeBWXkT (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 18:40:19 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55048 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752044AbeBWXkN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 18:40:13 -0500
Received: by mail-wm0-f65.google.com with SMTP id z81so7470778wmb.4
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 15:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t3HcS67AdLWy3CCt91suGW9H+cbj8OjVDFp36RjXZMs=;
        b=QLObFf9XMC7v77q7Qah5vzF2GH7lRvKue1JHDLS8y/ef6xyWZY90QPIXjiBuQ2Wag+
         l7IqIsVj4jbHqfyS0mE44i5FhSfxbnjbPQX1LRBzw3lzLqQ9beAArJEPHQptm2DZQ16U
         yAm+/ZCD498Kx40oZpCV4STag5KidP+5yikYyoPEgOOsBEd02GeT4rwJcRlVshnCuLnl
         SpJzTf3FaQX2xAs5hncT90o4Pw/RfIr2af840DQCQuPk8Gw9vlVkDknAgQ1VITJrLy3O
         K1WUXkE+xtV9qzyr1XL/VJkktFeUzSCSe0rXbj1UnM1Z1VC7cf8TPXinJXn7SHkuRbLw
         Xv8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t3HcS67AdLWy3CCt91suGW9H+cbj8OjVDFp36RjXZMs=;
        b=H6BML8pSCWBr5a8cdgDlMuGIXWpvcM/5fSfBAUb3UwfZXtGn772wGM2sTTttiX40vn
         5fjhG/eMYed/FFYfDufWpst7NyRpLT2reE/fWYH5viUUWr168YForLZlUKQ22zW5cQol
         dFuSsPJapUY6aKXqlWnli3kOuBqMpYibJOJ7fGc65Ss+5temz4B8KctlYErs7nT8K6n9
         UQGm3OM5OF6w7vECCUtyErJdPfYLgV31fSUrZFbwg8n87xfPZ7nm3UIlW1IrOHzzDVP4
         3ziCvRJ5rdlaaEaJplR2/8Do4NE8ICyTMDVt+RXb0DITyAA7ipBDxH5hz4Ri0Maa69e/
         9SGQ==
X-Gm-Message-State: APf1xPAtcxIRJQ3OVrPDUSpPWe518frjZj+zJjrcV8JAN51Obn3Uz+7B
        cNg7q2KkL4oVFvyjnJ4DVJGQaA==
X-Google-Smtp-Source: AG47ELuoyAGUM9NXMqNppo4v1K3XpPx34ePtCUi1mpWFesqjQcJkrMTk7WHsBaV6d2XQN9zedzfqfg==
X-Received: by 10.28.135.142 with SMTP id j136mr3195409wmd.33.1519429212294;
        Fri, 23 Feb 2018 15:40:12 -0800 (PST)
Received: from localhost.localdomain (x590e551c.dyn.telefonica.de. [89.14.85.28])
        by smtp.gmail.com with ESMTPSA id c14sm7028939wmh.2.2018.02.23.15.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 23 Feb 2018 15:40:11 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 04/11] t3030-merge-recursive: don't check the stderr of a subshell
Date:   Sat, 24 Feb 2018 00:39:44 +0100
Message-Id: <20180223233951.11154-5-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.16.2.400.g911b7cc0da
In-Reply-To: <20180223233951.11154-1-szeder.dev@gmail.com>
References: <20180223233951.11154-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The two test checking 'git mmerge-recursive' in an empty worktree in
't3030-merge-recursive.sh' fail when the test script is run with '-x'
tracing (and using a shell other than a Bash version supporting
BASH_XTRACEFD).  The reason for those failures is that the tests check
the emptiness of a subshell's stderr, which includes the trace of
commands executed in that subshell as well, throwing off the emptiness
check.

Note that both subshells execute four git commands each, meaning that
checking the emptiness of the whole subshell implicitly ensures that
not only 'git merge-recursive' but none of the other three commands
outputs anything to their stderr.  Note also that if one of those
commands were to output anything on its stderr, then the current
combined check would not tell us which one of those four commands the
unexpected output came from.

Save the stderr of those four commands only instead of the whole
subshell, so it remains free from tracing output, and save and check
them individually, so they will show us from which command the
unexpected output came from.

After this change t3030 passes with '-x', even when running with
/bin/sh.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t3030-merge-recursive.sh | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index cdc38fe5d1..cbeea1cf94 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -525,20 +525,22 @@ test_expect_success 'merge-recursive w/ empty work tree - ours has rename' '
 		GIT_INDEX_FILE="$PWD/ours-has-rename-index" &&
 		export GIT_INDEX_FILE &&
 		mkdir "$GIT_WORK_TREE" &&
-		git read-tree -i -m $c7 &&
-		git update-index --ignore-missing --refresh &&
-		git merge-recursive $c0 -- $c7 $c3 &&
-		git ls-files -s >actual-files
-	) 2>actual-err &&
-	>expected-err &&
+		git read-tree -i -m $c7 2>actual-err &&
+		test_must_be_empty expected-err &&
+		git update-index --ignore-missing --refresh 2>actual-err &&
+		test_must_be_empty expected-err &&
+		git merge-recursive $c0 -- $c7 $c3 2>actual-err &&
+		test_must_be_empty expected-err &&
+		git ls-files -s >actual-files 2>actual-err &&
+		test_must_be_empty expected-err
+	) &&
 	cat >expected-files <<-EOF &&
 	100644 $o3 0	b/c
 	100644 $o0 0	c
 	100644 $o0 0	d/e
 	100644 $o0 0	e
 	EOF
-	test_cmp expected-files actual-files &&
-	test_cmp expected-err actual-err
+	test_cmp expected-files actual-files
 '
 
 test_expect_success 'merge-recursive w/ empty work tree - theirs has rename' '
@@ -548,20 +550,22 @@ test_expect_success 'merge-recursive w/ empty work tree - theirs has rename' '
 		GIT_INDEX_FILE="$PWD/theirs-has-rename-index" &&
 		export GIT_INDEX_FILE &&
 		mkdir "$GIT_WORK_TREE" &&
-		git read-tree -i -m $c3 &&
-		git update-index --ignore-missing --refresh &&
-		git merge-recursive $c0 -- $c3 $c7 &&
-		git ls-files -s >actual-files
-	) 2>actual-err &&
-	>expected-err &&
+		git read-tree -i -m $c3 2>actual-err &&
+		test_must_be_empty expected-err &&
+		git update-index --ignore-missing --refresh 2>>actual-err &&
+		test_must_be_empty expected-err &&
+		git merge-recursive $c0 -- $c3 $c7 2>>actual-err &&
+		test_must_be_empty expected-err &&
+		git ls-files -s >actual-files 2>>actual-err &&
+		test_must_be_empty expected-err
+	) &&
 	cat >expected-files <<-EOF &&
 	100644 $o3 0	b/c
 	100644 $o0 0	c
 	100644 $o0 0	d/e
 	100644 $o0 0	e
 	EOF
-	test_cmp expected-files actual-files &&
-	test_cmp expected-err actual-err
+	test_cmp expected-files actual-files
 '
 
 test_expect_success 'merge removes empty directories' '
-- 
2.16.2.400.g911b7cc0da

