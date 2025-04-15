Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02059288C99
	for <git@vger.kernel.org>; Tue, 15 Apr 2025 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709908; cv=none; b=G87HeQ6Q2JwQGalyRMe6zHoz9M4kjPYChTuVQhrIm3ZUC3b4gfhAnrIl2hS7DuQcEyydA5ozmPWmYtZw7a8KCS0d4QkbuPHN6AC086MH4ysdJRjWGV2E3A0U9mrObc03joTLAzDOeybtXqIkY+7MnEoS5an/eHS7oKpd2ZDkbc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709908; c=relaxed/simple;
	bh=7XbTae2TMNFqr4iy3EsC+gE9WZn6fx6pTjehhRInWkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HAjhrrHW4BCq+Zck5PL5diAqfLVVva7TAJVOy66U5UTPLFdzN9K+mLT5ZFlAYmKSvpR/r8/2JSCi2dY+Lwx8LWl+wtClMAb6vYCD2YNVGzKAYP2cMKqIx4A8Uz0wIDiKvQfkXFaRssS4biNMU6JlamMxP5cmDUNOPJ27kLe3N0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ersJg9ft; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BLfEUT96; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ersJg9ft";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BLfEUT96"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 026FC2540370;
	Tue, 15 Apr 2025 05:38:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 15 Apr 2025 05:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744709903;
	 x=1744796303; bh=EMuckOE+1qgD0CxTZwT9ga7zO2AhJ/xW2ctz0YrCuLE=; b=
	ersJg9ftSknqhLfXbeZYNmhsFGtZwOGAy9LY7YLRlUnYNKpfOuFMTXnWSbFBBkfx
	f4I8/Ijmv75XLxRzJNS2o1F5UmeArVFFlsCUATvPnCvlAt5LZpoGmV1CMzatjLjN
	mB3YDZFa+BrwTz0slStQvrgtjH+yaM2CuPOUdjKr/wpRBzOG7mNaKXtR9u5ZolMK
	WvfVmQpisbux+RJNlxBZFgJ8w1ReZDjQBXRED9PCYdS9xrgXwr2Vm8Mv7MlNseBa
	/VpvY1M2/rvjJ0gbTwh80OYNiMlvE2ZcZ4WfnaFqRwrgEWyqDDjwHwOrYsjWCHcL
	2pN5uCmttE4XxqoDc9CpBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744709903; x=
	1744796303; bh=EMuckOE+1qgD0CxTZwT9ga7zO2AhJ/xW2ctz0YrCuLE=; b=B
	LfEUT96dcUgiZHfui6XBKMXCBWfvHdy5M21ZawXVYfSRm+FHxalJi9RPeqpsyn87
	IdDdjNF15UmygXN3/OWkdjz+iXrSQtkmHbBsFglWrB3GOX+KgvxAoV634rLrrtrm
	Br2QsJ3Qt8SAtyG2RwoZo+OF7sJRzy2Y3jpu+Me+2YTwBXaTqfhD7HAu/9b8XEGd
	KXEwpwEquP3y2AEYEReBC8tPXyWItNhkaW4i66RvUj98BaB1IZydOOsJxnw+bVyM
	gcoBrBhoD8vdM6GJ2oooCWuMDPfWT+TGhp1A3Voqb1JuGgkjJqkD7LV/TJSN5TDf
	tl964fyzKUrnvmRzVnSjA==
X-ME-Sender: <xms:Dyn-Z9x-sBvAYTgHrLqo8PFqJPxzgD-alI1Qn_NL9IFzbBLeaGy-vQ>
    <xme:Dyn-Z9TH5V6K9oYDyCdeT0ReB7rv8FxAUwSTzNVOnBECJqA17jMnuASVNdSG5k0zq
    b0gduDOS_-WR-CNdQ>
X-ME-Received: <xmr:Dyn-Z3XlLuBXTinpsBSy9xb4Gs5bSG7JGSgIAS9GqK5yC4xrEFl8gP9EAuoBAHZD2XVw1FQWxyul_G4swLYelFf0LV24LPjOwO4EU1j9rl4mtQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtg
    hordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:Dyn-Z_g83tixZRFOCVy-PryeIOzqI3xkyFOcpbul7JT7A--L7kB0NA>
    <xmx:Dyn-Z_CJSoLzJMloYqrishhkyX_jBLTER_MwtYJHiW01HJmdEsC7ow>
    <xmx:Dyn-Z4L30DuJFn0_jG09CkLAcf2RfQzZFlkOcurxzpEomw4DxApD_w>
    <xmx:Dyn-Z-C_zZClelRi90YpFbwJwT5qQYdztTsYqo-bOZZT_L7MpFmXCg>
    <xmx:Dyn-Z3607XoPpg9KMHQoHc1gFS6L2neR0_Oa-uhrV1eCfcIf83C5PfyI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Apr 2025 05:38:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 33453498 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Apr 2025 09:38:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 15 Apr 2025 11:38:16 +0200
