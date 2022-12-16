Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A95C001B2
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 15:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiLPPb0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 10:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLPPbY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 10:31:24 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B18A120AB
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 07:31:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id w15so2842988wrl.9
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 07:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAFl3g0ii3MudzNaTXBcOtIccfisGMWtyBiFHC36zl0=;
        b=LdDrvVqDNEUKvh2qtdLYqtbUM7JxF9U51EuOCbbADNOX9v8WHtlWUnWUNjjuEE2MZI
         tJFxnhq2pnRygw9VhYD11OoFOzJgXnwOP1B8UlSK989YtdY8eRWHC3pzRn+RFheM4Q+f
         nlM7FMqNQV1gDUv4UTfABwrplcXtpMit+FlNz+Lo4xpKhXseWba4aKqzOXL3fQajVE4V
         6LiMy1OXF1y9dx9c1gAPoVKL/BJrCZj6+Hz/Y1kZGWMpgX5rUpobKWQ4PSODlOwaEe3t
         2cmSvT6BkSczgjHO8V+yHFw3nZyP0e97eAIJqes4YEt075euHmUQj/q9eiyEaMIu6zLm
         mJqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAFl3g0ii3MudzNaTXBcOtIccfisGMWtyBiFHC36zl0=;
        b=hCXwZAa1AmP/sMFRAknalQL0H4uibGcLXT5kpJPafKmQbzXsEe1UugV8guXOXLu9z6
         kO2f57AmnH2Plb91tapGvH9ih53jKbx5ESxWt3cYCnJKkcD1Sx8rAfqjpD+Dn2K7pWp+
         FmT/s3S/Fkw+HJcCFrGTTnKSUGvA3XT2fS21rDnfAwYxMcWvUxa+jwR/eTg4sezP4FT/
         5UnZtlvqtHD1N8PrCPzz/KZYJyTcpb50slFS+grJeOner3RNud6+SlzJ+YprmytNuYRE
         QgJGbi+mtMQ98gSySIpkFCMSdZiVYBc7FvUXBkW6zBNXelFEBKQ1LC0u4kGH4Avah0+n
         1OZg==
X-Gm-Message-State: ANoB5pmP43jL2bEL/22ph1dXWfH2OMz+qslFuZrcTAwe9gjgi5ircLPm
        EKqUOaQGPMHqWwV0FAp3tRbWsoqp/XE=
X-Google-Smtp-Source: AA0mqf4hhbHIaAL0btHpUnpv8Ewk41xhs5y4MNerCtfRcag1Hy+0YtI1L9dUMbePUFZbwktPVKji2g==
X-Received: by 2002:a05:6000:81a:b0:242:69f4:cb75 with SMTP id bt26-20020a056000081a00b0024269f4cb75mr21768111wrb.54.1671204681414;
        Fri, 16 Dec 2022 07:31:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p13-20020a056000018d00b002422202fa7fsm2527169wrx.39.2022.12.16.07.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 07:31:20 -0800 (PST)
Message-Id: <c99470d46763cdfbde01629888c379c448b3579d.1671204678.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
References: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
        <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Dec 2022 15:31:15 +0000
Subject: [PATCH v4 1/4] hashfile: allow skipping the hash function
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com, avarab@gmail.com,
        newren@gmail.com, Jacob Keller <jacob.keller@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
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
index 0d29f528fbc..793a59da12b 100644
--- a/csum-file.h
+++ b/csum-file.h
@@ -20,6 +20,13 @@ struct hashfile {
 	size_t buffer_len;
 	unsigned char *buffer;
 	unsigned char *check_buffer;
+
+	/**
+	 * If non-zero, skip_hash indicates that we should
+	 * not actually compute the hash for this hashfile and
+	 * instead only use it as a buffered write.
+	 */
+	int skip_hash;
 };
 
 /* Checkpoint */
-- 
gitgitgadget

