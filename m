Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1C269816
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 10:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744107862; cv=none; b=On5jKS3qKJIxXEaszm+euMjTPkqt6MdO+SVrHVJ+G0jMy4Op03cyCqpqjGk+ApRArf0qZNzujgXKGAezi/eBERJD2vLPgHfCbf5s5osH+2xIy7OKqIsIzrBCeKPxcfpCzcKMuFiBGtPellTjxjXIC5O1UT6BX+G3+3y9tSBGk6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744107862; c=relaxed/simple;
	bh=tdo6N7gYBZ7OqLLCVpQo/YPaNPAJkIOxbem5VdrHlP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIN9cGk8UJuQK6xDihYqxsD7vlC68KaUVAS6Dp+xjFLV52IrT+DMsJr51vgQIfJoL1V01IsUrrrmuvOCKhdsTej4DaHw4NVNoK5ViFOyyrm24gNSf4kso+B+VwRW09LV2ujSxE2zksICPpZgvgkDS3ST7CrcF2kk/WnIIoJvmQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=atokkVt4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ua/V9rcD; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="atokkVt4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ua/V9rcD"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 9CCD1138014C
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 06:24:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 08 Apr 2025 06:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744107859;
	 x=1744194259; bh=uz0gpbfH8pa8RfQWcSxNagIcdSRtD6lo8SKsXhp8C4g=; b=
	atokkVt4x2kHPrBjV4ns5ipLVKcctl2YWimFY4TcofpZo3uAg/lYLf4FkekeYkuS
	j48c3pRpg0qb+8Z4V+WZH6NlgL6Bvmk593TQ7KDvZBPawDdvMnvR7SK7sq/zYJHj
	9eQMMUrjKYa+XFxuvYo12JLBbtNVk3buVZDz3DYBxGcosOc+OU7tFgyLJpcJgZDO
	VVNDPNzVZbYQ0kKgs/yF9GxMbWGmnfpkFMwBCi092uchZV5oI2SRCkQfRWkP7EBI
	7s8rQbWjYQ7rCKZUwic8tcX92RDKODJlsbCqMon3mtyO3d2Zalu8hQE1hvOOD3CU
	VU9Y1LQLOCBJEfce5bEcPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744107859; x=
	1744194259; bh=uz0gpbfH8pa8RfQWcSxNagIcdSRtD6lo8SKsXhp8C4g=; b=u
	a/V9rcDtkS4XSFZxxoUYfwLQt/HKybRh+n6QBJo0oxFN+WM0FWz/z/ry+giA75rt
	YoEtNin8g4+TP7fOUI6NSNP3CuERDx033d8WOyaz5WtDk9k2XuwFq7Xqg3CDY4JW
	wKrBvvsqjNQE4tB1Jm3CHuudzaNs4blkWE3xJ5ncECuY+5fwGennd8UMbzGiSZnm
	jCXJxwHz98ZLGMjPlXDoEKuG5Pan9nN3QFYIefw0DGtRfer2/iJoJg2etbe2Xsaf
	BLNvHmVRTtPvpwGOO3SGhgl/uYGrNiWzSCMdzBR8Ow6LKYtva/idKIMZ6TyZZQyx
	929e2jZCse8r0Fstt1zjw==
X-ME-Sender: <xms:U_n0Z0oNvbGGZda82OkVJodxH5lK-xAbVkWXJvnKSD8hAMhc8r-o2A>
    <xme:U_n0Z6pAnTvqO_gKHcRdcYgpAtn9FDHc-DeITUeaNlUltTEpmoBCcJ3ZKQ6UI05TN
    CXkCrnGwtbAV7wsFA>
