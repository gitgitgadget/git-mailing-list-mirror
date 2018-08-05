Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9FF33208E9
	for <e@80x24.org>; Sun,  5 Aug 2018 17:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbeHETbI (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 15:31:08 -0400
Received: from mail-wr1-f44.google.com ([209.85.221.44]:38248 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbeHETbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 15:31:07 -0400
Received: by mail-wr1-f44.google.com with SMTP id v14-v6so10145065wro.5
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 10:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pyr+n0w9i0SVjaRjaQHrqc+3y/4V0m4s8D6DSdtqdVg=;
        b=GPhLfUq5r9G48SVSAXm4lamlYUvVrVjqLHoMXv7vQg7ueWsX3EpCA5Gnkx9dYRW/n/
         xJy6jDdTcPeNvSMleYWcxRqiizDVujciY8WGR1iCB+ea+gaqQkH6hmSmRfgJehHeGH29
         JiacBtRXfJx0798FM2BidwiV46MaVS2vDb5lhRdkMg+1k8PT1O6WXGdAtShRUqrbVKQf
         HEa+7OuIiESo+i6uiDeXCD0T4jvN/eARrNqXlCxyw2A2qjRCiCyyV4SzS5sFeK9PhoKL
         lHQ68/mXHwNkFSuGRTI9ke4pcY/gmkthjyHqKN6bX+LwznO7uXOKRHNBL3Wp0YKhp35F
         hVnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pyr+n0w9i0SVjaRjaQHrqc+3y/4V0m4s8D6DSdtqdVg=;
        b=puAMuZx9hRDNdoYW8udA1jXAKz0ZaUE1AXicInFjcfTqPZBaZUIA5IbIZPfL6c1au0
         uL0UsFRDaW9hhv2m3I74gxqd8yzxRiGQlFKUjFT2cFrwB2mNzKc6aqa1TYXL7bWcQKrv
         hLRycP+aJJk004eBh2Zz0xMHUXsdH6TwwR/ZTIwVN6MsmC5AjdrwUCUU5Y3hG6gZniMA
         NLtuUT0c4C7fHL6vPMa+lgoSQiWJ8R6KOlQPn/MU0hJp4id101LPD2IzvARAUvVEGZEF
         W3mS6hF8qxI2SClyV0szCNpyhXjOwyihsYe9rDI5FWkfJTSrJmWaZsGkWn/w+Os0DP0E
         38rQ==
X-Gm-Message-State: AOUpUlGTSaYbKV/YLTdHDd0lWIm8BoNmgN53wVI0AEcGTID0v1S1DYrB
        tBwRYMdNnLI2hDeq38wqLkmCQwP3
X-Google-Smtp-Source: AAOMgpdraiW+evqfX/TvUWlFF6lnk1FZbb/QvUCNGoLMyBU20HFMg5kDMKcGT/p8EllVslj0Tvqr2A==
X-Received: by 2002:adf:e287:: with SMTP id v7-v6mr8003590wri.139.1533489947713;
        Sun, 05 Aug 2018 10:25:47 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id x62-v6sm7523228wmg.1.2018.08.05.10.25.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 10:25:47 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/6] pack-objects: add delta-islands support
Date:   Sun,  5 Aug 2018 19:25:22 +0200
Message-Id: <20180805172525.15278-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.327.ga7d188ab43
In-Reply-To: <20180805172525.15278-1-chriscool@tuxfamily.org>
References: <20180805172525.15278-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Implement support for delta islands in git pack-objects
and document how delta islands work in
"Documentation/git-pack-objects.txt" and Documentation/config.txt.

This allows users to setup delta islands in their config and
get the benefit of less disk usage while cloning and fetching
is still quite fast and not much more CPU intensive.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config.txt           |  15 ++++
 Documentation/git-pack-objects.txt |  97 +++++++++++++++++++++
 builtin/pack-objects.c             | 130 ++++++++++++++++++++---------
 3 files changed, 201 insertions(+), 41 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 43b2de7b5f..b74a1f60f4 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2542,6 +2542,21 @@ Note that changing the compression level will not automatically recompress
 all existing objects. You can force recompression by passing the -F option
 to linkgit:git-repack[1].
 
+pack.island::
+	An extended regular expression configuring a set of delta
+	islands. See "DELTA ISLANDS" in linkgit:git-pack-objects[1]
+	for details.
+
+pack.islandCore::
+	Specify an island name which gets to have its objects be
+	packed first. This creates a kind of pseudo-pack at the front
+	of one pack, so that the objects from the specified island are
+	hopefully faster to copy into any pack that should be served
+	to a user requesting these objects. In practice this means
+	that the island specified should likely correspond to what is
+	the most commonly cloned in the repo. See also "DELTA ISLANDS"
+	in linkgit:git-pack-objects[1].
+
 pack.deltaCacheSize::
 	The maximum memory in bytes used for caching deltas in
 	linkgit:git-pack-objects[1] before writing them out to a pack.
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index d95b472d16..05f49c1d17 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -289,6 +289,103 @@ Unexpected missing object will raise an error.
 --unpack-unreachable::
 	Keep unreachable objects in loose form. This implies `--revs`.
 
+--delta-islands::
+	Restrict delta matches based on "islands". See DELTA ISLANDS
+	below.
+
+
+DELTA ISLANDS
+-------------
+
+When possible, `pack-objects` tries to reuse existing on-disk deltas to
+avoid having to search for new ones on the fly. This is an important
+optimization for serving fetches, because it means the server can avoid
+inflating most objects at all and just send the bytes directly from
+disk. This optimization can't work when an object is stored as a delta
+against a base which the receiver does not have (and which we are not
+already sending). In that case the server "breaks" the delta and has to
+find a new one, which has a high CPU cost. Therefore it's important for
+performance that the set of objects in on-disk delta relationships match
+what a client would fetch.
+
+In a normal repository, this tends to work automatically. The objects
+are mostly reachable from the branches and tags, and that's what clients
+fetch. Any deltas we find on the server are likely to be between objects
+the client has or will have.
+
+But in some repository setups, you may have several related but separate
+groups of ref tips, with clients tending to fetch those groups
+independently. For example, imagine that you are hosting several "forks"
+of a repository in a single shared object store, and letting clients
+view them as separate repositories through `GIT_NAMESPACE` or separate
+repos using the alternates mechanism. A naive repack may find that the
+optimal delta for an object is against a base that is only found in
+another fork. But when a client fetches, they will not have the base
+object, and we'll have to find a new delta on the fly.
+
+A similar situation may exist if you have many refs outside of
+`refs/heads/` and `refs/tags/` that point to related objects (e.g.,
+`refs/pull` or `refs/changes` used by some hosting providers). By
+default, clients fetch only heads and tags, and deltas against objects
+found only in those other groups cannot be sent as-is.
+
+Delta islands solve this problem by allowing you to group your refs into
+distinct "islands". Pack-objects computes which objects are reachable
+from which islands, and refuses to make a delta from an object `A`
+against a base which is not present in all of `A`'s islands. This
+results in slightly larger packs (because we miss some delta
+opportunities), but guarantees that a fetch of one island will not have
+to recompute deltas on the fly due to crossing island boundaries.
+
+When repacking with delta islands the delta window tends to get
+clogged with candidates that are forbidden by the config. Repacking
+with a big --window helps (and doesn't take as long as it otherwise
+might because we can reject some object pairs based on islands before
+doing any computation on the content).
+
+Islands are configured via the `pack.island` option, which can be
+specified multiple times. Each value is a left-anchored regular
+expressions matching refnames. For example:
+
+-------------------------------------------
+[pack]
+island = refs/heads/
+island = refs/tags/
+-------------------------------------------
+
+puts heads and tags into an island (whose name is the empty string; see
+below for more on naming). Any refs which do not match those regular
+expressions (e.g., `refs/pull/123`) is not in any island. Any object
+which is reachable only from `refs/pull/` (but not heads or tags) is
+therefore not a candidate to be used as a base for `refs/heads/`.
+
+Refs are grouped into islands based on their "names", and two regexes
+that produce the same name are considered to be in the same
+island. The names are computed from the regexes by concatenating any
+capture groups from the regex, with a '-' dash in between. (And if
+there are no capture groups, then the name is the empty string, as in
+the above example.) This allows you to create arbitrary numbers of
+islands. Only up to 7 such capture groups are supported though.
+
+For example, imagine you store the refs for each fork in
+`refs/virtual/ID`, where `ID` is a numeric identifier. You might then
+configure:
+
+-------------------------------------------
+[pack]
+island = refs/virtual/([0-9]+)/heads/
+island = refs/virtual/([0-9]+)/tags/
+island = refs/virtual/([0-9]+)/(pull)/
+-------------------------------------------
+
+That puts the heads and tags for each fork in their own island (named
+"1234" or similar), and the pull refs for each go into their own
+"1234-pull".
+
+Note that we pick a single island for each regex to go into, using "last
+one wins" ordering (which allows repo-specific config to take precedence
+over user-wide config, and so forth).
+
 SEE ALSO
 --------
 linkgit:git-rev-list[1]
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ebc8cefb53..3d09742d91 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -24,6 +24,7 @@
 #include "streaming.h"
 #include "thread-utils.h"
 #include "pack-bitmap.h"
