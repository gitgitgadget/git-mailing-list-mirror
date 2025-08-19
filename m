Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F96311C3C
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755591624; cv=none; b=o0mBBS32Bj9V4jAvi4YgzkjgPeaEorrvv/OVuLDYRD6xm8YGzxhVFlTtySLcvqoxUDr2frIb5kr9AdmISi0YN72dMeS9BiV1UkKYE8FVX/DM5Ud6KJtdxIWMKQZcFYUN9lZoSiwUUbpkD5y24TK+dxBsonFJTgEUIWZ5x/86H74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755591624; c=relaxed/simple;
	bh=N3ctK/44RGuYus4l12ofcSQ+FfXre5ff7p+UDntGvUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMmNKNWQo+CNa3SSZWswTV3/4i05fc7da682U4fYxYNdIsPMFJb5CaTYDwjn7L9WVCeC4ClXYwhf1Cq/1mfhhp37AYNF7eCV3VlQV6/QGBOblsW0r8qKvf+Kxn1d9TktNc4krtAbEtPYbxsdFk/7zkSdzNYcO394FkZQ5pxivDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H+r522y2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EpljNEET; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H+r522y2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EpljNEET"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 4AF081D0025D
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:21 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 19 Aug 2025 04:20:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1755591621;
	 x=1755678021; bh=UD7oH96RdFJMvJWtEdptn8JLLLvVYmAJI7k/ch2J7/A=; b=
	H+r522y2Ds2Av25N0Bqyf+AbHhv9YIjdEb6ZfNOIupArot80xRaod57LQ2O+MFdd
	76wYpFz7VsYP6i/ARrGD34g9n+l9vgNY8a8Ab7b7+BQTxO67o9cuBOs5/iiNMzEq
	kccd/TnZZJTtA0LPgNROx5in9AXRM9xO2wJdWPd48VjyU1hs2eH6zIrfiIPYzQbh
	2Fi18x9gZDMykYuhmq2vWOvFrf1q6KiwGjeY2xUJHV92xN5vvaMkOIrNChI4ko4D
	I4XL0o8j4QiUmsMXLD3/uRf04w7Ny/N00tEla4mOs9MbWZL2TncxbVyToQxwPzz+
	FQdmHWfNjxGRE1ckrVBIhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755591621; x=
	1755678021; bh=UD7oH96RdFJMvJWtEdptn8JLLLvVYmAJI7k/ch2J7/A=; b=E
	pljNEETpCStm8VzJrXVF0MrJhzPnQZ68zqiWvDBhO1Jmafk7ZAnm8/lD0Y9lDM2z
	/bft3BHx0Ai48f+jjguMRx3zcAD4IfX1pIFwT42QFB5VM37gRry1DWMuBPC3PjiO
	Cq0Ntyu1hhTPuQMlSy52wDoVzZ3EiVSkKKVr/gS72/UuWvttgJpPXnqdtcgmbH8O
	0E5iJlOIisE+qRLS8e845MBaI2npZMGEYHnqhB5srGkIKGpE08Kj8MprjuQf5quX
	381SZneoGgs64rZY2HjwE0tZQstwGLCLVEnLx6ALBX+nZmSc/+tlqGxVAhddvfQ9
	w6+Xbptvsy0nOKs3l5B/Q==
X-ME-Sender: <xms:xTOkaCsxQPNxT2EJ2MxPjpoi577x7-tdHDC85JinYmw63PxIFqibew>
    <xme:xTOkaJf8R1g2bGCAl2W6kjHCC4OWuAwBTbubb8tU3nDjcMKSBNT4TX9QDbdyfs8gB
    3_1ldxg-ml48m7xjg>
X-ME-Received: <xmr:xTOkaHK3P3mfrCjzB7z5Pcz3u6cA1j6rVbwP2j7Kmd-QzQcAySbCSMSSnJprD_6bm5EvTgWlAUpWDx7tvsMxELUbZh_ljU6RIVXzo1golidn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduheehtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:xTOkaPZ8Lnl-TeYK3jK056AGDSEM5S508lHbPfZ5r41rELeU8DS3gg>
    <xmx:xTOkaKslg6VavQXNId1aag-BcODh9X6qwoKvjuI2QvWrmSsYbB53Dw>
    <xmx:xTOkaEu1UV81YCROabVPA_L6PO86IpUiVPbf7-ZOdRfRDzP_iBLLAQ>
    <xmx:xTOkaHcyYwKU4RX16EVN6uNgMN1UShQ75Yb557jDUcA0KvHrQiibqA>
    <xmx:xTOkaGXLatNWgYw5FCBnI3vSD9wYAKXfw-xZXZlnK47XleMx9NlK6wPv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 19 Aug 2025 04:20:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad6dde32 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Tue, 19 Aug 2025 08:20:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 Aug 2025 10:19:44 +0200
