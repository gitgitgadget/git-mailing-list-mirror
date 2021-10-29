Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D729C433FE
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17A3661167
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231734AbhJ2OCF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:02:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhJ2OBz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 10:01:55 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F4FC061767
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:26 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 71so6629155wma.4
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oUOtW+VMfF77w6KugTIk7kk1SNVq3GaMJS9+jVTFH/w=;
        b=aoY85z2ScqUWiujne/dtBtScAk9hA0ronrqLgP89suTWs8FZlqKqLo4kHM7rMN1J7z
         VSGxCadimkZuzRAmV4eI7a1iko8EWDrV1iWi3GIvLVQ2Hp3LPwE6Y0DIAFIn/Px5Z1GS
         rDgrAX4CMRBSXM695w3fsLvBIqcHEoqGTQrOO+Yo6FeTawLdwQxFVrfphyNjoA7KhEy9
         4RE8ZEGhI6le5xDa5rJceyBUMG7yFD4BHWEwVDyY4sSwabaOQhmdb4Py6z/zEIxbO25Q
         BKhNmdN1+LS5qHb3tB2UDvdPN6tKkudYQL3aXK+sFCu2KZwV+kvFGq8THtdLu49LTsdz
         zL4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oUOtW+VMfF77w6KugTIk7kk1SNVq3GaMJS9+jVTFH/w=;
        b=RWxegGkUZqNDWDtFNK+EJ8Dkm5ihADHkoGF5j5zWjb+R6DYDkWLQLEh1QEV3RijtuA
         /6Nx9zLOmhGI9mfkfHz+DUtcHBvOt/pLFc4YzKnAn9pNZfJfjXrdB9MGSf7y4AGPK1M1
         9FfHNcb1B+27011DZsFaa7E0lw2qknQz5pRI7rkx7GhgxYGxD/hf73SkEEdAh5CwW8jp
         /ypOwDVJNyHLsOx09HhAA5afRJXJ+LUS1kjlkHz8ibb3+QxrexW3dmx3lm3A1MgVp5tW
         BZTWoLfvcf/gPO8IsExMsMM6m4r5LpoUP+lOpURrJspEXfWEIv1eLI2i7YxNNZOsmXGK
         Iw4w==
X-Gm-Message-State: AOAM531vkV9RmW7jUVDwwK+j+tMzbb1pdF+Mhh3YTj7GESUcQC9LJe85
        T/UqvA8c15zSIoFvtPaGHmYSTlEW10g=
X-Google-Smtp-Source: ABdhPJz3Xmbv/65NnMAzFutCOtxHjen+jKi1So2QaXKxqk3H9dfmcNFmO+XhuQAga3xvjSJuhUaPdA==
X-Received: by 2002:a1c:20cc:: with SMTP id g195mr5193487wmg.42.1635515965251;
        Fri, 29 Oct 2021 06:59:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h17sm4237634wrp.34.2021.10.29.06.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:59:24 -0700 (PDT)
Message-Id: <f59c523bcc48b187680be9149e9311f15bfe06dc.1635515959.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:59:18 +0000
Subject: [PATCH v3 7/8] odb: guard against data loss checking out a huge file
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

This introduces an additional guard for platforms where `unsigned long`
and `size_t` are not of the same size. If the size of an object in the
database would overflow `unsigned long`, instead we now exit with an
error.

A complete fix will have to update _many_ other functions throughout the
codebase to use `size_t` instead of `unsigned long`. It will have to be
implemented at some stage.

This commit puts in a stop-gap for the time being.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matt Cooper <vtbassmatt@gmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 delta.h       | 6 +++---
 object-file.c | 6 +++---
 packfile.c    | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/delta.h b/delta.h
index 2df5fe13d95..8a56ec07992 100644
--- a/delta.h
+++ b/delta.h
@@ -90,15 +90,15 @@ static inline unsigned long get_delta_hdr_size(const unsigned char **datap,
 					       const unsigned char *top)
 {
 	const unsigned char *data = *datap;
-	unsigned long cmd, size = 0;
+	size_t cmd, size = 0;
 	int i = 0;
 	do {
 		cmd = *data++;
-		size |= (cmd & 0x7f) << i;
+		size |= st_left_shift(cmd & 0x7f, i);
 		i += 7;
 	} while (cmd & 0x80 && data < top);
 	*datap = data;
-	return size;
+	return cast_size_t_to_ulong(size);
 }
 
 #endif
diff --git a/object-file.c b/object-file.c
index f233b440b22..70e456fc2a3 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1344,7 +1344,7 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
 				       unsigned int flags)
 {
 	const char *type_buf = hdr;
-	unsigned long size;
+	size_t size;
 	int type, type_len = 0;
 
 	/*
@@ -1388,12 +1388,12 @@ static int parse_loose_header_extended(const char *hdr, struct object_info *oi,
 			if (c > 9)
 				break;
 			hdr++;
-			size = size * 10 + c;
+			size = st_add(st_mult(size, 10), c);
 		}
 	}
 
 	if (oi->sizep)
-		*oi->sizep = size;
+		*oi->sizep = cast_size_t_to_ulong(size);
 
 	/*
 	 * The length must be followed by a zero byte
diff --git a/packfile.c b/packfile.c
index 755aa7aec5e..3ccea004396 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1059,7 +1059,7 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 		unsigned long len, enum object_type *type, unsigned long *sizep)
 {
 	unsigned shift;
-	unsigned long size, c;
+	size_t size, c;
 	unsigned long used = 0;
 
 	c = buf[used++];
@@ -1073,10 +1073,10 @@ unsigned long unpack_object_header_buffer(const unsigned char *buf,
 			break;
 		}
 		c = buf[used++];
-		size += (c & 0x7f) << shift;
+		size = st_add(size, st_left_shift(c & 0x7f, shift));
 		shift += 7;
 	}
-	*sizep = size;
+	*sizep = cast_size_t_to_ulong(size);
 	return used;
 }
 
-- 
gitgitgadget

