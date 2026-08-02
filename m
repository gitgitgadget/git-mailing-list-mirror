Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059537F739
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 21:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785706401; cv=none; b=AjFqHIruGRg9QoV20CsEylJNcYdinBskDigz/1XroYAiPT80seCWiFJBxjSA7FSQVyeaQkOQxfdr7Xoh8djAUhX10dLWr5vU1lcPoVNnnaqfOCvxaHFyHgCpl/u6M8V/xI0gHQ8Rb7eF0Nqm5thgcR/ZlboYH3l8ZSeGhfCuwgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785706401; c=relaxed/simple;
	bh=8qH0RHV+TXkvcILVLN8uEtc9N++4pbZ+GYer3efG+oU=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=KJKxa2ItryR9ULYkeAuKnWGYpqqGJ+OUIDA4q8G66SPkyv4rAvYcak+v3VzG+6zPzTbj/AHHec1t/BXEoMqbft3a9QIkpBBIMtrBBByBvjmwvxnPn9du17EEtg6rwymMggaDdfleg7W/IBba/+kCvryb+s+tjAX0LXsPUU5W+6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rgh1+/u2; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rgh1+/u2"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8eeb4508f29so18169086d6.0
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 14:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785706398; x=1786311198; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7bh7HJIouzQgKqTR0RecS1bYAMTMmygGUGDgQjp0EAc=;
        b=Rgh1+/u2T5Oneqh0BukUUh7JvjAlHw7mDpHF4i9PwWEgPm0rMc6qD/LJ32jZ613Tla
         VBolM16ZBuNH5SngFVH8pzgAedbujJegWjkG09sVNvMfZBia8XYVnTIQk3B1oSQ2maPo
         +lmK4jNaIIohKeJt5SoL7b1TNs7r7NI408FBvRUpdzPbfJaK7PmRlhCHLcsXgVs/c0io
         4viPNnxh++3GMqz+6tboE/vUuyML29NXA+4VfjCrjY+OjDIvLXbmpoxrs2koY7wBE4hX
         ZzChQ4NUvlEGpG6r3Sci3KxsTXwsDLEodL++V/lfIfwmADqRtNff9j9KBFDVO39VBzw3
         5GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785706398; x=1786311198;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7bh7HJIouzQgKqTR0RecS1bYAMTMmygGUGDgQjp0EAc=;
        b=LQJ1tuJcJpCcY2hOyJhw9zR0Nb6e6U4/k3rtbBKQDgDJzqmbm06Xch1jmMeCPT5QsP
         ZSZDb/fj02wEWSo3bbnVo6LQ4eMKI7BW4EilzXYdzSWua7vrgRUGy+Vap3j8Xy3WScQf
         sMYQQpWqFUo3qSJO0d7Ed66HJe1gYMVkcFVLFft0FwiUB754tNNE7odsp757Ecl8SH4g
         irKVDackCqaeYhHPmwBVLLfzdoXoACM5zLHb+wgwE+Qn8qiT3BwMqHjKz3o2nITcmtqL
         2kPtFMvxUug6CBP26Bhdaafcw7igOXaWZfPwkdfGA4WLYmgPlQtXgHbFFJm+vq+hvv8T
         h+pA==
X-Gm-Message-State: AOJu0YxhznyofnxDOkuH2Y6zjyzhxs8TN/2WAjVFSLSBIdSusZFjgGpE
	QPmnDzfTvwz2AJn7OazRG1jXOVxbCuA5J1yrmVEoJ7s3KpKueEDsYhV4ht8jqw==
