Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2868EC0015E
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 13:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbjGNNaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 09:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235393AbjGNNaP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 09:30:15 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A391A2691
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 06:30:13 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-316eabffaa6so1465977f8f.2
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 06:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689341412; x=1691933412;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M3W4qN25I+kp3ZwvzdI/k7svMUXD1lG4AMh/sAv6drw=;
        b=WzkIiu9BZWyx1Qk5naysdYvS/BRlWjBnmt+MIamrqk438IDxTTWqvGzibh1sQlnmDQ
         0Ft3H5Xl6MzW/qJvQ6e5mizr52ntQV+D1jq0cqfrRh4uOrJD0wJh7sHpn0aFh/WvgPpn
         tONVlgLjWIH2jEHcmUAZ1p6Gx1IE/0JTUA6D5KScPIKpvNIu4m3VZfUXojWzza2wYLsm
         +IN6lfYf3+Ril67opE295hFLMWeVXTc1J/w6/Bg7v2oupSkQRg33u3XySCGh3mEMa1F6
         b+d0HCWyRG/C2XMYV//zSZxtOfFG9wNbnLB4FKEkDnhCTolDsYhKMMiMApKJVLFQpPS+
         C7hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689341412; x=1691933412;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M3W4qN25I+kp3ZwvzdI/k7svMUXD1lG4AMh/sAv6drw=;
        b=HSuuUHoBNOuO3xjk/gPzWBhE/L/CezGaLy3zB1xgBdGts2WZBuwSMGv2g2mmr/z0xg
         CE0J43eYyrfxUTLgrqmQS7zCFiGBj1YwkbvcF3h/+Isq1Z12BRoAHtB4O78WEfZ70T/s
         earR76zTKPs6pvt941VZ1smJa730RpAvxKBrzkWrGKCIWVM5Zq0F1kMHMr7CMDj4L9ZH
         BdkPcQRBXctfxAaj9W1V2zI2eL3Ge7+i+AgIchk9gLBrgZ61Xr5EzLyFzANV6l+uTmBg
         EhBT4Cun8DCj5ArYZnH6yOM01SsYSHh/JuiCIXGc+Soy0l6wCjLbTvTlFW/C08ZWpHmL
         cXOA==
X-Gm-Message-State: ABy/qLYFDSJVp2TML2wqdAY1yz1w3qgBTPJMyB9COZDULciOXBdRD06o
        +cP7IYmRVB1bjz/lkRQyB/3B2Gc0vbs=
X-Google-Smtp-Source: APBJJlEQXwHnNlaRT5/+nONdsuPPIJpf8OaHHGE1yewdB/CRJG/PckP+lVkkOos9TxaoI6B82ufcQQ==
X-Received: by 2002:adf:d4c8:0:b0:30f:c1ab:a039 with SMTP id w8-20020adfd4c8000000b0030fc1aba039mr4197274wrk.40.1689341411650;
        Fri, 14 Jul 2023 06:30:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d5487000000b0030ae901bc54sm10854785wrv.62.2023.07.14.06.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 06:30:11 -0700 (PDT)
Message-ID: <pull.1545.git.git.1689341410476.gitgitgadget@gmail.com>
From:   "D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Jul 2023 13:30:10 +0000
Subject: [PATCH] t4002: fix "diff can read from stdin" syntax
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "D. Ben Knoble" <ben.knoble+github@gmail.com>,
        "D. Ben Knoble" <ben.knoble+github@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "D. Ben Knoble" <ben.knoble+github@gmail.com>

I noticed this test was producing output like

```
t4002-diff-basic.sh: test_expect_successdiff can read from stdin: not found
```

which is rather odd. Investigation shows an error of shell syntax:
foo'abc' is the same as fooabc to the shell. Perhaps obviously, this is
not a valid command for the test.

I am surprised this doesn't count as an error in the test, but that
accounts for it going unnoticed.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
    t4002: fix "diff can read from stdin" syntax
    
    I noticed this test was producing output like
    
    t4002-diff-basic.sh: test_expect_successdiff can read from stdin: not found
    
    
    which is rather odd. Investigation shows an error of shell syntax:
    foo'abc' is the same as fooabc to the shell. Perhaps obviously, this is
    not a valid command for the test.
    
    I am surprised this doesn't count as an error in the test, but that
    accounts for it going unnoticed.
    
    ------------------------------------------------------------------------
    
    I would be interested in knowing how to "unsilence" failures like this
    so they do not go unnoticed in the future.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1545%2Fbenknoble%2Ft4002-diff-stdin-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1545/benknoble/t4002-diff-stdin-v1
Pull-Request: https://github.com/git/git/pull/1545

 t/t4002-diff-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4002-diff-basic.sh b/t/t4002-diff-basic.sh
index d524d4057dc..7afc883ec37 100755
--- a/t/t4002-diff-basic.sh
+++ b/t/t4002-diff-basic.sh
@@ -403,7 +403,7 @@ test_expect_success 'diff-tree -r B A == diff-tree -r -R A B' '
 	git diff-tree -r -R $tree_A $tree_B >.test-b &&
 	cmp -s .test-a .test-b'
 
-test_expect_success'diff can read from stdin' '
+test_expect_success 'diff can read from stdin' '
 	test_must_fail git diff --no-index -- MN - < NN |
 		grep -v "^index" | sed "s#/-#/NN#" >.test-a &&
 	test_must_fail git diff --no-index -- MN NN |

base-commit: aa9166bcc0ba654fc21f198a30647ec087f733ed
-- 
gitgitgadget
