Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F720C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27711604AC
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 15:46:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234402AbhKBPs4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 11:48:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhKBPsx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 11:48:53 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16361C061714
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 08:46:18 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id z200so15113708wmc.1
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 08:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ulMMWzy7rXqFFjJnM3j2i3iw89BF4CDsIbfxaR7WZ/I=;
        b=L7VshczPcJBLsa9RzG8CKnZZ/cILXnO5ZeOxwPKfEvdpleotbrv2jq/5lhftuHxiLU
         OlpJc3zwPlNYGdP4sqvJuzP+eEGn0nHv/f4qDsczK5jQyzinWXBcJCamxnHpL8KVSbPF
         a3j4KkE9wvjGYkbUfGzdKTKivXpTtIizo+79WGsUMVersVE+2dlPFn01jBw0VuU+SXg2
         rW6GZ4KfWcGoBnDJEgA/nFrDP3YSXI0mHZb4HvkpLpZnqoq/itNaNR8XJNhgXP5qbPc1
         VBKjw2D7os8LJHIyDtqJkUpCEtMHZNY+DGjxe3JYoXgFm3XMUO66DJDBcT6C/Hjbc52Z
         n5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ulMMWzy7rXqFFjJnM3j2i3iw89BF4CDsIbfxaR7WZ/I=;
        b=yC3gClbLN0NGr39naYWwE/LDpJ6FnfersvSQh8tftVTRHtlovqRca0dbrJm2T2APG6
         xSMFO39G1f/LqNBXFHGWTPFRZF2XnLUnoExrWH84tlhw6eOVNo1DNLSytZjbkFXI1aA7
         gNpQx0QsSlxZ5rY6kfiotcV3lsoKwzfpD4WBMoS9G01ly6nRuIxowei+uckpuoNo++6L
         BhesvQ3m/yHm1admFA8ZtcUvydFu7pNSBhKlpgMlskQZerwt5p8qe3EL6yYHiG6EwDcP
         Ke55EXjrFMeneylq0hJvIHqej9VALlu09FzwWaBzURNkOAFY+zFjKP4y42k2UFGP5aBf
         zH5A==
X-Gm-Message-State: AOAM532G3QXfbF1Erhngq/J3ylZzDCJfuqrblALIeztkLRFVbC99wN8F
        vVgNNMmf5CtC/0Ue3hNT0TDxyitiznU=
X-Google-Smtp-Source: ABdhPJxQpiOBY3UgdkY8QakESHHETG1JX4oyYJmsZpkTTbzXMqGu8kKFJLNFG+kg8YlcCKBOlEiVNA==
X-Received: by 2002:a05:600c:4a27:: with SMTP id c39mr8149801wmp.101.1635867976456;
        Tue, 02 Nov 2021 08:46:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm3628613wmp.1.2021.11.02.08.46.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 08:46:16 -0700 (PDT)
Message-Id: <308a8f2a3ade63ef21feb945e45866f2a83ae101.1635867971.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
References: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
        <pull.1068.v4.git.1635867971.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Nov 2021 15:46:08 +0000
Subject: [PATCH v4 5/8] odb: teach read_blob_entry to use size_t
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
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
index e7f9f0bdc56..e6d52f98b15 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -85,7 +85,7 @@ test_expect_success 'ident converts on output' '
 
 # This smudge filter prepends 5GB of zeros to the file it checks out. This
 # ensures that smudging doesn't mangle large files on 64-bit Windows.
-test_expect_failure EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
+test_expect_success EXPENSIVE,SIZE_T_IS_64BIT,!LONG_IS_64BIT \
 		'files over 4GB convert on output' '
 	test_commit test small "a small file" &&
 	small_size=$(test_file_size small) &&
-- 
gitgitgadget