+#include "delta-islands.h"
 #include "reachable.h"
 #include "sha1-array.h"
 #include "argv-array.h"
@@ -59,6 +60,7 @@ static struct packing_data to_pack;
 
 static struct pack_idx_entry **written_list;
 static uint32_t nr_result, nr_written, nr_seen;
+static uint32_t write_layer;
 
 static int non_empty;
 static int reuse_delta = 1, reuse_object = 1;
@@ -93,6 +95,8 @@ static uint16_t write_bitmap_options;
 
 static int exclude_promisor_objects;
 
+static int use_delta_islands;
+
 static unsigned long delta_cache_size = 0;
 static unsigned long max_delta_cache_size = DEFAULT_DELTA_CACHE_SIZE;
 static unsigned long cache_max_small_delta_size = 1000;
@@ -607,7 +611,7 @@ static inline void add_to_write_order(struct object_entry **wo,
 			       unsigned int *endp,
 			       struct object_entry *e)
 {
-	if (e->filled)
+	if (e->filled || e->layer != write_layer)
 		return;
 	wo[(*endp)++] = e;
 	e->filled = 1;
@@ -669,6 +673,7 @@ static void add_family_to_write_order(struct object_entry **wo,
 
 static struct object_entry **compute_write_order(void)
 {
+	uint32_t max_layers = 1;
 	unsigned int i, wo_end, last_untagged;
 
 	struct object_entry **wo;
@@ -700,51 +705,58 @@ static struct object_entry **compute_write_order(void)
 	 */
 	for_each_tag_ref(mark_tagged, NULL);
 
-	/*
-	 * Give the objects in the original recency order until
-	 * we see a tagged tip.
-	 */
+	if (use_delta_islands)
+		max_layers = compute_pack_layers(&to_pack);
+
 	ALLOC_ARRAY(wo, to_pack.nr_objects);
-	for (i = wo_end = 0; i < to_pack.nr_objects; i++) {
-		if (objects[i].tagged)
-			break;
-		add_to_write_order(wo, &wo_end, &objects[i]);
-	}
-	last_untagged = i;
+	wo_end = 0;
 
-	/*
-	 * Then fill all the tagged tips.
-	 */
-	for (; i < to_pack.nr_objects; i++) {
-		if (objects[i].tagged)
+	for (; write_layer < max_layers; ++write_layer) {
+		/*
+		 * Give the objects in the original recency order until
+		 * we see a tagged tip.
+		 */
+		for (i = 0; i < to_pack.nr_objects; i++) {
+			if (objects[i].tagged)
+				break;
 			add_to_write_order(wo, &wo_end, &objects[i]);
-	}
+		}
+		last_untagged = i;
 
-	/*
-	 * And then all remaining commits and tags.
-	 */
-	for (i = last_untagged; i < to_pack.nr_objects; i++) {
-		if (oe_type(&objects[i]) != OBJ_COMMIT &&
-		    oe_type(&objects[i]) != OBJ_TAG)
-			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
-	}
+		/*
+		 * Then fill all the tagged tips.
+		 */
+		for (; i < to_pack.nr_objects; i++) {
+			if (objects[i].tagged)
+				add_to_write_order(wo, &wo_end, &objects[i]);
+		}
 
-	/*
-	 * And then all the trees.
-	 */
-	for (i = last_untagged; i < to_pack.nr_objects; i++) {
-		if (oe_type(&objects[i]) != OBJ_TREE)
-			continue;
-		add_to_write_order(wo, &wo_end, &objects[i]);
-	}
+		/*
+		 * And then all remaining commits and tags.
+		 */
+		for (i = last_untagged; i < to_pack.nr_objects; i++) {
+			if (oe_type(&objects[i]) != OBJ_COMMIT &&
+			    oe_type(&objects[i]) != OBJ_TAG)
+				continue;
+			add_to_write_order(wo, &wo_end, &objects[i]);
+		}
 
-	/*
-	 * Finally all the rest in really tight order
-	 */
-	for (i = last_untagged; i < to_pack.nr_objects; i++) {
-		if (!objects[i].filled)
-			add_family_to_write_order(wo, &wo_end, &objects[i]);
+		/*
+		 * And then all the trees.
+		 */
+		for (i = last_untagged; i < to_pack.nr_objects; i++) {
+			if (oe_type(&objects[i]) != OBJ_TREE)
+				continue;
+			add_to_write_order(wo, &wo_end, &objects[i]);
+		}
+
+		/*
+		 * Finally all the rest in really tight order
+		 */
+		for (i = last_untagged; i < to_pack.nr_objects; i++) {
+			if (!objects[i].filled && objects[i].layer == write_layer)
+				add_family_to_write_order(wo, &wo_end, &objects[i]);
+		}
 	}
 
 	if (wo_end != to_pack.nr_objects)
@@ -1504,7 +1516,8 @@ static void check_object(struct object_entry *entry)
 			break;
 		}
 
-		if (base_ref && (base_entry = packlist_find(&to_pack, base_ref, NULL))) {
+		if (base_ref && (base_entry = packlist_find(&to_pack, base_ref, NULL)) &&
+		    in_same_island(&entry->idx.oid, &base_entry->idx.oid)) {
 			/*
 			 * If base_ref was set above that means we wish to
 			 * reuse delta data, and we even found that base
@@ -1820,6 +1833,11 @@ static int type_size_sort(const void *_a, const void *_b)
 		return -1;
 	if (a->preferred_base < b->preferred_base)
 		return 1;
+	if (use_delta_islands) {
+		int island_cmp = island_delta_cmp(&a->idx.oid, &b->idx.oid);
+		if (island_cmp)
+			return island_cmp;
+	}
 	if (a_size > b_size)
 		return -1;
 	if (a_size < b_size)
@@ -1968,6 +1986,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	if (trg_size < src_size / 32)
 		return 0;
 
+	if (!in_same_island(&trg->entry->idx.oid, &src->entry->idx.oid))
+		return 0;
+
 	/* Load data if not already done */
 	if (!trg->data) {
 		read_lock();
@@ -2506,6 +2527,9 @@ static void prepare_pack(int window, int depth)
 	uint32_t i, nr_deltas;
 	unsigned n;
 
+	if (use_delta_islands)
+		resolve_tree_islands(progress, &to_pack);
+
 	get_object_details();
 
 	/*
@@ -2669,6 +2693,9 @@ static void show_commit(struct commit *commit, void *data)
 
 	if (write_bitmap_index)
 		index_commit_for_bitmap(commit);
+
+	if (use_delta_islands)
+		propagate_island_marks(commit);
 }
 
 static void show_object(struct object *obj, const char *name, void *data)
@@ -2676,6 +2703,19 @@ static void show_object(struct object *obj, const char *name, void *data)
 	add_preferred_base_object(name);
 	add_object_entry(&obj->oid, obj->type, name, 0);
 	obj->flags |= OBJECT_ADDED;
+
+	if (use_delta_islands) {
+		const char *p;
+		unsigned depth = 0;
+		struct object_entry *ent;
+
+		for (p = strchr(name, '/'); p; p = strchr(p + 1, '/'))
+			depth++;
+
+		ent = packlist_find(&to_pack, obj->oid.hash, NULL);
+		if (ent && depth > ent->tree_depth)
+			ent->tree_depth = depth;
+	}
 }
 
 static void show_object__ma_allow_any(struct object *obj, const char *name, void *data)
@@ -3003,6 +3043,9 @@ static void get_object_list(int ac, const char **av)
 	if (use_bitmap_index && !get_object_list_from_bitmap(&revs))
 		return;
 
+	if (use_delta_islands)
+		load_delta_islands();
+
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(&revs, show_edge);
@@ -3182,6 +3225,8 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		  option_parse_missing_action },
 		OPT_BOOL(0, "exclude-promisor-objects", &exclude_promisor_objects,
 			 N_("do not pack objects in promisor packfiles")),
+		OPT_BOOL(0, "delta-islands", &use_delta_islands,
+			 N_("respect islands during delta compression")),
 		OPT_END(),
 	};
 
@@ -3308,6 +3353,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	if (pack_to_stdout || !rev_list_all)
 		write_bitmap_index = 0;
 
+	if (use_delta_islands)
+		argv_array_push(&rp, "--topo-order");
+
 	if (progress && all_progress_implied)
 		progress = 2;
 
-- 
2.18.0.327.ga7d188ab43