X-ME-Received: <xmr:U_n0Z5OcJarAoreP8E_v4shPs-OcwjmnPrSzAQccwpx4XhvO54xtSuyQFFNAfRt1JTsQxcuDGoojsiDv36QBVKn7gHwCLn2ZvIUhp96Rt_BWuTBe8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddvkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:U_n0Z74oF1NFPAAwx7G68VQYVT7HaGGpCNY7hbeUhb7u9sDVS42sTA>
    <xmx:U_n0Zz7R4r5uo4WCOqmC4_ooua3_d8Ao3EOKjh5yn2Pfe4FjXcrj3w>
    <xmx:U_n0Z7hnnzhQP7j7Vd--EKVTFDjZsXux1qONdMbLNZP6Vpqs-yJPjQ>
    <xmx:U_n0Z94KTPPqDdZabzdVHIFHozZ6j43u2myQL4e7VVLxlY_BZPvVCw>
    <xmx:U_n0ZwH1XxovdBXAqJTkgytams_Vhgw1DOQJDH81SczZ76c6cxZ7qd5O>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 8 Apr 2025 06:24:19 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fcb0d047 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 8 Apr 2025 10:24:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 08 Apr 2025 12:24:15 +0200
Subject: [PATCH 7/9] object: split out functions relating to object store
 subsystem
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250408-pks-split-object-file-v1-7-f1fd50191143@pks.im>
References: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
In-Reply-To: <20250408-pks-split-object-file-v1-0-f1fd50191143@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

Split out functions relating to the object store subsystem from
"object.c". This helps us to separate concerns.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-store-ll.h |  3 ---
 object-store.c    | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 object.c          | 67 -------------------------------------------------------
 3 files changed, 66 insertions(+), 70 deletions(-)

