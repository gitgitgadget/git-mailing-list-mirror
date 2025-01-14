Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DF82361C1
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855868; cv=none; b=Q3Kx1vcC/MivfZvMpt3v8guduVyg5sCXJZWcdHQTxtgk18d0AMDxYug08YDq6m21w/Syr93WtpVf3CpQGUHUpbFVZi9Q27xzIr0Y6+E60NvhwHm35xuHkxD8N2pXz8xyZG9QBIfJcKr1DBzk52H5AIiSqosQEHWB0GD+tJtM9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855868; c=relaxed/simple;
	bh=K1+pOoigXJ5XVk+7cCDoNp/NLPcslUdrxXhncr0Q00I=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=cJvuJ4D+lTobn+K6D+Kvt79nK5CfQGJsapwuRVpzyDXYkblOumpSpTNz7wZr0xypbALjG7cTp9dtUlhUnGV0nE2z2xwgBKl/1nKxd4GbtSr2l7MnpgFzzaw2HENtBICprSiUrZIkRx2uQguAUt1OycG4QpkHULXlsZENtDsSXY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QLo/w8XQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Uj3d9KVq; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QLo/w8XQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Uj3d9KVq"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0B62A11400A6;
	Tue, 14 Jan 2025 06:57:46 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Jan 2025 06:57:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855866;
	 x=1736942266; bh=udOZH8RUnd8Aa9KUkZrIZ2fIMZC6Q5nW9Pfe0d8WGqc=; b=
	QLo/w8XQES4D1y8jlM/XpNPS3p2erX2NANci83zyC0tNORD8aQJmFeCVVEmddWMW
	aveeqzrLQ34BsSMtfXJWwioluFYzRi07BVCAqAFG2SnmL7pUhJnSAw1oy4ujAzPQ
	JRAVzVOmNMMIt4xqNKQzlVcfTY3CpWhII7JDHrXZomXE7VqAJlUu+neT4xDmpSUM
	2M7Cv2JS/HvXw+6eKsmMW1CHKvJQhvCwz36v8is3mtNAJDn+U1pihR55T0lWfRyx
	pX40DQpnJDs01sjq2X81IUcnmh3Sp4jyCdYdc3eZFPyHIB3trsBoU6Ebz7WRxBEV
	/ExfQNB8Dymtp8tz33DnVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855866; x=
	1736942266; bh=udOZH8RUnd8Aa9KUkZrIZ2fIMZC6Q5nW9Pfe0d8WGqc=; b=U
	j3d9KVqGHMlAwB+9+a5XRgipenxyFToLgwcRgyRowpNvv3IceheUA6kA0O4L+pW6
	UGnWbhKosssz28pBN79xwnrfNcOZYJyKprHW9oQ+mycdIZ91ACkWGT93s8kh6Jbg
	i0KUDJFASNL5zfGrCYboPauj13CSDG9/NPY8XAK/ONG9VVEPEcohvzUhIZMq0O8l
	ajMKO//py+qe+3QWPCtDttnZ4kTCfmecVeTuR4EuzEw63RO1H83EyWLYgIbJgzWw
	piOKPgxplbKs90C70V0jF1rmJjNkCWfeRdyjFjO1i5UZH/vJaaddHciL8MPXmA6H
	/aR1jnTBPwXkvGuL3ZD1g==
X-ME-Sender: <xms:OVGGZ4MxnofrIxsSELM5j5msF9n5EYNNBDHLwBLXMF2FoiSq40_JSg>
    <xme:OVGGZ-_ikGUtn3SWhrDLJpjeW-6Mplf34iAO_yfxp55NQ0-i_Zx_Opnlo2Q4J2MrK
    OBsYOYMxgVUAPQEhQ>
