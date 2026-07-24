Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CDD3C942E
	for <git@vger.kernel.org>; Fri, 24 Jul 2026 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784927177; cv=none; b=PAcGK+X/onwOe4Nzvu1eEK48UCIjyfF1u4PnD8mDSrC+IttoBDmQr0vzTeQwxZurvTqUZdaiTt+gR39B5FNOFwBHnsPoxLMK9S04X9eOUjxNH3/OzkEtBH14D8tg29sa1eQimgY9OpLd7hWC3Gb4VPukIbGwrdlv1BwkaE4xhz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784927177; c=relaxed/simple;
	bh=rVf8OmZBg1sYzpXaaWUcXj3rELFIDdlX9uwWUoH8CLU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+1O6K0+kkA1Qwkgw/5/Z1xMBC66vSnI3eC82r9krlSXpmb0UtWDfLfVFsmQApAWvknvUeVwjmlvzsd+EwB+va356VwsHPf/z+GdwdgFB0sRkGWrTMjuUok+weJYP9yR4+UjjL38jo9DbB+cJppwQuJegz3Ew2rxmIPzQbGN5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=f1fXD3wF; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="f1fXD3wF"
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6611669cd16so804579d50.0
        for <git@vger.kernel.org>; Fri, 24 Jul 2026 14:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784927164; x=1785531964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GznjXyJ75dsVqpEc40aEOAdCaIaaDwL/dFS/47Us2A8=;
        b=f1fXD3wFU6TiLGsPCE6DIAiH75pQ0jfGF5iialpfyJEVuDZ9JKZs+kt0Xqz3FrLzy8
         WypU0ovbmPdVsswDP8PtIMdMeqU4HckEc4CVitFjNQsIwplD3WjowTL0pbUAuMqs0+Bb
         o9a6VpCL4Jlfv8SyaZqp7ZPZYKA4lFDR3a4tc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784927164; x=1785531964;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GznjXyJ75dsVqpEc40aEOAdCaIaaDwL/dFS/47Us2A8=;
        b=Jzbx8xFjUqstl4mpHQahKdLI5s3iVjitRaL3XWgc/NW+ZNzqN4kqFpbdeq01155vIT
         j0kFLhG/JCxCjxDRb5yuk/EoPt+sXzMWBcBRWEn+YR47McYe8qWzc/BBxXDdED/7zs74
         2E9jsSJYfMXXOYzvtOjRVKXcqZ/Suhq8ghb2Lta2tlYWPY4Q9g9fIkA/h9JxGcVwHq8O
         UjoSh8++qvngSiLFC4J/xq6+cbQL84pVb7IB6nPO3lhcmKnr8O/CCfM2f9ihc+Zp1lNT
         J+P+CXX/bileCjMNePmSCzxSqKSRvhaJjvGUotoiqceW/OUdKQH3taFcWHycdGYAXlLu
         /Iow==
X-Gm-Message-State: AOJu0Yx0eFnacaeB+ALSEbPl2s1JnbqDdi7dZu8smrX0JwVH8onW2eRm
	75xN4XM/TMMGmkrPQ70ohf9I997Djt39PBANhXBPFLBQtRGU47/4d1I35OZdNO10b44kGSHw6V3
	S3rrKN88=
