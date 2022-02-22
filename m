Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03969C433F5
	for <git@archiver.kernel.org>; Tue, 22 Feb 2022 16:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiBVQax (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Feb 2022 11:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiBVQax (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Feb 2022 11:30:53 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614A2166E1F
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id h6so34382101wrb.9
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 08:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+m/aieNUxti1udp6/tuXx1EdP5Pxoaz8caGLgixBNK0=;
        b=OELDgwph2ZrhcjWXCeXCVynGDrNvb9CbG6t8VlFbzbyPpQ1uUonHa2+QNLlw+xGz0X
         qZ1LSAK/uMGj9B7sThH9XsRU4rEcKNBELoUnO3wuCtqMDASeann51hSq5DNPDCPr5TIg
         3uERsJ3WQprX8E4syAe5H3p/vIDkTnItwYfdC55a/SUo64qXjtaKzoCT+W3L1apbDazY
         8FUz/+vzdWZfAtaCs30YQ0wpg0KtpnaeFv4mVGZuxHF3N79VAxxRngmwt9bwkIOMY8ja
         pPqeY1yp9vXZRePetMNXogv8ozFGAHubkVay0zHWJ7ag5Bks9isPDekGAa2pBftV/u74
         eHqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+m/aieNUxti1udp6/tuXx1EdP5Pxoaz8caGLgixBNK0=;
        b=slgXx3tfVW6u4mFd8tQQbp87U7qgAk6OURhXp0uUUpUDI84iiedZkoHVluZsjRGN5n
         U33WKLfipD/dyD0J0hilGvGZu/lGu58G8a8kGHjiEc4zRO9K9a0Judnr4RvHc425suRm
         1/g6eMYbLxC18LIQbL81wNy4v03FIC39Pk0iSNm6Dg6em6LW6USt1+NTsxidTBhMZFig
         9XhuVE307YsKRu+QtfErCkFV777jEfqjd7oefQyvXSTfYMhyGiZT7IS0ZYhuOIBcemDe
         kEmMU7bMQVLEmJuvC0IfamOh1rUYrCs6HGSWcp+bsy5mxyFCyKayJthKoSB0ECWulIfT
         O19g==
X-Gm-Message-State: AOAM530ELwoxmkT0nPD3TMKXeOvEU/bIiegJtu7L0xfnubzGkAgIUPcp
        4T/CukQlCCmkciYvvct9dU9NBhAkXRw=
X-Google-Smtp-Source: ABdhPJxpINWLHQ2RiHntkwFRzUiZYqQthIFG9qr2cG2xYVXVv6wq7/tOM27r4khC/VpDSPkRvMC5CA==
X-Received: by 2002:a5d:530c:0:b0:1e4:aabf:ad5f with SMTP id e12-20020a5d530c000000b001e4aabfad5fmr20185110wrv.28.1645547425806;
        Tue, 22 Feb 2022 08:30:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20-20020a7bcb54000000b0037fa63db8aasm2838044wmj.5.2022.02.22.08.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 08:30:24 -0800 (PST)
Message-Id: <81ca0d68cde6c1cfcf439b8b43016fd2b8e64d10.1645547423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <pull.1132.v2.git.1645547423.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Feb 2022 16:30:10 +0000
Subject: [PATCH v2 01/14] bisect run: fix the error message
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
 builtin/bisect--helper.c    |  8 ++------
 t/t6030-bisect-porcelain.sh | 10 ++++++++++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 28a2e6a5750..4208206af07 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1093,7 +1093,6 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 {
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
-	struct strvec args = STRVEC_INIT;
 	struct strvec run_args = STRVEC_INIT;
 	const char *new_state;
 	int temporary_stdout_fd, saved_stdout;
@@ -1111,8 +1110,6 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	strvec_push(&run_args, command.buf);
 
 	while (1) {
-		strvec_clear(&args);
-
 		printf(_("running %s\n"), command.buf);
 		res = run_command_v_opt(run_args.v, RUN_USING_SHELL);
 
@@ -1157,14 +1154,13 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 			printf(_("bisect found first bad commit"));
 			res = BISECT_OK;
 		} else if (res) {
-			error(_("bisect run failed: 'git bisect--helper --bisect-state"
-			" %s' exited with error code %d"), args.v[0], res);
+			error(_("bisect run failed: 'git bisect"
+			" %s' exited with error code %d"), new_state, res);
 		} else {
 			continue;
 		}
 
 		strbuf_release(&command);
-		strvec_clear(&args);
 		strvec_clear(&run_args);
 		return res;
 	}
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 1be85d064e7..720442de2eb 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -980,4 +980,14 @@ test_expect_success 'bisect visualize with a filename with dash and space' '
 	git bisect visualize -p -- "-hello 2"
 '
 
+test_expect_success 'testing' '
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

