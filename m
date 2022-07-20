Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34ED0C433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 18:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbiGTSil (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 14:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGTSih (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 14:38:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88057391B
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:38:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso1317800wmq.3
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 11:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+/xO9ll8JpeGK0I4H7EYcynDHbRKCdQAMzzulpwBe7Q=;
        b=mnKOAFm6xETuUv6A+d0BRzPHJY+QA7/7YcrqhZOrsIxloMdsfFHfNkf/6E1lV33WTe
         e2Sp8mE53YAef8XOcq0cU2SWQP8DNMYvYxBFjyFdTIud2VO7VslD7Gn+WQ26Xwv6mRCj
         G9AdGAbfcb2o1h08PZvoCSNYBm9TGoRRA4FA8AgEgocnubQyZuQuU4nNrGjklKSbXEsL
         RLppWFhgzuNIMJ2j7H5AV1dCcaYXTSaIX5RPYzg81eSRVxkpypsqkZVi1y319zmI02bj
         +Xn1e/EzmEXyR3AUZ+K6a10OKlRV6uLveSG5R9832mNq1g8si5Lpi1FUWI5rB9YNYo6z
         2deA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+/xO9ll8JpeGK0I4H7EYcynDHbRKCdQAMzzulpwBe7Q=;
        b=6NX7dAk5PWlMt/gVEdhSw3MtQ0NdgO0ajI7fiS6rNVLGBHWq2BoOjCVNLA2cQmbn7a
         XeKuFohTyoaNXZ5xFW7MpWdKlKY2Wt7xz3XCsn/NPA41/C39OPHM4FqcviZSGRROPuJJ
         H+kUvYI4UHmNWruapPsgrEkuGOT+GcgHv+nRISuw7t+kaiP/Tjy5U0D39LAwbAkxY/u9
         svvP7kS0MAQcK+/w8bX5/Km30QIykYb2hJx4zJJbhUGitRrq1YlERaum9nLBH8b2xRXH
         MFbiWEzpfk4QRoC+T5H/NlQedcQwbazB8uHkn/pS7FRBZCXthwDeLKQTQo5Xl2JaQHu/
         exEQ==
X-Gm-Message-State: AJIora+aDCdyG54cL8kXY9fVGMU8mHoHTNql29V5694L/ANILJr9Uc/J
        dDmIa880ETeOVRgt4xTNhn3BGKF9ZuE=
X-Google-Smtp-Source: AGRyM1u7sDm9D+sTy8XcWGETL2jnr2wZFBucgW4vOtWm9t9f/6fpqrGdiciwBkgSz5tvCzRZ7044tA==
X-Received: by 2002:a05:600c:348f:b0:3a2:e369:9cc2 with SMTP id a15-20020a05600c348f00b003a2e3699cc2mr5173315wmq.166.1658342307493;
        Wed, 20 Jul 2022 11:38:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2-20020a7bc382000000b003a03185231bsm3356035wmj.31.2022.07.20.11.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 11:38:26 -0700 (PDT)
Message-Id: <33aca8f3dc8b12773f187fcb8e40060c2be4aabc.1658342304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
        <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Jul 2022 18:38:19 +0000
Subject: [PATCH v5 1/6] Documentation/technical: describe bitmap lookup table
 extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
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
index 04b3ec21785..c30dc177643 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -67,6 +67,17 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 			pack/MIDX. The format and meaning of the name-hash is
 			described below.
 
+			** {empty}
+			BITMAP_OPT_LOOKUP_TABLE (0x10): :::
+			If present, the end of the bitmap file contains a table
+			containing a list of `N` <commit_pos, offset, xor_row>
+			triplets. The format and meaning of the table is described
+			below.
++
+NOTE: Unlike the xor_offset used to compress an individual bitmap,
+`xor_row` stores an *absolute* index into the lookup table, not a location
+relative to the current entry.
+
 		4-byte entry count (network byte order)
 
 			The total count of entries (bitmapped commits) in this bitmap index.
@@ -205,3 +216,31 @@ Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
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

