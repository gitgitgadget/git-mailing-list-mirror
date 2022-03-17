Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7307BC433EF
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 14:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbiCQO5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 10:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiCQO47 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 10:56:59 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE155203A4D
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 07:55:39 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id r7so3264813wmq.2
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uG2G3NePbll9Wg5k5zTPe0WGzmsXQUPC397Ap/uix3w=;
        b=f1/YN9n4Jwuo3EFUZUdW7CKs2goZIvqftGpEFHvLvi9mVbLkmcZn7Z6RG1SISZrYH2
         Jze9LlmtDCCaYLQsFyTMXLYjtWhOKuM/XtcZLM/jM8t2j8qdyfqdvC25aQL9UCi6Q0Ep
         K6XlqcHsiqL3k4WwpigQGdRzHf25yovo32CqwfjKMDKkEvd3HqJUYxG2KKyySSy93HV2
         9w0it1GKNJ87oVGjyrN3e0WGnCTNdfq1RGUf4nfX93hAg2GPCtLvjw5Qr3dtCWuRVWLY
         3n/6FnQCHUeKaK2KTeNSU9tOURAdevoOxLrUF2SMDfrquoUTGgvtCHVwm62aDY10noWc
         RlYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uG2G3NePbll9Wg5k5zTPe0WGzmsXQUPC397Ap/uix3w=;
        b=1rzpKUIAgFRGz7bqSX036EcN2Dj4BqKJXayW6wlJyuxAV3wyJjAtWDlAgG7OWkwpTa
         cpnK66k26weKAa6X4IVghvtD5d0WklzWroNHzRhNPe3GDrYocTXKJHiQWSEJLKGWi5Qr
         a3rLaj9BHVGy5aACCMgS/I0k6EdBFD7m01o2sNzyYoMBHheBcyL+HYWEDmMEaVZLel2t
         rftIcvutTyY2DORR83emR98FbK4p2xAWMRj5WZjMnZ9JAKqSQqije4QXFS8Zr4RTopVZ
         FtM15RxCcQzqRWlPilE3STSJ574faBb1425xW44OhsHHdfFiuyDXdOrT2vgJreYFcY2E
         rmLQ==
X-Gm-Message-State: AOAM530ZI+0kdCr0HtOrH/SXXcbdIkDUvhLMXzviu1pI8XRzE1ab2KDX
        IK6QOp2Sn3n5kqf5xSqg1PDe5yd3uC6sUA==
X-Google-Smtp-Source: ABdhPJwAQ5dg1o6F/Wf+V5/rDcltAGRTJML1aNIFgnvOhccaq4+Uagtfb8/2A1zEE5WeBhJtqeHMhg==
X-Received: by 2002:a05:600c:3552:b0:389:95b2:5f4a with SMTP id i18-20020a05600c355200b0038995b25f4amr4393444wmq.24.1647528937855;
        Thu, 17 Mar 2022 07:55:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d4bcd000000b001f0620ecb3csm4340071wrt.40.2022.03.17.07.55.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 07:55:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/2] tests: demonstrate "show --word-diff --color-moved" regression
Date:   Thu, 17 Mar 2022 15:55:34 +0100
Message-Id: <patch-v2-1.2-7f6a6450259-20220317T144838Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-v2-0.2-00000000000-20220317T144838Z-avarab@gmail.com>
References: <a5e5cdd4658d457ffbd80f7263e352cbf3141a1a.1647520853.git.git@grubix.eu> <cover-v2-0.2-00000000000-20220317T144838Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael J Gruber <git@grubix.eu>

Add a failing test which demonstrates a regression in
a18d66cefb ("diff.c: free "buf" in diff_words_flush()", 2022-03-04),
the regression is discussed in detail in the subsequent commit. With
it running `git show --word-diff --color-moved` with SANITIZE=address
would emit:

	==31191==ERROR: AddressSanitizer: attempting double-free on 0x617000021100 in thread T0:
	    #0 0x49f0a2 in free (git+0x49f0a2)
	    #1 0x9b0e4d in diff_words_flush diff.c:2153:3
	    #2 0x9aed5d in fn_out_consume diff.c:2354:3
	    #3 0xe092ab in consume_one xdiff-interface.c:43:9
	    #4 0xe072eb in xdiff_outf xdiff-interface.c:76:10
	    #5 0xec7014 in xdl_emit_diffrec xdiff/xutils.c:53:6
	    [...]

	0x617000021100 is located 0 bytes inside of 768-byte region [0x617000021100,0x617000021400)
	freed by thread T0 here:
	    #0 0x49f0a2 in free (git+0x49f0a2)
	    [...(same stacktrace)...]

	previously allocated by thread T0 here:
	    #0 0x49f603 in __interceptor_realloc (git+0x49f603)
	    #1 0xde4da4 in xrealloc wrapper.c:126:8
	    #2 0x995dc5 in append_emitted_diff_symbol diff.c:794:2
	    #3 0x96c44a in emit_diff_symbol diff.c:1527:3
	    [...]

This was not caught by the test suite because we test `diff
--word-diff --color-moved` only so far.

Therefore, add a test for `show`, too.

Signed-off-by: Michael J Gruber <git@grubix.eu>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4015-diff-whitespace.sh | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 9babf13bc9b..ff8a0426ca5 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -1622,7 +1622,7 @@ test_expect_success 'cmd option assumes configured colored-moved' '
 	test_cmp expected actual
 '
 
-test_expect_success 'no effect from --color-moved with --word-diff' '
+test_expect_success 'no effect on diff from --color-moved with --word-diff' '
 	cat <<-\EOF >text.txt &&
 	Lorem Ipsum is simply dummy text of the printing and typesetting industry.
 	EOF
@@ -1636,6 +1636,12 @@ test_expect_success 'no effect from --color-moved with --word-diff' '
 	test_cmp expect actual
 '
 
+test_expect_failure 'no effect on show from --color-moved with --word-diff' '
+	git show --color-moved --word-diff >actual &&
+	git show --word-diff >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'set up whitespace tests' '
 	git reset --hard &&
 	# Note that these lines have no leading or trailing whitespace.
-- 
2.35.1.1384.g7d2906948a1