Subject: [PATCH v3 03/10] object-file: move `git_open_cloexec()` to
 "compat/open.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250415-pks-split-object-file-v3-3-6aa7db7ad7b0@pks.im>
References: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
In-Reply-To: <20250415-pks-split-object-file-v3-0-6aa7db7ad7b0@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, 
 Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The `git_open_cloexec()` wrapper function provides the ability to open a
file with `O_CLOEXEC` in a platform-agnostic way. This function is
provided by "object-file.c" even though it is not specific to the object
subsystem at all.

Move the file into "compat/open.c". This file already exists before this
commit, but has only been compiled conditionally depending on whether or
not open(3p) may return EINTR. With this change we now unconditionally
compile the object, but wrap `git_open_with_retry()` in an ifdef.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile          |  2 +-
 commit-graph.c    |  1 -
 compat/open.c     | 29 +++++++++++++++++++++++++++++
 git-compat-util.h |  3 +++
 meson.build       |  1 +
 midx.c            |  1 -
 object-file.c     | 27 ---------------------------
 object-file.h     |  3 ---
 pack-bitmap.c     |  1 -
 pack-mtimes.c     |  1 -
 pack-revindex.c   |  1 -
 11 files changed, 34 insertions(+), 36 deletions(-)

diff --git a/Makefile b/Makefile
index c41fc41ef0e..bb5407b4703 100644
--- a/Makefile
+++ b/Makefile
@@ -994,6 +994,7 @@ LIB_OBJS += common-exit.o
 LIB_OBJS += common-init.o
 LIB_OBJS += compat/nonblock.o
 LIB_OBJS += compat/obstack.o
+LIB_OBJS += compat/open.o
 LIB_OBJS += compat/terminal.o
 LIB_OBJS += compiler-tricks/not-constant.o
 LIB_OBJS += config.o
@@ -1812,7 +1813,6 @@ ifdef FREAD_READS_DIRECTORIES
 endif
 ifdef OPEN_RETURNS_EINTR
 	COMPAT_CFLAGS += -DOPEN_RETURNS_EINTR
-	COMPAT_OBJS += compat/open.o
 endif
 ifdef NO_SYMLINK_HEAD
 	BASIC_CFLAGS += -DNO_SYMLINK_HEAD
diff --git a/commit-graph.c b/commit-graph.c
index 3b5bae00af9..9621c454972 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -13,7 +13,6 @@
 #include "refs.h"
 #include "hash-lookup.h"
 #include "commit-graph.h"
-#include "object-file.h"
 #include "object-store-ll.h"
 #include "oid-array.h"
 #include "path.h"
diff --git a/compat/open.c b/compat/open.c
index eb3754a23b8..37ae2b1aeb9 100644
--- a/compat/open.c
+++ b/compat/open.c
@@ -1,5 +1,6 @@
 #include "git-compat-util.h"
 
+#ifdef OPEN_RETURNS_EINTR
 #undef open
 int git_open_with_retry(const char *path, int flags, ...)
 {
@@ -23,3 +24,31 @@ int git_open_with_retry(const char *path, int flags, ...)
 
 	return ret;
 }