X-Gm-Gg: AR+sD13b2/mDRwwGpoZ6S9hnHcDIbQ7B5xTvzLODsLgr3pZebuifYFKljY3W+ChNJ/0
	cNJzHxD3WboI8mnvlGRe8sqvHgKeMP7v/60L7aD+/FaBeGPuZm8Igf9p52an/epxDIRiyffQF7R
	HWWXTqv8DBeMNA6MsoDskUcp0FP7ybW5u26VOPRrx3V1QLckGuewY2/G1SyRcYIGVoYqEYACZPP
	OygOxHWEUxvywadLA1P3dS055RSaLcs+TmDc5Xarbuf4z4KSbYeNrAWefpDO+PFWE3v1ZGQHSxJ
	pO78oVk/4bB+EdkXXqMyRRWaI8WgCamiP6IYu/R62FxN7DViIWsz2txAuLw67+20crL9dQL2IzA
	tV9dXL00ThToWS0f9Esw3tc0/RQnwHG4gy7Mxo/Ht1+EIw6tUp7h5ebHTLPjfpMWfo7E3ytZ/GR
	qsqEu5PfA0Isns9a2X/PTFcDxITpxZUKLYzFcrVM+QqtQnqPKz+Z0M/UmYi1Ds9A==
X-Received: by 2002:a05:6214:3f8e:b0:907:82de:4309 with SMTP id 6a1803df08f44-9084955465cmr178185076d6.2.1785706398227;
        Sun, 02 Aug 2026 14:33:18 -0700 (PDT)
