Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C617420B7E9
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513740; cv=none; b=N36zUI0dfFtMBZPJr9J8xOJ86UU/i20PU8/0PqQTCsfdf8wBZrwct01FSfYctrOJEKuUYhK/fmCF/lm+9Hdiu7n+XRY0KsyKHN2kAgoodqFN9LdsLskM/EZ2gCg5j3uxlZGBhgAYLAtJqs2zbvk7sAml0tJGXlzwclnL2Ko6JNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513740; c=relaxed/simple;
	bh=KYsVG/etjHY+CGnUdDs8p6eCX14cw71Ff7Y4OS1HlVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=o6DcU2nQAD6I9mKko5cbCSXxGXGxBSo+W8kje7vH/jj2VaZxyaWweWqv0oXI29iV7dUJtSUXipPxMu5SVCQJXYh/n+wLmNBTVnjrjUuMpdnpYYeBoKjxDzyAmZhEYZjQ8roPAPmt86c7joknMGKC+xawgIcWDehGccIevItZOHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UkqB+knb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c1yYJGnm; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UkqB+knb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c1yYJGnm"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id F08FF25401BF
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:36 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 10 Jan 2025 07:55:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736513736;
	 x=1736600136; bh=vOAVEC6ZTd1faQmUzBbwN12hDr4m82woou+52DsTFWI=; b=
	UkqB+knblOSIL4RW9Vtlq11xhKVgtACYyxKyO5IqXYtjH+qwT0dJvj9qO7FDBBoQ
	a6IfqonhrmlnEQ14hTSsowItIrU1wq5HU6MlShXErlO4QsJjpSW9IXczlDGJOz1K
	JkkWHs8KHRUgbdLVTarNxcnAFa4RkR3aGI0M+VAhwQ6xy8Zxv3B3ZKYbtQ59ROkF
	kElAa4hJ5Tmjas4TukyBO5xfULgrk1lWYE5QYpfkiQHoKj+WX+1jff+mNVdoMJAS
	Vaz96xDpKP3XimY6ztCZWWRbGeB1TG+O7WgaNKHt/ygOibUF1FMVlrdHptPz3wPD
	yh6+sfwyx6Eq/elrDF+2ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736513736; x=
	1736600136; bh=vOAVEC6ZTd1faQmUzBbwN12hDr4m82woou+52DsTFWI=; b=c
	1yYJGnmfx5jAsFAhU4zqBL7gsr5u6LeO6Mn0T12rQlAn6rKQXUH5LBFECydXHmFI
	LOdEOTVkNWh5jyUUvWGIH4YsdT/xtsf9pWGZWX5hmNCOwiokErvuZ/M4BTutepPC
	AqGhbu+1+6UCMZ3fGO5a17klOPSlLODHu/JXDZJKxUN2SNSH6Aq34jICzLz3ALUl
	6K1QA4qBAZ+jyKFNu0xw9l6Shb1TuBHSONprdOSwQKAmsRXmemezrEBHg+73bNbx
	u0WjH7MCLftAnYC26iyikBE2kkx9UAha/A2Cu8pSIfWfFc5ULBd08d4r0QrgNZLJ
	5Ab/xg8UCuYQQDRkS+IpA==
X-ME-Sender: <xms:yBiBZyOOsSa9p31_kmDOywj7FmzptJ27Ktq0ROiNjHPR3mIreUU-8A>
    <xme:yBiBZw8Th6n_9ThJgG8WiOaRQf2FvbvpeL5qA6qUFo11zLiMTiaLb4qXuxtdZMSgZ
    bmuUkY6J6jk0LPllA>
X-ME-Received: <xmr:yBiBZ5Tv1hTAPrHIRVnKRbIW5b280fRpqX8I1orfIN9EtSnIZIr266FooEQ0NfMkewwbymG_3ZICIOz0RyEuCTlr-ddvG3Qq08Ga9k-CWXTCPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yBiBZytmFnStQBoY0mYhqecDzL9wWXs0tgj4h0DHqeATf-Jdkd5QqQ>
    <xmx:yBiBZ6fmO0OONclTKp9XRwIxYb_MoewSmIAUsCsBxr8sLOmcsWpR2w>
    <xmx:yBiBZ23blWb2pPVJ-D5RkUr65jBJ7-E2p9nmiZ9cFLQBYv-StdG1KQ>
    <xmx:yBiBZ-_sC5JD8Jllob9oYCDPs2XxcUg8tgf4orO1Vj4Ht-Avu6HMUg>
    <xmx:yBiBZ-Hr5XQudbGXwt7Aobpi8oN-7WJyTkW-U1K2vaIde0XqLbN692sZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:36 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cbcd618d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 Jan 2025 12:55:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 13:55:28 +0100
Subject: [PATCH 1/8] compat: drop `uncompress2()` compatibility shim
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-compat-drop-uncompress2-v1-1-965d0022a74d@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
In-Reply-To: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 7361eb2eaad422e7a6c6ed95d275615836c21cdb..f1aac01f729efaf19e25b1f11505de49443d5326 100644
--- a/meson.build
+++ b/meson.build
@@ -248,7 +248,6 @@ libgit_sources = [
   'compat/nonblock.c',
   'compat/obstack.c',
   'compat/terminal.c',
-  'compat/zlib-uncompress2.c',
   'config.c',
   'connect.c',
   'connected.c',

-- 
2.48.0.rc2.279.g1de40edade.dirty

