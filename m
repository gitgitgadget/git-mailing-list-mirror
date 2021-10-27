Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2667EC433F5
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B8C8610C7
	for <git@archiver.kernel.org>; Wed, 27 Oct 2021 07:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240690AbhJ0Hvq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Oct 2021 03:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbhJ0Hvl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Oct 2021 03:51:41 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09ACC061570
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:49:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id b194-20020a1c1bcb000000b0032cd7b47853so388617wmb.5
        for <git@vger.kernel.org>; Wed, 27 Oct 2021 00:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=G8b0Yza3/ZQAy0Ifk3OIHmi/taJeE58zzCQSjNSOtls=;
        b=KCQ7rlv5YIQlqAaVelOOUnbrxG6rglpkBQiW2PlkrfF9EfKJ9KKalHcLCJEK2LQAnL
         HnZwsEPzfcF42/18ZZRHSBDdR7zYnU438ApMNAC3W9+CY1VRJ2klm9obZUa5Z7DNTzgv
         ogLGY6EGvx+RMhOJY6NctcVLNzW8adGe4BWI/lK9urkOigGkKJSZojmiShMbFLz4UXpf
         +NZlrrouBw0JbdzDX/YdPqcUKyXXAWl6tMzd2ra83QPnPZbzpIyFjBVTCUnsZeBEHVbX
         3fFU5rtF23s0BT/T4wbIPTgVy+7FeVStjWPpwb7N+yf370hHB/Qvp9khwmv+gf6vWQKA
         LnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=G8b0Yza3/ZQAy0Ifk3OIHmi/taJeE58zzCQSjNSOtls=;
        b=VyFYlgSHLuOXjAcEJBmj2W2f0KiuwE+FDmbQMCIarid+Qz5BkLOSmnk69r1aPgUsxe
         cB7otVUxXWRN8NZNgdFHVXNba33OkJ/lCkMHeZd8tdv5PXyTvecT/kskxh4bVJ6EKZ/X
         OWEFGzD/CPmvENurGWkAMwrWdjLisA41Bo2fbqtb2WrPoYVcS7mB50NuMfsv3/onfQVS
         mKRCI0gvSXL4nKyA8ZTjjA2hZW2WJnWrirPt24L0h47I4CGv2r9k+8coLwF3lP5yL9DO
         MdocsFSvfwf2/ZvKte+sMys9GFyx+JiH994XDRv+4qQ4+2vIMN4vEVeC6zQtJE7yQHmj
         +3Mw==
X-Gm-Message-State: AOAM532Ht3OuJkWt58fugPlbj32HuTZTb60YibyoyIfpnXe8BH+p7vcq
        Cokx7SmfMrbRoE1u8theKK1zIJwmSJg=
X-Google-Smtp-Source: ABdhPJwbmMWovZyt/2JqLjFf7Dzmxiadde6O/3rQTVt/FC1l3k60hwTTmWu4cYD4poyGHUFyirLPiA==
X-Received: by 2002:a1c:98d2:: with SMTP id a201mr4047776wme.113.1635320955225;
        Wed, 27 Oct 2021 00:49:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm20737063wrm.40.2021.10.27.00.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 00:49:14 -0700 (PDT)
Message-Id: <5b9d149ba23be06c70262128616e80f45a053a84.1635320952.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 27 Oct 2021 07:49:09 +0000
Subject: [PATCH 2/5] odb: teach read_blob_entry to use size_t
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Matt Cooper <vtbassmatt@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Matt Cooper <vtbassmatt@gmail.com>

There is mixed use of size_t and unsigned long to deal with sizes in the
codebase. Recall that Windows defines unsigned long as 32 bits even on
64-bit platforms, meaning that converting size_t to unsigned long narrows
the range. This mostly doesn't cause a problem since Git rarely deals
with files larger than 2^32 bytes.

But adjunct systems such as Git LFS, which use smudge/clean filters to
keep huge files out of the repository, may have huge file contents passed
through some of the functions in entry.c and convert.c. On Windows, this
results in a truncated file being written to the workdir. I traced this to
one specific use of unsigned long in write_entry (and a similar instance
in write_pc_item_to_fd for parallel checkout). That appeared to be for
the call to read_blob_entry, which expects a pointer to unsigned long.

By altering the signature of read_blob_entry to expect a size_t,
write_entry can be switched to use size_t internally (which all of its
callers and most of its callees already used). To avoid touching dozens of
additional files, read_blob_entry uses a local unsigned long to call a
chain of functions which aren't prepared to accept size_t.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 entry.c                     | 8 +++++---
 entry.h                     | 2 +-
 parallel-checkout.c         | 2 +-
 t/t1051-large-conversion.sh | 2 +-
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/entry.c b/entry.c
index 711ee0693c7..4cb3942dbdc 100644
--- a/entry.c
+++ b/entry.c
@@ -82,11 +82,13 @@ static int create_file(const char *path, unsigned int mode)
 	return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
 }
 
-void *read_blob_entry(const struct cache_entry *ce, unsigned long *size)
+void *read_blob_entry(const struct cache_entry *ce, size_t *size)
 {
 	enum object_type type;
-	void *blob_data = read_object_file(&ce->oid, &type, size);
+	unsigned long ul;
+	void *blob_data = read_object_file(&ce->oid, &type, &ul);
 
+	*size = ul;
 	if (blob_data) {
 		if (type == OBJ_BLOB)
 			return blob_data;
@@ -270,7 +272,7 @@ static int write_entry(struct cache_entry *ce, char *path, struct conv_attrs *ca
 	int fd, ret, fstat_done = 0;
 	char *new_blob;
 	struct strbuf buf = STRBUF_INIT;
-	unsigned long size;
+	size_t size;
 	ssize_t wrote;
 	size_t newsize = 0;
 	struct stat st;
diff --git a/entry.h b/entry.h
index b8c0e170dc7..61ee8c17604 100644
--- a/entry.h
+++ b/entry.h
@@ -51,7 +51,7 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
  */
 void unlink_entry(const struct cache_entry *ce);
 
-void *read_blob_entry(const struct cache_entry *ce, unsigned long *size);
+void *read_blob_entry(const struct cache_entry *ce, size_t *size);
 int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st);
 void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
 			   struct stat *st);
diff --git a/parallel-checkout.c b/parallel-checkout.c
index 6b1af32bb3d..b6f4a25642e 100644
--- a/parallel-checkout.c
+++ b/parallel-checkout.c
@@ -261,7 +261,7 @@ static int write_pc_item_to_fd(struct parallel_checkout_item *pc_item, int fd,
 	struct stream_filter *filter;
 	struct strbuf buf = STRBUF_INIT;
 	char *blob;
-	unsigned long size;
+	size_t size;
 	ssize_t wrote;
 
 	/* Sanity check */
diff --git a/t/t1051-large-conversion.sh b/t/t1051-large-conversion.sh
index 684ba5bd0a5..38aa0d8a075 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -85,7 +85,7 @@ test_expect_success 'ident converts on output' '
 
 # This smudge filter prepends 5GB of zeros to the file it checks out. This
 # ensures that smudging doesn't mangle large files on 64-bit Windows.
-test_expect_failure EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
+test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
 	test_commit test small "a small file" &&
 	test_config filter.makelarge.smudge "dd if=/dev/zero bs=$((1024*1024)) count=$((5*1024)) && cat" &&
 	echo "small filter=makelarge" >.gitattributes &&
-- 
gitgitgadget

