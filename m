Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAC920DD6D
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513742; cv=none; b=uqk11S8cMoNyKIo3k/7IJCwjg+s5dZvOv+yQvckKOfqmy5JwVyHgR8c5YF379TfwtoJY3yIw+hHtyw/7RcfD3GODt+iK3Dz4Tw4nqQQRSYkzgu9339PmxxpfvNdVfT13zRa2jpeSg5eaukcYUFFmf+StM0JXQczOJByuyzTCvoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513742; c=relaxed/simple;
	bh=ktRXCLekCxmku6R6y+zcQ445wnIchyEm4JWknCEM8ao=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kcChgW8vQ99NW/0l8TWs21wyA8xYtSzmXtdvlTMaJL7QHFEbetqzDrQBC66WlHibgrk/w4rj/jI25/1/3ZAIE3xyDdXMz5EaXWt+jeTXvm6989YSNXXR0BazDAEvLWEqyAG4XdU6//1WyMOTcrMi48T/uh4cKOH+uvnPNOJuNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PAylcr2T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N+KFv9pj; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PAylcr2T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N+KFv9pj"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 39A901140155
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:40 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 10 Jan 2025 07:55:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736513740;
	 x=1736600140; bh=4FceCZ6i+H4mPWHUWqPArosKyJBgfOP6t3/XXDsJtfg=; b=
	PAylcr2T3XbdSDUsIT8loluhIpv/z9vN17CnWTth+312W3AvQ1WS0GeX+gBZTc6n
	bLhzyDEoZRGR8p0+jMmY8qlyM3gEiukQsdAIwF73d953vknR61ubFJOUk12SpXa6
	rF1rWeo0CgG4oR7zV3ljvGwqPL4wffoR9KvJrGbKrwkaVHH+qCYxHANOpd0mMHT8
	M+XVx7lbDvFoiEWudIWK3idJnpu1rZRvPOloSXKusrSSPsA+1lOFoNR/sR3/Mhw/
	mH7bLpLEyj5dVDhSuvCNXbhuoNdKRgf8wtZ9owUpVQUkMS0lSt4D6cJJmHTbSx7P
	8awBcex3SxSmGUs8zMl4tA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736513740; x=
	1736600140; bh=4FceCZ6i+H4mPWHUWqPArosKyJBgfOP6t3/XXDsJtfg=; b=N
	+KFv9pjmdUSHfSWTr4OOjg9c7TUXXmKovfqbIHxFNgOELneMUOC6VMJ/QCx8XBxw
	ZjrGJfzixdyU9xbP1Ye8E2Uqx6jiicqOG8/Wv40nDmNlA0SsW1vmtHe85hNIHN1B
	pC64AvdmRLUGdUMzfzUJ0o960tBz76salo3kNH581Bx2096MBZ41j4nx/ux9LMmw
	25wTLScaxFOCOIM3DL5KaNyn+67W84W3Q8Nw6FByJDuIftcK027yuuMvyODAaHhL
	S8kU8J76YMP5W0JMtn2cPV6C7NgyQH5Erm3zUIqH1jLjFG7k8lt7eLa2C2oRTcPs
	xCFma4TlfZeEr8W9UNX4Q==
X-ME-Sender: <xms:yxiBZwriOaNQY9trB_2d5_d5nGvnbkfFqdGrAmTcolSq2NlngUY4MA>
    <xme:yxiBZ2pW6NUiR_CC4DOteW7NCKFuXzQ5HQ-j-yIVdBaUjgr3gXG3BDQZcKhvPZ67A
    x1fXGv07dn2a9E_0A>
