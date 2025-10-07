Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0132DFA54
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759840890; cv=none; b=MK/KF5mU6/0tSu2GGNeV45CRXIBXJeNmWE0YZn8lxdnrSRcq/okV1qTLqaahRb9ADi5xC4dHgAzZikSrgEzFPdNCjHrTDDyLfsw7m5OXpCZvL97qi1p4HEVz5wnpSFXkEjue1pe4c6OsKeU0uNJI4Wh+ztGQ/ttu0RCo1tX3BTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759840890; c=relaxed/simple;
	bh=AHTjSLbylwiuii4JyucK4SfbIXs2s9TqquyBVWO800E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pu7UDEbcaxU5YoEgVayPK6uLcqawxjfgf0xRmmcbi9HHLPRX+HlWoboAG84CkXqi/HBmkwCPDJ6Vy4VIoAdXanoTduOQAYGx4FEKKRlX04bqwRbfLX9c0radPHSDpRRTaW+47UNbZZ+DbIo51F7vVUk+zA4l/Qv0mg2ayQUZ6Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FK1QqqmZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=u5hVZjcg; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FK1QqqmZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="u5hVZjcg"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6F10614001B9;
	Tue,  7 Oct 2025 08:41:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 07 Oct 2025 08:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759840887;
	 x=1759927287; bh=s78P+zk1cvTEoSXycSFbDVFUV2Gh8SZyskfVyCOGff4=; b=
	FK1QqqmZAMZnVrXdVSr/xXGVnIxb1Z13GEVv65RMPdHCNyZ0AJh8+VOK3SFJL0s6
	gMcyENyH/HJ5WBlW6WGZlO+LUHG1G+n0ChvUTbAfYW70BlB2+xUJ5tPi1X8wYT0R
	mX1qJLJBT+afkJKKM65Csx+Gbq5HWec6khknWuOyEVAdA/Ss8/LYuMeflLB9KTTC
	k9VKWh64sZlj3dBzkDUef8IFvRDYaDbJjK5dfxp6PsyQmC6iPrnmVSgd7mWQfEk0
	/VX+i2sObb/qvUmUlTaTbgDtt6E/XnCKJ1fDaSz+/DVYm5K14CqlaSvAZFW1n/pT
	6W32I3ftWD9h34dHl5e8Vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759840887; x=
	1759927287; bh=s78P+zk1cvTEoSXycSFbDVFUV2Gh8SZyskfVyCOGff4=; b=u
	5hVZjcg/hUcbiQ4Lg4COxqfKca5L8kasG0nuG0C1EHIJxAdLWNOP7IfkDTAY5/HZ
	AVui6hP1A2L8S8aWZRLcmfggJstlGISPwhl8gIN7x3ubOF4p8SpcNOinHW9Net9z
	8q7mT/xBaF97YnNcD4Cjbwdmm0EEwcbDMFhSKt4f3eQUmLIphz9yVULy9sbxCl67
	+ttj8Mp+Agcgh1WaSQDao6+Z2NqL7Bql0PzImU2ltuP2q8a+Yh7Dei17v5mJNveW
	J0bwDo8HLHEGaYjEvE5P+QNx3QadAgu93/axYE2Bg0mvsTzeG/zur/Nwpz/bXhAV
	ZZn67nPsC24TNKi9gUnfg==
X-ME-Sender: <xms:dwrlaJqNurBZ8Um-RNfXqIw8IGY9AKRarrLLQGHRNXm7-jL9jhajyA>
    <xme:dwrlaBpGMsn-Wx3lny5gbh7KEtTgbUyq6J1kf4BvTVx51TciGDjBPeXYbhCqabqgv
    PSqahGt3s_Tz85uCHCJa9jxzyKMm8PSFDFT2aT1SL_rfO7oZj0e>
