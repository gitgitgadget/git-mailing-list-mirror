Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.5 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD541C4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BAA023C41
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387426AbgLITRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:17:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgLITRE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:17:04 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5C7C0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:16:23 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id 4so1464613plk.5
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=fuWckh7RvGU1LCxZf/NuvH2DHOrIMb+4Nr8WilM9O4M=;
        b=F9gI6dZ16TUpov7N2Hjtox5vQ4jEbAC7i7nInRWxeuWTpfShGvWrrrjmakuXGG2UeL
         iJnOmhmsgCHTpFji5XxGcXtApihdomABceZF6pOO7QD9ZJzRTaEtBK0kcqHYHIvUTwMH
         Jv/Uxbp+4GHZk3eM8FySL0p/hM7AmAuH9EpbEP4Y8do+fNsN4xyjkh8sOBVv8oNfQIq+
         h0jB9Mt3PVlMJbk5t/hR+cdIQZ+NcPF7t/amApTrdUWykc7YQKpoLJtl/jcRCY2bDKEJ
         law2y8xplFfCtSm1cT+FrtHOh1NXnRhXQJbwyppELasHgOFy9M+hf1SunWUHh1o9pnv6
         Corg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=fuWckh7RvGU1LCxZf/NuvH2DHOrIMb+4Nr8WilM9O4M=;
        b=AFBI89mzvCQjrZ2Boyy7X+dp/kXAIQh+RmEVvm4mmBBUWqM6dwvmA7s1gFzJE2jHmz
         jTpPpj8/I2Oi0GZ69EBYCiF9BNHg2lcb4Tg2v48x60bj9iUgfh84hffoNKLRCh1lhNZq
         fj+paKH5k3SmOF4B6fqGf7lJpxModX9VCad3BA0EGFeonfGI2rKIhPwGdpX0LUbJd0Ud
         Gb6KxPYux2d0T/D+6rnB2YrucZMBVZm30DrxgxpQ1svorDan75sBSQi4ncKFD4QF1aty
         jdr8ZdAO4BHrjzbfJ2lxS2SFX53XxIws7z/yrnbMydgX2LH+8DNoQf/IOUVMdtk2JxUT
         5r2g==
X-Gm-Message-State: AOAM530BX4HGIDVD/M6jmek+tVoTgfFM0JELevO7Astq7En8mdBY55SV
        FyCXKwAXImcjr6MMfveDxISamA==
X-Google-Smtp-Source: ABdhPJzZ20TdbezBGd1AAlfbBXEUcWdCjlGrU/NQVAIPuU9st+HtXm7/iwUsqpNHGi0gAH1wLxCw3w==
X-Received: by 2002:a17:902:fe95:b029:da:fa53:666 with SMTP id x21-20020a170902fe95b02900dafa530666mr3460035plm.72.1607541383386;
        Wed, 09 Dec 2020 11:16:23 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id z23sm3289371pfn.202.2020.12.09.11.16.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:16:21 -0800 (PST)
Date:   Wed, 9 Dec 2020 11:16:16 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, congdanhqx@gmail.com,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v4 5/8] maintenance: add start/stop subcommands
Message-ID: <20201209191616.GO36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jrnieder@gmail.com, jonathantanmy@google.com,
        sluongng@gmail.com, congdanhqx@gmail.com,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.724.v3.git.1601902635.gitgitgadget@gmail.com>
 <pull.724.v4.git.1602782524.gitgitgadget@gmail.com>
 <5194f6b1facbd14cc17eea0337c0cc397a2a51fc.1602782524.git.gitgitgadget@gmail.com>
 <20201209185114.GN36751@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209185114.GN36751@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Whoops, had a small think-o while writing the patch message. Fixed
below.

-- >8 --
Subject: [PATCH] t7900: use --fixed-value in git-maintenance tests

Use --fixed-value in git-config calls in the git-maintenance tests, so
that the tests will continue to work even if the repo path contains
regexp metacharacters.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 t/t7900-maintenance.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index fab0e01c39..41bf523953 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -422,7 +422,7 @@ test_expect_success 'start from empty cron table' '
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance start &&
 
 	# start registers the repo
-	git config --get --global maintenance.repo "$(pwd)" &&
+	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
 	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=daily" cron.txt &&
 	grep "for-each-repo --config=maintenance.repo maintenance run --schedule=hourly" cron.txt &&
@@ -433,7 +433,7 @@ test_expect_success 'stop from existing schedule' '
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
 
 	# stop does not unregister the repo
-	git config --get --global maintenance.repo "$(pwd)" &&
+	git config --get --global --fixed-value maintenance.repo "$(pwd)" &&
 
 	# Operation is idempotent
 	GIT_TEST_CRONTAB="test-tool crontab cron.txt" git maintenance stop &&
-- 
2.29.2.576.ga3fc446d84-goog

