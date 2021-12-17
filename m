Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929F1C433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 04:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbhLQEZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 23:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhLQEZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 23:25:28 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C391AC061401
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:27 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so805505wmc.2
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 20:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HKcGONYzuNGo4Z60SgbwND68IRFRxpUaJ+SAe9KSTeU=;
        b=g2m/BV9AiL5sIyjTrsmEpcaigO4VPlZN0bqtFTN5pMWlgmVDPRuCDkiR3G/fcFfgnD
         2NsZw1B9MWyNYSl3CxMssLPjgZSG1f30j0ETJ7c15dy40OZo1ovbYrZlzwXkY5QCVJdh
         o2lJx3oprZhNMzcwlilDF1IVQw+pymqurr6/7Q/+uPgKXlXYC0geBZfnVikE0v5bDGZL
         e0KOItZ5ES8/lVc1hOws5wvPT8D6iAtd0lI+sXC1ty/tqveKKCMA/9sYP6F8i31hT3PW
         xqdwUpHZyqABgiSbnjCb8DKxtMcn5Km/h/LQgxDxcC1fqZgXWIoeUjfAyEN2T7up0+wA
         dZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HKcGONYzuNGo4Z60SgbwND68IRFRxpUaJ+SAe9KSTeU=;
        b=4HZrvzVBnkWueLLJ+H+8vJjsx4yCBaUZtmkfq+7xcregCn1K1PCV9SYz4THRvN5msA
         6c9Yay/iOjuiwJr5MIBvPPh//P8g9cSlUxMoepUUFzJUH/l1cdBbjW/T2uhPCxFody0f
         1ZHUIeNTmLewZF8svG8JkUpzcs644KeBERfHON1oPPN+NRnfA4vRtp4oXy1sjj4npkuy
         v9u/r/TDB78INCV/Gq+srDcLrb7DptbCBDFaoSb65XC9ZtFn2dp7Z0rdEdssy58HxaFv
         D0ZaNbdWtK8ZqKCWjEmSu2mvaVxK0VEWDQCoOSpQRL1ARSO2fDGBwW4l0rAKH1ChuxoD
         45Mw==
X-Gm-Message-State: AOAM530SKuky9JJ6yyHcKNulpXFmspd9b5jX8/aJKeGlTtvD5AgLzLwV
        J74zaxKQUZVqaVoYPQSO9dShhJs71iZoMg==
X-Google-Smtp-Source: ABdhPJxFg4Xrrxhe40YszB0vCDlUiwCRvMTtErldO1dRIgA+QqsfOiI5uZeaa33T6oMOdX6x3N4Cmg==
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr179921wmj.3.1639715126164;
        Thu, 16 Dec 2021 20:25:26 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o64sm6325634wme.28.2021.12.16.20.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 20:25:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 5/7] progress.c: add temporary variable from progress struct
Date:   Fri, 17 Dec 2021 05:25:00 +0100
Message-Id: <patch-v7-5.7-c2303bfd130-20211217T041945Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a temporary "progress" variable for the dereferenced p_progress
pointer to a "struct progress *". Before 98a13647408 (trace2: log
progress time and throughput, 2020-05-12) we didn't dereference
"p_progress" in this function, now that we do it's easier to read the
code if we work with a "progress" struct pointer like everywhere else,
instead of a pointer to a pointer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/progress.c b/progress.c
index 680c6a8bf93..76a95cb7322 100644
--- a/progress.c
+++ b/progress.c
@@ -325,15 +325,16 @@ void stop_progress(struct progress **p_progress)
 	finish_if_sparse(*p_progress);
 
 	if (*p_progress) {
+		struct progress *progress = *p_progress;
 		trace2_data_intmax("progress", the_repository, "total_objects",
 				   (*p_progress)->total);
 
 		if ((*p_progress)->throughput)
 			trace2_data_intmax("progress", the_repository,
 					   "total_bytes",
-					   (*p_progress)->throughput->curr_total);
+					   progress->throughput->curr_total);
 
-		trace2_region_leave("progress", (*p_progress)->title, the_repository);
+		trace2_region_leave("progress", progress->title, the_repository);
 	}
 
 	stop_progress_msg(p_progress, _("done"));
-- 
2.34.1.1119.g7a3fc8778ee

