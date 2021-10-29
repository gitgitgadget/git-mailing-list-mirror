Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03EAC433EF
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAAE36115C
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 13:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbhJ2OCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 10:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbhJ2OBy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 10:01:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091A4C061766
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:26 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id p14so16254512wrd.10
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=V3UJ7kXSNpQVGVtTGUng6sI3LTiP2EGs8G33fVBLwWI=;
        b=Q6OnzByLnjR8//4r2n4F/W9dTJYe99MkHA86u0P5fPMvyRcA9EVcZkKNCrAg/lPp+F
         Q1aDvc7mL9JgnotAK0CE9DBW58kbt1W6blAq0p4xaXhpG18rDYeD2i2say+P7HFOmWHh
         umWgcXUCOOGHaP+MrzkDew2hl+elglWXRhH6/PHUIOQVvaY3zLQMg4jV+1Ji6jJRUVIa
         m4btyffbb13QSdEAHt8LMvalbOpW1cuyGz2ukmg4fr7HAV4KEIE2hsyJFvKpWWZ9kHGI
         fbtw+aKf+RXC136O/BeQQKJSbFKkpedbel4GcL/7s1TtNh0wJXfKOzuUxY9UjkCM3TEc
         QzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=V3UJ7kXSNpQVGVtTGUng6sI3LTiP2EGs8G33fVBLwWI=;
        b=xA1LrYjGZ+UQVTSKDj6JAuFPD8+gQPSbi4be2xinGVTlb668tLocMOwGdvdC5NNvFs
         uxz+0RO2n+/3V5On8KY1H179p9dv4x6rzYSXEp6tP0hZrUTdr3PjftbAAyqdNQaWvL0T
         r0g6O4QjZKxhB2GzhiVQ/hzPo4fidlOMQQJ929OngGuvX1wOIdCiapoqRJiTjpWRA9DL
         hlV4OxM5UFrrcL/nccUn+2uaNKl6iJT2qj246Ksuel5x80BtoH0LUL4ZCuYn/oNE5D1f
         SnwcCuqeya5aFJAoOqcqiiu00HT05ir6tBUuvNEuUkmqr2w3SrhMvTMldWiHTxU02GcX
         ehuA==
X-Gm-Message-State: AOAM531d9tatsp/Pu6DgIoHprFAoqzAC8klnfo76thfyBdU6RurFJ81T
        h2PWovgy+sUT0sGVLDKBWrMszowEprQ=
X-Google-Smtp-Source: ABdhPJzOoUYIn+KIWXJQ6gucNzOtfuQX4mLY2xEJPTH2VjfvsJyJKNpnfVGUtHlHVEXF2RouWH71Fg==
X-Received: by 2002:adf:ed41:: with SMTP id u1mr14757111wro.346.1635515964698;
        Fri, 29 Oct 2021 06:59:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f133sm3220230wmf.31.2021.10.29.06.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 06:59:24 -0700 (PDT)
Message-Id: <18419070c29aef85c266f01174f436566bf792fd.1635515959.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
References: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
        <pull.1068.v3.git.1635515959.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Oct 2021 13:59:17 +0000
Subject: [PATCH v3 6/8] git-compat-util: introduce more size_t helpers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We will use them in the next commit.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-compat-util.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index a508dbe5a35..1f41e5611a1 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -113,6 +113,14 @@
 #define unsigned_mult_overflows(a, b) \
     ((a) && (b) > maximum_unsigned_value_of_type(a) / (a))
 
+/*
+ * Returns true if the left shift of "a" by "shift" bits will
+ * overflow. The type of "a" must be unsigned.
+ */
+#define unsigned_left_shift_overflows(a, shift) \
+    ((shift) < bitsizeof(a) && \
+     (a) > maximum_unsigned_value_of_type(a) >> (shift))
+
 #ifdef __GNUC__
 #define TYPEOF(x) (__typeof__(x))
 #else
@@ -859,6 +867,23 @@ static inline size_t st_sub(size_t a, size_t b)
 	return a - b;
 }
 
+static inline size_t st_left_shift(size_t a, unsigned shift)
+{
+	if (unsigned_left_shift_overflows(a, shift))
+		die("size_t overflow: %"PRIuMAX" << %u",
+		    (uintmax_t)a, shift);
+	return a << shift;
+}
+
+static inline unsigned long cast_size_t_to_ulong(size_t a)
+{
+	if (a != (unsigned long)a)
+		die("object too large to read on this platform: %"
+		    PRIuMAX" is cut off to %lu",
+		    (uintmax_t)a, (unsigned long)a);
+	return (unsigned long)a;
+}
+
 #ifdef HAVE_ALLOCA_H
 # include <alloca.h>
 # define xalloca(size)      (alloca(size))
-- 
gitgitgadget

