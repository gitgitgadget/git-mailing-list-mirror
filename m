Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0DE4C433DB
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EFE164F1A
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 16:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234045AbhCMQR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 13 Mar 2021 11:17:59 -0500
Received: from mout.web.de ([212.227.15.4]:50791 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233877AbhCMQRd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Mar 2021 11:17:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615652244;
        bh=C1m7xpduyYBzrtJcmEbzsWmuR88ploJyF++Qu2qWDL0=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=bJOK0Uua/y5B5IiqOQC9YZbZHwGlsYd/ls8ksD4V2otaC23YsTQQ5o8pyR3V8mWtx
         3CxdhMaXkSGyfnCyhtLtSdTFiZPA86OoPpcKjUmdNtMTLPV6gtvmETdYZCAxOu6LFy
         0KNFyRIY+ZwPf+bjF12DYEK6Tmv6MbayR7hdFNVo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MeSYJ-1l5OJg2r6d-00QELE; Sat, 13 Mar 2021 17:17:23 +0100
Subject: [PATCH 2/2] use CALLOC_ARRAY
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <b417c7cc-8e40-04df-0314-d4c3fab278b7@web.de>
Message-ID: <b2942f67-f0c0-872b-9b8c-11b6ea295412@web.de>
Date:   Sat, 13 Mar 2021 17:17:22 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <b417c7cc-8e40-04df-0314-d4c3fab278b7@web.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g6yAmIiYlVVfN+rTwzrtovMDsAp6BhIGm0Obx6smxFbYwv+CAz0
 w//b1g2cPC47NexHO+sC+4MCRD+XhxCmZuj8Nfy9DCBNcm/LivEd4n7l5rwvR6qdjzZdGJm
 e9VeWc716kngJUx8eCV65lY6hKxPstYYLYsm7GvC/xjbUiJFkNIIKrCroNBXPR5gg8k82Tw
 Wckrf+5XV4f/NVfTVGrtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PpQysbxUy60=:nB0WlmP5efAj4dUp2CP71x
 TM9Fbh4NW3KGtngg5tW7QXtQqjFjwXJPegcDFcKJ13YhXWZRfZQ1TTNDrnyOPEcf9SH/ZTmnr
 Qi3g7Ph4R8yuO8GCcSUT51LxXHSiaXzkAZwcxC+oO9TeHjtkRf56xP6k9aTl89aTPPxAtaVSU
 xrly/zVJNwwlGFEvV00ltYNPs3Ac09L2P54TlJKiaIFfb4vKqp2f9oaj6o0tCVPd/AqJGiFIy
 zOQWxnPl/awc9yj/3dWzLVN7whsu1+wcDDI7se3M++mhg3ycwcPBaLTlYmj0zA8cVXpMTKFKa
 c0t9yeIwGgRrKnwQjhFl6LxSsvxxU6YIa0C0LsteV8CN1LewLhzBtOm8kSRA5QbuHTdSkMZfn
 UHIuzDu5BEFfka6ljAKxOu6khoLxSLnCsx2SebEoqL6QHUy0xjBZfCNCW5sOjeIJfGX+AJ38M
 N8/yrWhXaoDcPXl/ULtzOzD5PQdGmdac6U8AYua4/YfEYc/4WiqQ8sGazLr+ScjBxdf9YX9hR
 oPUsm5pOMZ69cm/Oc8Qvl5ZmLftArbEARmwsTo3jFF2R2pl3I9t5dDL9di8THZCfYNk3ie9Xn
 kbAyfKl8lM4B/2aaZeM5t4JSUkwNZVb6Ko/3m7sOWABJkOePgbsyzseG9Cvs0iYy0o97/C8Qw
 dspWcB+PjzvLeQh1xK6zBhsgTgRiW04GskIfhdaO91WcuDi4UKfw+zhrOmPMHIQdlfQNpFpbu
 44RXs0HNzz6ITMktNXa49BNJmTG7Sj6v98soRUQJnY8IxnJ5g2ISNHatpCo0D65QNg7eGgWJa
 sPMir9EQRxEHDfznC9caf7vL8Q2bsVUPiaau+bSXD1sT+aj9RT+7ey0UQJI3APV4ThlrDhbrF
 55G6UXPpLAIC4AbM5xPg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add and apply a semantic patch for converting code that open-codes
CALLOC_ARRAY to use it instead.  It shortens the code and infers the
element size automatically.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 add-interactive.c              |  2 +-
 apply.c                        |  6 +++---
 archive-tar.c                  |  2 +-
 attr.c                         | 12 ++++++------
 bisect.c                       |  2 +-
 blame.c                        | 17 ++++++++---------
 bloom.c                        |  2 +-
 builtin/clean.c                |  2 +-
 builtin/fast-import.c          |  8 ++++----
 builtin/grep.c                 |  2 +-
 builtin/index-pack.c           | 10 +++++-----
 builtin/ls-remote.c            |  2 +-
 builtin/merge.c                |  2 +-
 builtin/notes.c                |  2 +-
 builtin/pack-objects.c         |  8 ++++----
 builtin/pack-redundant.c       |  2 +-
 builtin/receive-pack.c         |  4 ++--
 builtin/unpack-objects.c       |  4 ++--
 bulk-checkin.c                 |  2 +-
 cache-tree.c                   |  2 +-
 combine-diff.c                 | 20 ++++++++++----------
 commit-graph.c                 |  4 ++--
 commit-reach.c                 |  6 +++---
 commit.c                       |  4 ++--
 config.c                       |  2 +-
 contrib/coccinelle/array.cocci |  8 ++++++++
 convert.c                      |  2 +-
 daemon.c                       |  4 ++--
 decorate.c                     |  2 +-
 diff.c                         | 10 ++++------
 diffcore-rename.c              |  3 +--
 dir.c                          |  6 +++---
 ewah/bitmap.c                  |  2 +-
 fetch-pack.c                   |  2 +-
 fmt-merge-msg.c                |  2 +-
 grep.c                         |  8 ++++----
 hashmap.c                      |  2 +-
 http-backend.c                 |  2 +-
 http-push.c                    |  4 ++--
 http.c                         |  4 ++--
 imap-send.c                    |  4 ++--
 line-log.c                     |  2 +-
 line-range.c                   |  2 +-
 list-objects-filter.c          |  6 +++---
 ll-merge.c                     |  2 +-
 mailmap.c                      |  2 +-
 merge-ort.c                    |  9 ++++-----
 merge-recursive.c              |  9 ++++-----
 midx.c                         |  8 ++++----
 name-hash.c                    |  8 ++++----
 negotiator/default.c           |  2 +-
 negotiator/skipping.c          |  4 ++--
 notes-merge.c                  |  2 +-
 notes-utils.c                  |  2 +-
 notes.c                        |  2 +-
 object-file.c                  |  2 +-
 object.c                       |  4 ++--
 pack-bitmap.c                  |  4 ++--
 pack-objects.c                 |  2 +-
 packfile.c                     |  2 +-
 patch-ids.c                    |  2 +-
 pathspec.c                     |  4 ++--
 pretty.c                       |  2 +-
 progress.c                     |  2 +-
 promisor-remote.c              |  2 +-
 range-diff.c                   |  2 +-
 read-cache.c                   |  8 ++++----
 ref-filter.c                   |  6 +++---
 reflog-walk.c                  |  4 ++--
 refs.c                         |  4 ++--
 refs/files-backend.c           | 10 +++++-----
 refs/iterator.c                |  2 +-
 refs/packed-backend.c          |  4 ++--
 refs/ref-cache.c               |  2 +-
 remote.c                       |  8 ++++----
 repository.c                   |  4 ++--
 resolve-undo.c                 |  4 ++--
 revision.c                     |  6 +++---
 run-command.c                  |  4 ++--
 send-pack.c                    |  4 ++--
 sequencer.c                    |  2 +-
 server-info.c                  |  2 +-
 split-index.c                  |  4 ++--
 trailer.c                      |  2 +-
 transport-helper.c             |  4 ++--
 transport.c                    |  2 +-
 worktree.c                     |  4 ++--
 wt-status.c                    |  6 +++---
 88 files changed, 190 insertions(+), 188 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 09faee0e8f..36ebdbdf7e 100644
=2D-- a/add-interactive.c
+++ b/add-interactive.c
@@ -476,7 +476,7 @@ static void collect_changes_cb(struct diff_queue_struc=
t *q,

 			add_file_item(s->files, name);

-			entry =3D xcalloc(1, sizeof(*entry));
+			CALLOC_ARRAY(entry, 1);
 			hashmap_entry_init(&entry->ent, hash);
 			entry->name =3D s->files->items[s->files->nr - 1].string;
 			entry->item =3D s->files->items[s->files->nr - 1].util;
diff --git a/apply.c b/apply.c
index 668b16e989..6695a931e9 100644
=2D-- a/apply.c
+++ b/apply.c
@@ -1781,7 +1781,7 @@ static int parse_single_patch(struct apply_state *st=
ate,
 		struct fragment *fragment;
 		int len;

-		fragment =3D xcalloc(1, sizeof(*fragment));
+		CALLOC_ARRAY(fragment, 1);
 		fragment->linenr =3D state->linenr;
 		len =3D parse_fragment(state, line, size, patch, fragment);
 		if (len <=3D 0) {
@@ -1959,7 +1959,7 @@ static struct fragment *parse_binary_hunk(struct app=
ly_state *state,
 		size -=3D llen;
 	}

-	frag =3D xcalloc(1, sizeof(*frag));
+	CALLOC_ARRAY(frag, 1);
 	frag->patch =3D inflate_it(data, hunk_size, origlen);
 	frag->free_patch =3D 1;
 	if (!frag->patch)
@@ -4681,7 +4681,7 @@ static int apply_patch(struct apply_state *state,
 		struct patch *patch;
 		int nr;

-		patch =3D xcalloc(1, sizeof(*patch));
+		CALLOC_ARRAY(patch, 1);
 		patch->inaccurate_eof =3D !!(options & APPLY_OPT_INACCURATE_EOF);
 		patch->recount =3D  !!(options & APPLY_OPT_RECOUNT);
 		nr =3D parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
diff --git a/archive-tar.c b/archive-tar.c
index a971fdc0f6..05d2455870 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -371,7 +371,7 @@ static int tar_filter_config(const char *var, const ch=
ar *value, void *data)

 	ar =3D find_tar_filter(name, namelen);
 	if (!ar) {
-		ar =3D xcalloc(1, sizeof(*ar));
+		CALLOC_ARRAY(ar, 1);
 		ar->name =3D xmemdupz(name, namelen);
 		ar->write_archive =3D write_tar_filter_archive;
 		ar->flags =3D ARCHIVER_WANT_COMPRESSION_LEVELS |
diff --git a/attr.c b/attr.c
index 4ef85d668b..59a8d8af1a 100644
=2D-- a/attr.c
+++ b/attr.c
@@ -569,7 +569,7 @@ struct attr_check *attr_check_initl(const char *one, .=
..)
 	check =3D attr_check_alloc();
 	check->nr =3D cnt;
 	check->alloc =3D cnt;
-	check->items =3D xcalloc(cnt, sizeof(struct attr_check_item));
+	CALLOC_ARRAY(check->items, cnt);

 	check->items[0].attr =3D git_attr(one);
 	va_start(params, one);
@@ -670,7 +670,7 @@ static struct attr_stack *read_attr_from_array(const c=
har **list)
 	const char *line;
 	int lineno =3D 0;

-	res =3D xcalloc(1, sizeof(*res));
+	CALLOC_ARRAY(res, 1);
 	while ((line =3D *(list++)) !=3D NULL)
 		handle_attr_line(res, line, "[builtin]", ++lineno, 1);
 	return res;
@@ -707,7 +707,7 @@ static struct attr_stack *read_attr_from_file(const ch=
ar *path, int macro_ok)

 	if (!fp)
 		return NULL;
-	res =3D xcalloc(1, sizeof(*res));
+	CALLOC_ARRAY(res, 1);
 	while (fgets(buf, sizeof(buf), fp)) {
 		char *bufp =3D buf;
 		if (!lineno)
@@ -733,7 +733,7 @@ static struct attr_stack *read_attr_from_index(const s=
truct index_state *istate,
 	if (!buf)
 		return NULL;

-	res =3D xcalloc(1, sizeof(*res));
+	CALLOC_ARRAY(res, 1);
 	for (sp =3D buf; *sp; ) {
 		char *ep;
 		int more;
@@ -774,7 +774,7 @@ static struct attr_stack *read_attr(const struct index=
_state *istate,
 	}

 	if (!res)
-		res =3D xcalloc(1, sizeof(*res));
+		CALLOC_ARRAY(res, 1);
 	return res;
 }

@@ -874,7 +874,7 @@ static void bootstrap_attr_stack(const struct index_st=
ate *istate,
 	else
 		e =3D NULL;
 	if (!e)
-		e =3D xcalloc(1, sizeof(struct attr_stack));
+		CALLOC_ARRAY(e, 1);
 	push_stack(stack, e, NULL, 0);
 }

diff --git a/bisect.c b/bisect.c
index ae48d19acf..af2863d044 100644
=2D-- a/bisect.c
+++ b/bisect.c
@@ -423,7 +423,7 @@ void find_bisection(struct commit_list **commit_list, =
int *reaches,
 	show_list("bisection 2 sorted", 0, nr, list);

 	*all =3D nr;
-	weights =3D xcalloc(on_list, sizeof(*weights));
+	CALLOC_ARRAY(weights, on_list);

 	/* Do the real work of finding bisection commit. */
 	best =3D do_find_bisection(list, nr, weights, bisect_flags);
diff --git a/blame.c b/blame.c
index d6a3f5b70b..5018bb8fb2 100644
=2D-- a/blame.c
+++ b/blame.c
@@ -951,13 +951,13 @@ static int *fuzzy_find_matching_lines(struct blame_o=
rigin *parent,
 	max_search_distance_b =3D ((2 * max_search_distance_a + 1) * length_b
 				 - 1) / length_a;

-	result =3D xcalloc(length_b, sizeof(int));
-	second_best_result =3D xcalloc(length_b, sizeof(int));
-	certainties =3D xcalloc(length_b, sizeof(int));
+	CALLOC_ARRAY(result, length_b);
+	CALLOC_ARRAY(second_best_result, length_b);
+	CALLOC_ARRAY(certainties, length_b);

 	/* See get_similarity() for details of similarities. */
 	similarity_count =3D length_b * (max_search_distance_a * 2 + 1);
-	similarities =3D xcalloc(similarity_count, sizeof(int));
+	CALLOC_ARRAY(similarities, similarity_count);

 	for (i =3D 0; i < length_b; ++i) {
 		result[i] =3D -1;
@@ -995,7 +995,7 @@ static void fill_origin_fingerprints(struct blame_orig=
in *o)
 		return;
 	o->num_lines =3D find_line_starts(&line_starts, o->file.ptr,
 					o->file.size);
-	o->fingerprints =3D xcalloc(o->num_lines, sizeof(struct fingerprint));
+	CALLOC_ARRAY(o->fingerprints, o->num_lines);
 	get_line_fingerprints(o->fingerprints, o->file.ptr, line_starts,
 			      0, o->num_lines);
 	free(line_starts);
@@ -1853,8 +1853,7 @@ static void blame_chunk(struct blame_entry ***dstq, =
struct blame_entry ***srcq,
 	diffp =3D NULL;

 	if (ignore_diffs && same - tlno > 0) {
-		line_blames =3D xcalloc(same - tlno,
-				      sizeof(struct blame_line_tracker));
+		CALLOC_ARRAY(line_blames, same - tlno);
 		guess_line_blames(parent, target, tlno, offset, same,
 				  parent_len, line_blames);
 	}
@@ -2216,7 +2215,7 @@ static struct blame_list *setup_blame_list(struct bl=
ame_entry *unblamed,
 	for (e =3D unblamed, num_ents =3D 0; e; e =3D e->next)
 		num_ents++;
 	if (num_ents) {
-		blame_list =3D xcalloc(num_ents, sizeof(struct blame_list));
+		CALLOC_ARRAY(blame_list, num_ents);
 		for (e =3D unblamed, i =3D 0; e; e =3D e->next)
 			blame_list[i++].ent =3D e;
 	}
@@ -2428,7 +2427,7 @@ static void pass_blame(struct blame_scoreboard *sb, =
struct blame_origin *origin,
 	else if (num_sg < ARRAY_SIZE(sg_buf))
 		memset(sg_buf, 0, sizeof(sg_buf));
 	else
-		sg_origin =3D xcalloc(num_sg, sizeof(*sg_origin));
+		CALLOC_ARRAY(sg_origin, num_sg);

 	/*
 	 * The first pass looks for unrenamed path to optimize for
diff --git a/bloom.c b/bloom.c
index b176f28f53..52b87474c6 100644
=2D-- a/bloom.c
+++ b/bloom.c
@@ -277,7 +277,7 @@ struct bloom_filter *get_or_compute_bloom_filter(struc=
t repository *r,
 				*computed |=3D BLOOM_TRUNC_EMPTY;
 			filter->len =3D 1;
 		}
-		filter->data =3D xcalloc(filter->len, sizeof(unsigned char));
+		CALLOC_ARRAY(filter->data, filter->len);

 		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
 			struct bloom_key key;
diff --git a/builtin/clean.c b/builtin/clean.c
index 687ab473c2..995053b791 100644
=2D-- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -623,7 +623,7 @@ static int *list_and_choose(struct menu_opts *opts, st=
ruct menu_stuff *stuff)
 				nr +=3D chosen[i];
 		}

-		result =3D xcalloc(st_add(nr, 1), sizeof(int));
+		CALLOC_ARRAY(result, st_add(nr, 1));
 		for (i =3D 0; i < stuff->nr && j < nr; i++) {
 			if (chosen[i])
 				result[j++] =3D i;
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index dd4d09cece..3afa81cf9a 100644
=2D-- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3322,7 +3322,7 @@ static void option_rewrite_submodules(const char *ar=
g, struct string_list *list)
 		die(_("Expected format name:filename for submodule rewrite option"));
 	*f =3D '\0';
 	f++;
-	ms =3D xcalloc(1, sizeof(*ms));
+	CALLOC_ARRAY(ms, 1);

 	fp =3D fopen(f, "r");
 	if (!fp)
@@ -3519,9 +3519,9 @@ int cmd_fast_import(int argc, const char **argv, con=
st char *prefix)

 	alloc_objects(object_entry_alloc);
 	strbuf_init(&command_buf, 0);
-	atom_table =3D xcalloc(atom_table_sz, sizeof(struct atom_str*));
-	branch_table =3D xcalloc(branch_table_sz, sizeof(struct branch*));
-	avail_tree_table =3D xcalloc(avail_tree_table_sz, sizeof(struct avail_tr=
ee_content*));
+	CALLOC_ARRAY(atom_table, atom_table_sz);
+	CALLOC_ARRAY(branch_table, branch_table_sz);
+	CALLOC_ARRAY(avail_tree_table, avail_tree_table_sz);
 	marks =3D mem_pool_calloc(&fi_mem_pool, 1, sizeof(struct mark_set));

 	hashmap_init(&object_table, object_entry_hashcmp, NULL, 0);
diff --git a/builtin/grep.c b/builtin/grep.c
index 4e91a253ac..ccd8d08f3d 100644
=2D-- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -211,7 +211,7 @@ static void start_threads(struct grep_opt *opt)
 		strbuf_init(&todo[i].out, 0);
 	}

-	threads =3D xcalloc(num_threads, sizeof(*threads));
+	CALLOC_ARRAY(threads, num_threads);
 	for (i =3D 0; i < num_threads; i++) {
 		int err;
 		struct grep_opt *o =3D grep_opt_dup(opt);
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index bad5748807..21899687e2 100644
=2D-- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -185,7 +185,7 @@ static void init_thread(void)
 	if (show_stat)
 		pthread_mutex_init(&deepest_delta_mutex, NULL);
 	pthread_key_create(&key, NULL);
-	thread_data =3D xcalloc(nr_threads, sizeof(*thread_data));
+	CALLOC_ARRAY(thread_data, nr_threads);
 	for (i =3D 0; i < nr_threads; i++) {
 		thread_data[i].pack_fd =3D open(curr_pack, O_RDONLY);
 		if (thread_data[i].pack_fd =3D=3D -1)
@@ -1674,7 +1674,7 @@ static void show_pack_info(int stat_only)
 	unsigned long *chain_histogram =3D NULL;

 	if (deepest_delta)
-		chain_histogram =3D xcalloc(deepest_delta, sizeof(unsigned long));
+		CALLOC_ARRAY(chain_histogram, deepest_delta);

 	for (i =3D 0; i < nr_objects; i++) {
 		struct object_entry *obj =3D &objects[i];
@@ -1912,10 +1912,10 @@ int cmd_index_pack(int argc, const char **argv, co=
nst char *prefix)

 	curr_pack =3D open_pack_file(pack_name);
 	parse_pack_header();
-	objects =3D xcalloc(st_add(nr_objects, 1), sizeof(struct object_entry));
+	CALLOC_ARRAY(objects, st_add(nr_objects, 1));
 	if (show_stat)
-		obj_stat =3D xcalloc(st_add(nr_objects, 1), sizeof(struct object_stat))=
;
-	ofs_deltas =3D xcalloc(nr_objects, sizeof(struct ofs_delta_entry));
+		CALLOC_ARRAY(obj_stat, st_add(nr_objects, 1));
+	CALLOC_ARRAY(ofs_deltas, nr_objects);
 	parse_pack_objects(pack_hash);
 	if (report_end_of_input)
 		write_in_full(2, "\0", 1);
diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index ef604752a0..abfa984737 100644
=2D-- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -88,7 +88,7 @@ int cmd_ls_remote(int argc, const char **argv, const cha=
r *prefix)

 	if (argc > 1) {
 		int i;
-		pattern =3D xcalloc(argc, sizeof(const char *));
+		CALLOC_ARRAY(pattern, argc);
 		for (i =3D 1; i < argc; i++) {
 			pattern[i - 1] =3D xstrfmt("*/%s", argv[i]);
 		}
diff --git a/builtin/merge.c b/builtin/merge.c
index eb00b273e6..388619536a 100644
=2D-- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -210,7 +210,7 @@ static struct strategy *get_strategy(const char *name)
 		exit(1);
 	}

-	ret =3D xcalloc(1, sizeof(struct strategy));
+	CALLOC_ARRAY(ret, 1);
 	ret->name =3D xstrdup(name);
 	ret->attr =3D NO_TRIVIAL;
 	return ret;
diff --git a/builtin/notes.c b/builtin/notes.c
index 08b8914d29..74bba39ca8 100644
=2D-- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -730,7 +730,7 @@ static int merge_commit(struct notes_merge_options *o)
 	else
 		oidclr(&parent_oid);

-	t =3D xcalloc(1, sizeof(struct notes_tree));
+	CALLOC_ARRAY(t, 1);
 	init_notes(t, "NOTES_MERGE_PARTIAL", combine_notes_overwrite, 0);

 	o->local_ref =3D local_ref_to_free =3D
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 6d62aaf59a..4bb602688c 100644
=2D-- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1635,7 +1635,7 @@ static void add_preferred_base(struct object_id *oid=
)
 		}
 	}

-	it =3D xcalloc(1, sizeof(*it));
+	CALLOC_ARRAY(it, 1);
 	it->next =3D pbase_tree;
 	pbase_tree =3D it;

@@ -2096,7 +2096,7 @@ static void get_object_details(void)
 		progress_state =3D start_progress(_("Counting objects"),
 						to_pack.nr_objects);

-	sorted_by_offset =3D xcalloc(to_pack.nr_objects, sizeof(struct object_en=
try *));
+	CALLOC_ARRAY(sorted_by_offset, to_pack.nr_objects);
 	for (i =3D 0; i < to_pack.nr_objects; i++)
 		sorted_by_offset[i] =3D to_pack.objects + i;
 	QSORT(sorted_by_offset, to_pack.nr_objects, pack_offset_sort);
@@ -2428,7 +2428,7 @@ static void find_deltas(struct object_entry **list, =
unsigned *list_size,
 	struct unpacked *array;
 	unsigned long mem_usage =3D 0;

-	array =3D xcalloc(window, sizeof(struct unpacked));
+	CALLOC_ARRAY(array, window);

 	for (;;) {
 		struct object_entry *entry;
@@ -2665,7 +2665,7 @@ static void ll_find_deltas(struct object_entry **lis=
t, unsigned list_size,
 	if (progress > pack_to_stdout)
 		fprintf_ln(stderr, _("Delta compression using up to %d threads"),
 			   delta_search_threads);
-	p =3D xcalloc(delta_search_threads, sizeof(*p));
+	CALLOC_ARRAY(p, delta_search_threads);

 	/* Partition the work amongst work threads. */
 	for (i =3D 0; i < delta_search_threads; i++) {
diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 6e115a811a..7102996c75 100644
=2D-- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -373,7 +373,7 @@ static void sort_pack_list(struct pack_list **pl)
 		return;

 	/* prepare an array of packed_list for easier sorting */
-	ary =3D xcalloc(n, sizeof(struct pack_list *));
+	CALLOC_ARRAY(ary, n);
 	for (n =3D 0, p =3D *pl; p; p =3D p->next)
 		ary[n++] =3D p;

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index d26040c477..51c8c40fab 100644
=2D-- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -358,7 +358,7 @@ static void proc_receive_ref_append(const char *prefix=
)
 	char *p;
 	int len;

-	ref_pattern =3D xcalloc(1, sizeof(struct proc_receive_ref));
+	CALLOC_ARRAY(ref_pattern, 1);
 	p =3D strchr(prefix, ':');
 	if (p) {
 		while (prefix < p) {
@@ -1024,7 +1024,7 @@ static int read_proc_receive_report(struct packet_re=
ader *reader,
 			}
 			if (new_report) {
 				if (!hint->report) {
-					hint->report =3D xcalloc(1, sizeof(struct ref_push_report));
+					CALLOC_ARRAY(hint->report, 1);
 					report =3D hint->report;
 				} else {
 					report =3D hint->report;
diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index dd4a75e030..a4ba2ebac6 100644
=2D-- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -46,7 +46,7 @@ static struct obj_buffer *lookup_object_buffer(struct ob=
ject *base)
 static void add_object_buffer(struct object *object, char *buffer, unsign=
ed long size)
 {
 	struct obj_buffer *obj;
-	obj =3D xcalloc(1, sizeof(struct obj_buffer));
+	CALLOC_ARRAY(obj, 1);
 	obj->buffer =3D buffer;
 	obj->size =3D size;
 	if (add_decoration(&obj_decorate, object, obj))
@@ -500,7 +500,7 @@ static void unpack_all(void)

 	if (!quiet)
 		progress =3D start_progress(_("Unpacking objects"), nr_objects);
-	obj_list =3D xcalloc(nr_objects, sizeof(*obj_list));
+	CALLOC_ARRAY(obj_list, nr_objects);
 	for (i =3D 0; i < nr_objects; i++) {
 		unpack_one(i);
 		display_progress(progress, i + 1);
diff --git a/bulk-checkin.c b/bulk-checkin.c
index 583aacb9e3..6f3c97cd34 100644
=2D-- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -211,7 +211,7 @@ static int deflate_to_pack(struct bulk_checkin_state *=
state,

 	/* Note: idx is non-NULL when we are writing */
 	if ((flags & HASH_WRITE_OBJECT) !=3D 0)
-		idx =3D xcalloc(1, sizeof(*idx));
+		CALLOC_ARRAY(idx, 1);

 	already_hashed_to =3D 0;

diff --git a/cache-tree.c b/cache-tree.c
index 2fb483d3c0..add1f07713 100644
=2D-- a/cache-tree.c
+++ b/cache-tree.c
@@ -564,7 +564,7 @@ static struct cache_tree *read_one(const char **buffer=
, unsigned long *size_p)
 	 * hence +2.
 	 */
 	it->subtree_alloc =3D subtree_nr + 2;
-	it->down =3D xcalloc(it->subtree_alloc, sizeof(struct cache_tree_sub *))=
;
+	CALLOC_ARRAY(it->down, it->subtree_alloc);
 	for (i =3D 0; i < subtree_nr; i++) {
 		/* read each subtree */
 		struct cache_tree *sub;
diff --git a/combine-diff.c b/combine-diff.c
index 9228aebc16..06635f91bc 100644
=2D-- a/combine-diff.c
+++ b/combine-diff.c
@@ -214,11 +214,11 @@ static struct lline *coalesce_lines(struct lline *ba=
se, int *lenbase,
 	 *   - Else if we have NEW, insert newend lline into base and
 	 *   consume newend
 	 */
-	lcs =3D xcalloc(st_add(origbaselen, 1), sizeof(int*));
-	directions =3D xcalloc(st_add(origbaselen, 1), sizeof(enum coalesce_dire=
ction*));
+	CALLOC_ARRAY(lcs, st_add(origbaselen, 1));
+	CALLOC_ARRAY(directions, st_add(origbaselen, 1));
 	for (i =3D 0; i < origbaselen + 1; i++) {
-		lcs[i] =3D xcalloc(st_add(lennew, 1), sizeof(int));
-		directions[i] =3D xcalloc(st_add(lennew, 1), sizeof(enum coalesce_direc=
tion));
+		CALLOC_ARRAY(lcs[i], st_add(lennew, 1));
+		CALLOC_ARRAY(directions[i], st_add(lennew, 1));
 		directions[i][0] =3D BASE;
 	}
 	for (j =3D 1; j < lennew + 1; j++)
@@ -398,8 +398,8 @@ static void consume_hunk(void *state_,
 		state->lost_bucket =3D &state->sline[state->nb-1];
 	}
 	if (!state->sline[state->nb-1].p_lno)
-		state->sline[state->nb-1].p_lno =3D
-			xcalloc(state->num_parent, sizeof(unsigned long));
+		CALLOC_ARRAY(state->sline[state->nb - 1].p_lno,
+			     state->num_parent);
 	state->sline[state->nb-1].p_lno[state->n] =3D state->ob;
 }

@@ -1159,7 +1159,7 @@ static void show_patch_diff(struct combine_diff_path=
 *elem, int num_parent,
 	if (result_size && result[result_size-1] !=3D '\n')
 		cnt++; /* incomplete line */

-	sline =3D xcalloc(st_add(cnt, 2), sizeof(*sline));
+	CALLOC_ARRAY(sline, st_add(cnt, 2));
 	sline[0].bol =3D result;
 	for (lno =3D 0, cp =3D result; cp < result + result_size; cp++) {
 		if (*cp =3D=3D '\n') {
@@ -1178,7 +1178,7 @@ static void show_patch_diff(struct combine_diff_path=
 *elem, int num_parent,
 	/* Even p_lno[cnt+1] is valid -- that is for the end line number
 	 * for deletion hunk at the end.
 	 */
-	sline[0].p_lno =3D xcalloc(st_mult(st_add(cnt, 2), num_parent), sizeof(u=
nsigned long));
+	CALLOC_ARRAY(sline[0].p_lno, st_mult(st_add(cnt, 2), num_parent));
 	for (lno =3D 0; lno <=3D cnt; lno++)
 		sline[lno+1].p_lno =3D sline[lno].p_lno + num_parent;

@@ -1319,7 +1319,7 @@ static struct diff_filepair *combined_pair(struct co=
mbine_diff_path *p,
 	struct diff_filespec *pool;

 	pair =3D xmalloc(sizeof(*pair));
-	pool =3D xcalloc(st_add(num_parent, 1), sizeof(struct diff_filespec));
+	CALLOC_ARRAY(pool, st_add(num_parent, 1));
 	pair->one =3D pool + 1;
 	pair->two =3D pool;

@@ -1348,7 +1348,7 @@ static void handle_combined_callback(struct diff_opt=
ions *opt,
 	struct diff_queue_struct q;
 	int i;

-	q.queue =3D xcalloc(num_paths, sizeof(struct diff_filepair *));
+	CALLOC_ARRAY(q.queue, num_paths);
 	q.alloc =3D num_paths;
 	q.nr =3D num_paths;
 	for (i =3D 0, p =3D paths; p; p =3D p->next)
diff --git a/commit-graph.c b/commit-graph.c
index ca025ce8eb..e21eeea42b 100644
=2D-- a/commit-graph.c
+++ b/commit-graph.c
@@ -516,7 +516,7 @@ static struct commit_graph *load_commit_graph_chain(st=
ruct repository *r,
 		return NULL;

 	count =3D st.st_size / (the_hash_algo->hexsz + 1);
-	oids =3D xcalloc(count, sizeof(struct object_id));
+	CALLOC_ARRAY(oids, count);

 	prepare_alt_odb(r);

@@ -2238,7 +2238,7 @@ int write_commit_graph(struct object_directory *odb,
 	if (!commit_graph_compatible(the_repository))
 		return 0;

-	ctx =3D xcalloc(1, sizeof(struct write_commit_graph_context));
+	CALLOC_ARRAY(ctx, 1);
 	ctx->r =3D the_repository;
 	ctx->odb =3D odb;
 	ctx->append =3D flags & COMMIT_GRAPH_WRITE_APPEND ? 1 : 0;
diff --git a/commit-reach.c b/commit-reach.c
index 2ea84d3dc0..c226ee3da4 100644
=2D-- a/commit-reach.c
+++ b/commit-reach.c
@@ -183,7 +183,7 @@ static int remove_redundant_no_gen(struct repository *=
r,
 	int *filled_index;
 	int i, j, filled;

-	work =3D xcalloc(cnt, sizeof(*work));
+	CALLOC_ARRAY(work, cnt);
 	redundant =3D xcalloc(cnt, 1);
 	ALLOC_ARRAY(filled_index, cnt - 1);

@@ -399,7 +399,7 @@ static struct commit_list *get_merge_bases_many_0(stru=
ct repository *r,

 	/* There are more than one */
 	cnt =3D commit_list_count(result);
-	rslt =3D xcalloc(cnt, sizeof(*rslt));
+	CALLOC_ARRAY(rslt, cnt);
 	for (list =3D result, i =3D 0; list; list =3D list->next)
 		rslt[i++] =3D list->item;
 	free_commit_list(result);
@@ -541,7 +541,7 @@ struct commit_list *reduce_heads(struct commit_list *h=
eads)
 		p->item->object.flags |=3D STALE;
 		num_head++;
 	}
-	array =3D xcalloc(num_head, sizeof(*array));
+	CALLOC_ARRAY(array, num_head);
 	for (p =3D heads, i =3D 0; p; p =3D p->next) {
 		if (p->item->object.flags & STALE) {
 			array[i++] =3D p->item;
diff --git a/commit.c b/commit.c
index 6ccd774841..42f8117b51 100644
=2D-- a/commit.c
+++ b/commit.c
@@ -1171,7 +1171,7 @@ static void handle_signed_tag(struct commit *parent,=
 struct commit_extra_header
 	 * if (verify_signed_buffer(buf, len, buf + len, size - len, ...))
 	 *	warn("warning: signed tag unverified.");
 	 */
-	mergetag =3D xcalloc(1, sizeof(*mergetag));
+	CALLOC_ARRAY(mergetag, 1);
 	mergetag->key =3D xstrdup("mergetag");
 	mergetag->value =3D buf;
 	mergetag->len =3D size;
@@ -1336,7 +1336,7 @@ static struct commit_extra_header *read_commit_extra=
_header_lines(
 			 excluded_header_field(line, eof - line, exclude))
 			continue;

-		it =3D xcalloc(1, sizeof(*it));
+		CALLOC_ARRAY(it, 1);
 		it->key =3D xmemdupz(line, eof-line);
 		*tail =3D it;
 		tail =3D &it->next;
diff --git a/config.c b/config.c
index f90b633dba..6428393a41 100644
=2D-- a/config.c
+++ b/config.c
@@ -2269,7 +2269,7 @@ static void repo_read_config(struct repository *repo=
)
 	opts.git_dir =3D repo->gitdir;

 	if (!repo->config)
-		repo->config =3D xcalloc(1, sizeof(struct config_set));
+		CALLOC_ARRAY(repo->config, 1);
 	else
 		git_configset_clear(repo->config);

diff --git a/contrib/coccinelle/array.cocci b/contrib/coccinelle/array.coc=
ci
index 46b8d2ee11..9a17d2a121 100644
=2D-- a/contrib/coccinelle/array.cocci
+++ b/contrib/coccinelle/array.cocci
@@ -88,3 +88,11 @@ expression n;
 @@
 - ptr =3D xmalloc((n) * sizeof(T));
 + ALLOC_ARRAY(ptr, n);
+
+@@
+type T;
+T *ptr;
+expression n;
+@@
+- ptr =3D xcalloc(n, \( sizeof(*ptr) \| sizeof(T) \) )
++ CALLOC_ARRAY(ptr, n)
diff --git a/convert.c b/convert.c
index ee360c2f07..9ecc1c699c 100644
=2D-- a/convert.c
+++ b/convert.c
@@ -1028,7 +1028,7 @@ static int read_convert_config(const char *var, cons=
t char *value, void *cb)
 		if (!strncmp(drv->name, name, namelen) && !drv->name[namelen])
 			break;
 	if (!drv) {
-		drv =3D xcalloc(1, sizeof(struct convert_driver));
+		CALLOC_ARRAY(drv, 1);
 		drv->name =3D xmemdupz(name, namelen);
 		*user_convert_tail =3D drv;
 		user_convert_tail =3D &(drv->next);
diff --git a/daemon.c b/daemon.c
index 2ab7ea82eb..343531980d 100644
=2D-- a/daemon.c
+++ b/daemon.c
@@ -840,7 +840,7 @@ static void add_child(struct child_process *cld, struc=
t sockaddr *addr, socklen_
 {
 	struct child *newborn, **cradle;

-	newborn =3D xcalloc(1, sizeof(*newborn));
+	CALLOC_ARRAY(newborn, 1);
 	live_children++;
 	memcpy(&newborn->cld, cld, sizeof(*cld));
 	memcpy(&newborn->address, addr, addrlen);
@@ -1148,7 +1148,7 @@ static int service_loop(struct socketlist *socklist)
 	struct pollfd *pfd;
 	int i;

-	pfd =3D xcalloc(socklist->nr, sizeof(struct pollfd));
+	CALLOC_ARRAY(pfd, socklist->nr);

 	for (i =3D 0; i < socklist->nr; i++) {
 		pfd[i].fd =3D socklist->list[i];
diff --git a/decorate.c b/decorate.c
index a605b1b5f4..2036d15967 100644
=2D-- a/decorate.c
+++ b/decorate.c
@@ -39,7 +39,7 @@ static void grow_decoration(struct decoration *n)
 	struct decoration_entry *old_entries =3D n->entries;

 	n->size =3D (old_size + 1000) * 3 / 2;
-	n->entries =3D xcalloc(n->size, sizeof(struct decoration_entry));
+	CALLOC_ARRAY(n->entries, n->size);
 	n->nr =3D 0;

 	for (i =3D 0; i < old_size; i++) {
diff --git a/diff.c b/diff.c
index 6956f5e335..4acccd9d7e 100644
=2D-- a/diff.c
+++ b/diff.c
@@ -2233,14 +2233,12 @@ static void init_diff_words_data(struct emit_callb=
ack *ecbdata,
 	struct diff_options *o =3D xmalloc(sizeof(struct diff_options));
 	memcpy(o, orig_opts, sizeof(struct diff_options));

-	ecbdata->diff_words =3D
-		xcalloc(1, sizeof(struct diff_words_data));
+	CALLOC_ARRAY(ecbdata->diff_words, 1);
 	ecbdata->diff_words->type =3D o->word_diff;
 	ecbdata->diff_words->opt =3D o;

 	if (orig_opts->emitted_symbols)
-		o->emitted_symbols =3D
-			xcalloc(1, sizeof(struct emitted_diff_symbols));
+		CALLOC_ARRAY(o->emitted_symbols, 1);

 	if (!o->word_regex)
 		o->word_regex =3D userdiff_word_regex(one, o->repo->index);
@@ -2509,7 +2507,7 @@ static struct diffstat_file *diffstat_add(struct dif=
fstat_t *diffstat,
 					  const char *name_b)
 {
 	struct diffstat_file *x;
-	x =3D xcalloc(1, sizeof(*x));
+	CALLOC_ARRAY(x, 1);
 	ALLOC_GROW(diffstat->files, diffstat->nr + 1, diffstat->alloc);
 	diffstat->files[diffstat->nr++] =3D x;
 	if (name_b) {
@@ -4918,7 +4916,7 @@ static int diff_opt_find_object(const struct option =
*option,
 		return error(_("unable to resolve '%s'"), arg);

 	if (!opt->objfind)
-		opt->objfind =3D xcalloc(1, sizeof(*opt->objfind));
+		CALLOC_ARRAY(opt->objfind, 1);

 	opt->pickaxe_opts |=3D DIFF_PICKAXE_KIND_OBJFIND;
 	opt->flags.recursive =3D 1;
diff --git a/diffcore-rename.c b/diffcore-rename.c
index 41558185ae..9c1478c078 100644
=2D-- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -787,8 +787,7 @@ void diffcore_rename(struct diff_options *options)
 				(uint64_t)num_destinations * (uint64_t)num_sources);
 	}

-	mx =3D xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_destinations),
-		     sizeof(*mx));
+	CALLOC_ARRAY(mx, st_mult(NUM_CANDIDATE_PER_DST, num_destinations));
 	for (dst_cnt =3D i =3D 0; i < rename_dst_nr; i++) {
 		struct diff_filespec *two =3D rename_dst[i].p->two;
 		struct diff_score *m;
diff --git a/dir.c b/dir.c
index fd8aa7c40f..19c2fa239b 100644
=2D-- a/dir.c
+++ b/dir.c
@@ -1488,7 +1488,7 @@ static void prep_exclude(struct dir_struct *dir,
 		const char *cp;
 		struct oid_stat oid_stat;

-		stk =3D xcalloc(1, sizeof(*stk));
+		CALLOC_ARRAY(stk, 1);
 		if (current < 0) {
 			cp =3D base;
 			current =3D 0;
@@ -3162,7 +3162,7 @@ void write_untracked_extension(struct strbuf *out, s=
truct untracked_cache *untra
 	int varint_len;
 	const unsigned hashsz =3D the_hash_algo->rawsz;

-	ouc =3D xcalloc(1, sizeof(*ouc));
+	CALLOC_ARRAY(ouc, 1);
 	stat_data_to_disk(&ouc->info_exclude_stat, &untracked->ss_info_exclude.s=
tat);
 	stat_data_to_disk(&ouc->excludes_file_stat, &untracked->ss_excludes_file=
.stat);
 	ouc->dir_flags =3D htonl(untracked->dir_flags);
@@ -3373,7 +3373,7 @@ struct untracked_cache *read_untracked_extension(con=
st void *data, unsigned long
 	if (next + exclude_per_dir_offset + 1 > end)
 		return NULL;

-	uc =3D xcalloc(1, sizeof(*uc));
+	CALLOC_ARRAY(uc, 1);
 	strbuf_init(&uc->ident, ident_len);
 	strbuf_add(&uc->ident, ident, ident_len);
 	load_oid_stat(&uc->ss_info_exclude,
diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 0d31cdc866..38a47c44db 100644
=2D-- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -25,7 +25,7 @@
 struct bitmap *bitmap_word_alloc(size_t word_alloc)
 {
 	struct bitmap *bitmap =3D xmalloc(sizeof(struct bitmap));
-	bitmap->words =3D xcalloc(word_alloc, sizeof(eword_t));
+	CALLOC_ARRAY(bitmap->words, word_alloc);
 	bitmap->word_alloc =3D word_alloc;
 	return bitmap;
 }
diff --git a/fetch-pack.c b/fetch-pack.c
index 6a61a46428..fb04a76ca2 100644
=2D-- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1916,7 +1916,7 @@ static void update_shallow(struct fetch_pack_args *a=
rgs,
 	 * remote is also shallow, check what ref is safe to update
 	 * without updating .git/shallow
 	 */
-	status =3D xcalloc(nr_sought, sizeof(*status));
+	CALLOC_ARRAY(status, nr_sought);
 	assign_shallow_commits_to_refs(si, NULL, status);
 	if (si->nr_ours || si->nr_theirs) {
 		for (i =3D 0; i < nr_sought; i++)
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index 1e51492a05..0f66818e0f 100644
=2D-- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -130,7 +130,7 @@ static int handle_line(char *line, struct merge_parent=
s *merge_parents)
 	if (!find_merge_parent(merge_parents, &oid, NULL))
 		return 0; /* subsumed by other parents */

-	origin_data =3D xcalloc(1, sizeof(struct origin_data));
+	CALLOC_ARRAY(origin_data, 1);
 	oidcpy(&origin_data->oid, &oid);

 	if (line[len - 1] =3D=3D '\n')
diff --git a/grep.c b/grep.c
index aabfaaa4c3..223035318b 100644
=2D-- a/grep.c
+++ b/grep.c
@@ -621,7 +621,7 @@ static struct grep_expr *compile_pattern_atom(struct g=
rep_pat **list)
 	case GREP_PATTERN: /* atom */
 	case GREP_PATTERN_HEAD:
 	case GREP_PATTERN_BODY:
-		x =3D xcalloc(1, sizeof (struct grep_expr));
+		CALLOC_ARRAY(x, 1);
 		x->node =3D GREP_NODE_ATOM;
 		x->u.atom =3D p;
 		*list =3D p->next;
@@ -651,7 +651,7 @@ static struct grep_expr *compile_pattern_not(struct gr=
ep_pat **list)
 		if (!p->next)
 			die("--not not followed by pattern expression");
 		*list =3D p->next;
-		x =3D xcalloc(1, sizeof (struct grep_expr));
+		CALLOC_ARRAY(x, 1);
 		x->node =3D GREP_NODE_NOT;
 		x->u.unary =3D compile_pattern_not(list);
 		if (!x->u.unary)
@@ -676,7 +676,7 @@ static struct grep_expr *compile_pattern_and(struct gr=
ep_pat **list)
 		y =3D compile_pattern_and(list);
 		if (!y)
 			die("--and not followed by pattern expression");
-		z =3D xcalloc(1, sizeof (struct grep_expr));
+		CALLOC_ARRAY(z, 1);
 		z->node =3D GREP_NODE_AND;
 		z->u.binary.left =3D x;
 		z->u.binary.right =3D y;
@@ -696,7 +696,7 @@ static struct grep_expr *compile_pattern_or(struct gre=
p_pat **list)
 		y =3D compile_pattern_or(list);
 		if (!y)
 			die("not a pattern expression %s", p->pattern);
-		z =3D xcalloc(1, sizeof (struct grep_expr));
+		CALLOC_ARRAY(z, 1);
 		z->node =3D GREP_NODE_OR;
 		z->u.binary.left =3D x;
 		z->u.binary.right =3D y;
diff --git a/hashmap.c b/hashmap.c
index 5009471800..134d2eec80 100644
=2D-- a/hashmap.c
+++ b/hashmap.c
@@ -76,7 +76,7 @@ unsigned int memihash_cont(unsigned int hash_seed, const=
 void *buf, size_t len)
 static void alloc_table(struct hashmap *map, unsigned int size)
 {
 	map->tablesize =3D size;
-	map->table =3D xcalloc(size, sizeof(struct hashmap_entry *));
+	CALLOC_ARRAY(map->table, size);

 	/* calculate resize thresholds for new size */
 	map->grow_at =3D (unsigned int) ((uint64_t) size * HASHMAP_LOAD_FACTOR /=
 100);
diff --git a/http-backend.c b/http-backend.c
index a03b4bae22..b329bf63f0 100644
=2D-- a/http-backend.c
+++ b/http-backend.c
@@ -39,7 +39,7 @@ static struct string_list *get_parameters(void)
 	if (!query_params) {
 		const char *query =3D getenv("QUERY_STRING");

-		query_params =3D xcalloc(1, sizeof(*query_params));
+		CALLOC_ARRAY(query_params, 1);
 		while (query && *query) {
 			char *name =3D url_decode_parameter_name(&query);
 			char *value =3D url_decode_parameter_value(&query);
diff --git a/http-push.c b/http-push.c
index 6a4a43e07f..b60d5fcc85 100644
=2D-- a/http-push.c
+++ b/http-push.c
@@ -896,7 +896,7 @@ static struct remote_lock *lock_remote(const char *pat=
h, long timeout)
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, dav_headers);
 	curl_easy_setopt(slot->curl, CURLOPT_FILE, &in_buffer);

-	lock =3D xcalloc(1, sizeof(*lock));
+	CALLOC_ARRAY(lock, 1);
 	lock->timeout =3D -1;

 	if (start_active_slot(slot)) {
@@ -1713,7 +1713,7 @@ int cmd_main(int argc, const char **argv)
 	int new_refs;
 	struct ref *ref, *local_refs;

-	repo =3D xcalloc(1, sizeof(*repo));
+	CALLOC_ARRAY(repo, 1);

 	argv++;
 	for (i =3D 1; i < argc; i++, argv++) {
diff --git a/http.c b/http.c
index f8ea28bb2e..0e31fc21bc 100644
=2D-- a/http.c
+++ b/http.c
@@ -2324,7 +2324,7 @@ struct http_pack_request *new_direct_http_pack_reque=
st(
 	off_t prev_posn =3D 0;
 	struct http_pack_request *preq;

-	preq =3D xcalloc(1, sizeof(*preq));
+	CALLOC_ARRAY(preq, 1);
 	strbuf_init(&preq->tmpfile, 0);

 	preq->url =3D url;
@@ -2419,7 +2419,7 @@ struct http_object_request *new_http_object_request(=
const char *base_url,
 	off_t prev_posn =3D 0;
 	struct http_object_request *freq;

-	freq =3D xcalloc(1, sizeof(*freq));
+	CALLOC_ARRAY(freq, 1);
 	strbuf_init(&freq->tmpfile, 0);
 	oidcpy(&freq->oid, oid);
 	freq->localfile =3D -1;
diff --git a/imap-send.c b/imap-send.c
index d0b94f911e..bb085d66d1 100644
=2D-- a/imap-send.c
+++ b/imap-send.c
@@ -963,9 +963,9 @@ static struct imap_store *imap_open_store(struct imap_=
server_conf *srvc, const c
 	char *arg, *rsp;
 	int s =3D -1, preauth;

-	ctx =3D xcalloc(1, sizeof(*ctx));
+	CALLOC_ARRAY(ctx, 1);

-	ctx->imap =3D imap =3D xcalloc(1, sizeof(*imap));
+	ctx->imap =3D CALLOC_ARRAY(imap, 1);
 	imap->buf.sock.fd[0] =3D imap->buf.sock.fd[1] =3D -1;
 	imap->in_progress_append =3D &imap->in_progress;

diff --git a/line-log.c b/line-log.c
index 75c8b1acff..51d93310a4 100644
=2D-- a/line-log.c
+++ b/line-log.c
@@ -296,7 +296,7 @@ static void line_log_data_insert(struct line_log_data =
**list,
 		return;
 	}

-	p =3D xcalloc(1, sizeof(struct line_log_data));
+	CALLOC_ARRAY(p, 1);
 	p->path =3D path;
 	range_set_append(&p->ranges, begin, end);
 	if (ip) {
diff --git a/line-range.c b/line-range.c
index 9b50583dc0..955a8a9535 100644
=2D-- a/line-range.c
+++ b/line-range.c
@@ -202,7 +202,7 @@ static const char *parse_range_funcname(
 	drv =3D userdiff_find_by_path(istate, path);
 	if (drv && drv->funcname.pattern) {
 		const struct userdiff_funcname *pe =3D &drv->funcname;
-		xecfg =3D xcalloc(1, sizeof(*xecfg));
+		CALLOC_ARRAY(xecfg, 1);
 		xdiff_set_find_func(xecfg, pe->pattern, pe->cflags);
 	}

diff --git a/list-objects-filter.c b/list-objects-filter.c
index 4ec0041cfb..39e2f15333 100644
=2D-- a/list-objects-filter.c
+++ b/list-objects-filter.c
@@ -186,7 +186,7 @@ static enum list_objects_filter_result filter_trees_de=
pth(
 		seen_info =3D oidmap_get(
 			&filter_data->seen_at_depth, &obj->oid);
 		if (!seen_info) {
-			seen_info =3D xcalloc(1, sizeof(*seen_info));
+			CALLOC_ARRAY(seen_info, 1);
 			oidcpy(&seen_info->base.oid, &obj->oid);
 			seen_info->depth =3D filter_data->current_depth;
 			oidmap_put(&filter_data->seen_at_depth, seen_info);
@@ -626,7 +626,7 @@ static void filter_combine__init(
 	size_t sub;

 	d->nr =3D filter_options->sub_nr;
-	d->sub =3D xcalloc(d->nr, sizeof(*d->sub));
+	CALLOC_ARRAY(d->sub, d->nr);
 	for (sub =3D 0; sub < d->nr; sub++)
 		d->sub[sub].filter =3D list_objects_filter__init(
 			filter->omits ? &d->sub[sub].omits : NULL,
@@ -674,7 +674,7 @@ struct filter *list_objects_filter__init(
 	if (!init_fn)
 		return NULL;

-	filter =3D xcalloc(1, sizeof(*filter));
+	CALLOC_ARRAY(filter, 1);
 	filter->omits =3D omitted;
 	init_fn(filter_options, filter);
 	return filter;
diff --git a/ll-merge.c b/ll-merge.c
index 1ec0b959e0..9a8a2c365c 100644
=2D-- a/ll-merge.c
+++ b/ll-merge.c
@@ -268,7 +268,7 @@ static int read_merge_config(const char *var, const ch=
ar *value, void *cb)
 		if (!strncmp(fn->name, name, namelen) && !fn->name[namelen])
 			break;
 	if (!fn) {
-		fn =3D xcalloc(1, sizeof(struct ll_merge_driver));
+		CALLOC_ARRAY(fn, 1);
 		fn->name =3D xmemdupz(name, namelen);
 		fn->fn =3D ll_ext_merge;
 		*ll_user_merge_tail =3D fn;
diff --git a/mailmap.c b/mailmap.c
index 9bb9cf8b30..183a2f65ee 100644
=2D-- a/mailmap.c
+++ b/mailmap.c
@@ -83,7 +83,7 @@ static void add_mapping(struct string_list *map,
 	if (item->util) {
 		me =3D (struct mailmap_entry *)item->util;
 	} else {
-		me =3D xcalloc(1, sizeof(struct mailmap_entry));
+		CALLOC_ARRAY(me, 1);
 		me->namemap.strdup_strings =3D 1;
 		me->namemap.cmp =3D namemap_cmp;
 		item->util =3D me;
diff --git a/merge-ort.c b/merge-ort.c
index 603d30c521..92dea35e57 100644
=2D-- a/merge-ort.c
+++ b/merge-ort.c
@@ -1576,8 +1576,7 @@ static void compute_collisions(struct strmap *collis=
ions,
 		if (collision_info) {
 			free(new_path);
 		} else {
-			collision_info =3D xcalloc(1,
-						 sizeof(struct collision_info));
+			CALLOC_ARRAY(collision_info, 1);
 			string_list_init(&collision_info->source_files, 0);
 			strmap_put(collisions, new_path, collision_info);
 		}
@@ -1718,7 +1717,7 @@ static void apply_directory_rename_modifications(str=
uct merge_options *opt,
 		struct conflict_info *dir_ci;
 		char *cur_dir =3D dirs_to_insert.items[i].string;

-		dir_ci =3D xcalloc(1, sizeof(*dir_ci));
+		CALLOC_ARRAY(dir_ci, 1);

 		dir_ci->merged.directory_name =3D parent_name;
 		len =3D strlen(parent_name);
@@ -2703,7 +2702,7 @@ static void process_entry(struct merge_options *opt,
 		 * the directory to remain here, so we need to move this
 		 * path to some new location.
 		 */
-		new_ci =3D xcalloc(1, sizeof(*new_ci));
+		CALLOC_ARRAY(new_ci, 1);
 		/* We don't really want new_ci->merged.result copied, but it'll
 		 * be overwritten below so it doesn't matter.  We also don't
 		 * want any directory mode/oid values copied, but we'll zero
@@ -3083,7 +3082,7 @@ static int checkout(struct merge_options *opt,
 	unpack_opts.verbose_update =3D (opt->verbosity > 2);
 	unpack_opts.fn =3D twoway_merge;
 	if (1/* FIXME: opts->overwrite_ignore*/) {
-		unpack_opts.dir =3D xcalloc(1, sizeof(*unpack_opts.dir));
+		CALLOC_ARRAY(unpack_opts.dir, 1);
 		unpack_opts.dir->flags |=3D DIR_SHOW_IGNORED;
 		setup_standard_excludes(unpack_opts.dir);
 	}
diff --git a/merge-recursive.c b/merge-recursive.c
index b052974f19..b69e694d98 100644
=2D-- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -303,7 +303,7 @@ static inline void setup_rename_conflict_info(enum ren=
ame_type rename_type,
 		return;
 	}

-	ci =3D xcalloc(1, sizeof(struct rename_conflict_info));
+	CALLOC_ARRAY(ci, 1);
 	ci->rename_type =3D rename_type;
 	ci->ren1 =3D ren1;
 	ci->ren2 =3D ren2;
@@ -2389,8 +2389,7 @@ static void compute_collisions(struct hashmap *colli=
sions,
 			continue;
 		collision_ent =3D collision_find_entry(collisions, new_path);
 		if (!collision_ent) {
-			collision_ent =3D xcalloc(1,
-						sizeof(struct collision_entry));
+			CALLOC_ARRAY(collision_ent, 1);
 			hashmap_entry_init(&collision_ent->ent,
 						strhash(new_path));
 			hashmap_put(collisions, &collision_ent->ent);
@@ -2594,7 +2593,7 @@ static struct string_list *get_renames(struct merge_=
options *opt,
 	struct string_list *renames;

 	compute_collisions(&collisions, dir_renames, pairs);
-	renames =3D xcalloc(1, sizeof(struct string_list));
+	CALLOC_ARRAY(renames, 1);

 	for (i =3D 0; i < pairs->nr; ++i) {
 		struct string_list_item *item;
@@ -3664,7 +3663,7 @@ static int merge_start(struct merge_options *opt, st=
ruct tree *head)
 		return -1;
 	}

-	opt->priv =3D xcalloc(1, sizeof(*opt->priv));
+	CALLOC_ARRAY(opt->priv, 1);
 	string_list_init(&opt->priv->df_conflict_file_set, 1);
 	return 0;
 }
diff --git a/midx.c b/midx.c
index 971faa8cfc..becfafe65e 100644
=2D-- a/midx.c
+++ b/midx.c
@@ -145,8 +145,8 @@ struct multi_pack_index *load_multi_pack_index(const c=
har *object_dir, int local

 	m->num_objects =3D ntohl(m->chunk_oid_fanout[255]);

-	m->pack_names =3D xcalloc(m->num_packs, sizeof(*m->pack_names));
-	m->packs =3D xcalloc(m->num_packs, sizeof(*m->packs));
+	CALLOC_ARRAY(m->pack_names, m->num_packs);
+	CALLOC_ARRAY(m->packs, m->num_packs);

 	cur_pack_name =3D (const char *)m->chunk_pack_names;
 	for (i =3D 0; i < m->num_packs; i++) {
@@ -1144,7 +1144,7 @@ int expire_midx_packs(struct repository *r, const ch=
ar *object_dir, unsigned fla
 	if (!m)
 		return 0;

-	count =3D xcalloc(m->num_packs, sizeof(uint32_t));
+	CALLOC_ARRAY(count, m->num_packs);

 	if (flags & MIDX_PROGRESS)
 		progress =3D start_delayed_progress(_("Counting referenced objects"),
@@ -1315,7 +1315,7 @@ int midx_repack(struct repository *r, const char *ob=
ject_dir, size_t batch_size,
 	if (!m)
 		return 0;

-	include_pack =3D xcalloc(m->num_packs, sizeof(unsigned char));
+	CALLOC_ARRAY(include_pack, m->num_packs);

 	if (batch_size) {
 		if (fill_included_packs_batch(r, m, include_pack, batch_size))
diff --git a/name-hash.c b/name-hash.c
index 4e03fac9bb..ce28f3f070 100644
=2D-- a/name-hash.c
+++ b/name-hash.c
@@ -225,7 +225,7 @@ static void init_dir_mutex(void)
 {
 	int j;

-	lazy_dir_mutex_array =3D xcalloc(LAZY_MAX_MUTEX, sizeof(pthread_mutex_t)=
);
+	CALLOC_ARRAY(lazy_dir_mutex_array, LAZY_MAX_MUTEX);

 	for (j =3D 0; j < LAZY_MAX_MUTEX; j++)
 		init_recursive_mutex(&lazy_dir_mutex_array[j]);
@@ -514,9 +514,9 @@ static void threaded_lazy_init_name_hash(
 	k_start =3D 0;
 	nr_each =3D DIV_ROUND_UP(istate->cache_nr, lazy_nr_dir_threads);

-	lazy_entries =3D xcalloc(istate->cache_nr, sizeof(struct lazy_entry));
-	td_dir =3D xcalloc(lazy_nr_dir_threads, sizeof(struct lazy_dir_thread_da=
ta));
-	td_name =3D xcalloc(1, sizeof(struct lazy_name_thread_data));
+	CALLOC_ARRAY(lazy_entries, istate->cache_nr);
+	CALLOC_ARRAY(td_dir, lazy_nr_dir_threads);
+	CALLOC_ARRAY(td_name, 1);

 	init_dir_mutex();

diff --git a/negotiator/default.c b/negotiator/default.c
index 4b78f6bf36..434189ae5d 100644
=2D-- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -167,7 +167,7 @@ void default_negotiator_init(struct fetch_negotiator *=
negotiator)
 	negotiator->next =3D next;
 	negotiator->ack =3D ack;
 	negotiator->release =3D release;
-	negotiator->data =3D ns =3D xcalloc(1, sizeof(*ns));
+	negotiator->data =3D CALLOC_ARRAY(ns, 1);
 	ns->rev_list.compare =3D compare_commits_by_commit_date;

 	if (marked)
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index dffbc76c49..1236e79224 100644
=2D-- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -62,7 +62,7 @@ static struct entry *rev_list_push(struct data *data, st=
ruct commit *commit, int
 	struct entry *entry;
 	commit->object.flags |=3D mark | SEEN;

-	entry =3D xcalloc(1, sizeof(*entry));
+	CALLOC_ARRAY(entry, 1);
 	entry->commit =3D commit;
 	prio_queue_put(&data->rev_list, entry);

@@ -241,7 +241,7 @@ void skipping_negotiator_init(struct fetch_negotiator =
*negotiator)
 	negotiator->next =3D next;
 	negotiator->ack =3D ack;
 	negotiator->release =3D release;
-	negotiator->data =3D data =3D xcalloc(1, sizeof(*data));
+	negotiator->data =3D CALLOC_ARRAY(data, 1);
 	data->rev_list.compare =3D compare;

 	if (marked)
diff --git a/notes-merge.c b/notes-merge.c
index 2fe724f1cf..d2771fa3d4 100644
=2D-- a/notes-merge.c
+++ b/notes-merge.c
@@ -136,7 +136,7 @@ static struct notes_merge_pair *diff_tree_remote(struc=
t notes_merge_options *o,
 	diff_tree_oid(base, remote, "", &opt);
 	diffcore_std(&opt);

-	changes =3D xcalloc(diff_queued_diff.nr, sizeof(struct notes_merge_pair)=
);
+	CALLOC_ARRAY(changes, diff_queued_diff.nr);

 	for (i =3D 0; i < diff_queued_diff.nr; i++) {
 		struct diff_filepair *p =3D diff_queued_diff.queue[i];
diff --git a/notes-utils.c b/notes-utils.c
index 4bf4888d8c..d7d18e30f5 100644
=2D-- a/notes-utils.c
+++ b/notes-utils.c
@@ -129,7 +129,7 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(=
const char *cmd)
 	c->cmd =3D cmd;
 	c->enabled =3D 1;
 	c->combine =3D combine_notes_concatenate;
-	c->refs =3D xcalloc(1, sizeof(struct string_list));
+	CALLOC_ARRAY(c->refs, 1);
 	c->refs->strdup_strings =3D 1;
 	c->refs_from_env =3D 0;
 	c->mode_from_env =3D 0;
diff --git a/notes.c b/notes.c
index d5ac081e76..a19e4ad794 100644
=2D-- a/notes.c
+++ b/notes.c
@@ -452,7 +452,7 @@ static void load_subtree(struct notes_tree *t, struct =
leaf_node *subtree,
 			goto handle_non_note;
 		}

-		l =3D xcalloc(1, sizeof(*l));
+		CALLOC_ARRAY(l, 1);
 		oidcpy(&l->key_oid, &object_oid);
 		oidcpy(&l->val_oid, &entry.oid);
 		if (note_tree_insert(t, node, n, l, type,
diff --git a/object-file.c b/object-file.c
index 5bcfde8471..624af408cd 100644
=2D-- a/object-file.c
+++ b/object-file.c
@@ -546,7 +546,7 @@ static int link_alt_odb_entry(struct repository *r, co=
nst char *entry,
 		return -1;
 	}

-	ent =3D xcalloc(1, sizeof(*ent));
+	CALLOC_ARRAY(ent, 1);
 	ent->path =3D xstrdup(pathbuf.buf);

 	/* add the alternate entry */
diff --git a/object.c b/object.c
index 98017bed8e..78343781ae 100644
=2D-- a/object.c
+++ b/object.c
@@ -127,7 +127,7 @@ static void grow_object_hash(struct repository *r)
 	int new_hash_size =3D r->parsed_objects->obj_hash_size < 32 ? 32 : 2 * r=
->parsed_objects->obj_hash_size;
 	struct object **new_hash;

-	new_hash =3D xcalloc(new_hash_size, sizeof(struct object *));
+	CALLOC_ARRAY(new_hash, new_hash_size);
 	for (i =3D 0; i < r->parsed_objects->obj_hash_size; i++) {
 		struct object *obj =3D r->parsed_objects->obj_hash[i];

@@ -478,7 +478,7 @@ struct parsed_object_pool *parsed_object_pool_new(void=
)
 	o->object_state =3D allocate_alloc_state();

 	o->is_shallow =3D -1;
-	o->shallow_stat =3D xcalloc(1, sizeof(*o->shallow_stat));
+	CALLOC_ARRAY(o->shallow_stat, 1);

 	o->buffer_slab =3D allocate_commit_buffer_slab();

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1f69b5fa85..1ebe0c8162 100644
=2D-- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -978,7 +978,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_in=
fo *revs,

 	/* try to open a bitmapped pack, but don't parse it yet
 	 * because we may not need to use it */
-	bitmap_git =3D xcalloc(1, sizeof(*bitmap_git));
+	CALLOC_ARRAY(bitmap_git, 1);
 	if (open_pack_bitmap(revs->repo, bitmap_git) < 0)
 		goto cleanup;

@@ -1388,7 +1388,7 @@ uint32_t *create_bitmap_mapping(struct bitmap_index =
*bitmap_git,
 	uint32_t *reposition;

 	num_objects =3D bitmap_git->pack->num_objects;
-	reposition =3D xcalloc(num_objects, sizeof(uint32_t));
+	CALLOC_ARRAY(reposition, num_objects);

 	for (i =3D 0; i < num_objects; ++i) {
 		struct object_id oid;
diff --git a/pack-objects.c b/pack-objects.c
index f2a433885a..fe2a4eace9 100644
=2D-- a/pack-objects.c
+++ b/pack-objects.c
@@ -49,7 +49,7 @@ static void rehash_objects(struct packing_data *pdata)
 		pdata->index_size =3D 1024;

 	free(pdata->index);
-	pdata->index =3D xcalloc(pdata->index_size, sizeof(*pdata->index));
+	CALLOC_ARRAY(pdata->index, pdata->index_size);

 	entry =3D pdata->objects;

diff --git a/packfile.c b/packfile.c
index 1fec12ac5f..ea29f4ba77 100644
=2D-- a/packfile.c
+++ b/packfile.c
@@ -638,7 +638,7 @@ unsigned char *use_pack(struct packed_git *p,
 			if (p->pack_fd =3D=3D -1 && open_packed_git(p))
 				die("packfile %s cannot be accessed", p->pack_name);

-			win =3D xcalloc(1, sizeof(*win));
+			CALLOC_ARRAY(win, 1);
 			win->offset =3D (offset / window_align) * window_align;
 			len =3D p->pack_size - win->offset;
 			if (len > packed_git_window_size)
diff --git a/patch-ids.c b/patch-ids.c
index 3f404e4b0b..8bf425555d 100644
=2D-- a/patch-ids.c
+++ b/patch-ids.c
@@ -124,7 +124,7 @@ struct patch_id *add_commit_patch_id(struct commit *co=
mmit,
 	if (!patch_id_defined(commit))
 		return NULL;

-	key =3D xcalloc(1, sizeof(*key));
+	CALLOC_ARRAY(key, 1);
 	if (init_patch_id_entry(key, commit, ids)) {
 		free(key);
 		return NULL;
diff --git a/pathspec.c b/pathspec.c
index 7a229d8d22..18b3be362a 100644
=2D-- a/pathspec.c
+++ b/pathspec.c
@@ -154,7 +154,7 @@ static void parse_pathspec_attr_match(struct pathspec_=
item *item, const char *va
 	string_list_remove_empty_items(&list, 0);

 	item->attr_check =3D attr_check_alloc();
-	item->attr_match =3D xcalloc(list.nr, sizeof(struct attr_match));
+	CALLOC_ARRAY(item->attr_match, list.nr);

 	for_each_string_list_item(si, &list) {
 		size_t attr_len;
@@ -561,7 +561,7 @@ void parse_pathspec(struct pathspec *pathspec,
 		if (!(flags & PATHSPEC_PREFER_CWD))
 			BUG("PATHSPEC_PREFER_CWD requires arguments");

-		pathspec->items =3D item =3D xcalloc(1, sizeof(*item));
+		pathspec->items =3D CALLOC_ARRAY(item, 1);
 		item->match =3D xstrdup(prefix);
 		item->original =3D xstrdup(prefix);
 		item->nowildcard_len =3D item->len =3D strlen(prefix);
diff --git a/pretty.c b/pretty.c
index c5f5ecc40d..d5efd00e21 100644
=2D-- a/pretty.c
+++ b/pretty.c
@@ -678,7 +678,7 @@ static int mailmap_name(const char **email, size_t *em=
ail_len,
 {
 	static struct string_list *mail_map;
 	if (!mail_map) {
-		mail_map =3D xcalloc(1, sizeof(*mail_map));
+		CALLOC_ARRAY(mail_map, 1);
 		read_mailmap(mail_map);
 	}
 	return mail_map->nr && map_user(mail_map, email, email_len, name, name_l=
en);
diff --git a/progress.c b/progress.c
index 31014e6fca..680c6a8bf9 100644
=2D-- a/progress.c
+++ b/progress.c
@@ -196,7 +196,7 @@ void display_throughput(struct progress *progress, uin=
t64_t total)
 	now_ns =3D progress_getnanotime(progress);

 	if (!tp) {
-		progress->throughput =3D tp =3D xcalloc(1, sizeof(*tp));
+		progress->throughput =3D CALLOC_ARRAY(tp, 1);
 		tp->prev_total =3D tp->curr_total =3D total;
 		tp->prev_ns =3D now_ns;
 		strbuf_init(&tp->display, 0);
diff --git a/promisor-remote.c b/promisor-remote.c
index 3c572b1c81..da3f2ca261 100644
=2D-- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -208,7 +208,7 @@ static int remove_fetched_oids(struct repository *repo=
,

 	if (remaining_nr) {
 		int j =3D 0;
-		new_oids =3D xcalloc(remaining_nr, sizeof(*new_oids));
+		CALLOC_ARRAY(new_oids, remaining_nr);
 		for (i =3D 0; i < oid_nr; i++)
 			if (remaining[i])
 				oidcpy(&new_oids[j++], &old_oids[i]);
diff --git a/range-diff.c b/range-diff.c
index f617426474..116fb0735c 100644
=2D-- a/range-diff.c
+++ b/range-diff.c
@@ -96,7 +96,7 @@ static int read_patches(const char *range, struct string=
_list *list,
 				string_list_append(list, buf.buf)->util =3D util;
 				strbuf_reset(&buf);
 			}
-			util =3D xcalloc(1, sizeof(*util));
+			CALLOC_ARRAY(util, 1);
 			if (get_oid(p, &util->oid)) {
 				error(_("could not parse commit '%s'"), p);
 				free(util);
diff --git a/read-cache.c b/read-cache.c
index 1e9a50c6c7..c8d12eaa3c 100644
=2D-- a/read-cache.c
+++ b/read-cache.c
@@ -2097,7 +2097,7 @@ static unsigned long load_cache_entries_threaded(str=
uct index_state *istate, con
 	/* ensure we have no more threads than we have blocks to process */
 	if (nr_threads > ieot->nr)
 		nr_threads =3D ieot->nr;
-	data =3D xcalloc(nr_threads, sizeof(*data));
+	CALLOC_ARRAY(data, nr_threads);

 	offset =3D ieot_start =3D 0;
 	ieot_blocks =3D DIV_ROUND_UP(ieot->nr, nr_threads);
@@ -2199,7 +2199,7 @@ int do_read_index(struct index_state *istate, const =
char *path, int must_exist)
 	istate->version =3D ntohl(hdr->hdr_version);
 	istate->cache_nr =3D ntohl(hdr->hdr_entries);
 	istate->cache_alloc =3D alloc_nr(istate->cache_nr);
-	istate->cache =3D xcalloc(istate->cache_alloc, sizeof(*istate->cache));
+	CALLOC_ARRAY(istate->cache, istate->cache_alloc);
 	istate->initialized =3D 1;

 	p.istate =3D istate;
@@ -2326,7 +2326,7 @@ int read_index_from(struct index_state *istate, cons=
t char *path,
 	if (split_index->base)
 		discard_index(split_index->base);
 	else
-		split_index->base =3D xcalloc(1, sizeof(*split_index->base));
+		CALLOC_ARRAY(split_index->base, 1);

 	base_oid_hex =3D oid_to_hex(&split_index->base_oid);
 	base_path =3D xstrfmt("%s/sharedindex.%s", gitdir, base_oid_hex);
@@ -3427,7 +3427,7 @@ void stat_validity_update(struct stat_validity *sv, =
int fd)
 		stat_validity_clear(sv);
 	else {
 		if (!sv->sd)
-			sv->sd =3D xcalloc(1, sizeof(struct stat_data));
+			CALLOC_ARRAY(sv->sd, 1);
 		fill_stat_data(sv->sd, &st);
 	}
 }
diff --git a/ref-filter.c b/ref-filter.c
index 33b5e68056..f0bd32f714 100644
=2D-- a/ref-filter.c
+++ b/ref-filter.c
@@ -1677,7 +1677,7 @@ static int populate_value(struct ref_array_item *ref=
, struct strbuf *err)
 	int i;
 	struct object_info empty =3D OBJECT_INFO_INIT;

-	ref->value =3D xcalloc(used_atom_cnt, sizeof(struct atom_value));
+	CALLOC_ARRAY(ref->value, used_atom_cnt);

 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
 		ref->symref =3D resolve_refdup(ref->refname, RESOLVE_REF_READING,
@@ -2186,7 +2186,7 @@ static void reach_filter(struct ref_array *array,
 	if (!check_reachable)
 		return;

-	to_clear =3D xcalloc(array->nr, sizeof(struct commit *));
+	CALLOC_ARRAY(to_clear, array->nr);

 	repo_init_revisions(the_repository, &revs, NULL);

@@ -2491,7 +2491,7 @@ void parse_ref_sorting(struct ref_sorting **sorting_=
tail, const char *arg)
 {
 	struct ref_sorting *s;

-	s =3D xcalloc(1, sizeof(*s));
+	CALLOC_ARRAY(s, 1);
 	s->next =3D *sorting_tail;
 	*sorting_tail =3D s;

diff --git a/reflog-walk.c b/reflog-walk.c
index 3a25b27d8f..e9cd328369 100644
=2D-- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -112,7 +112,7 @@ struct reflog_walk_info {

 void init_reflog_walk(struct reflog_walk_info **info)
 {
-	*info =3D xcalloc(1, sizeof(struct reflog_walk_info));
+	CALLOC_ARRAY(*info, 1);
 	(*info)->complete_reflogs.strdup_strings =3D 1;
 }

@@ -181,7 +181,7 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 	}
 	free(branch);

-	commit_reflog =3D xcalloc(1, sizeof(struct commit_reflog));
+	CALLOC_ARRAY(commit_reflog, 1);
 	if (recno < 0) {
 		commit_reflog->recno =3D get_reflog_recno_by_time(reflogs, timestamp);
 		if (commit_reflog->recno < 0) {
diff --git a/refs.c b/refs.c
index a665ed5e10..261fd82beb 100644
=2D-- a/refs.c
+++ b/refs.c
@@ -1007,7 +1007,7 @@ struct ref_transaction *ref_store_transaction_begin(=
struct ref_store *refs,
 	struct ref_transaction *tr;
 	assert(err);

-	tr =3D xcalloc(1, sizeof(struct ref_transaction));
+	CALLOC_ARRAY(tr, 1);
 	tr->ref_store =3D refs;
 	return tr;
 }
@@ -1306,7 +1306,7 @@ int parse_hide_refs_config(const char *var, const ch=
ar *value, const char *secti
 		while (len && ref[len - 1] =3D=3D '/')
 			ref[--len] =3D '\0';
 		if (!hide_refs) {
-			hide_refs =3D xcalloc(1, sizeof(*hide_refs));
+			CALLOC_ARRAY(hide_refs, 1);
 			hide_refs->strdup_strings =3D 1;
 		}
 		string_list_append(hide_refs, ref);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4fdc68810b..119972ee16 100644
=2D-- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -549,7 +549,7 @@ static int lock_raw_ref(struct files_ref_store *refs,

 	/* First lock the file so it can't change out from under us. */

-	*lock_p =3D lock =3D xcalloc(1, sizeof(*lock));
+	*lock_p =3D CALLOC_ARRAY(lock, 1);

 	lock->ref_name =3D xstrdup(refname);
 	files_ref_path(refs, &ref_file, refname);
@@ -843,7 +843,7 @@ static struct ref_iterator *files_ref_iterator_begin(

 	overlay_iter =3D overlay_ref_iterator_begin(loose_iter, packed_iter);

-	iter =3D xcalloc(1, sizeof(*iter));
+	CALLOC_ARRAY(iter, 1);
 	ref_iterator =3D &iter->base;
 	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable,
 			       overlay_iter->ordered);
@@ -930,7 +930,7 @@ static struct ref_lock *lock_ref_oid_basic(struct file=
s_ref_store *refs,
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);

-	lock =3D xcalloc(1, sizeof(struct ref_lock));
+	CALLOC_ARRAY(lock, 1);

 	if (mustexist)
 		resolve_flags |=3D RESOLVE_REF_READING;
@@ -2152,7 +2152,7 @@ static struct ref_iterator *reflog_iterator_begin(st=
ruct ref_store *ref_store,
 		return empty_ref_iterator_begin();
 	}

-	iter =3D xcalloc(1, sizeof(*iter));
+	CALLOC_ARRAY(iter, 1);
 	ref_iterator =3D &iter->base;

 	base_ref_iterator_init(ref_iterator, &files_reflog_iterator_vtable, 0);
@@ -2597,7 +2597,7 @@ static int files_transaction_prepare(struct ref_stor=
e *ref_store,
 	if (!transaction->nr)
 		goto cleanup;

-	backend_data =3D xcalloc(1, sizeof(*backend_data));
+	CALLOC_ARRAY(backend_data, 1);
 	transaction->backend_data =3D backend_data;

 	/*
diff --git a/refs/iterator.c b/refs/iterator.c
index 629e00a122..a89d132d4f 100644
=2D-- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -393,7 +393,7 @@ struct ref_iterator *prefix_ref_iterator_begin(struct =
ref_iterator *iter0,
 	if (!*prefix && !trim)
 		return iter0; /* optimization: no need to wrap iterator */

-	iter =3D xcalloc(1, sizeof(*iter));
+	CALLOC_ARRAY(iter, 1);
 	ref_iterator =3D &iter->base;

 	base_ref_iterator_init(ref_iterator, &prefix_ref_iterator_vtable, iter0-=
>ordered);
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index b912f2505f..dfecdbc1db 100644
=2D-- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -941,7 +941,7 @@ static struct ref_iterator *packed_ref_iterator_begin(
 	if (start =3D=3D snapshot->eof)
 		return empty_ref_iterator_begin();

-	iter =3D xcalloc(1, sizeof(*iter));
+	CALLOC_ARRAY(iter, 1);
 	ref_iterator =3D &iter->base;
 	base_ref_iterator_init(ref_iterator, &packed_ref_iterator_vtable, 1);

@@ -1424,7 +1424,7 @@ static int packed_transaction_prepare(struct ref_sto=
re *ref_store,
 	 * do so itself.
 	 */

-	data =3D xcalloc(1, sizeof(*data));
+	CALLOC_ARRAY(data, 1);
 	string_list_init(&data->updates, 0);

 	transaction->backend_data =3D data;
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index b7052f72e2..46f1e54284 100644
=2D-- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -530,7 +530,7 @@ struct ref_iterator *cache_ref_iterator_begin(struct r=
ef_cache *cache,
 	if (prime_dir)
 		prime_ref_dir(dir, prefix);

-	iter =3D xcalloc(1, sizeof(*iter));
+	CALLOC_ARRAY(iter, 1);
 	ref_iterator =3D &iter->base;
 	base_ref_iterator_init(ref_iterator, &cache_ref_iterator_vtable, 1);
 	ALLOC_GROW(iter->levels, 10, iter->levels_alloc);
diff --git a/remote.c b/remote.c
index c3f85c17ca..6d1e8d02df 100644
=2D-- a/remote.c
+++ b/remote.c
@@ -151,7 +151,7 @@ static struct remote *make_remote(const char *name, in=
t len)
 	if (e)
 		return container_of(e, struct remote, ent);

-	ret =3D xcalloc(1, sizeof(struct remote));
+	CALLOC_ARRAY(ret, 1);
 	ret->prune =3D -1;  /* unspecified */
 	ret->prune_tags =3D -1;  /* unspecified */
 	ret->name =3D xstrndup(name, len);
@@ -186,7 +186,7 @@ static struct branch *make_branch(const char *name, si=
ze_t len)
 	}

 	ALLOC_GROW(branches, branches_nr + 1, branches_alloc);
-	ret =3D xcalloc(1, sizeof(struct branch));
+	CALLOC_ARRAY(ret, 1);
 	branches[branches_nr++] =3D ret;
 	ret->name =3D xstrndup(name, len);
 	ret->refname =3D xstrfmt("refs/heads/%s", ret->name);
@@ -207,7 +207,7 @@ static struct rewrite *make_rewrite(struct rewrites *r=
,
 	}

 	ALLOC_GROW(r->rewrite, r->rewrite_nr + 1, r->rewrite_alloc);
-	ret =3D xcalloc(1, sizeof(struct rewrite));
+	CALLOC_ARRAY(ret, 1);
 	r->rewrite[r->rewrite_nr++] =3D ret;
 	ret->base =3D xstrndup(base, len);
 	ret->baselen =3D len;
@@ -1664,7 +1664,7 @@ static void set_merge(struct branch *ret)

 	remote =3D remote_get(ret->remote_name);

-	ret->merge =3D xcalloc(ret->merge_nr, sizeof(*ret->merge));
+	CALLOC_ARRAY(ret->merge, ret->merge_nr);
 	for (i =3D 0; i < ret->merge_nr; i++) {
 		ret->merge[i] =3D xcalloc(1, sizeof(**ret->merge));
 		ret->merge[i]->src =3D xstrdup(ret->merge_name[i]);
diff --git a/repository.c b/repository.c
index c98298acd0..87b355e7a6 100644
=2D-- a/repository.c
+++ b/repository.c
@@ -72,7 +72,7 @@ void repo_set_gitdir(struct repository *repo,
 	repo_set_commondir(repo, o->commondir);

 	if (!repo->objects->odb) {
-		repo->objects->odb =3D xcalloc(1, sizeof(*repo->objects->odb));
+		CALLOC_ARRAY(repo->objects->odb, 1);
 		repo->objects->odb_tail =3D &repo->objects->odb->next;
 	}
 	expand_base_dir(&repo->objects->odb->path, o->object_dir,
@@ -262,7 +262,7 @@ void repo_clear(struct repository *repo)
 int repo_read_index(struct repository *repo)
 {
 	if (!repo->index)
-		repo->index =3D xcalloc(1, sizeof(*repo->index));
+		CALLOC_ARRAY(repo->index, 1);

 	/* Complete the double-reference */
 	if (!repo->index->repo)
diff --git a/resolve-undo.c b/resolve-undo.c
index 236320f179..bbd2e57fe4 100644
=2D-- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -15,7 +15,7 @@ void record_resolve_undo(struct index_state *istate, str=
uct cache_entry *ce)
 		return;

 	if (!istate->resolve_undo) {
-		resolve_undo =3D xcalloc(1, sizeof(*resolve_undo));
+		CALLOC_ARRAY(resolve_undo, 1);
 		resolve_undo->strdup_strings =3D 1;
 		istate->resolve_undo =3D resolve_undo;
 	}
@@ -57,7 +57,7 @@ struct string_list *resolve_undo_read(const char *data, =
unsigned long size)
 	int i;
 	const unsigned rawsz =3D the_hash_algo->rawsz;

-	resolve_undo =3D xcalloc(1, sizeof(*resolve_undo));
+	CALLOC_ARRAY(resolve_undo, 1);
 	resolve_undo->strdup_strings =3D 1;

 	while (size) {
diff --git a/revision.c b/revision.c
index b78733f508..99c859f797 100644
=2D-- a/revision.c
+++ b/revision.c
@@ -154,7 +154,7 @@ static void paths_and_oids_insert(struct hashmap *map,

 	entry =3D hashmap_get_entry(map, &key, ent, NULL);
 	if (!entry) {
-		entry =3D xcalloc(1, sizeof(struct path_and_oids_entry));
+		CALLOC_ARRAY(entry, 1);
 		hashmap_entry_init(&entry->ent, hash);
 		entry->path =3D xstrdup(key.path);
 		oidset_init(&entry->trees, 16);
@@ -1555,7 +1555,7 @@ void clear_ref_exclusion(struct string_list **ref_ex=
cludes_p)
 void add_ref_exclusion(struct string_list **ref_excludes_p, const char *e=
xclude)
 {
 	if (!*ref_excludes_p) {
-		*ref_excludes_p =3D xcalloc(1, sizeof(**ref_excludes_p));
+		CALLOC_ARRAY(*ref_excludes_p, 1);
 		(*ref_excludes_p)->strdup_strings =3D 1;
 	}
 	string_list_append(*ref_excludes_p, exclude);
@@ -2929,7 +2929,7 @@ static struct merge_simplify_state *locate_simplify_=
state(struct rev_info *revs,

 	st =3D lookup_decoration(&revs->merge_simplification, &commit->object);
 	if (!st) {
-		st =3D xcalloc(1, sizeof(*st));
+		CALLOC_ARRAY(st, 1);
 		add_decoration(&revs->merge_simplification, &commit->object, st);
 	}
 	return st;
diff --git a/run-command.c b/run-command.c
index 4e34623e2e..be6bc128cd 100644
=2D-- a/run-command.c
+++ b/run-command.c
@@ -1638,8 +1638,8 @@ static void pp_init(struct parallel_processes *pp,
 	pp->nr_processes =3D 0;
 	pp->output_owner =3D 0;
 	pp->shutdown =3D 0;
-	pp->children =3D xcalloc(n, sizeof(*pp->children));
-	pp->pfd =3D xcalloc(n, sizeof(*pp->pfd));
+	CALLOC_ARRAY(pp->children, n);
+	CALLOC_ARRAY(pp->pfd, n);
 	strbuf_init(&pp->buffered_output, 0);

 	for (i =3D 0; i < n; i++) {
diff --git a/send-pack.c b/send-pack.c
index 9045f8a082..5f215b13c7 100644
=2D-- a/send-pack.c
+++ b/send-pack.c
@@ -188,13 +188,13 @@ static int receive_status(struct packet_reader *read=
er, struct ref *refs)
 			}
 			if (new_report) {
 				if (!hint->report) {
-					hint->report =3D xcalloc(1, sizeof(struct ref_push_report));
+					CALLOC_ARRAY(hint->report, 1);
 					report =3D hint->report;
 				} else {
 					report =3D hint->report;
 					while (report->next)
 						report =3D report->next;
-					report->next =3D xcalloc(1, sizeof(struct ref_push_report));
+					CALLOC_ARRAY(report->next, 1);
 					report =3D report->next;
 				}
 				new_report =3D 0;
diff --git a/sequencer.c b/sequencer.c
index d2332d3e17..848204d3dc 100644
=2D-- a/sequencer.c
+++ b/sequencer.c
@@ -5171,7 +5171,7 @@ void todo_list_add_exec_commands(struct todo_list *t=
odo_list,
 	int i, insert, nr =3D 0, alloc =3D 0;
 	struct todo_item *items =3D NULL, *base_items =3D NULL;

-	base_items =3D xcalloc(commands->nr, sizeof(struct todo_item));
+	CALLOC_ARRAY(base_items, commands->nr);
 	for (i =3D 0; i < commands->nr; i++) {
 		size_t command_len =3D strlen(commands->items[i].string);

diff --git a/server-info.c b/server-info.c
index bae2cdfd51..de0aa4498c 100644
=2D-- a/server-info.c
+++ b/server-info.c
@@ -296,7 +296,7 @@ static void init_pack_info(const char *infofile, int f=
orce)

 		i =3D num_pack++;
 		ALLOC_GROW(info, num_pack, alloc);
-		info[i] =3D xcalloc(1, sizeof(struct pack_info));
+		CALLOC_ARRAY(info[i], 1);
 		info[i]->p =3D p;
 		info[i]->old_num =3D -1;
 	}
diff --git a/split-index.c b/split-index.c
index c0e8ad670d..94937d21a3 100644
=2D-- a/split-index.c
+++ b/split-index.c
@@ -5,7 +5,7 @@
 struct split_index *init_split_index(struct index_state *istate)
 {
 	if (!istate->split_index) {
-		istate->split_index =3D xcalloc(1, sizeof(*istate->split_index));
+		CALLOC_ARRAY(istate->split_index, 1);
 		istate->split_index->refcount =3D 1;
 	}
 	return istate->split_index;
@@ -87,7 +87,7 @@ void move_cache_to_base_index(struct index_state *istate=
)
 		mem_pool_combine(istate->ce_mem_pool, istate->split_index->base->ce_mem=
_pool);
 	}

-	si->base =3D xcalloc(1, sizeof(*si->base));
+	CALLOC_ARRAY(si->base, 1);
 	si->base->version =3D istate->version;
 	/* zero timestamp disables racy test in ce_write_index() */
 	si->base->timestamp =3D istate->timestamp;
diff --git a/trailer.c b/trailer.c
index 35b58357cb..be4e972642 100644
=2D-- a/trailer.c
+++ b/trailer.c
@@ -445,7 +445,7 @@ static struct arg_item *get_conf_item(const char *name=
)
 	}

 	/* Item does not already exists, create it */
-	item =3D xcalloc(1, sizeof(*item));
+	CALLOC_ARRAY(item, 1);
 	duplicate_conf(&item->conf, &default_conf_info);
 	item->conf.name =3D xstrdup(name);

diff --git a/transport-helper.c b/transport-helper.c
index 49b7fb4dcb..4cd76366fa 100644
=2D-- a/transport-helper.c
+++ b/transport-helper.c
@@ -745,13 +745,13 @@ static int push_update_ref_status(struct strbuf *buf=
,
 			die(_("'option' without a matching 'ok/error' directive"));
 		if (state->new_report) {
 			if (!state->hint->report) {
-				state->hint->report =3D xcalloc(1, sizeof(struct ref_push_report));
+				CALLOC_ARRAY(state->hint->report, 1);
 				state->report =3D state->hint->report;
 			} else {
 				state->report =3D state->hint->report;
 				while (state->report->next)
 					state->report =3D state->report->next;
-				state->report->next =3D xcalloc(1, sizeof(struct ref_push_report));
+				CALLOC_ARRAY(state->report->next, 1);
 				state->report =3D state->report->next;
 			}
 			state->new_report =3D 0;
diff --git a/transport.c b/transport.c
index b13fab5dc3..1c4ab676d1 100644
=2D-- a/transport.c
+++ b/transport.c
@@ -871,7 +871,7 @@ void transport_take_over(struct transport *transport,
 		BUG("taking over transport requires non-NULL "
 		    "smart_options field.");

-	data =3D xcalloc(1, sizeof(*data));
+	CALLOC_ARRAY(data, 1);
 	data->options =3D *transport->smart_options;
 	data->conn =3D child;
 	data->fd[0] =3D data->conn->out;
diff --git a/worktree.c b/worktree.c
index e00858540e..f35ac40a84 100644
=2D-- a/worktree.c
+++ b/worktree.c
@@ -53,7 +53,7 @@ static struct worktree *get_main_worktree(void)
 	strbuf_add_real_path(&worktree_path, get_git_common_dir());
 	strbuf_strip_suffix(&worktree_path, "/.git");

-	worktree =3D xcalloc(1, sizeof(*worktree));
+	CALLOC_ARRAY(worktree, 1);
 	worktree->path =3D strbuf_detach(&worktree_path, NULL);
 	/*
 	 * NEEDSWORK: If this function is called from a secondary worktree and
@@ -84,7 +84,7 @@ static struct worktree *get_linked_worktree(const char *=
id)
 	strbuf_rtrim(&worktree_path);
 	strbuf_strip_suffix(&worktree_path, "/.git");

-	worktree =3D xcalloc(1, sizeof(*worktree));
+	CALLOC_ARRAY(worktree, 1);
 	worktree->path =3D strbuf_detach(&worktree_path, NULL);
 	worktree->id =3D xstrdup(id);
 	add_head_info(worktree);
diff --git a/wt-status.c b/wt-status.c
index 0c8287a023..1aed68c43c 100644
=2D-- a/wt-status.c
+++ b/wt-status.c
@@ -456,7 +456,7 @@ static void wt_status_collect_changed_cb(struct diff_q=
ueue_struct *q,
 		it =3D string_list_insert(&s->change, p->two->path);
 		d =3D it->util;
 		if (!d) {
-			d =3D xcalloc(1, sizeof(*d));
+			CALLOC_ARRAY(d, 1);
 			it->util =3D d;
 		}
 		if (!d->worktree_status)
@@ -540,7 +540,7 @@ static void wt_status_collect_updated_cb(struct diff_q=
ueue_struct *q,
 		it =3D string_list_insert(&s->change, p->two->path);
 		d =3D it->util;
 		if (!d) {
-			d =3D xcalloc(1, sizeof(*d));
+			CALLOC_ARRAY(d, 1);
 			it->util =3D d;
 		}
 		if (!d->index_status)
@@ -671,7 +671,7 @@ static void wt_status_collect_changes_initial(struct w=
t_status *s)
 		it =3D string_list_insert(&s->change, ce->name);
 		d =3D it->util;
 		if (!d) {
-			d =3D xcalloc(1, sizeof(*d));
+			CALLOC_ARRAY(d, 1);
 			it->util =3D d;
 		}
 		if (ce_stage(ce)) {
=2D-
2.30.2
