Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2442420A1E
	for <e@80x24.org>; Fri, 14 Dec 2018 21:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730893AbeLNVWT (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 16:22:19 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45802 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbeLNVWS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 16:22:18 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so3385858pfd.12
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 13:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DaVKACR02fwDVdFPxPtpAbTxrAIDzBMs3BS2UvUyQ80=;
        b=Sl4UocGv3s/spai4sEl7ssPMMB6DVQdCIBdqDUjsIJXPmMA3V/FUOpZ3rilKwco80+
         nz//bbHb1NI85rdHHPJIFZEud6M9tJnG/5QJU70lx1Lt2qFm3daTNcyzSkeI3BSq4ccL
         1guqguJfzTL36h0e8a8iHl+qHP83Ie1p6V/KsQ3/ocL37mXCphyo8+8HGYnAUEAPL6ab
         tLAmFOuJvqtBzgh3PreDcJCd0j+ETQ9ZkQ118hPFJDY+8XfvbZ78PVRrMUTCepp++aDi
         cHpm6TOMPj2247yjNfYLXeQfk6HM4B5n4FijrwGO4hvMMN3lvY4gHHLlm2MPyvRFAq8Z
         ufgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DaVKACR02fwDVdFPxPtpAbTxrAIDzBMs3BS2UvUyQ80=;
        b=fUkYv6gp5GBhJX9Choeu1vFiNx2A0oU8LzZPPakPARRV/HvO1yEoZ0VQEgt/1DHuKO
         zb4ygQ5M0e7AxnmdKp9w5esNnt1bSSqYA8ChA15Tgu5G1x+lbJyF0sWMliD6Qsh378Sd
         HXRABeMtG5FwNeq7+x8GAUQpqNHToj37K1m3FdwayNkn72toV8ERu+D2hv3goPHnn/qh
         2In8W0I7cSVDQcdiqKNJo7JNqSZO4dLVFJEaBX9GwyFom6sQ9df6cQ1uJI8S6eeY09Pw
         rIJJZdR0Ly9juQqbYbJJVCVVqwlvuD5FBRsaIQ5OB8lp1jmxnUzk97VDofx3a3MzRjty
         Sulg==
X-Gm-Message-State: AA+aEWbmLcpLO3NO2H/Wa16iQ1+0MCvoG5YyFqcJ20aBIWv9vucpGwcC
        zq/LT7TSRcWLc40r7PAipJqetoDF
X-Google-Smtp-Source: AFSGD/Uf2YalqP+NSK294OZzpfSPwm9ThelJeFXadZCy6E9875QfHaCVit+Da+HW63SYLtx4/T9KmQ==
X-Received: by 2002:a63:9809:: with SMTP id q9mr4106878pgd.109.1544822536351;
        Fri, 14 Dec 2018 13:22:16 -0800 (PST)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id u70sm9985685pfa.176.2018.12.14.13.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 13:22:15 -0800 (PST)
Date:   Fri, 14 Dec 2018 13:22:15 -0800 (PST)
X-Google-Original-Date: Fri, 14 Dec 2018 21:22:06 GMT
Message-Id: <pull.89.v4.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.89.v3.git.gitgitgadget@gmail.com>
References: <pull.89.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 0/6] Add a new "sparse" tree walk algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, jrnieder@gmail.com,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One of the biggest remaining pain points for users of very large
repositories is the time it takes to run 'git push'. We inspected some slow
pushes by our developers and found that the "Enumerating Objects" phase of a
push was very slow. This is unsurprising, because this is why reachability
bitmaps exist. However, reachability bitmaps are not available to us because
of the single pack-file requirement. The bitmap approach is intended for
servers anyway, and clients have a much different behavior pattern.

Specifically, clients are normally pushing a very small number of objects
compared to the entire working directory. A typical user changes only a
small cone of the working directory, so let's use that to our benefit.

Create a new "sparse" mode for 'git pack-objects' that uses the paths that
introduce new objects to direct our search into the reachable trees. By
collecting trees at each path, we can then recurse into a path only when
there are uninteresting and interesting trees at that path. This gains a
significant performance boost for small topics while presenting a
possibility of packing extra objects.

The main algorithm change is in patch 4, but is set up a little bit in
patches 1 and 2.

As demonstrated in the included test script, we see that the existing
algorithm can send extra objects due to the way we specify the "frontier".
But we can send even more objects if a user copies objects from one folder
to another. I say "copy" because a rename would (usually) change the
original folder and trigger a walk into that path, discovering the objects.

In order to benefit from this approach, the user can opt-in using the
pack.useSparse config setting. This setting can be overridden using the
'--no-sparse' option.

