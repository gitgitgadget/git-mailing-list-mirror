Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75330C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344965AbhLVS4q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344954AbhLVS4m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:56:42 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BBEC061401
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:42 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id p1-20020a1c7401000000b00345c2d068bdso1843124wmc.3
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J9jVqwMPaNdDSNjujdVEAD8serufDJ5UG7qKldS2NTo=;
        b=dogplk6Pse60y+ZAKHh8ph6DXETtF0jwW5j1UHqA/2ISjoL+aa+B1BJfTj6friIvtV
         v0Ar7r/ruF9rpxgPHvgXgxG7IKRFcXT+8ozPKZ0m3vs3G5fwGT0VtBnYZhetT57OWbfn
         RNP37jSrFey/4UKgtGJyFuzPEN+qpJuqH6fl1ee8xO4g8iR4Biuid5RVHQsemFWkjqW/
         ldCP+TZvhsjIXTqr07slMX8bc6GabiedFIHjGf5vWj18AvCnwo1bulq5jKMkHtL0ZZR7
         dEUMGvGVrFsSfE2GRtHZvnDPRXPOCIeFdLtojqdPqB7h2rr4g1/Hahg4W4e1EtHHvORB
         b3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J9jVqwMPaNdDSNjujdVEAD8serufDJ5UG7qKldS2NTo=;
        b=PL81oZE7toYaQ/LgDMEvQA6iBO3P9VNwJzO6SirOo+FOTQ+kva/w2pKUjxAs/3gjwf
         92RsoiX8J+50hOv/y+gBxuZEfWnS7gkFBRBdzmQOaVo+a781/D4ZzvQgswLpjRKNgclW
         uNU0N+Qm4QHZYQVn60Vrl89BIVLsLe39C4bfCqWrTWl+eXwZbrlo8GIZzyrjCS5hyf2q
         qD8YKvtHfGhil6XnGwaFzeeHHT4JywpfWhCG4mBp3VJJhtiAM9wEPy9rCe6iEORWm3vQ
         F4EwsqovA9c4CwNwtR6Brfv0wmEVirF80OuBh+sVImAYHSQJo/nwvTbEn1JkUQWc2uFZ
         sm6A==
X-Gm-Message-State: AOAM5311jGvtwOH2oNFMb6wwJOzSvNcLyKZXKIPl47frRS32lABBkM9V
        7Tmso+pIF+XfSbJbOWVEXD50zGnxk5U=
X-Google-Smtp-Source: ABdhPJyGvWht0Fp+XPyQcQsfapoJejCSZqwRYYZlKWb+C603V6/+JBXZXUu8FKAmLehOysd28TaYpA==
X-Received: by 2002:a05:600c:3783:: with SMTP id o3mr1831409wmr.78.1640199400527;
        Wed, 22 Dec 2021 10:56:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b10sm2689603wrg.19.2021.12.22.10.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:56:40 -0800 (PST)
Message-Id: <7551bcdd9175d0e7a0bdc60ad0fed7310976e02d.1640199396.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:56:25 +0000
Subject: [PATCH v5 05/16] reftable: ignore remove() return value in
 stack_test.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

If the cleanup fails, there is nothing we can do.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index d628420e63a..4b7292945c3 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -89,7 +89,7 @@ static void test_read_file(void)
 		EXPECT(0 == strcmp(want[i], names[i]));
 	}
 	free_names(names);
-	remove(fn);
+	(void) remove(fn);
 }
 
 static void test_parse_names(void)
-- 
gitgitgadget

