Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F145F18C91F
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053696; cv=none; b=E3OBlUlQOMIdeYA5KeH4pIf+Nwd6ma4XTrRKIKSqr2Q/z4UBskPthDcVE74qbkTtPUplAOTTzVbHeCRBXYC/qztd9vWJLUKXWG4k7p7Vnl+aRsg/0sojgCKq/YBCVQ1fOObgncpH1KFGTN5XfpLP4/MqmlJ3rmTseEl+tNucD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053696; c=relaxed/simple;
	bh=FsQFbJtOec+Wgk/wib68HyD5Czlb5D6fbTZywVQ8GpY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P5wCXwY28aqThG3vTnhmR1cthJGa+vbq7dkxgouWlklwkXtWDbM8FRmsOc811mX7xSs4PWjq8EVd/HAv3KEpayJkuaeSwuGsltCypPwcVzG+Usp//saELiKm3d2oP3H4Udx8ndJhsBtB+8h4BnygZzuL7wGXgUQ7kSkepay7ILc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AgaZOp0K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NKhfNsmI; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AgaZOp0K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NKhfNsmI"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id D7C631140147;
	Tue, 28 Jan 2025 03:41:33 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 28 Jan 2025 03:41:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738053693;
	 x=1738140093; bh=ye8uSdYa2vZ5CKQbHevM5cNBg5UZo3j8hfxI5hgXlLI=; b=
	AgaZOp0K5rTbYZt2HhekN881mXIt3dKUlk47BRBWI0IJr+n/1x+nhh2hBMQzGAIv
	Yyea+lxF7ZYuZi159Xj8kY/RLGcpkc7uz9lWCNUDxsYpdNBbyvYHy2fqYh14qjBs
	WKYAJ9kBxrpvR8sEaM9/Gr7MjtBmKFWQOXT0i4twWBQMieHX8RHF1yB0nnEq+gVO
	vG04PzJ3TfDHOabHVoqYxnWDnAv/0sDFOMxHhJ6yQ1GfpX8I3BYNgtuINmqjkPYv
	VBrYlQnM9wcXWe9vSgewwlq0gctZK+q04X34aFzt1hWbmHdOYE5vJGvMSh81lqnj
	pCmmmHBw0blAT9A1Lh4IaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738053693; x=
	1738140093; bh=ye8uSdYa2vZ5CKQbHevM5cNBg5UZo3j8hfxI5hgXlLI=; b=N
	KhfNsmIFgvLlZhKwVz6m19T4z/hqy5P5DvSg/IEawVFrG3Y2wgIE4XQ4XP+IdIss
	lw2dwuvvUS/VPqFFOD6O/geK5kuBAVmvue2q2DStAjnyceam1bRP0My8bE7HeDYx
	7+o8fNWmDrCgdLSCSBOBjGquOEutV4v0jVlHkqpgLnA3qdk6Hq3oRC3g0UfKWcTm
	fz+fk9qheYHXPMU+6kerhBZcRV1R10aiR8MCi5AdllBR1OZI0luUjOOcmNegCFZ8
	vg4muvPVR9ehrmo8Sx/lHHcrUcmfqYAasLNj6JDpJnKZzPBtc0l1Uln02VMTp87I
	aUoy7hsPaIjSKxDuz7vCQ==
X-ME-Sender: <xms:PZiYZ9Ty857T3Hjg-pc_5DOwCYzjuoZYNpQSBku3NNY6lXMpm3NKJg>
    <xme:PZiYZ2z4btXk0jCBFlFXe9y-7g2sZiB6d-VE6Mpihl4B0LXfU_SdWbAqFTN_F8tKV
    7ODYYRaC7F9-OH8gw>
X-ME-Received: <xmr:PZiYZy0mYTbl2MICk1tmWnxsFJh_NMUPUf1QRz-tPtAAGrjqKUZ4dVgXNoN925n-8C-JlecNDICoZESpK7mIrjRHdAssbHoyuj_Xn_yUd4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:PZiYZ1AbCeylgzaRpKmkhPa-6BkjpaN2SQB8KjzxAc3pw00Av7oyNg>
    <xmx:PZiYZ2hFbniaGVYbx704Nhlwrtn6e16sbyAAqt1k3dJWtJlWvbzVug>
    <xmx:PZiYZ5qZFQY2cxIfs-kf5wyTqQ9S7B1_cAbR9X9kwonnV31csL-fmw>
    <xmx:PZiYZxhUyJdEAFpZz6sK78pItjoqKUJt8IIcAxB35vwWKbqy9SGzAg>
    <xmx:PZiYZ3vYGfIx3uqX-TryO-xuWlj7JHnYO7tBXSrSO4w6r8yZG9UWc2II>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:41:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2daea82e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:41:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:41:27 +0100
Subject: [PATCH v4 01/10] compat: drop `uncompress2()` compatibility shim
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-b4-pks-compat-drop-uncompress2-v4-1-129bc36ae8f5@pks.im>
References: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
In-Reply-To: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Our compat library has an implementation of zlib's `uncompress2()`
function that gets used when linking against an old version of zlib
that doesn't yet have it. The last user of `uncompress2()` got removed
in 15a60b747e (reftable/block: open-code call to `uncompress2()`,
2024-04-08), so the compatibility code is not required anymore. Drop it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                  |  1 -
 compat/zlib-uncompress2.c | 96 -----------------------------------------------
 git-compat-util.h         |  9 -----
 meson.build               |  1 -
 4 files changed, 107 deletions(-)

