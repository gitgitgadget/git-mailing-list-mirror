Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B4622540C
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828696; cv=none; b=r98N7DMSsSJF/HYzTV5zIXc85bYTzcWr50qg+bMiywL0HdSLL7gvh3VriSEzCHJueOGPvcxWUnBRb51mwfRkXTcNnsTJjBBu/31LYBQsJoYZ89FcrD4NX9C6Er4st3/tGJaXmd6QQOjOqN/2k2twOUZBnRjCW4h+8oEx4qJAOVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828696; c=relaxed/simple;
	bh=pluOZWqDu0fpB9mTr4jz4hFS3hQP6Plvl/KUHaKtGMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hXQtYLDmtn+SsopeQuMdz8N30yDJ/Wv1lltQMDE3n1n9zl74f9uzFM8H6k9wDJd0rrg/ehJsI378V7avWhS6DrzRIaJJPRseq5pak5NayT69314oJY/tWxJE1nLX34sR4adU9fges/zPOasP+sGbdtNTfrpgMMG5NvWdMry3dA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pm5Szx5o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TqwNVv1r; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pm5Szx5o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TqwNVv1r"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 0722E138020F
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:14 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 06 Feb 2025 02:58:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828694;
	 x=1738915094; bh=ndakx+bSEIJ9oTvobrrYRczY591eIq64aZZSyvHH7KI=; b=
	Pm5Szx5oOQwlk9l38bwCRc01gNDqqQScHL9I8Mfx/APT3EY++iHfQjmG+6J1/RQq
	/qpdNU4TMpkLoZXfcHWje9/IqFKZYCKyLlPSbctFiJDLh1T8fQDPNHk4bgkCKY9c
	sj49oCYlqQN0gwkkDQzw+xKcIzMuEDDzNm+L5G+KH6Zqy93u3bo8bk3EzZdmVtNo
	iT7h/19yMT/Ej9sYidmIDdGLQG6q4iIwl5/q8P25IwJW1Om+Hi3ZvQ9oIb7Aw2Pg
	vlEwwTRCUW098fxIz8kEUudE/BiOWHf5RfZrSiAmoEH/UeS2jVczfV+H1y05XLPS
	RCtjCaoAVI8Cd0D0Otx9BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828694; x=
	1738915094; bh=ndakx+bSEIJ9oTvobrrYRczY591eIq64aZZSyvHH7KI=; b=T
	qwNVv1rVTju/HxqBmSjihKeWjWMqtzoEYkFglhrLSNTTGmLcbJevd6Nic+JqfGNu
	S6qeTD+aCsEXbRcI2+Y5WBqjc+PtZf3vtzA/KlFWe/oMejtMziB79muF3h7OmI6B
	DisW4uJsb3EVLed1Z/u0HkAYIKgMHFPqL6Zd+27UNpo4PukqnlZRfGdo8A8OLj/O
	95BGGlNf2DesrelmB3rIJSSr7/Myt6MvWT9uSJxV1WGmWPrPfw5CSnzfiulqaWQh
	G0e3eUNfoBkGOci3mj3UVZ55Dj3NXFrLkkkJrwgnLXGW0ReTfJR5Snjsic+8DIwq
	S+r+GT+ViYuM9W6oRNFlQ==
X-ME-Sender: <xms:lWukZ6OW7-TFb5ylUiUHOgkAkm6Si1EP4Te-MINTI3b2136JZjPdxQ>
    <xme:lWukZ4-xkzsa6a4Se_j9Cw8kBfGRwLQdWDbttSftC6byw9kIp1cTHT4OFihh10h_m
    TlAjMBunsAHkAMhZA>