+#endif
+
+int git_open_cloexec(const char *name, int flags)
+{
+	int fd;
+	static int o_cloexec = O_CLOEXEC;
+
+	fd = open(name, flags | o_cloexec);
+	if ((o_cloexec & O_CLOEXEC) && fd < 0 && errno == EINVAL) {
+		/* Try again w/o O_CLOEXEC: the kernel might not support it */
+		o_cloexec &= ~O_CLOEXEC;
+		fd = open(name, flags | o_cloexec);
+	}
+
+#if defined(F_GETFD) && defined(F_SETFD) && defined(FD_CLOEXEC)
+	{
+		static int fd_cloexec = FD_CLOEXEC;
+
+		if (!o_cloexec && 0 <= fd && fd_cloexec) {
+			/* Opened w/o O_CLOEXEC?  try with fcntl(2) to add it */
+			int flags = fcntl(fd, F_GETFD);
+			if (fcntl(fd, F_SETFD, flags | fd_cloexec))
+				fd_cloexec = 0;
+		}
+	}
+#endif
+	return fd;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index cf733b38acd..9273a8ee087 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1000,6 +1000,9 @@ int git_vsnprintf(char *str, size_t maxsize,
 int git_open_with_retry(const char *path, int flag, ...);
 #endif
 
+int git_open_cloexec(const char *name, int flags);
+#define git_open(name) git_open_cloexec(name, O_RDONLY)
+
 #ifdef __GLIBC_PREREQ
 #if __GLIBC_PREREQ(2, 1)
 #define HAVE_STRCHRNUL
diff --git a/meson.build b/meson.build
index 145d2f7ff9e..a55e800b85b 100644
--- a/meson.build
+++ b/meson.build
@@ -263,6 +263,7 @@ libgit_sources = [
   'common-init.c',
   'compat/nonblock.c',
   'compat/obstack.c',
+  'compat/open.c',
   'compat/terminal.c',
   'compiler-tricks/not-constant.c',
   'config.c',
diff --git a/midx.c b/midx.c
index 807fdf72f7b..3d0015f7828 100644
--- a/midx.c
+++ b/midx.c
@@ -5,7 +5,6 @@
 #include "dir.h"
 #include "hex.h"
 #include "packfile.h"
-#include "object-file.h"
 #include "hash-lookup.h"
 #include "midx.h"
 #include "progress.h"
diff --git a/object-file.c b/object-file.c
index 6228e1c40f8..c3e20417f3f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -833,33 +833,6 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
 	return !oideq(oid, &real_oid) ? -1 : 0;
 }
 
-int git_open_cloexec(const char *name, int flags)
-{
-	int fd;
-	static int o_cloexec = O_CLOEXEC;
-
-	fd = open(name, flags | o_cloexec);
-	if ((o_cloexec & O_CLOEXEC) && fd < 0 && errno == EINVAL) {
-		/* Try again w/o O_CLOEXEC: the kernel might not support it */
-		o_cloexec &= ~O_CLOEXEC;
-		fd = open(name, flags | o_cloexec);
-	}
-
-#if defined(F_GETFD) && defined(F_SETFD) && defined(FD_CLOEXEC)
-	{
-		static int fd_cloexec = FD_CLOEXEC;
-
-		if (!o_cloexec && 0 <= fd && fd_cloexec) {
-			/* Opened w/o O_CLOEXEC?  try with fcntl(2) to add it */
-			int flags = fcntl(fd, F_GETFD);
-			if (fcntl(fd, F_SETFD, flags | fd_cloexec))
-				fd_cloexec = 0;
-		}
-	}
-#endif
-	return fd;
-}
-
 /*
  * Find "oid" as a loose object in the local repository or in an alternate.
  * Returns 0 on success, negative on failure.
diff --git a/object-file.h b/object-file.h
index 922f2bba8c9..353d8a85c33 100644
--- a/object-file.h
+++ b/object-file.h
@@ -21,9 +21,6 @@ extern int fetch_if_missing;
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
-int git_open_cloexec(const char *name, int flags);
-#define git_open(name) git_open_cloexec(name, O_RDONLY)
-
 /**
  * unpack_loose_header() initializes the data stream needed to unpack
  * a loose object header.
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 7fd78c634ef..0dbd7c4ffe1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -17,7 +17,6 @@
 #include "packfile.h"
 #include "repository.h"
 #include "trace2.h"
-#include "object-file.h"
 #include "object-store-ll.h"
 #include "list-objects-filter-options.h"
 #include "midx.h"
diff --git a/pack-mtimes.c b/pack-mtimes.c
index cdf30b8d2b0..bcea28e521d 100644
--- a/pack-mtimes.c
+++ b/pack-mtimes.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-mtimes.h"
-#include "object-file.h"
 #include "object-store-ll.h"
 #include "packfile.h"
 #include "strbuf.h"
diff --git a/pack-revindex.c b/pack-revindex.c
index 038e0c96b1c..1ee7b49e206 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -1,7 +1,6 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "pack-revindex.h"
-#include "object-file.h"
 #include "object-store-ll.h"
 #include "packfile.h"
 #include "strbuf.h"

-- 
2.49.0.805.g082f7c87e0.dirty

