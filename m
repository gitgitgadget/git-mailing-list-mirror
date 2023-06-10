Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09230C7EE43
	for <git@archiver.kernel.org>; Sat, 10 Jun 2023 20:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjFJUWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jun 2023 16:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232465AbjFJUVq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jun 2023 16:21:46 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E013AA4
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:41 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f7ebb2b82cso30784535e9.2
        for <git@vger.kernel.org>; Sat, 10 Jun 2023 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686428499; x=1689020499;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yRxjfJg1uXE6Fstm9uVOLObk2IL6n83aPh98fojxElM=;
        b=KllUfUiM0rsZ4vvMdBvMUgrerHhG+Fhsyca4mF/P8kYjXGb1roC4DgWqsShyhtBg1K
         GbkAxa+9cz/j9zaEkLwZm8lf/R4YEpUmnkdxx1CI+iRwUJZWBt0yvWLWb0uCUYyCZwMN
         gzfOrPBtqsEGkNaMnzYyXT3LghMLELmZ6DY6+M3R409sH2rbM/6Y1Hy2DeUx8p/9NeR0
         uxlUkhqYIzvXA5YdLqS6aLur++X/KdBuRkZX270cWvZZjzNHfHWiWfVtLOsrROLkaAU3
         lS65tqOtz3eRbfuHnMfVBDjBusvsdR+SDkzCCLvAoiJ1UA9eZ3ny6h6Pb7uBzokVPkmu
         /uWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686428499; x=1689020499;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRxjfJg1uXE6Fstm9uVOLObk2IL6n83aPh98fojxElM=;
        b=dpxOS305thjwkOJlMAPnsbfKyllyT4UFV7q9Wx7pddpNBj40eDYKQDBfTylytbt7ZH
         CyfBy7eXHOiG/iz/JSQZ5ZNXzFbYaqk4Dx/iS/R2Q1iOmq+EqN1oIbBr12wrvZCHSUE2
         IfKC3V47i6eZVU3O/VmpYCAn/U125uuI06CRoGW8JmYebvvC7ugLaklHlY+2R6C8v4VR
         kZbEdLr9FWZ1U2S1oYbRhxueQXqvZaM7oXFzVqv5NA0M9nspsX47Ra+9ZHH08Gb610LV
         g8KrRv/UzKKBaXQ63c8CDNAO4sFHypgKv9BLbzebQANMG+iIOJd1AIrQrh/x6Jtm9A2u
         3egw==
X-Gm-Message-State: AC+VfDxpKYnslQKMCyYDTmQnnnHlykWdxCAtSIphYMpOPMgnclpGixuI
        HK5V5Tugq31ooOEQ0h8g2pGNN5lwx1A=
X-Google-Smtp-Source: ACHHUZ5QyWopQ4U5pbiZQ6vG663yx5x2QLJKIqKsZO/Ja6HBn+6JL1AlIX1EjVyELMJ8/MnafBUq/A==
X-Received: by 2002:a7b:c4cd:0:b0:3f7:f8d1:122 with SMTP id g13-20020a7bc4cd000000b003f7f8d10122mr3972543wmk.20.1686428499340;
        Sat, 10 Jun 2023 13:21:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003f733c1129fsm6548346wmc.33.2023.06.10.13.21.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jun 2023 13:21:39 -0700 (PDT)
Message-Id: <807b8201d145a21c629797067cee21d1d1b9a0d4.1686428485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
References: <pull.1543.git.1686428484.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 10 Jun 2023 20:21:18 +0000
Subject: [PATCH 19/25] completion: complete --patch-with-raw
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
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
index a69421cd740..c0d2678d320 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1741,7 +1741,7 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--color-moved-ws= --no-color-moved-ws
 			--full-index --binary --abbrev --diff-filter=
 			--find-copies --find-object --find-renames
-			--no-relative --relative
+			--no-relative --relative --patch-with-raw
 			--find-copies-harder --ignore-cr-at-eol
 			--text --ignore-space-at-eol --ignore-space-change
 			--ignore-all-space --ignore-blank-lines --exit-code
-- 
gitgitgadget

