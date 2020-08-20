Return-Path: <SRS0=wu5b=B6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB343C433DF
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 16:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0B1F206B5
	for <git@archiver.kernel.org>; Thu, 20 Aug 2020 16:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TLRtNfzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729509AbgHTQCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729760AbgHTQCL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Aug 2020 12:02:11 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D929C061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 09:02:11 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id v2so2072671ilq.4
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wiq4vagWQ2Hpm0v0HSDATKhu75Lnt9K/dZ6U8eMT1n0=;
        b=TLRtNfzd2j4PK01LKzVvvNybhUPE/JlTmi5AeLpcaRRLZllD31PUNutzLvEUuwwRLU
         Qjfo03WBmuHo+aNrG1a99VlkRE5MX8RWMbXT6KpxXcAKuTSW7GxdghwP+bJGohKRfk+o
         89AfFtkXCT1k0PCT8UEPzC88waJDA8KF7bOxLCuEgRLKD1Obx+G19sxcGEcD8vOp4/Ls
         FwQ0NKu/0jMii2nx298FOhTbTdWvDYMnLZaV1t1PdOH9X2xgqREnNN2LJ/fZKrzR9mc1
         QfXQt+Sp+1eid+V8uJDZSDVuCySMZVCK7DBZ56hvMGNwWAW+69rDA90G3cPvaDlQ6at/
         5/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wiq4vagWQ2Hpm0v0HSDATKhu75Lnt9K/dZ6U8eMT1n0=;
        b=hZucOF3zECu4q3yDmNm/jdggmXeczWSy4nLEDGic+7LvHw3kUq+qVtgj7EdVOF8XQ/
         e5Ugm/hstVUsCrOjoUI8XOFAaB4qiiSjDoqB2x53WwCOZYkk/AyY5FCbCYwhGDrUAYTK
         e0Yo2gHKYyea/jNiJ9nKL6w+yw398Yin4w0D+Nxq7Up2v29Cy3LTcUSlfKUJmPPJ8WHV
         TDRnDKFCQiZ6qqRmlgpm7YS8ijqA5ru0TLAjvSpAK8douB7fVvwcMHjHTx4wtK71zLQm
         ATuFjiizCY+cYma41gi//bPb/yxRTH+qIWasg24HXz9iAPo43eS1XuAbbu1QeRFEDrF2
         cvfQ==
X-Gm-Message-State: AOAM532bYMhe99o6ldGe2Vph7PVArTtw3w3m9MSoGsdrqeikG/dewFxR
        bPSw5k+cNT6llPdIARmBKq7RztCUCL8CYV9bIdI78/cUtEDogQ==
X-Google-Smtp-Source: ABdhPJx11nsJJRZKtg4y60CmDTnrvvBiaIR0TqLRnqKEklCjk6wCxmD3Ep+lxlbVn/MAYL6knGo1tyZFspbOGv3+6IM=
X-Received: by 2002:a92:5a05:: with SMTP id o5mr3074493ilb.58.1597939330331;
 Thu, 20 Aug 2020 09:02:10 -0700 (PDT)
MIME-Version: 1.0
From:   Gopal Yadav <gopunop@gmail.com>
Date:   Thu, 20 Aug 2020 21:31:59 +0530
Message-ID: <CAAUOv8gf7e=pFGgPBK5cb1_RusWEY7s+iWf95_ETTz_3juzggg@mail.gmail.com>
Subject: [PATCH] Issue #353: Skipping lazy prereq for skipped tests
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 Skipping lazy prereq for test cases that are skipped via
 the --run option or via GIT_SKIP_TESTS. Issue 353:
 https://github.com/gitgitgadget/git/issues/353

Signed-off-by: Gopal Yadav <gopunop@gmail.com>
---
 t/test-lib-functions.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 6a8e194a99..bac86ffd9d 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -578,10 +578,10 @@ test_expect_failure () {
     test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
     test "$#" = 2 ||
     BUG "not 2 or 3 parameters to test-expect-failure"
-    test_verify_prereq
-    export test_prereq
     if ! test_skip "$@"
     then
+        test_verify_prereq
+        export test_prereq
         say >&3 "checking known breakage of $TEST_NUMBER.$test_count '$1': $2"
         if test_run_ "$2" expecting_failure
         then
@@ -598,10 +598,10 @@ test_expect_success () {
     test "$#" = 3 && { test_prereq=$1; shift; } || test_prereq=
     test "$#" = 2 ||
     BUG "not 2 or 3 parameters to test-expect-success"
-    test_verify_prereq
-    export test_prereq
     if ! test_skip "$@"
     then
+        test_verify_prereq
+        export test_prereq
         say >&3 "expecting success of $TEST_NUMBER.$test_count '$1': $2"
         if test_run_ "$2"
         then
@@ -627,10 +627,10 @@ test_external () {
     BUG "not 3 or 4 parameters to test_external"
     descr="$1"
     shift
-    test_verify_prereq
-    export test_prereq
     if ! test_skip "$descr" "$@"
     then
+        test_verify_prereq
+        export test_prereq
         # Announce the script to reduce confusion about the
         # test output that follows.
         say_color "" "# run $test_count: $descr ($*)"
-- 
2.20.1
