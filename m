Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC75288C9A
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913152; cv=none; b=uxAu3Rv+86ywLl9iqmdUfAoRGn3yJy2xC20/mOS03nZPkPoW+hq8mCVXZftu1GD9fHtDyEVgByQsRdSalKgR+JC2+M1uiek8vlD6cj+WFkKi3BXjxJZ8JdWxobjunmsbuIXCGfAfq0EWstkh78GzUxzmMUKro1xCW+QBHkLZQ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913152; c=relaxed/simple;
	bh=bKYijLghwa39ww4M8L0KHTO4Rhl1ZHTorjsNOCuY1xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNtBmSLKJQgEBrmjDa10arQZPnQgznNKB0AOXRAOi0J8vRStjGBWLlcVtubGosva2tCXk9LrFW2Kn3ULilFUqVrhrok7A92Hl8z+yW48hzBUMikiDxz3cQqEhb04x1rwb0JdMyJ2KidnaxJVAAu/BgYFtaKiFFQ3yPDnwrsAWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KcqW/0Lq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rL3E+rse; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KcqW/0Lq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rL3E+rse"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1BA0A13804FC;
	Tue, 29 Apr 2025 03:52:29 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 29 Apr 2025 03:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745913149;
	 x=1745999549; bh=tkMKd6xzyRMS6R0fH3OH20TDJXCZnx4KaqXbvn/IZd0=; b=
	KcqW/0LqkL3YMpMdtqgCNt8cAs9IP6taRwb+kVlLqd4IUohpvqN+ZMIWEyYbUWrv
	28Itp0Kpnj5h8QNToK9SJSk/ZP9+NZWCkn0dfAWtfjz9cDvX2ATc3AcxI6pD5Za4
	lC3/I8A6Sn2Pimn1JK1VkwPCmIhv969zG0e/3s7ddMXjKWzo8equBZ9/70ccMYot
	0yDRoAcK6q5KsUQUyYTVv7PBx1NpG8jLDeufXUKpFfPxdCyt5ThfoJCPUQChFCKj
	1Prt2jPhQ2Il2Ncrgcwg/d6kYJg9HT0QPK1934zhBlliufPxIZ9MKZvtc20bEWsE
	p8CIl0U8NNq8p+JF+u3XEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745913149; x=
	1745999549; bh=tkMKd6xzyRMS6R0fH3OH20TDJXCZnx4KaqXbvn/IZd0=; b=r
	L3E+rse7d6cJsFA1jSu7IbAU6YvTrJrBJwx4Jd5Qrtziyztr2EbvwIFJmb+dJfjq
	EAzHuMvY+WsoFCbt3t/55QP8nd/xwZXYAm9r2DdGOpW2gN9VjUH0GGaVuxYhnBWy
	Y3W3eZcNkKaLdpKEDVt+aSAfFvc1Qm/GmEB5hcqBUBGBr5bAXgKaL828iGDoWEj/
	STqLgfhKHxgIE8PcC+QU0Exxt9UH3rMLnw9NP6J/bYtDZdCFl1A2e5HhpWjFMlKS
	gKUm3tchalBpPFFzE5DaG6yA4oK3L/eLnV+HeBeo1PLYuda+DNGooHUVsFhBmgM2
	sXrm/X3Gmir2Xjxr3naAg==
X-ME-Sender: <xms:PIUQaDjqFhlkIIEJXfndzw4rabs5jGjrXReYMaWupWDE_fGh6iaMYg>
    <xme:PIUQaAAmxggHfzqFg6xAI2cCJuZJN4UU6og7iTWCxiwF-apN83P5mST9KEej7l0ay
    dSeSDfnO_35PM_lIQ>
