Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCCADC3A589
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 01:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiBHBFK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Feb 2022 20:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343715AbiBGXuC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Feb 2022 18:50:02 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C888C0612A4
        for <git@vger.kernel.org>; Mon,  7 Feb 2022 15:50:01 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id c19so12872834wrb.10
        for <git@vger.kernel.org>; Mon, 07 Feb 2022 15:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=onCw496qxEGIYlKeL4ualhEcXJGdOJoVv6Y9YtBgwOU=;
        b=g2neCw6dkfwkqiz1+N28W9aYmPUTK61aZ4Jy96954KfsnbEG5jYdulGydyFe+mYU/D
         LB2X/KFdFT8GI0pmmR4o8HcgMIAzfJ58n2CNVMLuXUDbiSsYLba6ZYT09WTReQNyLzZe
         mFxT2c+QOFCvQdtI8TBJ1vknW13PxidypqLExknuRqv6pCYIIxDPF8XZ5xVjQjmEsUGt
         73h1dMmB879Q58g2LYuIiKBOEpSC3rYwDXoiA6kh1LDkgFEJO4PlSgl7rI9rmqKHexg0
         A6/nXKlLqOekXDmOCxiqL86VPgvnbiYBEmc8a/l2EdWpcXfvjkeDs/n5ARMOqzBG2RKX
         NlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=onCw496qxEGIYlKeL4ualhEcXJGdOJoVv6Y9YtBgwOU=;
        b=zNJuDDlYRkEKPAAmdDh+PKfP2nTqnglN7BiSLM/4MJGUk2e14tMXWkQ1hCwmPSfu87
         cXJ3mpMcBJDai+BRakfSn5TiNiCT0ljEY0ETXYtVaeqrkAJz8Pob1Yq2iurBOupaVcH7
         /ydknqFCXjiyvTrVrpJKguA1kQELmrxMUj23wHf50K52ZBemROeHPm6LwXMBkxetdNoK
         M+0ggPDd/xY0zZuxiQ+7Jj0FAqArjJMl/RU4sytqKk79e/2PvdcOt+t9MGFT0s59I1Iu
         m8HukbdJAUZTYoTZ4NklGCerPgovlN+2trK71XysxbNxwaqdA+rnJ9lR1helfP4OD7DQ
         38vA==
X-Gm-Message-State: AOAM5330xz6gFoTxn40bEl1zcN4qKq7vPqpoETQeCCuffbUqmy0SW8IW
        rkkFO82VOQVaAqR+5hV3NuJ0XQaam/I=
X-Google-Smtp-Source: ABdhPJzENNfLP9V+SwsYOy9kJhDnl1ZgOkiC7uk1HSWbtPgVttEu/mWzV61EC26mHs4ASZ9Mgx57CQ==
X-Received: by 2002:a5d:6982:: with SMTP id g2mr1433919wru.96.1644277799962;
        Mon, 07 Feb 2022 15:49:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm13518312wre.45.2022.02.07.15.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 15:49:59 -0800 (PST)
Message-Id: <49977ff9f4e5616689eecc388e53cd6312454da7.1644277797.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1139.git.1644277797.gitgitgadget@gmail.com>
References: <pull.1139.git.1644277797.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Feb 2022 23:49:57 +0000
Subject: [PATCH 2/2] t0012: verify that built-ins handle `-h` even without
 gitdir
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

We just fixed a class of recently introduced bugs where calling, say,
`git fetch -h` outside a repository would not show the usage but instead
show an ugly `BUG` message.

Let's verify that this does not regress anymore.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t0012-help.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 91b68c74a15..cbd725ccac8 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -139,13 +139,18 @@ test_expect_success 'git help --config-sections-for-completion' '
 '
 
 test_expect_success 'generate builtin list' '
+	mkdir -p sub &&
 	git --list-cmds=builtins >builtins
 '
 
 while read builtin
 do
 	test_expect_success "$builtin can handle -h" '
-		test_expect_code 129 git $builtin -h >output 2>&1 &&
+		(
+			GIT_CEILING_DIRECTORIES=$(pwd) &&
+			export GIT_CEILING_DIRECTORIES &&
+			test_expect_code 129 git -C sub $builtin -h >output 2>&1
+		) &&
 		test_i18ngrep usage output
 	'
 done <builtins
-- 
gitgitgadget
