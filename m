Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8FBC19F2C
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 17:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbiG2RMQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 13:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233332AbiG2RMO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 13:12:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413646C12E
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 10:12:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m13so2796021wrq.6
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 10:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nBMbWzVHMqXzwLlnW7jnIh9hCfJABd4syF3NF23qI1I=;
        b=UJ1s3XdZbAUnAIpctpGpeNILg5Nuhx2Tjoj+RfnOoGoV4W/+3nr78jj6beBxo9TqTd
         5/S4fnLF8abIsDi1aZG/FHxNLduik0vXKX3Xgimedj5D01xy1+9FUedEuS45yujz8wdR
         r6AosuiqVfy1SPIGjFK8vc9jclxJv4V3Uovj1sFX/l8kMUv0/tHX56iD+D1fYF7eGraI
         DoVnX65OH3ftCiIWqL0KqI4HPYj2UlWalYRCS18Aby0KWDl3w7lx+b+bP3IG+Qzaox8E
         IJ/OlAa0WGO8U44f/420YunYv4wFVfpReJ5z+Ad4Dq//EAQamUu4SJTBrbMxFmElusn6
         QzUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nBMbWzVHMqXzwLlnW7jnIh9hCfJABd4syF3NF23qI1I=;
        b=7hGG/YJHbl9GaFNMUplmnXrF4QyOsZn7H7x4JVuGOQfS8c4aAZJZPi+QbK8OgOoam6
         qwumZHOTUFmZ3V4MYQ1ZDlNYUtx645A5saf+sVxKXU7DPHkqFXkSlGtaUvMsgSggf2P5
         LhsfdoqpRf3CzwDspH9y/Hh5pwXAV9uUR/UbupfIadCiXaFTveaV4ZhGTV2dfIRWGv6D
         TxdAuiNQDf4Itnpj9GnyOxn43jf9cOuqIrN0kYCbUKrJMKd+TRDvBT65Yv64gxm0/S9G
         y0rPJkiVavpydhUFqIvvk2AUTBF316Rt9eQG6TRz6QKnqBnq4RntVeqLNY+4B2eLQOxk
         1l3w==
X-Gm-Message-State: ACgBeo1XtvUWwgPW111ygm9R4i/6lMfe5EhF/RjWYWecVdTkxRc38Sep
        Ycs/m6oBRD+goIdpIABTv5BuUmZ0EEU=
X-Google-Smtp-Source: AA6agR48sePHFiNYXIYXd9Q+gjbuh+pbCK1sZogpOFb0AZy/KK5wBUbK/aLzN0d9weGnmLR1Yb7tww==
X-Received: by 2002:a5d:6b43:0:b0:21d:7d01:b314 with SMTP id x3-20020a5d6b43000000b0021d7d01b314mr3180059wrw.357.1659114730110;
        Fri, 29 Jul 2022 10:12:10 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i16-20020a05600c401000b003a305c0ab06sm8783517wmm.31.2022.07.29.10.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 10:12:09 -0700 (PDT)
Message-Id: <082c7ffa41f241c61ae2fe5ab763fb09c680a17b.1659114727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1307.v2.git.1659114727.gitgitgadget@gmail.com>
References: <pull.1307.git.1659084748350.gitgitgadget@gmail.com>
        <pull.1307.v2.git.1659114727.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 17:12:06 +0000
Subject: [PATCH v2 1/2] merge-ort: clean up after failed merge
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 9fefce68dc8 (merge-ort: basic outline for merge_switch_to_result(),
2020-12-13), we added functionality to lay down the result of a merge on
disk. But we forgot to release the data structures in case
`unpack_trees()` failed to run properly.

This was pointed out by the `linux-leaks` job in our CI runs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-ort.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/merge-ort.c b/merge-ort.c
index 931b91438cf..e820e45a8e8 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3157,6 +3157,7 @@ void merge_switch_to_result(struct merge_options *opt,
 		if (checkout(opt, head, result->tree)) {
 			/* failure to function */
 			result->clean = -1;
+			merge_finalize(opt, result);
 			return;
 		}
 		trace2_region_leave("merge", "checkout", opt->repo);
@@ -3167,6 +3168,7 @@ void merge_switch_to_result(struct merge_options *opt,
 						    &opti->conflicted)) {
 			/* failure to function */
 			result->clean = -1;
+			merge_finalize(opt, result);
 			return;
 		}
 		trace2_region_leave("merge", "record_conflicted", opt->repo);
-- 
gitgitgadget

