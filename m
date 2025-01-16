Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102F21DB362
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 09:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737019051; cv=none; b=MjcONApdJXqTFyoE5K54JfWKEUFaaDRhT3VUcLgrJHal+94owzjNRJ9FYs+rvN/fSJi9pxDJMD3IDmEP4lEZEhxBXZm7zmfHpOkbKrel0W/0lIrfsoBqQDnh/+tvTp4g58R2Yqv/brApHW1wKbeW2f6KdCRt1ZJSAQP76t3ubc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737019051; c=relaxed/simple;
	bh=2jkIW9mhfaJCiWQ7tE3T3XTKuymJPazqdtK3UQxShH0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U71waybeD3AsUlEDIdwHKO22RZUIhjvXHWlpPzgDtbdINGY8/Ql2Js+H1S6a+AvSHL1MBC3nke3VGn02EXMfuQGq78M5wCopwXmUBLYVVF4o/mw4dZEJWiv/1ed853O8FqSbQtkcj0OQpN2SkVjFslWfiaRJCN0EeLINgUj5UXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oHIxq83S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xjk5JzX3; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oHIxq83S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xjk5JzX3"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F7E72540175;
	Thu, 16 Jan 2025 04:17:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 16 Jan 2025 04:17:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737019048;
	 x=1737105448; bh=N6vZuPRuRlvg2mH4nO4m1fHCXA66INLNBUg54sv0f+g=; b=
	oHIxq83SOtqsVoCEvtQh316uy19gM7uuXh2U86F1yTvqO9gQqLcFNTWpOSUGnQwR
	oLQvrdeqrf17JaNO2F0kHnuQWA9hbz/PDk0aVnpfGmLfkAPxaZhB2FMRKR7fDm4u
	IkUgnbE4vtSQxxhorFwqGf4m7tkCVS7aWU//Pqb5ee1f5jTUKthAoyDi+WCXTkyr
	y9Na/oMQWqq7ICL1+2QaE7yO4kQe6/7aIzFZ5cWB1/zAPn/EFQDTfTU05CIuNPzN
	qz8mLdayaiAEu7uJluH5g/EIvUnObXvxxQdWuL/415x0USRwStRbK5EscUHr3ipv
	Uvj3Z4yAPDcijYyZZp2siw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1737019048; x=
	1737105448; bh=N6vZuPRuRlvg2mH4nO4m1fHCXA66INLNBUg54sv0f+g=; b=X
	jk5JzX3pzoZ+z2ZwRqzhRwb940zvI/HxSh57gNreRzkkKfPfhcurBRsrLYCesZ8v
	9+DNld+h4OLMX7ge+dS3MoQnZSa3uBJlFinTvCa9PogEuuESso5lZjrIqfoXilsq
	r8Vx/xwhHnxXXkKgbAW9M4IR5gu895V7MDWlpjmK4f0FQDCqvaMd2XiMpdRc/5bG
	+MSWSgKFhE7DPTmz7XG90wNF5I+A9aD6LEd7zoRKFyxXDccPz73W+wSczi9ojug7
	HP6Q23C22pFmt+a14KouH5hdbsV8LkpFZRLGjR5KMtcTlSSVdI+1T7HssvF0skEL
	Ml4lMGTg5KePiC7Zmx9LA==
X-ME-Sender: <xms:qM6IZ5NsT3Mq7JjMpRKQpFJGd4E7Zgg2uYpsXtLzlfYUp9sfICFrOA>
    <xme:qM6IZ79o102V5LJIXPauVoRnucNPmSoTFkIB3GWh4gU_4W0R-pX-ND28udZ8p77lZ
    Dr28RILf1-_GycHrw>
X-ME-Received: <xmr:qM6IZ4SLR9YTokbpty6FlwpgD92ZN2RF01uBh52q-qEcOo5KkNzndAx62OWTyxJsnC3ajdxGy2rGVZhr1TIWdw8gRky476ubZhkNpG0KS-ZExeo91A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeiuddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejffelleeftedvffegteeglefhteejudeuhffhveei
    vdfgjedvteelgeelhefgfeenucffohhmrghinhepghhnuhdrohhrghenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrth
    hhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:qM6IZ1trYt6SKZBlmxnUvyaO-TGlaR89pjj4DAMHFxpCqSjU3W3yzw>
    <xmx:qM6IZxc8gzpeMrFeVGDSGywYo9TvAcY6gBZ1AsMZvhyA5AUgf3nDbA>
    <xmx:qM6IZx3c96lA2Br91zFKRm-L3A0AQ3LU_pXyHWjPV88f-jR4SiRZFQ>
    <xmx:qM6IZ99XpJHB6l_Bq60S2Sh0yMqKP5eJPJElZ5xeqQ4oCcdJa1_qIQ>
    <xmx:qM6IZ17IgpPmHJkAazYTymhZqYwDVfyQhCfAu0P8fBuBVmPgJQUbQH8_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jan 2025 04:17:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4441dd47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jan 2025 09:17:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jan 2025 10:17:21 +0100
Subject: [PATCH v3 08/10] compat/zlib: allow use of zlib-ng as backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250116-b4-pks-compat-drop-uncompress2-v3-8-f2af1f5c4a06@pks.im>
References: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
In-Reply-To: <20250116-b4-pks-compat-drop-uncompress2-v3-0-f2af1f5c4a06@pks.im>
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
index 2690bfce41..58e53927b2 100644
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
2.48.0.257.gd3603152ad.dirty

