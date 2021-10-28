Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78AF0C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E11860F92
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhJ1UxS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231307AbhJ1UxL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:53:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF21C061348
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:43 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso5337880wmc.1
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 13:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oUOtW+VMfF77w6KugTIk7kk1SNVq3GaMJS9+jVTFH/w=;
        b=UxQLySi2b3e76QvKhtPPYHtzbTjRDXz8WYSn71ED9ZZpxbUYrafgg34LC+P8E36Euw
         a3TDDK+599H9WMcQk8WmgMx3Ya9EjevTTxRvjZI9S7lOA1/es0u9/EmctUCNYRDXScVh
         iIz+Oa43HE7jnVNHtnlZ09GA1y5GqdRImPMoqCWYKDlkMn+af8I2YCNk6WUQVLyXEOFG
         tAjYvNs0VFCbaFlgPszJBavaiY8DS57IYLYqV5bN9Y+0PcTIGdzyrIu+qPuDa4GLlE5z
         jXKKITb2AsepQyCF3JmEBj5gHSuXg2fed+Smmzo4XiRtDkY94aHR//fLHLAlKATJkpLd
         Tssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oUOtW+VMfF77w6KugTIk7kk1SNVq3GaMJS9+jVTFH/w=;
        b=6rs/y4GsBB9qrjNRr3ghupDS61t7dcGQAJXX5l76aflAM/9ZhrwqbZ/ihCbW2w40zq
         fLGk8DO60S/HZfEKZv2d6pAWv1WjU0GeMvtsJuNWDwEWO0dtcXiy5m0IK1N97UhBDQto
         4FzZSCoQhxUQ7pl675+3H6+DbQT90jepC0JBUijI7mTDyZNCwKUmSImraI6AOcU6XyG3
         oRaLmYvnymUHwXbUPkgXwspotxmBZqKl1Md7+2C22uPI2c9ckvhk2teyCavewqVhh/JB
         nZiWSRQfXszsyGTQKXlhL+R0IdFzGeuToyCVDHnpvIF4mQLZD/ufHMGNvyr2qXNQLJVk
         cy8g==
X-Gm-Message-State: AOAM532mm1LWTzZNvieX9X1T6Hfryasye8+w+LCRJRmKtT+ukSqudnmZ
        dHDH430NNg6AhT517ZdnBE9OlQQe1Gs=
X-Google-Smtp-Source: ABdhPJzE0n1tnJMj24Kmg+UFJfFdtHwA32c4fAJ4htsr1gbhZtoYTTI2l1grAsUwmsrQddZw9+H5ww==
X-Received: by 2002:a7b:c010:: with SMTP id c16mr6933046wmb.141.1635454242375;
        Thu, 28 Oct 2021 13:50:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u15sm3661501wmq.12.2021.10.28.13.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 13:50:42 -0700 (PDT)
Message-Id: <c6910584108250be18713ba248dd7eff8571667b.1635454237.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com>
        <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com>
From:   "Matt Cooper via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Oct 2021 20:50:36 +0000
Subject: [PATCH v2 6/7] odb: guard against data loss checking out a huge file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Carlo Arenas <carenas@gmail.com>,
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

