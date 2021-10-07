Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724E8C4332F
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DBAC6120D
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 20:26:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242243AbhJGU2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 16:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242320AbhJGU1i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 16:27:38 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB229C061772
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 13:25:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id r7so22714065wrc.10
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 13:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Y8xygLBEpIwgrHd3gJDb2UpbcYegKU1wZLV3OyStP30=;
        b=GOERJI720zsDqsB/OfJXVnQeN2UW2t4XuNfqpdfmtDTT/VtJE3+/DTaXwLLwqh0FHG
         mXzPlwryUFGbzfrkquaSVfAfa4OKgG/rtrBtJHcFcCg/EmCkz+cZauSjexImRP1wnRos
         EunpmwdFCD7tXKh3WHcqEC3UopQji+ZqSMu6XwyIW6MucuQzb1zS8yiqkvzmY7HZqyr3
         Rf89P/LL+80cR9M8KhEZLyPXphk2a1gx6sYolpcWdiwJ7CSDSMxhk0SCPd5oUrsGAjOi
         mf7L/DA+pSg7j9Xw8lzqemye594W2Svruv4h36a+p0rwdwp+3Hut75b7ifNIa1aMVTn8
         yotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Y8xygLBEpIwgrHd3gJDb2UpbcYegKU1wZLV3OyStP30=;
        b=NequBvwM/N/AigXOjhEbXDDjuifWjXhDkOoT+PFeWOKY0+OGcFGhMjpDvrvDQ6a8n3
         rUmoLwSS0Z/0QmayWAYBrKvz0LTo5wWK/uAsw8AMwMrLnS3FKqeblRe/RsJZ9pgbCFfO
         EvxjZ7V+qxcS2F7EKSSJiewq96aKbViScNk5fP6TXQRAgDK2hmK72na6HqlIdehmsrC4
         SwXytx7aVCzDn0kOt43Soq76Y5l9jQrE0AYE2B5UAQavzRZUn3jHJMyI1nLXXZo/YvUo
         1ICUbpGECyqaMEFVZmLaKe67ZRpuVjvGs9kKg+BY8f61Qo+wWiw7AHj1r2oLXzdRcD5o
         OgcA==
X-Gm-Message-State: AOAM531cOQzWxtbpSIidseJo9yf6RRj6bjsH/6Qz7TooypCLexwyzs+5
        zVVbrfcm5UPVT76zGWwj+02Eby3lX8A=
X-Google-Smtp-Source: ABdhPJx1i68jtrENGkxh64fQwIWa73lzDXD9j1oYN0wIoSA9QEYaxFJe6ssA0hJzj6a9PbgY/OumfA==
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr6885899wma.161.1633638331453;
        Thu, 07 Oct 2021 13:25:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm483449wrd.71.2021.10.07.13.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 13:25:31 -0700 (PDT)
Message-Id: <c8428cb0df857fbc47c6cbc2813d4701eda36321.1633638316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
        <pull.1081.v4.git.git.1633638315.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 Oct 2021 20:25:15 +0000
Subject: [PATCH v4 19/19] Add "test-tool dump-reftable" command.
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
index 29344440715..0d189a72410 100644
--- a/Makefile
+++ b/Makefile
@@ -2454,6 +2454,7 @@ REFTABLE_OBJS += reftable/writer.o
 
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
