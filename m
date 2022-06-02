Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2969C433EF
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 13:53:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235605AbiFBNxB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 09:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbiFBNww (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 09:52:52 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF901AA173
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 06:52:51 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id z17so2630727wmf.1
        for <git@vger.kernel.org>; Thu, 02 Jun 2022 06:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lQUV46032B+RDVGoe9w/TiOva8DdwMfNUVNzl1mBHU0=;
        b=hIMiNnnn5c5hORC2SCaM/J1zuF1OfvYcYyKyERAEGoasdlbTk2Zb4HliWyAFK6Zqi/
         jwP6n4VLGid2Hxur8fmtvvkyk1JWXHhabkmTjYn+5tLudUaayWPYNF/ssPioAF/dZNa4
         RKqtfyaiXsoApxopcZgQeHrIkIIvIcUJYpG8+Rmtke9noxpg0pBKIhbJQUB+q6ByYH8o
         c3bzPrbE65w+W8TsCUcZe2EMHeYSx0T0N9ILxzxg2bX9Oj6SMM0Fy6kwQ6w9TtwAXhzm
         A/58x6jGIF3uyMixDaB6+2OH7za19F5c0deUVKNPkjnvLlt7DhVx7LMFfuqzmw9CH4JE
         7k3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lQUV46032B+RDVGoe9w/TiOva8DdwMfNUVNzl1mBHU0=;
        b=Vbxgr7yXmtgqqroGXpIuxrsvBY3spffos7bUi37I8OQMDAXGl5gkWitzVWyGlyqSBz
         OO7dzy8n7a+5d7DRRmjE3x5o1wWRxjTrE1lp4Pd7oC1xIrlaVwkOALZQRDm8bhi4iYUd
         hUvGxsSu0GfSz0fu+eHVSI3rTzlc4wdPVkbOCOjqHTzXwn8oE/o7va86wDyfDzWJfZ2v
         uW9uuoFb5A+0dQUwZpExXVgUzfJLz/LBHq0C9/aItzLJOKwilVP7bH5rFys6y9DsrxR7
         g5DHR+VfjHNTRLAFNtdlsbRcSS2Noq3uVJzL0H7Ipqi2J9I66IAtrJKWI2CZmwOWIFW4
         mQuQ==
X-Gm-Message-State: AOAM531BgWabGKqOC/st0A0OfAez8GGaZw0T5b3GZ3tLxcqw08/E6K53
        IGquBMHZrSJG+oU793rofLl/sRkmgnUM9PdQ
X-Google-Smtp-Source: ABdhPJzd26I2nQM3bs4Ph0N9l9++Wp0Q73UHDgI6iEV5x9cInw2iXAobhiB2AIf4h2/JrK/9ea8HHA==
X-Received: by 2002:a05:600c:3646:b0:397:326d:eac7 with SMTP id y6-20020a05600c364600b00397326deac7mr4211437wmq.43.1654177969450;
        Thu, 02 Jun 2022 06:52:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x8-20020adff0c8000000b00210a6bd8019sm4209695wro.8.2022.06.02.06.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:52:48 -0700 (PDT)
Message-Id: <976361e624a3dd58c8f291358d42f4e4c66eb266.1654177966.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
References: <pull.1246.git.1654177966.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 02 Jun 2022 13:52:45 +0000
Subject: [PATCH 1/2] bitmap-format.txt: fix some formatting issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

The asciidoc generated html for `Documentation/technical/bitmap-
format.txt` is broken. This is mainly because `-` is used for nested
lists (which is not allowed in asciidoc) instead of `*`.

Fix these and also reformat it (e.g. removing some blank lines) for
better readability of the html page.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/technical/bitmap-format.txt | 96 +++++++++++------------
 1 file changed, 45 insertions(+), 51 deletions(-)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 04b3ec21785..110d7ddf8ed 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -39,7 +39,7 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 
 == On-disk format
 
-	- A header appears at the beginning:
+	* A header appears at the beginning:
 
 		4-byte signature: {'B', 'I', 'T', 'M'}
 
@@ -48,35 +48,30 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 			of the bitmap index (the same one as JGit).
 
 		2-byte flags (network byte order)
-
 			The following flags are supported:
-
-			- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
-			This flag must always be present. It implies that the
-			bitmap index has been generated for a packfile or
-			multi-pack index (MIDX) with full closure (i.e. where
-			every single object in the packfile/MIDX can find its
-			parent links inside the same packfile/MIDX). This is a
-			requirement for the bitmap index format, also present in
-			JGit, that greatly reduces the complexity of the
-			implementation.
-
-			- BITMAP_OPT_HASH_CACHE (0x4)
-			If present, the end of the bitmap file contains
-			`N` 32-bit name-hash values, one per object in the
-			pack/MIDX. The format and meaning of the name-hash is
-			described below.
+				- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
+				This flag must always be present. It implies that the
+				bitmap index has been generated for a packfile or
+				multi-pack index (MIDX) with full closure (i.e. where
+				every single object in the packfile/MIDX can find its
+				parent links inside the same packfile/MIDX). This is a
+				requirement for the bitmap index format, also present in
+				JGit, that greatly reduces the complexity of the
+				implementation.
+				- BITMAP_OPT_HASH_CACHE (0x4)
+				If present, the end of the bitmap file contains
+				`N` 32-bit name-hash values, one per object in the
+				pack/MIDX. The format and meaning of the name-hash is
+				described below.
 
 		4-byte entry count (network byte order)
-
 			The total count of entries (bitmapped commits) in this bitmap index.
 
 		20-byte checksum
-
 			The SHA1 checksum of the pack/MIDX this bitmap index
 			belongs to.
 
-	- 4 EWAH bitmaps that act as type indexes
+	* 4 EWAH bitmaps that act as type indexes
 
 		Type indexes are serialized after the hash cache in the shape
 		of four EWAH bitmaps stored consecutively (see Appendix A for
@@ -84,7 +79,6 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 
 		There is a bitmap for each Git object type, stored in the following
 		order:
-
 			- Commits
 			- Trees
 			- Blobs
@@ -97,39 +91,39 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 		in a full set (all bits set), and the AND of all 4 bitmaps will
 		result in an empty bitmap (no bits set).
 
-	- N entries with compressed bitmaps, one for each indexed commit
+	* N entries with compressed bitmaps, one for each indexed commit
 
 		Where `N` is the total amount of entries in this bitmap index.
 		Each entry contains the following:
 
-		- 4-byte object position (network byte order)
-			The position **in the index for the packfile or
-			multi-pack index** where the bitmap for this commit is
-			found.
-
-		- 1-byte XOR-offset
-			The xor offset used to compress this bitmap. For an entry
-			in position `x`, a XOR offset of `y` means that the actual
-			bitmap representing this commit is composed by XORing the
-			bitmap for this entry with the bitmap in entry `x-y` (i.e.
-			the bitmap `y` entries before this one).
-
-			Note that this compression can be recursive. In order to
-			XOR this entry with a previous one, the previous entry needs
-			to be decompressed first, and so on.
-
-			The hard-limit for this offset is 160 (an entry can only be
-			xor'ed against one of the 160 entries preceding it). This
-			number is always positive, and hence entries are always xor'ed
-			with **previous** bitmaps, not bitmaps that will come afterwards
-			in the index.
-
-		- 1-byte flags for this bitmap
-			At the moment the only available flag is `0x1`, which hints
-			that this bitmap can be re-used when rebuilding bitmap indexes
-			for the repository.
-
-		- The compressed bitmap itself, see Appendix A.
+			** 4-byte object position (network byte order)
+				The position **in the index for the packfile or
+				multi-pack index** where the bitmap for this commit is
+				found.
+
+			** 1-byte XOR-offset
+				The xor offset used to compress this bitmap. For an entry
+				in position `x`, a XOR offset of `y` means that the actual
+				bitmap representing this commit is composed by XORing the
+				bitmap for this entry with the bitmap in entry `x-y` (i.e.
+				the bitmap `y` entries before this one).
+
+				Note that this compression can be recursive. In order to
+				XOR this entry with a previous one, the previous entry needs
+				to be decompressed first, and so on.
+
+				The hard-limit for this offset is 160 (an entry can only be
+				xor'ed against one of the 160 entries preceding it). This
+				number is always positive, and hence entries are always xor'ed
+				with **previous** bitmaps, not bitmaps that will come afterwards
+				in the index.
+
+			** 1-byte flags for this bitmap
+				At the moment the only available flag is `0x1`, which hints
+				that this bitmap can be re-used when rebuilding bitmap indexes
+				for the repository.
+
+			** The compressed bitmap itself, see Appendix A.
 
 == Appendix A: Serialization format for an EWAH bitmap
 
-- 
gitgitgadget

