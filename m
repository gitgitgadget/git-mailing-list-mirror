Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDBD29898B
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744363808; cv=none; b=RQa2yXdMiUQ3wQJww43jLhjLs7aaEay+Hl1BwE35eEaxn2vE+ujsn7OriiDcRwRFUibFoymYf1gbaZgQf7gx9SkO6XDGE2TgLzft7QvHSOd5TuUkUnGTYX8Ily/ut92hL88sBEUDvQUB5L9foiZky/G/4hF6RtnryOMX6MfSVpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744363808; c=relaxed/simple;
	bh=rK3m8l8n1Y7ey+gPFZL/H4XrK06aIbI5bIQyiEl+mj4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T/eaP/NJEe/yFimdA6MLTe0e33lEI554WUsMr/GH/clX/6w5jOyu9CGR5mc42TqfHO02/9XxkkyvAfQVwWhNN3KyBk/2/UZ1ofiZ0UAMdvDQP9/dInGdDgDXRqYTxRIKNJwJnX5dr4CaMXCU1yzMXlT29nDW47F0j9ZQgz/a7IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aD0gF3T8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pH+8csqi; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aD0gF3T8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pH+8csqi"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E30011402D0;
	Fri, 11 Apr 2025 05:30:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 11 Apr 2025 05:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744363803;
	 x=1744450203; bh=qEw2rQGwuVqmkNo3Mcg39Kcyq2VyENlMGybsPqz6lO4=; b=
	aD0gF3T8Yo5V5w6mx9c16EGr9SK4R16lNne4iTnYWJbLBfDWFiTnXwmh56/xSWe1
	IIrTS5MMzNzA4z0QbLQMfKjBKV0fQpH3CDcgAp7yJ4SY+vq7DhG7gG6XOMkA1FUV
	AE1fHamFjtBTO7gcCoNhFzjr2GGUvv33Tl3LTrR2gNtO3RF09ZpkQruvHkTiawWy
	QDESAr3zHYnlT3SYJrCRfnotYsM9hrHWcePUMcOuu+49o9Nc0ES477sfFdMh1ru4
	VRU7AoLvQM80udKlCQmUkZI+8Jcv08s1MWSrTVh+MThaY6Qzn9mhUETWwWN8OoNG
	Q+dyiEgbo45X6WGpJLwqXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744363803; x=
	1744450203; bh=qEw2rQGwuVqmkNo3Mcg39Kcyq2VyENlMGybsPqz6lO4=; b=p
	H+8csqinVYWfCkyXc9M0X8zAH9cRXI4sb4up0CsHhFT3m3lYTxbAL3svfTdCUzrV
	C+YqDyzs+8rd1PSGVyXl+UoApwkmnOVt1b52qftzYQuo4P4gxy3MQa2M3mYl7Bex
	tTF2O5mzj41H7Ux7KOmKQsbNu3o2zah8LqSiXSValDhz8nIBthS86VpJMafWY4Sr
	68opp3x40kL4dtzbtdVNcKdLJCtiLujhM/8ZKN4p8BZnCkEkCWpr0KoLhq7ZFGFb
	wBm3eKvmYMRaT8vjH6EpAxvdja6xWw/feJF/84Qx7r146cfoKtDdTKzYtVfssT4r
	+QQLjjCg91JUpOCAl3Iiw==
X-ME-Sender: <xms:G-H4Z0t8-2_SF_HUrOMFlkGqN4xf6PjtBUoD2Aeoq_E9wkPFcC5i3w>
    <xme:G-H4Zxdq2YbYObSlte0mCwosx5kESsXQMT8DvT_HRMufghUj0NRncgZm8zSQ7RvaB
    oriJ-4sXTXbuxikuw>
X-ME-Received: <xmr:G-H4Z_wtd3aPTNOfA9mHADOLOC0ufHGjFH_NTJzNbTYQvPACD5H5G2Ef395bMCtAhw2NiEOBXzm8z5uZE6Ge_BYWkkSZcrx_ALwvQlnwDJy2Cj8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvuddugeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeefueevuedvuedugeeiveettdduheelgfelvddu
    veeljeetfeejjeefkefhhedtueenucffohhmrghinheptgefqdhmvghsohhnrdgsuhhilh
    gupdhprggtkhgvugdrihhsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpe
    hsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgt
    phhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:G-H4Z3NoQrU8t-Ig66ktOG9b2zZf27r72i7Wd-VMyIchK9-9ElIzGw>
    <xmx:G-H4Z0-PZReWYCXFdIYh9G-MsQ13Cj__urDwMiWybzURvAwttV8lnQ>
    <xmx:G-H4Z_WauVSWWDe8QJ8hERZa_aygbfHy6F_Z66ZQ3fEGOPMJcBlobA>
    <xmx:G-H4Z9epuJbqwVbBxeJ8sw8hLTOCQuDWJUifp3iTDlMiJMbdFAGVhw>
    <xmx:G-H4Z5K4TgQA0UIT4GYInDUmM40PV0nQt9tGtfa9f20Qrw98np12kJ6R>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Apr 2025 05:30:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 83854c69 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 11 Apr 2025 09:30:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 11 Apr 2025 11:29:53 +0200
Subject: [PATCH v2 4/9] object-file: split out functions relating to object
 store subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250411-pks-split-object-file-v2-4-2bea0c9033ae@pks.im>
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
In-Reply-To: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

While we have the "object-store.h" header, most of the functionality for
object stores is actually hosted in "object-file.c". This makes it hard
to find relevant functions and causes us to mix up concerns.

Split out functions relating to the object store subsystem into a new
"object-store.c" file.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                 |   1 +
 builtin/checkout.c       |   1 +
 builtin/merge-file.c     |   1 +
 builtin/mktree.c         |   1 +
 builtin/notes.c          |   1 +
 builtin/receive-pack.c   |   1 +
 builtin/tag.c            |   1 +
 builtin/unpack-file.c    |   1 +
 builtin/unpack-objects.c |   1 +
 commit.c                 |   1 +
 http-push.c              |   1 +
 match-trees.c            |   3 +-
 merge-ort.c              |   3 +-
 meson.build              |   1 +
 notes-cache.c            |   3 +-
 notes.c                  |   3 +-
 object-file.c            | 991 +----------------------------------------------
 object-file.h            |  68 +++-
 object-store-ll.h        |  60 +--
 object-store.c           | 972 ++++++++++++++++++++++++++++++++++++++++++++++
 20 files changed, 1074 insertions(+), 1041 deletions(-)

diff --git a/Makefile b/Makefile
index bb5407b4703..d8ad76fb791 100644
--- a/Makefile
+++ b/Makefile
@@ -1086,6 +1086,7 @@ LIB_OBJS += notes.o
 LIB_OBJS += object-file-convert.o
 LIB_OBJS += object-file.o
 LIB_OBJS += object-name.o
+LIB_OBJS += object-store.o
 LIB_OBJS += object.o
 LIB_OBJS += oid-array.o
 LIB_OBJS += oidmap.o
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2e7486cf658..3e68623838a 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -18,6 +18,7 @@
 #include "lockfile.h"
 #include "mem-pool.h"
 #include "merge-recursive.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "parse-options.h"
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 7e315f374b2..2b16b10d2ca 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -5,6 +5,7 @@
 #include "abspath.h"
 #include "diff.h"
 #include "hex.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store.h"
 #include "config.h"
diff --git a/builtin/mktree.c b/builtin/mktree.c
index 3c16faa40e3..0644f951161 100644
--- a/builtin/mktree.c
+++ b/builtin/mktree.c
@@ -11,6 +11,7 @@
 #include "strbuf.h"
 #include "tree.h"
 #include "parse-options.h"