X-ME-Received: <xmr:PIUQaDGG4sE5NOSkfEfRT5fo_4pCfgrPnl07WJjYuGOMzMpQpNcujroWvToj2k7D04bo1WzJJKJIk4wETxt0-Ltn5Nf1TKOEyXVJ8Tg9DxE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefvdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:PYUQaASVEopGfUsnj1OFzIUeXWVvGvsSkUiaIhI7Cx6UZ0zdJK3taw>
    <xmx:PYUQaAzPvo-dsLYsMyptifB5XsCL98F8WXrk8wqkbB4ncC7o--BKtA>
    <xmx:PYUQaG6MOWoCacs05oWOpci5PJCNu525KGxJRs3xgOuRstHGSJbRHA>
    <xmx:PYUQaFwwsToqLLtWWu-vRMPMEepIq90m5gu_KNpr0ljyzPLDpzJqMw>
    <xmx:PYUQaLsRfQfVI5_05XqqpjMrcnNRHDKlUP01SSXGfmvzzGRezbVlCEG2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 03:52:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 74bb697a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 07:52:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Apr 2025 09:52:20 +0200
Subject: [PATCH v3 6/7] treewide: convert users of `repo_has_object_file()`
 to `has_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-pks-object-store-cleanups-v3-6-42902bad09a1@pks.im>
References: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
In-Reply-To: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

As the comment of `repo_has_object_file()` and its `_with_flags()`
variant tells us, these functions are considered to be deprecated in
favor of `has_object()`. There are a couple of slight benefits in favor
of the replacement:

  - The new function has a short-and-sweet name.

  - More explicit defaults: `has_object()` doesn't fetch missing objects
    via promisor remotes, and neither does it reload packfiles if an
    object wasn't found by default. This ensures that it becomes
    immediately obvious when a simple object existence check may result
    in expensive actions.

Most importantly though, it is confusing that we have two sets of
functions that ultimately do the same thing, but with different
defaults.

Start sunsetting `repo_has_object_file()` and its `_with_flags()`
sibling by replacing all callsites with `has_object()`:

  - `repo_has_object_file(...)` is equivalent to
    `has_object(..., HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)`.

  - `repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT)`
    is equivalent to `has_object(..., 0)`.

  - `repo_has_object_file_with_flags(..., OBJECT_INFO_SKIP_FETCH_OBJECT)`
    is equivalent to `has_object(..., HAS_OBJECT_RECHECK_PACKED)`.

  - `repo_has_object_file_with_flags(..., OBJECT_INFO_QUICK)`
    is equivalent to `has_object(..., HAS_OBJECT_FETCH_PROMISOR)`.

The replacements should be functionally equivalent.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c       |  3 ++-
 builtin/clone.c          |  4 +---
 builtin/fetch.c          | 15 +++++++--------
 builtin/index-pack.c     |  5 ++---
 builtin/receive-pack.c   |  4 +++-
 builtin/remote.c         |  3 ++-
 builtin/show-ref.c       |  3 ++-
 builtin/unpack-objects.c |  3 ++-
 bulk-checkin.c           |  3 ++-
 cache-tree.c             | 13 +++++++++----
 fetch-pack.c             |  7 +++----
 http-push.c              | 11 +++++++----
 http-walker.c            |  6 ++++--
 list-objects.c           |  3 ++-
 notes.c                  |  3 ++-
 object-store.c           |  2 +-
 reflog.c                 |  3 ++-
 refs.c                   |  2 +-
 remote.c                 |  2 +-
 send-pack.c              |  5 +----
 shallow.c                |  9 ++++++---
 upload-pack.c            |  3 +--
 walker.c                 |  3 ++-
 23 files changed, 65 insertions(+), 50 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0e3f10a9467..3914a2a3f61 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -169,7 +169,8 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 		goto cleanup;
 
 	case 'e':
-		ret = !repo_has_object_file(the_repository, &oid);
+		ret = !has_object(the_repository, &oid,
+				  HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR);
 		goto cleanup;
 
 	case 'w':
diff --git a/builtin/clone.c b/builtin/clone.c
index 6b1d11a3ed2..b498b81a043 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -504,9 +504,7 @@ static void write_followtags(const struct ref *refs, const char *msg)
 			continue;
 		if (ends_with(ref->name, "^{}"))
 			continue;
-		if (!repo_has_object_file_with_flags(the_repository, &ref->old_oid,
-						     OBJECT_INFO_QUICK |
-						     OBJECT_INFO_SKIP_FETCH_OBJECT))
+		if (!has_object(the_repository, &ref->old_oid, 0))
 			continue;
 		refs_update_ref(get_main_ref_store(the_repository), msg,
 				ref->name, &ref->old_oid, NULL, 0,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 95589b49948..aadcf49a5b4 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -337,7 +337,6 @@ static void find_non_local_tags(const struct ref *refs,
 	struct string_list_item *remote_ref_item;
 	const struct ref *ref;
 	struct refname_hash_entry *item = NULL;
-	const int quick_flags = OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT;
 
 	refname_hash_init(&existing_refs);
 	refname_hash_init(&remote_refs);
@@ -367,9 +366,9 @@ static void find_non_local_tags(const struct ref *refs,
 		 */
 		if (ends_with(ref->name, "^{}")) {
 			if (item &&
-			    !repo_has_object_file_with_flags(the_repository, &ref->old_oid, quick_flags) &&
+			    !has_object(the_repository, &ref->old_oid, 0) &&
 			    !oidset_contains(&fetch_oids, &ref->old_oid) &&
-			    !repo_has_object_file_with_flags(the_repository, &item->oid, quick_flags) &&
+			    !has_object(the_repository, &item->oid, 0) &&
 			    !oidset_contains(&fetch_oids, &item->oid))
 				clear_item(item);
 			item = NULL;
@@ -383,7 +382,7 @@ static void find_non_local_tags(const struct ref *refs,
 		 * fetch.
 		 */
 		if (item &&
-		    !repo_has_object_file_with_flags(the_repository, &item->oid, quick_flags) &&
+		    !has_object(the_repository, &item->oid, 0) &&
 		    !oidset_contains(&fetch_oids, &item->oid))
 			clear_item(item);
 
@@ -404,7 +403,7 @@ static void find_non_local_tags(const struct ref *refs,
 	 * checked to see if it needs fetching.
 	 */
 	if (item &&
-	    !repo_has_object_file_with_flags(the_repository, &item->oid, quick_flags) &&
+	    !has_object(the_repository, &item->oid, 0) &&
 	    !oidset_contains(&fetch_oids, &item->oid))
 		clear_item(item);
 
@@ -911,7 +910,8 @@ static int update_local_ref(struct ref *ref,
 	struct commit *current = NULL, *updated;
 	int fast_forward = 0;
 
-	if (!repo_has_object_file(the_repository, &ref->new_oid))
+	if (!has_object(the_repository, &ref->new_oid,
+			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		die(_("object %s not found"), oid_to_hex(&ref->new_oid));
 
 	if (oideq(&ref->old_oid, &ref->new_oid)) {
@@ -1330,8 +1330,7 @@ static int check_exist_and_connected(struct ref *ref_map)
 	 * we need all direct targets to exist.
 	 */
 	for (r = rm; r; r = r->next) {
-		if (!repo_has_object_file_with_flags(the_repository, &r->old_oid,
-						     OBJECT_INFO_SKIP_FETCH_OBJECT))
+		if (!has_object(the_repository, &r->old_oid, HAS_OBJECT_RECHECK_PACKED))
 			return -1;
 	}
 
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index f49431d626b..147e9b8b479 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -892,9 +892,8 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 
 	if (startup_info->have_repository) {
 		read_lock();
-		collision_test_needed =
-			repo_has_object_file_with_flags(the_repository, oid,
-							OBJECT_INFO_QUICK);
+		collision_test_needed = has_object(the_repository, oid,
+						   HAS_OBJECT_FETCH_PROMISOR);
 		read_unlock();
 	}
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index be314879e82..c92e57ba188 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1506,7 +1506,9 @@ static const char *update(struct command *cmd, struct shallow_info *si)
 		}
 	}
 
-	if (!is_null_oid(new_oid) && !repo_has_object_file(the_repository, new_oid)) {
+	if (!is_null_oid(new_oid) &&
+	    !has_object(the_repository, new_oid,
+			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 		error("unpack should have generated %s, "
 		      "but I can't find it!", oid_to_hex(new_oid));
 		ret = "bad pack";
diff --git a/builtin/remote.c b/builtin/remote.c
index b4baa34e665..0d6755bcb71 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -454,7 +454,8 @@ static int get_push_ref_states(const struct ref *remote_refs,
 			info->status = PUSH_STATUS_UPTODATE;
 		else if (is_null_oid(&ref->old_oid))
 			info->status = PUSH_STATUS_CREATE;
-		else if (repo_has_object_file(the_repository, &ref->old_oid) &&
+		else if (has_object(the_repository, &ref->old_oid,
+				    HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) &&
 			 ref_newer(&ref->new_oid, &ref->old_oid))
 			info->status = PUSH_STATUS_FASTFORWARD;
 		else
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index f81209f23c3..623a52a45f8 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -35,7 +35,8 @@ static void show_one(const struct show_one_options *opts,
 	const char *hex;
 	struct object_id peeled;
 
-	if (!repo_has_object_file(the_repository, oid))
+	if (!has_object(the_repository, oid,
+			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		die("git show-ref: bad ref %s (%s)", refname,
 		    oid_to_hex(oid));
 
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 661be789f13..e905d5f4e19 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -449,7 +449,8 @@ static void unpack_delta_entry(enum object_type type, unsigned long delta_size,
 		delta_data = get_data(delta_size);
 		if (!delta_data)
 			return;
-		if (repo_has_object_file(the_repository, &base_oid))
+		if (has_object(the_repository, &base_oid,
+			       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			; /* Ok we have this one */
 		else if (resolve_against_held(nr, &base_oid,
 					      delta_data, delta_size))
diff --git a/bulk-checkin.c b/bulk-checkin.c
index c31c31b18d8..678e2ecc2c2 100644
--- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -130,7 +130,8 @@ static void flush_batch_fsync(void)
 static int already_written(struct bulk_checkin_packfile *state, struct object_id *oid)
 {
 	/* The object may already exist in the repository */
-	if (repo_has_object_file(the_repository, oid))
+	if (has_object(the_repository, oid,
+		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 1;
 
 	/* Might want to keep the list sorted */
diff --git a/cache-tree.c b/cache-tree.c
index c0e1e9ee1d4..fa3858e2829 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -238,7 +238,9 @@ int cache_tree_fully_valid(struct cache_tree *it)
 	int i;
 	if (!it)
 		return 0;
-	if (it->entry_count < 0 || !repo_has_object_file(the_repository, &it->oid))
+	if (it->entry_count < 0 ||
+	    has_object(the_repository, &it->oid,
+		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 0;
 	for (i = 0; i < it->subtree_nr; i++) {
 		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
@@ -289,7 +291,9 @@ static int update_one(struct cache_tree *it,
 		}
 	}
 
-	if (0 <= it->entry_count && repo_has_object_file(the_repository, &it->oid))
+	if (0 <= it->entry_count &&
+	    has_object(the_repository, &it->oid,
+		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return it->entry_count;
 
 	/*
@@ -395,7 +399,8 @@ static int update_one(struct cache_tree *it,
 		ce_missing_ok = mode == S_IFGITLINK || missing_ok ||
 			!must_check_existence(ce);
 		if (is_null_oid(oid) ||
-		    (!ce_missing_ok && !repo_has_object_file(the_repository, oid))) {
+		    (!ce_missing_ok && !has_object(the_repository, oid,
+						   HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))) {
 			strbuf_release(&buffer);
 			if (expected_missing)
 				return -1;
@@ -443,7 +448,7 @@ static int update_one(struct cache_tree *it,
 		struct object_id oid;
 		hash_object_file(the_hash_algo, buffer.buf, buffer.len,
 				 OBJ_TREE, &oid);
-		if (repo_has_object_file_with_flags(the_repository, &oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
+		if (has_object(the_repository, &oid, HAS_OBJECT_RECHECK_PACKED))
 			oidcpy(&it->oid, &oid);
 		else
 			to_invalidate = 1;
diff --git a/fetch-pack.c b/fetch-pack.c
index 210dc30d50f..fa4231fee74 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -769,9 +769,7 @@ static void mark_complete_and_common_ref(struct fetch_negotiator *negotiator,
 		if (!commit) {
 			struct object *o;
 
-			if (!repo_has_object_file_with_flags(the_repository, &ref->old_oid,
-							     OBJECT_INFO_QUICK |
-							     OBJECT_INFO_SKIP_FETCH_OBJECT))
+			if (!has_object(the_repository, &ref->old_oid, 0))
 				continue;
 			o = parse_object(the_repository, &ref->old_oid);
 			if (!o || o->type != OBJ_COMMIT)
@@ -1985,7 +1983,8 @@ static void update_shallow(struct fetch_pack_args *args,
 		struct oid_array extra = OID_ARRAY_INIT;
 		struct object_id *oid = si->shallow->oid;
 		for (i = 0; i < si->shallow->nr; i++)
-			if (repo_has_object_file(the_repository, &oid[i]))
+			if (has_object(the_repository, &oid[i],
+				       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 				oid_array_append(&extra, &oid[i]);
 		if (extra.nr) {
 			setup_alternate_shallow(&shallow_lock,
diff --git a/http-push.c b/http-push.c
index 32e37565f4e..f9e67cabd4b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1446,7 +1446,9 @@ static void one_remote_ref(const char *refname)
 	 * Fetch a copy of the object if it doesn't exist locally - it
 	 * may be required for updating server info later.
 	 */
-	if (repo->can_update_info_refs && !repo_has_object_file(the_repository, &ref->old_oid)) {
+	if (repo->can_update_info_refs &&
+	    !has_object(the_repository, &ref->old_oid,
+			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 		obj = lookup_unknown_object(the_repository, &ref->old_oid);
 		fprintf(stderr,	"  fetch %s for %s\n",
 			oid_to_hex(&ref->old_oid), refname);
@@ -1651,14 +1653,14 @@ static int delete_remote_branch(const char *pattern, int force)
 			return error("Remote HEAD symrefs too deep");
 		if (is_null_oid(&head_oid))
 			return error("Unable to resolve remote HEAD");
-		if (!repo_has_object_file(the_repository, &head_oid))
+		if (!has_object(the_repository, &head_oid, HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			return error("Remote HEAD resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", oid_to_hex(&head_oid));
 
 		/* Remote branch must resolve to a known object */
 		if (is_null_oid(&remote_ref->old_oid))
 			return error("Unable to resolve remote branch %s",
 				     remote_ref->name);
-		if (!repo_has_object_file(the_repository, &remote_ref->old_oid))
+		if (!has_object(the_repository, &remote_ref->old_oid, HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			return error("Remote branch %s resolves to object %s\nwhich does not exist locally, perhaps you need to fetch?", remote_ref->name, oid_to_hex(&remote_ref->old_oid));
 
 		/* Remote branch must be an ancestor of remote HEAD */
@@ -1879,7 +1881,8 @@ int cmd_main(int argc, const char **argv)
 		if (!force_all &&
 		    !is_null_oid(&ref->old_oid) &&
 		    !ref->force) {
-			if (!repo_has_object_file(the_repository, &ref->old_oid) ||
+			if (!has_object(the_repository, &ref->old_oid,
+					HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) ||
 			    !ref_newer(&ref->peer_ref->new_oid,
 				       &ref->old_oid)) {
 				/*
diff --git a/http-walker.c b/http-walker.c
index 95458e2f638..463f7b119ad 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -138,7 +138,8 @@ static int fill_active_slot(void *data UNUSED)
 	list_for_each_safe(pos, tmp, head) {
 		obj_req = list_entry(pos, struct object_request, node);
 		if (obj_req->state == WAITING) {
-			if (repo_has_object_file(the_repository, &obj_req->oid))
+			if (has_object(the_repository, &obj_req->oid,
+				       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 				obj_req->state = COMPLETE;
 			else {
 				start_object_request(obj_req);
@@ -496,7 +497,8 @@ static int fetch_object(struct walker *walker, const struct object_id *oid)
 	if (!obj_req)
 		return error("Couldn't find request for %s in the queue", hex);
 
-	if (repo_has_object_file(the_repository, &obj_req->oid)) {
+	if (has_object(the_repository, &obj_req->oid,
+		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 		if (obj_req->req)
 			abort_http_object_request(&obj_req->req);
 		abort_object_request(obj_req);
diff --git a/list-objects.c b/list-objects.c
index 1e5512e1318..597114281f6 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -74,7 +74,8 @@ static void process_blob(struct traversal_context *ctx,
 	 * of missing objects.
 	 */
 	if (ctx->revs->exclude_promisor_objects &&
-	    !repo_has_object_file(the_repository, &obj->oid) &&
+	    !has_object(the_repository, &obj->oid,
+			HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) &&
 	    is_promisor_object(ctx->revs->repo, &obj->oid))
 		return;
 
diff --git a/notes.c b/notes.c
index d9645c4b5dc..0a128f1de98 100644
--- a/notes.c
+++ b/notes.c
@@ -794,7 +794,8 @@ static int prune_notes_helper(const struct object_id *object_oid,
 	struct note_delete_list **l = (struct note_delete_list **) cb_data;
 	struct note_delete_list *n;
 
-	if (repo_has_object_file(the_repository, object_oid))
+	if (has_object(the_repository, object_oid,
+		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 		return 0; /* nothing to do for this note */
 
 	/* failed to find object => prune this note */
diff --git a/object-store.c b/object-store.c
index 0d873868a6d..2db34804e8f 100644
--- a/object-store.c
+++ b/object-store.c
@@ -847,7 +847,7 @@ int pretend_object_file(struct repository *repo,
 	char *co_buf;
 
 	hash_object_file(repo->hash_algo, buf, len, type, oid);
-	if (repo_has_object_file_with_flags(repo, oid, OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT) ||
+	if (has_object(repo, oid, 0) ||
 	    find_cached_object(repo->objects, oid))
 		return 0;
 
diff --git a/reflog.c b/reflog.c
index c6c534dfad4..2db1cc81d01 100644
--- a/reflog.c
+++ b/reflog.c
@@ -152,7 +152,8 @@ static int tree_is_complete(const struct object_id *oid)
 	init_tree_desc(&desc, &tree->object.oid, tree->buffer, tree->size);
 	complete = 1;
 	while (tree_entry(&desc, &entry)) {
-		if (!repo_has_object_file(the_repository, &entry.oid) ||
+		if (!has_object(the_repository, &entry.oid,
+				HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR) ||
 		    (S_ISDIR(entry.mode) && !tree_is_complete(&entry.oid))) {
 			tree->object.flags |= INCOMPLETE;
 			complete = 0;
diff --git a/refs.c b/refs.c
index 6559db37890..dce5c49ca2b 100644
--- a/refs.c
+++ b/refs.c
@@ -376,7 +376,7 @@ int ref_resolves_to_object(const char *refname,
 {
 	if (flags & REF_ISBROKEN)
 		return 0;
-	if (!repo_has_object_file(repo, oid)) {
+	if (!has_object(repo, oid, HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 		error(_("%s does not point to a valid object!"), refname);
 		return 0;
 	}
diff --git a/remote.c b/remote.c
index 9fa3614e7a3..4099183cacd 100644
--- a/remote.c
+++ b/remote.c
@@ -1702,7 +1702,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		if (!reject_reason && !ref->deletion && !is_null_oid(&ref->old_oid)) {
 			if (starts_with(ref->name, "refs/tags/"))
 				reject_reason = REF_STATUS_REJECT_ALREADY_EXISTS;
-			else if (!repo_has_object_file_with_flags(the_repository, &ref->old_oid, OBJECT_INFO_SKIP_FETCH_OBJECT))
+			else if (!has_object(the_repository, &ref->old_oid, HAS_OBJECT_RECHECK_PACKED))
 				reject_reason = REF_STATUS_REJECT_FETCH_FIRST;
 			else if (!lookup_commit_reference_gently(the_repository, &ref->old_oid, 1) ||
 				 !lookup_commit_reference_gently(the_repository, &ref->new_oid, 1))
diff --git a/send-pack.c b/send-pack.c
index 5005689cb55..86592ce526d 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -45,10 +45,7 @@ int option_parse_push_signed(const struct option *opt,
 static void feed_object(struct repository *r,
 			const struct object_id *oid, FILE *fh, int negative)
 {
-	if (negative &&
-	    !repo_has_object_file_with_flags(r, oid,
-					     OBJECT_INFO_SKIP_FETCH_OBJECT |
-					     OBJECT_INFO_QUICK))
+	if (negative && !has_object(r, oid, 0))
 		return;
 
 	if (negative)
diff --git a/shallow.c b/shallow.c
index 2f82ebd6e3f..faeeeb45f98 100644
--- a/shallow.c
+++ b/shallow.c
@@ -310,7 +310,8 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	if (graft->nr_parent != -1)
 		return 0;
 	if (data->flags & QUICK) {
-		if (!repo_has_object_file(the_repository, &graft->oid))
+		if (!has_object(the_repository, &graft->oid,
+				HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			return 0;
 	} else if (data->flags & SEEN_ONLY) {
 		struct commit *c = lookup_commit(the_repository, &graft->oid);
@@ -476,7 +477,8 @@ void prepare_shallow_info(struct shallow_info *info, struct oid_array *sa)
 	ALLOC_ARRAY(info->ours, sa->nr);
 	ALLOC_ARRAY(info->theirs, sa->nr);
 	for (size_t i = 0; i < sa->nr; i++) {
-		if (repo_has_object_file(the_repository, sa->oid + i)) {
+		if (has_object(the_repository, sa->oid + i,
+			       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 			struct commit_graft *graft;
 			graft = lookup_commit_graft(the_repository,
 						    &sa->oid[i]);
@@ -513,7 +515,8 @@ void remove_nonexistent_theirs_shallow(struct shallow_info *info)
 	for (i = dst = 0; i < info->nr_theirs; i++) {
 		if (i != dst)
 			info->theirs[dst] = info->theirs[i];
-		if (repo_has_object_file(the_repository, oid + info->theirs[i]))
+		if (has_object(the_repository, oid + info->theirs[i],
+			       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR))
 			dst++;
 	}
 	info->nr_theirs = dst;
diff --git a/upload-pack.c b/upload-pack.c
index 30e4630f3a1..956da5b061a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -509,8 +509,7 @@ static int got_oid(struct upload_pack_data *data,
 {
 	if (get_oid_hex(hex, oid))
 		die("git upload-pack: expected SHA1 object, got '%s'", hex);
-	if (!repo_has_object_file_with_flags(the_repository, oid,
-					     OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH_OBJECT))
+	if (!has_object(the_repository, oid, 0))
 		return -1;
 	return do_got_oid(data, oid);
 }
diff --git a/walker.c b/walker.c
index 4fedc19f346..b470d43e54d 100644
--- a/walker.c
+++ b/walker.c
@@ -150,7 +150,8 @@ static int process(struct walker *walker, struct object *obj)
 		return 0;
 	obj->flags |= SEEN;
 
-	if (repo_has_object_file(the_repository, &obj->oid)) {
+	if (has_object(the_repository, &obj->oid,
+		       HAS_OBJECT_RECHECK_PACKED | HAS_OBJECT_FETCH_PROMISOR)) {
 		/* We already have it, so we should scan it now. */
 		obj->flags |= TO_SCAN;
 	}

-- 
2.49.0.967.g6a0df3ecc3.dirty