X-Gm-Gg: AR+sD138ee/NcA8uGZbxXpYb0WrasNZPeLqBWUHr64YL7S4/uWRFZti0ZrWqYVX6WL1
	C+UBD1+z2de1ts1NHvrcOpWH9qQLG1vTr7zl+9UpAPIDupYMt95GGKQPevYOL5Tb3SbMr4FEncb
	vj+HOCihmk4T2OMl3+zC6Y+l6VGIoln5b2uj79yMlwmJGxiG91DulVklrbqbzEV4adAURfqri6K
	FdcuCaTtdORRzHMs1EWii41rWTEDsljXEtMPfyPZPTzVcIm3t5BUb9odR+FPj5KQVpdPaHJ9q+m
	huwcPu+x5LfSWDD+Z1tcV7Idq+ZF8PkocUpbWOY9fdwhDZGP9WASyTvyb53yOoeV2bo/7Fyninp
	kIxBne+/ddcRxE5TQeQpCZWMbhcFFzRKUNgsyaOIjgEiFzOJErqt7aFjZQjm8BNdJhO9xbDunA8
	sUG05sWGRNnzgSFSJxvNHNzumq5SSQz46T/h2guThA0jcTIOL9fGvjJEWRvY0FztGhiWMhZBB2l
	2uw6XF6Lc79htEfs/k7ui2EaDp9F+EoAPzWUqUMKoK2gu0Zb2pUIBs=
X-Received: by 2002:a53:ced0:0:b0:667:bb60:78b2 with SMTP id 956f58d0204a3-668a4c25326mr2009852d50.34.1784927163837;
        Fri, 24 Jul 2026 14:06:03 -0700 (PDT)
