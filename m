Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E14DC433FE
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 287A761100
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhJ2OCB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhJ2OBy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 10:01:54 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA7C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:25 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id s13so9145029wrb.3
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1+ty6a4AULDHr7+j56mom2jNLWnzVhESh0nVpi+cBaY=;
        b=l9ogPCzP8Sl1gPVMmoFWx0dquH89AXDvorvbLEm2t11jSy/g6vxNN/tuLaWltfLKBk
         UkI2qV7wNnir0LZSqPiDMhe7yrn9M5w3xdRmA8b3ISnVpv5bOgAVev07NCF0LYuP7YPY
         UsL2OtRv1PlR7JxCi5z2THMcdB8VdnXb0uCw2iLYBOkl/UreGww8Xql+ZtKS20fsBiWa
         t2gRXYsV5iDxJd9uApLmGn8AjIiVjKTuTyRZ3xi95DE7XfVExBTn/XHaP99m0nQjTVj/
         C8l7cNoYinf2HfI0taPP1c3ZynBN+j3F5AIyoygrSjRdYQiM78amd+hu9fFEbzEr6JpQ
         xaVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1+ty6a4AULDHr7+j56mom2jNLWnzVhESh0nVpi+cBaY=;
        b=tbV78RObFncUmKaE7gNwAqX3jBt8ihkYDYrILOrD0Wq4XxhGAeXHlDAIVRNQ24gDRO
         o909QTFsbfbPQV/BqtdX2N0PXOQZqP5BOqaDTfsvL9Dxl3KSg7EEJFzWdCnQEqoMKf/q
         qTj3XcbDi0JNAkBSKE3VXfCoh6hZZVng5RSUQVY1v1Cvonczy7A09elbJeonYz+JS9GW
         kCPbUcUFWP2OiFaPiiJxq9HSJ5emxBoTFbWaSK3P8W/56KqJplEmkoc3/ZXgG0Sg4DHr
         QRywome2NIT2/Rs4FI5l3ApDWlVJR4XMlwLAif4CWg6KA3vnuzoryh9X+6ezY2hKKwSi
         WgRw==
X-Gm-Message-State: AOAM530BtO4CwvgpA9MEdc7uq0fuobu9skotzmb1bB3aXObES4TXlHL9
        zzJIKgxMbqwtzpor9TxHMWVCQhRMNZU=
X-Google-Smtp-Source: ABdhPJzVn85IS86kUOc2SWMo3PQWFbhHNIkSUDCCEDgBsrdtPTrvrFKhxJN8RItPfuXrCk8tLrbd6A==
X-Received: by 2002:adf:e0cc:: with SMTP id m12mr14880858wri.62.1635515963982;
        Fri, 29 Oct 2021 06:59:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o23sm5686312wms.18.2021.10.29.06.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:59:23 -0700 (PDT)
Message-Id: <dbef8168bc7044dbc8471c5ecc7146cf3e979263.1635515959.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:59:16 +0000
Subject: [PATCH v3 5/8] odb: teach read_blob_entry to use size_t
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index bff86c13208..8b23d862600 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -85,7 +85,7 @@ test_expect_success 'ident converts on output' '
 
 # This smudge filter prepends 5GB of zeros to the file it checks out. This
 # ensures that smudging doesn't mangle large files on 64-bit Windows.
-test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 		'files over 4GB convert on output' '
 	test_commit test small "a small file" &&
 	test_config filter.makelarge.smudge \
-- 
gitgitgadget