X-ME-Received: <xmr:lWukZxRsnbgsy3_v5_SLT_uHPdwVuvj2BJjh5WZrQUKZ0StjCE0Ux1tnj71kcoPX69g9FAgKXb2vLML17DJvWUpw--iO8KrMdRrpQbIe9r6q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:lWukZ6todElk-2zJUS-shgd5pD4NNU05sMdLW-7KGPQN9bOdLyel4g>
    <xmx:lWukZyf3geAMrZNohqg-tRjvPdTQJgW3e32gh_oELxMkSKsDujI-uA>
    <xmx:lWukZ-3hPYa4R9t4L-pHsq2ayGkWZRCQ-9fD0OoKAXKn5C6EtVR4BQ>
    <xmx:lWukZ2-xbQCFu4UVHS8BYgSZJqVfzJ5dna8qkPsaTpp6laIOuRgdyA>
    <xmx:lWukZzoisFdXE_5EnMO40pp6M9gyjM2ZG7oQMgx3NKtO3hq3xMixPkO->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18a37bad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:58:07 +0100
Subject: [PATCH 11/16] rerere: let `rerere_path()` write paths into a
 caller-provided buffer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-11-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Same as with `get_worktree_git_dir()` a couple of commits ago, the
`rerere_path()` function returns paths that need not be free'd by the
caller because `git_path()` internally uses `get_pathname()`.