X-ME-Received: <xmr:dwrlaD0rpDVxgVmBCrwE-7Rj3noaL_Zwv9BUTT-Pe7Hr0t4SN_TfgX-jjUcokaL3o1FA_7PIslLGYS3M3ZA5I70wXOonPLFIyzL5jdenLnM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:dwrlaACA1T8MVgfdgGWL4a6EvFf8ns4-bKb6kqDrMBAt6B2sNG8ypA>
    <xmx:dwrlaLf9regyC_B8790MbGwAlfDyc4uF9jy1D8aXK0FYcvSrc-gEaQ>
    <xmx:dwrlaFhcU5hxGqZzEfhxzLMM_6sLz9uAiiLy8HzCLVa5y_3Si6wLzw>
    <xmx:dwrlaDoUKg1truTN73S99-GHm1Z3fcGCfPQCJFYuWKskrNOoE_7djA>
    <xmx:dwrlaCzJQVL_YVAiRyJW9x_KJbe7Pfi0iNjdafcOApiba_S5Eqp9qFeU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 08:41:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 990b5152 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 7 Oct 2025 12:41:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Oct 2025 14:41:11 +0200
Subject: [PATCH 5/6] packfile: introduce macro to iterate through packs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251007-pks-packfiles-convert-get-all-v1-5-428227657a89@pks.im>
References: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
In-Reply-To: <20251007-pks-packfiles-convert-get-all-v1-0-428227657a89@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
X-Mailer: b4 0.14.3

We have a bunch of different sites that want to iterate through all
packs of a given `struct packfile_store`. This pattern is somewhat
verbose and repetitive, which makes it somewhat cumbersome.