X-ME-Received: <xmr:OVGGZ_SxR9jQcoFK34pxuQOXtbb3ZeAckwIzkWVMFMyTzGqWvdkg6edScYcyKREpiucxiw93p9Y_2kZ_fMNByd0B42GeEQoiNomxiivIZ9LBHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhufffkf
    ggtgfgjghfvfevofesthekredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjeevueejgf
    evueejkeegvedutdfguddtkeelkeekleekvdethfeggeffgeevteeunecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghdpghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    pedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:OVGGZwtpO2o6bCUf-6bFpjfYL7DhuFLMNeJGSH2Cs1ZzlO4-31k0Ig>
    <xmx:OVGGZwdgEzghHrKxuvM-C9XBVEmTmksmzPqxI2TOr57noYfD80s33g>
    <xmx:OVGGZ03J4GHO19Zwjl7cVIiCsU4gV4DTzHGLA2kaWEsmXSPSYt6zSQ>
    <xmx:OVGGZ091Km1gbgH1DYBp_AAfh1Picvv_uZoO4FyX9PAvxHsXwHb8_g>
    <xmx:OlGGZxrH8TnRjVw0yJbwreLHc_JewpSOBRmKkQtG1pEYcS85XQcZ2d8q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:57:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8d0ed06d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:57:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/10] compat/zlib: allow use of zlib-ng as backend
Date: Tue, 14 Jan 2025 12:57:41 +0100
Message-Id: <20250114-b4-pks-compat-drop-uncompress2-v2-0-614a2158e34e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIADVRhmcC/42NQQ6CMBBFr0Jm7Zh2bDW48h6GBbRVJgZKOthoC
 He3cAKX7+Xn/QUkJA4C12qBFDILx7EAHSpwfTs+A7IvDKTIKq0Vdganl6CLw9TO6FOc8D1ulII
 IYehsrY2xtTsRlEjRD/7sB/emcM8yx/Td/7Le7N/prFFhfbZeKaL2YvytrI88QLOu6w+uFKrCy
 QAAAA==
X-Change-ID: 20250110-b4-pks-compat-drop-uncompress2-eb5914459c32
In-Reply-To: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.2

Hi,

I have recently started to play around with zlib-ng a bit, which is a
hard fork of the zlib library. It describes itself as zlib replacement
with optimizations for "next generation" systems. As such, it contains
several implementations of central algorithms using for example SSE2,
AVX2 and other vectorized CPU intrinsics that supposedly speed up in-
and deflating data.

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

This patch series refactors how we wire up zlib in our project by
introducing a new "compat/zlib.h" header function. This header is then
later extended to patch over the differences between zlib and zlib-ng,
which is mostly just that zlib-ng has a `zng_` prefix for each of its
symbols. Like this, we can support both libraries directly, and a new
Meson build options allows users to pick whichever backend they like.

In theory, these changes shouldn't be necessary because zlib-ng provides
a compatibility layer that make it directly compatible with zlib. But
most distros don't allow you to install zlib-ng with that layer is it
would mean that zlib would need to be replaced globally. Instead, they
typically only provide a version of zlib-ng that only has the `zng_`
prefixed symbols.

Given the observed speedup I do think that this is a worthwhile change
so that users (or especially hosting providers) can easily switch to
zlib-ng without impacting the rest of their system.

Changes in v2:
  - Wire up zlib-ng in our Makefile.
  - Exercise zlib-ng via CI by adapting our "linux-musl" job to use
    Meson and installing zlib-ng.
  - Link to v1: https://lore.kernel.org/r/20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im

The series is built on top of fbe8d3079d (Git 2.48, 2025-01-10) with
ps/meson-weak-sha1-build at 6a0ee54f9a (meson: provide a summary of
configured backends, 2024-12-30) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (10):
      compat: drop `uncompress2()` compatibility shim
      git-compat-util: drop `z_const` define
      compat: introduce new "zlib.h" header
      git-compat-util: move include of "compat/zlib.h" into "git-zlib.h"
      compat/zlib: provide `deflateBound()` shim centrally
      compat/zlib: provide stubs for `deflateSetHeader()`
      git-zlib: cast away potential constness of `next_in` pointer
      compat/zlib: allow use of zlib-ng as backend
      ci: switch linux-musl to use Meson
      ci: make "linux-musl" job use zlib-ng

 .github/workflows/main.yml |  2 +-
 .gitlab-ci.yml             |  2 +-
 Makefile                   | 21 +++++++---
 archive-tar.c              |  4 --
 archive.c                  |  1 +
 ci/install-dependencies.sh |  4 +-
 ci/lib.sh                  |  5 +--
 ci/run-build-and-tests.sh  |  3 +-
 compat/zlib-compat.h       | 47 +++++++++++++++++++++++
 compat/zlib-uncompress2.c  | 96 ----------------------------------------------
 config.c                   |  1 +
 csum-file.c                |  3 +-
 environment.c              |  1 +
 git-compat-util.h          | 12 ------
 git-zlib.c                 |  6 +--
 git-zlib.h                 |  2 +
 meson.build                | 24 +++++++++---
 meson_options.txt          |  4 ++
 reftable/block.c           |  1 -
 reftable/system.h          |  1 +
 20 files changed, 100 insertions(+), 140 deletions(-)

