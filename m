Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2371FC433F5
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 14:33:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233697AbhLTOdC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 09:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233666AbhLTOdB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 09:33:01 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8874CC06173E
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:33:00 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id y83-20020a1c7d56000000b003456dfe7c5cso8813610wmc.1
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 06:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qxLEDaVVXuSkRbZPv11EOStJOOrvJtXLEYzIeB0ifgQ=;
        b=TTw78Iu3egxl9bwxbIB37myp27wZHtlQE4cRiknNVrCwzhhq3JfkqBSju96j2Max9T
         GhwShpqEhDYPzTS8mj+jVqF8UddGpZ2JW8dHNgkjzRE8Ang5EvGS7nltt0tuY9/YTojt
         kW+7ZoGwB589RBnCNMqXSjO3bdrSgTCulhW515K1Lv+yWjH77rZxbh8aWdvI9LgF4VRW
         fgnzjKtxtUG55y33XpKJwoC2apP44IqUmiFfNbGBjQVQS14F7F03LITJXF+HZKnsQ3fU
         MscGIV/kCSEzE8orWTmqCiKmG/S9dA6szeriy3kBZUSj86X7ML1j0etdICougLfNBnij
         0DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qxLEDaVVXuSkRbZPv11EOStJOOrvJtXLEYzIeB0ifgQ=;
        b=63LLSSaMJZP0uSGbsaR2yRzZjEwu8EggQLr860ovF92b8al9nLPdjIJkIy+kHrZum9
         53ZX254yc2EvLGlCdNR8hiFs31Za2Btty0Mz8yAB0B3773RdiW3mVFaNDRhLoJyve1yl
         vE4vMUod9j/EeXGYQX9LqMobbsaHP9bwX9lBNZSwvzaJta+PauUoWqTOGhILm/yDkomA
         z1z/2VdQB2fGT8xS3dca4PMgH+r4hFGTInwlqHrlmMCi/7nurnopyqiewG7nY9ec8WKi
         cEqEx9z8Rl/JruVbxFc8JDzAPYtUxc7UV+TCdY/A39RDc3Rh/ivYRnvLJEr+S4crcDtq
         2jkA==
X-Gm-Message-State: AOAM531dyMdpyRSIuxgnuGI7jxcb4aIsDmEZ7CHKUmcmHrQyDtZM5NVA
        FsOi/2yEOkEmi1dZvzGKxvf/1njUJ0Q=
X-Google-Smtp-Source: ABdhPJw7M8W04Ii0Sxhq8CGS53ZneXu2UhoXL7gzjnUJ31NlhyH3BwBeRlAkSeKpmVxgahCigG6cmg==
X-Received: by 2002:a05:600c:3d94:: with SMTP id bi20mr21206838wmb.83.1640010779027;
        Mon, 20 Dec 2021 06:32:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bg12sm19736192wmb.5.2021.12.20.06.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 06:32:58 -0800 (PST)
Message-Id: <cc8639fc29db18da00ba2a95a1305efc3ea24205.1640010777.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
References: <pull.1100.git.1640010777.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 14:32:56 +0000
Subject: [PATCH 1/2] t3701: clean up hunk splitting tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Clean up some test constructs in preparation for extending the tests
in the next commit. There are three small changes, I've grouped them
together as they're so small it didn't seem worth creating three
separate commits.
 1 - "cat file | sed expression" is better written as
     "sed expression file".
 2 - Follow our usual practice of redirecting the output of git
     commands to a file rather than piping it into another command.
 3 - Use test_write_lines rather than 'printf "%s\n"'.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3701-add-interactive.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 207714655f2..77de0029ba5 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -347,7 +347,7 @@ test_expect_success 'setup patch' '
 # Expected output, diff is similar to the patch but w/ diff at the top
 test_expect_success 'setup expected' '
 	echo diff --git a/file b/file >expected &&
-	cat patch |sed "/^index/s/ 100644/ 100755/" >>expected &&
+	sed "/^index/s/ 100644/ 100755/" patch >>expected &&
 	cat >expected-output <<-\EOF
 	--- a/file
 	+++ b/file
@@ -373,9 +373,9 @@ test_expect_success 'setup expected' '
 test_expect_success 'add first line works' '
 	git commit -am "clear local changes" &&
 	git apply patch &&
-	printf "%s\n" s y y | git add -p file 2>error |
-		sed -n -e "s/^([1-2]\/[1-2]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
-		       -e "/^[-+@ \\\\]"/p  >output &&
+	test_write_lines s y y | git add -p file 2>error >raw-output &&
+	sed -n -e "s/^([1-2]\/[1-2]) Stage this hunk[^@]*\(@@ .*\)/\1/" \
+	       -e "/^[-+@ \\\\]"/p raw-output >output &&
 	test_must_be_empty error &&
 	git diff --cached >diff &&
 	diff_cmp expected diff &&
-- 
gitgitgadget

