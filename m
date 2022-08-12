Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098AEC00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 20:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbiHLUK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 16:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234491AbiHLUKY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 16:10:24 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EFF6176
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p10so2245232wru.8
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 13:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=UWkmwEMmDQA88Knl6wRhhl/jDXRNKzlTXKO5NvbUwn8=;
        b=c1LZg0tyIjRaA0tMZh+uMUE9+biJx0sq5GDZ7VEqdlZcm1onsSj0Gx1+BrtX6tZcaT
         ySHDTlMF0M22HX1fnWMAHf3nzCwI/Zpx/0AwOiwLH/mKPZFZE8xSbkK3wIaYH1YeY+lZ
         ng+ZnFsvUAiWcPCFIiWWIZ07kQlmW7IsPb7X02JT0MAJYBNoHpAi3C+yQqtdrIlEjCGa
         E6hlBLOd8SFhjofe1R7DCU8OLBmcfrUCJGedo+JrnFUwm6SnmMKYXGhTcJD0GRAAtt1Z
         +O12LiE9wMNWTlj6gTqdu8X7Te6YjR6iSiCXX9KNnotK0qlhv5LuMx1ZE3ZCuB8v/MTB
         xKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=UWkmwEMmDQA88Knl6wRhhl/jDXRNKzlTXKO5NvbUwn8=;
        b=rQ0pJbEvInaHnSzMw10DcssEL8dXuibKE77eewskxNBUkZeGyP2crasEOzx0XiG0N5
         JqEvAdD7DAbBrG+8w9U3K0SSmSgI77JyXtFFhDwK/l9agv0aAmH2mwtIXz3qYCaft4aH
         gu4zgICspqNypi5ztabTX5YtYTpLhKbGNFd1u3rLFcuIiGaF9oyz7AOMGqaxzrbAvIrL
         n7aLhTIueoK+pSIYhMGRmHCRoOmgclz+uEMBF5m5tZEzHoRNgx9AFJlISrph7cj52eoU
         lKhL7iFMZdO56reOw4qFeJuDuGcHa1Y6k53HqZjKoQ/WMtShh7y9ruMgoptDPUgAW+T2
         WpLQ==
X-Gm-Message-State: ACgBeo2ZOcOWBxoevz+d7oAKoxpM609aNuLWUrciQUyk6OHA0PXDOVge
        Ynl+Rzh9zgh0hvczZMO/ldtmq+ixjHI=
X-Google-Smtp-Source: AA6agR6vQNPoUhERNJAi8mUfmPohHKJlWvkd6lOxIYhswX4WnmkYjBxTfLaUdp2dnF/TViN0uI3DBg==
X-Received: by 2002:a5d:6d0f:0:b0:220:76a3:b31d with SMTP id e15-20020a5d6d0f000000b0022076a3b31dmr3012087wrq.581.1660335021969;
        Fri, 12 Aug 2022 13:10:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bp15-20020a5d5a8f000000b0021ee65426a2sm289078wrb.65.2022.08.12.13.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 13:10:21 -0700 (PDT)
Message-Id: <f5ceb9c71903c41c47d715ec75ced9375c643ac3.1660335019.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Aug 2022 20:10:09 +0000
Subject: [PATCH v4 01/11] scalar-diagnose: use "$GIT_UNZIP" in test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
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

