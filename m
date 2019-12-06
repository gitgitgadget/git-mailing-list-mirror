Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E025BC2D0B1
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADB6F2464E
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTtphh9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbfLFNIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:08:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35102 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbfLFNIc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 08:08:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id c20so5812637wmb.0
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 05:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pVjJ1d97OpG4rro4F3oFJL8ULZntWJLHWsqB7HlzzP4=;
        b=nTtphh9rgKmmpfkOeikVLjOlQ8e99T5+ZXX9LVZyAciOKdxvTjLXj7ejR621JLsj5P
         d9fFnvYdnlS9yHvymsTY7fSOE6nwC4MJLqtIbXUr1kpAbsTfzSWXjrhjEnRskyD/DaWS
         6xHKQOsVcQgOUWytEapD2w/iSMdqzpUu2CYknkcvPlpTjUGMDbkNLtBs53xoTkRRKzqN
         /eu5zDmrppwjnklYqk+celyuap3bgNSO34uaIHPaKpaX2QBU3R3y/w873tQ57JLSSm02
         6U65aqzU8SsnOfE+tl37XFy8eQutFfdmEoDZIrK1y/nnrZ0hOzCztHEUNmyC7g+Y+7hi
         g8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pVjJ1d97OpG4rro4F3oFJL8ULZntWJLHWsqB7HlzzP4=;
        b=NePKz6jneKpgmDgOwnWTIn0+4wfpCur5T5HaerCdarjwVgB5lAEQVq2x7idTXk24ft
         PisO1JrTi6sTfZKPU8hjXa7g2M9YG+TToSBhONrklAV99m7Xt/L0mlXmapNmZBffBWJ8
         qX1qVC30Mz6Wb3stAgYAbGy9I5AiibonwRr3IvplPIaE1z4RJ6jT/qzpWy5R3tia9p29
         16FC1qxwNBCSPET7fqYWjKnLwIS9VE1y24UL9L2nYh7f4qbQIIlTtCmaR9U3AxYJ+WDu
         19DlXTHyDicN+CNtEteVa8HNXTJCLBFDbTV+/Ckap00p1UcgBjJPp785ilaohcZ84mpi
         RHsw==
X-Gm-Message-State: APjAAAXjahPcY+Mn6n76ja2PIGjnBYL6NVknUlSVeFom9lkizzY4zyVo
        3fTkP9jwhZRShBW67TWuPJQndIE4
X-Google-Smtp-Source: APXvYqwF8Un3Nr4Edlden20V0YflFI5Fb/hSNNBy+DJLNOpIp+xfB1+TCQIiDQEyl6lfrgptL/+pIw==
X-Received: by 2002:a1c:dc82:: with SMTP id t124mr3962441wmg.122.1575637710541;
        Fri, 06 Dec 2019 05:08:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z4sm3407474wme.17.2019.12.06.05.08.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 05:08:30 -0800 (PST)
Message-Id: <3f219fd789b3cf1c4d9c42b71a175d31df1afeeb.1575637705.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.172.git.1575637705.gitgitgadget@gmail.com>
References: <pull.172.git.1575637705.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Dec 2019 13:08:23 +0000
Subject: [PATCH 5/7] t3701: verify that the diff.algorithm config setting is
 handled
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Without this patch, there is actually no test in Git's test suite that
covers the diff.algorithm feature. Let's add one.

We do this by passing a bogus value and then expecting `git diff-files`
to produce the appropriate error message.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3701-add-interactive.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 797610e96d..f43634102e 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -524,6 +524,16 @@ test_expect_success 'detect bogus diffFilter output' '
 	test_must_fail force_color git add -p <y
 '
 
+test_expect_success 'diff.algorithm is passed to `git diff-files`' '
+	git reset --hard &&
+
+	>file &&
+	git add file &&
+	echo changed >file &&
+	git -c diff.algorithm=bogus add -p 2>err &&
+	test_i18ngrep "error: option diff-algorithm accepts " err
+'
+
 test_expect_success 'patch-mode via -i prompts for files' '
 	git reset --hard &&
 
-- 
gitgitgadget