+#include "object-file.h"
 #include "object-store-ll.h"
 
 static struct treeent {
diff --git a/builtin/notes.c b/builtin/notes.c
index ff61ec5f2da..0dbc233752d 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -14,6 +14,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "notes.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "path.h"
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b3e2a9d0c60..ee51bd76f60 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -31,6 +31,7 @@
 #include "tmp-objdir.h"
 #include "oidset.h"
 #include "packfile.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "path.h"
diff --git a/builtin/tag.c b/builtin/tag.c
index 7c173535cb3..536a01ff3ae 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -17,6 +17,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "refs.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store-ll.h"
 #include "path.h"
diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index fb5fcbc40a8..b19e5cabd03 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "config.h"
 #include "hex.h"
+#include "object-file.h"
 #include "object-name.h"
 #include "object-store-ll.h"
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 3bbcaf2de9b..4078eab9252 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -8,6 +8,7 @@
 #include "gettext.h"
 #include "git-zlib.h"
 #include "hex.h"
+#include "object-file.h"
 #include "object-store-ll.h"
 #include "object.h"
 #include "delta.h"
diff --git a/commit.c b/commit.c
index 48aeefaad31..fbf4f8e87fd 100644
--- a/commit.c
+++ b/commit.c
@@ -29,6 +29,7 @@
 #include "tree.h"
 #include "hook.h"
 #include "parse.h"
+#include "object-file.h"
 #include "object-file-convert.h"
 
 static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
diff --git a/http-push.c b/http-push.c
index 1b030d96f48..806eb67cf1b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -19,6 +19,7 @@
 #include "tree-walk.h"
 #include "url.h"
 #include "packfile.h"
+#include "object-file.h"
 #include "object-store-ll.h"
 #include "commit-reach.h"
 
diff --git a/match-trees.c b/match-trees.c
index ef14ceb594c..72922d5d64e 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -6,7 +6,8 @@
 #include "strbuf.h"
 #include "tree.h"
 #include "tree-walk.h"
-#include "object-store-ll.h"
+#include "object-file.h"
+#include "object-store.h"
 #include "repository.h"
 
 static int score_missing(unsigned mode)
diff --git a/merge-ort.c b/merge-ort.c
index 1554900d984..5de3e2fc159 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -36,8 +36,9 @@
 #include "merge-ll.h"
 #include "match-trees.h"
 #include "mem-pool.h"
+#include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "oid-array.h"
 #include "path.h"
 #include "promisor-remote.h"
diff --git a/meson.build b/meson.build
index a55e800b85b..f656f978020 100644
--- a/meson.build
+++ b/meson.build
@@ -355,6 +355,7 @@ libgit_sources = [
   'object-file-convert.c',
   'object-file.c',
   'object-name.c',
+  'object-store.c',
   'object.c',
   'oid-array.c',
   'oidmap.c',
diff --git a/notes-cache.c b/notes-cache.c
index ecfdf6e43b5..150241b15e0 100644
--- a/notes-cache.c
+++ b/notes-cache.c
@@ -2,7 +2,8 @@
 
 #include "git-compat-util.h"
 #include "notes-cache.h"
-#include "object-store-ll.h"
+#include "object-file.h"
+#include "object-store.h"
 #include "pretty.h"
 #include "repository.h"
 #include "commit.h"
diff --git a/notes.c b/notes.c
index ce5a1006a83..d9645c4b5dc 100644
--- a/notes.c
+++ b/notes.c
@@ -6,8 +6,9 @@
 #include "environment.h"
 #include "hex.h"
 #include "notes.h"
+#include "object-file.h"
 #include "object-name.h"
-#include "object-store-ll.h"
+#include "object-store.h"
 #include "utf8.h"
 #include "strbuf.h"
 #include "tree-walk.h"
diff --git a/object-file.c b/object-file.c
index ea2ed7628e6..1c74aa239fb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -11,75 +11,26 @@
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
-#include "abspath.h"
-#include "config.h"
+#include "bulk-checkin.h"
 #include "convert.h"
 #include "environment.h"
+#include "fsck.h"
 #include "gettext.h"
 #include "hex.h"
-#include "string-list.h"
-#include "lockfile.h"
-#include "pack.h"
-#include "commit.h"
-#include "run-command.h"
-#include "refs.h"
-#include "bulk-checkin.h"
-#include "repository.h"
-#include "replace-object.h"
-#include "streaming.h"
-#include "dir.h"
-#include "list.h"
-#include "quote.h"
-#include "packfile.h"
+#include "loose.h"
+#include "object-file-convert.h"
 #include "object-file.h"
 #include "object-store.h"
 #include "oidtree.h"
+#include "pack.h"
+#include "packfile.h"
 #include "path.h"
-#include "promisor-remote.h"
 #include "setup.h"
-#include "submodule.h"
-#include "fsck.h"
-#include "loose.h"
-#include "object-file-convert.h"
+#include "streaming.h"
 
 /* The maximum size for an object header. */
 #define MAX_HEADER_LEN 32
 
-/*
- * This is meant to hold a *small* number of objects that you would
- * want repo_read_object_file() to be able to return, but yet you do not want
- * to write them into the object store (e.g. a browse-only
- * application).
- */
-static struct cached_object_entry {
-	struct object_id oid;
-	struct cached_object {
-		enum object_type type;
-		const void *buf;
-		unsigned long size;
-	} value;
-} *cached_objects;
-static int cached_object_nr, cached_object_alloc;
-
-static const struct cached_object *find_cached_object(const struct object_id *oid)
-{
-	static const struct cached_object empty_tree = {
-		.type = OBJ_TREE,
-		.buf = "",
-	};
-	int i;
-	const struct cached_object_entry *co = cached_objects;
-
-	for (i = 0; i < cached_object_nr; i++, co++) {
-		if (oideq(&co->oid, oid))
-			return &co->value;
-	}
-	if (oideq(oid, the_hash_algo->empty_tree))
-		return &empty_tree;
-	return NULL;
-}
-
-
 static int get_conv_flags(unsigned flags)
 {
 	if (flags & HASH_RENORMALIZE)
@@ -90,40 +41,6 @@ static int get_conv_flags(unsigned flags)
 		return 0;
 }
 
-
-int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
-{
-	int fd;
-	/*
-	 * we let the umask do its job, don't try to be more
-	 * restrictive except to remove write permission.
-	 */
-	int mode = 0444;
-	repo_git_path_replace(the_repository, temp_filename, "objects/%s", pattern);
-	fd = git_mkstemp_mode(temp_filename->buf, mode);
-	if (0 <= fd)
-		return fd;
-
-	/* slow path */
-	/* some mkstemp implementations erase temp_filename on failure */
-	repo_git_path_replace(the_repository, temp_filename, "objects/%s", pattern);
-	safe_create_leading_directories(temp_filename->buf);
-	return xmkstemp_mode(temp_filename->buf, mode);
-}
-
-int odb_pack_keep(const char *name)
-{
-	int fd;
-
-	fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
-	if (0 <= fd)
-		return fd;
-
-	/* slow path */
-	safe_create_leading_directories_const(name);
-	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
-}
-
 static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
 {
 	int i;
@@ -137,9 +54,9 @@ static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
 	}
 }
 
-static const char *odb_loose_path(struct object_directory *odb,
-				  struct strbuf *buf,
-				  const struct object_id *oid)
+const char *odb_loose_path(struct object_directory *odb,
+			   struct strbuf *buf,
+			   const struct object_id *oid)
 {
 	strbuf_reset(buf);
 	strbuf_addstr(buf, odb->path);
@@ -148,513 +65,6 @@ static const char *odb_loose_path(struct object_directory *odb,
 	return buf->buf;
 }
 
-const char *loose_object_path(struct repository *r, struct strbuf *buf,
-			      const struct object_id *oid)
-{
-	return odb_loose_path(r->objects->odb, buf, oid);
-}
-
-/*
- * Return non-zero iff the path is usable as an alternate object database.
- */
-static int alt_odb_usable(struct raw_object_store *o,
-			  struct strbuf *path,
-			  const char *normalized_objdir, khiter_t *pos)
-{
-	int r;
-
-	/* Detect cases where alternate disappeared */
-	if (!is_directory(path->buf)) {
-		error(_("object directory %s does not exist; "
-			"check .git/objects/info/alternates"),
-		      path->buf);
-		return 0;
-	}
-
-	/*
-	 * Prevent the common mistake of listing the same
-	 * thing twice, or object directory itself.
-	 */
-	if (!o->odb_by_path) {
-		khiter_t p;
-
-		o->odb_by_path = kh_init_odb_path_map();
-		assert(!o->odb->next);
-		p = kh_put_odb_path_map(o->odb_by_path, o->odb->path, &r);
-		assert(r == 1); /* never used */
-		kh_value(o->odb_by_path, p) = o->odb;
-	}
-	if (fspatheq(path->buf, normalized_objdir))
-		return 0;
-	*pos = kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
-	/* r: 0 = exists, 1 = never used, 2 = deleted */
-	return r == 0 ? 0 : 1;
-}
-
-/*
- * Prepare alternate object database registry.
- *
- * The variable alt_odb_list points at the list of struct
- * object_directory.  The elements on this list come from
- * non-empty elements from colon separated ALTERNATE_DB_ENVIRONMENT
- * environment variable, and $GIT_OBJECT_DIRECTORY/info/alternates,
- * whose contents is similar to that environment variable but can be
- * LF separated.  Its base points at a statically allocated buffer that
- * contains "/the/directory/corresponding/to/.git/objects/...", while
- * its name points just after the slash at the end of ".git/objects/"
- * in the example above, and has enough space to hold all hex characters
- * of the object ID, an extra slash for the first level indirection, and
- * the terminating NUL.
- */
-static void read_info_alternates(struct repository *r,
-				 const char *relative_base,
-				 int depth);
-static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
-	const char *relative_base, int depth, const char *normalized_objdir)
-{
-	struct object_directory *ent;
-	struct strbuf pathbuf = STRBUF_INIT;
-	struct strbuf tmp = STRBUF_INIT;
-	khiter_t pos;
-	int ret = -1;
-
-	if (!is_absolute_path(entry->buf) && relative_base) {
-		strbuf_realpath(&pathbuf, relative_base, 1);
-		strbuf_addch(&pathbuf, '/');
-	}
-	strbuf_addbuf(&pathbuf, entry);
-
-	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
-		error(_("unable to normalize alternate object path: %s"),
-		      pathbuf.buf);
-		goto error;
-	}
-	strbuf_swap(&pathbuf, &tmp);
-
-	/*
-	 * The trailing slash after the directory name is given by
-	 * this function at the end. Remove duplicates.
-	 */
-	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
-		strbuf_setlen(&pathbuf, pathbuf.len - 1);
-
-	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos))
-		goto error;
-
-	CALLOC_ARRAY(ent, 1);
-	/* pathbuf.buf is already in r->objects->odb_by_path */
-	ent->path = strbuf_detach(&pathbuf, NULL);
-
-	/* add the alternate entry */
-	*r->objects->odb_tail = ent;
-	r->objects->odb_tail = &(ent->next);
-	ent->next = NULL;
-	assert(r->objects->odb_by_path);
-	kh_value(r->objects->odb_by_path, pos) = ent;
-
-	/* recursively add alternates */
-	read_info_alternates(r, ent->path, depth + 1);
-	ret = 0;
- error:
-	strbuf_release(&tmp);
-	strbuf_release(&pathbuf);
-	return ret;
-}
-
-static const char *parse_alt_odb_entry(const char *string,
-				       int sep,
-				       struct strbuf *out)
-{
-	const char *end;
-
-	strbuf_reset(out);
-
-	if (*string == '#') {
-		/* comment; consume up to next separator */
-		end = strchrnul(string, sep);
-	} else if (*string == '"' && !unquote_c_style(out, string, &end)) {
-		/*
-		 * quoted path; unquote_c_style has copied the
-		 * data for us and set "end". Broken quoting (e.g.,
-		 * an entry that doesn't end with a quote) falls
-		 * back to the unquoted case below.
-		 */
-	} else {
-		/* normal, unquoted path */
-		end = strchrnul(string, sep);
-		strbuf_add(out, string, end - string);
-	}
-
-	if (*end)
-		end++;
-	return end;
-}
-
-static void link_alt_odb_entries(struct repository *r, const char *alt,
-				 int sep, const char *relative_base, int depth)
-{
-	struct strbuf objdirbuf = STRBUF_INIT;
-	struct strbuf entry = STRBUF_INIT;
-
-	if (!alt || !*alt)
-		return;
-
-	if (depth > 5) {
-		error(_("%s: ignoring alternate object stores, nesting too deep"),
-				relative_base);
-		return;
-	}
-
-	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
-
-	while (*alt) {
-		alt = parse_alt_odb_entry(alt, sep, &entry);
-		if (!entry.len)
-			continue;
-		link_alt_odb_entry(r, &entry,
-				   relative_base, depth, objdirbuf.buf);
-	}
-	strbuf_release(&entry);
-	strbuf_release(&objdirbuf);
-}
-
-static void read_info_alternates(struct repository *r,
-				 const char *relative_base,
-				 int depth)
-{
-	char *path;
-	struct strbuf buf = STRBUF_INIT;
-
-	path = xstrfmt("%s/info/alternates", relative_base);
-	if (strbuf_read_file(&buf, path, 1024) < 0) {
-		warn_on_fopen_errors(path);
-		free(path);
-		return;
-	}
-
-	link_alt_odb_entries(r, buf.buf, '\n', relative_base, depth);
-	strbuf_release(&buf);
-	free(path);
-}
-
-void add_to_alternates_file(const char *reference)
-{
-	struct lock_file lock = LOCK_INIT;
-	char *alts = repo_git_path(the_repository, "objects/info/alternates");
-	FILE *in, *out;
-	int found = 0;
-
-	hold_lock_file_for_update(&lock, alts, LOCK_DIE_ON_ERROR);
-	out = fdopen_lock_file(&lock, "w");
-	if (!out)
-		die_errno(_("unable to fdopen alternates lockfile"));
-
-	in = fopen(alts, "r");
-	if (in) {
-		struct strbuf line = STRBUF_INIT;
-
-		while (strbuf_getline(&line, in) != EOF) {
-			if (!strcmp(reference, line.buf)) {
-				found = 1;
-				break;
-			}
-			fprintf_or_die(out, "%s\n", line.buf);
-		}
-
-		strbuf_release(&line);
-		fclose(in);
-	}
-	else if (errno != ENOENT)
-		die_errno(_("unable to read alternates file"));
-
-	if (found) {
-		rollback_lock_file(&lock);
-	} else {
-		fprintf_or_die(out, "%s\n", reference);
-		if (commit_lock_file(&lock))
-			die_errno(_("unable to move new alternates file into place"));
-		if (the_repository->objects->loaded_alternates)
-			link_alt_odb_entries(the_repository, reference,
-					     '\n', NULL, 0);
-	}
-	free(alts);
-}
-
-void add_to_alternates_memory(const char *reference)
-{
-	/*
-	 * Make sure alternates are initialized, or else our entry may be
-	 * overwritten when they are.
-	 */
-	prepare_alt_odb(the_repository);
-
-	link_alt_odb_entries(the_repository, reference,
-			     '\n', NULL, 0);
-}
-
-struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy)
-{
-	struct object_directory *new_odb;
-
-	/*
-	 * Make sure alternates are initialized, or else our entry may be
-	 * overwritten when they are.
-	 */
-	prepare_alt_odb(the_repository);
-
-	/*
-	 * Make a new primary odb and link the old primary ODB in as an
-	 * alternate
-	 */
-	new_odb = xcalloc(1, sizeof(*new_odb));
-	new_odb->path = xstrdup(dir);
-
-	/*
-	 * Disable ref updates while a temporary odb is active, since
-	 * the objects in the database may roll back.
-	 */
-	new_odb->disable_ref_updates = 1;
-	new_odb->will_destroy = will_destroy;
-	new_odb->next = the_repository->objects->odb;
-	the_repository->objects->odb = new_odb;
-	return new_odb->next;
-}
-
-void restore_primary_odb(struct object_directory *restore_odb, const char *old_path)
-{
-	struct object_directory *cur_odb = the_repository->objects->odb;
-
-	if (strcmp(old_path, cur_odb->path))
-		BUG("expected %s as primary object store; found %s",
-		    old_path, cur_odb->path);
-
-	if (cur_odb->next != restore_odb)
-		BUG("we expect the old primary object store to be the first alternate");
-
-	the_repository->objects->odb = restore_odb;
-	free_object_directory(cur_odb);
-}
-
-/*
- * Compute the exact path an alternate is at and returns it. In case of
- * error NULL is returned and the human readable error is added to `err`
- * `path` may be relative and should point to $GIT_DIR.
- * `err` must not be null.
- */
-char *compute_alternate_path(const char *path, struct strbuf *err)
-{
-	char *ref_git = NULL;
-	const char *repo;
-	int seen_error = 0;
-
-	ref_git = real_pathdup(path, 0);
-	if (!ref_git) {
-		seen_error = 1;
-		strbuf_addf(err, _("path '%s' does not exist"), path);
-		goto out;
-	}
-
-	repo = read_gitfile(ref_git);
-	if (!repo)
-		repo = read_gitfile(mkpath("%s/.git", ref_git));
-	if (repo) {
-		free(ref_git);
-		ref_git = xstrdup(repo);
-	}
-
-	if (!repo && is_directory(mkpath("%s/.git/objects", ref_git))) {
-		char *ref_git_git = mkpathdup("%s/.git", ref_git);
-		free(ref_git);
-		ref_git = ref_git_git;
-	} else if (!is_directory(mkpath("%s/objects", ref_git))) {
-		struct strbuf sb = STRBUF_INIT;
-		seen_error = 1;
-		if (get_common_dir(&sb, ref_git)) {
-			strbuf_addf(err,
-				    _("reference repository '%s' as a linked "
-				      "checkout is not supported yet."),
-				    path);
-			goto out;
-		}
-
-		strbuf_addf(err, _("reference repository '%s' is not a "
-					"local repository."), path);
-		goto out;
-	}
-
-	if (!access(mkpath("%s/shallow", ref_git), F_OK)) {
-		strbuf_addf(err, _("reference repository '%s' is shallow"),
-			    path);
-		seen_error = 1;
-		goto out;
-	}
-
-	if (!access(mkpath("%s/info/grafts", ref_git), F_OK)) {
-		strbuf_addf(err,
-			    _("reference repository '%s' is grafted"),
-			    path);
-		seen_error = 1;
-		goto out;
-	}
-
-out:
-	if (seen_error) {
-		FREE_AND_NULL(ref_git);
-	}
-
-	return ref_git;
-}
-
-struct object_directory *find_odb(struct repository *r, const char *obj_dir)
-{
-	struct object_directory *odb;
-	char *obj_dir_real = real_pathdup(obj_dir, 1);
-	struct strbuf odb_path_real = STRBUF_INIT;
-
-	prepare_alt_odb(r);
-	for (odb = r->objects->odb; odb; odb = odb->next) {
-		strbuf_realpath(&odb_path_real, odb->path, 1);
-		if (!strcmp(obj_dir_real, odb_path_real.buf))
-			break;
-	}
-
-	free(obj_dir_real);
-	strbuf_release(&odb_path_real);
-
-	if (!odb)
-		die(_("could not find object directory matching %s"), obj_dir);
-	return odb;
-}
-
-static void fill_alternate_refs_command(struct child_process *cmd,
-					const char *repo_path)
-{
-	const char *value;
-
-	if (!git_config_get_value("core.alternateRefsCommand", &value)) {
-		cmd->use_shell = 1;
-
-		strvec_push(&cmd->args, value);
-		strvec_push(&cmd->args, repo_path);
-	} else {
-		cmd->git_cmd = 1;
-
-		strvec_pushf(&cmd->args, "--git-dir=%s", repo_path);
-		strvec_push(&cmd->args, "for-each-ref");
-		strvec_push(&cmd->args, "--format=%(objectname)");
-
-		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
-			strvec_push(&cmd->args, "--");
-			strvec_split(&cmd->args, value);
-		}
-	}
-
-	strvec_pushv(&cmd->env, (const char **)local_repo_env);
-	cmd->out = -1;
-}
-
-static void read_alternate_refs(const char *path,
-				alternate_ref_fn *cb,
-				void *data)
-{
-	struct child_process cmd = CHILD_PROCESS_INIT;
-	struct strbuf line = STRBUF_INIT;
-	FILE *fh;
-
-	fill_alternate_refs_command(&cmd, path);
-
-	if (start_command(&cmd))
-		return;
-
-	fh = xfdopen(cmd.out, "r");
-	while (strbuf_getline_lf(&line, fh) != EOF) {
-		struct object_id oid;
-		const char *p;
-
-		if (parse_oid_hex(line.buf, &oid, &p) || *p) {
-			warning(_("invalid line while parsing alternate refs: %s"),
-				line.buf);
-			break;
-		}
-
-		cb(&oid, data);
-	}
-
-	fclose(fh);
-	finish_command(&cmd);
-	strbuf_release(&line);
-}
-
-struct alternate_refs_data {
-	alternate_ref_fn *fn;
-	void *data;
-};
-
-static int refs_from_alternate_cb(struct object_directory *e,
-				  void *data)
-{
-	struct strbuf path = STRBUF_INIT;
-	size_t base_len;
-	struct alternate_refs_data *cb = data;
-
-	if (!strbuf_realpath(&path, e->path, 0))
-		goto out;
-	if (!strbuf_strip_suffix(&path, "/objects"))
-		goto out;
-	base_len = path.len;
-
-	/* Is this a git repository with refs? */
-	strbuf_addstr(&path, "/refs");
-	if (!is_directory(path.buf))
-		goto out;
-	strbuf_setlen(&path, base_len);
-
-	read_alternate_refs(path.buf, cb->fn, cb->data);
-
-out:
-	strbuf_release(&path);
-	return 0;
-}
-
-void for_each_alternate_ref(alternate_ref_fn fn, void *data)
-{
-	struct alternate_refs_data cb;
-	cb.fn = fn;
-	cb.data = data;
-	foreach_alt_odb(refs_from_alternate_cb, &cb);
-}
-
-int foreach_alt_odb(alt_odb_fn fn, void *cb)
-{
-	struct object_directory *ent;
-	int r = 0;
-
-	prepare_alt_odb(the_repository);
-	for (ent = the_repository->objects->odb->next; ent; ent = ent->next) {
-		r = fn(ent, cb);
-		if (r)
-			break;
-	}
-	return r;
-}
-
-void prepare_alt_odb(struct repository *r)
-{
-	if (r->objects->loaded_alternates)
-		return;
-
-	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
-
-	read_info_alternates(r, r->objects->odb->path, 0);
-	r->objects->loaded_alternates = 1;
-}
-
-int has_alt_odb(struct repository *r)
-{
-	prepare_alt_odb(r);
-	return !!r->objects->odb->next;
-}
-
 /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
 static int freshen_file(const char *fn)
 {
@@ -1056,9 +466,9 @@ int parse_loose_header(const char *hdr, struct object_info *oi)
 	return 0;
 }
 
