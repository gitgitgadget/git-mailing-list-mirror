Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D251C433FE
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8A8660FE3
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhJ1UxP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhJ1UxL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:53:11 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5492C061767
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:42 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso2468894wmd.4
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xQJS77RTg3Pdf1nt4Dna+a75Am/a8dbrk8tITHuHJ9s=;
        b=m2A6h+t7gJ6+4UzltwtniY0UTX2HJQboeeayDPulBJKCb4fzH3G7vqf8lNefjyJeeX
         WSOFibLqcaQiDtFSTCoCZfM1twJBIEh9Xgi86GNAAkFv9B2PP/tq7oDmZPW+6UY2RClZ
         UDItaQmNUOqdXhQx9adSs/rHCUD9ggI47G/wPWQk1WFRw3aUWRHaACfpvcmi5RL6xeFU
         7k33dVKSJwqLpuhxDe12li8r86YRVaBC9F/iANUh6k65fodfatak/EnYeDzy+Nnp0tmg
         asM6c+3vqrI0ctfjwFYv7DR+aMah9gAKXXpXbc4Rc7GsdoejnP23SOeT1DJh5DBCmtlR
         qE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xQJS77RTg3Pdf1nt4Dna+a75Am/a8dbrk8tITHuHJ9s=;
        b=0Hmf5G9NRB2V13hotz0GJxHEyR6n0/oqw65xYyRbuuImosbA1s3wnHX1obV1LBeXBx
         IVK+v8cuzcUpbeiddyDH1jBJj4lTm4B+wc71vgKfQYGak/31j8QkppEAx6geAjujefj8
         hRYIMYe3jY1qxQvPl/lK4kGH+/VgFg/tWXv+dQ6lyFRGHc0s0VSLK3hLI4YxHWGw/79c
         j8jrh4yQjrl7o2Ksom4H9CW1uYWlIpWoeKO3DqztdE9bVKokCGXRibB55zd6rOHOzSHa
         O6Jf3W6uD10CC+pkTvbVvXbt8n4/vcRySZJ/dxIJcsq/eFcJ8CSKKrpqUID3lyHx0xu1
         A88A==
X-Gm-Message-State: AOAM530HJTVXBztq31cKaAJcNYrPIpAL0EwHSLblnmu7HlX9X+90fe+6
        tsFgpD5N/KwjV80hEPxOPwdid/NZ1uA=
X-Google-Smtp-Source: ABdhPJzsw0mcmMT4c/gCV1aahZozUmUC7RRy+WSdj2o1RdqMd858QwhE61bEpw+0+uWzHW6QbAIWqQ==
X-Received: by 2002:a05:600c:1c21:: with SMTP id j33mr14706576wms.163.1635454241340;
        Thu, 28 Oct 2021 13:50:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r11sm3817625wro.93.2021.10.28.13.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 13:50:41 -0700 (PDT)
Message-Id: <3ffd3a001f742713eb0fde8508f876ff95103d82.1635454237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
        <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 20:50:34 +0000
Subject: [PATCH v2 4/7] odb: teach read_blob_entry to use size_t
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
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
index 7c1a2845005..5ba03d02682 100755
--- a/t/t1051-large-conversion.sh
+++ b/t/t1051-large-conversion.sh
@@ -85,7 +85,7 @@ test_expect_success 'ident converts on output' '
 
 # This smudge filter prepends 5GB of zeros to the file it checks out. This
 # ensures that smudging doesn't mangle large files on 64-bit Windows.
-test_expect_failure EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
+test_expect_success EXPENSIVE,!LONG_IS_64BIT 'files over 4GB convert on output' '
 	test_commit test small "a small file" &&
 	test_config filter.makelarge.smudge \
 		"test-tool genzeros $((5*1024*1024*1024)) && cat" &&
-- 
gitgitgadget

