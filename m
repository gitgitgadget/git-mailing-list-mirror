Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9741DF971
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738053701; cv=none; b=SjAo/KBvtEzEo2r5aWNlxgvY40hj1vkZIJzZ+nJ415iR1KWzyitZosKvLMtgovgsI+UZaCyAXBVvrstFvUAd40JuJA7WuwQAdKAtaj6I9wlqKHkcg//gYOsvco8U4JRF+ImhYUtw9ANjyIR9+hz0a0HOYO79mXarg8AVkgGB2M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738053701; c=relaxed/simple;
	bh=0sQvRDOnxc4CAbN2nOgc5ogwgdxthBo+EgFsxuXdG1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TXA/5KzQZ1TOAokv6JST7QlmsuYyR5ax+apM6MpoOH58Qya3Eu2EWunozJY42PVZoQl2o4xX4HCgV4rTOCvDu7heKYGmvQK/kVKwMICjv+88XhsCGItq134e5xAj1+gefDBaIken129FZFpGk0w1MbtsGqdlGbgKRzCsXPnXI68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fXBBqdWP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iTmDAlrl; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fXBBqdWP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iTmDAlrl"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4F8252540088;
	Tue, 28 Jan 2025 03:41:39 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 28 Jan 2025 03:41:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738053699;
	 x=1738140099; bh=QSLZg8fjtFHeULyURPF/B73qmCEuppLbEBN08YOOJds=; b=
	fXBBqdWPQl1z53+8GfMDqCEgJDTyHPGgicnwh3WuhNbHtx9YdjYsGOD3ektrFyIK
	ThoJB0SJU4K6NtfnxRPw8RTR9UCDngnAnndnoLKHj5WDmnNNk/uGlkRqVwMU4b4X
	rO0hQ4ib0BliRfPLAMPcFffbOEa5hRxfTICNqaqQo7HPVJxC0rt1ePY7ovyHkN7n
	7FAQ/1/2KTtFhyNJPuv3cpBJEmehfYEK35dNyuR25x1sWEiPKHtlsloetsV2pYDo
	ZX9dbsFCVQyY/WIR2Rj4AqFC//NpvHSahWckofCVtWmqCQDn2I9EfGsSe9y4HMjH
	ucp2Y3QpbhsFceeku5xvXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738053699; x=
	1738140099; bh=QSLZg8fjtFHeULyURPF/B73qmCEuppLbEBN08YOOJds=; b=i
	TmDAlrlfWTueafdHURDbA7guGTeIcbj25KF5cUYcFHSqxI7fjjfeaxE4QtsgxIqg
	kZilC+T4g9bmNphX+e1uGs4xAZDfjRDhboZO9jth1Hz4P3Me5yR+3FRNfmIlKjrI
	Xx0x3Fyj3B5W173d1ljmOwjUE+auG+9cTC3wrFPnno/pEUedSDUHhAJua7sgi7Ms
	uWYfKbykPHfFugmesp9oyZ2o/Hn0jLGpEopggx2kD6UXE8sgfn6qPwXYaWsA9p8P
	5rPzBdpmSk7KGROsLMTILOrnwFOV8n/m0gYEAveUupPfL8ZN347jNvQ+IW2W/IWj
	34RhMZ/PdCSHX1ZFA+G2A==
X-ME-Sender: <xms:QpiYZ1x0cRTdJ7zpYym8KTJ_RPQUBV_JXR-N0-DuI03NYQIB_3HukA>
    <xme:QpiYZ1RPn_fFAiA2qcYI1QByt6nmVMa5_w1ca3eFxbK_-YauElXSjmPt6YbTSqClC
    hDD6MWdf1oIvb4ifw>
X-ME-Received: <xmr:QpiYZ_WW6oBmQakFH-4n8grfoB4UJgFvs3vDxaPyn6dIcEYwcf3qgJ9WP86mEPUMnqfICMk4GC4PEtLRyEaMAAsspBSQ7a-dOMfmv5wkahs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehieehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeejffelleeftedvffegteeglefhteejudeuhffh
    veeivdfgjedvteelgeelhefgfeenucffohhmrghinhepghhnuhdrohhrghenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
    pdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:Q5iYZ3jQQYx65LVhur6ZLvMqmvEQIjxur6ZGzbIVcRphSMQQCr7IKA>
    <xmx:Q5iYZ3BXNVTmxpuyClNjpqtOWnOHYeg7qXckrvWvdT7nNJv_A00kpQ>
    <xmx:Q5iYZwJ3awMBLVSbiMeDkOlUTEORYfSwwCwlu-VRq9SwwjhUbaJflg>
    <xmx:Q5iYZ2AJI-Y_jjI1DTcA2DRQ8mcBQF6R9uduLTCAnF8GE2b7LNjaUg>
    <xmx:Q5iYZ-P6toa6sDlKd7Am5aHDG8bxtiVagDoYSu_Z4AO1nWI_IfMUYGDD>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:41:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id adcc4ffb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:41:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:41:34 +0100
