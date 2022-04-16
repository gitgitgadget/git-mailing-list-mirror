Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A707C433F5
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 08:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiDPILp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 04:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiDPILp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 04:11:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70923D488
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 01:09:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r13so12928218wrr.9
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 01:09:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=uVPuKD7A5KW80xGCIxLVM3JfcF91WHWFm+NLy7dRMTs=;
        b=Jn1stqpjgdxNbDryUPT4ESLZbRZD951PxwjMx9kAeAjnH+MaNlqKk3uaFuPLxADN7K
         4gdeixur33DHHMtM7IzUTghaWOUtSaaCfqdMHL+EJJSCVlmyx0r+y2sR2N8+ZnA45nfs
         N+Xpu8+misEmRwppRa0h1kiTbE8fxsNyiQO7xXyVpWIkXT3E5g7ZDv+YAM+Vz5cDMB2o
         6RT2zxah1qYMVWhCoMcSKyh+2W9h94T/HZ4mPKnEgjQMUmLLNfkEjRhLWIMkLJehplnl
         zZbZCZa8XBbAPKjQzpIqWhtSBNHhGWma8w/BbkJex3tUj6eut66LOJ8BppBZiRJxS0Rk
         UI4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uVPuKD7A5KW80xGCIxLVM3JfcF91WHWFm+NLy7dRMTs=;
        b=Y0ZTyXF3zg4oVBD1FlmqPXrNOwvcuioRQKb1UQTrwyPTwKtK6qVlg7ZHrzvw10kv78
         hRjncw2odEjT33KtM/Agmq5A94hUl+S7rqmI20LTJl542NEoGvpKLiDQ6H2phMFdje3X
         SLlYu/ZQEu0Pac7SAG12NlyvJk20YjAYpDNSAAq3R+XBklMJEj24goeCy42jZJa0Egbo
         6Ea3+0ytGkHXx/EeljTQRfdirqQcgJyxfrJsvVsAmdW+Df1LmJrz7fEUDW7djginVWhM
         v1wBj7vioDhkDTkg+LFK3y6QDwd7NXG+dHB9MvEoTn85VeI/qmaMFRmch1yEUvEOJb+T
         Koig==
X-Gm-Message-State: AOAM531qnppk7wkgwMptYV6XXqf0wQsn12flwccE03BEdbxlERuh2gTr
        1MTTwZOLBRkN+gEZ3K8+d5pgPxpmTzQ=
X-Google-Smtp-Source: ABdhPJwYrt3FTVMfSaVEIvWxjUsJn0ra0lPXJQKVVKhEjhAOwqG21IZKPwqMSlHNFr1Rc3KxOwhy9g==
X-Received: by 2002:adf:c6c1:0:b0:206:db8:c40 with SMTP id c1-20020adfc6c1000000b002060db80c40mr1802558wrh.29.1650096551903;
        Sat, 16 Apr 2022 01:09:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r6-20020a1c4406000000b0039229d3c4eesm2474729wma.12.2022.04.16.01.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 01:09:11 -0700 (PDT)
Message-Id: <pull.1218.git.1650096550631.gitgitgadget@gmail.com>
From:   "Jack McGuinness via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 16 Apr 2022 08:09:10 +0000
Subject: [PATCH] area: /t/t4204-log.sh, partially modernized test script t4202
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jack McGuinness <jmcguinness2@ucmerced.edu>,
        Jack <jmcguinness2@ucmerced.edu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jack <jmcguinness2@ucmerced.edu>

Remove test body indentations made with spaces, replace with tabs.
Remove blank lines at start and end of test bodies.

Signed-off-by: Jack McGuinness <jmcguinness2@ucmerced.edu>
---
    [GSoC][PATCH] Applicant Microproject - Modernizing t4202
    
    Hi, My name is Jack McGuinness, and a while ago I expressed my interest
    in git and GSoC. However, due to some personal and academic reasons I
    haven't been able to work on my micro project since then. I was able to
    work on my proposal, and I will be finished with it before the
    submission deadline, but I just want to express my apologies for doing
    this so late.
    
    In my patch, I completed the first four bullet points described in
    https://lore.kernel.org/git/CAPig+cQpUu2UO-+jWn1nTaDykWnxwuEitzVB7PnW2SS_b7V8Hg@mail.gmail.com/
    . I will complete the rest of them for t4202 over the rest of today, and
    submit their respective patches promptly.
    
    It has taken a few tries to get submitting my patch wrong due to a
    plethora of problems, but I think this time it will work.
    
    Thanks for your time, Jack.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1218%2FJackMcGu%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1218/JackMcGu/master-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1218

 t/t4202-log.sh | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index be07407f855..6fa9f7500ac 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -49,26 +49,22 @@ test_expect_success setup '
 
 printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial" > expect
 test_expect_success 'pretty' '
