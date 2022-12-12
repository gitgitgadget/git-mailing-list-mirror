Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D836C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 16:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiLLQbb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 11:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbiLLQbY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 11:31:24 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A31FCEC
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 08:31:21 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id n9-20020a05600c3b8900b003d0944dba41so5669893wms.4
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 08:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed5q4EI9Rja0zU3IUSIZ9CyNU+B6k57eyHEpfMq9F2s=;
        b=N9TLo4b0YJAnMqBn7W6Xr+yD4fMQjYFNCu4raw++ZuwTHvvqA8/fRckg1VsCsjkvSc
         vQ+Y52KRXPeEiYK1FWSW6PhHocXMZNG6vBLjTBK4rNHmskZ+rSN2C82gePUYo4Zi2BAk
         xByf+GFGHmSgnxmPlXi4+uDqhzOlEPFtl36OEEZqwbbcWH3lQkUyDwfoCM5dEKjLN1eK
         ZI2T0J5PVBw7TYM5pG+LcvWaCg9YdjZszYCRJ5zd2vSZLXQqrJw8/HrcZHMfq9rLY2jL
         JovkWzR3WZpkd/u4KPX6zjJLvsR453iYN85wgtWEmDMkfBQ7faIEu66l9T7cEM9K2WnZ
         YZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed5q4EI9Rja0zU3IUSIZ9CyNU+B6k57eyHEpfMq9F2s=;
        b=D70omHTwMVTLINh16tOI02xENKmNRvWGjK9iQ8WndjoGbnE2tCurVdhMAjcmEty4EI
         Ryd9f7DK3UOcEwHSPLp5dxjI6GUfVGI/raTAtmtKT0aapatOdXI8fNNoI6zER6Jxg+aY
         /8NYBzeEXrVBw8uvZx5UNjxmg6XjCN/KcB/Yf0+8TDWJgtB8vntv17p5iIRd8hsSnAuy
         /DFMJsEiyVKQq0KE+NzIKUTuMK3l7U4eu4L831jgjG9wrYC/Afj/v5EYhyVX8c2EDCT/
         9OCKbb87XPPuK6k7F98f5P7AQ3H+8Uw/Vik7T3hf9bzoLbZNVWcUj9tUWZgDdLbWiJRL
         hrQw==
X-Gm-Message-State: ANoB5plzmDfCH3dvT1GGj61JyquMka7fu4T5bSFacv2xl32MiA9fss8a
        NvwQTOVfzdTptYO6h5xfjoEh/qgW8PY=
X-Google-Smtp-Source: AA0mqf797uGpLey11OSWDFflIbPaz21DA48ut5R8Jh7CP6rz6hlS8Gk+Xw2l6RRljzE0H5ifCYTQsw==
X-Received: by 2002:a05:600c:2201:b0:3cf:6be3:a7f6 with SMTP id z1-20020a05600c220100b003cf6be3a7f6mr13007975wml.13.1670862679488;
        Mon, 12 Dec 2022 08:31:19 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c3b8c00b003cfd10a33afsm10700061wms.11.2022.12.12.08.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:31:19 -0800 (PST)
Message-Id: <b582d681581a356534ef018c3a12004b2d9779a7.1670862677.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
References: <pull.1439.git.1670433958.gitgitgadget@gmail.com>
        <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Dec 2022 16:31:14 +0000
Subject: [PATCH v2 1/4] hashfile: allow skipping the hash function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The hashfile API is useful for generating files that include a trailing
hash of the file's contents up to that point. Using such a hash is
helpful for verifying the file for corruption-at-rest, such as a faulty
drive causing flipped bits.

Git's index file includes this trailing hash, so it uses a 'struct
hashfile' to handle the I/O to the file. This was very convenient to
allow using the hashfile methods during these operations.