diff --git a/Makefile b/Makefile
index 97e8385b66..86c6c3d7ad 100644
--- a/Makefile
+++ b/Makefile
@@ -984,7 +984,6 @@ LIB_OBJS += commit.o
 LIB_OBJS += compat/nonblock.o
 LIB_OBJS += compat/obstack.o
 LIB_OBJS += compat/terminal.o
-LIB_OBJS += compat/zlib-uncompress2.o
 LIB_OBJS += config.o
 LIB_OBJS += connect.o
 LIB_OBJS += connected.o
diff --git a/compat/zlib-uncompress2.c b/compat/zlib-uncompress2.c
deleted file mode 100644
index 77a1b08048..0000000000
--- a/compat/zlib-uncompress2.c
+++ /dev/null
@@ -1,96 +0,0 @@
-#include "git-compat-util.h"
-
-#if ZLIB_VERNUM < 0x1290
-/* taken from zlib's uncompr.c
-
-   commit cacf7f1d4e3d44d871b605da3b647f07d718623f
-   Author: Mark Adler <madler@alumni.caltech.edu>
-   Date:   Sun Jan 15 09:18:46 2017 -0800
-
-       zlib 1.2.11
-
-*/
-
-/*
- * Copyright (C) 1995-2003, 2010, 2014, 2016 Jean-loup Gailly, Mark Adler
- * For conditions of distribution and use, see copyright notice in zlib.h
- */
-
-/* clang-format off */
-
-/* ===========================================================================
-     Decompresses the source buffer into the destination buffer.  *sourceLen is
-   the byte length of the source buffer. Upon entry, *destLen is the total size
-   of the destination buffer, which must be large enough to hold the entire
-   uncompressed data. (The size of the uncompressed data must have been saved
-   previously by the compressor and transmitted to the decompressor by some
-   mechanism outside the scope of this compression library.) Upon exit,
-   *destLen is the size of the decompressed data and *sourceLen is the number
-   of source bytes consumed. Upon return, source + *sourceLen points to the
-   first unused input byte.
-
-     uncompress returns Z_OK if success, Z_MEM_ERROR if there was not enough
-   memory, Z_BUF_ERROR if there was not enough room in the output buffer, or
-   Z_DATA_ERROR if the input data was corrupted, including if the input data is
-   an incomplete zlib stream.
-*/
-int ZEXPORT uncompress2 (
-    Bytef *dest,
-    uLongf *destLen,
-    const Bytef *source,
-    uLong *sourceLen) {
-    z_stream stream;
-    int err;
-    const uInt max = (uInt)-1;
-    uLong len, left;
-    Byte buf[1];    /* for detection of incomplete stream when *destLen == 0 */
-
-    len = *sourceLen;
-    if (*destLen) {
-	left = *destLen;
-	*destLen = 0;
-    }
-    else {
-	left = 1;
-	dest = buf;
-    }
-
-    stream.next_in = (z_const Bytef *)source;
-    stream.avail_in = 0;
-    stream.zalloc = (alloc_func)0;
-    stream.zfree = (free_func)0;
-    stream.opaque = (voidpf)0;
-
-    err = inflateInit(&stream);
-    if (err != Z_OK) return err;
-
-    stream.next_out = dest;
-    stream.avail_out = 0;
-
-    do {
-	if (stream.avail_out == 0) {
-	    stream.avail_out = left > (uLong)max ? max : (uInt)left;
-	    left -= stream.avail_out;
-	}
-	if (stream.avail_in == 0) {
-	    stream.avail_in = len > (uLong)max ? max : (uInt)len;
-	    len -= stream.avail_in;
-	}
-	err = inflate(&stream, Z_NO_FLUSH);
-    } while (err == Z_OK);
-
-    *sourceLen -= len + stream.avail_in;
-    if (dest != buf)
-	*destLen = stream.total_out;
-    else if (stream.total_out && err == Z_BUF_ERROR)
-	left = 1;
-
-    inflateEnd(&stream);
-    return err == Z_STREAM_END ? Z_OK :
-	   err == Z_NEED_DICT ? Z_DATA_ERROR  :
-	   err == Z_BUF_ERROR && left + stream.avail_out ? Z_DATA_ERROR :
-	   err;
-}
-#else
-static void *dummy_variable = &dummy_variable;
-#endif
diff --git a/git-compat-util.h b/git-compat-util.h
index e283c46c6f..d50f487c00 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1540,15 +1540,6 @@ int common_exit(const char *file, int line, int code);
 #define z_const
 #include <zlib.h>
 
-#if ZLIB_VERNUM < 0x1290
-/*
- * This is uncompress2, which is only available in zlib >= 1.2.9
- * (released as of early 2017). See compat/zlib-uncompress2.c.
- */
-int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
-		uLong *sourceLen);
-#endif
-
 /*
  * This include must come after system headers, since it introduces macros that
  * replace system names.
diff --git a/meson.build b/meson.build
index 30d7a89490..12129a8b95 100644
--- a/meson.build
+++ b/meson.build
@@ -263,7 +263,6 @@ libgit_sources = [
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
-  'compat/zlib-uncompress2.c',
   'config.c',
   'connect.c',
   'connected.c',

-- 
2.48.1.362.g079036d154.dirty