-static int loose_object_info(struct repository *r,
-			     const struct object_id *oid,
-			     struct object_info *oi, int flags)
+int loose_object_info(struct repository *r,
+		      const struct object_id *oid,
+		      struct object_info *oi, int flags)
 {
 	int status = 0;
 	int fd;
@@ -1154,345 +564,6 @@ static int loose_object_info(struct repository *r,
 	return status;
 }
 
-int obj_read_use_lock = 0;
-pthread_mutex_t obj_read_mutex;
-
-void enable_obj_read_lock(void)
-{
-	if (obj_read_use_lock)
-		return;
-
-	obj_read_use_lock = 1;
-	init_recursive_mutex(&obj_read_mutex);
-}
-
-void disable_obj_read_lock(void)
-{
-	if (!obj_read_use_lock)
-		return;
-
-	obj_read_use_lock = 0;
-	pthread_mutex_destroy(&obj_read_mutex);
-}
-
-int fetch_if_missing = 1;
-
-static int do_oid_object_info_extended(struct repository *r,
-				       const struct object_id *oid,
-				       struct object_info *oi, unsigned flags)
-{
-	static struct object_info blank_oi = OBJECT_INFO_INIT;
-	const struct cached_object *co;
-	struct pack_entry e;
-	int rtype;
-	const struct object_id *real = oid;
-	int already_retried = 0;
-
-
-	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
-		real = lookup_replace_object(r, oid);
-
-	if (is_null_oid(real))
-		return -1;
-
-	if (!oi)
-		oi = &blank_oi;
-
-	co = find_cached_object(real);
-	if (co) {
-		if (oi->typep)
-			*(oi->typep) = co->type;
-		if (oi->sizep)
-			*(oi->sizep) = co->size;
-		if (oi->disk_sizep)
-			*(oi->disk_sizep) = 0;
-		if (oi->delta_base_oid)
-			oidclr(oi->delta_base_oid, the_repository->hash_algo);
-		if (oi->type_name)
-			strbuf_addstr(oi->type_name, type_name(co->type));
-		if (oi->contentp)
-			*oi->contentp = xmemdupz(co->buf, co->size);
-		oi->whence = OI_CACHED;
-		return 0;
-	}
-
-	while (1) {
-		if (find_pack_entry(r, real, &e))
-			break;
-
-		/* Most likely it's a loose object. */
-		if (!loose_object_info(r, real, oi, flags))
-			return 0;
-
-		/* Not a loose object; someone else may have just packed it. */
-		if (!(flags & OBJECT_INFO_QUICK)) {
-			reprepare_packed_git(r);
-			if (find_pack_entry(r, real, &e))
-				break;
-		}
-
-		/*
-		 * If r is the_repository, this might be an attempt at
-		 * accessing a submodule object as if it were in the_repository
-		 * (having called add_submodule_odb() on that submodule's ODB).
-		 * If any such ODBs exist, register them and try again.
-		 */
-		if (r == the_repository &&
-		    register_all_submodule_odb_as_alternates())
-			/* We added some alternates; retry */
-			continue;
-
-		/* Check if it is a missing object */
-		if (fetch_if_missing && repo_has_promisor_remote(r) &&
-		    !already_retried &&
-		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
-			promisor_remote_get_direct(r, real, 1);
-			already_retried = 1;
-			continue;
-		}
-
-		if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
-			const struct packed_git *p;
-			if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
-				die(_("replacement %s not found for %s"),
-				    oid_to_hex(real), oid_to_hex(oid));
-			if ((p = has_packed_and_bad(r, real)))
-				die(_("packed object %s (stored in %s) is corrupt"),
-				    oid_to_hex(real), p->pack_name);
-		}
-		return -1;
-	}
-
-	if (oi == &blank_oi)
-		/*
-		 * We know that the caller doesn't actually need the
-		 * information below, so return early.
-		 */
-		return 0;
-	rtype = packed_object_info(r, e.p, e.offset, oi);
-	if (rtype < 0) {
-		mark_bad_packed_object(e.p, real);
-		return do_oid_object_info_extended(r, real, oi, 0);
-	} else if (oi->whence == OI_PACKED) {
-		oi->u.packed.offset = e.offset;
-		oi->u.packed.pack = e.p;
-		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
-					 rtype == OBJ_OFS_DELTA);
-	}
-
-	return 0;
-}
-
-static int oid_object_info_convert(struct repository *r,
-				   const struct object_id *input_oid,
-				   struct object_info *input_oi, unsigned flags)
-{
-	const struct git_hash_algo *input_algo = &hash_algos[input_oid->algo];
-	int do_die = flags & OBJECT_INFO_DIE_IF_CORRUPT;
-	struct strbuf type_name = STRBUF_INIT;
-	struct object_id oid, delta_base_oid;
-	struct object_info new_oi, *oi;
-	unsigned long size;
-	void *content;
-	int ret;
-
-	if (repo_oid_to_algop(r, input_oid, the_hash_algo, &oid)) {
-		if (do_die)
-			die(_("missing mapping of %s to %s"),
-			    oid_to_hex(input_oid), the_hash_algo->name);
-		return -1;
-	}
-
-	/* Is new_oi needed? */
-	oi = input_oi;
-	if (input_oi && (input_oi->delta_base_oid || input_oi->sizep ||
-			 input_oi->contentp)) {
-		new_oi = *input_oi;
-		/* Does delta_base_oid need to be converted? */
-		if (input_oi->delta_base_oid)
-			new_oi.delta_base_oid = &delta_base_oid;
-		/* Will the attributes differ when converted? */
-		if (input_oi->sizep || input_oi->contentp) {
-			new_oi.contentp = &content;
-			new_oi.sizep = &size;
-			new_oi.type_name = &type_name;
-		}
-		oi = &new_oi;
-	}
-
-	ret = oid_object_info_extended(r, &oid, oi, flags);
-	if (ret)
-		return -1;
-	if (oi == input_oi)
-		return ret;
-
-	if (new_oi.contentp) {
-		struct strbuf outbuf = STRBUF_INIT;
-		enum object_type type;
-
-		type = type_from_string_gently(type_name.buf, type_name.len,
-					       !do_die);
-		if (type == -1)
-			return -1;
-		if (type != OBJ_BLOB) {
-			ret = convert_object_file(the_repository, &outbuf,
-						  the_hash_algo, input_algo,
-						  content, size, type, !do_die);
-			free(content);
-			if (ret == -1)
-				return -1;
-			size = outbuf.len;
-			content = strbuf_detach(&outbuf, NULL);
-		}
-		if (input_oi->sizep)
-			*input_oi->sizep = size;
-		if (input_oi->contentp)
-			*input_oi->contentp = content;
-		else
-			free(content);
-		if (input_oi->type_name)
-			*input_oi->type_name = type_name;
-		else
-			strbuf_release(&type_name);
-	}
-	if (new_oi.delta_base_oid == &delta_base_oid) {
-		if (repo_oid_to_algop(r, &delta_base_oid, input_algo,
-				 input_oi->delta_base_oid)) {
-			if (do_die)
-				die(_("missing mapping of %s to %s"),
-				    oid_to_hex(&delta_base_oid),
-				    input_algo->name);
-			return -1;
-		}
-	}
-	input_oi->whence = new_oi.whence;
-	input_oi->u = new_oi.u;
-	return ret;
-}
-
-int oid_object_info_extended(struct repository *r, const struct object_id *oid,
-			     struct object_info *oi, unsigned flags)
-{
-	int ret;
-
-	if (oid->algo && (hash_algo_by_ptr(r->hash_algo) != oid->algo))
-		return oid_object_info_convert(r, oid, oi, flags);
-
-	obj_read_lock();
-	ret = do_oid_object_info_extended(r, oid, oi, flags);
-	obj_read_unlock();
-	return ret;
-}
-
-
-/* returns enum object_type or negative */
-int oid_object_info(struct repository *r,
-		    const struct object_id *oid,
-		    unsigned long *sizep)
-{
-	enum object_type type;
-	struct object_info oi = OBJECT_INFO_INIT;
-
-	oi.typep = &type;
-	oi.sizep = sizep;
-	if (oid_object_info_extended(r, oid, &oi,
-				      OBJECT_INFO_LOOKUP_REPLACE) < 0)
-		return -1;
-	return type;
-}
-
-int pretend_object_file(void *buf, unsigned long len, enum object_type type,
-			struct object_id *oid)
-{
-	struct cached_object_entry *co;
-	char *co_buf;
-
-	hash_object_file(the_hash_algo, buf, len, type, oid);
-	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
-	    find_cached_object(oid))
-		return 0;
-	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
-	co = &cached_objects[cached_object_nr++];
-	co->value.size = len;
-	co->value.type = type;
-	co_buf = xmalloc(len);
-	memcpy(co_buf, buf, len);
-	co->value.buf = co_buf;
-	oidcpy(&co->oid, oid);
-	return 0;
-}
-
-/*
- * This function dies on corrupt objects; the callers who want to
- * deal with them should arrange to call oid_object_info_extended() and give
- * error messages themselves.
- */
-void *repo_read_object_file(struct repository *r,
-			    const struct object_id *oid,
-			    enum object_type *type,
-			    unsigned long *size)
-{
-	struct object_info oi = OBJECT_INFO_INIT;
-	unsigned flags = OBJECT_INFO_DIE_IF_CORRUPT | OBJECT_INFO_LOOKUP_REPLACE;
-	void *data;
-
-	oi.typep = type;
-	oi.sizep = size;
-	oi.contentp = &data;
-	if (oid_object_info_extended(r, oid, &oi, flags))
-		return NULL;
-
-	return data;
-}
-
-void *read_object_with_reference(struct repository *r,
-				 const struct object_id *oid,
-				 enum object_type required_type,
-				 unsigned long *size,
-				 struct object_id *actual_oid_return)
-{
-	enum object_type type;
-	void *buffer;
-	unsigned long isize;
-	struct object_id actual_oid;
-
-	oidcpy(&actual_oid, oid);
-	while (1) {
-		int ref_length = -1;
-		const char *ref_type = NULL;
-
-		buffer = repo_read_object_file(r, &actual_oid, &type, &isize);
-		if (!buffer)
-			return NULL;
-		if (type == required_type) {
-			*size = isize;
-			if (actual_oid_return)
-				oidcpy(actual_oid_return, &actual_oid);
-			return buffer;
-		}
-		/* Handle references */
-		else if (type == OBJ_COMMIT)
-			ref_type = "tree ";
-		else if (type == OBJ_TAG)
-			ref_type = "object ";
-		else {
-			free(buffer);
-			return NULL;
-		}
-		ref_length = strlen(ref_type);
-
-		if (ref_length + the_hash_algo->hexsz > isize ||
-		    memcmp(buffer, ref_type, ref_length) ||
-		    get_oid_hex((char *) buffer + ref_length, &actual_oid)) {
-			free(buffer);
-			return NULL;
-		}
-		free(buffer);
-		/* Now we have the ID of the referred-to object in
-		 * actual_oid.  Check again. */
-	}
-}
-
 static void hash_object_body(const struct git_hash_algo *algo, struct git_hash_ctx *c,
 			     const void *buf, unsigned long len,
 			     struct object_id *oid,
@@ -2154,32 +1225,6 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	return ret;
 }
 