Received: from [127.0.0.1] ([9.234.149.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-908435eceb2sm61754006d6.41.2026.08.02.14.33.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 14:33:17 -0700 (PDT)
Message-Id: <pull.2191.git.1785706396130.gitgitgadget@gmail.com>
From: "Arijit Banerjee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 02 Aug 2026 21:33:15 +0000
Subject: [PATCH] index-pack: speed up promisor link recording
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Jonathan Tan <jonathantanmy@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Junio C Hamano <gitster@pobox.com>,
    Arijit Banerjee <arijit91@gmail.com>,
    Arijit Banerjee <arijit@effectiveailabs.com>

From: Arijit Banerjee <arijit@effectiveailabs.com>

When indexing a promisor pack, index-pack parses every reconstructed
non-blob object into the shared object model to record its outgoing links.
Since parse_object_buffer() runs under read_mutex, worker threads serialize
while allocating persistent tree, commit, and tag structures that are only
needed to enumerate those links.

Read the links directly from the reconstructed object buffers instead. Keep
the strict and fsck paths unchanged, use worker-local typed oidmaps during
normal promisor indexing, and merge them after the workers exit. Transfer
entries during the merge so that it does not temporarily duplicate the
complete link set.

The typed entries preserve checks previously performed as a side effect of
object parsing. Reject malformed commit and tag headers, conflicting
expected types, and targets whose actual type disagrees when the target is
present in the pack. Preserve commit-graft handling and the existing policy
of recording only subtree entries from trees.

With three runs per version on Debian 12, median end-to-end wall-clock time
for a --filter=blob:none clone of linux.git decreased from 156 seconds to
133 seconds (15%). Trace2 attributed the change to the initial index-pack
--promisor phase, whose median duration decreased from 121 seconds to 98
seconds (19%). System CPU time decreased by 46%.

Two paired spot checks against GitHub showed end-to-end reductions of 18%
and 26%. These measurements include network and server variability and are
therefore corroborating rather than controlled results. A third pair was not
interpretable because the baseline request encountered a transport stall.

A full-clone control showed no material change, taking approximately 256
seconds with either version. This is expected because full clones do not
exercise promisor-link recording.

t5302-pack-index.sh passed with both SHA-1 and SHA-256, while
t0410-partial-clone.sh and t5616-partial-clone.sh also passed. New coverage
checks malformed commit headers, conflicting link types, and mismatched tag
target types.

Signed-off-by: Arijit Banerjee <arijit@effectiveailabs.com>
---
    index-pack: speed up promisor link recording
    
    AI assistance: OpenAI Codex was used to identify the bottleneck and
    assist with the implementation, testing, and benchmark analysis. I
    reviewed the resulting change and take responsibility for this
    submission.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2191%2Farijit91%2Findex-pack-promisor-link-recording-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2191/arijit91/index-pack-promisor-link-recording-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2191

 builtin/index-pack.c  | 234 ++++++++++++++++++++++++++++++++++++++----
 t/t5302-pack-index.sh |  50 +++++++++
 2 files changed, 265 insertions(+), 19 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bc86925ad0..a973146757 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -23,7 +23,8 @@
 #include "odb.h"
 #include "odb/streaming.h"
 #include "oid-array.h"
-#include "oidset.h"
+#include "hash-lookup.h"
+#include "oidmap.h"
 #include "path.h"
 #include "replace-object.h"
 #include "tree-walk.h"
@@ -105,6 +106,12 @@ static size_t base_cache_limit;
 struct thread_local_data {
 	pthread_t thread;
 	int pack_fd;
+	struct oidmap outgoing_links;
+};
+
+struct outgoing_link {
+	struct oidmap_entry entry;
+	enum object_type type;
 };
 
 /* Remember to update object flag allocation in object.h */
@@ -155,11 +162,8 @@ static uint32_t input_crc32;
 static int input_fd, output_fd;
 static const char *curr_pack;
 
-/*
- * outgoing_links is guarded by read_mutex, and record_outgoing_links is
- * read-only in a thread.
- */
-static struct oidset outgoing_links = OIDSET_INIT;
+/* Worker-local maps are merged after all workers have exited. */
+static struct oidmap outgoing_links = OIDMAP_INIT;
 static int record_outgoing_links;
 
 static struct thread_local_data *thread_data;
@@ -196,6 +200,55 @@ static inline void unlock_mutex(pthread_mutex_t *mutex)
 		pthread_mutex_unlock(mutex);
 }
 
+static void record_outgoing_link_to(struct oidmap *map,
+				    const struct object_id *oid,
+				    enum object_type type)
+{
+	struct outgoing_link *link = oidmap_get(map, oid);
+
+	if (link) {
+		if (type != OBJ_ANY && link->type != OBJ_ANY &&
+		    type != link->type)
+			die(_("object %s is referred to as both a %s and a %s"),
+			    oid_to_hex(oid), type_name(link->type),
+			    type_name(type));
+		if (link->type == OBJ_ANY)
+			link->type = type;
+		return;
+	}
+
+	CALLOC_ARRAY(link, 1);
+	oidcpy(&link->entry.oid, oid);
+	link->type = type;
+	if (oidmap_put(map, link))
+		BUG("duplicate outgoing link");
+}
+
+static void merge_outgoing_links(struct oidmap *dest, struct oidmap *src)
+{
+	struct oidmap_iter iter;
+	struct outgoing_link *link;
+
+	while ((link = oidmap_iter_first(src, &iter))) {
+		struct outgoing_link *old = oidmap_get(dest, &link->entry.oid);
+
+		oidmap_remove(src, &link->entry.oid);
+		if (old) {
+			if (link->type != OBJ_ANY && old->type != OBJ_ANY &&
+			    link->type != old->type)
+				die(_("object %s is referred to as both a %s and a %s"),
+				    oid_to_hex(&link->entry.oid),
+				    type_name(old->type), type_name(link->type));
+			if (old->type == OBJ_ANY)
+				old->type = link->type;
+			free(link);
+		} else if (oidmap_put(dest, link)) {
+			BUG("duplicate outgoing link");
+		}
+	}
+	oidmap_clear(src, 0);
+}
+
 /*
  * Mutex and conditional variable can't be statically-initialized on Windows.
  */
@@ -211,6 +264,7 @@ static void init_thread(void)
 	CALLOC_ARRAY(thread_data, nr_threads);
 	for (i = 0; i < nr_threads; i++) {
 		thread_data[i].pack_fd = xopen(curr_pack, O_RDONLY);
+		oidmap_init(&thread_data[i].outgoing_links, 0);
 	}
 
 	threads_active = 1;
@@ -221,14 +275,17 @@ static void cleanup_thread(void)
 	int i;
 	if (!threads_active)
 		return;
-	threads_active = 0;
 	pthread_mutex_destroy(&read_mutex);
 	pthread_mutex_destroy(&counter_mutex);
 	pthread_mutex_destroy(&work_mutex);
 	if (show_stat)
 		pthread_mutex_destroy(&deepest_delta_mutex);
-	for (i = 0; i < nr_threads; i++)
+	for (i = 0; i < nr_threads; i++) {
+		merge_outgoing_links(&outgoing_links,
+				     &thread_data[i].outgoing_links);
 		close(thread_data[i].pack_fd);
+	}
+	threads_active = 0;
 	pthread_key_delete(key);
 	free(thread_data);
 }
