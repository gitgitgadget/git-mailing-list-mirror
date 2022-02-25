Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82991C433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 17:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243496AbiBYRKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 12:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbiBYRKw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 12:10:52 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B77EB1FED92
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:10:19 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l1-20020a7bcf01000000b0037f881182a8so2080213wmg.2
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 09:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=raZeHnz0d+CORTk9WwiMcBzUr8yYuX4fJZnnYzX4to8=;
        b=BvSZ0W7hTJAhBNGt+N0H/vIkov9vcdpdfnSkpPQMcFx+jh0esiwD3gjzcABRVwhiRQ
         d+HcDANHXw7Tn6Bs+7k0NOR4vTEwpJg/SqR31zJF1IrvcSK3W6kZGZfi5cy1Lps8VC54
         YzFrDSmNLPxHJddauvDTV0QaWI8YKfnpjvVn5EDjQ8iJ7U/cRYihOYJSpORQzXcaZ6Cy
         fmKKg8UGW/UVDVMiQoKLCHtRwuDUOKXYDDlHN2+TWpZ4Vi+1l4pSfKO+8EOH8XNb+Q3w
         t5HHjSKqbvKjjD44DE2S+x6qO0+XxFya+H5TvXrM/P4pAdOVrsoDi/7ceR4mUyCX8jE2
         f7pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=raZeHnz0d+CORTk9WwiMcBzUr8yYuX4fJZnnYzX4to8=;
        b=iJnNW99yTxCRs96YdAWXBKO35LB0HOG/a9qKHj+sWUNROjitRfOpPopATCHebmPlAR
         AZY3+J9HrCUkJ+4pwSiWiFRx1bklv02YJvqL36kaenaz2I8WKZJ7NUdbTwachFkrjzG5
         xUgNvyl4df48c94A+UZYQcDGRVBmkzCZbFLPUXxa6T6iORN5+BNCsYee9Oe1XFm481GP
         GRucafiqLJI+o88mMnnqsuv3wN40Od3iSwP9WhCnlpf1hD9ax7vuEwmQXibkjlYjReRD
         VaqyKUHs/KiN4tG8Vcj02xt7IWvriB7IOyixn21Hg9MlDccLiUdDCCQk5u0bmpc53m2v
         4h2Q==
X-Gm-Message-State: AOAM533uFMbllhlGvh1d35oRTe2C9WjA/2KhHtRkNBBDb8DVwmRh9PXY
        Bnq4obz3REbmTuUTDR1tr4prEc8X+ak=
X-Google-Smtp-Source: ABdhPJwlAwqTsXL5Pq03evK0qejBtJdGDMUYeymSemDTS+U83BKb2C6gu2+Cglh7LEViaZc1t9Zz3Q==
X-Received: by 2002:a05:600c:4b87:b0:381:fe:3c5e with SMTP id e7-20020a05600c4b8700b0038100fe3c5emr3527342wmp.47.1645809018013;
        Fri, 25 Feb 2022 09:10:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bh7-20020a05600c3d0700b00380f6ec4d5asm6030065wmb.16.2022.02.25.09.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:10:17 -0800 (PST)
Message-Id: <d29a68e65a0f5d37460175d9a4276fb2e1810dab.1645809015.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
References: <pull.986.git.1624559401.gitgitgadget@gmail.com>
        <pull.986.v2.git.1645809015.gitgitgadget@gmail.com>
From:   "Tao Klerks via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Feb 2022 17:10:13 +0000
Subject: [PATCH v2 2/3] t7519: populate untracked cache before test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>, Tao Klerks <tao@klerks.biz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tao Klerks <tao@klerks.biz>

In its current state, the t7519 test dealing with untracked cache
assumes that "git update-index --untracked-cache" will *populate* the
untracked cache. This is not correct - it will only add an empty
untracked cache structure to the index.

If we're going to compare two git status runs with something
interesting happening in-between, we need to ensure that the index is
in a stable/steady state *before* that first run.

Achieve this by adding another prior "git status" run.

At this stage this change does nothing, because there is a bug,
addressed in the next patch, whereby once the empty untracked cache
structure is added by the update-index invocation, the untracked cache
gets updated in every subsequent "git status" call, but the index with
these updates does not get written down.

That bug actually invalidates this entire test case - but we're fixing
that next.

Signed-off-by: Tao Klerks <tao@klerks.biz>
---
 t/t7519-status-fsmonitor.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 3f984136ea9..fffc57120d6 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -341,6 +341,7 @@ test_expect_success UNTRACKED_CACHE 'ignore .git changes when invalidating UNTR'
 		git config core.fsmonitor .git/hooks/fsmonitor-test &&
 		git update-index --untracked-cache &&
 		git update-index --fsmonitor &&
+		git status &&
 		GIT_TRACE2_PERF="$TRASH_DIRECTORY/trace-before" \
 		git status &&
 		test-tool dump-untracked-cache >../before
-- 
gitgitgadget

