Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CD2C5479D
	for <git@archiver.kernel.org>; Fri,  6 Jan 2023 16:32:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjAFQcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Jan 2023 11:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAFQcC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jan 2023 11:32:02 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED68976EF1
        for <git@vger.kernel.org>; Fri,  6 Jan 2023 08:32:00 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id z16so1760124wrw.1
        for <git@vger.kernel.org>; Fri, 06 Jan 2023 08:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gAFl3g0ii3MudzNaTXBcOtIccfisGMWtyBiFHC36zl0=;
        b=aK3B6cwKg3htHZKo85uf2S7rkGqMzxuaaBW01WhECc/uLjcXQxWUGaHk/UK+iaiLkG
         T2G8o2wbK4jUst4ysihpjUV38H8JmkeWQ7Y8tbCXmJNlkGOjwrurfR+gBgZo5gdE5Ah/
         iAqFTytDwC5tBYBbjkwvIyP4XC3CqvkkXb1c6/OGRx/USdNugr+drn0wl08lCJNxixcp
         6i65uwJaoivX64tuYO5zkhkjWkqy1bFW9g9y2n5NGAgIhQ/N1RGx0jKfgDZVUuvc4FCB
         eBL5lYFWoVRvyOZPCxcbz3CNR9Nwy+tRPLHidGkzaTqVL94lNEksoSs6+aC0Alb22zeV
         hxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gAFl3g0ii3MudzNaTXBcOtIccfisGMWtyBiFHC36zl0=;
        b=BNgTA8EXa4RpYBPcToN4U2R/2jf+//3hbMms1KGzMkd3F/K/7i4di4kyX6QPoiFJgs
         54kec/yMv3o9G1W+/l3MCLnl+lDUEbhw5mKZ3RWOpoNCdBwEED5WjDD3yW7QHXK3WfgA
         xF/OGYwJpgBY8To2FZ0Dst3A8hJJqNfZXXaR+rJbb5+wetr1MRikcpBITbycBrKU5kUJ
         yyfjD/KeID3cHCH69DLr134wOooMwbuq4qz0XdMKpa4OtA8CJTfDyO4A59ml72jLhws3
         ZTzClvLKx7NqxA8Qga+yWlGS0E7z4aVNhukxt2/Jr/R7gXNuX9oel1q0ZPseXpAdL2pD
         sCrA==
X-Gm-Message-State: AFqh2kryiBhBDSQR+A6XO7KUXuGQp/yTxyrGQX7BAOGwpvExgGdRbsgR
        yAvLMe292ZuMh//ZlBWlY7eBII93Yf0=
X-Google-Smtp-Source: AMrXdXvfcqLP8MuQ+ErbxA1wOh59bUMHuBa9xYIOdkI7JAxFbRzuXTMU36cfUiHZU0R15tm00CWWqg==
X-Received: by 2002:adf:cc8f:0:b0:242:14bb:439d with SMTP id p15-20020adfcc8f000000b0024214bb439dmr36504977wrj.43.1673022719239;
        Fri, 06 Jan 2023 08:31:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6-20020adfe486000000b002423dc3b1a9sm1556128wrm.52.2023.01.06.08.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 08:31:58 -0800 (PST)
Message-Id: <c99470d46763cdfbde01629888c379c448b3579d.1673022717.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v5.git.1673022717.gitgitgadget@gmail.com>
References: <pull.1439.v4.git.1671204678.gitgitgadget@gmail.com>
        <pull.1439.v5.git.1673022717.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 Jan 2023 16:31:53 +0000
Subject: [PATCH v5 1/4] hashfile: allow skipping the hash function
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