diff --git a/object-store-ll.h b/object-store-ll.h
index 8ae80b8a5fa..8bb0f33f9a8 100644
--- a/object-store-ll.h
+++ b/object-store-ll.h
@@ -92,9 +92,6 @@ struct oidtree *odb_loose_cache(struct object_directory *odb,
 /* Empty the loose object cache for the specified object directory. */
 void odb_clear_loose_cache(struct object_directory *odb);
 
-/* Clear and free the specified object directory */
-void free_object_directory(struct object_directory *odb);
-
 struct packed_git {
 	struct hashmap_entry packmap_ent;
 	struct packed_git *next;
diff --git a/object-store.c b/object-store.c
index e5f1f00cdde..ea2d86c429b 100644
--- a/object-store.c
+++ b/object-store.c
@@ -2,11 +2,13 @@
 
 #include "git-compat-util.h"
 #include "abspath.h"
+#include "commit-graph.h"
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
 #include "lockfile.h"
+#include "loose.h"
 #include "object-file-convert.h"
 #include "object-file.h"
 #include "object-store.h"
@@ -361,6 +363,14 @@ struct object_directory *set_temporary_primary_odb(const char *dir, int will_des
 	return new_odb->next;
 }
 
+static void free_object_directory(struct object_directory *odb)
+{
+	free(odb->path);
+	odb_clear_loose_cache(odb);
+	loose_object_map_clear(&odb->loose_map);
+	free(odb);
+}
+
 void restore_primary_odb(struct object_directory *restore_odb, const char *old_path)
 {
 	struct object_directory *cur_odb = the_repository->objects->odb;
@@ -970,3 +980,59 @@ void assert_oid_type(const struct object_id *oid, enum object_type expect)
 		die(_("%s is not a valid '%s' object"), oid_to_hex(oid),
 		    type_name(expect));
 }
+
+struct raw_object_store *raw_object_store_new(void)
+{
+	struct raw_object_store *o = xmalloc(sizeof(*o));
+
+	memset(o, 0, sizeof(*o));
+	INIT_LIST_HEAD(&o->packed_git_mru);
+	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
+	pthread_mutex_init(&o->replace_mutex, NULL);
+	return o;
+}
+
+static void free_object_directories(struct raw_object_store *o)
+{
+	while (o->odb) {
+		struct object_directory *next;
+
+		next = o->odb->next;
+		free_object_directory(o->odb);
+		o->odb = next;
+	}
+	kh_destroy_odb_path_map(o->odb_by_path);
+	o->odb_by_path = NULL;
+}
+
+void raw_object_store_clear(struct raw_object_store *o)
+{
+	FREE_AND_NULL(o->alternate_db);
+
+	oidmap_free(o->replace_map, 1);
+	FREE_AND_NULL(o->replace_map);
+	pthread_mutex_destroy(&o->replace_mutex);
+
+	free_commit_graph(o->commit_graph);
+	o->commit_graph = NULL;
+	o->commit_graph_attempted = 0;
+
+	free_object_directories(o);
+	o->odb_tail = NULL;
+	o->loaded_alternates = 0;
+
+	INIT_LIST_HEAD(&o->packed_git_mru);
+	close_object_store(o);
+
+	/*
+	 * `close_object_store()` only closes the packfiles, but doesn't free
+	 * them. We thus have to do this manually.
+	 */
+	for (struct packed_git *p = o->packed_git, *next; p; p = next) {
+		next = p->next;
+		free(p);
+	}
+	o->packed_git = NULL;
+
+	hashmap_clear(&o->pack_map);
+}
diff --git a/object.c b/object.c
index 154525a4972..ccda798b75f 100644
--- a/object.c
+++ b/object.c
@@ -6,16 +6,13 @@
 #include "object.h"
 #include "replace-object.h"
 #include "object-file.h"
-#include "object-store.h"
 #include "blob.h"
 #include "statinfo.h"
 #include "tree.h"
 #include "commit.h"
 #include "tag.h"
 #include "alloc.h"
-#include "packfile.h"
 #include "commit-graph.h"
-#include "loose.h"
 
 unsigned int get_max_object_index(const struct repository *repo)
 {
@@ -567,70 +564,6 @@ struct parsed_object_pool *parsed_object_pool_new(struct repository *repo)
 	return o;
 }
 
-struct raw_object_store *raw_object_store_new(void)
-{
-	struct raw_object_store *o = xmalloc(sizeof(*o));
-
-	memset(o, 0, sizeof(*o));
-	INIT_LIST_HEAD(&o->packed_git_mru);
-	hashmap_init(&o->pack_map, pack_map_entry_cmp, NULL, 0);
-	pthread_mutex_init(&o->replace_mutex, NULL);
-	return o;
-}
-
-void free_object_directory(struct object_directory *odb)
-{
-	free(odb->path);
-	odb_clear_loose_cache(odb);
-	loose_object_map_clear(&odb->loose_map);
-	free(odb);
-}
-
-static void free_object_directories(struct raw_object_store *o)
-{
-	while (o->odb) {
-		struct object_directory *next;
-
-		next = o->odb->next;
-		free_object_directory(o->odb);
-		o->odb = next;
-	}
-	kh_destroy_odb_path_map(o->odb_by_path);
-	o->odb_by_path = NULL;
-}
-
-void raw_object_store_clear(struct raw_object_store *o)
-{
-	FREE_AND_NULL(o->alternate_db);
-
-	oidmap_free(o->replace_map, 1);
-	FREE_AND_NULL(o->replace_map);
-	pthread_mutex_destroy(&o->replace_mutex);
-
-	free_commit_graph(o->commit_graph);
-	o->commit_graph = NULL;
-	o->commit_graph_attempted = 0;
-
-	free_object_directories(o);
-	o->odb_tail = NULL;
-	o->loaded_alternates = 0;
-
-	INIT_LIST_HEAD(&o->packed_git_mru);
-	close_object_store(o);
-
-	/*
-	 * `close_object_store()` only closes the packfiles, but doesn't free
-	 * them. We thus have to do this manually.
-	 */
-	for (struct packed_git *p = o->packed_git, *next; p; p = next) {
-		next = p->next;
-		free(p);
-	}
-	o->packed_git = NULL;
-
-	hashmap_clear(&o->pack_map);
-}
-
 void parsed_object_pool_reset_commit_grafts(struct parsed_object_pool *o)
 {
 	for (int i = 0; i < o->grafts_nr; i++) {

-- 
2.49.0.682.gc9b6a7b2b0.dirty