However, hashing the file contents during write comes at a performance
penalty. It's slower to hash the bytes on their way to the disk than
without that step. This problem is made worse by the replacement of
hardware-accelerated SHA1 computations with the software-based sha1dc
computation.

This write cost is significant, and the checksum capability is likely
not worth that cost for such a short-lived file. The index is rewritten
frequently and the only time the checksum is checked is during 'git
fsck'. Thus, it would be helpful to allow a user to opt-out of the hash
computation.

We first need to allow Git to opt-out of the hash computation in the
hashfile API. The buffered writes of the API are still helpful, so it
makes sense to make the change here.

Introduce a new 'skip_hash' option to 'struct hashfile'. When set, the
update_fn and final_fn members of the_hash_algo are skipped. When
finalizing the hashfile, the trailing hash is replaced with the null
hash.

This use of a trailing null hash would be desireable in either case,
since we do not want to special case a file format to have a different
length depending on whether it was hashed or not. When the final bytes
of a file are all zero, we can infer that it was written without
hashing, and thus that verification is not available as a check for file
consistency. This also means that we could easily toggle hashing for any
file format we desire.

A version of this patch has existed in the microsoft/git fork since
2017 [1] (the linked commit was rebased in 2018, but the original dates
back to January 2017). Here, the change to make the index use this fast
path is delayed until a later change.

[1] https://github.com/microsoft/git/commit/21fed2d91410f45d85279467f21d717a2db45201

Co-authored-by: Kevin Willford <kewillf@microsoft.com>
Signed-off-by: Kevin Willford <kewillf@microsoft.com>
Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 csum-file.c | 14 +++++++++++---
 csum-file.h |  7 +++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index 59ef3398ca2..cce13c0f047 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -45,7 +45,8 @@ void hashflush(struct hashfile *f)
 	unsigned offset = f->offset;
 
 	if (offset) {
-		the_hash_algo->update_fn(&f->ctx, f->buffer, offset);
+		if (!f->skip_hash)
+			the_hash_algo->update_fn(&f->ctx, f->buffer, offset);
 		flush(f, f->buffer, offset);
 		f->offset = 0;
 	}
@@ -64,7 +65,12 @@ int finalize_hashfile(struct hashfile *f, unsigned char *result,
 	int fd;
 
 	hashflush(f);
-	the_hash_algo->final_fn(f->buffer, &f->ctx);
+
+	if (f->skip_hash)
+		hashclr(f->buffer);
+	else
+		the_hash_algo->final_fn(f->buffer, &f->ctx);
+
 	if (result)
 		hashcpy(result, f->buffer);
 	if (flags & CSUM_HASH_IN_STREAM)
@@ -108,7 +114,8 @@ void hashwrite(struct hashfile *f, const void *buf, unsigned int count)
 			 * the hashfile's buffer. In this block,
 			 * f->offset is necessarily zero.
 			 */
-			the_hash_algo->update_fn(&f->ctx, buf, nr);
+			if (!f->skip_hash)
+				the_hash_algo->update_fn(&f->ctx, buf, nr);
 			flush(f, buf, nr);
 		} else {
 			/*
@@ -153,6 +160,7 @@ static struct hashfile *hashfd_internal(int fd, const char *name,
 	f->tp = tp;
 	f->name = name;
 	f->do_crc = 0;
+	f->skip_hash = 0;
 	the_hash_algo->init_fn(&f->ctx);
 
 	f->buffer_len = buffer_len;
diff --git a/csum-file.h b/csum-file.h
index 0d29f528fbc..29468067f81 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -20,6 +20,13 @@ struct hashfile {
 	size_t buffer_len;
 	unsigned char *buffer;
 	unsigned char *check_buffer;
+
+	/**
+	 * If set to 1, skip_hash indicates that we should
+	 * not actually compute the hash for this hashfile and
+	 * instead only use it as a buffered write.
+	 */
+	unsigned int skip_hash;
 };
 
 /* Checkpoint */
-- 
gitgitgadget

