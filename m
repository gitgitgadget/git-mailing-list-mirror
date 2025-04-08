Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC92690EC
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107861; cv=none; b=DC9q1czP3zBOG5oT48FVHQCPHate+hVZS+EdyBkbLk7e2bIuJ0rSRMXQNqIs8oXUtBmoasNTFZdIFZpXuXoOM6z7DiP+E3C5Yj67NsqyoXF7Wf5PfErdTxdSbLNwscjgBeTvNVxUdsqKAf0op7fQZdJDe/14hxsgxsZuY7PaMYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107861; c=relaxed/simple;
	bh=nidu1DIQ2Mgi1bhTCaX2P5np7yq+2yqCUD7Oqb5EYrw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IeLzlyTCQY/me2Qb3R1v9l+Hi6L/HPsvWoz/B+Hs2HMozTbe+zTsspVFERCrhu4G709yl4l3rv7mqVeWNjgBTUOuBFmat9DwbF29HyDhj6c6KroKi1LvKu+LizVPZBWotYkp0A7nylI5Hz8C10I2TcmzFm++D8R2tSzKdDOmZtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jat/aUDy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VdDTfWNE; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jat/aUDy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VdDTfWNE"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 431D81380170
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:24:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 08 Apr 2025 06:24:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744107857;
	 x=1744194257; bh=xeImIqK4v8f3NSQtc/QrK0m/0HpDRhmrfJ+cjrRH4Ek=; b=
	Jat/aUDyTrFoZwwxWVma2fQEN/Vih9G69h6sYSM5kD3HwctwIbaLy3nN4Z09fhQs
	fySNJy8NZZ2vsQKMgzR1SJW4RBL65NBFdmhdK3Ic5cyeVywAGLM7hejw+ttaAfJk
	l6WKhP//GX7d2wUO6RUFSMUGsUxk4IX3ZT92jwrq5A1sv8OcQlCMTBNceuDh8yDs
	M/vYdxUyPtQUa8w2jYNpFkNDSHwrRkS9Zdi10yG+Ca4PPHKi7HeiNfsAo+IDkj5Y
	RpQLPIpWgerGBrWfxchIjTf2hgRF8TDEN40yJJ5M6lrPStnWIQwcnJXEr9bWi94K
	Z8PwbmQuuR6TTgk29C5uHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744107857; x=
	1744194257; bh=xeImIqK4v8f3NSQtc/QrK0m/0HpDRhmrfJ+cjrRH4Ek=; b=V
	dDTfWNEYCcg2/zYbJpzDwIx07FkuYQ6Uhpngqqty65dUCgg5jIverVYlH4cvcKpC
	V4qhXOHSVhLO++DFu+ZT5Eun0ATbNf/uPfpKkk17hijq6TTMk2yRepyKHbpPTYP4
	mKQ1cR/24r7SmelSu5Scje8WaO1XwEL1u3kYORTNw06u+bRB4JX6nB1agxFn0A9Y
	wJypJR+S28lxxW9e7Gu6X/hc1UIzs/Q9xFdAn3uU80j5a8qABETiO/Aeq8eVRBpj
	ZxuqEflkwg7Ctmrp1ljABzLC5f+9+G+f6MxM62JrgqQBfRU3DwdwECUTGgr5ZCvV
	VRGlKiFyMxmMfRzv541hg==
X-ME-Sender: <xms:UPn0Z49Im8cmivElUXAZa0bY1z1UMjbwfg_W1hFGhnI4yK7qsiUiTA>
    <xme:UPn0Zwt7GK5XbyJ8TQI2pOy-V1gHX9h5Vu8gHD_pKUHxD6CsFSOsQ4ggoA8sz4ICD
    DXSJM80AAMEPLqKSw>
X-ME-Received: <xmr:UPn0Z-CdfA4dt85NA9XTOVQAvGrdUvbPf6Jenki1hb_keRQtI1zSGO_-r1YLEsnCjTqCpTqLsKlMYz3VYieNHl938J5LRmzfOexPt4P_vE386ChD2g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UPn0Z4fkSTA-VyeRbDZGV6KEP4nXNU63IyzScz00Z3ki_yHytU7GKQ>
    <xmx:UPn0Z9Nbf-2YcbMMRxYt-I7qmIbbAudv7dECNpE4BxuMLp0ej0J00w>
    <xmx:UPn0ZylHJK2ZVKN9rAvKBcgxV6W7KTb-AZKCMnkaISoNuwOzY3nouQ>
    <xmx:UPn0Z_uzyuqLLobn5dijHMjffFRVwwdpAMGWVIC_ZRpX1qIoYJvDCw>
    <xmx:Ufn0Zwo1zSDZ-9FWRNbo_42tEl6UtLvgIF4b888UUC_0Bj-aSuS0sQ-i>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 8 Apr 2025 06:24:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f2dc84f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 8 Apr 2025 10:24:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Apr 2025 12:24:10 +0200
Subject: [PATCH 2/9] object-file: move `git_open_cloexec()` to
 "compat/open.c"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-pks-split-object-file-v1-2-f1fd50191143@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
In-Reply-To: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 3fae20dc21b..8060c358b84 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -14,7 +14,6 @@
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
index 23b2c8560be..1a20c7fa072 100644
--- a/object-file.c
+++ b/object-file.c
@@ -834,33 +834,6 @@ int stream_object_signature(struct repository *r, const struct object_id *oid)
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
2.49.0.682.gc9b6a7b2b0.dirty