Refactor the function to instead accept a caller-provided buffer that
the path will be written into, passing on ownership to the caller. This
refactoring prepares us for the removal of `git_path()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rerere.c | 11 ++++---
 rerere.c         | 87 ++++++++++++++++++++++++++++++++++++++------------------
 rerere.h         |  3 +-
 3 files changed, 69 insertions(+), 32 deletions(-)

diff --git a/builtin/rerere.c b/builtin/rerere.c
index 41127e24e5..1312e79d89 100644
--- a/builtin/rerere.c
+++ b/builtin/rerere.c
@@ -4,9 +4,9 @@
 #include "config.h"
 #include "gettext.h"
 #include "parse-options.h"
-
-#include "string-list.h"
 #include "rerere.h"
+#include "strbuf.h"
+#include "string-list.h"
 #include "xdiff/xdiff.h"
 #include "xdiff-interface.h"
 #include "pathspec.h"
@@ -112,15 +112,18 @@ int cmd_rerere(int argc,
 				merge_rr.items[i].util = NULL;
 		}
 	} else if (!strcmp(argv[0], "diff")) {
+		struct strbuf buf = STRBUF_INIT;
 		if (setup_rerere(the_repository, &merge_rr,
 				 flags | RERERE_READONLY) < 0)
 			return 0;
 		for (size_t i = 0; i < merge_rr.nr; i++) {
 			const char *path = merge_rr.items[i].string;
 			const struct rerere_id *id = merge_rr.items[i].util;
-			if (diff_two(rerere_path(id, "preimage"), path, path, path))
-				die(_("unable to generate diff for '%s'"), rerere_path(id, NULL));
+			if (diff_two(rerere_path(&buf, id, "preimage"), path, path, path))
+				die(_("unable to generate diff for '%s'"), rerere_path(&buf, id, NULL));
 		}
+
+		strbuf_release(&buf);
 	} else
 		usage_with_options(rerere_usage, options);
 
diff --git a/rerere.c b/rerere.c
index e7fa6426b3..763cb715a6 100644
--- a/rerere.c
+++ b/rerere.c
@@ -91,16 +91,18 @@ static void assign_variant(struct rerere_id *id)
 	id->variant = variant;
 }
 
-const char *rerere_path(const struct rerere_id *id, const char *file)
+const char *rerere_path(struct strbuf *buf, const struct rerere_id *id, const char *file)
 {
 	if (!file)
-		return git_path("rr-cache/%s", rerere_id_hex(id));
+		return repo_git_path_replace(the_repository, buf, "rr-cache/%s",
+					     rerere_id_hex(id));
 
 	if (id->variant <= 0)
-		return git_path("rr-cache/%s/%s", rerere_id_hex(id), file);
+		return repo_git_path_replace(the_repository, buf, "rr-cache/%s/%s",
+					     rerere_id_hex(id), file);
 
-	return git_path("rr-cache/%s/%s.%d",
-			rerere_id_hex(id), file, id->variant);
+	return repo_git_path_replace(the_repository, buf, "rr-cache/%s/%s.%d",
+				     rerere_id_hex(id), file, id->variant);
 }
 
 static int is_rr_file(const char *name, const char *filename, int *variant)
@@ -624,9 +626,10 @@ static int try_merge(struct index_state *istate,
 {
 	enum ll_merge_result ret;
 	mmfile_t base = {NULL, 0}, other = {NULL, 0};
+	struct strbuf buf = STRBUF_INIT;
 
-	if (read_mmfile(&base, rerere_path(id, "preimage")) ||
-	    read_mmfile(&other, rerere_path(id, "postimage"))) {
+	if (read_mmfile(&base, rerere_path(&buf, id, "preimage")) ||
+	    read_mmfile(&other, rerere_path(&buf, id, "postimage"))) {
 		ret = LL_MERGE_CONFLICT;
 	} else {
 		/*
@@ -637,6 +640,7 @@ static int try_merge(struct index_state *istate,
 			       istate, NULL);
 	}
 
+	strbuf_release(&buf);
 	free(base.ptr);
 	free(other.ptr);
 
@@ -657,6 +661,7 @@ static int merge(struct index_state *istate, const struct rerere_id *id, const c
 {
 	FILE *f;
 	int ret;
+	struct strbuf buf = STRBUF_INIT;
 	mmfile_t cur = {NULL, 0};
 	mmbuffer_t result = {NULL, 0};
 
@@ -664,8 +669,8 @@ static int merge(struct index_state *istate, const struct rerere_id *id, const c
 	 * Normalize the conflicts in path and write it out to
 	 * "thisimage" temporary file.
 	 */
-	if ((handle_file(istate, path, NULL, rerere_path(id, "thisimage")) < 0) ||
-	    read_mmfile(&cur, rerere_path(id, "thisimage"))) {
+	if ((handle_file(istate, path, NULL, rerere_path(&buf, id, "thisimage")) < 0) ||
+	    read_mmfile(&cur, rerere_path(&buf, id, "thisimage"))) {
 		ret = 1;
 		goto out;
 	}
@@ -678,9 +683,9 @@ static int merge(struct index_state *istate, const struct rerere_id *id, const c
 	 * A successful replay of recorded resolution.
 	 * Mark that "postimage" was used to help gc.
 	 */
-	if (utime(rerere_path(id, "postimage"), NULL) < 0)
+	if (utime(rerere_path(&buf, id, "postimage"), NULL) < 0)
 		warning_errno(_("failed utime() on '%s'"),
-			      rerere_path(id, "postimage"));
+			      rerere_path(&buf, id, "postimage"));
 
 	/* Update "path" with the resolution */
 	f = fopen(path, "w");
@@ -694,6 +699,7 @@ static int merge(struct index_state *istate, const struct rerere_id *id, const c
 out:
 	free(cur.ptr);
 	free(result.ptr);
+	strbuf_release(&buf);
 
 	return ret;
 }
@@ -720,9 +726,11 @@ static void update_paths(struct repository *r, struct string_list *update)
 
 static void remove_variant(struct rerere_id *id)
 {
-	unlink_or_warn(rerere_path(id, "postimage"));
-	unlink_or_warn(rerere_path(id, "preimage"));
+	struct strbuf buf = STRBUF_INIT;
+	unlink_or_warn(rerere_path(&buf, id, "postimage"));
+	unlink_or_warn(rerere_path(&buf, id, "preimage"));
 	id->collection->status[id->variant] = 0;
+	strbuf_release(&buf);
 }
 
 /*
@@ -739,6 +747,7 @@ static void do_rerere_one_path(struct index_state *istate,
 	const char *path = rr_item->string;
 	struct rerere_id *id = rr_item->util;
 	struct rerere_dir *rr_dir = id->collection;
+	struct strbuf buf = STRBUF_INIT;
 	int variant;
 
 	variant = id->variant;
@@ -746,12 +755,12 @@ static void do_rerere_one_path(struct index_state *istate,
 	/* Has the user resolved it already? */
 	if (variant >= 0) {
 		if (!handle_file(istate, path, NULL, NULL)) {
-			copy_file(rerere_path(id, "postimage"), path, 0666);
+			copy_file(rerere_path(&buf, id, "postimage"), path, 0666);
 			id->collection->status[variant] |= RR_HAS_POSTIMAGE;
 			fprintf_ln(stderr, _("Recorded resolution for '%s'."), path);
 			free_rerere_id(rr_item);
 			rr_item->util = NULL;
-			return;
+			goto out;
 		}
 		/*
 		 * There may be other variants that can cleanly
@@ -787,22 +796,25 @@ static void do_rerere_one_path(struct index_state *istate,
 				   path);
 		free_rerere_id(rr_item);
 		rr_item->util = NULL;
-		return;
+		goto out;
 	}
 
 	/* None of the existing one applies; we need a new variant */
 	assign_variant(id);
 
 	variant = id->variant;
-	handle_file(istate, path, NULL, rerere_path(id, "preimage"));
+	handle_file(istate, path, NULL, rerere_path(&buf, id, "preimage"));
 	if (id->collection->status[variant] & RR_HAS_POSTIMAGE) {
-		const char *path = rerere_path(id, "postimage");
+		const char *path = rerere_path(&buf, id, "postimage");
 		if (unlink(path))
 			die_errno(_("cannot unlink stray '%s'"), path);
 		id->collection->status[variant] &= ~RR_HAS_POSTIMAGE;
 	}
 	id->collection->status[variant] |= RR_HAS_PREIMAGE;
 	fprintf_ln(stderr, _("Recorded preimage for '%s'"), path);
+
+out:
+	strbuf_release(&buf);
 }
 
 static int do_plain_rerere(struct repository *r,
@@ -810,6 +822,7 @@ static int do_plain_rerere(struct repository *r,
 {
 	struct string_list conflict = STRING_LIST_INIT_DUP;
 	struct string_list update = STRING_LIST_INIT_DUP;
+	struct strbuf buf = STRBUF_INIT;
 	int i;
 
 	find_conflict(r, &conflict);
@@ -843,7 +856,7 @@ static int do_plain_rerere(struct repository *r,
 		string_list_insert(rr, path)->util = id;
 
 		/* Ensure that the directory exists. */
-		mkdir_in_gitdir(rerere_path(id, NULL));
+		mkdir_in_gitdir(rerere_path(&buf, id, NULL));
 	}
 
 	for (i = 0; i < rr->nr; i++)
@@ -854,6 +867,7 @@ static int do_plain_rerere(struct repository *r,
 
 	string_list_clear(&conflict, 0);
 	string_list_clear(&update, 0);
+	strbuf_release(&buf);
 	return write_rr(rr, fd);
 }
 
@@ -1033,6 +1047,7 @@ static int rerere_forget_one_path(struct index_state *istate,
 	struct rerere_id *id;
 	unsigned char hash[GIT_MAX_RAWSZ];
 	int ret;
+	struct strbuf buf = STRBUF_INIT;
 	struct string_list_item *item;
 
 	/*
@@ -1056,8 +1071,8 @@ static int rerere_forget_one_path(struct index_state *istate,
 		if (!has_rerere_resolution(id))
 			continue;
 
-		handle_cache(istate, path, hash, rerere_path(id, "thisimage"));
-		if (read_mmfile(&cur, rerere_path(id, "thisimage"))) {
+		handle_cache(istate, path, hash, rerere_path(&buf, id, "thisimage"));
+		if (read_mmfile(&cur, rerere_path(&buf, id, "thisimage"))) {
 			free(cur.ptr);
 			error(_("failed to update conflicted state in '%s'"), path);
 			goto fail_exit;
@@ -1074,7 +1089,7 @@ static int rerere_forget_one_path(struct index_state *istate,
 		goto fail_exit;
 	}
 
-	filename = rerere_path(id, "postimage");
+	filename = rerere_path(&buf, id, "postimage");
 	if (unlink(filename)) {
 		if (errno == ENOENT)
 			error(_("no remembered resolution for '%s'"), path);
@@ -1088,7 +1103,7 @@ static int rerere_forget_one_path(struct index_state *istate,
 	 * conflict in the working tree, run us again to record
 	 * the postimage.
 	 */
-	handle_cache(istate, path, hash, rerere_path(id, "preimage"));
+	handle_cache(istate, path, hash, rerere_path(&buf, id, "preimage"));
 	fprintf_ln(stderr, _("Updated preimage for '%s'"), path);
 
 	/*
@@ -1099,9 +1114,11 @@ static int rerere_forget_one_path(struct index_state *istate,
 	free_rerere_id(item);
 	item->util = id;
 	fprintf(stderr, _("Forgot resolution for '%s'\n"), path);
+	strbuf_release(&buf);
 	return 0;
 
 fail_exit:
+	strbuf_release(&buf);
 	free(id);
 	return -1;
 }
@@ -1147,16 +1164,26 @@ int rerere_forget(struct repository *r, struct pathspec *pathspec)
 
 static timestamp_t rerere_created_at(struct rerere_id *id)
 {
+	struct strbuf buf = STRBUF_INIT;
 	struct stat st;
+	int ret;
 
-	return stat(rerere_path(id, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
+	ret = stat(rerere_path(&buf, id, "preimage"), &st) ? (time_t) 0 : st.st_mtime;
+
+	strbuf_release(&buf);
+	return ret;
 }
 
 static timestamp_t rerere_last_used_at(struct rerere_id *id)
 {
+	struct strbuf buf = STRBUF_INIT;
 	struct stat st;
+	int ret;
+
+	ret = stat(rerere_path(&buf, id, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
 
-	return stat(rerere_path(id, "postimage"), &st) ? (time_t) 0 : st.st_mtime;
+	strbuf_release(&buf);
+	return ret;
 }
 
 /*
@@ -1164,9 +1191,11 @@ static timestamp_t rerere_last_used_at(struct rerere_id *id)
  */
 static void unlink_rr_item(struct rerere_id *id)
 {
-	unlink_or_warn(rerere_path(id, "thisimage"));
+	struct strbuf buf = STRBUF_INIT;
+	unlink_or_warn(rerere_path(&buf, id, "thisimage"));
 	remove_variant(id);
 	id->collection->status[id->variant] = 0;
+	strbuf_release(&buf);
 }
 
 static void prune_one(struct rerere_id *id,
@@ -1264,10 +1293,14 @@ void rerere_clear(struct repository *r, struct string_list *merge_rr)
 
 	for (i = 0; i < merge_rr->nr; i++) {
 		struct rerere_id *id = merge_rr->items[i].util;
+		struct strbuf buf = STRBUF_INIT;
+
 		if (!has_rerere_resolution(id)) {
 			unlink_rr_item(id);
-			rmdir(rerere_path(id, NULL));
+			rmdir(rerere_path(&buf, id, NULL));
 		}
+
+		strbuf_release(&buf);
 	}
 	unlink_or_warn(git_path_merge_rr(r));
 	rollback_lock_file(&write_lock);
diff --git a/rerere.h b/rerere.h
index 5d6cb63879..d4b5f7c932 100644
--- a/rerere.h
+++ b/rerere.h
@@ -32,7 +32,8 @@ int repo_rerere(struct repository *, int);
  * path to that filesystem entity.  With "file" specified with NULL,
  * return the path to the directory that houses these files.
  */
-const char *rerere_path(const struct rerere_id *, const char *file);
+const char *rerere_path(struct strbuf *buf, const struct rerere_id *,
+			const char *file);
 int rerere_forget(struct repository *, struct pathspec *);
 int rerere_remaining(struct repository *, struct string_list *);
 void rerere_clear(struct repository *, struct string_list *);

-- 
2.48.1.538.gc4cfc42d60.dirty

