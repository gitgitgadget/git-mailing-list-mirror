Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5138CC4167B
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 15:07:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiLOPHN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 10:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiLOPHJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 10:07:09 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CCD3054F
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:07:04 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id o5-20020a05600c510500b003d21f02fbaaso1911326wms.4
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 07:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ed5q4EI9Rja0zU3IUSIZ9CyNU+B6k57eyHEpfMq9F2s=;
        b=jtwaA2B+7OxQFXwec4HC7bht6LMenRIAZX5+QmSIXEty8kDCXKp+rWYj692LmxaFuH
         OB+DmN1SJkrjd5nbBawWRqsJn0JAk/+/M7ljnHIkUkGXXfByAyq24vu7dDdTDOHknEFl
         dGkmIKo7vfC7adFg6HufKHmOsNyDH26P8Y5k9+bsljy02SaQQZ6jv6ADK9Ow2+t8AYcn
         cigymf9TUdZ/BX2/bSAxH1z9ZglVA3REcbYkbmM566JteT+jEksA49xjTNVelUVWXPDs
         5EMRFbwykCOZkYLABX8ThbSu6d1jjmBJ2e12YkjrFiwMn1xW0i0hM0u5w09qpw1yc76I
         FCxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ed5q4EI9Rja0zU3IUSIZ9CyNU+B6k57eyHEpfMq9F2s=;
        b=xHmVXC8XUU7Q9GjDYegNCfgfYkoJfIC/pzyyHb3v3zdQAETlCMfTprwSOa89sf7sqi
         Ij6VMCOTzZPcfPzTyfbFDL0d8RRr/GV2n1TuEJk8V3KDuI0l/AJGu4uhOLupCkgz1XF5
         FX2xJqDa4BBNzpNkd2yydFrIczFZDFq1amNC607K2qNx4E0F2f7jI41wrvIerLQHubmp
         ukbHf5B3PFKYLR3ouswP3EBvtV8IV0Pg6j65eqlbhYL9yOHSkHaif1xgYNVOd6izCCu6
         jamzEgrzn2UUJsGo/YOC0xmkSwmQSB82VFrexHH59x95ep+zoFQvxqpdJqEqO9zIYn6l
         B36g==
X-Gm-Message-State: ANoB5pkjNJmMQrfvW24pFszOfVOIBGCyqbJ00n7QNRpIGj1qjYuxlnDd
        voI50nEkhUXrJ0eBEiZWGaujlzKO6Q8=
X-Google-Smtp-Source: AA0mqf5/aBZYo+npBz+iy+rBt28YpdIyP3JHx/wePTQF0WV8bkPd0YEz8X1a7iCwY2UEZz+Pgerstg==
X-Received: by 2002:a05:600c:1ca1:b0:3d2:bca5:10a2 with SMTP id k33-20020a05600c1ca100b003d2bca510a2mr2451057wms.22.1671116822803;
        Thu, 15 Dec 2022 07:07:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay40-20020a05600c1e2800b003c6c5a5a651sm6664471wmb.28.2022.12.15.07.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 07:07:02 -0800 (PST)
Message-Id: <b582d681581a356534ef018c3a12004b2d9779a7.1671116820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
References: <pull.1439.v2.git.1670862677.gitgitgadget@gmail.com>
        <pull.1439.v3.git.1671116820.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Dec 2022 15:06:57 +0000
Subject: [PATCH v3 1/4] hashfile: allow skipping the hash function
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

