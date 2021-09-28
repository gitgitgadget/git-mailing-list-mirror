Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B29DC433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8B760E54
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 15:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241591AbhI1PM7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 11:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241577AbhI1PMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 11:12:25 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADD2C061770
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:33 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u18so58696580wrg.5
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Oq3m349hkcfRVasOp2vvR/xdnJBjdFd5wMdePqDzUUg=;
        b=hKNCedYdyGQ1Xy4CjRElzBYxJzyv9h61R+Q1J3OyAPb5tL0gbROe8gXyKoEQaGOCAS
         m6wVZf1BFLc/Y7ja6ML3qoauYXBw6XwONGoGPC1Cg6XSyMTolppPvGz7yH56J2/AwwNn
         h+VqZQIOI2lZUHwgf3hO7srrdSz9ol/CdDw0YxAXiFZ8WL3qSUCosmtMPpBwAobCbZh8
         MLmpuJmIejWDspfmiaXtP/c23oOyjAR+bO/4brfRD9g0gj3C7OzxAnlHxYgT79zboUEX
         N+Oplvyztuh8v/degt6egIeeKn6XjphkuJX8Fdtft8OHDvd+Lm8ubmeXMY9dnYeu7Chi
         4EQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Oq3m349hkcfRVasOp2vvR/xdnJBjdFd5wMdePqDzUUg=;
        b=ZT7ssOOgxkYDyil1s++LzXI4ueRDD+Lrra7yLuLGbz2fuFt89IghksKswQYGMRQDNs
         ZMLaX6VzxhjHDd0VHFtCteOO3v0at1cJu7J8WEM7SdEOUJ2s5y8U89zYV7i6WSTE8mrj
         xKR5oX6u7fChEX6y6I/F4KEmaggFKs7yb8nQG9SYcq3Efx8HFYSqy4BbMIMKnMCvp/8z
         nNbiLGda2GbHG+op64eVrSCScLOPsyg4AxY00dzN/13Fi1C22SoaKdR7GBVfsBtM4o5P
         16n9a18yH681uk0bT7T9i32iwRb/sSJVYqqAMV8MsrYrBIR/mN23EUObYd3efuNVnFu4
         A0jw==
X-Gm-Message-State: AOAM531n8+r9uSO+dhIUFZM0TK32jfe22OR8inXBWVuOLchpjN+/GqYW
        h+OXryEKDKF4XG0JO2mrXpHHyJA10zo=
X-Google-Smtp-Source: ABdhPJw64Z9KFG/9OHrAnkziHSiyJA5FpQLq4RcXequUzWcoB0qdOCDi4zBTyZ1kw4aXGeG7575m2A==
X-Received: by 2002:a05:6000:1b90:: with SMTP id r16mr674012wru.250.1632841832150;
        Tue, 28 Sep 2021 08:10:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm3020961wmc.14.2021.09.28.08.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 08:10:31 -0700 (PDT)
Message-Id: <7b3215aef390d64e1064c89e8a566b62a1ab24b5.1632841817.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
References: <pull.1081.v2.git.git.1631213264.gitgitgadget@gmail.com>
        <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Sep 2021 15:10:16 +0000
Subject: [PATCH v3 19/19] Add "test-tool dump-reftable" command.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This command dumps individual tables or a stack of of tables.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 Makefile                 | 1 +
 t/helper/test-reftable.c | 5 +++++
 t/helper/test-tool.c     | 1 +
 t/helper/test-tool.h     | 1 +
 4 files changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 53c13c90a5e..21834ace4cf 100644
--- a/Makefile
+++ b/Makefile
@@ -2452,6 +2452,7 @@ REFTABLE_OBJS += reftable/writer.o
 
 REFTABLE_TEST_OBJS += reftable/basics_test.o
 REFTABLE_TEST_OBJS += reftable/block_test.o
+REFTABLE_TEST_OBJS += reftable/dump.o
 REFTABLE_TEST_OBJS += reftable/merged_test.o
 REFTABLE_TEST_OBJS += reftable/pq_test.o
 REFTABLE_TEST_OBJS += reftable/record_test.o
diff --git a/t/helper/test-reftable.c b/t/helper/test-reftable.c
index 996da85f7b5..26b03d7b789 100644
--- a/t/helper/test-reftable.c
+++ b/t/helper/test-reftable.c
@@ -14,3 +14,8 @@ int cmd__reftable(int argc, const char **argv)
 	tree_test_main(argc, argv);
 	return 0;
 }
+
+int cmd__dump_reftable(int argc, const char **argv)
+{
+	return reftable_dump_main(argc, (char *const *)argv);
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index f7c888ffda7..338a57b104d 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -61,6 +61,7 @@ static struct test_cmd cmds[] = {
 	{ "read-midx", cmd__read_midx },
 	{ "ref-store", cmd__ref_store },
 	{ "reftable", cmd__reftable },
+	{ "dump-reftable", cmd__dump_reftable },
 	{ "regex", cmd__regex },
 	{ "repository", cmd__repository },
 	{ "revision-walking", cmd__revision_walking },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index 25f77469146..48cee1f4a2d 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -19,6 +19,7 @@ int cmd__dump_cache_tree(int argc, const char **argv);
 int cmd__dump_fsmonitor(int argc, const char **argv);
 int cmd__dump_split_index(int argc, const char **argv);
 int cmd__dump_untracked_cache(int argc, const char **argv);
+int cmd__dump_reftable(int argc, const char **argv);
 int cmd__example_decorate(int argc, const char **argv);
 int cmd__fast_rebase(int argc, const char **argv);
 int cmd__genrandom(int argc, const char **argv);
-- 
gitgitgadget