Subject: [PATCH v4 08/10] compat/zlib: allow use of zlib-ng as backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250128-b4-pks-compat-drop-uncompress2-v4-8-129bc36ae8f5@pks.im>
References: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
In-Reply-To: <20250128-b4-pks-compat-drop-uncompress2-v4-0-129bc36ae8f5@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Karthik Nayak <karthik.188@gmail.com>
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
 Makefile             | 20 +++++++++++++++-----
 compat/zlib-compat.h | 36 ++++++++++++++++++++++++++++++------
 meson.build          | 21 +++++++++++++++++----
 meson_options.txt    |  2 ++
 4 files changed, 64 insertions(+), 15 deletions(-)

diff --git a/Makefile b/Makefile
index 86c6c3d7ad..1853e6ddfa 100644
--- a/Makefile
+++ b/Makefile
@@ -183,7 +183,8 @@ include shared.mak
 # byte-order mark (BOM) when writing UTF-16 or UTF-32 and always writes in
 # big-endian format.
 #
-# Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
+# Define NO_DEFLATE_BOUND if your zlib does not have deflateBound. Define
+# ZLIB_NG if you want to use zlib-ng instead of zlib.
 #
 # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
 # as the compiler can crash (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
@@ -1687,11 +1688,20 @@ else
 endif
 IMAP_SEND_LDFLAGS += $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
 
-ifdef ZLIB_PATH
-	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
-	EXTLIBS += $(call libpath_template,$(ZLIB_PATH)/$(lib))
+ifdef ZLIB_NG
+	BASIC_CFLAGS += -DHAVE_ZLIB_NG
+	ifdef ZLIB_NG_PATH
+		BASIC_CFLAGS += -I$(ZLIB_NG_PATH)/include
+		EXTLIBS += $(call libpath_template,$(ZLIB_NG_PATH)/$(lib))
+	endif
+	EXTLIBS += -lz-ng
+else
+	ifdef ZLIB_PATH
+		BASIC_CFLAGS += -I$(ZLIB_PATH)/include
+		EXTLIBS += $(call libpath_template,$(ZLIB_PATH)/$(lib))
+	endif
+	EXTLIBS += -lz
 endif
-EXTLIBS += -lz
 
 ifndef NO_OPENSSL
 	OPENSSL_LIBSSL = -lssl
diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index 6226b30c0c..0c60e3af33 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -1,11 +1,34 @@
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
+
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
 
 /*
  * zlib only gained support for setting up the gzip header in v1.2.2.1. In
@@ -13,7 +36,7 @@
  * operating systems, so it's fine to simply make this a no-op when using a
  * zlib version that doesn't support this yet.
  */
-#if ZLIB_VERNUM < 0x1221
+# if ZLIB_VERNUM < 0x1221
 struct gz_header_s {
 	int os;
 };
@@ -24,6 +47,7 @@ static int deflateSetHeader(z_streamp strm, struct gz_header_s *head)
 	(void)(head);
 	return Z_OK;
 }
-#endif
+# endif
+#endif /* HAVE_ZLIB_NG */
 
 #endif /* COMPAT_ZLIB_H */
diff --git a/meson.build b/meson.build
index 12129a8b95..f9e6a051e0 100644
--- a/meson.build
+++ b/meson.build
@@ -792,11 +792,23 @@ else
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
@@ -2001,4 +2013,5 @@ summary({
   'sha1': sha1_backend,
   'sha1_unsafe': sha1_unsafe_backend,
   'sha256': sha256_backend,
+  'zlib': zlib_backend,
 }, section: 'Backends')
diff --git a/meson_options.txt b/meson_options.txt
index 5429022f30..c962c0a676 100644
--- a/meson_options.txt
+++ b/meson_options.txt
@@ -57,6 +57,8 @@ option('sha1_unsafe_backend', type: 'combo', choices: ['openssl', 'block', 'Comm
   description: 'The backend used for hashing data with the SHA1 object format in case no cryptographic security is needed.')
 option('sha256_backend', type: 'combo', choices: ['openssl', 'nettle', 'gcrypt', 'block'], value: 'block',
   description: 'The backend used for hashing objects with the SHA256 object format.')
+option('zlib_backend', type: 'combo', choices: ['auto', 'zlib', 'zlib-ng'], value: 'auto',
+  description: 'The backend used for compressing objects and other data.')
 
 # Build tweaks.
 option('macos_use_homebrew_gettext', type: 'boolean', value: true,

-- 
2.48.1.362.g079036d154.dirty

