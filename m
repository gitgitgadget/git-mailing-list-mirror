Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B77FCC433EF
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 21:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbiFFVGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 17:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbiFFVFs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 17:05:48 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0793D53E13
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 13:59:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id m26so9980517wrb.4
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 13:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RGAzshs4ALYm/fqfwEatKkltEWbLBshZ7bxI8LndapA=;
        b=SEEEwHF9+zipMnLJ/zG4NRSAwn1FiEsJsPBDNFxWHkDgHmr6+MXBJNEqV6zz8jWK1X
         e3LJ2v9aPPQbBsvpDz/HlrgUqoA//LNqEnWR59w+3wMpnqSNp0PdHkm6TIZCIS7rGNLe
         ciFM1ujrqcrzXOfyhJEf8iDApKqKTKL8dN9DEYb0G0dAkYFOLQVCEZobhiYhooQfMVmN
         rolJwQ+JV9Sat0JzF2CHblPcAIRBhD7eaZhj6w69m39f5WWaTBmEihU0kt8XRM013S8q
         hbVUpLMQPYUUoKcspyRCUw5eMUs4YqFNrUWmDAnHlaKmSIPDW8nhEFBatGDUyvjKNkHi
         vuVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RGAzshs4ALYm/fqfwEatKkltEWbLBshZ7bxI8LndapA=;
        b=KmdkVJfBvEjqYl92tUg3K3tQHJoosBFqxf0pHBakoAjH+LA/sV10EeFYe2oSKbMHUN
         OAGLv3qupemRJFV6FIa9xdZmTJcJgubGMxRan6PBRKMO73/0GlbDtyoqhip13lHcfqvu
         PibhwiM4X4MhFL5q6HTyjcJLZGclXB1ywR0ooj2KQjJ0+X0KZ/YlpHT8UOeI4SDZZCyZ
         DOXSxCQ7TDjdtvySIat9Xt/4wLoV+zMykBNCYkV8HgbCrdcBFamlqfYyd8Cuvaa/Emlf
         Xm4K8Vh3tvkE1baiO5Dp0eZU4Um8+4j0+o4jQ3Zdb3NWMN9PoTPX+he9c+4y4iAMKdhQ
         qRcQ==
X-Gm-Message-State: AOAM530J4Kkav1OTkuwHJQP21xP2dYNEA56TX5l7OR+iCRhQSvCGW002
        2s44lxYtY+0p70fyNfcEIf6WdHcWqLfvfH1Y
X-Google-Smtp-Source: ABdhPJwy31ihAe/PKtTKNZs7Dxx+4iYKldQXBY/nlfAh5g+4a7OxesIixDyYzvZk9nuAnHFyV7yZvg==
X-Received: by 2002:a5d:52c7:0:b0:210:ac6:3956 with SMTP id r7-20020a5d52c7000000b002100ac63956mr24212682wrv.379.1654549155150;
        Mon, 06 Jun 2022 13:59:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i19-20020a05600c355300b0039c45514f16sm8895303wmq.4.2022.06.06.13.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:59:14 -0700 (PDT)
Message-Id: <pull.1244.v2.git.1654549153769.gitgitgadget@gmail.com>
In-Reply-To: <pull.1244.git.1653916145441.gitgitgadget@gmail.com>
References: <pull.1244.git.1653916145441.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Jun 2022 20:59:13 +0000
Subject: [PATCH v2] range-diff: show submodule changes irrespective of
 diff.submodule
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

After generating diffs for each range to be compared using a 'git log'
invocation, range-diff.c::read_patches looks for the "diff --git" header
in those diffs to recognize the beginning of a new change.

In a project with submodules, and with 'diff.submodule=log' set in the
config, this header is missing for the diff of a changed submodule, so
any submodule changes are quietly ignored in the range-diff.

When 'diff.submodule=diff' is set in the config, the "diff --git" header
is also missing for the submodule itself, but is shown for submodule
content changes, which can easily confuse 'git range-diff' and lead to
errors such as:

    error: git apply: bad git-diff - inconsistent old filename on line 1
    error: could not parse git header 'diff --git path/to/submodule/and/some/file/within
    '
    error: could not parse log for '@{u}..@{1}'

Force the submodule diff format to its default ("short") when invoking
'git log' to generate the patches for each range, such that submodule
changes are always detected.

Add a test, including an invocation with '--creation-factor=100' to
force the second commit in the range not to be considered a complete
rewrite, in order to verify we do indeed get the "short" format.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    range-diff: show submodule changes irrespective of diff.submodule
    
    Changes since v1:
    
     * added a comparison without '--creation-factor' to the test, as
       suggested by Ævar
     * remove separate 'git add sub' invocations in favor of 'git commit -m
       msg sub', as suggested by Dscho

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1244%2Fphil-blain%2Frange-diff-submodule-diff-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1244/phil-blain/range-diff-submodule-diff-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1244