@@ -818,9 +875,14 @@ static int check_collison(struct object_entry *entry)
 	return 0;
 }
 
-static void record_outgoing_link(const struct object_id *oid)
+static void record_outgoing_link(const struct object_id *oid,
+				 enum object_type type)
 {
-	oidset_insert(&outgoing_links, oid);
+	struct oidmap *map = &outgoing_links;
+
+	if (threads_active && !strict && !do_fsck_object)
+		map = &get_thread_data()->outgoing_links;
+	record_outgoing_link_to(map, oid, type);
 }
 
 static void maybe_record_name_entry(const struct name_entry *entry)
@@ -849,7 +911,97 @@ static void maybe_record_name_entry(const struct name_entry *entry)
 	 * pack, so it won't be GC-ed, the tradeoff seems worth it.
 	*/
 	if (S_ISDIR(entry->mode))
-		record_outgoing_link(&entry->oid);
+		record_outgoing_link(&entry->oid, OBJ_ANY);
+}
+
+static int parse_outgoing_link_oid(const char **buf, const char *tail,
+				   const char *header, struct object_id *oid)
+{
+	const char *end;
+	size_t header_len = strlen(header);
+
+	if (tail - *buf <= header_len + the_hash_algo->hexsz ||
+	    memcmp(*buf, header, header_len) ||
+	    parse_oid_hex_algop(*buf + header_len, oid, &end,
+				the_hash_algo) ||
+	    end >= tail || *end != '\n')
+		return -1;
+	*buf = end + 1;
+	return 0;
+}
+
+static void record_outgoing_links_from_data(const void *data,
+					    unsigned long size,
+					    enum object_type type,
+					    const struct object_id *oid)
+{
+	const char *buf = data;
+	const char *tail = buf + size;
+
+	if (type == OBJ_TREE) {
+		struct tree_desc desc;
+		struct name_entry entry;
+
+		if (init_tree_desc_gently(&desc, oid, data, size, 0))
+			return;
+		while (tree_entry_gently(&desc, &entry))
+			maybe_record_name_entry(&entry);
+	} else if (type == OBJ_COMMIT) {
+		struct object_id link;
+		struct commit_graft *graft;
+		int i;
+
+		if (threads_active &&
+		    !the_repository->parsed_objects->commit_graft_prepared)
+			BUG("commit grafts were not prepared before resolving deltas");
+		graft = lookup_commit_graft(the_repository, oid);
+
+		if (parse_outgoing_link_oid(&buf, tail, "tree ", &link))
+			die(_("invalid tree line in commit %s"),
+			    oid_to_hex(oid));
+		if (buf >= tail)
+			die(_("truncated commit %s after tree line"),
+			    oid_to_hex(oid));
+		record_outgoing_link(&link, OBJ_TREE);
+
+		while (tail - buf > 7 + the_hash_algo->hexsz &&
+		       starts_with(buf, "parent ")) {
+			if (parse_outgoing_link_oid(&buf, tail, "parent ",
+						    &link))
+				die(_("invalid parent line in commit %s"),
+				    oid_to_hex(oid));
+			if (buf >= tail)
+				die(_("truncated commit %s after parent line"),
+				    oid_to_hex(oid));
+			if (!graft ||
+			    (graft->nr_parent >= 0 && grafts_keep_true_parents))
+				record_outgoing_link(&link, OBJ_COMMIT);
+		}
+		if (graft)
+			for (i = 0; i < graft->nr_parent; i++)
+				record_outgoing_link(&graft->parent[i],
+						     OBJ_COMMIT);
+	} else if (type == OBJ_TAG) {
+		struct object_id link;
+		const char *line_end;
+		enum object_type target_type;
+
+		if (size < the_hash_algo->hexsz + 24 ||
+		    parse_outgoing_link_oid(&buf, tail, "object ", &link))
+			die(_("invalid object line in tag %s"), oid_to_hex(oid));
+		if (!skip_prefix(buf, "type ", &buf) ||
+		    !(line_end = memchr(buf, '\n', tail - buf)))
+			die(_("invalid type line in tag %s"), oid_to_hex(oid));
+		target_type = type_from_string_gently(buf, line_end - buf, 1);
+		if (target_type < 0)
+			die(_("invalid type line in tag %s"), oid_to_hex(oid));
+		buf = line_end + 1;
+		if (buf + 4 >= tail || !skip_prefix(buf, "tag ", &buf) ||
+		    !memchr(buf, '\n', tail - buf))
+			die(_("invalid tag name line in tag %s"),
+			    oid_to_hex(oid));
+		record_outgoing_link(&link, target_type);
+	}
 }
 
 static void do_record_outgoing_links(struct object *obj)