Update in V2: 

 * Added GIT_TEST_PACK_SPARSE test option.
 * Fixed test breakages when GIT_TEST_PACK_SPARSE is enabled by adding null
   checks.

Update in V3:

 * Change documentation around 'pack.useSparse' config setting to better
   advertise to users.
 * Mostly a ping now that v2.20.0 is out.

Updates in V4:

 * Switched to using hashmap instead of string_list for the path/oidset
   dictionary. (This is due to some fear that the string_list performance
   would degrade for a very wide tree, but I am unable to measure a
   performance difference.)
 * Some cleanup of code snippets across commits.
 * Some grammar cleanup in the commit messages.

Derrick Stolee (6):
  revision: add mark_tree_uninteresting_sparse
  list-objects: consume sparse tree walk
  pack-objects: add --sparse option
  revision: implement sparse algorithm
  pack-objects: create pack.useSparse setting
  pack-objects: create GIT_TEST_PACK_SPARSE

 Documentation/config/pack.txt      |   9 ++
 Documentation/git-pack-objects.txt |  11 ++-
 bisect.c                           |   2 +-
 builtin/pack-objects.c             |  10 +-
 builtin/rev-list.c                 |   2 +-
 http-push.c                        |   2 +-
 list-objects.c                     |  70 +++++++++++---
 list-objects.h                     |   4 +-
 revision.c                         | 144 +++++++++++++++++++++++++++++
 revision.h                         |   2 +
 t/README                           |   4 +
 t/t5322-pack-objects-sparse.sh     | 139 ++++++++++++++++++++++++++++
 12 files changed, 382 insertions(+), 17 deletions(-)
 create mode 100755 t/t5322-pack-objects-sparse.sh


base-commit: a1598010f775d82b5adf12c29d0f5bc9b41434c6
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-89%2Fderrickstolee%2Fpush%2Fsparse-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-89/derrickstolee/push/sparse-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/89

