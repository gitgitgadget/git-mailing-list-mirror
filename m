Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E2D1D6DDA
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019047; cv=none; b=le9+iWaBV5mZCGb3tc1rxe2qe58kzuxA31YMeZUZb6abXRiNPPPKmbw3SZnGWyTt64E8GaeiDnO0Lz9aYSDQWq4sZQz7r+YMECJDak6fWCUILAlAaVrcEQWi4e9npHZhDlbCdnhqssyDMABzFf0Bw8+oeIXJKWz6DooI+0uDN9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019047; c=relaxed/simple;
	bh=esEaf/q+o9XwasAExyiFX+mr9F3WleAhPq5gvFHL9Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Re/ERwuHmvhjHODoyT9rHnFtJE/Lik4i4YP/P6aBp4PNAP57k4xPf6/31DW8SmEjx966SIt42AKVY/RgsnrJekFyAjKatD15h8r49A8lTcCk/PLOY+Ga9KIko6KR0r/WCwcKGgrwAbtLXzvGCqv9UVKMqckRw/cE0X4iYIaeaNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I1ZpdRRd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VjqLZ8no; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I1ZpdRRd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VjqLZ8no"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id BACC4114015E;
	Thu, 16 Jan 2025 04:17:24 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 16 Jan 2025 04:17:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737019044;
	 x=1737105444; bh=fU4l3uAIHnABq4v1/s6QUiOA8WQCv8+UE+YzpnliHV4=; b=
	I1ZpdRRdbhKckA47Z8F6nRFB5CQPD8XwzLdghQDhzLBLZSOIrGWGcE/QDWLlT3vQ
	XFHbnPi3xsH+pJT8nZxbRsI42CXik23Soqx7GOVRB0F1TdbRqTUIBYTig50TYaL0
	HhouY53ZofFUNK9eI/iCWK11DqQO98Imll9FfWPq9eGAYNVeunGuWyQKW1hQrNqZ
	I05506hAMJBk+/Tumz+NzyaRcQmWUAEOSQ7h3TYGi8RV1p/porPdU/2BNYsikpmD
	1Knzm53/s1zL8iOGl5cl6TYlrw4u9Ef7bowP9vAaP71hlkvDqIK3hxSpCAZX7lPK
	itPb9RLH5kt/OatLzVtFTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737019044; x=
	1737105444; bh=fU4l3uAIHnABq4v1/s6QUiOA8WQCv8+UE+YzpnliHV4=; b=V
	jqLZ8nowInTFIl379AJ+XQkC9LkIWNbMOG4W+0xl86Icd9E+J6rRtXMvNgk0k+Ez
	tyhpe2t+qMLo0uJH7P+nGPBaGLziYz2m0YGuI5mM4649aTZ7KIqGfYd3ZdzkoMOl
	MV8kTNqnNUNFhGG2kT64zSwODAiXHkdRvrGzlb7efaznU8uyHRZqmM1fiv9U33f7
	lEbqJ8QJAUQFrFwYK6wyIps9eUJHHVmbRCXvzLRGw5RSZAYyJ88fl9fVIQPgdXwQ
	5zPX44f73PT5KdwCVsPHks4XwXyrNnGJvYExncNLqEWRhBMCj+5Nw8BlHv0b7khk
	erv4pabEJyYwBRudZOL+Q==
X-ME-Sender: <xms:pM6IZ6di9e2wsh4FtfrIrFW6ZvJR-TTI5UTylWNqYI4QX2RUQ1PfYQ>
    <xme:pM6IZ0MnB9TKGsD6rsTqDvpOLkCTADPUvdrxDTfmeGoEDWnJX6kHkfyH5Jp_45k1C
    wW6RVWQW19wR_R1Sw>
X-ME-Received: <xmr:pM6IZ7hBdvd07dbRiOYdz0pPpiF9R36JEE7rCWnL9JC4EYWlmoxGXLiDfoXgmoxmrlDqC_gEZxBJm7eenW3WOZasI90OkNyWfj6PLgA7-UGApcIUVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiudcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfh
    rhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqne
    cuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteek
    gedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:pM6IZ3-36AaiS0BqLkeyFNNy-v-AGQzhT3wtw09lzAb9gNITrmuX1Q>
    <xmx:pM6IZ2v_SY0Ol9s9qPoLjVtOpxoXaO1cQAfyNEnixOID5n7ILuRLLw>
    <xmx:pM6IZ-F-hmV6FGjL0SlwI56070vxLdhF9Vj3ito9nf5VdoFJxXpePw>
    <xmx:pM6IZ1O9S5hbBWBnQBuy2rt9i-wqKZWYloyDEyDoKaORo2mtFz_shA>
    <xmx:pM6IZ6J_UZq9uVcn_Nb2u4eQTV4inxhpp5qvgzfMnx95_n8e4SoE371f>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 04:17:23 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3e677e04 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 09:17:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 10:17:14 +0100
Subject: [PATCH v3 01/10] compat: drop `uncompress2()` compatibility shim
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-b4-pks-compat-drop-uncompress2-v3-1-f2af1f5c4a06@pks.im>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
In-Reply-To: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
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
2.48.0.257.gd3603152ad.dirty

