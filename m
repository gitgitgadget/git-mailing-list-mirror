Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740CFCE7A94
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 11:20:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjIYLU5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 07:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjIYLUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 07:20:52 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABEEDA
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:44 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-31f71b25a99so6044767f8f.2
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 04:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695640842; x=1696245642; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcNCEV02FNopnwM40T1pAoRlxIYH68QM3v1pI2RK28c=;
        b=C2NdqjXQjGZuGWfsJgA4HWO4tO/JY5NHzCNpmJX0fioXgUBMc6Mnrj75tmIgq8qCnQ
         NvdkhJHDNDw0gKBvnHedVZcGApLntc650D3e42s8mOc44BknquDBcKOMYg4eRqalXcbr
         WEJ5wf0wNsX4TEDixdkQ5xrtGJGQW04EcBrwi7gO7nf0otXRIVTIoD0XPmfxYAVFjnkd
         H3TLpj4GX17WRhyZCg37OsiH2mltWGPqIYKgeXUav2hQ4wAB6Um71iHyBi73Zf2eZ5DR
         eZOncRojBbEX7VmdC9PKAYmoGKBu/EI8CAuz35+elOIHzg9SLZEWw+Xh6Ew7QAg6MSnB
         POsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695640842; x=1696245642;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcNCEV02FNopnwM40T1pAoRlxIYH68QM3v1pI2RK28c=;
        b=aouDg9Y7Eo7Q5rrMsEmFwexDZB226W2aT6PIMg+gEYaHpeRP+FQ2c6O7J65+mQAk6i
         bF6o7exhYZjdhKUz5JusNjEJN3wdg3J2wIpPBGCqg3kqnMXVDrUGY505T4P0tUHUlUHE
         bKfQgXTBlo/0c8APTik9WyCAvzmHumGrYJiT88nmMgBMSrfgjhdxq3wkGq7r/iET/0bj
         t3x/B6Cdfvr/qPsyUjIREV8bdVhocQU/V7bLI/epwOITRT3KsMuILQBKW9K3+7EnFnI3
         y7p2Dztyv8VIXEOFrUPrBdIq4HPI75zJU6N4WAtShQMAcZZ12zcv7OV58smNiIU9jI3k
         ACnA==
X-Gm-Message-State: AOJu0YwH9wRfNj8hjswS7J8bm4EYjQfXrDcdwavN3wR7WqVooW08MznH
        oOJgRyhMP4PVZLlqwprX/LgA50/JDic=
X-Google-Smtp-Source: AGHT+IHplFHuadg0FYco5V4EZz4eFkK6iw4bi5PD8zpkhYFkrVkvHNYKzQmAp/QnJn9NWJh1nrVtGw==
X-Received: by 2002:a5d:4644:0:b0:319:79b4:a8ba with SMTP id j4-20020a5d4644000000b0031979b4a8bamr4823330wrs.41.1695640842592;
        Mon, 25 Sep 2023 04:20:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r2-20020adfe682000000b0031ff89af0e4sm11540997wrm.99.2023.09.25.04.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 04:20:42 -0700 (PDT)
Message-ID: <90db3d5d41f8042a28cce02f910e7b6d5904308d.1695640837.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
References: <pull.1579.v2.git.1695070468.gitgitgadget@gmail.com>
        <pull.1579.v3.git.1695640836.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Sep 2023 11:20:31 +0000
Subject: [PATCH v3 2/7] unit-tests: do not mistake `.pdb` files for being
 executable
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When building the unit tests via CMake, the `.pdb` files are built.
Those are, essentially, files containing the debug information
separately from the executables.

Let's not confuse them with the executables we actually want to run.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/Makefile b/t/Makefile
index 095334bfdec..38fe0ded5bd 100644
--- a/t/Makefile
+++ b/t/Makefile
@@ -42,7 +42,7 @@ TPERF = $(sort $(wildcard perf/p[0-9][0-9][0-9][0-9]-*.sh))
 TINTEROP = $(sort $(wildcard interop/i[0-9][0-9][0-9][0-9]-*.sh))
 CHAINLINTTESTS = $(sort $(patsubst chainlint/%.test,%,$(wildcard chainlint/*.test)))
 CHAINLINT = '$(PERL_PATH_SQ)' chainlint.pl
-UNIT_TESTS = $(sort $(filter-out %.h %.c %.o unit-tests/t-basic%,$(wildcard unit-tests/t-*)))
+UNIT_TESTS = $(sort $(filter-out %.h %.c %.o %.pdb unit-tests/t-basic%,$(wildcard unit-tests/t-*)))
 
 # `test-chainlint` (which is a dependency of `test-lint`, `test` and `prove`)
 # checks all tests in all scripts via a single invocation, so tell individual
-- 
gitgitgadget