Range-diff vs v3:

 1:  60617681f7 ! 1:  817e30a287 revision: add mark_tree_uninteresting_sparse
     @@ -35,6 +35,9 @@
      +	while ((oid = oidset_iter_next(&iter))) {
      +		struct tree *tree = lookup_tree(r, oid);
      +
     ++		if (!tree)
     ++			continue;
     ++
      +		if (tree->object.flags & UNINTERESTING) {
      +			/*
      +			 * Remove the flag so the next call
 2:  4527addacb ! 2:  39dc89beb9 list-objects: consume sparse tree walk
     @@ -11,9 +11,10 @@
          We walk these commits until we discover a frontier of commits such
          that every commit walk starting at interesting commits ends in a root
          commit or unintersting commit. We then need to discover which
     -    non-commit objects are reachable from  uninteresting commits.
     +    non-commit objects are reachable from  uninteresting commits. This
     +    commit walk is not changing during this series.
      
     -    The mark_edges_unintersting() method in list-objects.c iterates on
     +    The mark_edges_uninteresting() method in list-objects.c iterates on
          the commit list and does the following:
      
          * If the commit is UNINTERSTING, then mark its root tree and every
     @@ -138,17 +139,22 @@
      +			      int sparse)
       {
       	struct commit_list *list;
     -+	struct oidset set;
       	int i;
       
     -+	if (sparse)
     +-	for (list = revs->commits; list; list = list->next) {
     +-		struct commit *commit = list->item;
     ++	if (sparse) {
     ++		struct oidset set;
      +		oidset_init(&set, 16);
     -+
     - 	for (list = revs->commits; list; list = list->next) {
     - 		struct commit *commit = list->item;
       
      -		if (commit->object.flags & UNINTERESTING) {
     -+		if (sparse) {
     +-			mark_tree_uninteresting(revs->repo,
     +-						get_commit_tree(commit));
     +-			if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
     +-				commit->object.flags |= SHOWN;
     +-				show_edge(commit);
     ++		for (list = revs->commits; list; list = list->next) {
     ++			struct commit *commit = list->item;
      +			struct tree *tree = get_commit_tree(commit);
      +
      +			if (commit->object.flags & UNINTERESTING)
     @@ -156,24 +162,27 @@
      +
      +			oidset_insert(&set, &tree->object.oid);
      +			add_edge_parents(commit, revs, show_edge, &set);
     -+		} else if (commit->object.flags & UNINTERESTING) {
     - 			mark_tree_uninteresting(revs->repo,
     - 						get_commit_tree(commit));
     - 			if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
     - 				commit->object.flags |= SHOWN;
     - 				show_edge(commit);
     ++		}
     ++
     ++		mark_trees_uninteresting_sparse(revs->repo, &set);
     ++		oidset_clear(&set);
     ++	} else {
     ++		for (list = revs->commits; list; list = list->next) {
     ++			struct commit *commit = list->item;
     ++			if (commit->object.flags & UNINTERESTING) {
     ++				mark_tree_uninteresting(revs->repo,
     ++							get_commit_tree(commit));
     ++				if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
     ++					commit->object.flags |= SHOWN;
     ++					show_edge(commit);
     ++				}
     ++				continue;
       			}
      -			continue;
     -+		} else {
      +			mark_edge_parents_uninteresting(commit, revs, show_edge);
       		}
      -		mark_edge_parents_uninteresting(commit, revs, show_edge);
       	}
     -+
     -+	if (sparse) {
     -+		mark_trees_uninteresting_sparse(revs->repo, &set);
     -+		oidset_clear(&set);
     -+	}
      +
       	if (revs->edge_hint_aggressive) {
       		for (i = 0; i < revs->cmdline.nr; i++) {
     @@ -193,17 +202,3 @@
       
       struct oidset;
       struct list_objects_filter_options;
     -
     -diff --git a/revision.c b/revision.c
     ---- a/revision.c
     -+++ b/revision.c
     -@@
     - 	while ((oid = oidset_iter_next(&iter))) {
     - 		struct tree *tree = lookup_tree(r, oid);
     - 
     -+		if (!tree)
     -+			continue;
     -+
     - 		if (tree->object.flags & UNINTERESTING) {
     - 			/*
     - 			 * Remove the flag so the next call
 3:  4ef318bdb2 = 3:  ab733daff5 pack-objects: add --sparse option
 4:  571b2e2784 ! 4:  c44172c35e revision: implement sparse algorithm
     @@ -6,8 +6,9 @@
          pack-objects --revs', we discover the "frontier" of commits
          that we care about and the boundary with commit we find
          uninteresting. From that point, we walk trees to discover which
     -    trees and blobs are uninteresting. Finally, we walk trees to find
     -    the interesting trees.
     +    trees and blobs are uninteresting. Finally, we walk trees from the
     +    interesting commits to find the interesting objects that are
     +    placed in the pack.
      
          This commit introduces a new, "sparse" way to discover the
          uninteresting trees. We use the perspective of a single user trying
     @@ -31,11 +32,13 @@
          parsing is UNINTERESTING.
      
          To actually improve the peformance, we need to terminate our
     -    recursion unless the oidset contains some intersting trees and
     -    some uninteresting trees. Technically, we only need one interesting
     -    tree for this to speed up in most cases, but we also will not mark
     -    anything UNINTERESTING if there are no uninteresting trees, so
     -    that would be wasted effort.
     +    recursion. If the oidset contains only UNINTERESTING trees, then
     +    we do not continue the recursion. This avoids walking trees that
     +    are likely to not be reachable from interesting trees. If the
     +    oidset contains only interesting trees, then we will walk these
     +    trees in the final stage that collects the intersting objects to
     +    place in the pack. Thus, we only recurse if the oidset contains
     +    both interesting and UNINITERESTING trees.
      
          There are a few ways that this is not a universally better option.
      
     @@ -108,51 +111,80 @@
      diff --git a/revision.c b/revision.c
      --- a/revision.c
      +++ b/revision.c
     +@@
     + #include "commit-reach.h"
     + #include "commit-graph.h"
     + #include "prio-queue.h"
     ++#include "hashmap.h"
     + 
     + volatile show_early_output_fn_t show_early_output;
     + 
      @@
       	mark_tree_contents_uninteresting(r, tree);
       }
       
     -+struct paths_and_oids {
     -+	struct string_list list;
     ++struct path_and_oids_entry {
     ++	struct hashmap_entry ent;
     ++	char *path;
     ++	struct oidset set;
      +};
      +
     -+static void paths_and_oids_init(struct paths_and_oids *po)
     ++static int path_and_oids_cmp(const void *hashmap_cmp_fn_data,
     ++			     const struct path_and_oids_entry *e1,
     ++			     const struct path_and_oids_entry *e2,
     ++			     const void *keydata)
     ++{
     ++	return strcmp(e1->path, e2->path);
     ++}
     ++
     ++int map_flags = 0;
     ++static void paths_and_oids_init(struct hashmap *map)
      +{
     -+	string_list_init(&po->list, 1);
     ++	hashmap_init(map, (hashmap_cmp_fn) path_and_oids_cmp, &map_flags, 0);
      +}
      +
     -+static void paths_and_oids_clear(struct paths_and_oids *po)
     ++static void paths_and_oids_clear(struct hashmap *map)
      +{
     -+	int i;
     -+	for (i = 0; i < po->list.nr; i++) {
     -+		oidset_clear(po->list.items[i].util);
     -+		free(po->list.items[i].util);
     ++	struct hashmap_iter iter;
     ++	struct path_and_oids_entry *entry;
     ++	hashmap_iter_init(map, &iter);
     ++
     ++	while ((entry = (struct path_and_oids_entry *)hashmap_iter_next(&iter))) {
     ++		oidset_clear(&entry->set);
     ++		free(entry->path);
      +	}
      +
     -+	string_list_clear(&po->list, 0);
     ++	hashmap_free(map, 1);
      +}
      +
     -+static void paths_and_oids_insert(struct paths_and_oids *po,
     ++static void paths_and_oids_insert(struct hashmap *map,
      +				  const char *path,
      +				  const struct object_id *oid)
      +{
     -+	struct string_list_item *item = string_list_insert(&po->list, path);
     -+	struct oidset *set;
     ++	int hash = strhash(path);
     ++	struct path_and_oids_entry key;
     ++	struct path_and_oids_entry *entry;
     ++
     ++	hashmap_entry_init(&key, hash);
     ++	key.path = xstrdup(path);
     ++	oidset_init(&key.set, 0);
      +
     -+	if (!item->util) {
     -+		set = xcalloc(1, sizeof(struct oidset));
     -+		oidset_init(set, 16);
     -+		item->util = set;
     ++	if (!(entry = (struct path_and_oids_entry *)hashmap_get(map, &key, NULL))) {
     ++		entry = xcalloc(1, sizeof(struct path_and_oids_entry));
     ++		hashmap_entry_init(entry, hash);
     ++		entry->path = key.path;
     ++		oidset_init(&entry->set, 16);
     ++		hashmap_put(map, entry);
      +	} else {
     -+		set = item->util;
     ++		free(key.path);
      +	}
      +
     -+	oidset_insert(set, oid);
     ++	oidset_insert(&entry->set, oid);
      +}
      +
      +static void add_children_by_path(struct repository *r,
      +				 struct tree *tree,
     -+				 struct paths_and_oids *po)
     ++				 struct hashmap *map)
      +{
      +	struct tree_desc desc;
      +	struct name_entry entry;
     @@ -167,7 +199,7 @@
      +	while (tree_entry(&desc, &entry)) {
      +		switch (object_type(entry.mode)) {
      +		case OBJ_TREE:
     -+			paths_and_oids_insert(po, entry.path, entry.oid);
     ++			paths_and_oids_insert(map, entry.path, entry.oid);
      +
      +			if (tree->object.flags & UNINTERESTING) {
      +				struct tree *child = lookup_tree(r, entry.oid);
     @@ -194,9 +226,10 @@
       void mark_trees_uninteresting_sparse(struct repository *r,
       				     struct oidset *set)
       {
     -+	int i;
      +	unsigned has_interesting = 0, has_uninteresting = 0;
     -+	struct paths_and_oids po;
     ++	struct hashmap map;
     ++	struct hashmap_iter map_iter;
     ++	struct path_and_oids_entry *entry;
       	struct object_id *oid;
       	struct oidset_iter iter;
       
     @@ -222,25 +255,25 @@
      +			has_uninteresting = 1;
      +		else
      +			has_interesting = 1;
     - 	}
     ++	}
      +
      +	/* Do not walk unless we have both types of trees. */
      +	if (!has_uninteresting || !has_interesting)
      +		return;
      +
     -+	paths_and_oids_init(&po);
     ++	paths_and_oids_init(&map);
      +
      +	oidset_iter_init(set, &iter);
      +	while ((oid = oidset_iter_next(&iter))) {
      +		struct tree *tree = lookup_tree(r, oid);
     -+		add_children_by_path(r, tree, &po);
     -+	}
     ++		add_children_by_path(r, tree, &map);
     + 	}
      +
     -+	for (i = 0; i < po.list.nr; i++)
     -+		mark_trees_uninteresting_sparse(
     -+			r, (struct oidset *)po.list.items[i].util);
     ++	hashmap_iter_init(&map, &map_iter);
     ++	while ((entry = hashmap_iter_next(&map_iter)))
     ++		mark_trees_uninteresting_sparse(r, &entry->set);
      +
     -+	paths_and_oids_clear(&po);
     ++	paths_and_oids_clear(&map);
       }
       
       struct commit_stack {
 5:  33d2c04dd6 = 5:  f386f6c3c9 pack-objects: create pack.useSparse setting
 6:  e4f29543ee = 6:  d011a9c1b1 pack-objects: create GIT_TEST_PACK_SPARSE

-- 
gitgitgadget
