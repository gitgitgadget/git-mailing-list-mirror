Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC5BC0502E
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiH0Mox (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiH0Mon (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1716A31EFC
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id c187-20020a1c35c4000000b003a30d88fe8eso5736055wma.2
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=197lBONP6pItK9QmNDlCg6sPoKXmLwJvk18dpuLL79s=;
        b=k0Cc9VTBDqtwIm0iOTtb1YePMtxBVWAOI9Q3ZM/K1PhqA4ql1fA1JutXWy2yHJ/+qm
         a7Ng2D8itAB6FDuFcfQ2aGZ99wuRslSqUagNzfD3LoON+WNG3WY9ZJ25n3vddoqcI2tW
         UL84q4NB/3g3dHdt8eDethhpupaAv39pdXDEwx1DIekP2UJCI3K+Hjxzry11vOfE3CBl
         +ZSYkKFTY1bZoajjX3o2624Xs8LmurIjjZNIe7h3CscNvnRBT4D/AcVOVo19ntEixp4K
         mOFgEgyymTzEXPT/RHxKeZ2pFuBdW1w0GtPHDKtfYgcG0Kwc4pMNDVFuvVVFfUEgU/1U
         nDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=197lBONP6pItK9QmNDlCg6sPoKXmLwJvk18dpuLL79s=;
        b=0fXN1CGzUuIO3waGHB0XMYD3qxU+b1KMJZAl+TvO4gXkz4NkaWBORvJrL8JGE7lDW6
         jR92oD7qqwlWrfEyUFmq5Yv9arwpapRBskqVMlbJcP0D3gptS5KGabhbElRKqp4Y8dYI
         shWI/hBB8nKjzX8YZtpwDTMBarhQaNF3TQs0VRgAoCOOQ5kwMUPJX6qOx2A+YAXe3c6/
         K6aWc8EJWeKjLVsoeoPwVdGXcDfpGaOIHm6Vsucnrnqz5CIl2pbKsq0fB1NTNMSgSmRp
         A6OYuKiISBDXt8hq8yoYNoD8ZUOBC7auJ+899bmh1ouQNsADM6eoqk3oA/As8VjfKqZK
         qoig==
X-Gm-Message-State: ACgBeo3q9qth0KCcw83461qJcdWKXifmJuvlvGQC56KNA0e/aAw3lGjC
        7V1VcCpFAYqVQfFTBfnwwoEPrxbbWEk=
X-Google-Smtp-Source: AA6agR4reilpFpUvEewGSPd4pYWnq8wVJ3csPWLD6qOM2cUWxx6fkRqpTRKVHeeVrU2NYyZbxz17wQ==
X-Received: by 2002:a7b:cd14:0:b0:3a5:c5b3:508 with SMTP id f20-20020a7bcd14000000b003a5c5b30508mr2165213wmj.179.1661604279125;
        Sat, 27 Aug 2022 05:44:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v5-20020a5d59c5000000b002257fd37877sm2369308wry.6.2022.08.27.05.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:38 -0700 (PDT)
Message-Id: <409492ad830828f2b5f341706ad9ad1c64f66d6e.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:17 +0000
Subject: [PATCH v5 09/16] bisect run: fix the error message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In d1bbbe45df8 (bisect--helper: reimplement `bisect_run` shell function
in C, 2021-09-13), we ported the `bisect run` subcommand to C, including
the part that prints out an error message when the implicit `git bisect
bad` or `git bisect good` failed.

However, the error message was supposed to print out whether the state
was "good" or "bad", but used a bogus (because non-populated) `args`
variable for it.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c    |  2 +-
 t/t6030-bisect-porcelain.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d797cd1cef8..a00167f1373 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1430,7 +1430,7 @@ static int cmd_bisect_run(int argc, const char **argv, const char *prefix)
 			printf(_("bisect found first bad commit"));
 			res = BISECT_OK;
 		} else if (res) {
-			error(_("bisect run failed: 'git bisect--helper --bisect-state"
+			error(_("bisect run failed: 'git bisect"
 			" %s' exited with error code %d"), new_state, res);
 		} else {
 			continue;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 6d6e72276ae..7a76f204083 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -1063,4 +1063,14 @@ test_expect_success 'bisect state output with bad commit' '
 	grep -F "waiting for good commit(s), bad commit known" output
 '
 
+test_expect_success 'verify correct error message' '
+	git bisect reset &&
+	git bisect start $HASH4 $HASH1 &&
+	write_script test_script.sh <<-\EOF &&
+	rm .git/BISECT*
+	EOF
+	test_must_fail git bisect run ./test_script.sh 2>error &&
+	grep "git bisect good.*exited with error code" error
+'
+
 test_done
-- 
gitgitgadget

