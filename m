Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F51C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 11:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbhLNLsL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 06:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbhLNLsD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 06:48:03 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79507C061748
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:02 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id t9so31918450wrx.7
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 03:48:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6v0+JuvgL+rkV6+ZUY0aCiH0eSlBA7tjh6rJWXdXHEw=;
        b=c73frBoM2eIMIdBZaswTZRnKstwVRV+qUekdeKep3ktKsC+X6ahTKGxUtplttNYPvg
         zkGzs5tbk+bzA9Iy01Nr+yfHOVQ1gErBj/1WdNLBeql1qDSy4Y2mtipxHBWReorK1ohz
         A/H2C55FObhTqk5I10JaFThp7XkKo/gl7PFoIhPe4A1viA1CS24mgApEhYoPg8+/mzNo
         lGk39GTKovfrYSlQefcvubEpmP4guY8ul+0AB7QF+KUzlRqiEEOQOEgmcFlkEnfrTttz
         M/nXfgtUOnDpUe3/a1qatqQGmHyOLOVhRusZ1F/3kkE0Y3EMfhx0RTXifQljtnhCJ/um
         K7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6v0+JuvgL+rkV6+ZUY0aCiH0eSlBA7tjh6rJWXdXHEw=;
        b=vssh6ccy5jqtpRoLCaWzGYkdJDFtHHJo7XUQFhPkGRZ5Hrl1bLfcu7KD2++jgjQH2t
         x1+pTz4ITn6PxUS5ZS8TZ5Fr1AGWvfmjvOPX4g4+bopHJOoGmRe8qZ6k/NUho4IYZ912
         GULJgDo8uO6NghPuYpfKVy2COf0KhClGMooqBDP4PmJFp0AM4kkN+M1EVhHiAb+USYdt
         +xZuRC0mgZU1CXMdOrqauqv3ZQ480ChpohJBKhN+NwHiWE5UfRUBcRiGBGKC5yc2Q/gH
         aU0bbcq2xlu+yHqaVD8374P6dk+aMF00ymCEYwF/UXGJ9stK6o6zlfWEwa8VI6UKcD2Z
         io5Q==
X-Gm-Message-State: AOAM531zSH+MJipo2UaIDNwUL36yDiLbrOb/fZPG/f7i/jXporoO+E8z
        WvX2eiwOaQ8DcX/dRxTzKCmZPHicBlI=
X-Google-Smtp-Source: ABdhPJyRvdfCpBl7uSkMAzDcqly8vwLMnZNLw/DJxTyWnX9PYAb1LDOZj5Krr9E0FtUDVKfl8OAS2w==
X-Received: by 2002:a5d:4575:: with SMTP id a21mr5369685wrc.193.1639482481001;
        Tue, 14 Dec 2021 03:48:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 8sm8387719wrb.49.2021.12.14.03.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 03:48:00 -0800 (PST)
Message-Id: <51b4a17a2e1f867c47d0b00f72721ef6e21fab04.1639482477.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
References: <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
        <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Dec 2021 11:47:49 +0000
Subject: [PATCH v4 04/11] reftable: check reftable_stack_auto_compact() return
 value
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

Fixes a problem detected by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index eb0b7228b0c..d628420e63a 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -814,6 +814,7 @@ static void test_reftable_stack_auto_compaction(void)
 		EXPECT_ERR(err);
 
 		err = reftable_stack_auto_compact(st);
+		EXPECT_ERR(err);
 		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
 	}
 
-- 
gitgitgadget

