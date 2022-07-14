Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB63C433EF
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 09:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbiGNJAm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 05:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiGNJAk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 05:00:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32CF42AEC
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 02:00:38 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d16so1624720wrv.10
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 02:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=NEsLkNZaS4jUx1rqOyKV1f2bzw/vmRm+Xnp1p1kbbeM=;
        b=KosjDzUkAPEiM9uC6BsDR49XGLvjMLiDDHdagUBQO5wJq6Jio74/SRjEq9S7qCyiw5
         e5JooMmAffYRha9ekdbIrLxLGRKczilP3bJIUuUhFXSuR8R7t6jIenlSn7zt91itay4+
         mAal04pBrVS8uDC2dpGlA8i9x0cCWw8YOXZmzK9s7URWfghbmI/X6IIOUtSS/nWPWZr0
         WgMT9zJYrpzL/AFUnf+xWtBkyCZC0p8j+hrVfqBfPxIHxIzk0uVXdkjL5QG2zdul4KP7
         8Y+MqURjqTaWmkEtHY6SkgE7bjYBbV6qEZIx7sguPaYYPU70m5Dmej2lzRkpZ0PysoTV
         42JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NEsLkNZaS4jUx1rqOyKV1f2bzw/vmRm+Xnp1p1kbbeM=;
        b=8MESQgGnVzxV2SfgnIb71hM7JRR8YY3RzB2vAvIUM5bquEuwSfoitDOxpLH7ENyUIm
         TUx/6pdVlBkypzNi/Zd/BT9uCf+nGV+oJ07UAIvF2a0CkrnAFC+7vHr8X+b9wOLbOdaI
         0e+031ih4QxJA0s62DnZ1o38BS/lpgwxMBjF+Me4vbA/N0DG7ycYhTNuAYMB0ICRY/7r
         CfAVajVWSdsNXSYfokC51e3Bt+J/zJdCNFlgk6lACFsfRi2hgT+i77gFSODbazfKmucF
         CMevCzKh7eZpxes34QgQKNHAgLQZeJXnK5YSlO0gtm1T3Xzl/63wwuHEouYL8u+3Tafe
         /DXA==
X-Gm-Message-State: AJIora8xDjy2+Yiyl9saEFwjZ/Z58DAkYJ4nV3lRmVWOTnheWEVPOyNR
        VKh8MR0p224QI7ipWhXWc2lAuriho/o=
X-Google-Smtp-Source: AGRyM1vTFN2SavhFHx5pFsabNZp9TVDNtXNgqxxA6VxOH3i9y9wT24xwPPxEgQyaSYNxl1Pu/Wzgiw==
X-Received: by 2002:a5d:4d46:0:b0:21d:8196:6181 with SMTP id a6-20020a5d4d46000000b0021d81966181mr7306139wru.459.1657789236824;
        Thu, 14 Jul 2022 02:00:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f15-20020adfe90f000000b0021d76985929sm884464wrm.80.2022.07.14.02.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 02:00:35 -0700 (PDT)
Message-Id: <pull.1288.git.1657789234416.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 14 Jul 2022 09:00:34 +0000
Subject: [PATCH] tests: fix incorrect --write-junit-xml code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 78d5e4cfb4b (tests: refactor --write-junit-xml code, 2022-05-21),
this developer refactored the `--write-junit-xml` code a bit, including
the part where the current test case's title was used in a `set`
invocation, but failed to account for the fact that some test cases'
titles start with a long option, which the `set` misinterprets as being
intended for parsing.

Let's fix this by using the `set -- <...>` form.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    tests(JUnit): fix a regression introduced by refactoring
    
    As if another data point was needed to corroborate my claim that
    refactorings are neither free of cost nor of risk, this patch fixes a
    regression I myself introduced while refactoring the JUnit XML output
    code. At least this refactoring was motivated by an ulterior goal to
    improve Git's contributor experience, not just refactoring for
    refactoring's sake.
    
    Unfortunately, I noticed this regression no earlier than when I needed
    to validate Git for Windows v2.37.1. Since v2.37.1 was an embargoed
    release, I could not use GitHub Actions for the CI testing, so I had to
    reinstate Git's Azure Pipeline.
    
    It will probably surprise only few, if at all, that this is far from the
    only regression in the CI code that I had to fix just so I could run the
    Azure Pipeline successfully. I plan on contributing all of these
    regression fixes, of course, packaged into neat little,
    logically-separate patch series that should be easy on reviewers.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1288%2Fdscho%2Ffix-junit-xml-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1288/dscho/fix-junit-xml-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1288

 t/test-lib-junit.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/test-lib-junit.sh b/t/test-lib-junit.sh
index c959183c7e2..79c31c788b9 100644
--- a/t/test-lib-junit.sh
+++ b/t/test-lib-junit.sh
@@ -46,7 +46,7 @@ finalize_test_case_output () {
 	shift
 	case "$test_case_result" in
 	ok)
-		set "$*"
+		set -- "$*"
 		;;
 	failure)
 		junit_insert="<failure message=\"not ok $test_count -"
@@ -65,17 +65,17 @@ finalize_test_case_output () {
 			junit_insert="$junit_insert<system-err>$(xml_attr_encode \
 				"$(cat "$GIT_TEST_TEE_OUTPUT_FILE")")</system-err>"
 		fi
-		set "$1" "      $junit_insert"
+		set -- "$1" "      $junit_insert"
 		;;
 	fixed)
-		set "$* (breakage fixed)"
+		set -- "$* (breakage fixed)"
 		;;
 	broken)
-		set "$* (known breakage)"
+		set -- "$* (known breakage)"
 		;;
 	skip)
 		message="$(xml_attr_encode --no-lf "$skipped_reason")"
-		set "$1" "      <skipped message=\"$message\" />"
+		set -- "$1" "      <skipped message=\"$message\" />"
 		;;
 	esac
 

base-commit: 4e2a4d1dd44367d7783f33b169698f2930ff13c0
-- 
gitgitgadget
