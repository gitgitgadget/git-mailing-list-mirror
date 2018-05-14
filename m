Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B27B21F406
	for <e@80x24.org>; Mon, 14 May 2018 21:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeENV4s (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:56:48 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:47052 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752116AbeENV4p (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:56:45 -0400
Received: by mail-qt0-f201.google.com with SMTP id v5-v6so16852145qto.13
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Ztc+xnV91e/Xd2NlyQjtufRPilUMMxBDEcAsgsenIzk=;
        b=hnLm3BofQjsb86UIQCucLBc+ZnK6A0po4Z95Ccx/U2ktZa0pvia/Esjr8ABQPH0jDt
         YIz3qgwzZsIBGtQZ9N4xYcep8Tp4bpF/vInMytU3jRZUcPlqlHoM6RzM9xPBzZ9/c8yn
         8jBLFbvvVI7G09VMzCiNB9RCxyKaC8drQJgusMfYX3+b7cb9f/xdhC/+qq3sgFf/NQp+
         4NgBlBHNEn7rRUhhe8R0uVPmZ9bFHxoRD/YzRwVLUcM7+RseuZgiDD5fZ6WEhqnf0HrR
         m9w/O8PZ92e2R6enf9BhWDUdXRv3QrbweOvmHc2iCWPiaT/vO0VgEx4HWIoWA1amZTir
         /Z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Ztc+xnV91e/Xd2NlyQjtufRPilUMMxBDEcAsgsenIzk=;
        b=PomxTA1h6ISP5/WvKmKpUIUE1NjddOTUNk2SVgR0zwIP+N0JVOqdyOcV419dNuYt8x
         0lnrCCSX+tLXTtkdnLH2Pl9gDgsT1vqXeA58b+VaUvU7p2YxjRe00aXlL3sR7XwMDF3y
         5CIHjZPOyj2sTIuPqxjFsHqcG2qTGm+12BwrZaOedmQeympfK/MaWzToJoKVfs2LzKPn
         q0iWUwOzG4PkkMsSnARdIhX2xKo8maYaWZfC7R0cHY8oRago1rqNXBbHNDvnMhgr/1fp
         pvBP8tlbr7jAqviB03xID9kauXZiYuVHBLIefIP43wv3PCxgnl/daSvpB1DYt+H3sNiX
         cBsw==
X-Gm-Message-State: ALKqPwdm/Dn4cgrGXHNOFliVnTvU6CphvlujTnVXquXneJ31iGP5uSNe
        Q97T3LYbtPrl6vPdKUV79HvJVKh3vXMipd+4UU9S89xdtfqFUu95J734No1lRjq58hyp2IqBrAY
        8YhkIjkp6BOx1L4FhkE5Dsp+fjtxq+YoGoogEozGHdQbwA6Z2RkhumRTP8g==
X-Google-Smtp-Source: AB8JxZpOm8fJNSfWlgM925IjgvrHrUuz/giaJB5eZ/xVU1yesXcf3vJV+Mp84i3oToaanxIC/2PRzAYqjho=
MIME-Version: 1.0
X-Received: by 2002:ac8:2999:: with SMTP id 25-v6mr17872401qts.1.1526335004295;
 Mon, 14 May 2018 14:56:44 -0700 (PDT)
Date:   Mon, 14 May 2018 14:55:54 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-4-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 03/35] refspec: rename struct refspec to struct refspec_item
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In preperation for introducing an abstraction around a collection of
refspecs (much like how a 'struct pathspec' is a collection of 'struct
pathspec_item's) rename the existing 'struct refspec' to 'struct
refspec_item'.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 branch.c                    |  6 ++---
 builtin/clone.c             |  4 +--
 builtin/fast-export.c       |  4 +--
 builtin/fetch.c             | 12 ++++-----
 builtin/pull.c              |  2 +-
 builtin/push.c              |  4 +--
 builtin/remote.c            |  8 +++---
 builtin/submodule--helper.c |  4 +--
 checkout.c                  |  4 +--
 refspec.c                   | 19 +++++++-------
 refspec.h                   | 10 ++++----
 remote.c                    | 50 ++++++++++++++++++-------------------
 remote.h                    | 16 ++++++------
 transport-helper.c          |  2 +-
 transport.c                 |  4 +--
 15 files changed, 74 insertions(+), 75 deletions(-)

diff --git a/branch.c b/branch.c
index 32ccefc6b..f967c98f6 100644
--- a/branch.c
+++ b/branch.c
@@ -9,7 +9,7 @@
 #include "worktree.h"
 
 struct tracking {
-	struct refspec spec;
+	struct refspec_item spec;
 	char *src;
 	const char *remote;
 	int matches;
@@ -219,8 +219,8 @@ int validate_new_branchname(const char *name, struct strbuf *ref, int force)
 static int check_tracking_branch(struct remote *remote, void *cb_data)
 {
 	char *tracking_branch = cb_data;
-	struct refspec query;
-	memset(&query, 0, sizeof(struct refspec));
+	struct refspec_item query;
+	memset(&query, 0, sizeof(struct refspec_item));
 	query.dst = tracking_branch;
 	return !remote_find_tracking(remote, &query);
 }
diff --git a/builtin/clone.c b/builtin/clone.c
index 6d1614ed3..854088a3a 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -547,7 +547,7 @@ static struct ref *find_remote_branch(const struct ref *refs, const char *branch
 }
 
 static struct ref *wanted_peer_refs(const struct ref *refs,
-		struct refspec *refspec)
+		struct refspec_item *refspec)
 {
 	struct ref *head = copy_ref(find_ref_by_name(refs, "HEAD"));
 	struct ref *local_refs = head;
@@ -895,7 +895,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	int err = 0, complete_refs_before_fetch = 1;
 	int submodule_progress;
 
-	struct refspec *refspec;
+	struct refspec_item *refspec;
 	const char *fetch_pattern;
 
 	fetch_if_missing = 0;
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a13b7c8ef..6f105dc79 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -36,7 +36,7 @@ static int use_done_feature;
 static int no_data;
 static int full_tree;
 static struct string_list extra_refs = STRING_LIST_INIT_NODUP;
-static struct refspec *refspecs;
+static struct refspec_item *refspecs;
 static int refspecs_nr;
 static int anonymize;
 
@@ -979,7 +979,7 @@ static void handle_deletes(void)
 {
 	int i;
 	for (i = 0; i < refspecs_nr; i++) {
-		struct refspec *refspec = &refspecs[i];
+		struct refspec_item *refspec = &refspecs[i];
 		if (*refspec->src)
 			continue;
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 1fce68e9a..745020a10 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -203,7 +203,7 @@ static void add_merge_config(struct ref **head,
 
 	for (i = 0; i < branch->merge_nr; i++) {
 		struct ref *rm, **old_tail = *tail;
-		struct refspec refspec;
+		struct refspec_item refspec;
 
 		for (rm = *head; rm; rm = rm->next) {
 			if (branch_merge_matches(branch, i, rm->name)) {
@@ -340,7 +340,7 @@ static void find_non_local_tags(struct transport *transport,
 }
 
 static struct ref *get_ref_map(struct transport *transport,
-			       struct refspec *refspecs, int refspec_count,
+			       struct refspec_item *refspecs, int refspec_count,
 			       int tags, int *autotags)
 {
 	int i;
@@ -371,7 +371,7 @@ static struct ref *get_ref_map(struct transport *transport,
 	argv_array_clear(&ref_prefixes);
 
 	if (refspec_count) {
-		struct refspec *fetch_refspec;
+		struct refspec_item *fetch_refspec;
 		int fetch_refspec_nr;
 
 		for (i = 0; i < refspec_count; i++) {
@@ -965,7 +965,7 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 	return ret;
 }
 
-static int prune_refs(struct refspec *refs, int ref_count, struct ref *ref_map,
+static int prune_refs(struct refspec_item *refs, int ref_count, struct ref *ref_map,
 		const char *raw_url)
 {
 	int url_len, i, result = 0;
@@ -1115,7 +1115,7 @@ static void backfill_tags(struct transport *transport, struct ref *ref_map)
 }
 
 static int do_fetch(struct transport *transport,
-		    struct refspec *refs, int ref_count)
+		    struct refspec_item *refs, int ref_count)
 {
 	struct string_list existing_refs = STRING_LIST_INIT_DUP;
 	struct ref *ref_map;
@@ -1357,7 +1357,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 static int fetch_one(struct remote *remote, int argc, const char **argv, int prune_tags_ok)
 {
 	static const char **refs = NULL;
-	struct refspec *refspec;
+	struct refspec_item *refspec;
 	int ref_nr = 0;
 	int j = 0;
 	int exit_code;
diff --git a/builtin/pull.c b/builtin/pull.c
index 6247c956d..5a79deae5 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -676,7 +676,7 @@ static const char *get_upstream_branch(const char *remote)
  */
 static const char *get_tracking_branch(const char *remote, const char *refspec)
 {
-	struct refspec *spec;
+	struct refspec_item *spec;
 	const char *spec_src;
 	const char *merge_branch;
 
diff --git a/builtin/push.c b/builtin/push.c
index fa65999b2..00d81fb1d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -80,8 +80,8 @@ static const char *map_refspec(const char *ref,
 		return ref;
 
 	if (remote->push) {
-		struct refspec query;
-		memset(&query, 0, sizeof(struct refspec));
+		struct refspec_item query;
+		memset(&query, 0, sizeof(struct refspec_item));
 		query.src = matched->name;
 		if (!query_refspecs(remote->push, remote->push_refspec_nr, &query) &&
 		    query.dst) {
diff --git a/builtin/remote.c b/builtin/remote.c
index c49513995..d9da82dc8 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -442,7 +442,7 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 		info->dest = xstrdup(item->string);
 	}
 	for (i = 0; i < remote->push_refspec_nr; i++) {
-		struct refspec *spec = remote->push + i;
+		struct refspec_item *spec = remote->push + i;
 		if (spec->matching)
 			item = string_list_append(&states->push, _("(matching)"));
 		else if (strlen(spec->src))
@@ -462,7 +462,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
 {
 	struct ref *ref, *matches;
 	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
-	struct refspec refspec;
+	struct refspec_item refspec;
 
 	refspec.force = 0;
 	refspec.pattern = 1;
@@ -515,7 +515,7 @@ static int add_branch_for_removal(const char *refname,
 	const struct object_id *oid, int flags, void *cb_data)
 {
 	struct branches_for_remote *branches = cb_data;
-	struct refspec refspec;
+	struct refspec_item refspec;
 	struct known_remote *kr;
 
 	memset(&refspec, 0, sizeof(refspec));
@@ -834,7 +834,7 @@ static int append_ref_to_tracked_list(const char *refname,
 	const struct object_id *oid, int flags, void *cb_data)
 {
 	struct ref_states *states = cb_data;
-	struct refspec refspec;
+	struct refspec_item refspec;
 
 	if (flags & REF_ISSYMREF)
 		return 0;
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6ab032acb..c0c4db007 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1746,11 +1746,11 @@ static int push_check(int argc, const char **argv, const char *prefix)
 	if (argc > 2) {
 		int i, refspec_nr = argc - 2;
 		struct ref *local_refs = get_local_heads();
-		struct refspec *refspec = parse_push_refspec(refspec_nr,
+		struct refspec_item *refspec = parse_push_refspec(refspec_nr,
 							     argv + 2);
 
 		for (i = 0; i < refspec_nr; i++) {
-			struct refspec *rs = refspec + i;
+			struct refspec_item *rs = refspec + i;
 
 			if (rs->pattern || rs->matching)
 				continue;
diff --git a/checkout.c b/checkout.c
index 193ba8567..bdefc888b 100644
--- a/checkout.c
+++ b/checkout.c
@@ -13,8 +13,8 @@ struct tracking_name_data {
 static int check_tracking_name(struct remote *remote, void *cb_data)
 {
 	struct tracking_name_data *cb = cb_data;
-	struct refspec query;
-	memset(&query, 0, sizeof(struct refspec));
+	struct refspec_item query;
+	memset(&query, 0, sizeof(struct refspec_item));
 	query.src = cb->src_ref;
 	if (remote_find_tracking(remote, &query) ||
 	    get_oid(query.dst, cb->dst_oid)) {
diff --git a/refspec.c b/refspec.c
index 3cfcbd37d..cef513ad8 100644
--- a/refspec.c
+++ b/refspec.c
@@ -2,7 +2,7 @@
 #include "refs.h"
 #include "refspec.h"
 
-static struct refspec s_tag_refspec = {
+static struct refspec_item s_tag_refspec = {
 	0,
 	1,
 	0,
@@ -12,13 +12,13 @@ static struct refspec s_tag_refspec = {
 };
 
 /* See TAG_REFSPEC for the string version */
-const struct refspec *tag_refspec = &s_tag_refspec;
+const struct refspec_item *tag_refspec = &s_tag_refspec;
 
 /*
  * Parses 'refspec' and populates 'rs'.  returns 1 if successful and 0 if the
  * refspec is invalid.
  */
-static int parse_refspec(struct refspec *rs, const char *refspec, int fetch)
+static int parse_refspec(struct refspec_item *rs, const char *refspec, int fetch)
 {
 	size_t llen;
 	int is_glob;
@@ -121,10 +121,10 @@ static int parse_refspec(struct refspec *rs, const char *refspec, int fetch)
 	return 1;
 }
 
-static struct refspec *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
+static struct refspec_item *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
 {
 	int i;
-	struct refspec *rs = xcalloc(nr_refspec, sizeof(*rs));
+	struct refspec_item *rs = xcalloc(nr_refspec, sizeof(*rs));
 
 	for (i = 0; i < nr_refspec; i++) {
 		if (!parse_refspec(&rs[i], refspec[i], fetch))
@@ -148,24 +148,24 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 
 int valid_fetch_refspec(const char *fetch_refspec_str)
 {
-	struct refspec *refspec;
+	struct refspec_item *refspec;
 
 	refspec = parse_refspec_internal(1, &fetch_refspec_str, 1, 1);
 	free_refspec(1, refspec);
 	return !!refspec;
 }
 
-struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec)
+struct refspec_item *parse_fetch_refspec(int nr_refspec, const char **refspec)
 {
 	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
 }
 
-struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
+struct refspec_item *parse_push_refspec(int nr_refspec, const char **refspec)
 {
 	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
 }
 
-void free_refspec(int nr_refspec, struct refspec *refspec)
+void free_refspec(int nr_refspec, struct refspec_item *refspec)
 {
 	int i;
 
@@ -178,4 +178,3 @@ void free_refspec(int nr_refspec, struct refspec *refspec)
 	}
 	free(refspec);
 }
-
diff --git a/refspec.h b/refspec.h
index b1db91918..173cea882 100644
--- a/refspec.h
+++ b/refspec.h
@@ -2,9 +2,9 @@
 #define REFSPEC_H
 
 #define TAG_REFSPEC "refs/tags/*:refs/tags/*"
-const struct refspec *tag_refspec;
+const struct refspec_item *tag_refspec;
 
-struct refspec {
+struct refspec_item {
 	unsigned force : 1;
 	unsigned pattern : 1;
 	unsigned matching : 1;
@@ -15,9 +15,9 @@ struct refspec {
 };
 
 int valid_fetch_refspec(const char *refspec);
-struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
-struct refspec *parse_push_refspec(int nr_refspec, const char **refspec);
+struct refspec_item *parse_fetch_refspec(int nr_refspec, const char **refspec);
+struct refspec_item *parse_push_refspec(int nr_refspec, const char **refspec);
 
-void free_refspec(int nr_refspec, struct refspec *refspec);
+void free_refspec(int nr_refspec, struct refspec_item *refspec);
 
 #endif /* REFSPEC_H */
diff --git a/remote.c b/remote.c
index 4d67c061a..89820c476 100644
--- a/remote.c
+++ b/remote.c
@@ -97,7 +97,7 @@ void add_prune_tags_to_fetch_refspec(struct remote *remote)
 {
 	int nr = remote->fetch_refspec_nr;
 	int bufsize = nr  + 1;
-	int size = sizeof(struct refspec);
+	int size = sizeof(struct refspec_item);
 
 	remote->fetch = xrealloc(remote->fetch, size  * bufsize);
 	memcpy(&remote->fetch[nr], tag_refspec, size);
@@ -724,7 +724,7 @@ static int match_name_with_pattern(const char *key, const char *name,
 	return ret;
 }
 
-static void query_refspecs_multiple(struct refspec *refs, int ref_count, struct refspec *query, struct string_list *results)
+static void query_refspecs_multiple(struct refspec_item *refs, int ref_count, struct refspec_item *query, struct string_list *results)
 {
 	int i;
 	int find_src = !query->src;
@@ -733,7 +733,7 @@ static void query_refspecs_multiple(struct refspec *refs, int ref_count, struct
 		error("query_refspecs_multiple: need either src or dst");
 
 	for (i = 0; i < ref_count; i++) {
-		struct refspec *refspec = &refs[i];
+		struct refspec_item *refspec = &refs[i];
 		const char *key = find_src ? refspec->dst : refspec->src;
 		const char *value = find_src ? refspec->src : refspec->dst;
 		const char *needle = find_src ? query->dst : query->src;
@@ -750,7 +750,7 @@ static void query_refspecs_multiple(struct refspec *refs, int ref_count, struct
 	}
 }
 
-int query_refspecs(struct refspec *refs, int ref_count, struct refspec *query)
+int query_refspecs(struct refspec_item *refs, int ref_count, struct refspec_item *query)
 {
 	int i;
 	int find_src = !query->src;
@@ -761,7 +761,7 @@ int query_refspecs(struct refspec *refs, int ref_count, struct refspec *query)
 		return error("query_refspecs: need either src or dst");
 
 	for (i = 0; i < ref_count; i++) {
-		struct refspec *refspec = &refs[i];
+		struct refspec_item *refspec = &refs[i];
 		const char *key = find_src ? refspec->dst : refspec->src;
 		const char *value = find_src ? refspec->src : refspec->dst;
 
@@ -781,12 +781,12 @@ int query_refspecs(struct refspec *refs, int ref_count, struct refspec *query)
 	return -1;
 }
 
-char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
+char *apply_refspecs(struct refspec_item *refspecs, int nr_refspec,
 		     const char *name)
 {
-	struct refspec query;
+	struct refspec_item query;
 
-	memset(&query, 0, sizeof(struct refspec));
+	memset(&query, 0, sizeof(struct refspec_item));
 	query.src = (char *)name;
 
 	if (query_refspecs(refspecs, nr_refspec, &query))
@@ -795,7 +795,7 @@ char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
 	return query.dst;
 }
 
-int remote_find_tracking(struct remote *remote, struct refspec *refspec)
+int remote_find_tracking(struct remote *remote, struct refspec_item *refspec)
 {
 	return query_refspecs(remote->fetch, remote->fetch_refspec_nr, refspec);
 }
@@ -1004,7 +1004,7 @@ static char *guess_ref(const char *name, struct ref *peer)
 }
 
 static int match_explicit_lhs(struct ref *src,
-			      struct refspec *rs,
+			      struct refspec_item *rs,
 			      struct ref **match,
 			      int *allocated_match)
 {
@@ -1030,7 +1030,7 @@ static int match_explicit_lhs(struct ref *src,
 
 static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
-			  struct refspec *rs)
+			  struct refspec_item *rs)
 {
 	struct ref *matched_src, *matched_dst;
 	int allocated_src;
@@ -1099,7 +1099,7 @@ static int match_explicit(struct ref *src, struct ref *dst,
 }
 
 static int match_explicit_refs(struct ref *src, struct ref *dst,
-			       struct ref ***dst_tail, struct refspec *rs,
+			       struct ref ***dst_tail, struct refspec_item *rs,
 			       int rs_nr)
 {
 	int i, errs;
@@ -1108,10 +1108,10 @@ static int match_explicit_refs(struct ref *src, struct ref *dst,
 	return errs;
 }
 
-static char *get_ref_match(const struct refspec *rs, int rs_nr, const struct ref *ref,
-		int send_mirror, int direction, const struct refspec **ret_pat)
+static char *get_ref_match(const struct refspec_item *rs, int rs_nr, const struct ref *ref,
+		int send_mirror, int direction, const struct refspec_item **ret_pat)
 {
-	const struct refspec *pat;
+	const struct refspec_item *pat;
 	char *name;
 	int i;
 	int matching_refs = -1;
@@ -1282,12 +1282,12 @@ static void prepare_ref_index(struct string_list *ref_index, struct ref *ref)
  */
 int check_push_refs(struct ref *src, int nr_refspec, const char **refspec_names)
 {
-	struct refspec *refspec = parse_push_refspec(nr_refspec, refspec_names);
+	struct refspec_item *refspec = parse_push_refspec(nr_refspec, refspec_names);
 	int ret = 0;
 	int i;
 
 	for (i = 0; i < nr_refspec; i++) {
-		struct refspec *rs = refspec + i;
+		struct refspec_item *rs = refspec + i;
 
 		if (rs->pattern || rs->matching)
 			continue;
@@ -1310,7 +1310,7 @@ int check_push_refs(struct ref *src, int nr_refspec, const char **refspec_names)
 int match_push_refs(struct ref *src, struct ref **dst,
 		    int nr_refspec, const char **refspec, int flags)
 {
-	struct refspec *rs;
+	struct refspec_item *rs;
 	int send_all = flags & MATCH_REFS_ALL;
 	int send_mirror = flags & MATCH_REFS_MIRROR;
 	int send_prune = flags & MATCH_REFS_PRUNE;
@@ -1330,7 +1330,7 @@ int match_push_refs(struct ref *src, struct ref **dst,
 	for (ref = src; ref; ref = ref->next) {
 		struct string_list_item *dst_item;
 		struct ref *dst_peer;
-		const struct refspec *pat = NULL;
+		const struct refspec_item *pat = NULL;
 		char *dst_name;
 
 		dst_name = get_ref_match(rs, nr_refspec, ref, send_mirror, FROM_SRC, &pat);
@@ -1686,7 +1686,7 @@ static int ignore_symref_update(const char *refname)
  * local symbolic ref.
  */
 static struct ref *get_expanded_map(const struct ref *remote_refs,
-				    const struct refspec *refspec)
+				    const struct refspec_item *refspec)
 {
 	const struct ref *ref;
 	struct ref *ret = NULL;
@@ -1751,7 +1751,7 @@ static struct ref *get_local_ref(const char *name)
 }
 
 int get_fetch_map(const struct ref *remote_refs,
-		  const struct refspec *refspec,
+		  const struct refspec_item *refspec,
 		  struct ref ***tail,
 		  int missing_ok)
 {
@@ -2089,7 +2089,7 @@ struct ref *guess_remote_head(const struct ref *head,
 struct stale_heads_info {
 	struct string_list *ref_names;
 	struct ref **stale_refs_tail;
-	struct refspec *refs;
+	struct refspec_item *refs;
 	int ref_count;
 };
 
@@ -2098,9 +2098,9 @@ static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
 {
 	struct stale_heads_info *info = cb_data;
 	struct string_list matches = STRING_LIST_INIT_DUP;
-	struct refspec query;
+	struct refspec_item query;
 	int i, stale = 1;
-	memset(&query, 0, sizeof(struct refspec));
+	memset(&query, 0, sizeof(struct refspec_item));
 	query.dst = (char *)refname;
 
 	query_refspecs_multiple(info->refs, info->ref_count, &query, &matches);
@@ -2131,7 +2131,7 @@ static int get_stale_heads_cb(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fetch_map)
+struct ref *get_stale_heads(struct refspec_item *refs, int ref_count, struct ref *fetch_map)
 {
 	struct ref *ref, *stale_refs = NULL;
 	struct string_list ref_names = STRING_LIST_INIT_NODUP;
diff --git a/remote.h b/remote.h
index 386ced901..3657bd43d 100644
--- a/remote.h
+++ b/remote.h
@@ -28,12 +28,12 @@ struct remote {
 	int pushurl_alloc;
 
 	const char **push_refspec;
-	struct refspec *push;
+	struct refspec_item *push;
 	int push_refspec_nr;
 	int push_refspec_alloc;
 
 	const char **fetch_refspec;
-	struct refspec *fetch;
+	struct refspec_item *fetch;
 	int fetch_refspec_nr;
 	int fetch_refspec_alloc;
 
@@ -163,8 +163,8 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
-extern int query_refspecs(struct refspec *specs, int nr, struct refspec *query);
-char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
+extern int query_refspecs(struct refspec_item *specs, int nr, struct refspec_item *query);
+char *apply_refspecs(struct refspec_item *refspecs, int nr_refspec,
 		     const char *name);
 
 int check_push_refs(struct ref *src, int nr_refspec, const char **refspec);
@@ -185,7 +185,7 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
  * missing_ok is usually false, but when we are adding branch.$name.merge
  * it is Ok if the branch is not at the remote anymore.
  */
-int get_fetch_map(const struct ref *remote_refs, const struct refspec *refspec,
+int get_fetch_map(const struct ref *remote_refs, const struct refspec_item *refspec,
 		  struct ref ***tail, int missing_ok);
 
 struct ref *get_remote_ref(const struct ref *remote_refs, const char *name);
@@ -193,7 +193,7 @@ struct ref *get_remote_ref(const struct ref *remote_refs, const char *name);
 /*
  * For the given remote, reads the refspec's src and sets the other fields.
  */
-int remote_find_tracking(struct remote *remote, struct refspec *refspec);
+int remote_find_tracking(struct remote *remote, struct refspec_item *refspec);
 
 struct branch {
 	const char *name;
@@ -203,7 +203,7 @@ struct branch {
 	const char *pushremote_name;
 
 	const char **merge_name;
-	struct refspec **merge;
+	struct refspec_item **merge;
 	int merge_nr;
 	int merge_alloc;
 
@@ -272,7 +272,7 @@ struct ref *guess_remote_head(const struct ref *head,
 			      int all);
 
 /* Return refs which no longer exist on remote */
-struct ref *get_stale_heads(struct refspec *refs, int ref_count, struct ref *fetch_map);
+struct ref *get_stale_heads(struct refspec_item *refs, int ref_count, struct ref *fetch_map);
 
 /*
  * Compare-and-swap
diff --git a/transport-helper.c b/transport-helper.c
index b99e1cce9..b156a37e7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -36,7 +36,7 @@ struct helper_data {
 	char *export_marks;
 	char *import_marks;
 	/* These go from remote name (as in "list") to private name */
-	struct refspec *refspecs;
+	struct refspec_item *refspecs;
 	int refspec_nr;
 	/* Transport options for fetch-pack/send-pack (should one of
 	 * those be invoked).
diff --git a/transport.c b/transport.c
index 2cf63d18b..3ad4d37dc 100644
--- a/transport.c
+++ b/transport.c
@@ -390,7 +390,7 @@ int transport_refs_pushed(struct ref *ref)
 
 void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int verbose)
 {
-	struct refspec rs;
+	struct refspec_item rs;
 
 	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
 		return;
@@ -1111,7 +1111,7 @@ int transport_push(struct transport *transport,
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
 		int pretend = flags & TRANSPORT_PUSH_DRY_RUN;
 		int push_ret, ret, err;
-		struct refspec *tmp_rs;
+		struct refspec_item *tmp_rs;
 		struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 		int i;
 
-- 
2.17.0.441.gb46fe60e1d-goog