Received: from com-79390 (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-668c6f6ae98sm12430d50.10.2026.07.24.14.06.02
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 14:06:03 -0700 (PDT)
Date: Fri, 24 Jul 2026 16:06:00 -0500
From: Taylor Blau <ttaylorr@openai.com>
To: git@vger.kernel.org
Subject: [PATCH 2/5] packfile: recover delta cycles through duplicate entries
Message-ID: <c66a9cabba9469ab2324ccbfbcef3e789593dba3.1784927134.git.ttaylorr@openai.com>
References: <cover.1784927134.git.ttaylorr@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1784927134.git.ttaylorr@openai.com>

98f8854c94 (index-pack: allow revisiting REF_DELTA chains, 2025-04-28)
changed t5309's recoverable-cycle case to expect index-pack to accept
the pack, but did not read the resulting objects. The .idx for a pack
with duplicate OIDs retains every physical entry, with equal OIDs in a
contiguous run. Ordinary REF_DELTA lookup selects one representation
from such a run. If that choice closes a cycle, both type and content
readers follow the same physical offsets indefinitely even though
another representation is usable.

Keep the ordinary walk, and recognize a cycle only when its existing
stack shows an exact repeated pack offset. At that point, restart at the
requested object and search duplicate representations depth-first.
Treat each OID as a node, try each entry in its .idx run, and translate
OFS_DELTA bases back to OIDs. A bitmap marks each OID group already
visited. Reaching a full object records the exact offsets along the
acyclic path so unpack_entry() can replay it; packed_to_object_type()
needs only the resulting type.

Thus, acyclic lookups continue to use the existing single-entry lookup.
Duplicate-run scans, the visited bitmap, and OFS-to-OID translation
remain confined to recovery after a proven cycle.

Extend t5309 to read both type and content after indexing. Cover a
root-level full duplicate, a mixed REF/OFS cycle, and a tail into a
three-object cycle which must backtrack before taking an alternate
REF_DELTA/OFS_DELTA path to a full base. Keep the fixtures
hash-independent so the same cases run under SHA-1 and SHA-256. This
adds the reader validation missing from the earlier acceptance test.

Signed-off-by: Taylor Blau <ttaylorr@openai.com>
---
 packfile.c                   | 199 +++++++++++++++++++++++++++++++++++
 t/t5309-pack-delta-cycles.sh | 148 ++++++++++++++++++++++++--
 2 files changed, 341 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index 0eee45055f..6049d1fd8c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -10,6 +10,7 @@
 #include "dir.h"
 #include "packfile.h"
 #include "delta.h"
+#include "ewah/ewok.h"
 #include "hash-lookup.h"
 #include "commit.h"
 #include "object.h"
@@ -1077,6 +1078,160 @@ static int get_delta_base_oid(struct packed_git *p,
 		return -1;
 }
 
+/*
+ * Search duplicate representations for a chain ending in a full object.
+ * Representations of the same OID are interchangeable as delta bases.
+ *
+ * Each path entry is the search frame for one OID. It walks that OID's
+ * contiguous .idx entries and retains the chosen entry's .pack offset
+ * for replay.
+ */
+struct delta_path_entry {
+	off_t selected_offset; /* zero until a candidate is selected */
+	uint32_t next; /* index position of the next candidate */
+	uint32_t remaining; /* total number of candidates remaining */
+};
+
+struct delta_path {
+	struct delta_path_entry *entries;
+	size_t nr, alloc;
+};
+
+static int push_oid_group(struct packed_git *p,
+			  const struct object_id *oid,
+			  struct bitmap *visited, struct delta_path *path)
+{
+	struct object_id candidate;
+	struct delta_path_entry *entry;
+	uint32_t first_index_pos, group_index_pos, index_pos;
+
+	/*
+	 * Determine the range of index positions referring to duplicate
+	 * copies of the given object.
+	 *
+	 * Any position within that range is OK, since we will determine
+	 * the exact range below.
+	 */
+	if (!bsearch_pack(oid, p, &group_index_pos))
+		return 0;
+	if (bitmap_get(visited, group_index_pos))
+		return 0;
+
+	first_index_pos = group_index_pos;
+	while (first_index_pos > 0) {
+		if (nth_packed_object_id(&candidate, p, first_index_pos - 1) < 0)
+			return -1;
+		if (!oideq(&candidate, oid))
+			break;
+		first_index_pos--;
+	}
+
+	for (index_pos = first_index_pos; index_pos < p->num_objects; index_pos++) {
+		if (nth_packed_object_id(&candidate, p, index_pos) < 0)
+			return -1;
+		if (!oideq(&candidate, oid))
+			break;
+	}
+
+	bitmap_set(visited, group_index_pos);
+
+	ALLOC_GROW(path->entries, path->nr + 1, path->alloc);
+	entry = &path->entries[path->nr++];
+	entry->selected_offset = 0;
+	entry->next = first_index_pos;
+	entry->remaining = index_pos - first_index_pos;
+
+	return 1;
+}
+
+static enum object_type find_delta_path(struct packed_git *p,
+					struct pack_window **w_curs,
+					off_t offset,
+					struct delta_path *path)
+{
+	struct object_id oid;
+	uint32_t pack_pos;
+	struct bitmap *visited;
+	enum object_type result = OBJ_BAD;
+
+	if (offset_to_pack_pos(p, offset, &pack_pos) < 0)
+		return OBJ_BAD;
+	if (nth_packed_object_id(&oid, p, pack_pos_to_index(p, pack_pos)) < 0)
+		return OBJ_BAD;
+
+	visited = bitmap_new();
+	if (push_oid_group(p, &oid, visited, path) != 1)
+		goto done;
+
+	/*
+	 * Search depth-first for a chain ending in a full object. Each frame
+	 * tries every representation of one OID; a delta pushes its base OID,
+	 * while exhausting a frame backtracks to its parent.
+	 */
+	while (path->nr) {
+		struct delta_path_entry *entry = &path->entries[path->nr - 1];
+		enum object_type candidate_type;
+		off_t curpos;
+		size_t size;
+
+		/*
+		 * This OID has no path to a full object. Let its parent try
+		 * another representation; exhausting the root fails the search.
+		 */
+		if (!entry->remaining) {
+			path->nr--;
+			continue;
+		}
+
+		entry->selected_offset =
+			nth_packed_object_offset(p, entry->next++);
+		entry->remaining--;
+		curpos = entry->selected_offset;
+		candidate_type = unpack_object_header(p, w_curs, &curpos, &size);
+
+		/*
+		 * A full object terminates the chain, and its type is
+		 * inherited by every delta above it. A delta continues
+		 * at its base; any other type rejects only this
+		 * representation.
+		 */
+		switch (candidate_type) {
+		case OBJ_COMMIT:
+		case OBJ_TREE:
+		case OBJ_BLOB:
+		case OBJ_TAG:
+			result = candidate_type;
+			goto done;
+		case OBJ_OFS_DELTA:
+		case OBJ_REF_DELTA:
+			break;
+		default:
+			/*
+			 * A bad or unknown type rejects only this copy;
+			 * another representation of the same OID may
+			 * still work.
+			 */
+			continue;
+		}
+
+		/*
+		 * Descend to this delta's base. A malformed reference
+		 * or a missing or already-visited base rejects this
+		 * copy. A newly pushed base is examined next; an index
+		 * error aborts the search.
+		 */
+		if (get_delta_base_oid(p, w_curs, curpos, &oid, candidate_type,
+				       entry->selected_offset))
+			continue;
+		if (push_oid_group(p, &oid, visited, path) < 0)
+			goto done;
+	}
+
+done:
+	bitmap_free(visited);
+	return result;
+}
+
 static int retry_bad_packed_offset(struct repository *r,
 				   struct packed_git *p,
 				   off_t obj_offset)
@@ -1105,11 +1260,27 @@ static enum object_type packed_to_object_type(struct repository *r,
 {
 	off_t small_poi_stack[POI_STACK_PREALLOC];
 	off_t *poi_stack = small_poi_stack;
+	off_t root_offset = obj_offset;
 	int poi_stack_nr = 0, poi_stack_alloc = POI_STACK_PREALLOC;
 
 	while (type == OBJ_OFS_DELTA || type == OBJ_REF_DELTA) {
 		off_t base_offset;
 		size_t size;
+
+		if (poi_stack_nr > 0 && poi_stack_nr % 2 == 0 &&
+		    obj_offset == poi_stack[poi_stack_nr / 2]) {
+			struct delta_path path = { 0 };
+			/*
+			 * Normal lookup returned to the same pack
+			 * entry. Restart from the requested object
+			 * using alternate representations.
+			 */
+			type = find_delta_path(p, w_curs, root_offset, &path);
+			free(path.entries);
+			if (type == OBJ_BAD)
+				goto unwind;
+			break;
+		}
 		/* Push the object we're going to leave behind */
 		if (poi_stack_nr >= poi_stack_alloc && poi_stack == small_poi_stack) {
 			poi_stack_alloc = alloc_nr(poi_stack_nr);
@@ -1525,9 +1696,11 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 {
 	struct pack_window *w_curs = NULL;
 	off_t curpos = obj_offset;
+	off_t root_offset = obj_offset;
 	void *data = NULL;
 	size_t size;
 	enum object_type type;
+	struct delta_path path = { 0 };
 	struct unpack_entry_stack_ent small_delta_stack[UNPACK_ENTRY_STACK_PREALLOC];
 	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
 	int delta_stack_nr = 0, delta_stack_alloc = UNPACK_ENTRY_STACK_PREALLOC;
@@ -1553,6 +1726,22 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			break;
 		}
 
+		if (!path.nr &&
+		    delta_stack_nr > 0 && delta_stack_nr % 2 == 0 &&
+		    obj_offset == delta_stack[delta_stack_nr / 2].obj_offset) {
+			/*
+			 * Normal lookup returned to the same pack
+			 * entry. Find an acyclic path if one exists,
+			 * discard this walk, and replay that path.
+			 */
+			if (find_delta_path(p, &w_curs, root_offset,
+					    &path) == OBJ_BAD)
+				break;
+			delta_stack_nr = 0;
+			curpos = obj_offset = path.entries[0].selected_offset;
+			continue;
+		}
+
 		if (do_check_packed_object_crc && p->index_version > 1) {
 			uint32_t pack_pos, index_pos;
 			off_t len;
@@ -1591,6 +1780,15 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 			break;
 		}
 
+		/* Use the base chosen by recovery, not the one from normal lookup. */
+		if (path.nr) {
+			size_t path_pos = (size_t)delta_stack_nr + 1;
+
+			if (path_pos >= path.nr)
+				BUG("alternate delta path ends in a delta");
+			base_offset = path.entries[path_pos].selected_offset;
+		}
+
 		/* push object, proceed to base */
 		if (delta_stack_nr >= delta_stack_alloc
 		    && delta_stack == small_delta_stack) {
@@ -1731,6 +1929,7 @@ void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
 
 out:
 	unuse_pack(&w_curs);
+	free(path.entries);
 
 	if (delta_stack != small_delta_stack)
 		free(delta_stack);
diff --git a/t/t5309-pack-delta-cycles.sh b/t/t5309-pack-delta-cycles.sh
index 6b03675d91..f613950e38 100755
--- a/t/t5309-pack-delta-cycles.sh
+++ b/t/t5309-pack-delta-cycles.sh
@@ -9,6 +9,83 @@ test_description='test index-pack handling of delta cycles in packfiles'
 A=$(test_oid packlib_7_0)
 B=$(test_oid packlib_7_76)
 
+# Copy the entries from a complete pack without its header or trailer.
+pack_entries () {
+	entry_size=$(wc -c <"$1") &&
+	dd if="$1" bs=1 skip=12 \
+		count=$((entry_size - 12 - $(test_oid rawsz))) 2>/dev/null
+}
+
+# B as an OFS_DELTA against A at the given one-byte distance.
+pack_obj_b_ofs_a () {
+	pack_obj "$B" "$A" >b-ref.tmp &&
+	printf "\145" &&
+	printf "\\$(printf "%03o" "$1")" &&
+	dd if=b-ref.tmp bs=1 skip=$((1 + $(test_oid rawsz))) 2>/dev/null
+}
+
+# Return the base of the first one-byte-header REF_DELTA for the given OID.
+first_ref_base () {
+	idx=$(echo .git/objects/pack/*.idx) &&
+	offset=$(git show-index <"$idx" |
+		awk -v oid="$1" '$2 == oid { print $1; exit }') &&
+	dd if="${idx%.idx}.pack" bs=1 skip=$((offset + 1)) \
+		count=$(test_oid rawsz) 2>/dev/null |
+	test-tool hexdump |
+	tr -d " \n"
+}
+
+# The order of equal-OID entries in the .idx is unspecified. Retain a pack
+# which selects $1 as a delta against $2. Unless $3 is "-", also require the
+# first copy searched during recovery to be a REF_DELTA against $3.
+install_cycle () {
+	cycle_oid=$1 &&
+	cycle_base=$2 &&
+	first_base=$3 &&
+	shift 3 &&
+	for pack
+	do
+		clear_packs &&
+		git index-pack --fix-thin --stdin <"$pack" &&
+		selected_base=$(echo "$cycle_oid" |
+			git cat-file --batch-check="%(deltabase)") ||
+		return 1
+		if test "$selected_base" = "$cycle_base" &&
+		   { test "$first_base" = "-" ||
+		     test "$(first_ref_base "$cycle_oid")" = "$first_base"; }
+		then
+			return 0
+		fi
+	done
+	return 1
+}
+
+make_cycle_pack () {
+	cycle_pack=$1 &&
+	shift &&
+	test-tool -C alt-source pack-deltas --num-objects=6 >refs.tmp <<-EOF &&
+	REF_DELTA $T $X
+	REF_DELTA $X $1
+	REF_DELTA $Y $Z
+	REF_DELTA $Z $X
+	REF_DELTA $X $2
+	REF_DELTA $X $3
+	EOF
+	{
+		pack_header 8 &&
+		pack_entries refs.tmp &&
+		cat a-full &&
+		pack_obj_b_ofs_a "$a_full_size"
+	} >"$cycle_pack" &&
+	pack_trailer "$cycle_pack"
+}
+
+check_blob () {
+	test "$(git cat-file -t "$1")" = blob &&
+	git cat-file blob "$1" >actual &&
+	test_cmp_bin "$2" actual
+}
+
 # double-check our hand-constucted packs
 test_expect_success 'index-pack works with a single delta (A->B)' '
 	clear_packs &&
@@ -67,18 +144,77 @@ test_expect_success 'failover to an object in another pack' '
 '
 
 test_expect_success 'failover to a duplicate object in the same pack' '
-	clear_packs &&
+	{
+		pack_header 3 &&
+		pack_obj $A &&
+		pack_obj $B $A &&
+		pack_obj $A $B
+	} >recoverable-1.pack &&
+	pack_trailer recoverable-1.pack &&
 	{
 		pack_header 3 &&
 		pack_obj $A $B &&
 		pack_obj $B $A &&
 		pack_obj $A
-	} >recoverable.pack &&
-	pack_trailer recoverable.pack &&
+	} >recoverable-2.pack &&
+	pack_trailer recoverable-2.pack &&
 
-	# This cycle does not fail since the existence of a full copy
-	# of A in the pack allows us to resolve the cycle.
-	git index-pack --fix-thin --stdin <recoverable.pack
+	# The selected copy of A is part of the cycle, but the full copy
+	# lets both type and content lookups resolve it.
+	install_cycle "$A" "$B" - recoverable-1.pack recoverable-2.pack &&
+	printf "\7\0" >expect &&
+	check_blob "$A" expect
+'
+
+test_expect_success 'failover from a mixed REF/OFS cycle' '
+	pack_obj "$A" "$B" >a-ref &&
+	pack_obj "$B" >b-full &&
+	a_ref_size=$(wc -c <a-ref) &&
+	b_full_size=$(wc -c <b-full) &&
+
+	{
+		pack_header 3 &&
+		cat a-ref &&
+		cat b-full &&
+		pack_obj_b_ofs_a "$((a_ref_size + b_full_size))"
+	} >mixed-1.pack &&
+	pack_trailer mixed-1.pack &&
+	{
+		pack_header 3 &&
+		cat a-ref &&
+		pack_obj_b_ofs_a "$a_ref_size" &&
+		cat b-full
+	} >mixed-2.pack &&
+	pack_trailer mixed-2.pack &&
+
+	# The REF_DELTA for A selects the OFS_DELTA copy of B; the
+	# full B is its escape.
+	install_cycle "$B" "$A" - mixed-1.pack mixed-2.pack &&
+	printf "\7\0" >expect &&
+	check_blob "$A" expect
+'
+
+test_expect_success 'failover after a tail into a three-object delta cycle' '
+	git init alt-source &&
+	printf "\7\76" |
+		git -C alt-source hash-object -w --stdin >/dev/null &&
+	X=$(printf x | git -C alt-source hash-object -w --stdin) &&
+	Y=$(printf y | git -C alt-source hash-object -w --stdin) &&
+	Z=$(printf z | git -C alt-source hash-object -w --stdin) &&
+	printf "tail T\n" >tail &&
+	T=$(git -C alt-source hash-object -w --stdin <tail) &&
+
+	pack_obj "$A" >a-full &&
+	a_full_size=$(wc -c <a-full) &&
+	make_cycle_pack alternate-1.pack "$B" "$Y" "$Y" &&
+	make_cycle_pack alternate-2.pack "$Y" "$B" "$Y" &&
+	make_cycle_pack alternate-3.pack "$Y" "$Y" "$B" &&
+
+	# Lookup of T follows T->X->Y->Z->X. Recovery must exhaust that
+	# branch, then use X->B->A, whose final edge is an OFS_DELTA.
+	install_cycle "$X" "$Y" "$Y" \
+		alternate-1.pack alternate-2.pack alternate-3.pack &&
+	check_blob "$T" tail
 '
 
 test_expect_success 'index-pack works with thin pack A->B->C with B on disk' '
-- 
2.55.0.383.gde07827a19

