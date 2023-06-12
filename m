Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD98EC7EE23
	for <git@archiver.kernel.org>; Mon, 12 Jun 2023 12:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236078AbjFLMx1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jun 2023 08:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbjFLMxQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2023 08:53:16 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0106910FA
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:52:59 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-30ae95c4e75so4242297f8f.2
        for <git@vger.kernel.org>; Mon, 12 Jun 2023 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686574378; x=1689166378;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+M0/92IfMNu3+ZNKHyADTtuyGLmFRsLqMO6az5RJJ1Y=;
        b=FhZS2I+ceiyVM/GYbRgJyXM/sQ/mJw0AGepi9ROH2rYBhTh8zrln4v1ZOaRd8jmzpp
         UYJddc6z9C8wSBXc4Zhy5Bwl0YzykMYzi95rP/UCXiZFCyw7xC6bz4cxooRdkvQvwpt/
         VKPqn1cCr4nhCsOUvmEi0sR1mq/y563guzkHMp6xPjy+0hKn3OFavBJ4FEgyvSlYBG2p
         2APrPwMAgVYETE2HwxJNcPGv0W0gFYu68WGa+DrY9TBkTTXiBH4q7fJlduki38y2Kg/E
         Yb6ARk3dk7+dh3e0OUST/omu4ppcKYuOQDvsfPCwVgxxanVFPcKF57qz5MOzzhU69zjk
         7kYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686574378; x=1689166378;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+M0/92IfMNu3+ZNKHyADTtuyGLmFRsLqMO6az5RJJ1Y=;
        b=lGDX8qZwyK2qkZu8nnjR84B9fgdQMQWTjuZdPab86APYjdZouRIDd2nOHR8O3stplv
         rbby47RGZxQAj4r9UGwjS0FTGyNYIj0u5PTClPysDAK/xfKhNRVmL8bVsLZyJM/qT8kK
         ZH5L8X0JXjFGKYhxHiLyKORMy0kOW41XWOb/PcB6vdykzR5CLEh6CYAvtMYyfFw2r56s
         nGos9heKp4I0feB+yYas5dXjqfptcKPoF/G8WKIBGWadm4vqA0uQYt3PrAiz9st2vtcJ
         8+2VHJIFpMfuuOwlnUiHjTHYTmNJ95GrRfD1O903ndqk2TgtXaGcF9avgJNtiEzV+vfF
         SHYw==
X-Gm-Message-State: AC+VfDy897jMpOo4/uwqS0GbyaWOABkC2q76MBF0jrujGHdUQOFR164o
        6Da7v0xYi+z67Q3owllkLGk/qIl/JRc=
X-Google-Smtp-Source: ACHHUZ7QraG+gqqYrmHR0QYe+WqemliUl2XzxObeV/DI7MLu3qkWoWq7W6AKtzHUnpheOqrxSw2XzQ==
X-Received: by 2002:a5d:448c:0:b0:30d:bdce:fdbf with SMTP id j12-20020a5d448c000000b0030dbdcefdbfmr5459641wrq.19.1686574378101;
        Mon, 12 Jun 2023 05:52:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b5-20020adff905000000b0030aedb8156esm12281962wrr.102.2023.06.12.05.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 05:52:57 -0700 (PDT)
Message-Id: <d38823dd116e4579bbbeb96ff7b1eae8116681bb.1686574374.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
        <pull.1543.v2.git.1686574374.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Jun 2023 12:52:31 +0000
Subject: [PATCH v2 03/25] completion: complete --cc
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index f07b00b9c68..b61c54e37f7 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1754,7 +1754,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--submodule --submodule= --ignore-submodules
 			--indent-heuristic --no-indent-heuristic
 			--textconv --no-textconv --break-rewrites
-			--patch --no-patch
+			--patch --no-patch --cc
 			--anchored=
 "
 
-- 
gitgitgadget

