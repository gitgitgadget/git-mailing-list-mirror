Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F7BC1F97E
	for <e@80x24.org>; Sat, 18 Aug 2018 17:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeHRVEs (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Aug 2018 17:04:48 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56160 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeHRVEr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Aug 2018 17:04:47 -0400
Received: by mail-wm0-f67.google.com with SMTP id f21-v6so10408978wmc.5
        for <git@vger.kernel.org>; Sat, 18 Aug 2018 10:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0yd2o6wYr3pzCdB/j4gQ482GJX09Iid6P46Tn4DMnK0=;
        b=B5qIw6ajIoiKalUxyo7cVmW+Biz7tHs8/R9CMzG84FGWYeKAFDEwU+DplLwuTWeyGJ
         N8zSt+K8cNm0SOq1g2ZIN8SykrTRwnR56Z17w60Ry3UATspH0J6w0X66NoE5+MkiZMsJ
         DMfsUtZbjqvl86md9gg4Fd/KlCwHLRKNPd+0hZCY2zLl7N++wjMrakW0T77hqLk1HkUM
         Hy8LVDTd74OzvXEdpohJi+xSA1lLuq6Xic1MNUahFfpQFu1J25LlUP4dMbYu0HcP033G
         8ttwgwFp8a7Rc5PaHKP3dbnyNSDhkVQryejrcEhL4n/3trm8UnDttAXfjktlDRe92hso
         hNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0yd2o6wYr3pzCdB/j4gQ482GJX09Iid6P46Tn4DMnK0=;
        b=CL+8tvoRAYnJZSK/OSupRDPIz1Z7ZjGUhDcXdhsKGuG7AbsWHHfKRzFTgt6PiF2zt2
         jOIy4M6KfY026yZFTilXZspqW8t/C3Xewn7gUqLe5rXin21RibRj8GksKPeyvjVPvltU
         ky7HsBO1itkLqLWtkq9nEfMYmoySIzYW5uFDH403JaoMSOVgWdPg9S5lSCBKk6nQCKge
         w9chLrSI2Z9FY8KyRbTsnxVu0M6ZM4aGU+ZcAeAMaoykffTp3Up9qLJsJh6bRZuBw4eD
         cIiXPsgtHv1suG1M60YuEl7WeAXNMglFRnDlhkH/ASb7MitROdLvAjrWRL9/vwUjspOg
         dOpw==
X-Gm-Message-State: AOUpUlGtff5zsoZo6J4fZkFruuQ1V03w2PDGIx4+dxFw8WdYvE86MUCu
        lVKyyvUcLUcd1XffxR//SFKHAbyh
X-Google-Smtp-Source: AA+uWPxngvV8YpxDgdJN2qBMiHoNMuJ05T9zcP1GJPlsPKygfkmJRzQTMpI1PHXVldxBuRsLitcZAA==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr22422939wmt.94.1534614975813;
        Sat, 18 Aug 2018 10:56:15 -0700 (PDT)
Received: from localhost.localdomain (84-236-78-30.pool.digikabel.hu. [84.236.78.30])
        by smtp.gmail.com with ESMTPSA id 72-v6sm3308052wrb.48.2018.08.18.10.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 18 Aug 2018 10:56:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH] t7508-status: fix a bogus check in a submodule-related test
Date:   Sat, 18 Aug 2018 19:56:06 +0200
Message-Id: <20180818175606.24108-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.903.gab616d7dc6
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 90e14525f2 (Add tests for the diff.ignoreSubmodules config
option, 2010-08-06) the test '.gitmodules ignore=dirty suppresses
submodules with untracked content' in 't7508-status.sh' contains a
check that is bogus for two reasons.

The commit in question added the following three lines at the
beginning of that test:

  git config diff.ignoreSubmodules dirty &&
  git status >output &&
  ! test -s actual &&

That 'test' is problematic, because:

  - The output of 'git status' is saved in the file 'output', but the
    subsequent 'test' looks at the file 'actual'.  This is the first
    mention of 'actual' in t7508, so that file doesn't exist at that
    point, and, consequently, the 'test' itself fails.  However, since
    there is a '!' in front to flip the exit code, the command as a
    whole succeeds.
    I guess that this 'test' should look at the file 'output' instead,
    but...

  - This whole command checks that the given file is empty, i.e. that,
    supposedly, 'git status' produced no output.  However, in this
    case 'git status' does produce output, and indeed it should
    produce the same output as already expected in the neighbouring
    tests or even later in the same test, all running 'git status' in
    similar situations.

So drop that bogus check, and verify that 'git status's output matches
what's otherwise expected in similar cases.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

This is a submodules-related test, and I'm not very well versed in
submodules, hence the RFC.

 t/t7508-status.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index e1f11293e2..4ea528785a 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1183,7 +1183,7 @@ test_expect_success '--ignore-submodules=dirty suppresses submodules with untrac
 test_expect_success '.gitmodules ignore=dirty suppresses submodules with untracked content' '
 	test_config diff.ignoreSubmodules dirty &&
 	git status >output &&
-	! test -s actual &&
+	test_i18ncmp expect output &&
 	git config --add -f .gitmodules submodule.subname.ignore dirty &&
 	git config --add -f .gitmodules submodule.subname.path sm &&
 	git status >output &&
-- 
2.18.0.903.gab616d7dc6