-
 	git log --pretty="format:%s" > actual &&
 	test_cmp expect actual
 '
 
 printf "sixth\nfifth\nfourth\nthird\nsecond\ninitial\n" > expect
 test_expect_success 'pretty (tformat)' '
-
 	git log --pretty="tformat:%s" > actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'pretty (shortcut)' '
-
 	git log --pretty="%s" > actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'format' '
-
 	git log --format="%s" > actual &&
 	test_cmp expect actual
 '
@@ -83,13 +79,11 @@ cat > expect << EOF
 EOF
 
 test_expect_success 'format %w(11,1,2)' '
-
 	git log -2 --format="%w(11,1,2)This is the %s commit." > actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'format %w(,1,2)' '
-
 	git log -2 --format="%w(,1,2)This is%nthe %s%ncommit." > actual &&
 	test_cmp expect actual
 '
@@ -103,47 +97,37 @@ $(git rev-parse --short :/second ) second
 $(git rev-parse --short :/initial) initial
 EOF
 test_expect_success 'oneline' '
-
 	git log --oneline > actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'diff-filter=A' '
-
 	git log --no-renames --pretty="format:%s" --diff-filter=A HEAD > actual &&
 	git log --no-renames --pretty="format:%s" --diff-filter A HEAD > actual-separate &&
 	printf "fifth\nfourth\nthird\ninitial" > expect &&
 	test_cmp expect actual &&
 	test_cmp expect actual-separate
-
 '
 
 test_expect_success 'diff-filter=M' '
-
 	git log --pretty="format:%s" --diff-filter=M HEAD >actual &&
 	printf "second" >expect &&
 	test_cmp expect actual
-
 '
 
 test_expect_success 'diff-filter=D' '
-
 	git log --no-renames --pretty="format:%s" --diff-filter=D HEAD >actual &&
 	printf "sixth\nthird" >expect &&
 	test_cmp expect actual
-
 '
 
 test_expect_success 'diff-filter=R' '
-
 	git log -M --pretty="format:%s" --diff-filter=R HEAD >actual &&
 	printf "third" >expect &&
 	test_cmp expect actual
-
 '
 
 test_expect_success 'multiple --diff-filter bits' '
-
 	git log -M --pretty="format:%s" --diff-filter=R HEAD >expect &&
 	git log -M --pretty="format:%s" --diff-filter=Ra HEAD >actual &&
 	test_cmp expect actual &&
@@ -152,19 +136,15 @@ test_expect_success 'multiple --diff-filter bits' '
 	git log -M --pretty="format:%s" \
 		--diff-filter=a --diff-filter=R HEAD >actual &&
 	test_cmp expect actual
-
 '
 
 test_expect_success 'diff-filter=C' '
-
 	git log -C -C --pretty="format:%s" --diff-filter=C HEAD >actual &&
 	printf "fourth" >expect &&
 	test_cmp expect actual
-
 '
 
 test_expect_success 'git log --follow' '
-
 	git log --follow --pretty="format:%s" ichi >actual &&
 	printf "third\nsecond\ninitial" >expect &&
 	test_cmp expect actual
@@ -820,7 +800,6 @@ test_expect_success 'log.decorate configuration' '
 	test_config log.decorate full &&
 	git log --pretty=raw >actual &&
 	test_cmp expect.raw actual
-
 '
 
 test_expect_success 'decorate-refs with glob' '
@@ -879,7 +858,7 @@ test_expect_success 'multiple decorate-refs' '
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs="heads/octopus*" \
 		--decorate-refs="tags/reach" >actual &&
-    test_cmp expect.decorate actual
+	test_cmp expect.decorate actual
 '
 
 test_expect_success 'decorate-refs-exclude with glob' '
@@ -2037,7 +2016,7 @@ test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 miss
 	GNUPGHOME=. git log --graph --show-signature -n1 plain-x509-nokey >actual &&
 	grep "^|\\\  merged tag" actual &&
 	grep -e "^| | gpgsm: certificate not found" \
-	     -e "^| | gpgsm: failed to find the certificate: Not found" actual
+		 -e "^| | gpgsm: failed to find the certificate: Not found" actual
 '
 
 test_expect_success GPGSM 'log --graph --show-signature for merged tag x509 bad signature' '
@@ -2190,10 +2169,10 @@ test_expect_success 'log --decorate includes all levels of tag annotated tags' '
 '
 
 test_expect_success 'log --end-of-options' '
-       git update-ref refs/heads/--source HEAD &&
-       git log --end-of-options --source >actual &&
-       git log >expect &&
-       test_cmp expect actual
+	   git update-ref refs/heads/--source HEAD &&
+	   git log --end-of-options --source >actual &&
+	   git log >expect &&
+	   test_cmp expect actual
 '
 
 test_expect_success 'set up commits with different authors' '

base-commit: 4027e30c5395c9c1aeea85e99f51ac62f5148145
-- 
gitgitgadget
