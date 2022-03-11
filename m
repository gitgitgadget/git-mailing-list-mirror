Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945CAC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 22:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbiCKWwr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:52:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiCKWwe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 17:52:34 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D63221FA1C9
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:30:26 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id b28so5795220lfc.4
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 14:30:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N02KhVTYvRVKrWbf2GT8sT3dLTGR6Av8r8Cts0hfabY=;
        b=ZHCGSvlSLC1FBqgl5FNIxpEPJvnlG5x3PXRtevgxJoQzvXG6VUlC4GyFJz8uesw9F9
         uKmrIRNuDoXQVB0JJPKpVt81k2e1EFSpLfXm8yphhJ6Kr67g8QZ/+XwHlahrV2S7yKaN
         paTFpiiJ/rygujaYtwZSSbOG3YxAyCNPlxvTb2hfW8yUkOesG5b/I4cFd9bxU8iPJ5n/
         ITFopP4OOeXTvBkxidC+mGd4K2C+BWmNawvg4P4CwN9BeGiJtHiB1MyJzRI4UHLxL4Gz
         ijRz1A0fNzbkGj5ZPBG/EcHaG/PHxj7aIqcgX8AgJP7EEkqfi6lywQOf95FJdC3BRMJF
         7G8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N02KhVTYvRVKrWbf2GT8sT3dLTGR6Av8r8Cts0hfabY=;
        b=hOaYzsf0Tpq6OF2WEH85Ktp0SvFQ0sODTqMKWCqn4UuPwn2V9wf6tSPDCAjROSFgUr
         b83D9UaO9B+D74T+SAvYzqchyzUC00OUlSPEO0/KIFiEqNSMvwWidGbLdhnuvfKJysKp
         ou+Z9ir2tYD6n+zohvVEmKsr6F1kM3PWeXzoRfaHqwEtDgS+4oeg7k62GSoR9Ywboqdy
         Xn1ebmhhCs/X4YKFcH1caywjx2xjSPaIPN/PyNFVPPluXwllzi/wEpOfyUShEQYa28Rv
         P2MePObsmhfcqlgupz4GthuzutMwoluEgcx6BEumgD4pKd2iWtPNUbDJOSb4l6Q43o71
         0rog==
X-Gm-Message-State: AOAM530FYmMfc1h+gECBGGsw84OsmpimsUx5xX+bzjKv6FkFj5YO6jLY
        IsfRAgIPOD8g8QpUdNpU+FRbERRXGjQ=
X-Google-Smtp-Source: ABdhPJyEv8DNQZDWobDvOuR7OZGUBy0CNFCzyBpQPWQ2NzVJD5bi1Jq2RvJPgisMKZIfvh/r04bVgQ==
X-Received: by 2002:adf:d1a8:0:b0:1f0:59c5:5e18 with SMTP id w8-20020adfd1a8000000b001f059c55e18mr8698658wrc.585.1647033309114;
        Fri, 11 Mar 2022 13:15:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n20-20020a05600c501400b0038995ede299sm7568279wmr.17.2022.03.11.13.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:15:08 -0800 (PST)
Message-Id: <edd4af7333a479e5c92b1cfc13311ad974297857.1647033303.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
References: <pull.1174.git.1647033303.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Mar 2022 21:14:53 +0000
Subject: [PATCH 06/16] t/perf/p7519: use grep rather than egrep in test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

fixup! t/perf/p7519: speed up test on Windows

Use grep rather than egrep

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/perf/p7519-fsmonitor.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index a1c552129cc..5f97edf6a11 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -218,7 +218,7 @@ test_fsmonitor_suite () {
 		git ls-files | \
 			head -100000 | \
 			grep -v \" | \
-			egrep -v " ." | \
+			grep -v " ." | \
 			xargs test-tool chmtime -300 &&
 		git status
 	'
-- 
gitgitgadget

