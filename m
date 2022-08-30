Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1208ECAAD5
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 18:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiH3SvD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 14:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiH3Suu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 14:50:50 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8784330A
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:33 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so6678514wms.5
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 11:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=feDvPsKx77Bi4ul4KWxYeI7P3pgcGlJwNEU0p2xe7Zs=;
        b=Z+UNhmys5XeT89PWnv82QCk61n9f+A54uKsT8vfVvJmWlnI8BbCkfkzkj+Q+SFsrDK
         yj5ewlD8Y9lHRygi3/nYJ0fmpV8gtlqvg4q7XpBF9wHZcqGkdfd0vjzSsiceMt4KI7S1
         TbjZsyedgO1jvpTHSy6n6o+KDJGZSXi8veoU3XHCgPiLGZYPGWXzqbiy2hYRLuCMDjxh
         rC5C7y3o0v5ASqR9wNEtMIRzr8Nc1nfUmZ7AJeEnwey8AqZJUXNykkWAT0VbpOjUY6KE
         Yu7/Kh8+Xp6QaAUxtcFcHO2K4J9FyrucF5ZDOoz9sZuXzEpp4XsVoluuTIsADN2afmoy
         UOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=feDvPsKx77Bi4ul4KWxYeI7P3pgcGlJwNEU0p2xe7Zs=;
        b=1LIaT8lNJJrwfmEvSvep1ID70iNsiPq8olrPGgqf93BABqqTu4cCVhrXgwZQ/UwWzm
         6lt7jTlzCUEP2/mANQkKmFDDR4R0cuykDLgB2XSJaVNqZUxiAiHtm6cLvK2V29+gfnem
         o0ChPv5Iwp2JgocMvVomQTaXHSrFGA8GkMK6DfZECq+9THiBHxlfsS11DEdoL/3+p6Tr
         /i2FMqTbGiBK0waLAzonBFj2umW7vqQy7iRWLeGXXiFLVLyq0BVePvA18bhKbdEs5BRv
         7bA+N+b9m0CgoYSUfII+hsqmLt56JGwocsIkYf1vERLGEip8UewongF4kNlfGWs6ZVnt
         VPSQ==
X-Gm-Message-State: ACgBeo2H4k7b+BQ7WYxZCxo8UKPX1P1wZ8p7WFZ6YOZroFvecibza+dq
        blAmLGR9160nVa9G9AskwXzdoF6tpZU=
X-Google-Smtp-Source: AA6agR6E/n91S3I1yPn6y5fGdCN60P9iDQN+bnhsyN0cJUv4nmHY60xaw0QxGoQxBi0CaEUTXiuiMw==
X-Received: by 2002:a1c:7414:0:b0:3a5:fd9e:e629 with SMTP id p20-20020a1c7414000000b003a5fd9ee629mr10839097wmc.194.1661885432041;
        Tue, 30 Aug 2022 11:50:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e14-20020adfef0e000000b0021d6924b777sm5669888wro.115.2022.08.30.11.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 11:50:31 -0700 (PDT)
Message-Id: <4696652b99ce05bece8e3abd10620aa4e4bba7c5.1661885419.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
References: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
        <pull.1132.v6.git.1661885419.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Aug 2022 18:50:12 +0000
Subject: [PATCH v6 09/16] bisect run: fix the error message
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
variable for it. This was fixed in 80c2e9657f2 (bisect--helper: report
actual bisect_state() argument on error, 2022-01-18), but the error
message still talks about `bisect--helper`, which is an implementation
detail that should not concern end users.

Fix that, and add a regression test to ensure that the intended form of
the error message.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c    |  2 +-
 t/t6030-bisect-porcelain.sh | 10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 56d900c3d3c..ba4aa8059cb 100644
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