Range-diff versus v1:

 1:  5f650c2a6b =  1:  0d442c86cf compat: drop `uncompress2()` compatibility shim
 2:  a94c26ad03 =  2:  9fb474c07a git-compat-util: drop `z_const` define
 3:  4431647ede =  3:  d732ab51ca compat: introduce new "zlib.h" header
 4:  bbca17dfb5 =  4:  b261f9ebcd git-compat-util: move include of "compat/zlib.h" into "git-zlib.h"
 5:  d5315531d8 =  5:  8fa63dc02c compat/zlib: provide `deflateBound()` shim centrally
 6:  27691c395f =  6:  851c90ea6a compat/zlib: provide stubs for `deflateSetHeader()`
 7:  5c47ab5f9b =  7:  54d4a95753 git-zlib: cast away potential constness of `next_in` pointer
 8:  9826f57665 !  8:  e260c57b2e compat/zlib: allow use of zlib-ng as backend
    @@ Commit message
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## Makefile ##
    +@@ Makefile: include shared.mak
    + # byte-order mark (BOM) when writing UTF-16 or UTF-32 and always writes in
    + # big-endian format.
    + #
    +-# Define NO_DEFLATE_BOUND if your zlib does not have deflateBound.
    ++# Define NO_DEFLATE_BOUND if your zlib does not have deflateBound. Define
    ++# ZLIB_NG if you want to use zlib-ng instead of zlib.
    + #
    + # Define NO_NORETURN if using buggy versions of gcc 4.6+ and profile feedback,
    + # as the compiler can crash (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=49299)
    +@@ Makefile: else
    + endif
    + IMAP_SEND_LDFLAGS += $(OPENSSL_LINK) $(OPENSSL_LIBSSL) $(LIB_4_CRYPTO)
    + 
    +-ifdef ZLIB_PATH
    +-	BASIC_CFLAGS += -I$(ZLIB_PATH)/include
    +-	EXTLIBS += $(call libpath_template,$(ZLIB_PATH)/$(lib))
    ++ifdef ZLIB_NG
    ++	BASIC_CFLAGS += -DHAVE_ZLIB_NG
    ++	ifdef ZLIB_NG_PATH
    ++		BASIC_CFLAGS += -I$(ZLIB_NG_PATH)/include
    ++		EXTLIBS += $(call libpath_template,$(ZLIB_NG_PATH)/$(lib))
    ++	endif
    ++	EXTLIBS += -lz-ng
    ++else
    ++	ifdef ZLIB_PATH
    ++		BASIC_CFLAGS += -I$(ZLIB_PATH)/include
    ++		EXTLIBS += $(call libpath_template,$(ZLIB_PATH)/$(lib))
    ++	endif
    ++	EXTLIBS += -lz
    + endif
    +-EXTLIBS += -lz
    + 
    + ifndef NO_OPENSSL
    + 	OPENSSL_LIBSSL = -lssl
    +
      ## compat/zlib-compat.h ##
     @@
      #ifndef COMPAT_ZLIB_H
 -:  ---------- >  9:  7ae8f413d4 ci: switch linux-musl to use Meson
 -:  ---------- > 10:  2dd1b49e4f ci: make "linux-musl" job use zlib-ng

---
base-commit: b2da7775f8b064ef54920eb0f2e60c7f6df8f995
change-id: 20250110-b4-pks-compat-drop-uncompress2-eb5914459c32