Range-diff vs v1:

 1:  4ae11694ac6 ! 1:  1982b720a04 range-diff: show submodule changes irrespective of diff.submodule
     @@ Commit message
      
          Force the submodule diff format to its default ("short") when invoking
          'git log' to generate the patches for each range, such that submodule
     -    changes are always shown.
     +    changes are always detected.
      
     -    Note that the test must use '--creation-factor=100' to force the second
     -    commit in the range not to be considered a complete rewrite.
     +    Add a test, including an invocation with '--creation-factor=100' to
     +    force the second commit in the range not to be considered a complete
     +    rewrite, in order to verify we do indeed get the "short" format.
      
          Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
      
     @@ t/t3206-range-diff.sh: test_expect_success '--left-only/--right-only' '
      +	git checkout -b main-sub topic &&
      +	git submodule add ./sub-repo sub &&
      +	git -C sub checkout --detach sub-first &&
     -+	git add sub &&
     -+	git commit -m "add sub" &&
     ++	git commit -m "add sub" sub &&
      +	sup_oid1=$(git rev-parse --short HEAD) &&
      +	git checkout -b topic-sub &&
      +	git -C sub checkout sub-second &&
     -+	git add sub &&
     -+	git commit -m "change sub" &&
     ++	git commit -m "change sub" sub &&
      +	sup_oid2=$(git rev-parse --short HEAD) &&
      +	git checkout -b modified-sub main-sub &&
      +	git -C sub checkout sub-third &&
     -+	git add sub &&
     -+	git commit -m "change sub" &&
     ++	git commit -m "change sub" sub &&
      +	sup_oid3=$(git rev-parse --short HEAD) &&
     ++	sup_oid0=$(test_oid __) &&
      +
      +	test_config diff.submodule log &&
     ++	git range-diff topic topic-sub modified-sub >actual &&
     ++	cat >expect <<-EOF &&
     ++	1:  $sup_oid1 = 1:  $sup_oid1 add sub
     ++	2:  $sup_oid2 < -:  $sup_oid0 change sub
     ++	-:  $sup_oid0 > 2:  $sup_oid3 change sub
     ++	EOF
     ++	test_cmp expect actual &&
     ++	test_config diff.submodule diff &&
     ++	git range-diff topic topic-sub modified-sub >actual &&
      +	git range-diff --creation-factor=100 topic topic-sub modified-sub >actual &&
      +	cat >expect <<-EOF &&
      +	1:  $sup_oid1 = 1:  $sup_oid1 add sub


 range-diff.c          |  2 +-
 t/t3206-range-diff.sh | 51 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index b72eb9fdbee..068bf214544 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -44,7 +44,7 @@ static int read_patches(const char *range, struct string_list *list,
 
 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 		     "--reverse", "--date-order", "--decorate=no",
-		     "--no-prefix",
+		     "--no-prefix", "--submodule=short",
 		     /*
 		      * Choose indicators that are not used anywhere
 		      * else in diffs, but still look reasonable
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index e30bc48a290..d12e4e4cc6c 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -772,4 +772,55 @@ test_expect_success '--left-only/--right-only' '
 	test_cmp expect actual
 '
 
+test_expect_success 'submodule changes are shown irrespective of diff.submodule' '
+	git init sub-repo &&
+	test_commit -C sub-repo sub-first &&
+	sub_oid1=$(git -C sub-repo rev-parse HEAD) &&
+	test_commit -C sub-repo sub-second &&
+	sub_oid2=$(git -C sub-repo rev-parse HEAD) &&
+	test_commit -C sub-repo sub-third &&
+	sub_oid3=$(git -C sub-repo rev-parse HEAD) &&
+
+	git checkout -b main-sub topic &&
+	git submodule add ./sub-repo sub &&
+	git -C sub checkout --detach sub-first &&
+	git commit -m "add sub" sub &&
+	sup_oid1=$(git rev-parse --short HEAD) &&
+	git checkout -b topic-sub &&
+	git -C sub checkout sub-second &&
+	git commit -m "change sub" sub &&
+	sup_oid2=$(git rev-parse --short HEAD) &&
+	git checkout -b modified-sub main-sub &&
+	git -C sub checkout sub-third &&
+	git commit -m "change sub" sub &&
+	sup_oid3=$(git rev-parse --short HEAD) &&
+	sup_oid0=$(test_oid __) &&
+
+	test_config diff.submodule log &&
+	git range-diff topic topic-sub modified-sub >actual &&
+	cat >expect <<-EOF &&
+	1:  $sup_oid1 = 1:  $sup_oid1 add sub
+	2:  $sup_oid2 < -:  $sup_oid0 change sub
+	-:  $sup_oid0 > 2:  $sup_oid3 change sub
+	EOF
+	test_cmp expect actual &&
+	test_config diff.submodule diff &&
+	git range-diff topic topic-sub modified-sub >actual &&
+	git range-diff --creation-factor=100 topic topic-sub modified-sub >actual &&
+	cat >expect <<-EOF &&
+	1:  $sup_oid1 = 1:  $sup_oid1 add sub
+	2:  $sup_oid2 ! 2:  $sup_oid3 change sub
+	    @@ Commit message
+	      ## sub ##
+	     @@
+	     -Subproject commit $sub_oid1
+	    -+Subproject commit $sub_oid2
+	    ++Subproject commit $sub_oid3
+	EOF
+	test_cmp expect actual &&
+	test_config diff.submodule diff &&
+	git range-diff --creation-factor=100 topic topic-sub modified-sub >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 7a3eb286977746bc09a5de7682df0e5a7085e17c
-- 
gitgitgadget
