Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66912C4332F
	for <git@archiver.kernel.org>; Thu, 20 Oct 2022 18:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiJTS2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Oct 2022 14:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJTS2O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Oct 2022 14:28:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E991F524E
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:13 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v1so387526wrt.11
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 11:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cTLoZaZ6n+Wz/7kdysCOtNZST9K2cELlvFYvnhYh5CM=;
        b=quXNb3GatOUDfTvVuA2OQa+AZUu01IrAY9bLoBSwGhMzD6TcCpOTf8WlE5lg8MwasR
         N2E1qM6mP4eKLzeKVhwpZpsn3ZTeOMVszcmrXiLeomNT91VGtjX3sQiGx3uWZywRvFsb
         kadkpI401otZAQ2X3Q4JVLyIuLtWHxwmC/iBR3Ep/zvN1G8IW4iAV20k+zu6ekTOQpdI
         U7BSegkBXqYiyhIUryiYv1Sh/GtxB5o009N/RrQvwge0yhn/xu0WNAApEEIAudOGURJQ
         7ShrFxr7JcOxchBKbsxtLbTE1w6koawJxCpsDA1sj//ZCgwhqBnM2R1I4CkBPlQMqJoa
         sHNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cTLoZaZ6n+Wz/7kdysCOtNZST9K2cELlvFYvnhYh5CM=;
        b=3/h6Cp+3TO/Zvrx8Jt6OGpUALIv5NV2I7r+PYcw6HmreTxeJOzXrUbiPJr5CFAQaQE
         jukMdD5w8zF4ZMHWxnrxzoTyBNUuTjIqitM0Q1uf6W/zU5DQXgPT0x4zlPt7HiGjq9pE
         Z2nxo1P8EcRiokiQ+/966+P+/vAtlk+HSEJx+9rcCzhTFc8lHLbFZNzMTIu7Pn8WCLvI
         zdDWK/VR36zuSfgv+DMr7gYEyzJaCH2wwii28VY4EQ8KYHbMZfajL7Yk2FYRM+mstvvY
         z3+V3f35+0aQwZYoEgKtsKxKqlCBAi9bqlzdzoxEtVHa7pUHQrju3WWmmfoqKUARgHcj
         ZYCg==
X-Gm-Message-State: ACrzQf2SlzyqiYdAl5zpsMMgawLh96InBeQ5W1Hrz5OOswpoovffkm7e
        yYYuMlqTwfXzukUI+WsViX+AZsaW7f0=
X-Google-Smtp-Source: AMsMyM6uNewKjWOaoeNedmVduKAR9njmqRz0Wrhskvx8gKfSem4cZ8Jx+k3XrDKwZP0jr/RkHqzhdw==
X-Received: by 2002:a5d:6485:0:b0:236:4ed2:409c with SMTP id o5-20020a5d6485000000b002364ed2409cmr1042427wri.110.1666290492151;
        Thu, 20 Oct 2022 11:28:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d19-20020a05600c4c1300b003a84375d0d1sm404059wmp.44.2022.10.20.11.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 11:28:11 -0700 (PDT)
Message-Id: <6e7e4f3187e2fbbbb54bb1cf5793bf6e981a5a94.1666290489.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
References: <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
        <pull.1373.v3.git.1666290489.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 20 Oct 2022 18:28:02 +0000
Subject: [PATCH v3 1/8] trace2: use size_t alloc,nr_open_regions in
 tr2tls_thread_ctx
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use "size_t" rather than "int" for the "alloc" and "nr_open_regions"
fields in the "tr2tls_thread_ctx".  These are used by ALLOC_GROW().

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tls.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index b1e327a928e..a90bd639d48 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -11,8 +11,8 @@
 struct tr2tls_thread_ctx {
 	struct strbuf thread_name;
 	uint64_t *array_us_start;
-	int alloc;
-	int nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
+	size_t alloc;
+	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
 	int thread_id;
 };
 
-- 
gitgitgadget

