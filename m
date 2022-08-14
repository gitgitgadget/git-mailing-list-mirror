Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2FCC25B06
	for <git@archiver.kernel.org>; Sun, 14 Aug 2022 17:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241858AbiHNRAN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Aug 2022 13:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241540AbiHNQ7p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Aug 2022 12:59:45 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA4E62CA
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 09:55:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id az6-20020a05600c600600b003a530cebbe3so2908830wmb.0
        for <git@vger.kernel.org>; Sun, 14 Aug 2022 09:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=OZX76/OBWtsYaD2plHm2WdewtzV+QcpnjZ+i1Lu1Vaw=;
        b=Rn6FmiX2lPbftJFdD3AfyTnk+UaV50uiCeUhtgc00sAH9jSU/rwCFnHpLAqNBw6+MK
         bc4YmlptDw7Ptrt/TJuMY4Vu+8ZS8o2DrpH/+1Bq3Z5y4wy3vVSp7DkrOxDltLHbzA78
         6M9q444+ODtLpX/m935cJ6uBJUSssPcMZotyWuem6/wiL2A9jsJVi3m08y5b2h8b+7YJ
         0VEVhncpkN7Qn4SYR/7JrKC2czE6fbgSlzD+f6oeUp0aksudUUwJ/P+BRMLedOkqhJkL
         pJftK/zImn/B7kjNgOiR7DZB1vznx3Wh7i1Eksxm1cumT8q1ApHngOsqFj06bigqBsVE
         2IHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=OZX76/OBWtsYaD2plHm2WdewtzV+QcpnjZ+i1Lu1Vaw=;
        b=hTxZZSYE7oHg+Yuzg6A7WNys+/6V30DP8uI1DvbTj28HrOTYhaYfHElOJvq/4cNxL8
         8eSgVO/B9QGWYAZJPp3rIiZneIlRBWYTDInYFJXGu43ZcT/dr1pVpxNeD98fZJqTG9Aw
         0aGR1Ig+fMJgZmZHZeqCFRgaYm9EYKvxjV7MXCbfC55fxRhijyOEUUJRC/t7Og4laHu3
         0EWwG8cp/GSKaCLT5HYM0IdgtxzYN2zsdvwFMd8mLr1I5mALdfXuBdhO6XhgMYU6HPXp
         Aw/Vld6Mzv5Kwd1txdoSmAQp742zGnObg0eKaSm2jNq2IDiDIPznQaEe0a4xLJeEQYbe
         24Sg==
X-Gm-Message-State: ACgBeo2cgTSb0rF6kzpidqyIQyO11vzWKR02Ziyr7jA4pKIfNL6b1fB0
        ERIX3ntTHp1pEmJmpVSe3PDThNtwhmA=
X-Google-Smtp-Source: AA6agR4ifwpW0Do1i0YbwjywGw16u0aoQkSSlrPKAvRrmOMZpXgG4REEcemY1PEmD6jKx2IM08GV2g==
X-Received: by 2002:a1c:7512:0:b0:3a4:f09d:1cf7 with SMTP id o18-20020a1c7512000000b003a4f09d1cf7mr14093035wmc.67.1660496115853;
        Sun, 14 Aug 2022 09:55:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16-20020adfdc10000000b0021e5f32ade7sm4920096wri.68.2022.08.14.09.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 09:55:14 -0700 (PDT)
Message-Id: <67b71be8c85a44b21c3181a9e9532d5dc3f81668.1660496112.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
References: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
        <pull.1266.v6.git.1660496112.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Aug 2022 16:55:06 +0000
Subject: [PATCH v6 1/6] Documentation/technical: describe bitmap lookup table
 extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

When reading bitmap file, Git loads each and every bitmap one by one
even if all the bitmaps are not required. A "bitmap lookup table"
extension to the bitmap format can reduce the overhead of loading
bitmaps which stores a list of bitmapped commit id pos (in the midx
or pack, along with their offset and xor offset. This way Git can
load only the necessary bitmaps without loading the previous bitmaps.

Older versions of Git ignore the lookup table extension and don't
throw any kind of warning or error while parsing the bitmap file.

Add some information for the new "bitmap lookup table" extension in the
bitmap-format documentation.

Mentored-by: Taylor Blau <me@ttaylorr.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Co-Authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/technical/bitmap-format.txt | 39 +++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index a85f58f5153..c2e652b71a7 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -72,6 +72,17 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 	    pack/MIDX. The format and meaning of the name-hash is
 	    described below.
 
+		** {empty}
+		BITMAP_OPT_LOOKUP_TABLE (0x10): :::
+		If present, the end of the bitmap file contains a table
+		containing a list of `N` <commit_pos, offset, xor_row>
+		triplets. The format and meaning of the table is described
+		below.
++
+NOTE: Unlike the xor_offset used to compress an individual bitmap,
+`xor_row` stores an *absolute* index into the lookup table, not a location
+relative to the current entry.
+
 	4-byte entry count (network byte order): ::
 	    The total count of entries (bitmapped commits) in this bitmap index.
 
@@ -216,3 +227,31 @@ Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
 If implementations want to choose a different hashing scheme, they are
 free to do so, but MUST allocate a new header flag (because comparing
 hashes made under two different schemes would be pointless).
+
+Commit lookup table
+-------------------
+
+If the BITMAP_OPT_LOOKUP_TABLE flag is set, the last `N * (4 + 8 + 4)`
+bytes (preceding the name-hash cache and trailing hash) of the `.bitmap`
+file contains a lookup table specifying the information needed to get
+the desired bitmap from the entries without parsing previous unnecessary
+bitmaps.
+
+For a `.bitmap` containing `nr_entries` reachability bitmaps, the table
+contains a list of `nr_entries` <commit_pos, offset, xor_row> triplets
+(sorted in the ascending order of `commit_pos`). The content of i'th
+triplet is -
+
+	* {empty}
+	commit_pos (4 byte integer, network byte order): ::
+	It stores the object position of a commit (in the midx or pack
+	index).
+
+	* {empty}
+	offset (8 byte integer, network byte order): ::
+	The offset from which that commit's bitmap can be read.
+
+	* {empty}
+	xor_row (4 byte integer, network byte order): ::
+	The position of the triplet whose bitmap is used to compress
+	this one, or `0xffffffff` if no such bitmap exists.
-- 
gitgitgadget