@@ -871,12 +1023,13 @@ static void do_record_outgoing_links(struct object *obj)
 		struct commit *commit = (struct commit *) obj;
 		struct commit_list *parents = commit->parents;
 
-		record_outgoing_link(get_commit_tree_oid(commit));
+		record_outgoing_link(get_commit_tree_oid(commit), OBJ_TREE);
 		for (; parents; parents = parents->next)
-			record_outgoing_link(&parents->item->object.oid);
+			record_outgoing_link(&parents->item->object.oid,
+					     OBJ_COMMIT);
 	} else if (obj->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) obj;
-		record_outgoing_link(get_tagged_oid(tag));
+		record_outgoing_link(get_tagged_oid(tag), tag->tagged->type);
 	}
 }
 
@@ -925,6 +1078,12 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 		free(has_data);
 	}
 
+	if (record_outgoing_links && !strict && !do_fsck_object) {
+		if (type != OBJ_BLOB)
+			record_outgoing_links_from_data(data, size, type, oid);
+		goto out;
+	}
+
 	if (strict || do_fsck_object || record_outgoing_links) {
 		read_lock();
 		if (type == OBJ_BLOB) {
@@ -975,6 +1134,7 @@ static void sha1_object(const void *data, struct object_entry *obj_entry,
 		read_unlock();
 	}
 
+out:
 	free(new_data);
 }
 
@@ -1811,20 +1971,53 @@ static void show_pack_info(int stat_only)
 	free(chain_histogram);
 }
 
+static const struct object_id *idx_object_oid(size_t pos, const void *table)
+{
+	struct pack_idx_entry * const *entries = table;
+
+	return &entries[pos]->oid;
+}
+
+static void validate_outgoing_link_types(struct pack_idx_entry **sorted,
+					 int nr)
+{
+	struct oidmap_iter iter;
+	struct outgoing_link *link;
+
+	oidmap_iter_init(&outgoing_links, &iter);
+	while ((link = oidmap_iter_next(&iter))) {
+		int pos;
+		struct object_entry *actual;
+
+		if (link->type == OBJ_ANY)
+			continue;
+		pos = oid_pos(&link->entry.oid, sorted, nr, idx_object_oid);
+		if (pos < 0)
+			continue;
+		actual = container_of(sorted[pos], struct object_entry, idx);
+		if (actual->real_type != link->type)
+			die(_("object %s is a %s, but was referred to as a %s"),
+			    oid_to_hex(&link->entry.oid),
+			    type_name(actual->real_type),
+			    type_name(link->type));
+	}
+}
+
 static void repack_local_links(void)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	FILE *out;
 	struct strbuf line = STRBUF_INIT;
-	struct oidset_iter iter;
-	struct object_id *oid;
+	struct oidmap_iter iter;
+	struct outgoing_link *link;
 	char *base_name = NULL;
 
-	if (!oidset_size(&outgoing_links))
+	if (!oidmap_get_size(&outgoing_links))
 		return;
 
