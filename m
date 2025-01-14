Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E82361C4
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855869; cv=none; b=pUc0HTe3udsIT+S0P9lUXm+3ei+E8eIEQ98eIIGf3HGQwXs5iFkmoNzeNq0cu3hSqTpKV2JPHOYOgbD5w8Rq12JbJXjDDxOtgshfz8567Dgf2Iqxbgss613qMlvwWijbwVt9HWyMv86rFTPsev6KapJGHdkZSGkXsA/5NuWwuOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855869; c=relaxed/simple;
	bh=O9wBplcsGjYpOZAj8EXLvvHoAmjCt2iDNdkuG//elDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ESc8Q+XOIcBHzqii4c6GW7Lpc7ZDWk9APrqwaoO+U6LqhgKTp1YP/qozFeg9koZuu32mJF8BR5CjBOK/NtYLb7Mpwq4B0ygKmthx6ckBg0h6ur2O2uAjGoDNxOv1eyJA1oPvBJyXvYrBjttFFVeTwudnhS0V/bscwBKtGZ+EaYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a2nL9Bi9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXDGXaM/; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a2nL9Bi9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXDGXaM/"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id F36B11380389;
	Tue, 14 Jan 2025 06:57:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 14 Jan 2025 06:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855866;
	 x=1736942266; bh=ccYcGhLEFZBML8r4AynsdEC+8DsJVP/81xdkLk/3OyQ=; b=
	a2nL9Bi97aNXAWOemw/78vXqjuoQzjhX5lzNp8Q1R/Vt/2qH+QILMPShOdG5W0fq
	1BWPdp/bLGy4LEPSkjojVhl7lBip1PE/U5O8V9nx5f+u+x3wERbSjZCyr/JkA30Q
	gjIZOCv8ClUJ6rG3xLz0jtI9kKRDNNV56SUfer06NZXt531hicHq2DUyv4Fkdjbo
	sC4K4e4/DSnos8H6aY0jh+Lc0KcdiYCfJOsWrO0w9S1AWP5pOgytwbIk0bBO8kGe
	FDRnAUgKMh1cHS1Rna1MG5VauEicSLkOR108YR6f/DpqQ0jvjiQ5I+TiGPuczc42
	wV6O9+NKSc0UITE7QxLi+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855866; x=
	1736942266; bh=ccYcGhLEFZBML8r4AynsdEC+8DsJVP/81xdkLk/3OyQ=; b=Q
	XDGXaM/obm1X4HMGKuKdSOk9s5U9Ps49UztSMof+QXMagwb1+Pg0peFGd3BtZjXO
	YteQ+BWaaS4p+ykG72xbkhTS6IhEn9BHtKpQ00GTE4silDwWyeCoCi2DoIT6yh+z
	7pOQRa9xpnIEYtW2VX21eLoeHBwnIY5VOzg0YGWMJw/NLODXEHgi08AshhIZZFvo
	qCMF+pHuvWv+rqIaxglIuUcbbVKW41TvsgPTO9eVyT6PXkZvkpSZRqHaRsi81r55
	IYDL/BkLSqPPolqfsGGrW6Bk93FcRru58Pinlf0B/qVq5wF83NMtSIgNd3qZnkKo
	BAvY0hrw6RyDsGjB9/98Q==
X-ME-Sender: <xms:OlGGZ8akLfGEa82WigwBOOfC9H7DgMOG1kcjeYCeXk5S5QI1dQg5iQ>
    <xme:OlGGZ3Yo95R5xM7kifkl2FT6S7S0pm_3ksUTL-k3nMbqAqYoF-JiHyTU9K-yVJKgK
    BA369VTHyLQRHONew>
X-ME-Received: <xmr:OlGGZ2-WvhPkpzjaOWTNb4ASsqhHo985R1qLwbbwVwtRReOOkP8aHoudzZrrmBNR2vLdK-30l_PJSInbvOisI7A0vy_mW5cc0WafRiyKLaPMWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhm
X-ME-Proxy: <xmx:OlGGZ2ozhdhicUq8KEK7-aSKAhNXDEh1OK6nskquJgJH4CvAcPp_Dw>
    <xmx:OlGGZ3rk42pAgGKQNS9RvnVwTY2sk5rRnY0y4fcJUoWVJAQJZ5EreA>
    <xmx:OlGGZ0SArC93ZcaIL_9D628pBQLs2D-I5GY5mfe5yl1pFjfNRkrJhQ>
    <xmx:OlGGZ3pG_fCiKzV_Z_FqDnISR03dgRUDD7Is2tcFZUiiUEESG2A3AQ>
    <xmx:OlGGZ-1GtdoIRnaLS2VRIqiFVyOSMRoKVBpn-SGU-MbCms3k9zxQy4r0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:57:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6d423209 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:57:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:57:42 +0100
Subject: [PATCH v2 01/10] compat: drop `uncompress2()` compatibility shim
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-b4-pks-compat-drop-uncompress2-v2-1-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
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
index 97e8385b6643b963c54affb3ae621fc93fad28b5..86c6c3d7adfb8b0b52afeaafa3cc3c2a141e2f63 100644
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
index 77a1b08048463da25ba8d6b36031ccb7e8cce7b5..0000000000000000000000000000000000000000
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
index e283c46c6fa06e4079851296a55c9bd5472a65b4..d50f487c00d7958e871bb9a98419e55f866cdd1d 100644
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
index 831da1d43cafe85a8c9ac872e141476adbc08188..e6a0397c25db5875526f8723d5630584b2c2cf8e 100644
--- a/meson.build
+++ b/meson.build
@@ -256,7 +256,6 @@ libgit_sources = [
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
-  'compat/zlib-uncompress2.c',
   'config.c',
   'connect.c',
   'connected.c',

-- 
2.48.0.257.gd3603152ad.dirty

