Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F267C43334
	for <git@archiver.kernel.org>; Fri, 10 Jun 2022 10:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349138AbiFJK5d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jun 2022 06:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349082AbiFJK5F (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jun 2022 06:57:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025C72A11CA
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 03:54:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so882527wms.3
        for <git@vger.kernel.org>; Fri, 10 Jun 2022 03:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vkyqhm02plQIka8kb3KvivKLbR/KycQGuGJMTJlOrKM=;
        b=Q5erlb5HD0uBh3pp6FraEh/5+qqIf2caQYsWwAPFRPaCt2uiVVXTqQM4KdZFLMIEDL
         sy77pP1jhItIuaKpKNcrLpTgSWI/Z8El3T4MhlelygB6mWfVSA2ZQPMXSwwHCxlDE6mU
         kf8nalUAbcXajRQ/7J/FilbbU9p5YIiWZiWIrUXjw0/QnfnGvYg7ikuFqk8NaUcSKKFs
         CYMDSuYIPbPvFC74dXUPgSBLdWx+dzqgF9lZDYEtzxAlUh3TFT2XOnWF5QXvJVRskDVo
         ++qnu000yu+yyRfrDo+uDx1vtUBfzz9Hz4AO2MJhvDom3XQffTZEBaH9NXSwbcBV8NfK
         AxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vkyqhm02plQIka8kb3KvivKLbR/KycQGuGJMTJlOrKM=;
        b=ehEc2j2qyPKQRg4F4Q8r1iswySd2KT0c1XJQQaV8nErnc2bJdNrih2z9E/oichi31p
         Cmhd8iaoG3ZBoHK/O4YXI3tuazxg/Q4/Ww6d2osSEnv00eML5C7GChzZMWnTQvE0YjbA
         Th1kARXWQfJK+bIOJV6+AvsTuzcUXDkrpPamOTgRPjiqzNxFEpMzUlcNCO6EKJMBUtKG
         W+wX2iph5nwNg/P8YeZCQeKg90xkR4UXYrPGz+vefr6jgx5roxUwqpcJn1pzfhic+dcN
         98kFxJpWw4RVPbce0nUwQQRifoRVj1/wqWxi3NWMxoXTWUw05hE5GWri9MBVTCQlFMQv
         Ittw==
X-Gm-Message-State: AOAM533Nc3f5np1XjGeDutMBxLkV8GshPxYY8nf4kAPBjCdjByYKbG6A
        ecj4lDRGjk6BWjqobZtRtezHpipjYVm+Zg==
X-Google-Smtp-Source: ABdhPJwrn7S0XAJE5JYYrYeYSuMr5RAAE1J/O2QYfKrtH3Xbq2KHcnemPnkEcDH9V7YpbO1L/3HlIQ==
X-Received: by 2002:a05:600c:4f96:b0:39c:7bd0:d4c8 with SMTP id n22-20020a05600c4f9600b0039c7bd0d4c8mr3506990wmq.16.1654858485779;
        Fri, 10 Jun 2022 03:54:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d14-20020a5d6dce000000b0020c5253d927sm27309015wrz.115.2022.06.10.03.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 03:54:44 -0700 (PDT)
Message-Id: <c74b9a52c2a7b5f3ebbfaca08c8de42aac7f7eac.1654858481.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
References: <pull.1246.v2.git.1654623814.gitgitgadget@gmail.com>
        <pull.1246.v3.git.1654858481.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jun 2022 10:54:40 +0000
Subject: [PATCH v3 2/3] bitmap-format.txt: fix some formatting issues
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

The asciidoc generated html for `Documentation/technical/bitmap-
format.txt` is broken. This is mainly because `-` is used for nested
lists (which is not allowed in asciidoc) instead of `*`.

Fix these and also reformat it for better readability of the html page.

Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/technical/bitmap-format.txt | 109 ++++++++++++----------
 1 file changed, 58 insertions(+), 51 deletions(-)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 04b3ec21785..cd621379f42 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -39,19 +39,22 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 
 == On-disk format
 
-	- A header appears at the beginning:
+	* A header appears at the beginning:
 
-		4-byte signature: {'B', 'I', 'T', 'M'}
+		4-byte signature: :: {'B', 'I', 'T', 'M'}
+
+		2-byte version number (network byte order): ::
 
-		2-byte version number (network byte order)
 			The current implementation only supports version 1
 			of the bitmap index (the same one as JGit).
 
-		2-byte flags (network byte order)
+		2-byte flags (network byte order): ::
 
 			The following flags are supported:
 
-			- BITMAP_OPT_FULL_DAG (0x1) REQUIRED
+			** {empty}
+			BITMAP_OPT_FULL_DAG (0x1) REQUIRED: :::
+
 			This flag must always be present. It implies that the
 			bitmap index has been generated for a packfile or
 			multi-pack index (MIDX) with full closure (i.e. where
@@ -61,75 +64,79 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 			JGit, that greatly reduces the complexity of the
 			implementation.
 
-			- BITMAP_OPT_HASH_CACHE (0x4)
+			** {empty}
+			BITMAP_OPT_HASH_CACHE (0x4): :::
+
 			If present, the end of the bitmap file contains
 			`N` 32-bit name-hash values, one per object in the
 			pack/MIDX. The format and meaning of the name-hash is
 			described below.
 
-		4-byte entry count (network byte order)
-
+		4-byte entry count (network byte order): ::
 			The total count of entries (bitmapped commits) in this bitmap index.
 
-		20-byte checksum
-
+		20-byte checksum: ::
 			The SHA1 checksum of the pack/MIDX this bitmap index
 			belongs to.
 
-	- 4 EWAH bitmaps that act as type indexes
-
-		Type indexes are serialized after the hash cache in the shape
-		of four EWAH bitmaps stored consecutively (see Appendix A for
-		the serialization format of an EWAH bitmap).
-
-		There is a bitmap for each Git object type, stored in the following
-		order:
-
-			- Commits
-			- Trees
-			- Blobs
-			- Tags
-
-		In each bitmap, the `n`th bit is set to true if the `n`th object
-		in the packfile or multi-pack index is of that type.
-
-		The obvious consequence is that the OR of all 4 bitmaps will result
-		in a full set (all bits set), and the AND of all 4 bitmaps will
-		result in an empty bitmap (no bits set).
-
-	- N entries with compressed bitmaps, one for each indexed commit
-
-		Where `N` is the total amount of entries in this bitmap index.
-		Each entry contains the following:
-
-		- 4-byte object position (network byte order)
+	* 4 EWAH bitmaps that act as type indexes
++
+Type indexes are serialized after the hash cache in the shape
+of four EWAH bitmaps stored consecutively (see Appendix A for
+the serialization format of an EWAH bitmap).
++
+There is a bitmap for each Git object type, stored in the following
+order:
++
+	- Commits
+	- Trees
+	- Blobs
+	- Tags
+
++
+In each bitmap, the `n`th bit is set to true if the `n`th object
+in the packfile or multi-pack index is of that type.
+
+    The obvious consequence is that the OR of all 4 bitmaps will result
+    in a full set (all bits set), and the AND of all 4 bitmaps will
+    result in an empty bitmap (no bits set).
+
+	* N entries with compressed bitmaps, one for each indexed commit
++
+Where `N` is the total amount of entries in this bitmap index.
+Each entry contains the following:
+
+		** {empty}
+		4-byte object position (network byte order): ::
 			The position **in the index for the packfile or
 			multi-pack index** where the bitmap for this commit is
 			found.
 
-		- 1-byte XOR-offset
+		** {empty}
+		1-byte XOR-offset: ::
 			The xor offset used to compress this bitmap. For an entry
 			in position `x`, a XOR offset of `y` means that the actual
 			bitmap representing this commit is composed by XORing the
 			bitmap for this entry with the bitmap in entry `x-y` (i.e.
 			the bitmap `y` entries before this one).
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
++
+NOTE: This compression can be recursive. In order to
+XOR this entry with a previous one, the previous entry needs
+to be decompressed first, and so on.
++
+The hard-limit for this offset is 160 (an entry can only be
+xor'ed against one of the 160 entries preceding it). This
+number is always positive, and hence entries are always xor'ed
+with **previous** bitmaps, not bitmaps that will come afterwards
+in the index.
+
+		** {empty}
+		1-byte flags for this bitmap: ::
 			At the moment the only available flag is `0x1`, which hints
 			that this bitmap can be re-used when rebuilding bitmap indexes
 			for the repository.
 
-		- The compressed bitmap itself, see Appendix A.
+		** The compressed bitmap itself, see Appendix A.
 
 == Appendix A: Serialization format for an EWAH bitmap
 
-- 
gitgitgadget