-	oidset_iter_init(&outgoing_links, &iter);
-	while ((oid = oidset_iter_next(&iter))) {
+	oidmap_iter_init(&outgoing_links, &iter);
+	while ((link = oidmap_iter_next(&iter))) {
+		const struct object_id *oid = &link->entry.oid;
 		struct odb_source_info source_info;
 		struct object_info info = {
 			.source_infop = &source_info,
@@ -1919,6 +2112,7 @@ int cmd_index_pack(int argc,
 	fsck_options.walk = mark_link;
 
 	reset_pack_idx_option(&opts);
+	oidmap_init(&outgoing_links, 0);
 	opts.flags |= WRITE_REV;
 	repo_config(the_repository, git_index_pack_config, &opts);
 	if (prefix && chdir(prefix))
@@ -2102,6 +2296,7 @@ int cmd_index_pack(int argc,
 		idx_objects[i] = &objects[i].idx;
 	curr_index = write_idx_file(the_repository, index_name, idx_objects,
 				    nr_objects, &opts, pack_hash);
+	validate_outgoing_link_types(idx_objects, nr_objects);
 	if (rev_index)
 		curr_rev_index = write_rev_file(the_repository, rev_index_name,
 						idx_objects, nr_objects,
@@ -2146,6 +2341,7 @@ int cmd_index_pack(int argc,
 	free(curr_rev_index);
 
 	repack_local_links();
+	oidmap_clear(&outgoing_links, 1);
 
 	/*
 	 * Let the caller know this pack is not self contained
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index 735de1023e..2f99a49d9d 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -309,4 +309,54 @@ test_expect_success DEFAULT_HASH_ALGORITHM 'index-pack --fsck-objects outside of
 	)
 '
 
+test_expect_success 'index-pack --promisor rejects malformed commits' '
+	test_when_finished "rm -rf malformed-src malformed-dst malformed.pack bad-commit" &&
+	test_create_repo malformed-src &&
+	test_create_repo malformed-dst &&
+	printf "tree not-an-object\n\nmessage\n" >bad-commit &&
+	bad_oid=$(git -C malformed-src hash-object --literally -t commit \
+		-w --stdin <bad-commit) &&
+	printf "%s\n" "$bad_oid" |
+		git -C malformed-src pack-objects --stdout >malformed.pack &&
+	test_must_fail git -C malformed-dst index-pack --stdin --promisor \
+		<malformed.pack 2>err &&
+	test_grep "invalid tree line in commit $bad_oid" err
+'
+
+test_expect_success 'index-pack --promisor rejects conflicting link types' '
+	test_when_finished "rm -rf conflict-src conflict-dst conflict.pack bad-commit" &&
+	test_create_repo conflict-src &&
+	test_create_repo conflict-dst &&
+	tree_oid=$(git -C conflict-src mktree </dev/null) &&
+	{
+		printf "tree %s\n" "$tree_oid" &&
+		printf "parent %s\n\nmessage\n" "$tree_oid"
+	} >bad-commit &&
+	commit_oid=$(git -C conflict-src hash-object --literally -t commit \
+		-w --stdin <bad-commit) &&
+	printf "%s\n%s\n" "$tree_oid" "$commit_oid" |
+		git -C conflict-src pack-objects --stdout >conflict.pack &&
+	test_must_fail git -C conflict-dst index-pack --stdin --promisor \
+		<conflict.pack 2>err &&
+	test_grep "object $tree_oid is referred to as both a tree and a commit" err
+'
+
+test_expect_success 'index-pack --promisor verifies tag target types' '
+	test_when_finished "rm -rf tag-src tag-dst tag.pack bad-tag" &&
+	test_create_repo tag-src &&
+	test_create_repo tag-dst &&
+	tree_oid=$(git -C tag-src mktree </dev/null) &&
+	{
+		printf "object %s\n" "$tree_oid" &&
+		printf "type commit\ntag wrong-type\n\nmessage\n"
+	} >bad-tag &&
+	tag_oid=$(git -C tag-src hash-object --literally -t tag \
+		-w --stdin <bad-tag) &&
+	printf "%s\n%s\n" "$tree_oid" "$tag_oid" |
+		git -C tag-src pack-objects --stdout >tag.pack &&
+	test_must_fail git -C tag-dst index-pack --stdin --promisor \
+		<tag.pack 2>err &&
+	test_grep "object $tree_oid is a tree, but was referred to as a commit" err
+'
+
 test_done

base-commit: a97fcc37c2bc6340a8d7ce78dedf227aac4e9aa7
-- 
gitgitgadget