-int has_object(struct repository *r, const struct object_id *oid,
-	       unsigned flags)
-{
-	int quick = !(flags & HAS_OBJECT_RECHECK_PACKED);
-	unsigned object_info_flags = OBJECT_INFO_SKIP_FETCH_OBJECT |
-		(quick ? OBJECT_INFO_QUICK : 0);
-
-	if (!startup_info->have_repository)
-		return 0;
-	return oid_object_info_extended(r, oid, NULL, object_info_flags) >= 0;
-}
-
-int repo_has_object_file_with_flags(struct repository *r,
-				    const struct object_id *oid, int flags)
-{
-	if (!startup_info->have_repository)
-		return 0;
-	return oid_object_info_extended(r, oid, NULL, flags) >= 0;
-}
-
-int repo_has_object_file(struct repository *r,
-			 const struct object_id *oid)
-{
-	return repo_has_object_file_with_flags(r, oid, 0);
-}
-
 /*
  * We can't use the normal fsck_error_function() for index_mem(),
  * because we don't yet have a valid oid for it to report. Instead,
@@ -2407,16 +1452,6 @@ int read_pack_header(int fd, struct pack_header *header)
 	return 0;
 }
 
-void assert_oid_type(const struct object_id *oid, enum object_type expect)
-{
-	enum object_type type = oid_object_info(the_repository, oid, NULL);
-	if (type < 0)
-		die(_("%s is not a valid object"), oid_to_hex(oid));
-	if (type != expect)
-		die(_("%s is not a valid '%s' object"), oid_to_hex(oid),
-		    type_name(expect));
-}
-
 int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 				struct strbuf *path,
 				each_loose_object_fn obj_cb,
diff --git a/object-file.h b/object-file.h
index 353d8a85c33..78c84d970a9 100644
--- a/object-file.h
+++ b/object-file.h
@@ -21,6 +21,29 @@ extern int fetch_if_missing;
 int index_fd(struct index_state *istate, struct object_id *oid, int fd, struct stat *st, enum object_type type, const char *path, unsigned flags);
 int index_path(struct index_state *istate, struct object_id *oid, const char *path, struct stat *st, unsigned flags);
 
+struct object_directory;
+
+const char *odb_loose_path(struct object_directory *odb,
+			   struct strbuf *buf,
+			   const struct object_id *oid);
+
+/*
+ * Return true iff an alternate object database has a loose object
+ * with the specified name.  This function does not respect replace
+ * references.
+ */
+int has_loose_object_nonlocal(const struct object_id *);
+
+int has_loose_object(const struct object_id *);
+
+/**
+ * format_object_header() is a thin wrapper around s xsnprintf() that
+ * writes the initial "<type> <obj-len>" part of the loose object
+ * header. It returns the size that snprintf() returns + 1.
+ */
+int format_object_header(char *str, size_t size, enum object_type type,
+			 size_t objsize);
+
 /**
  * unpack_loose_header() initializes the data stream needed to unpack
  * a loose object header.
@@ -61,6 +84,29 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 struct object_info;
 int parse_loose_header(const char *hdr, struct object_info *oi);
 
+int write_object_file_flags(const void *buf, unsigned long len,
+			    enum object_type type, struct object_id *oid,
+			    struct object_id *comapt_oid_in, unsigned flags);
+static inline int write_object_file(const void *buf, unsigned long len,
+				    enum object_type type, struct object_id *oid)
+{
+	return write_object_file_flags(buf, len, type, oid, NULL, 0);
+}
+
+struct input_stream {
+	const void *(*read)(struct input_stream *, unsigned long *len);
+	void *data;
+	int is_finished;
+};
+
+int write_object_file_literally(const void *buf, unsigned long len,
+				const char *type, struct object_id *oid,
+				unsigned flags);
+int stream_loose_object(struct input_stream *in_stream, size_t len,
+			struct object_id *oid);
+
+int force_object_loose(const struct object_id *oid, time_t mtime);
+
 /**
  * With in-core object data in "buf", rehash it to make sure the
  * object name actually matches "oid" to detect object corruption.
@@ -79,6 +125,10 @@ int check_object_signature(struct repository *r, const struct object_id *oid,
  */
 int stream_object_signature(struct repository *r, const struct object_id *oid);
 