Subject: [PATCH 15/16] packfile: refactor `get_all_packs()` to work on
 packfile store
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-b4-pks-packfiles-store-v1-15-1660842e125a@pks.im>
References: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
In-Reply-To: <20250819-b4-pks-packfiles-store-v1-0-1660842e125a@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The `get_all_packs()` function prepares the packfile store and then
returns its packfiles. Refactor it to accept a packfile store instead of
a repository to clarify its scope.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c          |  2 +-
 builtin/count-objects.c     |  2 +-
 builtin/fast-import.c       |  4 ++--
 builtin/fsck.c              |  8 ++++----
 builtin/gc.c                |  8 ++++----
 builtin/pack-objects.c      | 18 +++++++++---------
 builtin/pack-redundant.c    |  4 ++--
 builtin/repack.c            |  6 +++---
 connected.c                 |  2 +-
 http-backend.c              |  4 ++--
 http.c                      |  2 +-
 object-name.c               |  4 ++--
 pack-bitmap.c               |  4 ++--
 pack-objects.c              |  2 +-
 packfile.c                  | 14 +++++++-------
 packfile.h                  |  7 ++++++-
 server-info.c               |  2 +-
 t/helper/test-find-pack.c   |  2 +-
 t/helper/test-pack-mtimes.c |  2 +-
 19 files changed, 51 insertions(+), 46 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index fce0b06451c..7124c43fb14 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -854,7 +854,7 @@ static void batch_each_object(struct batch_options *opt,
 						 batch_one_object_bitmapped, &payload)) {
 		struct packed_git *pack;
 
-		for (pack = get_all_packs(the_repository); pack; pack = pack->next) {
+		for (pack = packfile_store_get_packs(the_repository->objects->packfiles); pack; pack = pack->next) {
 			if (bitmap_index_contains_pack(bitmap, pack) ||
 			    open_pack_index(pack))
 				continue;
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index a61d3b46aac..471d96a3089 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -129,7 +129,7 @@ int cmd_count_objects(int argc,
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
 
-		for (p = get_all_packs(the_repository); p; p = p->next) {
+		for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 			if (!p->pack_local)
 				continue;
 			if (open_pack_index(p))
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index a26e79689d5..4f355118a10 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -975,7 +975,7 @@ static int store_object(
 	if (e->idx.offset) {
 		duplicate_count_by_type[type]++;
 		return 1;
-	} else if (find_oid_pack(&oid, get_all_packs(the_repository))) {
+	} else if (find_oid_pack(&oid, packfile_store_get_packs(the_repository->objects->packfiles))) {
 		e->type = type;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
@@ -1175,7 +1175,7 @@ static void stream_blob(uintmax_t len, struct object_id *oidout, uintmax_t mark)
 		duplicate_count_by_type[OBJ_BLOB]++;
 		truncate_pack(&checkpoint);
 
-	} else if (find_oid_pack(&oid, get_all_packs(the_repository))) {
+	} else if (find_oid_pack(&oid, packfile_store_get_packs(the_repository->objects->packfiles))) {
 		e->type = OBJ_BLOB;
 		e->pack_id = MAX_PACK_ID;
 		e->idx.offset = 1; /* just not zero! */
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 543a2cdb5cd..e867fd510a3 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -873,14 +873,14 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 	int res = 0;
 
 	if (show_progress) {
-		for (struct packed_git *p = get_all_packs(r); p; p = p->next)
+		for (struct packed_git *p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next)
 			pack_count++;
 		progress = start_delayed_progress(the_repository,
 						  "Verifying reverse pack-indexes", pack_count);
 		pack_count = 0;
 	}
 
-	for (struct packed_git *p = get_all_packs(r); p; p = p->next) {
+	for (struct packed_git *p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
 		int load_error = load_pack_revindex_from_disk(p);
 
 		if (load_error < 0) {
@@ -1010,7 +1010,7 @@ int cmd_fsck(int argc,
 			struct progress *progress = NULL;
 
 			if (show_progress) {
-				for (p = get_all_packs(the_repository); p;
+				for (p = packfile_store_get_packs(the_repository->objects->packfiles); p;
 				     p = p->next) {
 					if (open_pack_index(p))
 						continue;
@@ -1020,7 +1020,7 @@ int cmd_fsck(int argc,
 				progress = start_progress(the_repository,
 							  _("Checking objects"), total);
 			}
-			for (p = get_all_packs(the_repository); p;
+			for (p = packfile_store_get_packs(the_repository->objects->packfiles); p;
 			     p = p->next) {
 				/* verify gives error messages itself */
 				if (verify_pack(the_repository,
diff --git a/builtin/gc.c b/builtin/gc.c
index 565afda51fe..030d0b0c774 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -488,7 +488,7 @@ static struct packed_git *find_base_packs(struct string_list *packs,
 {
 	struct packed_git *p, *base = NULL;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		if (!p->pack_local || p->is_cruft)
 			continue;
 		if (limit) {
@@ -513,7 +513,7 @@ static int too_many_packs(struct gc_config *cfg)
 	if (cfg->gc_auto_pack_limit <= 0)
 		return 0;
 
-	for (cnt = 0, p = get_all_packs(the_repository); p; p = p->next) {
+	for (cnt = 0, p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		if (!p->pack_local)
 			continue;
 		if (p->pack_keep)
@@ -1422,7 +1422,7 @@ static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
 	if (incremental_repack_auto_limit < 0)
 		return 1;
 
-	for (p = get_all_packs(the_repository);
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles);
 	     count < incremental_repack_auto_limit && p;
 	     p = p->next) {
 		if (!p->multi_pack_index)
@@ -1491,7 +1491,7 @@ static off_t get_auto_pack_size(void)
 	struct repository *r = the_repository;
 
 	odb_reprepare(r->objects);
-	for (p = get_all_packs(r); p; p = p->next) {
+	for (p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
 		if (p->pack_size > max_size) {
 			second_largest_size = max_size;
 			max_size = p->pack_size;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 53a22562503..1c24b84510e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3855,7 +3855,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 	string_list_sort(&exclude_packs);
 	string_list_remove_duplicates(&exclude_packs, 0);
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		const char *pack_name = pack_basename(p);
 
 		if ((item = string_list_lookup(&include_packs, pack_name)))
@@ -4105,7 +4105,7 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
 	 * Re-mark only the fresh packs as kept so that objects in
 	 * unknown packs do not halt the reachability traversal early.
 	 */
-	for (p = get_all_packs(the_repository); p; p = p->next)
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next)
 		p->pack_keep_in_core = 0;
 	mark_pack_kept_in_core(fresh_packs, 1);
 
@@ -4142,7 +4142,7 @@ static void read_cruft_objects(void)
 	string_list_sort(&discard_packs);
 	string_list_sort(&fresh_packs);
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		const char *pack_name = pack_basename(p);
 		struct string_list_item *item;
 
@@ -4394,7 +4394,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 	struct packed_git *p;
 
 	p = (last_found != (void *)1) ? last_found :
-					get_all_packs(the_repository);
+					packfile_store_get_packs(the_repository->objects->packfiles);
 
 	while (p) {
 		if ((!p->pack_local || p->pack_keep ||
@@ -4404,7 +4404,7 @@ static int has_sha1_pack_kept_or_nonlocal(const struct object_id *oid)
 			return 1;
 		}
 		if (p == last_found)
-			p = get_all_packs(the_repository);
+			p = packfile_store_get_packs(the_repository->objects->packfiles);
 		else
 			p = p->next;
 		if (p == last_found)
@@ -4441,7 +4441,7 @@ static void loosen_unused_packed_objects(void)
 	uint32_t loosened_objects_nr = 0;
 	struct object_id oid;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
 			continue;
 
@@ -4747,7 +4747,7 @@ static void add_extra_kept_packs(const struct string_list *names)
 	if (!names->nr)
 		return;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		const char *name = basename(p->pack_name);
 		int i;
 
@@ -5186,7 +5186,7 @@ int cmd_pack_objects(int argc,
 	add_extra_kept_packs(&keep_pack_list);
 	if (ignore_packed_keep_on_disk) {
 		struct packed_git *p;
-		for (p = get_all_packs(the_repository); p; p = p->next)
+		for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next)
 			if (p->pack_local && p->pack_keep)
 				break;
 		if (!p) /* no keep-able packs found */
@@ -5199,7 +5199,7 @@ int cmd_pack_objects(int argc,
 		 * it also covers non-local objects
 		 */
 		struct packed_git *p;
-		for (p = get_all_packs(the_repository); p; p = p->next) {
+		for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 			if (!p->pack_local) {
 				have_non_local_packs = 1;
 				break;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index fe81c293e3a..7b2cb3ef1e2 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -566,7 +566,7 @@ static struct pack_list * add_pack(struct packed_git *p)
 
 static struct pack_list * add_pack_file(const char *filename)
 {
-	struct packed_git *p = get_all_packs(the_repository);
+	struct packed_git *p = packfile_store_get_packs(the_repository->objects->packfiles);
 
 	if (strlen(filename) < 40)
 		die("Bad pack filename: %s", filename);
@@ -581,7 +581,7 @@ static struct pack_list * add_pack_file(const char *filename)
 
 static void load_all(void)
 {
-	struct packed_git *p = get_all_packs(the_repository);
+	struct packed_git *p = packfile_store_get_packs(the_repository->objects->packfiles);
 
 	while (p) {
 		add_pack(p);
diff --git a/builtin/repack.c b/builtin/repack.c
index ee8c80cd95c..6119e236512 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -267,7 +267,7 @@ static void collect_pack_filenames(struct existing_packs *existing,
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		int i;
 		const char *base;
 
@@ -499,7 +499,7 @@ static void init_pack_geometry(struct pack_geometry *geometry,
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		if (args->local && !p->pack_local)
 			/*
 			 * When asked to only repack local packfiles we skip
@@ -1140,7 +1140,7 @@ static void combine_small_cruft_packs(FILE *in, size_t combine_cruft_below_size,
 	struct strbuf buf = STRBUF_INIT;
 	size_t i;
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		if (!(p->is_cruft && p->pack_local))
 			continue;
 
diff --git a/connected.c b/connected.c
index d6e9682fd93..d7e07fa6b0d 100644
--- a/connected.c
+++ b/connected.c
@@ -76,7 +76,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		do {
 			struct packed_git *p;
 
-			for (p = get_all_packs(the_repository); p; p = p->next) {
+			for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 				if (!p->pack_promisor)
 					continue;
 				if (find_pack_entry_one(oid, p))
diff --git a/http-backend.c b/http-backend.c
index d5dfe762bb5..be4d8263a58 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -608,13 +608,13 @@ static void get_info_packs(struct strbuf *hdr, char *arg UNUSED)
 	size_t cnt = 0;
 
 	select_getanyfile(hdr);
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		if (p->pack_local)
 			cnt++;
 	}
 
 	strbuf_grow(&buf, cnt * 53 + 2);
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		if (p->pack_local)
 			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
 	}
diff --git a/http.c b/http.c
index af2120b64c7..16a1ab54f34 100644
--- a/http.c
+++ b/http.c
@@ -2416,7 +2416,7 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	 * If we already have the pack locally, no need to fetch its index or
 	 * even add it to list; we already have all of its objects.
 	 */
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		if (hasheq(p->hash, sha1, the_repository->hash_algo))
 			return 0;
 	}
diff --git a/object-name.c b/object-name.c
index c87995cc1e6..e346075394d 100644
--- a/object-name.c
+++ b/object-name.c
@@ -213,7 +213,7 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 			unique_in_midx(m, ds);
 	}
 
-	for (p = get_all_packs(ds->repo); p && !ds->ambiguous;
+	for (p = packfile_store_get_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
 	     p = p->next)
 		unique_in_pack(p, ds);
 }
@@ -806,7 +806,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 			find_abbrev_len_for_midx(m, mad);
 	}
 
-	for (p = get_all_packs(mad->repo); p; p = p->next)
+	for (p = packfile_store_get_packs(mad->repo->objects->packfiles); p; p = p->next)
 		find_abbrev_len_for_pack(p, mad);
 }
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index d14421ee204..67f9e92ec18 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -665,7 +665,7 @@ static int open_pack_bitmap(struct repository *r,
 	struct packed_git *p;
 	int ret = -1;
 
-	for (p = get_all_packs(r); p; p = p->next) {
+	for (p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
 		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
 			ret = 0;
 			/*
@@ -3363,7 +3363,7 @@ int verify_bitmap_files(struct repository *r)
 		free(midx_bitmap_name);
 	}
 
-	for (struct packed_git *p = get_all_packs(r);
+	for (struct packed_git *p = packfile_store_get_packs(r->objects->packfiles);
 	     p; p = p->next) {
 		char *pack_bitmap_name = pack_bitmap_filename(p);
 		res |= verify_bitmap_file(r->hash_algo, pack_bitmap_name);
diff --git a/pack-objects.c b/pack-objects.c
index a9d9855063a..5506f12293c 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -95,7 +95,7 @@ static void prepare_in_pack_by_idx(struct packing_data *pdata)
 	 * (i.e. in_pack_idx also zero) should return NULL.
 	 */
 	mapping[cnt++] = NULL;
-	for (p = get_all_packs(pdata->repo); p; p = p->next, cnt++) {
+	for (p = packfile_store_get_packs(pdata->repo->objects->packfiles); p; p = p->next, cnt++) {
 		if (cnt == nr) {
 			free(mapping);
 			return;
diff --git a/packfile.c b/packfile.c
index f1526e361c2..b60faf5c3e7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1029,19 +1029,19 @@ void packfile_store_reprepare(struct packfile_store *store)
 	packfile_store_prepare(store);
 }
 
-struct packed_git *get_all_packs(struct repository *r)
+struct packed_git *packfile_store_get_packs(struct packfile_store *store)
 {
-	packfile_store_prepare(r->objects->packfiles);
+	packfile_store_prepare(store);
 
-	for (struct odb_source *source = r->objects->sources; source; source = source->next) {
+	for (struct odb_source *source = store->odb->sources; source; source = source->next) {
 		struct multi_pack_index *m = source->midx;
 		if (!m)
 			continue;
 		for (uint32_t i = 0; i < m->num_packs + m->num_packs_in_base; i++)
-			prepare_midx_pack(r, m, i);
+			prepare_midx_pack(store->odb->repo, m, i);
 	}
 
-	return r->objects->packfiles->packs;
+	return store->packs;
 }
 
 struct list_head *get_packed_git_mru(struct repository *r)
@@ -2101,7 +2101,7 @@ struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
 		 * covers, one kept and one not kept, but the midx returns only
 		 * the non-kept version.
 		 */
-		for (p = get_all_packs(r); p; p = p->next) {
+		for (p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
 			if ((p->pack_keep && (flags & ON_DISK_KEEP_PACKS)) ||
 			    (p->pack_keep_in_core && (flags & IN_CORE_KEEP_PACKS))) {
 				ALLOC_GROW(packs, nr + 1, alloc);
@@ -2198,7 +2198,7 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	int r = 0;
 	int pack_errors = 0;
 
-	for (p = get_all_packs(repo); p; p = p->next) {
+	for (p = packfile_store_get_packs(repo->objects->packfiles); p; p = p->next) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
 		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
diff --git a/packfile.h b/packfile.h
index dff02370924..8f501f00947 100644
--- a/packfile.h
+++ b/packfile.h
@@ -128,6 +128,12 @@ void packfile_store_reprepare(struct packfile_store *store);
 void packfile_store_add_pack(struct packfile_store *store,
 			     struct packed_git *pack);
 
+/*
+ * Get all packs managed by the given store, including packfiles that are
+ * referenced by multi-pack indices.
+ */
+struct packed_git *packfile_store_get_packs(struct packfile_store *store);
+
 /*
  * Open the packfile and add it to the store if it isn't yet known. Returns
  * either the newly opened packfile or the preexisting packfile. Returns a
@@ -213,7 +219,6 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 extern void (*report_garbage)(unsigned seen_bits, const char *path);
 
 struct list_head *get_packed_git_mru(struct repository *r);
-struct packed_git *get_all_packs(struct repository *r);
 
 /*
  * Give a rough count of objects in the repository. This sacrifices accuracy
diff --git a/server-info.c b/server-info.c
index 9bb30d9ab71..79234c7fed3 100644
--- a/server-info.c
+++ b/server-info.c
@@ -292,7 +292,7 @@ static void init_pack_info(struct repository *r, const char *infofile, int force
 	int i;
 	size_t alloc = 0;
 
-	for (p = get_all_packs(r); p; p = p->next) {
+	for (p = packfile_store_get_packs(r->objects->packfiles); p; p = p->next) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
 		 */
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index 611a13a3261..183a777fc54 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -39,7 +39,7 @@ int cmd__find_pack(int argc, const char **argv)
 	if (repo_get_oid(the_repository, argv[0], &oid))
 		die("cannot parse %s as an object name", argv[0]);
 
-	for (p = get_all_packs(the_repository); p; p = p->next)
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next)
 		if (find_pack_entry_one(&oid, p)) {
 			printf("%s\n", p->pack_name);
 			actual_count++;
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index d51aaa3dc40..cfdfae77a6c 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -37,7 +37,7 @@ int cmd__pack_mtimes(int argc, const char **argv)
 	if (argc != 2)
 		usage(pack_mtimes_usage);
 
-	for (p = get_all_packs(the_repository); p; p = p->next) {
+	for (p = packfile_store_get_packs(the_repository->objects->packfiles); p; p = p->next) {
 		strbuf_addstr(&buf, basename(p->pack_name));
 		strbuf_strip_suffix(&buf, ".pack");
 		strbuf_addstr(&buf, ".mtimes");

-- 
2.51.0.261.g7ce5a0a67e.dirty