Introduce a new macro `packfile_store_for_each_pack()` that removes some
of the boilerplate.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c          |  2 +-
 builtin/count-objects.c     |  2 +-
 builtin/fsck.c              | 12 ++++++------
 builtin/gc.c                | 14 +++++++-------
 builtin/pack-objects.c      | 14 +++++++-------
 builtin/pack-redundant.c    | 12 ++++--------
 connected.c                 |  2 +-
 http-backend.c              |  4 ++--
 http.c                      |  2 +-
 object-name.c               |  8 +++++---
 pack-bitmap.c               |  6 +++---
 pack-objects.c              |  4 ++--
 packfile.c                  |  4 ++--
 packfile.h                  |  6 ++++++
 repack-cruft.c              |  2 +-
 repack-geometry.c           |  2 +-
 repack.c                    |  2 +-
 server-info.c               |  2 +-
 t/helper/test-find-pack.c   |  3 ++-
 t/helper/test-pack-mtimes.c |  2 +-
 20 files changed, 55 insertions(+), 50 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index ee6715fa52..a565c5f02b 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -855,7 +855,7 @@ static void batch_each_object(struct batch_options *opt,
 		struct packfile_store *packs = the_repository->objects->packfiles;
 		struct packed_git *pack;
 
-		for (pack = packfile_store_get_all_packs(packs); pack; pack = pack->next) {
+		packfile_store_for_each_pack(packs, pack) {
 			if (bitmap_index_contains_pack(bitmap, pack) ||
 			    open_pack_index(pack))
 				continue;
diff --git a/builtin/count-objects.c b/builtin/count-objects.c
index f2f407c2a7..09e3696823 100644
--- a/builtin/count-objects.c
+++ b/builtin/count-objects.c
@@ -130,7 +130,7 @@ int cmd_count_objects(int argc,
 		struct strbuf pack_buf = STRBUF_INIT;
 		struct strbuf garbage_buf = STRBUF_INIT;
 
-		for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+		packfile_store_for_each_pack(packs, p) {
 			if (!p->pack_local)
 				continue;
 			if (open_pack_index(p))
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8ee95e0d67..5462c442dc 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -869,18 +869,19 @@ static int check_pack_rev_indexes(struct repository *r, int show_progress)
 {
 	struct packfile_store *packs = r->objects->packfiles;
 	struct progress *progress = NULL;
+	struct packed_git *p;
 	uint32_t pack_count = 0;
 	int res = 0;
 
 	if (show_progress) {
-		for (struct packed_git *p = packfile_store_get_all_packs(packs); p; p = p->next)
+		packfile_store_for_each_pack(packs, p)
 			pack_count++;
 		progress = start_delayed_progress(the_repository,
 						  "Verifying reverse pack-indexes", pack_count);
 		pack_count = 0;
 	}
 
-	for (struct packed_git *p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	packfile_store_for_each_pack(packs, p) {
 		int load_error = load_pack_revindex_from_disk(p);
 
 		if (load_error < 0) {
@@ -1012,8 +1013,7 @@ int cmd_fsck(int argc,
 			struct progress *progress = NULL;
 
 			if (show_progress) {
-				for (p = packfile_store_get_all_packs(packs); p;
-				     p = p->next) {
+				packfile_store_for_each_pack(packs, p) {
 					if (open_pack_index(p))
 						continue;
 					total += p->num_objects;
@@ -1022,8 +1022,8 @@ int cmd_fsck(int argc,
 				progress = start_progress(the_repository,
 							  _("Checking objects"), total);
 			}
-			for (p = packfile_store_get_all_packs(packs); p;
-			     p = p->next) {
+
+			packfile_store_for_each_pack(packs, p) {
 				/* verify gives error messages itself */
 				if (verify_pack(the_repository,
 						p, fsck_obj_buffer,
diff --git a/builtin/gc.c b/builtin/gc.c
index ab6d6d3bd1..16fc56e5cc 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -490,7 +490,7 @@ static struct packed_git *find_base_packs(struct string_list *packs,
 	struct packfile_store *packfiles = the_repository->objects->packfiles;
 	struct packed_git *p, *base = NULL;
 
-	for (p = packfile_store_get_all_packs(packfiles); p; p = p->next) {
+	packfile_store_for_each_pack(packfiles, p) {
 		if (!p->pack_local || p->is_cruft)
 			continue;
 		if (limit) {
@@ -511,12 +511,12 @@ static int too_many_packs(struct gc_config *cfg)
 {
 	struct packfile_store *packs = the_repository->objects->packfiles;
 	struct packed_git *p;
-	int cnt;
+	int cnt = 0;
 
 	if (cfg->gc_auto_pack_limit <= 0)
 		return 0;
 
-	for (cnt = 0, p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	packfile_store_for_each_pack(packs, p) {
 		if (!p->pack_local)
 			continue;
 		if (p->pack_keep)
@@ -1425,9 +1425,9 @@ static int incremental_repack_auto_condition(struct gc_config *cfg UNUSED)
 	if (incremental_repack_auto_limit < 0)
 		return 1;
 
-	for (p = packfile_store_get_all_packs(the_repository->objects->packfiles);
-	     count < incremental_repack_auto_limit && p;
-	     p = p->next) {
+	packfile_store_for_each_pack(the_repository->objects->packfiles, p) {
+		if (count >= incremental_repack_auto_limit)
+			break;
 		if (!p->multi_pack_index)
 			count++;
 	}
@@ -1494,7 +1494,7 @@ static off_t get_auto_pack_size(void)
 	struct repository *r = the_repository;
 
 	odb_reprepare(r->objects);
-	for (p = packfile_store_get_all_packs(r->objects->packfiles); p; p = p->next) {
+	packfile_store_for_each_pack(r->objects->packfiles, p) {
 		if (p->pack_size > max_size) {
 			second_largest_size = max_size;
 			max_size = p->pack_size;
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index fe987fbb8b..65fb70f806 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3856,7 +3856,7 @@ static void read_packs_list_from_stdin(struct rev_info *revs)
 	string_list_sort(&exclude_packs);
 	string_list_remove_duplicates(&exclude_packs, 0);
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	packfile_store_for_each_pack(packs, p) {
 		const char *pack_name = pack_basename(p);
 
 		if ((item = string_list_lookup(&include_packs, pack_name)))
@@ -4107,7 +4107,7 @@ static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
 	 * Re-mark only the fresh packs as kept so that objects in
 	 * unknown packs do not halt the reachability traversal early.
 	 */
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next)
+	packfile_store_for_each_pack(packs, p)
 		p->pack_keep_in_core = 0;
 	mark_pack_kept_in_core(fresh_packs, 1);
 
@@ -4145,7 +4145,7 @@ static void read_cruft_objects(void)
 	string_list_sort(&discard_packs);
 	string_list_sort(&fresh_packs);
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	packfile_store_for_each_pack(packs, p) {
 		const char *pack_name = pack_basename(p);
 		struct string_list_item *item;
 
@@ -4446,7 +4446,7 @@ static void loosen_unused_packed_objects(void)
 	uint32_t loosened_objects_nr = 0;
 	struct object_id oid;
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	packfile_store_for_each_pack(packs, p) {
 		if (!p->pack_local || p->pack_keep || p->pack_keep_in_core)
 			continue;
 
@@ -4753,7 +4753,7 @@ static void add_extra_kept_packs(const struct string_list *names)
 	if (!names->nr)
 		return;
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	packfile_store_for_each_pack(packs, p) {
 		const char *name = basename(p->pack_name);
 		int i;
 
@@ -5194,7 +5194,7 @@ int cmd_pack_objects(int argc,
 		struct packfile_store *packs = the_repository->objects->packfiles;
 		struct packed_git *p;
 
-		for (p = packfile_store_get_all_packs(packs); p; p = p->next)
+		packfile_store_for_each_pack(packs, p)
 			if (p->pack_local && p->pack_keep)
 				break;
 		if (!p) /* no keep-able packs found */
@@ -5209,7 +5209,7 @@ int cmd_pack_objects(int argc,
 		struct packfile_store *packs = the_repository->objects->packfiles;
 		struct packed_git *p;
 
-		for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+		packfile_store_for_each_pack(packs, p) {
 			if (!p->pack_local) {
 				have_non_local_packs = 1;
 				break;
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index dd28171f0a..035a2c86a2 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -567,28 +567,24 @@ static struct pack_list * add_pack(struct packed_git *p)
 static struct pack_list * add_pack_file(const char *filename)
 {
 	struct packfile_store *packs = the_repository->objects->packfiles;
-	struct packed_git *p = packfile_store_get_all_packs(packs);
+	struct packed_git *p;
 
 	if (strlen(filename) < 40)
 		die("Bad pack filename: %s", filename);
 
-	while (p) {
+	packfile_store_for_each_pack(packs, p)
 		if (strstr(p->pack_name, filename))
 			return add_pack(p);
-		p = p->next;
-	}
 	die("Filename %s not found in packed_git", filename);
 }
 
 static void load_all(void)
 {
 	struct packfile_store *packs = the_repository->objects->packfiles;
-	struct packed_git *p = packfile_store_get_all_packs(packs);
+	struct packed_git *p;
 
-	while (p) {
+	packfile_store_for_each_pack(packs, p)
 		add_pack(p);
-		p = p->next;
-	}
 }
 
 int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED) {
diff --git a/connected.c b/connected.c
index b288a18b17..e6b048d176 100644
--- a/connected.c
+++ b/connected.c
@@ -77,7 +77,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 			struct packfile_store *packs = the_repository->objects->packfiles;
 			struct packed_git *p;
 
-			for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+			packfile_store_for_each_pack(packs, p) {
 				if (!p->pack_promisor)
 					continue;
 				if (find_pack_entry_one(oid, p))
diff --git a/http-backend.c b/http-backend.c
index 9084058f1e..8ba2d37dad 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -609,13 +609,13 @@ static void get_info_packs(struct strbuf *hdr, char *arg UNUSED)
 	size_t cnt = 0;
 
 	select_getanyfile(hdr);
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	packfile_store_for_each_pack(packs, p) {
 		if (p->pack_local)
 			cnt++;
 	}
 
 	strbuf_grow(&buf, cnt * 53 + 2);
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	packfile_store_for_each_pack(packs, p) {
 		if (p->pack_local)
 			strbuf_addf(&buf, "P %s\n", p->pack_name + objdirlen + 6);
 	}
diff --git a/http.c b/http.c
index 7e3af1e72f..2730352f0e 100644
--- a/http.c
+++ b/http.c
@@ -2425,7 +2425,7 @@ static int fetch_and_setup_pack_index(struct packed_git **packs_head,
 	 * If we already have the pack locally, no need to fetch its index or
 	 * even add it to list; we already have all of its objects.
 	 */
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	packfile_store_for_each_pack(packs, p) {
 		if (hasheq(p->hash, sha1, the_repository->hash_algo))
 			return 0;
 	}
diff --git a/object-name.c b/object-name.c
index 4e62bfa330..e998dc31b4 100644
--- a/object-name.c
+++ b/object-name.c
@@ -213,9 +213,11 @@ static void find_short_packed_object(struct disambiguate_state *ds)
 			unique_in_midx(m, ds);
 	}
 
-	for (p = packfile_store_get_all_packs(ds->repo->objects->packfiles); p && !ds->ambiguous;
-	     p = p->next)
+	packfile_store_for_each_pack(ds->repo->objects->packfiles, p) {
+		if (ds->ambiguous)
+			break;
 		unique_in_pack(p, ds);
+	}
 }
 
 static int finish_object_disambiguation(struct disambiguate_state *ds,
@@ -805,7 +807,7 @@ static void find_abbrev_len_packed(struct min_abbrev_data *mad)
 			find_abbrev_len_for_midx(m, mad);
 	}
 
-	for (p = packfile_store_get_all_packs(mad->repo->objects->packfiles); p; p = p->next)
+	packfile_store_for_each_pack(mad->repo->objects->packfiles, p)
 		find_abbrev_len_for_pack(p, mad);
 }
 
diff --git a/pack-bitmap.c b/pack-bitmap.c
index ac71035d77..2e30066b27 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -664,7 +664,7 @@ static int open_pack_bitmap(struct repository *r,
 	struct packed_git *p;
 	int ret = -1;
 
-	for (p = packfile_store_get_all_packs(r->objects->packfiles); p; p = p->next) {
+	packfile_store_for_each_pack(r->objects->packfiles, p) {
 		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
 			ret = 0;
 			/*
@@ -3347,6 +3347,7 @@ static int verify_bitmap_file(const struct git_hash_algo *algop,
 int verify_bitmap_files(struct repository *r)
 {
 	struct odb_source *source;
+	struct packed_git *p;
 	int res = 0;
 
 	odb_prepare_alternates(r->objects);
@@ -3362,8 +3363,7 @@ int verify_bitmap_files(struct repository *r)
 		free(midx_bitmap_name);
 	}
 
-	for (struct packed_git *p = packfile_store_get_all_packs(r->objects->packfiles);
-	     p; p = p->next) {
+	packfile_store_for_each_pack(r->objects->packfiles, p) {
 		char *pack_bitmap_name = pack_bitmap_filename(p);
 		res |= verify_bitmap_file(r->hash_algo, pack_bitmap_name);
 		free(pack_bitmap_name);
diff --git a/pack-objects.c b/pack-objects.c
index d8eb679735..2dfaae4886 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -96,13 +96,13 @@ static void prepare_in_pack_by_idx(struct packing_data *pdata)
 	 * (i.e. in_pack_idx also zero) should return NULL.
 	 */
 	mapping[cnt++] = NULL;
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next, cnt++) {
+	packfile_store_for_each_pack(packs, p) {
 		if (cnt == nr) {
 			free(mapping);
 			return;
 		}
 		p->index = cnt;
-		mapping[cnt] = p;
+		mapping[cnt++] = p;
 	}
 	pdata->in_pack_by_idx = mapping;
 }
diff --git a/packfile.c b/packfile.c
index db748b0bd4..00abb058db 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2099,7 +2099,7 @@ struct packed_git **kept_pack_cache(struct repository *r, unsigned flags)
 		 * covers, one kept and one not kept, but the midx returns only
 		 * the non-kept version.
 		 */
-		for (p = packfile_store_get_all_packs(r->objects->packfiles); p; p = p->next) {
+		packfile_store_for_each_pack(r->objects->packfiles, p) {
 			if ((p->pack_keep && (flags & ON_DISK_KEEP_PACKS)) ||
 			    (p->pack_keep_in_core && (flags & IN_CORE_KEEP_PACKS))) {
 				ALLOC_GROW(packs, nr + 1, alloc);
@@ -2196,7 +2196,7 @@ int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
 	int r = 0;
 	int pack_errors = 0;
 
-	for (p = packfile_store_get_all_packs(repo->objects->packfiles); p; p = p->next) {
+	packfile_store_for_each_pack(repo->objects->packfiles, p) {
 		if ((flags & FOR_EACH_OBJECT_LOCAL_ONLY) && !p->pack_local)
 			continue;
 		if ((flags & FOR_EACH_OBJECT_PROMISOR_ONLY) &&
diff --git a/packfile.h b/packfile.h
index 3f38c63476..b80f79c9aa 100644
--- a/packfile.h
+++ b/packfile.h
@@ -136,6 +136,12 @@ void packfile_store_reprepare(struct packfile_store *store);
 void packfile_store_add_pack(struct packfile_store *store,
 			     struct packed_git *pack);
 
+/*
+ * Load and iterate through all packs of the given packfile store.
+ */
+#define packfile_store_for_each_pack(store, p) \
+	for (p = packfile_store_get_all_packs(store); p; p = p->next)
+
 /*
  * Get all packs managed by the given store, including packfiles that are
  * referenced by multi-pack indices.
diff --git a/repack-cruft.c b/repack-cruft.c
index accb98bcdb..34e7a640de 100644
--- a/repack-cruft.c
+++ b/repack-cruft.c
@@ -12,7 +12,7 @@ static void combine_small_cruft_packs(FILE *in, off_t combine_cruft_below_size,
 	struct strbuf buf = STRBUF_INIT;
 	size_t i;
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	packfile_store_for_each_pack(packs, p) {
 		if (!(p->is_cruft && p->pack_local))
 			continue;
 
diff --git a/repack-geometry.c b/repack-geometry.c
index 56d651c9ce..7bb940ad10 100644
--- a/repack-geometry.c
+++ b/repack-geometry.c
@@ -33,7 +33,7 @@ void pack_geometry_init(struct pack_geometry *geometry,
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	packfile_store_for_each_pack(packs, p) {
 		if (args->local && !p->pack_local)
 			/*
 			 * When asked to only repack local packfiles we skip
diff --git a/repack.c b/repack.c
index 1982a48165..f169df86ce 100644
--- a/repack.c
+++ b/repack.c
@@ -128,7 +128,7 @@ void existing_packs_collect(struct existing_packs *existing,
 	struct packed_git *p;
 	struct strbuf buf = STRBUF_INIT;
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	packfile_store_for_each_pack(packs, p) {
 		size_t i;
 		const char *base;
 
diff --git a/server-info.c b/server-info.c
index 1d33de821e..804bc3c7c4 100644
--- a/server-info.c
+++ b/server-info.c
@@ -293,7 +293,7 @@ static void init_pack_info(struct repository *r, const char *infofile, int force
 	int i;
 	size_t alloc = 0;
 
-	for (p = packfile_store_get_all_packs(packs); p; p = p->next) {
+	packfile_store_for_each_pack(packs, p) {
 		/* we ignore things on alternate path since they are
 		 * not available to the pullers in general.
 		 */
diff --git a/t/helper/test-find-pack.c b/t/helper/test-find-pack.c
index e001dc3066..fdc29a6b69 100644
--- a/t/helper/test-find-pack.c
+++ b/t/helper/test-find-pack.c
@@ -39,11 +39,12 @@ int cmd__find_pack(int argc, const char **argv)
 	if (repo_get_oid(the_repository, argv[0], &oid))
 		die("cannot parse %s as an object name", argv[0]);
 
-	for (p = packfile_store_get_all_packs(the_repository->objects->packfiles); p; p = p->next)
+	packfile_store_for_each_pack(the_repository->objects->packfiles, p) {
 		if (find_pack_entry_one(&oid, p)) {
 			printf("%s\n", p->pack_name);
 			actual_count++;
 		}
+	}
 
 	if (count > -1 && count != actual_count)
 		die("bad packfile count %d instead of %d", actual_count, count);
diff --git a/t/helper/test-pack-mtimes.c b/t/helper/test-pack-mtimes.c
index 7c428c1601..6322473fbf 100644
--- a/t/helper/test-pack-mtimes.c
+++ b/t/helper/test-pack-mtimes.c
@@ -37,7 +37,7 @@ int cmd__pack_mtimes(int argc, const char **argv)
 	if (argc != 2)
 		usage(pack_mtimes_usage);
 
-	for (p = packfile_store_get_all_packs(the_repository->objects->packfiles); p; p = p->next) {
+	packfile_store_for_each_pack(the_repository->objects->packfiles, p) {
 		strbuf_addstr(&buf, basename(p->pack_name));
 		strbuf_strip_suffix(&buf, ".pack");
 		strbuf_addstr(&buf, ".mtimes");

-- 
2.51.0.764.g787ff6f08a.dirty