+int loose_object_info(struct repository *r,
+		      const struct object_id *oid,
+		      struct object_info *oi, int flags);
+
 enum finalize_object_file_flags {
 	FOF_SKIP_COLLISION_CHECK = 1,
 };
@@ -90,10 +140,18 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
 /* Helper to check and "touch" a file */
 int check_and_freshen_file(const char *fn, int freshen);
 
-void *read_object_with_reference(struct repository *r,
-				 const struct object_id *oid,
-				 enum object_type required_type,
-				 unsigned long *size,
-				 struct object_id *oid_ret);
+/*
+ * Open the loose object at path, check its hash, and return the contents,
+ * use the "oi" argument to assert things about the object, or e.g. populate its
+ * type, and size. If the object is a blob, then "contents" may return NULL,
+ * to allow streaming of large blobs.
+ *
+ * Returns 0 on success, negative on error (details may be written to stderr).
+ */
+int read_loose_object(const char *path,
+		      const struct object_id *expected_oid,
+		      struct object_id *real_oid,
+		      void **contents,
+		      struct object_info *oi);
 
 #endif /* OBJECT_FILE_H */
diff --git a/object-store-ll.h b/object-store-ll.h
index cd3bd5bd99f..8ae80b8a5fa 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -49,12 +49,6 @@ struct object_directory {
 	char *path;
 };
 
-struct input_stream {
-	const void *(*read)(struct input_stream *, unsigned long *len);
-	void *data;
-	int is_finished;
-};
-
 void prepare_alt_odb(struct repository *r);
 int has_alt_odb(struct repository *r);
 char *compute_alternate_path(const char *path, struct strbuf *err);
@@ -273,21 +267,6 @@ void hash_object_file(const struct git_hash_algo *algo, const void *buf,
 		      unsigned long len, enum object_type type,
 		      struct object_id *oid);
 
-int write_object_file_flags(const void *buf, unsigned long len,
-			    enum object_type type, struct object_id *oid,
-			    struct object_id *comapt_oid_in, unsigned flags);
-static inline int write_object_file(const void *buf, unsigned long len,
-				    enum object_type type, struct object_id *oid)
-{
-	return write_object_file_flags(buf, len, type, oid, NULL, 0);
-}
-
-int write_object_file_literally(const void *buf, unsigned long len,
-				const char *type, struct object_id *oid,
-				unsigned flags);
-int stream_loose_object(struct input_stream *in_stream, size_t len,
-			struct object_id *oid);
-
 /*
  * Add an object file to the in-memory object store, without writing it
  * to disk.
@@ -299,8 +278,6 @@ int stream_loose_object(struct input_stream *in_stream, size_t len,
 int pretend_object_file(void *, unsigned long, enum object_type,
 			struct object_id *oid);
 
-int force_object_loose(const struct object_id *oid, time_t mtime);
-
 struct object_info {
 	/* Request */
 	enum object_type *typep;
@@ -364,20 +341,6 @@ int oid_object_info_extended(struct repository *r,
 			     const struct object_id *,
 			     struct object_info *, unsigned flags);
 
-/*
- * Open the loose object at path, check its hash, and return the contents,
- * use the "oi" argument to assert things about the object, or e.g. populate its
- * type, and size. If the object is a blob, then "contents" may return NULL,
- * to allow streaming of large blobs.
- *
- * Returns 0 on success, negative on error (details may be written to stderr).
- */
-int read_loose_object(const char *path,
-		      const struct object_id *expected_oid,
-		      struct object_id *real_oid,
-		      void **contents,
-		      struct object_info *oi);
-
 /* Retry packed storage after checking packed and loose storage */
 #define HAS_OBJECT_RECHECK_PACKED 1
 
@@ -405,23 +368,6 @@ int repo_has_object_file(struct repository *r, const struct object_id *oid);
 int repo_has_object_file_with_flags(struct repository *r,
 				    const struct object_id *oid, int flags);
 
-/*
- * Return true iff an alternate object database has a loose object
- * with the specified name.  This function does not respect replace
- * references.
- */
-int has_loose_object_nonlocal(const struct object_id *);
-
-int has_loose_object(const struct object_id *);
-
-/**
- * format_object_header() is a thin wrapper around s xsnprintf() that
- * writes the initial "<type> <obj-len>" part of the loose object
- * header. It returns the size that snprintf() returns + 1.
- */
-int format_object_header(char *str, size_t size, enum object_type type,
-			 size_t objsize);
-
 void assert_oid_type(const struct object_id *oid, enum object_type expect);
 
 /*
@@ -553,4 +499,10 @@ int for_each_object_in_pack(struct packed_git *p,
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 			   void *data, enum for_each_object_flags flags);
 
+void *read_object_with_reference(struct repository *r,
+				 const struct object_id *oid,
+				 enum object_type required_type,
+				 unsigned long *size,
+				 struct object_id *oid_ret);
+
 #endif /* OBJECT_STORE_LL_H */
