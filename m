Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92632C19F2C
	for <git@archiver.kernel.org>; Mon,  1 Aug 2022 21:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiHAVPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Aug 2022 17:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232936AbiHAVPD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Aug 2022 17:15:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A69186DE
        for <git@vger.kernel.org>; Mon,  1 Aug 2022 14:15:02 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id bk11so5738333wrb.10
        for <git@vger.kernel.org>; Mon, 01 Aug 2022 14:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UWkmwEMmDQA88Knl6wRhhl/jDXRNKzlTXKO5NvbUwn8=;
        b=GQWuEBLm5vgLXo7y6JyfqGR0zBiyd1mhFBfSCuwyw1/hFaaPtZoRRIQqmIH8drhGOn
         cVhKoQwSl+98FTKmd4eCKtIIe1805MEcUZpvUEPvTld+U/Ds+z34sv/nGERBrNdvgfn6
         HYXba2kdpT66I3pEZTUDVEXL8i4EvExGq2S2xd8Z++1dd5H+V769uSetAsypahJPljgg
         my5lBVZWja5GGu/LIVe4cpf/JTPHr2RHZuzfViJvBZN4axnvx6Q/rKccKKB+3YJYHcan
         TFCzXLmVPtx3kcXUs/DB8EM2IEqG0YXrFAI3slkwg/Rl26zSxNVGagDWulAJL5JsR9Rr
         3+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UWkmwEMmDQA88Knl6wRhhl/jDXRNKzlTXKO5NvbUwn8=;
        b=uy9RecvDbs0Ku75xWnMMkqnJdxLESk63g3uFL7kMupgnDVxuwIPDUngi8VGwqTntdI
         toek+F51tM9GWYhPQZbMNALIXSsnGwKMNaVqp+5dAH3lGytv3GQ36tea870GzCL6o0xc
         dbLSFPEVkuz1LYllONhVteLe+bICc3FfmSEJWFXTvwxMVPb9puIxjzf1a8fvDysCwszw
         588l9RR3kQXun67+gsSlvhnOlSy1vU/bVnrrDntaPynUuZCvLDwbzr/cQCqQpIs1z+IQ
         RcjKft4CcnysiiXWVfZA4ZFbZpICtTjaVW2EtHpTWnM0zzDPqnvU2gsW5zoWguIGOzvI
         xkhg==
X-Gm-Message-State: ACgBeo1X4X/ZuwEwbaSct4PpE+Yeb4STWoxyJIJ6VNFbCdbnHtJzx0aO
        glsu0mNKhbcjoA4lnzClHG4YQh43XlE=
X-Google-Smtp-Source: AA6agR4V9fckUyLAnws7aHjxQd1lgME4pCP2Zz/3Hvcp1nlyKzBq5HBk6crhNhqDLZDF9BFAr/XOOw==
X-Received: by 2002:adf:ea0f:0:b0:220:5c01:22b7 with SMTP id q15-20020adfea0f000000b002205c0122b7mr7114760wrm.597.1659388500757;
        Mon, 01 Aug 2022 14:15:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c4fc900b003a31c4f6f74sm22794113wmq.32.2022.08.01.14.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 14:15:00 -0700 (PDT)
Message-Id: <a7a766de29b53610d19e56f270863230f3a2eab6.1659388498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
References: <pull.1310.git.1659388498.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 01 Aug 2022 21:14:52 +0000
Subject: [PATCH 1/7] scalar: use "$GIT_UNZIP" in 'scalar diagnose' test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Use the "$GIT_UNZIP" test variable rather than verbatim 'unzip' to unzip the
'scalar diagnose' archive. Using "$GIT_UNZIP" is needed to run the Scalar
tests on systems where 'unzip' is not in the system path.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/t/t9099-scalar.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/scalar/t/t9099-scalar.sh b/contrib/scalar/t/t9099-scalar.sh
index 10b1172a8aa..fac86a57550 100755
--- a/contrib/scalar/t/t9099-scalar.sh
+++ b/contrib/scalar/t/t9099-scalar.sh
@@ -109,14 +109,14 @@ test_expect_success UNZIP 'scalar diagnose' '
 	sed -n "s/.*$SQ\\(.*\\.zip\\)$SQ.*/\\1/p" <err >zip_path &&
 	zip_path=$(cat zip_path) &&
 	test -n "$zip_path" &&
-	unzip -v "$zip_path" &&
+	"$GIT_UNZIP" -v "$zip_path" &&
 	folder=${zip_path%.zip} &&
 	test_path_is_missing "$folder" &&
-	unzip -p "$zip_path" diagnostics.log >out &&
+	"$GIT_UNZIP" -p "$zip_path" diagnostics.log >out &&
 	test_file_not_empty out &&
-	unzip -p "$zip_path" packs-local.txt >out &&
+	"$GIT_UNZIP" -p "$zip_path" packs-local.txt >out &&
 	grep "$(pwd)/.git/objects" out &&
-	unzip -p "$zip_path" objects-local.txt >out &&
+	"$GIT_UNZIP" -p "$zip_path" objects-local.txt >out &&
 	grep "^Total: [1-9]" out
 '
 
-- 
gitgitgadget

