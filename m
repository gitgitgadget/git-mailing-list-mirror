Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 511E0C43334
	for <git@archiver.kernel.org>; Mon, 20 Jun 2022 12:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242175AbiFTMdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Jun 2022 08:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242722AbiFTMdW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Jun 2022 08:33:22 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D79D5FAA
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:19 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i81-20020a1c3b54000000b0039c76434147so7707689wma.1
        for <git@vger.kernel.org>; Mon, 20 Jun 2022 05:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hk+odqG8J7B8EapEcXY6hcN+RYOMJxUlv6hQ88ppQoE=;
        b=aFC7hgbrTKLXHXLmlVSI7hruu4jNH6mN/tfJxdQ/WNNO3uohgoVo200xFvNAOSEQei
         8yEr7pMQbK6wL+2XiCUgyXyubzzO1navM+571uodmf3RqYKQJyCoXZ59KJh+EodtJVq+
         lIgTRVTV9xuigkMQzxe1xZwQKso/1KfqCNJ1ykTTbPsaYBGsdRj/mWw78u5dn1Uq0KyW
         uxlJoTSG6f35zlLIzxyTFRkcDBnEFmvwOcFXpIGnrY0ImTP7KL7QGupjiS6e6SQ81UAg
         l2k9U+EQ5WuW67LCszcvLk6xzZeSJpxarHuMxlacNCfwmpgSK7c3infLpUsH89SgEuc3
         GVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hk+odqG8J7B8EapEcXY6hcN+RYOMJxUlv6hQ88ppQoE=;
        b=sgjvXk+6vekLk9dT29ObhpO7QsMqBEQuGPwj4omsYmE24g4qxJ7yd3Uygt804tIo0G
         QvKeIui04wbYfalR1Nesae6tcUv4xxSlSSJkgIgfUleL4wGElxjd9XHySLg7/QDmYgti
         677O0djuYILYiir+hfNrqjxRWeqZdSDXK6PcxwPF/lDBALcIUNex6XS9ZCapm4s0S/vK
         ghM8vrfd7xLutLjp9oXjoaTN+9la1NQckscwiRFVRil0TAp+sBU+3/nq8+CKb8IQNed6
         kHyahWR4xKLJHhgIxrCy3tmUxmqrgyNh+dISTHCrqVlYW404xpencuY3hsIxCByWckUb
         Xt5w==
X-Gm-Message-State: AJIora9ytemCHiiRmNxQPjmO9ZFzXJBXnGEL7HRGtu7+uYCbtKL6fat3
        vWOq25xOAWkFfSsGNImE99mHMYkT68q9IA==
X-Google-Smtp-Source: AGRyM1tH6k9O84p7MF6NIYAjAJ1H3mYJ6Gsd0kgD6fhMWGPmW9qQUozSpONPDMsp1oJJt+sHsdHvLQ==
X-Received: by 2002:a05:600c:3655:b0:39c:6745:ec53 with SMTP id y21-20020a05600c365500b0039c6745ec53mr23789232wmq.186.1655728397780;
        Mon, 20 Jun 2022 05:33:17 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d4312000000b002167efdd549sm13169958wrq.38.2022.06.20.05.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 05:33:16 -0700 (PDT)
Message-Id: <2e22ca5069af617fe23072d78efb08b26d6130be.1655728395.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
From:   "Abhradeep Chakraborty via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Jun 2022 12:33:09 +0000
Subject: [PATCH 1/6] Documentation/technical: describe bitmap lookup table
 extension
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>

When reading bitmap file, git loads each and every bitmap one by one
even if all the bitmaps are not required. A "bitmap lookup table"
extension to the bitmap format can reduce the overhead of loading
bitmaps which stores a list of bitmapped commit oids, along with their
offset and xor offset. This way git can load only the neccesary bitmaps
without loading the previous bitmaps.

Add some information for the new "bitmap lookup table" extension in the
bitmap-format documentation.

Co-Authored-by: Taylor Blau <ttaylorr@github.com>
Mentored-by: Taylor Blau <ttaylorr@github.com>
Co-Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
---
 Documentation/technical/bitmap-format.txt | 31 +++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/technical/bitmap-format.txt
index 04b3ec21785..34e98787b78 100644
--- a/Documentation/technical/bitmap-format.txt
+++ b/Documentation/technical/bitmap-format.txt
@@ -67,6 +67,14 @@ MIDXs, both the bit-cache and rev-cache extensions are required.
 			pack/MIDX. The format and meaning of the name-hash is
 			described below.
 
+			** {empty}
+			BITMAP_OPT_LOOKUP_TABLE (0xf) : :::
+			If present, the end of the bitmap file contains a table
+			containing a list of `N` object ids, a list of pairs of
+			offset and xor offset of respective objects, and 4-byte
+			integer denoting the flags (currently none). The format
+			and meaning of the table is described below.
+
 		4-byte entry count (network byte order)
 
 			The total count of entries (bitmapped commits) in this bitmap index.
@@ -205,3 +213,26 @@ Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
 If implementations want to choose a different hashing scheme, they are
 free to do so, but MUST allocate a new header flag (because comparing
 hashes made under two different schemes would be pointless).
+
+Commit lookup table
+-------------------
+
+If the BITMAP_OPT_LOOKUP_TABLE flag is set, the end of the `.bitmap`
+contains a lookup table specifying the positions of commits which have a
+bitmap.
+
+For a `.bitmap` containing `nr_entries` reachability bitmaps, the format
+is as follows:
+
+	- `nr_entries` object names.
+
+	- `nr_entries` pairs of 4-byte integers, each in network order.
+	  The first holds the offset from which that commit's bitmap can
+	  be read. The second number holds the position of the commit
+	  whose bitmap the current bitmap is xor'd with in lexicographic
+	  order, or 0xffffffff if the current commit is not xor'd with
+	  anything.
+
+	- One 4-byte network byte order integer specifying
+	  table-specific flags. None exist currently, so this is always
+	  "0".
-- 
gitgitgadget

