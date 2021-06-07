Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FDDC47082
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725D461057
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 12:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbhFGMhJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 08:37:09 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:50801 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhFGMhH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 08:37:07 -0400
Received: by mail-wm1-f51.google.com with SMTP id d184so150073wmd.0
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 05:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=y4mvuHoWzj7XrrowHJV5XjYD/DABbA0iLonUwaUawQ8=;
        b=P7UzSDxwpbJIsNFqw0SlPxPv+n6U9n2EBK0Kp6+wtyDBpc5jvAszi7H/QvBF4I/qQP
         CJFWr+//EntOO3MwoTq7mTUDKc6Mhha+UTS6lGvGuOJg8AjRIWeRUiAGEqYPQkLHCoqc
         JmdQiaSWEvodhHp0l5AtRyIrmi5p13cnGRypETW28eWCcJvcUuXaBsVGCPhzXqDWf+h3
         bN9XtIP4oGkTYcRGns1uOJziRy9Jr32EOHPASbaPLO0eHk4cXCu8A3EAFq7d4ALTkZga
         HMnGBrlU62q5Cc6oS2bkqJskxOzGNxDbe9twdjuAybk3FkYi6cvXTBr25qt8kZX8OXMw
         1+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=y4mvuHoWzj7XrrowHJV5XjYD/DABbA0iLonUwaUawQ8=;
        b=LcpMGZ84HCj4uFnxA6fgbOLKHiD357G6Vj9zY+gNU/4rtu4y5OmoNYkXc20MLFwZjX
         Mr2SqSL6XRPNPigYPM5ERynP6THNTBZjOXeujVskoSsAxJ+3WCKu28YTLP9LoQfAPuDR
         xpb0WIZrzCl1TZlobmZ2Rx9I6jhsBQlBvpOguU+tTFEBiOLPxByryBPMs/fTmdU7VKqt
         +qQpj1f3MWdrQ9wxMPt0OlVsVbx/Gg+5jtYVAi91Su9pa8GwFPVWVRx68M9CFKQNBlK8
         YPeaepSxHMZo7AYVH07N88cXVFP8ILog+98FPJNTB2DCWKcQ13vu7P+DlV5ge3WMmJe6
         vSZA==
X-Gm-Message-State: AOAM530tZlqRT5JwCFTJSsfqZnyHHM1YXMZ62sVTGifX9dyiZj7TujU3
        Tahd8d+aSDZltEETv2k33cSt97U4KKg=
X-Google-Smtp-Source: ABdhPJzkgItBygvXHSAKoRMPa77IkoUd66KtVMJvdKGd0LkIHEqSFqZla6Eb4bKjgoKimavLeqC1hA==
X-Received: by 2002:a05:600c:1546:: with SMTP id f6mr4479756wmg.47.1623069256057;
        Mon, 07 Jun 2021 05:34:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm20493770wmq.45.2021.06.07.05.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 05:34:15 -0700 (PDT)
Message-Id: <b99371c7dd61bad552231ac964605cf738f90c7f.1623069252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
References: <pull.932.v4.git.1621598382.gitgitgadget@gmail.com>
        <pull.932.v5.git.1623069252.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 12:34:01 +0000
Subject: [PATCH v5 03/14] t1092: replace incorrect 'echo' with 'cat'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

This fixes the test data shape to be as expected, allowing rename
detection to work properly now that the 'larger-conent' file actually
has meaningful lines.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 4f2f09b53a32..d55478a1902b 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -40,7 +40,7 @@ test_expect_success 'setup' '
 		done &&
 
 		git checkout -b rename-base base &&
-		echo >folder1/larger-content <<-\EOF &&
+		cat >folder1/larger-content <<-\EOF &&
 		matching
 		lines
 		help
-- 
gitgitgadget