X-ME-Received: <xmr:yxiBZ1NfqF4_ajbGqYs5L5Khnhx7mb7309yHeYAN9fvdCnsTVnqRZeVm_vOg9NYAGSeHmIYU51a5xNGxYny0NOobtFOH8LRs8XrIOtZmOXh8Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepfefhueegle
    ehfeejkedtffehvdfhvdetfefgtdduffduveevteegueeutdekhfegnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yxiBZ36UvLIjhSTkRm7jRP9W4NxUKgU8BU5L0ET27RMhuXqNGq2_vw>
    <xmx:yxiBZ_4xIOysiR7F9_VbdtIBpo20qtLOomFZl2gBUYLvXbXsYh3hvg>
    <xmx:yxiBZ3gZrlH_2QDKJj45VykQqdxxpKY9ekIG5akfxcz91yDcglsZgA>
    <xmx:yxiBZ545QC_5Mk5EZvHAVxwtpGb0092RTN7OHiJqku-cKxQdCLtqrw>
    <xmx:zBiBZ5RxFv4ke3jgtU1NHBWjEGKaP9N9pXkfw2oSKaTO8jwZPk8X1eFr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c3ad25ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 Jan 2025 12:55:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 13:55:35 +0100
Subject: [PATCH 8/8] compat/zlib: allow use of zlib-ng as backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250110-b4-pks-compat-drop-uncompress2-v1-8-965d0022a74d@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
In-Reply-To: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The zlib-ng library is a hard fork of the old and venerable zlib
library. It describes itself as zlib replacement with optimizations for
"next generation" systems. As such, it contains several implementations
of central algorithms using for example SSE2, AVX2 and other vectorized
CPU intrinsics that supposedly speed up in- and deflating data.

And indeed, compiling Git against zlib-ng leads to a significant speedup
when reading objects. The following benchmark uses git-cat-file(1) with
`--batch --batch-all-objects` in the Git repository:

    Benchmark 1: zlib
      Time (mean ± σ):     52.085 s ±  0.141 s    [User: 51.500 s, System: 0.456 s]
      Range (min … max):   52.004 s … 52.335 s    5 runs

    Benchmark 2: zlib-ng
      Time (mean ± σ):     40.324 s ±  0.134 s    [User: 39.731 s, System: 0.490 s]
      Range (min … max):   40.135 s … 40.484 s    5 runs

    Summary
      zlib-ng ran
        1.29 ± 0.01 times faster than zlib

So we're looking at a ~25% speedup compared to zlib. This is of course
an extreme example, as it makes us read through all objects in the
repository. But regardless, it should be possible to see some sort of
speedup in most commands that end up accessing the object database.

The zlib-ng library provides a compatibility layer that makes it a
proper drop-in replacement for zlib: nothing needs to change in the
build system to support it. Unfortunately though, this mode isn't easy
to use on most systems because distributions do not allow you to install
zlib-ng in that way, as that would mean that the zlib library would be
globally replaced. Instead, many distributions provide a package that
installs zlib-ng without the compatibility layer. This version does
provide effectively the same APIs like zlib does, but all of the symbols
are prefixed with `zng_` to avoid symbol collisions.

Implement a new build option that allows us to link against zlib-ng
directly. If set, we redefine zlib symbols so that we use the `zng_`
prefixed versions thereof provided by that library. Like this, it
becomes possible to install both zlib and zlib-ng (without the compat
layer) and then pick whichever library one wants to link against for
Git.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 compat/zlib-compat.h | 36 ++++++++++++++++++++++++++++++------
 meson.build          | 21 +++++++++++++++++----
 meson_options.txt    |  2 ++
 3 files changed, 49 insertions(+), 10 deletions(-)

diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index 2690bfce41caab2e9af7a09663d620f0ee5136a0..58e53927b227f8368c73a48f5e5dc84a223f0af5 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -1,13 +1,36 @@
 #ifndef COMPAT_ZLIB_H
 #define COMPAT_ZLIB_H
 
-#include <zlib.h>
+#ifdef HAVE_ZLIB_NG
+# include <zlib-ng.h>
 
-#if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
-# define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
-#endif
+# define z_stream zng_stream
+#define gz_header_s zng_gz_header_s
 
