Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C931A1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 22:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965100AbeFNWyq (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 18:54:46 -0400
Received: from mail-qk0-f202.google.com ([209.85.220.202]:44374 "EHLO
        mail-qk0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965093AbeFNWyp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 18:54:45 -0400
Received: by mail-qk0-f202.google.com with SMTP id m65-v6so6220283qkh.11
        for <git@vger.kernel.org>; Thu, 14 Jun 2018 15:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=i2xXfNVSVgTBzT2AB7wga/7vGp0Dv0J243u5uIt5qtA=;
        b=R/KYxtpYldKVz8LijPtJoF3DAHkUIcytCkxZNRnNEuOv5h7w4OJDKjgyGz8HnCvOc7
         GZFnwjKPr3ax+OyfUwspu0T8X9GgdAF/nanrzIbrYf7msE6eFsvZjIOq5XTa8NBxqTVZ
         i5CfeARIfpavv9fkKZgrfu8OR1JlSZ5c3U/m5gfQm7rVgWF6/gBTmT3mKp1iewYLM6bP
         x9AcMYomiIjpcmAOODn7xVeCtS4PwOizYTQ7MuPS6VsKuL996fJ9DlJ830gQoVQoKI+5
         eRjaNOTm1KDtEmvxj0oVeEb4Lgrs6i06FAhKZBmHS5dYNXj7B6hTdgrO3lqSF9l5J3+j
         QHnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=i2xXfNVSVgTBzT2AB7wga/7vGp0Dv0J243u5uIt5qtA=;
        b=h8ONcAdBZBtPR7BfeBlhBGpUhKCnp4GATGK2Bnlj/84dqY5MnzydQ0H9kpLy8t10Yc
         zkXoOmOM1xkplgPSTnWkTtP52hmbANMUd8cfmnQZktCCxxSwIWdPqu5V+DtID+wKTe3F
         hhQo1NKu0AiK33R/3/ZkvD+HyGO2Fhx71PRAdreAqfugaemlErvmI234QSfFCxqdMB/z
         hWrAo4EE9vzCvrxsPuIS+7GWCFPrQknWLz2o+Xq9DtmZMWCP2b7CAwR6cbcoPDMbSQb+
         ifG6MX1lu156CONmm9EMAYy/2ez0dI5bHb5/LHR1X0U8QcYyAjyxz9q1aNd7cpFDszE5
         /9fw==
X-Gm-Message-State: APt69E3HFrN+BQwSVcpgS/bTmTtdeTi1y2GfEF7ced/T+SSAowGunFZS
        TUrOLujihTn22ZsXiRVJNlXhHOzw5ppuZ3GvKHV4LB5brr/HGgMAPUc8xTEYHUbxOmw/7ppez3v
        ZLcqH6tG5zbYRvmK2+2v5uSCKivGMQ/Lh9PuyyuNYt0VZWmthqhUHCwSknWbyVLse/Z6fhnUtpT
        2x
X-Google-Smtp-Source: ADUXVKJ9Vxh+QjhZllNb2aB91L4/NhQQr3jemVAnEaX5KFdH3TxaaQyKvQyMxrOcAox0sXmdmSAfWXUTqJFc/CidekTz
MIME-Version: 1.0
X-Received: by 2002:a0c:8839:: with SMTP id 54-v6mr2322598qvl.24.1529016884270;
 Thu, 14 Jun 2018 15:54:44 -0700 (PDT)
Date:   Thu, 14 Jun 2018 15:54:26 -0700
In-Reply-To: <cover.1529016350.git.jonathantanmy@google.com>
Message-Id: <b868755fb9645194be672a03532170f125169944.1529016350.git.jonathantanmy@google.com>
References: <cover.1527894919.git.jonathantanmy@google.com> <cover.1529016350.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.17.0.582.gccdcbd54c4
Subject: [PATCH v3 5/7] fetch-pack: make negotiation-related vars local
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     bmwill@google.com, gitster@pobox.com,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reduce the number of global variables by making the priority queue and
the count of non-common commits in it local, passing them as a struct to
various functions where necessary.

This also helps in the case that fetch_pack() is invoked twice in the
same process (when tag following is required when using a transport that
does not support tag following), in that different priority queues will
now be used in each invocation, instead of reusing the possibly
non-empty one.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 fetch-pack.c | 116 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 47 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 806c40021..473e415c5 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -50,8 +50,12 @@ static int marked;
  */
 #define MAX_IN_VAIN 256
 
-static struct prio_queue rev_list = { compare_commits_by_commit_date };
-static int non_common_revs, multi_ack, use_sideband;
+struct negotiation_state {
+	struct prio_queue rev_list;
+	int non_common_revs;
+};
+
+static int multi_ack, use_sideband;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP_SHA1	01
 /* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
@@ -93,7 +97,9 @@ static void cache_one_alternate(const char *refname,
 	cache->items[cache->nr++] = obj;
 }
 
-static void for_each_cached_alternate(void (*cb)(struct object *))
+static void for_each_cached_alternate(struct negotiation_state *ns,
+				      void (*cb)(struct negotiation_state *,
+					         struct object *))
 {
 	static int initialized;
 	static struct alternate_object_cache cache;
@@ -105,10 +111,11 @@ static void for_each_cached_alternate(void (*cb)(struct object *))
 	}
 
 	for (i = 0; i < cache.nr; i++)
-		cb(cache.items[i]);
+		cb(ns, cache.items[i]);
 }
 
-static void rev_list_push(struct commit *commit, int mark)
+static void rev_list_push(struct negotiation_state *ns,
+			  struct commit *commit, int mark)
 {
 	if (!(commit->object.flags & mark)) {
 		commit->object.flags |= mark;
@@ -116,19 +123,21 @@ static void rev_list_push(struct commit *commit, int mark)
 		if (parse_commit(commit))
 			return;
 
-		prio_queue_put(&rev_list, commit);
+		prio_queue_put(&ns->rev_list, commit);
 
 		if (!(commit->object.flags & COMMON))
-			non_common_revs++;
+			ns->non_common_revs++;
 	}
 }
 
-static int rev_list_insert_ref(const char *refname, const struct object_id *oid)
+static int rev_list_insert_ref(struct negotiation_state *ns,
+			       const char *refname,
+			       const struct object_id *oid)
 {
 	struct object *o = deref_tag(parse_object(oid), refname, 0);
 
 	if (o && o->type == OBJ_COMMIT)
-		rev_list_push((struct commit *)o, SEEN);
+		rev_list_push(ns, (struct commit *)o, SEEN);
 
 	return 0;
 }
@@ -136,7 +145,7 @@ static int rev_list_insert_ref(const char *refname, const struct object_id *oid)
 static int rev_list_insert_ref_oid(const char *refname, const struct object_id *oid,
 				   int flag, void *cb_data)
 {
-	return rev_list_insert_ref(refname, oid);
+	return rev_list_insert_ref(cb_data, refname, oid);
 }
 
 static int clear_marks(const char *refname, const struct object_id *oid,
@@ -156,7 +165,7 @@ static int clear_marks(const char *refname, const struct object_id *oid,
    when only the server does not yet know that they are common).
 */
 
-static void mark_common(struct commit *commit,
+static void mark_common(struct negotiation_state *ns, struct commit *commit,
 		int ancestors_only, int dont_parse)
 {
 	if (commit != NULL && !(commit->object.flags & COMMON)) {
@@ -166,12 +175,12 @@ static void mark_common(struct commit *commit,
 			o->flags |= COMMON;
 
 		if (!(o->flags & SEEN))
-			rev_list_push(commit, SEEN);
+			rev_list_push(ns, commit, SEEN);
 		else {
 			struct commit_list *parents;
 
 			if (!ancestors_only && !(o->flags & POPPED))
-				non_common_revs--;
+				ns->non_common_revs--;
 			if (!o->parsed && !dont_parse)
 				if (parse_commit(commit))
 					return;
@@ -179,7 +188,8 @@ static void mark_common(struct commit *commit,
 			for (parents = commit->parents;
 					parents;
 					parents = parents->next)
-				mark_common(parents->item, 0, dont_parse);
+				mark_common(ns, parents->item, 0,
+					    dont_parse);
 		}
 	}
 }
@@ -188,7 +198,7 @@ static void mark_common(struct commit *commit,
   Get the next rev to send, ignoring the common.
 */
 
-static const struct object_id *get_rev(void)
+static const struct object_id *get_rev(struct negotiation_state *ns)
 {
 	struct commit *commit = NULL;
 
@@ -196,16 +206,16 @@ static const struct object_id *get_rev(void)
 		unsigned int mark;
 		struct commit_list *parents;
 
-		if (rev_list.nr == 0 || non_common_revs == 0)
+		if (ns->rev_list.nr == 0 || ns->non_common_revs == 0)
 			return NULL;
 
-		commit = prio_queue_get(&rev_list);
+		commit = prio_queue_get(&ns->rev_list);
 		parse_commit(commit);
 		parents = commit->parents;
 
 		commit->object.flags |= POPPED;
 		if (!(commit->object.flags & COMMON))
-			non_common_revs--;
+			ns->non_common_revs--;
 
 		if (commit->object.flags & COMMON) {
 			/* do not send "have", and ignore ancestors */
@@ -220,9 +230,9 @@ static const struct object_id *get_rev(void)
 
 		while (parents) {
 			if (!(parents->item->object.flags & SEEN))
-				rev_list_push(parents->item, mark);
+				rev_list_push(ns, parents->item, mark);
 			if (mark & COMMON)
-				mark_common(parents->item, 1, 0);
+				mark_common(ns, parents->item, 1, 0);
 			parents = parents->next;
 		}
 	}
@@ -296,9 +306,10 @@ static void send_request(struct fetch_pack_args *args,
 		write_or_die(fd, buf->buf, buf->len);
 }
 
-static void insert_one_alternate_object(struct object *obj)
+static void insert_one_alternate_object(struct negotiation_state *ns,
+					struct object *obj)
 {
-	rev_list_insert_ref(NULL, &obj->oid);
+	rev_list_insert_ref(ns, NULL, &obj->oid);
 }
 
 #define INITIAL_FLUSH 16
@@ -321,7 +332,8 @@ static int next_flush(int stateless_rpc, int count)
 	return count;
 }
 
-static int find_common(struct fetch_pack_args *args,
+static int find_common(struct negotiation_state *ns,
+		       struct fetch_pack_args *args,
 		       int fd[2], struct object_id *result_oid,
 		       struct ref *refs)
 {
@@ -337,8 +349,8 @@ static int find_common(struct fetch_pack_args *args,
 	if (args->stateless_rpc && multi_ack == 1)
 		die(_("--stateless-rpc requires multi_ack_detailed"));
 
-	for_each_ref(rev_list_insert_ref_oid, NULL);
-	for_each_cached_alternate(insert_one_alternate_object);
+	for_each_ref(rev_list_insert_ref_oid, ns);
+	for_each_cached_alternate(ns, insert_one_alternate_object);
 
 	fetching = 0;
 	for ( ; refs ; refs = refs->next) {
@@ -456,7 +468,7 @@ static int find_common(struct fetch_pack_args *args,
 	retval = -1;
 	if (args->no_dependents)
 		goto done;
-	while ((oid = get_rev())) {
+	while ((oid = get_rev(ns))) {
 		packet_buf_write(&req_buf, "have %s\n", oid_to_hex(oid));
 		print_verbose(args, "have %s", oid_to_hex(oid));
 		in_vain++;
@@ -514,7 +526,7 @@ static int find_common(struct fetch_pack_args *args,
 					} else if (!args->stateless_rpc
 						   || ack != ACK_common)
 						in_vain = 0;
-					mark_common(commit, 0, 1);
+					mark_common(ns, commit, 0, 1);
 					retval = 0;
 					got_continue = 1;
 					if (ack == ACK_ready)
@@ -704,7 +716,8 @@ static void filter_refs(struct fetch_pack_args *args,
 	*refs = newlist;
 }
 
-static void mark_alternate_complete(struct object *obj)
+static void mark_alternate_complete(struct negotiation_state *unused,
+				    struct object *obj)
 {
 	mark_complete(&obj->oid);
 }
@@ -741,7 +754,8 @@ static int add_loose_objects_to_set(const struct object_id *oid,
  * earliest commit time of the objects in refs that are commits and that we know
  * the commit time of.
  */
-static void mark_complete_and_common_ref(struct fetch_pack_args *args,
+static void mark_complete_and_common_ref(struct negotiation_state *ns,
+					 struct fetch_pack_args *args,
 					 struct ref **refs)
 {
 	struct ref *ref;
@@ -792,7 +806,7 @@ static void mark_complete_and_common_ref(struct fetch_pack_args *args,
 	if (!args->no_dependents) {
 		if (!args->deepen) {
 			for_each_ref(mark_complete_oid, NULL);
-			for_each_cached_alternate(mark_alternate_complete);
+			for_each_cached_alternate(NULL, mark_alternate_complete);
 			commit_list_sort_by_date(&complete);
 			if (cutoff)
 				mark_recent_complete_commits(args, cutoff);
@@ -810,9 +824,10 @@ static void mark_complete_and_common_ref(struct fetch_pack_args *args,
 				continue;
 
 			if (!(o->flags & SEEN)) {
-				rev_list_push((struct commit *)o, COMMON_REF | SEEN);
+				rev_list_push(ns, (struct commit *)o,
+					      COMMON_REF | SEEN);
 
-				mark_common((struct commit *)o, 1, 1);
+				mark_common(ns, (struct commit *)o, 1, 1);
 			}
 		}
 	}
@@ -995,6 +1010,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	struct object_id oid;
 	const char *agent_feature;
 	int agent_len;
+	struct negotiation_state ns = { { compare_commits_by_commit_date } };
 
 	sort_ref_list(&ref, ref_compare_name);
 	QSORT(sought, nr_sought, cmp_ref_by_name);
@@ -1070,13 +1086,13 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	if (marked)
 		for_each_ref(clear_marks, NULL);
 	marked = 1;
-	mark_complete_and_common_ref(args, &ref);
+	mark_complete_and_common_ref(&ns, args, &ref);
 	filter_refs(args, &ref, sought, nr_sought);
 	if (everything_local(args, &ref)) {
 		packet_flush(fd[1]);
 		goto all_done;
 	}
-	if (find_common(args, fd, &oid, ref) < 0)
+	if (find_common(&ns, args, fd, &oid, ref) < 0)
 		if (!args->keep_pack)
 			/* When cloning, it is not unusual to have
 			 * no common commit.
@@ -1096,7 +1112,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 		die(_("git fetch-pack: fetch failed."));
 
  all_done:
-	clear_prio_queue(&rev_list);
+	clear_prio_queue(&ns.rev_list);
 	return ref;
 }
 
@@ -1158,13 +1174,14 @@ static void add_common(struct strbuf *req_buf, struct oidset *common)
 	}
 }
 
-static int add_haves(struct strbuf *req_buf, int *haves_to_send, int *in_vain)
+static int add_haves(struct negotiation_state *ns, struct strbuf *req_buf,
+		     int *haves_to_send, int *in_vain)
 {
 	int ret = 0;
 	int haves_added = 0;
 	const struct object_id *oid;
 
-	while ((oid = get_rev())) {
+	while ((oid = get_rev(ns))) {
 		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
 		if (++haves_added >= *haves_to_send)
 			break;
@@ -1183,7 +1200,8 @@ static int add_haves(struct strbuf *req_buf, int *haves_to_send, int *in_vain)
 	return ret;
 }
 
-static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
+static int send_fetch_request(struct negotiation_state *ns, int fd_out,
+			      const struct fetch_pack_args *args,
 			      const struct ref *wants, struct oidset *common,
 			      int *haves_to_send, int *in_vain)
 {
@@ -1239,7 +1257,7 @@ static int send_fetch_request(int fd_out, const struct fetch_pack_args *args,
 		add_common(&req_buf, common);
 
 		/* Add initial haves */
-		ret = add_haves(&req_buf, haves_to_send, in_vain);
+		ret = add_haves(ns, &req_buf, haves_to_send, in_vain);
 	}
 
 	/* Send request */
@@ -1276,7 +1294,9 @@ static int process_section_header(struct packet_reader *reader,
 	return ret;
 }
 
-static int process_acks(struct packet_reader *reader, struct oidset *common)
+static int process_acks(struct negotiation_state *ns,
+			struct packet_reader *reader,
+			struct oidset *common)
 {
 	/* received */
 	int received_ready = 0;
@@ -1295,7 +1315,7 @@ static int process_acks(struct packet_reader *reader, struct oidset *common)
 				struct commit *commit;
 				oidset_insert(common, &oid);
 				commit = lookup_commit(&oid);
-				mark_common(commit, 0, 1);
+				mark_common(ns, commit, 0, 1);
 			}
 			continue;
 		}
@@ -1373,6 +1393,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct packet_reader reader;
 	int in_vain = 0;
 	int haves_to_send = INITIAL_FLUSH;
+	struct negotiation_state ns = { { compare_commits_by_commit_date } };
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE);
 
@@ -1393,18 +1414,19 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			marked = 1;
 
 			/* Filter 'ref' by 'sought' and those that aren't local */
-			mark_complete_and_common_ref(args, &ref);
+			mark_complete_and_common_ref(&ns, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);
 			if (everything_local(args, &ref))
 				state = FETCH_DONE;
 			else
 				state = FETCH_SEND_REQUEST;
 
-			for_each_ref(rev_list_insert_ref_oid, NULL);
-			for_each_cached_alternate(insert_one_alternate_object);
+			for_each_ref(rev_list_insert_ref_oid, &ns);
+			for_each_cached_alternate(&ns,
+						  insert_one_alternate_object);
 			break;
 		case FETCH_SEND_REQUEST:
-			if (send_fetch_request(fd[1], args, ref, &common,
+			if (send_fetch_request(&ns, fd[1], args, ref, &common,
 					       &haves_to_send, &in_vain))
 				state = FETCH_GET_PACK;
 			else
@@ -1412,7 +1434,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			break;
 		case FETCH_PROCESS_ACKS:
 			/* Process ACKs/NAKs */
-			switch (process_acks(&reader, &common)) {
+			switch (process_acks(&ns, &reader, &common)) {
 			case 2:
 				state = FETCH_GET_PACK;
 				break;
@@ -1441,7 +1463,7 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		}
 	}
 
-	clear_prio_queue(&rev_list);
+	clear_prio_queue(&ns.rev_list);
 	oidset_clear(&common);
 	return ref;
 }
-- 
2.17.0.582.gccdcbd54c4

