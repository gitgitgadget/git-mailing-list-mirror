Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7F822DC3A
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855876; cv=none; b=NksbjK/DcBH7lU75YsdnX4jO7llyTDXwLEL20R+6MFGphRUaN94PtKg1hyxERx3tK1bHRTNOVjtFquTBPNtcfgsKVTL8pdRRL1AsUv9wxkUXyxpLhVoBtCwanuqbX/evj8QjzfOZeIHQtgogK5hk8d/jn2XmElAfcAbt9eGKbSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855876; c=relaxed/simple;
	bh=9kXh41K8vHLxMwYVdpVOrZ+vOP7TBScaCvP8Pwb1J1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFad4lMxNF5RKjmGlWgujDQLOlbpOGk3mxx5ynClkJd5EQmqQrIxRa9Gq1+3Pw2y/pRgkSXdOcUma+Tpg3A82dvXHUGlnT6bQnDLPeGL9wnhDUP0W2peSA5P4skfXIs58/HrEKAaOjmP9C0qZDK1GLZoml8tzASD8RvkFVUiiRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sestsnVy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s1klN+fO; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sestsnVy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s1klN+fO"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C9A8B1380389;
	Tue, 14 Jan 2025 06:57:53 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 14 Jan 2025 06:57:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855873;
	 x=1736942273; bh=mEuKSjOU/EtBgynUAotbDS4ov/HmmmHnplOMBXaMYag=; b=
	sestsnVys8RL0x+kIuwsCRdf3ugQNZ4vLCXPJV2JjctMsNPX5H5greKj4qcqxoVZ
	XS+d6XoBMVrcjZ/t1/YWpEH9A3Fqxv7YyD7/CxYDJ8R3w5toYjYy+TUmqnjwYCTm
	8XmBDWyFOtqTs6eqAREthQu95SftwZLRgvPgG8kMpN6k+LTvYp1aMwIR55fQDEBv
	zvlUp2pQ+3l5CAUDARjr+GPOmmSaOBd3WJFdxq4rcpJBIjk4l6gr74jnzTHsT1BT
	hxJInzPxBdRRTY5dvHj2ccA2ORPn+zk9+FhISD0Q37BkQrBs3MGpOY5QEz4lHfBs
	KqvtvLkR4+0EVXUYOM3BIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855873; x=
	1736942273; bh=mEuKSjOU/EtBgynUAotbDS4ov/HmmmHnplOMBXaMYag=; b=s
	1klN+fOw7OdT7ST3Fjd+mm7BQV9l0bqoQdGwt1HR9FD+HJnHePR2llDusnuAtQSn
	B83vl65B6Suvhq+GXFrrXBxoqaaalCOmSy6hgDKik9AnfGVBQK+V0OcdcakP/0vR
	4ViLGFpYjaQwb/UB3+xuSLfNcQhHI8jStkp2bryJUNMjwpwkC7rDZrYZ4MVXY/CF
	u0vzyo+KJGk3c4P6JFK0/4Y1qMJEAD9tacny6eRD2D8Ts2hmZkCbucZb3Z40h45F
	ubGLMvaDxYS2covQW6wN5nPA1xsYkxfeMnUg64CpnpV1jIH3BlvkEIUhfn9/X20J
	g9KM3CHcK8cpFt9XtzT2w==
X-ME-Sender: <xms:QVGGZxsvlIQ-ZuUBdRjZqbZsn7FFvuLcEfcD9KxCSvdWPQBt2u0WKA>
    <xme:QVGGZ6dsRLSf4o6PvjBSUyMjhY_cid9cuAFQCkFUqUWZi_z8aUrb5VGyq2FqWBVkc
    P28iooRoyHxYqXWNA>
X-ME-Received: <xmr:QVGGZ0ylFC4kdhTbjKYP-R0TBnB9zuUOQ_d3ea1TvAM3b7Ik8WQkjYgb-Y5pV6F7n5qxNaY9TOg83BYHLhpyInkU4N9Lcf0NZe7xV3uBl3WmJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjeffleelfe
    etvdffgeetgeelhfetjeduuefhhfeviedvgfejvdetleegleehgfefnecuffhomhgrihhn
    pehgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:QVGGZ4MVQLo8gI5j_PjN7HbLLlRPnjfLz3k6ufSXOVqqz2W3FmpoTg>
    <xmx:QVGGZx-fpItPiLxjODDblvhFMGBdy9u6pTcwb5ZumpZvuGdKNRgznQ>
    <xmx:QVGGZ4U2iG9ucZLsFh4lAp9TaOfzRQ6mznZfllDlMPWE6--dzfv7Ig>
    <xmx:QVGGZydGNOl3OG6zV5kAOglDul2El2ejuKye5SYDV_5cuSXj7XYRVw>
    <xmx:QVGGZzLRUjzgnooWlT51Ioj4CGpAk4x3JezxxWGKsOvZQnRLhB_Ee_Rm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:57:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 583ec1e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:57:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 14 Jan 2025 12:57:49 +0100
Subject: [PATCH v2 08/10] compat/zlib: allow use of zlib-ng as backend
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250114-b4-pks-compat-drop-uncompress2-v2-8-614a2158e34e@pks.im>
References: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
In-Reply-To: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
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
index 86c6c3d7adfb8b0b52afeaafa3cc3c2a141e2f63..1853e6ddfafbc243d449b62410c003d00f555e0e 100644
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
index e6a0397c25db5875526f8723d5630584b2c2cf8e..3e31648dc171d7149c296941591eb94516ca6c93 100644
--- a/meson.build
+++ b/meson.build
@@ -785,11 +785,23 @@ else
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
@@ -1992,4 +2004,5 @@ summary({
   'sha1': sha1_backend,
   'sha1_unsafe': sha1_unsafe_backend,
   'sha256': sha256_backend,
+  'zlib': zlib_backend,
 }, section: 'Backends')
diff --git a/meson_options.txt b/meson_options.txt
index 5429022f30621105cd6974e4260cca60e5f24324..c962c0a676172ed478333b9e56d1430ff9cf0af0 100644
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