diff --git a/object-store.c b/object-store.c
new file mode 100644
index 00000000000..e5f1f00cdde
--- /dev/null
+++ b/object-store.c
@@ -0,0 +1,972 @@
+#define USE_THE_REPOSITORY_VARIABLE
+
+#include "git-compat-util.h"
+#include "abspath.h"
+#include "config.h"
+#include "environment.h"
+#include "gettext.h"
+#include "hex.h"
+#include "lockfile.h"
+#include "object-file-convert.h"
+#include "object-file.h"
+#include "object-store.h"
+#include "packfile.h"
+#include "path.h"
+#include "promisor-remote.h"
+#include "quote.h"
+#include "replace-object.h"
+#include "run-command.h"
+#include "setup.h"
+#include "strbuf.h"
+#include "strvec.h"
+#include "submodule.h"
+#include "write-or-die.h"
+
+/*
+ * This is meant to hold a *small* number of objects that you would
+ * want repo_read_object_file() to be able to return, but yet you do not want
+ * to write them into the object store (e.g. a browse-only
+ * application).
+ */
+static struct cached_object_entry {
+	struct object_id oid;
+	struct cached_object {
+		enum object_type type;
+		const void *buf;
+		unsigned long size;
+	} value;
+} *cached_objects;
+static int cached_object_nr, cached_object_alloc;
+
+static const struct cached_object *find_cached_object(const struct object_id *oid)
+{
+	static const struct cached_object empty_tree = {
+		.type = OBJ_TREE,
+		.buf = "",
+	};
+	int i;
+	const struct cached_object_entry *co = cached_objects;
+
+	for (i = 0; i < cached_object_nr; i++, co++) {
+		if (oideq(&co->oid, oid))
+			return &co->value;
+	}
+	if (oideq(oid, the_hash_algo->empty_tree))
+		return &empty_tree;
+	return NULL;
+}
+
+int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
+{
+	int fd;
+	/*
+	 * we let the umask do its job, don't try to be more
+	 * restrictive except to remove write permission.
+	 */
+	int mode = 0444;
+	repo_git_path_replace(the_repository, temp_filename, "objects/%s", pattern);
+	fd = git_mkstemp_mode(temp_filename->buf, mode);
+	if (0 <= fd)
+		return fd;
+
+	/* slow path */
+	/* some mkstemp implementations erase temp_filename on failure */
+	repo_git_path_replace(the_repository, temp_filename, "objects/%s", pattern);
+	safe_create_leading_directories(temp_filename->buf);
+	return xmkstemp_mode(temp_filename->buf, mode);
+}
+
+int odb_pack_keep(const char *name)
+{
+	int fd;
+
+	fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
+	if (0 <= fd)
+		return fd;
+
+	/* slow path */
+	safe_create_leading_directories_const(name);
+	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
+}
+
+const char *loose_object_path(struct repository *r, struct strbuf *buf,
+			      const struct object_id *oid)
+{
+	return odb_loose_path(r->objects->odb, buf, oid);
+}
+
+/*
+ * Return non-zero iff the path is usable as an alternate object database.
+ */
+static int alt_odb_usable(struct raw_object_store *o,
+			  struct strbuf *path,
+			  const char *normalized_objdir, khiter_t *pos)
+{
+	int r;
+
+	/* Detect cases where alternate disappeared */
+	if (!is_directory(path->buf)) {
+		error(_("object directory %s does not exist; "
+			"check .git/objects/info/alternates"),
+		      path->buf);
+		return 0;
+	}
+
+	/*
+	 * Prevent the common mistake of listing the same
+	 * thing twice, or object directory itself.
+	 */
+	if (!o->odb_by_path) {
+		khiter_t p;
+
+		o->odb_by_path = kh_init_odb_path_map();
+		assert(!o->odb->next);
+		p = kh_put_odb_path_map(o->odb_by_path, o->odb->path, &r);
+		assert(r == 1); /* never used */
+		kh_value(o->odb_by_path, p) = o->odb;
+	}
+	if (fspatheq(path->buf, normalized_objdir))
+		return 0;
+	*pos = kh_put_odb_path_map(o->odb_by_path, path->buf, &r);
+	/* r: 0 = exists, 1 = never used, 2 = deleted */
+	return r == 0 ? 0 : 1;
+}
+
+/*
+ * Prepare alternate object database registry.
+ *
+ * The variable alt_odb_list points at the list of struct
+ * object_directory.  The elements on this list come from
+ * non-empty elements from colon separated ALTERNATE_DB_ENVIRONMENT
+ * environment variable, and $GIT_OBJECT_DIRECTORY/info/alternates,
+ * whose contents is similar to that environment variable but can be
+ * LF separated.  Its base points at a statically allocated buffer that
+ * contains "/the/directory/corresponding/to/.git/objects/...", while
+ * its name points just after the slash at the end of ".git/objects/"
+ * in the example above, and has enough space to hold all hex characters
+ * of the object ID, an extra slash for the first level indirection, and
+ * the terminating NUL.
+ */
+static void read_info_alternates(struct repository *r,
+				 const char *relative_base,
+				 int depth);
+static int link_alt_odb_entry(struct repository *r, const struct strbuf *entry,
+	const char *relative_base, int depth, const char *normalized_objdir)
+{
+	struct object_directory *ent;
+	struct strbuf pathbuf = STRBUF_INIT;
+	struct strbuf tmp = STRBUF_INIT;
+	khiter_t pos;
+	int ret = -1;
+
+	if (!is_absolute_path(entry->buf) && relative_base) {
+		strbuf_realpath(&pathbuf, relative_base, 1);
+		strbuf_addch(&pathbuf, '/');
+	}
+	strbuf_addbuf(&pathbuf, entry);
+
+	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
+		error(_("unable to normalize alternate object path: %s"),
+		      pathbuf.buf);
+		goto error;
+	}
+	strbuf_swap(&pathbuf, &tmp);
+
+	/*
+	 * The trailing slash after the directory name is given by
+	 * this function at the end. Remove duplicates.
+	 */
+	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
+		strbuf_setlen(&pathbuf, pathbuf.len - 1);
+
+	if (!alt_odb_usable(r->objects, &pathbuf, normalized_objdir, &pos))
+		goto error;
+
+	CALLOC_ARRAY(ent, 1);
+	/* pathbuf.buf is already in r->objects->odb_by_path */
+	ent->path = strbuf_detach(&pathbuf, NULL);
+
+	/* add the alternate entry */
+	*r->objects->odb_tail = ent;
+	r->objects->odb_tail = &(ent->next);
+	ent->next = NULL;
+	assert(r->objects->odb_by_path);
+	kh_value(r->objects->odb_by_path, pos) = ent;
+
+	/* recursively add alternates */
+	read_info_alternates(r, ent->path, depth + 1);
+	ret = 0;
+ error:
+	strbuf_release(&tmp);
+	strbuf_release(&pathbuf);
+	return ret;
+}
+
+static const char *parse_alt_odb_entry(const char *string,
+				       int sep,
+				       struct strbuf *out)
+{
+	const char *end;
+
+	strbuf_reset(out);
+
+	if (*string == '#') {
+		/* comment; consume up to next separator */
+		end = strchrnul(string, sep);
+	} else if (*string == '"' && !unquote_c_style(out, string, &end)) {
+		/*
+		 * quoted path; unquote_c_style has copied the
+		 * data for us and set "end". Broken quoting (e.g.,
+		 * an entry that doesn't end with a quote) falls
+		 * back to the unquoted case below.
+		 */
+	} else {
+		/* normal, unquoted path */
+		end = strchrnul(string, sep);
+		strbuf_add(out, string, end - string);
+	}
+
+	if (*end)
+		end++;
+	return end;
+}
+
+static void link_alt_odb_entries(struct repository *r, const char *alt,
+				 int sep, const char *relative_base, int depth)
+{
+	struct strbuf objdirbuf = STRBUF_INIT;
+	struct strbuf entry = STRBUF_INIT;
+
+	if (!alt || !*alt)
+		return;
+
+	if (depth > 5) {
+		error(_("%s: ignoring alternate object stores, nesting too deep"),
+				relative_base);
+		return;
+	}
+
+	strbuf_realpath(&objdirbuf, r->objects->odb->path, 1);
+
+	while (*alt) {
+		alt = parse_alt_odb_entry(alt, sep, &entry);
+		if (!entry.len)
+			continue;
+		link_alt_odb_entry(r, &entry,
+				   relative_base, depth, objdirbuf.buf);
+	}
+	strbuf_release(&entry);
+	strbuf_release(&objdirbuf);
+}
+
+static void read_info_alternates(struct repository *r,
+				 const char *relative_base,
+				 int depth)
+{
+	char *path;
+	struct strbuf buf = STRBUF_INIT;
+
+	path = xstrfmt("%s/info/alternates", relative_base);
+	if (strbuf_read_file(&buf, path, 1024) < 0) {
+		warn_on_fopen_errors(path);
+		free(path);
+		return;
+	}
+
+	link_alt_odb_entries(r, buf.buf, '\n', relative_base, depth);
+	strbuf_release(&buf);
+	free(path);
+}
+
+void add_to_alternates_file(const char *reference)
+{
+	struct lock_file lock = LOCK_INIT;
+	char *alts = repo_git_path(the_repository, "objects/info/alternates");
+	FILE *in, *out;
+	int found = 0;
+
+	hold_lock_file_for_update(&lock, alts, LOCK_DIE_ON_ERROR);
+	out = fdopen_lock_file(&lock, "w");
+	if (!out)
+		die_errno(_("unable to fdopen alternates lockfile"));
+
+	in = fopen(alts, "r");
+	if (in) {
+		struct strbuf line = STRBUF_INIT;
+
+		while (strbuf_getline(&line, in) != EOF) {
+			if (!strcmp(reference, line.buf)) {
+				found = 1;
+				break;
+			}
+			fprintf_or_die(out, "%s\n", line.buf);
+		}
+
+		strbuf_release(&line);
+		fclose(in);
+	}
+	else if (errno != ENOENT)
+		die_errno(_("unable to read alternates file"));
+
+	if (found) {
+		rollback_lock_file(&lock);
+	} else {
+		fprintf_or_die(out, "%s\n", reference);
+		if (commit_lock_file(&lock))
+			die_errno(_("unable to move new alternates file into place"));
+		if (the_repository->objects->loaded_alternates)
+			link_alt_odb_entries(the_repository, reference,
+					     '\n', NULL, 0);
+	}
+	free(alts);
+}
+
+void add_to_alternates_memory(const char *reference)
+{
+	/*
+	 * Make sure alternates are initialized, or else our entry may be
+	 * overwritten when they are.
+	 */
+	prepare_alt_odb(the_repository);
+
+	link_alt_odb_entries(the_repository, reference,
+			     '\n', NULL, 0);
+}
+
+struct object_directory *set_temporary_primary_odb(const char *dir, int will_destroy)
+{
+	struct object_directory *new_odb;
+
+	/*
+	 * Make sure alternates are initialized, or else our entry may be
+	 * overwritten when they are.
+	 */
+	prepare_alt_odb(the_repository);
+
+	/*
+	 * Make a new primary odb and link the old primary ODB in as an
+	 * alternate
+	 */
+	new_odb = xcalloc(1, sizeof(*new_odb));
+	new_odb->path = xstrdup(dir);
+
+	/*
+	 * Disable ref updates while a temporary odb is active, since
+	 * the objects in the database may roll back.
+	 */
+	new_odb->disable_ref_updates = 1;
+	new_odb->will_destroy = will_destroy;
+	new_odb->next = the_repository->objects->odb;
+	the_repository->objects->odb = new_odb;
+	return new_odb->next;
+}
+
+void restore_primary_odb(struct object_directory *restore_odb, const char *old_path)
+{
+	struct object_directory *cur_odb = the_repository->objects->odb;
+
+	if (strcmp(old_path, cur_odb->path))
+		BUG("expected %s as primary object store; found %s",
+		    old_path, cur_odb->path);
+
+	if (cur_odb->next != restore_odb)
+		BUG("we expect the old primary object store to be the first alternate");
+
+	the_repository->objects->odb = restore_odb;
+	free_object_directory(cur_odb);
+}
+
+/*
+ * Compute the exact path an alternate is at and returns it. In case of
+ * error NULL is returned and the human readable error is added to `err`
+ * `path` may be relative and should point to $GIT_DIR.
+ * `err` must not be null.
+ */
+char *compute_alternate_path(const char *path, struct strbuf *err)
+{
+	char *ref_git = NULL;
+	const char *repo;
+	int seen_error = 0;
+
+	ref_git = real_pathdup(path, 0);
+	if (!ref_git) {
+		seen_error = 1;
+		strbuf_addf(err, _("path '%s' does not exist"), path);
+		goto out;
+	}
+
+	repo = read_gitfile(ref_git);
+	if (!repo)
+		repo = read_gitfile(mkpath("%s/.git", ref_git));
+	if (repo) {
+		free(ref_git);
+		ref_git = xstrdup(repo);
+	}
+
+	if (!repo && is_directory(mkpath("%s/.git/objects", ref_git))) {
+		char *ref_git_git = mkpathdup("%s/.git", ref_git);
+		free(ref_git);
+		ref_git = ref_git_git;
+	} else if (!is_directory(mkpath("%s/objects", ref_git))) {
+		struct strbuf sb = STRBUF_INIT;
+		seen_error = 1;
+		if (get_common_dir(&sb, ref_git)) {
+			strbuf_addf(err,
+				    _("reference repository '%s' as a linked "
+				      "checkout is not supported yet."),
+				    path);
+			goto out;
+		}
+
+		strbuf_addf(err, _("reference repository '%s' is not a "
+					"local repository."), path);
+		goto out;
+	}
+
+	if (!access(mkpath("%s/shallow", ref_git), F_OK)) {
+		strbuf_addf(err, _("reference repository '%s' is shallow"),
+			    path);
+		seen_error = 1;
+		goto out;
+	}
+
+	if (!access(mkpath("%s/info/grafts", ref_git), F_OK)) {
+		strbuf_addf(err,
+			    _("reference repository '%s' is grafted"),
+			    path);
+		seen_error = 1;
+		goto out;
+	}
+
+out:
+	if (seen_error) {
+		FREE_AND_NULL(ref_git);
+	}
+
+	return ref_git;
+}
+
+struct object_directory *find_odb(struct repository *r, const char *obj_dir)
+{
+	struct object_directory *odb;
+	char *obj_dir_real = real_pathdup(obj_dir, 1);
+	struct strbuf odb_path_real = STRBUF_INIT;
+
+	prepare_alt_odb(r);
+	for (odb = r->objects->odb; odb; odb = odb->next) {
+		strbuf_realpath(&odb_path_real, odb->path, 1);
+		if (!strcmp(obj_dir_real, odb_path_real.buf))
+			break;
+	}
+
+	free(obj_dir_real);
+	strbuf_release(&odb_path_real);
+
+	if (!odb)
+		die(_("could not find object directory matching %s"), obj_dir);
+	return odb;
+}
+
+static void fill_alternate_refs_command(struct child_process *cmd,
+					const char *repo_path)
+{
+	const char *value;
+
+	if (!git_config_get_value("core.alternateRefsCommand", &value)) {
+		cmd->use_shell = 1;
+
+		strvec_push(&cmd->args, value);
+		strvec_push(&cmd->args, repo_path);
+	} else {
+		cmd->git_cmd = 1;
+
+		strvec_pushf(&cmd->args, "--git-dir=%s", repo_path);
+		strvec_push(&cmd->args, "for-each-ref");
+		strvec_push(&cmd->args, "--format=%(objectname)");
+
+		if (!git_config_get_value("core.alternateRefsPrefixes", &value)) {
+			strvec_push(&cmd->args, "--");
+			strvec_split(&cmd->args, value);
+		}
+	}
+
+	strvec_pushv(&cmd->env, (const char **)local_repo_env);
+	cmd->out = -1;
+}
+
+static void read_alternate_refs(const char *path,
+				alternate_ref_fn *cb,
+				void *data)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf line = STRBUF_INIT;
+	FILE *fh;
+
+	fill_alternate_refs_command(&cmd, path);
+
+	if (start_command(&cmd))
+		return;
+
+	fh = xfdopen(cmd.out, "r");
+	while (strbuf_getline_lf(&line, fh) != EOF) {
+		struct object_id oid;
+		const char *p;
+
+		if (parse_oid_hex(line.buf, &oid, &p) || *p) {
+			warning(_("invalid line while parsing alternate refs: %s"),
+				line.buf);
+			break;
+		}
+
+		cb(&oid, data);
+	}
+
+	fclose(fh);
+	finish_command(&cmd);
+	strbuf_release(&line);
+}
+
+struct alternate_refs_data {
+	alternate_ref_fn *fn;
+	void *data;
+};
+
+static int refs_from_alternate_cb(struct object_directory *e,
+				  void *data)
+{
+	struct strbuf path = STRBUF_INIT;
+	size_t base_len;
+	struct alternate_refs_data *cb = data;
+
+	if (!strbuf_realpath(&path, e->path, 0))
+		goto out;
+	if (!strbuf_strip_suffix(&path, "/objects"))
+		goto out;
+	base_len = path.len;
+
+	/* Is this a git repository with refs? */
+	strbuf_addstr(&path, "/refs");
+	if (!is_directory(path.buf))
+		goto out;
+	strbuf_setlen(&path, base_len);
+
+	read_alternate_refs(path.buf, cb->fn, cb->data);
+
+out:
+	strbuf_release(&path);
+	return 0;
+}
+
+void for_each_alternate_ref(alternate_ref_fn fn, void *data)
+{
+	struct alternate_refs_data cb;
+	cb.fn = fn;
+	cb.data = data;
+	foreach_alt_odb(refs_from_alternate_cb, &cb);
+}
+
+int foreach_alt_odb(alt_odb_fn fn, void *cb)
+{
+	struct object_directory *ent;
+	int r = 0;
+
+	prepare_alt_odb(the_repository);
+	for (ent = the_repository->objects->odb->next; ent; ent = ent->next) {
+		r = fn(ent, cb);
+		if (r)
+			break;
+	}
+	return r;
+}
+
+void prepare_alt_odb(struct repository *r)
+{
+	if (r->objects->loaded_alternates)
+		return;
+
+	link_alt_odb_entries(r, r->objects->alternate_db, PATH_SEP, NULL, 0);
+
+	read_info_alternates(r, r->objects->odb->path, 0);
+	r->objects->loaded_alternates = 1;
+}
+
+int has_alt_odb(struct repository *r)
+{
+	prepare_alt_odb(r);
+	return !!r->objects->odb->next;
+}
+
+int obj_read_use_lock = 0;
+pthread_mutex_t obj_read_mutex;
+
+void enable_obj_read_lock(void)
+{
+	if (obj_read_use_lock)
+		return;
+
+	obj_read_use_lock = 1;
+	init_recursive_mutex(&obj_read_mutex);
+}
+
+void disable_obj_read_lock(void)
+{
+	if (!obj_read_use_lock)
+		return;
+
+	obj_read_use_lock = 0;
+	pthread_mutex_destroy(&obj_read_mutex);
+}
+
+int fetch_if_missing = 1;
+
+static int do_oid_object_info_extended(struct repository *r,
+				       const struct object_id *oid,
+				       struct object_info *oi, unsigned flags)
+{
+	static struct object_info blank_oi = OBJECT_INFO_INIT;
+	const struct cached_object *co;
+	struct pack_entry e;
+	int rtype;
+	const struct object_id *real = oid;
+	int already_retried = 0;
+
+
+	if (flags & OBJECT_INFO_LOOKUP_REPLACE)
+		real = lookup_replace_object(r, oid);
+
+	if (is_null_oid(real))
+		return -1;
+
+	if (!oi)
+		oi = &blank_oi;
+
+	co = find_cached_object(real);
+	if (co) {
+		if (oi->typep)
+			*(oi->typep) = co->type;
+		if (oi->sizep)
+			*(oi->sizep) = co->size;
+		if (oi->disk_sizep)
+			*(oi->disk_sizep) = 0;
+		if (oi->delta_base_oid)
+			oidclr(oi->delta_base_oid, the_repository->hash_algo);
+		if (oi->type_name)
+			strbuf_addstr(oi->type_name, type_name(co->type));
+		if (oi->contentp)
+			*oi->contentp = xmemdupz(co->buf, co->size);
+		oi->whence = OI_CACHED;
+		return 0;
+	}
+
+	while (1) {
+		if (find_pack_entry(r, real, &e))
+			break;
+
+		/* Most likely it's a loose object. */
+		if (!loose_object_info(r, real, oi, flags))
+			return 0;
+
+		/* Not a loose object; someone else may have just packed it. */
+		if (!(flags & OBJECT_INFO_QUICK)) {
+			reprepare_packed_git(r);
+			if (find_pack_entry(r, real, &e))
+				break;
+		}
+
+		/*
+		 * If r is the_repository, this might be an attempt at
+		 * accessing a submodule object as if it were in the_repository
+		 * (having called add_submodule_odb() on that submodule's ODB).
+		 * If any such ODBs exist, register them and try again.
+		 */
+		if (r == the_repository &&
+		    register_all_submodule_odb_as_alternates())
+			/* We added some alternates; retry */
+			continue;
+
+		/* Check if it is a missing object */
+		if (fetch_if_missing && repo_has_promisor_remote(r) &&
+		    !already_retried &&
+		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
+			promisor_remote_get_direct(r, real, 1);
+			already_retried = 1;
+			continue;
+		}
+
+		if (flags & OBJECT_INFO_DIE_IF_CORRUPT) {
+			const struct packed_git *p;
+			if ((flags & OBJECT_INFO_LOOKUP_REPLACE) && !oideq(real, oid))
+				die(_("replacement %s not found for %s"),
+				    oid_to_hex(real), oid_to_hex(oid));
+			if ((p = has_packed_and_bad(r, real)))
+				die(_("packed object %s (stored in %s) is corrupt"),
+				    oid_to_hex(real), p->pack_name);
+		}
+		return -1;
+	}
+
+	if (oi == &blank_oi)
+		/*
+		 * We know that the caller doesn't actually need the
+		 * information below, so return early.
+		 */
+		return 0;
+	rtype = packed_object_info(r, e.p, e.offset, oi);
+	if (rtype < 0) {
+		mark_bad_packed_object(e.p, real);
+		return do_oid_object_info_extended(r, real, oi, 0);
+	} else if (oi->whence == OI_PACKED) {
+		oi->u.packed.offset = e.offset;
+		oi->u.packed.pack = e.p;
+		oi->u.packed.is_delta = (rtype == OBJ_REF_DELTA ||
+					 rtype == OBJ_OFS_DELTA);
+	}
+
+	return 0;
+}
+
+static int oid_object_info_convert(struct repository *r,
+				   const struct object_id *input_oid,
+				   struct object_info *input_oi, unsigned flags)
+{
+	const struct git_hash_algo *input_algo = &hash_algos[input_oid->algo];
+	int do_die = flags & OBJECT_INFO_DIE_IF_CORRUPT;
+	struct strbuf type_name = STRBUF_INIT;
+	struct object_id oid, delta_base_oid;
+	struct object_info new_oi, *oi;
+	unsigned long size;
+	void *content;
+	int ret;
+
+	if (repo_oid_to_algop(r, input_oid, the_hash_algo, &oid)) {
+		if (do_die)
+			die(_("missing mapping of %s to %s"),
+			    oid_to_hex(input_oid), the_hash_algo->name);
+		return -1;
+	}
+
+	/* Is new_oi needed? */
+	oi = input_oi;
+	if (input_oi && (input_oi->delta_base_oid || input_oi->sizep ||
+			 input_oi->contentp)) {
+		new_oi = *input_oi;
+		/* Does delta_base_oid need to be converted? */
+		if (input_oi->delta_base_oid)
+			new_oi.delta_base_oid = &delta_base_oid;
+		/* Will the attributes differ when converted? */
+		if (input_oi->sizep || input_oi->contentp) {
+			new_oi.contentp = &content;
+			new_oi.sizep = &size;
+			new_oi.type_name = &type_name;
+		}
+		oi = &new_oi;
+	}
+
+	ret = oid_object_info_extended(r, &oid, oi, flags);
+	if (ret)
+		return -1;
+	if (oi == input_oi)
+		return ret;
+
+	if (new_oi.contentp) {
+		struct strbuf outbuf = STRBUF_INIT;
+		enum object_type type;
+
+		type = type_from_string_gently(type_name.buf, type_name.len,
+					       !do_die);
+		if (type == -1)
+			return -1;
+		if (type != OBJ_BLOB) {
+			ret = convert_object_file(the_repository, &outbuf,
+						  the_hash_algo, input_algo,
+						  content, size, type, !do_die);
+			free(content);
+			if (ret == -1)
+				return -1;
+			size = outbuf.len;
+			content = strbuf_detach(&outbuf, NULL);
+		}
+		if (input_oi->sizep)
+			*input_oi->sizep = size;
+		if (input_oi->contentp)
+			*input_oi->contentp = content;
+		else
+			free(content);
+		if (input_oi->type_name)
+			*input_oi->type_name = type_name;
+		else
+			strbuf_release(&type_name);
+	}
+	if (new_oi.delta_base_oid == &delta_base_oid) {
+		if (repo_oid_to_algop(r, &delta_base_oid, input_algo,
+				 input_oi->delta_base_oid)) {
+			if (do_die)
+				die(_("missing mapping of %s to %s"),
+				    oid_to_hex(&delta_base_oid),
+				    input_algo->name);
+			return -1;
+		}
+	}
+	input_oi->whence = new_oi.whence;
+	input_oi->u = new_oi.u;
+	return ret;
+}
+
+int oid_object_info_extended(struct repository *r, const struct object_id *oid,
+			     struct object_info *oi, unsigned flags)
+{
+	int ret;
+
+	if (oid->algo && (hash_algo_by_ptr(r->hash_algo) != oid->algo))
+		return oid_object_info_convert(r, oid, oi, flags);
+
+	obj_read_lock();
+	ret = do_oid_object_info_extended(r, oid, oi, flags);
+	obj_read_unlock();
+	return ret;
+}
+
+
+/* returns enum object_type or negative */
+int oid_object_info(struct repository *r,
+		    const struct object_id *oid,
+		    unsigned long *sizep)
+{
+	enum object_type type;
+	struct object_info oi = OBJECT_INFO_INIT;
+
+	oi.typep = &type;
+	oi.sizep = sizep;
+	if (oid_object_info_extended(r, oid, &oi,
+				      OBJECT_INFO_LOOKUP_REPLACE) < 0)
+		return -1;
+	return type;
+}
+
+int pretend_object_file(void *buf, unsigned long len, enum object_type type,
+			struct object_id *oid)
+{
+	struct cached_object_entry *co;
+	char *co_buf;
+
+	hash_object_file(the_hash_algo, buf, len, type, oid);
+	if (repo_has_object_file_with_flags(the_repository, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
+	    find_cached_object(oid))
+		return 0;
+	ALLOC_GROW(cached_objects, cached_object_nr + 1, cached_object_alloc);
+	co = &cached_objects[cached_object_nr++];
+	co->value.size = len;
+	co->value.type = type;
+	co_buf = xmalloc(len);
+	memcpy(co_buf, buf, len);
+	co->value.buf = co_buf;
+	oidcpy(&co->oid, oid);
+	return 0;
+}
+
+/*
+ * This function dies on corrupt objects; the callers who want to
+ * deal with them should arrange to call oid_object_info_extended() and give
+ * error messages themselves.
+ */
+void *repo_read_object_file(struct repository *r,
+			    const struct object_id *oid,
+			    enum object_type *type,
+			    unsigned long *size)
+{
+	struct object_info oi = OBJECT_INFO_INIT;
+	unsigned flags = OBJECT_INFO_DIE_IF_CORRUPT | OBJECT_INFO_LOOKUP_REPLACE;
+	void *data;
+
+	oi.typep = type;
+	oi.sizep = size;
+	oi.contentp = &data;
+	if (oid_object_info_extended(r, oid, &oi, flags))
+		return NULL;
+
+	return data;
+}
+
+void *read_object_with_reference(struct repository *r,
+				 const struct object_id *oid,
+				 enum object_type required_type,
+				 unsigned long *size,
+				 struct object_id *actual_oid_return)
+{
+	enum object_type type;
+	void *buffer;
+	unsigned long isize;
+	struct object_id actual_oid;
+
+	oidcpy(&actual_oid, oid);
+	while (1) {
+		int ref_length = -1;
+		const char *ref_type = NULL;
+
+		buffer = repo_read_object_file(r, &actual_oid, &type, &isize);
+		if (!buffer)
+			return NULL;
+		if (type == required_type) {
+			*size = isize;
+			if (actual_oid_return)
+				oidcpy(actual_oid_return, &actual_oid);
+			return buffer;
+		}
+		/* Handle references */
+		else if (type == OBJ_COMMIT)
+			ref_type = "tree ";
+		else if (type == OBJ_TAG)
+			ref_type = "object ";
+		else {
+			free(buffer);
+			return NULL;
+		}
+		ref_length = strlen(ref_type);
+
+		if (ref_length + the_hash_algo->hexsz > isize ||
+		    memcmp(buffer, ref_type, ref_length) ||
+		    get_oid_hex((char *) buffer + ref_length, &actual_oid)) {
+			free(buffer);
+			return NULL;
+		}
+		free(buffer);
+		/* Now we have the ID of the referred-to object in
+		 * actual_oid.  Check again. */
+	}
+}
+
+int has_object(struct repository *r, const struct object_id *oid,
+	       unsigned flags)
+{
+	int quick = !(flags & HAS_OBJECT_RECHECK_PACKED);
+	unsigned object_info_flags = OBJECT_INFO_SKIP_FETCH_OBJECT |
+		(quick ? OBJECT_INFO_QUICK : 0);
+
+	if (!startup_info->have_repository)
+		return 0;
+	return oid_object_info_extended(r, oid, NULL, object_info_flags) >= 0;
+}
+
+int repo_has_object_file_with_flags(struct repository *r,
+				    const struct object_id *oid, int flags)
+{
+	if (!startup_info->have_repository)
+		return 0;
+	return oid_object_info_extended(r, oid, NULL, flags) >= 0;
+}
+
+int repo_has_object_file(struct repository *r,
+			 const struct object_id *oid)
+{
+	return repo_has_object_file_with_flags(r, oid, 0);
+}
+
+void assert_oid_type(const struct object_id *oid, enum object_type expect)
+{
+	enum object_type type = oid_object_info(the_repository, oid, NULL);
+	if (type < 0)
+		die(_("%s is not a valid object"), oid_to_hex(oid));
+	if (type != expect)
+		die(_("%s is not a valid '%s' object"), oid_to_hex(oid),
+		    type_name(expect));
+}

-- 
2.49.0.777.g153de2bbd5.dirty