-#if ZLIB_VERNUM < 0x1221
+# define crc32(crc, buf, len) zng_crc32(crc, buf, len)
+
+# define inflate(strm, bits) zng_inflate(strm, bits)
+# define inflateEnd(strm) zng_inflateEnd(strm)
+# define inflateInit(strm) zng_inflateInit(strm)
+# define inflateInit2(strm, bits) zng_inflateInit2(strm, bits)
+# define inflateReset(strm) zng_inflateReset(strm)
+
+# define deflate(strm, flush) zng_deflate(strm, flush)
+# define deflateBound(strm, source_len) zng_deflateBound(strm, source_len)
+# define deflateEnd(strm) zng_deflateEnd(strm)
+# define deflateInit(strm, level) zng_deflateInit(strm, level)
+# define deflateInit2(stream, level, method, window_bits, mem_level, strategy) zng_deflateInit2(stream, level, method, window_bits, mem_level, strategy)
+# define deflateReset(strm) zng_deflateReset(strm)
+# define deflateSetHeader(strm, head) zng_deflateSetHeader(strm, head)
+
+#else
+# include <zlib.h>
+
+# if defined(NO_DEFLATE_BOUND) || ZLIB_VERNUM < 0x1200
+#  define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
+# endif
+
+# if ZLIB_VERNUM < 0x1221
 struct gz_header_s {
 	int os;
 };
@@ -18,6 +41,7 @@ static int deflateSetHeader(z_streamp strm, struct gz_header_s *head)
 	(void)(head);
 	return Z_OK;
 }
-#endif
+# endif
+#endif /* HAVE_ZLIB_NG */
 
 #endif /* COMPAT_ZLIB_H */
diff --git a/meson.build b/meson.build
index f1aac01f729efaf19e25b1f11505de49443d5326..aeb41c6c684a411c4bdcfa476d6a67e5c9bba371 100644
--- a/meson.build
+++ b/meson.build
@@ -777,11 +777,23 @@ else
   build_options_config.set('NO_PERL_CPAN_FALLBACKS', '')
 endif
 
-zlib = dependency('zlib', default_options: ['default_library=static', 'tests=disabled'])
-if zlib.version().version_compare('<1.2.0')
-  libgit_c_args += '-DNO_DEFLATE_BOUND'
+zlib_backend = get_option('zlib_backend')
+if zlib_backend in ['auto', 'zlib-ng']
+  zlib_ng = dependency('zlib-ng', required: zlib_backend == 'zlib-ng')
+  if zlib_ng.found()
+    zlib_backend = 'zlib-ng'
+    libgit_c_args += '-DHAVE_ZLIB_NG'
+    libgit_dependencies += zlib_ng
+  endif
+endif
+if zlib_backend in ['auto', 'zlib']
+  zlib = dependency('zlib', default_options: ['default_library=static', 'tests=disabled'])
+  if zlib.version().version_compare('<1.2.0')
+    libgit_c_args += '-DNO_DEFLATE_BOUND'
+  endif
+  zlib_backend = 'zlib'
+  libgit_dependencies += zlib
 endif
-libgit_dependencies += zlib
 
 threads = dependency('threads', required: false)
 if threads.found()
@@ -1948,4 +1960,5 @@ summary({
   'sha1': sha1_backend,
   'sha1_unsafe': sha1_unsafe_backend,
   'sha256': sha256_backend,
+  'zlib': zlib_backend,
 }, section: 'Backends')
diff --git a/meson_options.txt b/meson_options.txt
index 89b01bad042b533b23e0e2b4b780ce152ee688c8..585cef0ab2a1061e16e05a2252e37adeb48025f6 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -55,6 +55,8 @@ option('sha1_unsafe_backend', type: 'combo', choices: ['openssl', 'block', 'Comm
   description: 'The backend used for hashing data with the SHA1 object format in case no cryptographic security is needed.')
 option('sha256_backend', type: 'combo', choices: ['openssl', 'nettle', 'gcrypt', 'block'], value: 'block',
   description: 'The backend used for hashing objects with the SHA256 object format.')
+option('zlib_backend', type: 'combo', choices: ['auto', 'zlib', 'zlib-ng'], value: 'auto',
+  description: 'The backend used for compressing objects and other data.')
 
 # Build tweaks.
 option('macos_use_homebrew_gettext', type: 'boolean', value: true,

-- 
2.48.0.rc2.279.g1de40edade.dirty

