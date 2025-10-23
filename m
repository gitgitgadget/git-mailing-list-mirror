Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3312C15BC
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203785; cv=none; b=np7doW4V2MSFJ/CA4Xgqqq5mDNI/QE8Av5YsfOURpWliPlFNDAUileiEK+82r6R2xUQf/TL3YuJe25SZOr3/iCQQcBm4q5RlPwlZUU8boeQB6hPbDqPQ5vUv2becN4LU1p4caCZag3IUsEM07/eszQTJkxo6vMIx0LSfdUw7uSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203785; c=relaxed/simple;
	bh=S94zD/+6LVRUrs1URPwi6fRTrE2t/hyD8uHPDqkSx9A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjW53/ehKzPSCsgn6F+n328CfHehFqY1GyJUbFyq+g0FgajlkI/gJi00l8sKxIRjfLNFaUrirbtZ35c7XKFAr1gJ+Y//rWbLauGoEU7WBtppbD4/91jSgrUFcIMPTeSB6qN46eFVaTuxw8XCi8mebq1cVpwl6hdxJGP19lnb4VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=li9FjKQy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sruIV6vR; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="li9FjKQy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sruIV6vR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0FD4D14001BB;
	Thu, 23 Oct 2025 03:16:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 23 Oct 2025 03:16:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761203780;
	 x=1761290180; bh=BGPAPfmdIk2AGjwqDvAXyruVchzldwV0ezMd+3qs5vs=; b=
	li9FjKQycDenmUoNTwgQI9t47+lqGCVZiJ435X+5XuqZO7TaH7WzEldSC4TdLxba
	6LnqGGMufdMj1PqCkeXpNTl8l1qegyH0oIZLYP5xOBxe1XcRBYzoqIdrygcv3CvH
	N196jyw8UlooIX3LV/IdmLASHjZ/kcnP2GZs3Q7gOaRaxkZ8y8mG2j9dvMR0ulHy
	9tkyvmNz9kuYAdSHylOIT2AGOVF3Z6K2rjW4tK80BQ3VNb/Klggpc5h0CNy8KSYV
	rlp0RHaLgpi/T+cqC2NcxLIIoS3FbBKx3m5BAjyBVo3ZPASqihcjvf7sw6IfA06G
	ng3mkkFq8cUqXDDQ9y07IQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761203780; x=
	1761290180; bh=BGPAPfmdIk2AGjwqDvAXyruVchzldwV0ezMd+3qs5vs=; b=s
	ruIV6vRXRiXKxVh5PZeiY1XrHHvasv/f28SL2YWHQSEYP9L3UXx8PpA6wUt2c2vR
	QWAvWcgygMO7QQKCstMxWhVO/SVQHL4QRze81UtOER+yrDSZrdr1isTZiPf+/NXJ
	7K7+1kp1wmssdyc4GI6fgBzTmQUFCkdg0cmv5yAMSGqyl7JcwVqe/LuvhuLUfyam
	ok5bsARDHRX1g1yevMYADZvkudyX7JusxZTzIqeBR+ROzH7CgUmEMP9qzOCakvBU
	r2N0O8RLF5hikqNKLxWFispcP3H1GCYijJKKpyA/2HertzG7q1JPStxZtNXGs2Te
	aW+0dqLhxvWc8qpo9q5Gg==
X-ME-Sender: <xms:Q9b5aNK-H5YY4uWy-usJIwDfkpNDOUOZyxWN5CCeFbSZdj3cmtk9bQ>
    <xme:Q9b5aM0s_m2j4cJ2UEzQwVYaAG2zyoCu7pfZWrnT1FSs-xH3jEVpjUKalr0l6k6c5
    BPFyp1YrMgqUDtlyFx7CSSiCJg0jYto1vbVkFAwFE_Ks3uiCMxOWwI>
X-ME-Received: <xmr:Q9b5aPibOI116i1DbiDvBjMf8Keq5rFkdiYqreOKunQYxwh1437qKp8--3k3dXkICfMoC7FLSvjChxiRv5R7LNsdkxMkSAJOq0sTfP7N0B7vKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeehkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Q9b5aFWoyLmx7jyNlVetaenuRQAMs4VCQcCUBfpMUWhpY5woTbIZRQ>
    <xmx:Q9b5aGXZfaysP-_trcgo_1K3CFsO4o-emSZ4q7bN63574v6VUhq9TA>
    <xmx:Q9b5aNhsMhHBKii4CxR6scceMhpLUEio2Bygca35umRBaRxVhVTChQ>
    <xmx:Q9b5aJbealV1GvH3lWTpmLHaZhoCc9uKm12KhiTVscpxEx5VPlnm5Q>
    <xmx:RNb5aOF4N30r44VmFd6lxYzBTsaCyBj3bxVZBvW1wzRkPFsKLr7Xatr5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 03:16:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c6f3604 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 23 Oct 2025 07:16:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 23 Oct 2025 09:16:10 +0200
Subject: [PATCH v4 01/14] refs: introduce wrapper struct for `each_ref_fn`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-1-2be68ce82c9a@pks.im>
References: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
In-Reply-To: <20251023-b4-pks-ref-filter-skip-parsing-objects-v4-0-2be68ce82c9a@pks.im>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>, 
 Junio C Hamano <gitster@pobox.com>, Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.14.3

The `each_ref_fn` callback function type is used across our code base
for several different functions that iterate through reference. There's
a bunch of callbacks implementing this type, which makes any changes to
the callback signature extremely noisy. An example of the required churn
is e8207717f1 (refs: add referent to each_ref_fn, 2024-08-09): adding a
single argument required us to change 48 files.

It was already proposed back then [1] that we might want to introduce a
wrapper structure to alleviate the pain going forward. While this of
course requires the same kind of global refactoring as just introducing
a new parameter, it at least allows us to more change the callback type
afterwards by just extending the wrapper structure.

One counterargument to this refactoring is that it makes the structure
more opaque. While it is obvious which callsites need to be fixed up
when we change the function type, it's not obvious anymore once we use
a structure. That being said, we only have a handful of sites that
actually need to populate this wrapper structure: our ref backends,
"refs/iterator.c" as well as very few sites that invoke the iterator
callback functions directly.

Introduce this wrapper structure so that we can adapt the iterator
interfaces more readily.

[1]: <ZmarVcF5JjsZx0dl@tanuki>

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c                    | 24 +++++++---------
 builtin/bisect.c            | 17 ++++--------
 builtin/checkout.c          |  6 ++--
 builtin/describe.c          | 18 ++++++------
 builtin/fetch.c             | 13 +++------
 builtin/fsck.c              | 33 ++++++++++++----------
 builtin/gc.c                | 15 ++++------
 builtin/name-rev.c          | 17 ++++++------
 builtin/pack-objects.c      | 27 ++++++++----------
 builtin/receive-pack.c      | 13 ++++-----
 builtin/remote.c            | 44 +++++++++++++----------------
 builtin/replace.c           | 21 ++++++--------
 builtin/repo.c              |  9 ++----
 builtin/rev-parse.c         | 12 ++++----
 builtin/show-branch.c       | 35 +++++++++++------------
 builtin/show-ref.c          | 20 ++++++--------
 builtin/submodule--helper.c | 10 ++-----
 builtin/worktree.c          |  6 +---
 commit-graph.c              | 14 ++++------
 delta-islands.c             |  9 +++---
 fetch-pack.c                | 16 +++--------
 help.c                      | 10 +++----
 http-backend.c              | 20 ++++++--------
 log-tree.c                  | 24 ++++++++--------
 ls-refs.c                   | 36 ++++++++++++++----------
 midx-write.c                | 17 ++++++------
 negotiator/default.c        |  7 ++---
 negotiator/skipping.c       |  7 ++---
 notes.c                     |  8 ++----
 object-name.c               | 10 +++----
 pseudo-merge.c              | 21 ++++++--------
 reachable.c                 |  9 +++---
 ref-filter.c                | 24 ++++++++--------
 reflog.c                    |  9 ++----
 refs.c                      | 67 +++++++++++++++++++++++++--------------------
 refs.h                      | 26 +++++++++++++++---
 refs/files-backend.c        |  7 ++---
 refs/iterator.c             |  9 +++++-
 remote.c                    | 27 ++++++++----------
 repack-midx.c               | 16 +++++------
 replace-object.c            | 16 ++++-------
 revision.c                  | 12 ++++----
 server-info.c               | 12 ++++----
 shallow.c                   | 16 +++--------
 submodule.c                 | 12 ++------
 t/helper/test-ref-store.c   |  5 ++--
 upload-pack.c               | 29 +++++++++-----------
 walker.c                    |  8 ++----
 worktree.c                  | 11 ++++++--
 49 files changed, 392 insertions(+), 462 deletions(-)

diff --git a/bisect.c b/bisect.c
index a6dc76b15c9..326b59c0dc7 100644
--- a/bisect.c
+++ b/bisect.c
@@ -450,21 +450,20 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 	clear_commit_weight(&commit_weight);
 }
 
-static int register_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			int flags UNUSED, void *cb_data UNUSED)
+static int register_ref(const struct reference *ref, void *cb_data UNUSED)
 {
 	struct strbuf good_prefix = STRBUF_INIT;
 	strbuf_addstr(&good_prefix, term_good);
 	strbuf_addstr(&good_prefix, "-");
 
-	if (!strcmp(refname, term_bad)) {
+	if (!strcmp(ref->name, term_bad)) {
 		free(current_bad_oid);
 		current_bad_oid = xmalloc(sizeof(*current_bad_oid));
-		oidcpy(current_bad_oid, oid);
-	} else if (starts_with(refname, good_prefix.buf)) {
-		oid_array_append(&good_revs, oid);
-	} else if (starts_with(refname, "skip-")) {
-		oid_array_append(&skipped_revs, oid);
+		oidcpy(current_bad_oid, ref->oid);
+	} else if (starts_with(ref->name, good_prefix.buf)) {
+		oid_array_append(&good_revs, ref->oid);
+	} else if (starts_with(ref->name, "skip-")) {
+		oid_array_append(&skipped_revs, ref->oid);
 	}
 
 	strbuf_release(&good_prefix);
@@ -1178,14 +1177,11 @@ int estimate_bisect_steps(int all)
 	return (e < 3 * x) ? n : n - 1;
 }
 
-static int mark_for_removal(const char *refname,
-			    const char *referent UNUSED,
-			    const struct object_id *oid UNUSED,
-			    int flag UNUSED, void *cb_data)
+static int mark_for_removal(const struct reference *ref, void *cb_data)
 {
 	struct string_list *refs = cb_data;
-	char *ref = xstrfmt("refs/bisect%s", refname);
-	string_list_append(refs, ref);
+	char *bisect_ref = xstrfmt("refs/bisect%s", ref->name);
+	string_list_append(refs, bisect_ref);
 	return 0;
 }
 
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 8b8d870cd1e..5b2024be62d 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -358,10 +358,7 @@ static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
 	return 0;
 }
 
-static int inc_nr(const char *refname UNUSED,
-		  const char *referent UNUSED,
-		  const struct object_id *oid UNUSED,
-		  int flag UNUSED, void *cb_data)
+static int inc_nr(const struct reference *ref UNUSED, void *cb_data)
 {
 	unsigned int *nr = (unsigned int *)cb_data;
 	(*nr)++;
@@ -549,12 +546,11 @@ static int bisect_append_log_quoted(const char **argv)
 	return res;
 }
 
-static int add_bisect_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			  int flags UNUSED, void *cb)
+static int add_bisect_ref(const struct reference *ref, void *cb)
 {
 	struct add_bisect_ref_data *data = cb;
 
-	add_pending_oid(data->revs, refname, oid, data->object_flags);
+	add_pending_oid(data->revs, ref->name, ref->oid, data->object_flags);
 
 	return 0;
 }
@@ -1165,12 +1161,9 @@ static int bisect_visualize(struct bisect_terms *terms, int argc,
 	return run_command(&cmd);
 }
 
-static int get_first_good(const char *refname UNUSED,
-			  const char *referent UNUSED,
-			  const struct object_id *oid,
-			  int flag UNUSED, void *cb_data)
+static int get_first_good(const struct reference *ref, void *cb_data)
 {
-	oidcpy(cb_data, oid);
+	oidcpy(cb_data, ref->oid);
 	return 1;
 }
 
diff --git a/builtin/checkout.c b/builtin/checkout.c
index f9453473fe2..66b69df6e67 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1063,11 +1063,9 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
 		report_tracking(new_branch_info);
 }
 
-static int add_pending_uninteresting_ref(const char *refname, const char *referent UNUSED,
-					 const struct object_id *oid,
-					 int flags UNUSED, void *cb_data)
+static int add_pending_uninteresting_ref(const struct reference *ref, void *cb_data)
 {
-	add_pending_oid(cb_data, refname, oid, UNINTERESTING);
+	add_pending_oid(cb_data, ref->name, ref->oid, UNINTERESTING);
 	return 0;
 }
 
diff --git a/builtin/describe.c b/builtin/describe.c
index ffaf8d9f0aa..79545350443 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -154,20 +154,19 @@ static void add_to_known_names(const char *path,
 	}
 }
 
-static int get_name(const char *path, const char *referent UNUSED, const struct object_id *oid,
-		    int flag UNUSED, void *cb_data UNUSED)
+static int get_name(const struct reference *ref, void *cb_data UNUSED)
 {
 	int is_tag = 0;
 	struct object_id peeled;
 	int is_annotated, prio;
 	const char *path_to_match = NULL;
 
-	if (skip_prefix(path, "refs/tags/", &path_to_match)) {
+	if (skip_prefix(ref->name, "refs/tags/", &path_to_match)) {
 		is_tag = 1;
 	} else if (all) {
 		if ((exclude_patterns.nr || patterns.nr) &&
-		    !skip_prefix(path, "refs/heads/", &path_to_match) &&
-		    !skip_prefix(path, "refs/remotes/", &path_to_match)) {
+		    !skip_prefix(ref->name, "refs/heads/", &path_to_match) &&
+		    !skip_prefix(ref->name, "refs/remotes/", &path_to_match)) {
 			/* Only accept reference of known type if there are match/exclude patterns */
 			return 0;
 		}
@@ -209,10 +208,10 @@ static int get_name(const char *path, const char *referent UNUSED, const struct
 	}
 
 	/* Is it annotated? */
-	if (!peel_iterated_oid(the_repository, oid, &peeled)) {
-		is_annotated = !oideq(oid, &peeled);
+	if (!peel_iterated_oid(the_repository, ref->oid, &peeled)) {
+		is_annotated = !oideq(ref->oid, &peeled);
 	} else {
-		oidcpy(&peeled, oid);
+		oidcpy(&peeled, ref->oid);
 		is_annotated = 0;
 	}
 
@@ -229,7 +228,8 @@ static int get_name(const char *path, const char *referent UNUSED, const struct
 	else
 		prio = 0;
 
-	add_to_known_names(all ? path + 5 : path + 10, &peeled, prio, oid);
+	add_to_known_names(all ? ref->name + 5 : ref->name + 10,
+			   &peeled, prio, ref->oid);
 	return 0;
 }
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c7ff3480fb1..7052e6ff215 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -289,13 +289,11 @@ static struct refname_hash_entry *refname_hash_add(struct hashmap *map,
 	return ent;
 }
 
-static int add_one_refname(const char *refname, const char *referent UNUSED,
-			   const struct object_id *oid,
-			   int flag UNUSED, void *cbdata)
+static int add_one_refname(const struct reference *ref, void *cbdata)
 {
 	struct hashmap *refname_map = cbdata;
 
-	(void) refname_hash_add(refname_map, refname, oid);
+	(void) refname_hash_add(refname_map, ref->name, ref->oid);
 	return 0;
 }
 
@@ -1416,14 +1414,11 @@ static void set_option(struct transport *transport, const char *name, const char
 }
 
 
-static int add_oid(const char *refname UNUSED,
-		   const char *referent UNUSED,
-		   const struct object_id *oid,
-		   int flags UNUSED, void *cb_data)
+static int add_oid(const struct reference *ref, void *cb_data)
 {
 	struct oid_array *oids = cb_data;
 
-	oid_array_append(oids, oid);
+	oid_array_append(oids, ref->oid);
 	return 0;
 }
 
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 8ee95e0d67c..ed4eea16803 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -530,14 +530,13 @@ static int fsck_handle_reflog(const char *logname, void *cb_data)
 	return 0;
 }
 
-static int fsck_handle_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			   int flag UNUSED, void *cb_data UNUSED)
+static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
 {
 	struct object *obj;
 
-	obj = parse_object(the_repository, oid);
+	obj = parse_object(the_repository, ref->oid);
 	if (!obj) {
-		if (is_promisor_object(the_repository, oid)) {
+		if (is_promisor_object(the_repository, ref->oid)) {
 			/*
 			 * Increment default_refs anyway, because this is a
 			 * valid ref.
@@ -546,19 +545,19 @@ static int fsck_handle_ref(const char *refname, const char *referent UNUSED, con
 			 return 0;
 		}
 		error(_("%s: invalid sha1 pointer %s"),
-		      refname, oid_to_hex(oid));
+		      ref->name, oid_to_hex(ref->oid));
 		errors_found |= ERROR_REACHABLE;
 		/* We'll continue with the rest despite the error.. */
 		return 0;
 	}
-	if (obj->type != OBJ_COMMIT && is_branch(refname)) {
-		error(_("%s: not a commit"), refname);
+	if (obj->type != OBJ_COMMIT && is_branch(ref->name)) {
+		error(_("%s: not a commit"), ref->name);
 		errors_found |= ERROR_REFS;
 	}
 	default_refs++;
 	obj->flags |= USED;
 	fsck_put_object_name(&fsck_walk_options,
-			     oid, "%s", refname);
+			     ref->oid, "%s", ref->name);
 	mark_object_reachable(obj);
 
 	return 0;
@@ -580,13 +579,19 @@ static void get_default_heads(void)
 	worktrees = get_worktrees();
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
-		struct strbuf ref = STRBUF_INIT;
+		struct strbuf refname = STRBUF_INIT;
 
-		strbuf_worktree_ref(wt, &ref, "HEAD");
-		fsck_head_link(ref.buf, &head_points_at, &head_oid);
-		if (head_points_at && !is_null_oid(&head_oid))
-			fsck_handle_ref(ref.buf, NULL, &head_oid, 0, NULL);
-		strbuf_release(&ref);
+		strbuf_worktree_ref(wt, &refname, "HEAD");
+		fsck_head_link(refname.buf, &head_points_at, &head_oid);
+		if (head_points_at && !is_null_oid(&head_oid)) {
+			struct reference ref = {
+				.name = refname.buf,
+				.oid = &head_oid,
+			};
+
+			fsck_handle_ref(&ref, NULL);
+		}
+		strbuf_release(&refname);
 
 		if (include_reflogs)
 			refs_for_each_reflog(get_worktree_ref_store(wt),
diff --git a/builtin/gc.c b/builtin/gc.c
index e19e13d9788..9de5de175f6 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1100,24 +1100,21 @@ struct cg_auto_data {
 	int limit;
 };
 
-static int dfs_on_ref(const char *refname UNUSED,
-		      const char *referent UNUSED,
-		      const struct object_id *oid,
-		      int flags UNUSED,
-		      void *cb_data)
+static int dfs_on_ref(const struct reference *ref, void *cb_data)
 {
 	struct cg_auto_data *data = (struct cg_auto_data *)cb_data;
 	int result = 0;
+	const struct object_id *maybe_peeled = ref->oid;
 	struct object_id peeled;
 	struct commit_list *stack = NULL;
 	struct commit *commit;
 
-	if (!peel_iterated_oid(the_repository, oid, &peeled))
-		oid = &peeled;
-	if (odb_read_object_info(the_repository->objects, oid, NULL) != OBJ_COMMIT)
+	if (!peel_iterated_oid(the_repository, ref->oid, &peeled))
+		maybe_peeled = &peeled;
+	if (odb_read_object_info(the_repository->objects, maybe_peeled, NULL) != OBJ_COMMIT)
 		return 0;
 
-	commit = lookup_commit(the_repository, oid);
+	commit = lookup_commit(the_repository, maybe_peeled);
 	if (!commit)
 		return 0;
 	if (repo_parse_commit(the_repository, commit) ||
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 74512e54a38..615f7d1aae4 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -339,10 +339,9 @@ static int cmp_by_tag_and_age(const void *a_, const void *b_)
 	return a->taggerdate != b->taggerdate;
 }
 
-static int name_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
-		    int flags UNUSED, void *cb_data)
+static int name_ref(const struct reference *ref, void *cb_data)
 {
-	struct object *o = parse_object(the_repository, oid);
+	struct object *o = parse_object(the_repository, ref->oid);
 	struct name_ref_data *data = cb_data;
 	int can_abbreviate_output = data->tags_only && data->name_only;
 	int deref = 0;
@@ -350,14 +349,14 @@ static int name_ref(const char *path, const char *referent UNUSED, const struct
 	struct commit *commit = NULL;
 	timestamp_t taggerdate = TIME_MAX;
 
-	if (data->tags_only && !starts_with(path, "refs/tags/"))
+	if (data->tags_only && !starts_with(ref->name, "refs/tags/"))
 		return 0;
 
 	if (data->exclude_filters.nr) {
 		struct string_list_item *item;
 
 		for_each_string_list_item(item, &data->exclude_filters) {
-			if (subpath_matches(path, item->string) >= 0)
+			if (subpath_matches(ref->name, item->string) >= 0)
 				return 0;
 		}
 	}
@@ -378,7 +377,7 @@ static int name_ref(const char *path, const char *referent UNUSED, const struct
 			 * shouldn't stop when seeing 'refs/tags/v1.4' matches
 			 * 'refs/tags/v*'.  We should show it as 'v1.4'.
 			 */
-			switch (subpath_matches(path, item->string)) {
+			switch (subpath_matches(ref->name, item->string)) {
 			case -1: /* did not match */
 				break;
 			case 0: /* matched fully */
@@ -406,13 +405,13 @@ static int name_ref(const char *path, const char *referent UNUSED, const struct
 	}
 	if (o && o->type == OBJ_COMMIT) {
 		commit = (struct commit *)o;
-		from_tag = starts_with(path, "refs/tags/");
+		from_tag = starts_with(ref->name, "refs/tags/");
 		if (taggerdate == TIME_MAX)
 			taggerdate = commit->date;
 	}
 
-	add_to_tip_table(oid, path, can_abbreviate_output, commit, taggerdate,
-			 from_tag, deref);
+	add_to_tip_table(ref->oid, ref->name, can_abbreviate_output,
+			 commit, taggerdate, from_tag, deref);
 	return 0;
 }
 
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 5bdc44fb2de..39633a0158e 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -831,15 +831,14 @@ static enum write_one_status write_one(struct hashfile *f,
 	return WRITE_ONE_WRITTEN;
 }
 
-static int mark_tagged(const char *path UNUSED, const char *referent UNUSED, const struct object_id *oid,
-		       int flag UNUSED, void *cb_data UNUSED)
+static int mark_tagged(const struct reference *ref, void *cb_data UNUSED)
 {
 	struct object_id peeled;
-	struct object_entry *entry = packlist_find(&to_pack, oid);
+	struct object_entry *entry = packlist_find(&to_pack, ref->oid);
 
 	if (entry)
 		entry->tagged = 1;
-	if (!peel_iterated_oid(the_repository, oid, &peeled)) {
+	if (!peel_iterated_oid(the_repository, ref->oid, &peeled)) {
 		entry = packlist_find(&to_pack, &peeled);
 		if (entry)
 			entry->tagged = 1;
@@ -3306,13 +3305,12 @@ static void add_tag_chain(const struct object_id *oid)
 	}
 }
 
-static int add_ref_tag(const char *tag UNUSED, const char *referent UNUSED, const struct object_id *oid,
-		       int flag UNUSED, void *cb_data UNUSED)
+static int add_ref_tag(const struct reference *ref, void *cb_data UNUSED)
 {
 	struct object_id peeled;
 
-	if (!peel_iterated_oid(the_repository, oid, &peeled) && obj_is_packed(&peeled))
-		add_tag_chain(oid);
+	if (!peel_iterated_oid(the_repository, ref->oid, &peeled) && obj_is_packed(&peeled))
+		add_tag_chain(ref->oid);
 	return 0;
 }
 
@@ -4533,19 +4531,16 @@ static void record_recent_commit(struct commit *commit, void *data UNUSED)
 	oid_array_append(&recent_objects, &commit->object.oid);
 }
 
-static int mark_bitmap_preferred_tip(const char *refname,
-				     const char *referent UNUSED,
-				     const struct object_id *oid,
-				     int flags UNUSED,
-				     void *data UNUSED)
+static int mark_bitmap_preferred_tip(const struct reference *ref, void *data UNUSED)
 {
+	const struct object_id *maybe_peeled = ref->oid;
 	struct object_id peeled;
 	struct object *object;
 
-	if (!peel_iterated_oid(the_repository, oid, &peeled))
-		oid = &peeled;
+	if (!peel_iterated_oid(the_repository, ref->oid, &peeled))
+		maybe_peeled = &peeled;
 
-	object = parse_object_or_die(the_repository, oid, refname);
+	object = parse_object_or_die(the_repository, maybe_peeled, ref->name);
 	if (object->type == OBJ_COMMIT)
 		object->flags |= NEEDS_BITMAP;
 
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index c9288a9c7e3..e8ee0e73217 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -305,13 +305,12 @@ static void show_ref(const char *path, const struct object_id *oid)
 	}
 }
 
-static int show_ref_cb(const char *path_full, const char *referent UNUSED, const struct object_id *oid,
-		       int flag UNUSED, void *data)
+static int show_ref_cb(const struct reference *ref, void *data)
 {
 	struct oidset *seen = data;
-	const char *path = strip_namespace(path_full);
+	const char *path = strip_namespace(ref->name);
 
-	if (ref_is_hidden(path, path_full, &hidden_refs))
+	if (ref_is_hidden(path, ref->name, &hidden_refs))
 		return 0;
 
 	/*
@@ -320,13 +319,13 @@ static int show_ref_cb(const char *path_full, const char *referent UNUSED, const
 	 * transfer but will otherwise ignore them.
 	 */
 	if (!path) {
-		if (oidset_insert(seen, oid))
+		if (oidset_insert(seen, ref->oid))
 			return 0;
 		path = ".have";
 	} else {
-		oidset_insert(seen, oid);
+		oidset_insert(seen, ref->oid);
 	}
-	show_ref(path, oid);
+	show_ref(path, ref->oid);
 	return 0;
 }
 
diff --git a/builtin/remote.c b/builtin/remote.c
index 8a7ed4299a4..7ffc14ba157 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -570,17 +570,14 @@ struct branches_for_remote {
 	struct known_remotes *keep;
 };
 
-static int add_branch_for_removal(const char *refname,
-				  const char *referent UNUSED,
-				  const struct object_id *oid UNUSED,
-				  int flags UNUSED, void *cb_data)
+static int add_branch_for_removal(const struct reference *ref, void *cb_data)
 {
 	struct branches_for_remote *branches = cb_data;
 	struct refspec_item refspec;
 	struct known_remote *kr;
 
 	memset(&refspec, 0, sizeof(refspec));
-	refspec.dst = (char *)refname;
+	refspec.dst = (char *)ref->name;
 	if (remote_find_tracking(branches->remote, &refspec))
 		return 0;
 	free(refspec.src);
@@ -588,7 +585,7 @@ static int add_branch_for_removal(const char *refname,
 	/* don't delete a branch if another remote also uses it */
 	for (kr = branches->keep->list; kr; kr = kr->next) {
 		memset(&refspec, 0, sizeof(refspec));
-		refspec.dst = (char *)refname;
+		refspec.dst = (char *)ref->name;
 		if (!remote_find_tracking(kr->remote, &refspec)) {
 			free(refspec.src);
 			return 0;
@@ -596,16 +593,16 @@ static int add_branch_for_removal(const char *refname,
 	}
 
 	/* don't delete non-remote-tracking refs */
-	if (!starts_with(refname, "refs/remotes/")) {
+	if (!starts_with(ref->name, "refs/remotes/")) {
 		/* advise user how to delete local branches */
-		if (starts_with(refname, "refs/heads/"))
+		if (starts_with(ref->name, "refs/heads/"))
 			string_list_append(branches->skipped,
-					   abbrev_branch(refname));
+					   abbrev_branch(ref->name));
 		/* silently skip over other non-remote refs */
 		return 0;
 	}
 
-	string_list_append(branches->branches, refname);
+	string_list_append(branches->branches, ref->name);
 
 	return 0;
 }
@@ -713,18 +710,18 @@ static int rename_one_reflog(const char *old_refname,
 	return error;
 }
 
-static int rename_one_ref(const char *old_refname, const char *referent,
-			  const struct object_id *oid,
-			  int flags, void *cb_data)
+static int rename_one_ref(const struct reference *ref, void *cb_data)
 {
 	struct strbuf new_referent = STRBUF_INIT;
 	struct strbuf new_refname = STRBUF_INIT;
 	struct rename_info *rename = cb_data;
+	const struct object_id *oid = ref->oid;
+	const char *referent = ref->target;
 	int error;
 
-	compute_renamed_ref(rename, old_refname, &new_refname);
+	compute_renamed_ref(rename, ref->name, &new_refname);
 
-	if (flags & REF_ISSYMREF) {
+	if (ref->flags & REF_ISSYMREF) {
 		/*
 		 * Stupidly enough `referent` is not pointing to the immediate
 		 * target of a symref, but it's the recursively resolved value.
@@ -732,25 +729,25 @@ static int rename_one_ref(const char *old_refname, const char *referent,
 		 * unborn symrefs don't have any value for the `referent` at all.
 		 */
 		referent = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						   old_refname, RESOLVE_REF_NO_RECURSE,
+						   ref->name, RESOLVE_REF_NO_RECURSE,
 						   NULL, NULL);
 		compute_renamed_ref(rename, referent, &new_referent);
 		oid = NULL;
 	}
 
-	error = ref_transaction_delete(rename->transaction, old_refname,
+	error = ref_transaction_delete(rename->transaction, ref->name,
 				       oid, referent, REF_NO_DEREF, NULL, rename->err);
 	if (error < 0)
 		goto out;
 
 	error = ref_transaction_update(rename->transaction, new_refname.buf, oid, null_oid(the_hash_algo),
-				       (flags & REF_ISSYMREF) ? new_referent.buf : NULL, NULL,
+				       (ref->flags & REF_ISSYMREF) ? new_referent.buf : NULL, NULL,
 				       REF_SKIP_CREATE_REFLOG | REF_NO_DEREF | REF_SKIP_OID_VERIFICATION,
 				       NULL, rename->err);
 	if (error < 0)
 		goto out;
 
-	error = rename_one_reflog(old_refname, oid, rename);
+	error = rename_one_reflog(ref->name, oid, rename);
 	if (error < 0)
 		goto out;
 
@@ -1125,19 +1122,16 @@ static void free_remote_ref_states(struct ref_states *states)
 	string_list_clear_func(&states->push, clear_push_info);
 }
 
-static int append_ref_to_tracked_list(const char *refname,
-				      const char *referent UNUSED,
-				      const struct object_id *oid UNUSED,
-				      int flags, void *cb_data)
+static int append_ref_to_tracked_list(const struct reference *ref, void *cb_data)
 {
 	struct ref_states *states = cb_data;
 	struct refspec_item refspec;
 
-	if (flags & REF_ISSYMREF)
+	if (ref->flags & REF_ISSYMREF)
 		return 0;
 
 	memset(&refspec, 0, sizeof(refspec));
-	refspec.dst = (char *)refname;
+	refspec.dst = (char *)ref->name;
 	if (!remote_find_tracking(states->remote, &refspec)) {
 		string_list_append(&states->tracked, abbrev_branch(refspec.src));
 		free(refspec.src);
diff --git a/builtin/replace.c b/builtin/replace.c
index 900b560a77d..4c62c5ab58b 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -47,30 +47,27 @@ struct show_data {
 	enum replace_format format;
 };
 
-static int show_reference(const char *refname,
-			  const char *referent UNUSED,
-			  const struct object_id *oid,
-			  int flag UNUSED, void *cb_data)
+static int show_reference(const struct reference *ref, void *cb_data)
 {
 	struct show_data *data = cb_data;
 
-	if (!wildmatch(data->pattern, refname, 0)) {
+	if (!wildmatch(data->pattern, ref->name, 0)) {
 		if (data->format == REPLACE_FORMAT_SHORT)
-			printf("%s\n", refname);
+			printf("%s\n", ref->name);
 		else if (data->format == REPLACE_FORMAT_MEDIUM)
-			printf("%s -> %s\n", refname, oid_to_hex(oid));
+			printf("%s -> %s\n", ref->name, oid_to_hex(ref->oid));
 		else { /* data->format == REPLACE_FORMAT_LONG */
 			struct object_id object;
 			enum object_type obj_type, repl_type;
 
-			if (repo_get_oid(data->repo, refname, &object))
-				return error(_("failed to resolve '%s' as a valid ref"), refname);
+			if (repo_get_oid(data->repo, ref->name, &object))
+				return error(_("failed to resolve '%s' as a valid ref"), ref->name);
 
 			obj_type = odb_read_object_info(data->repo->objects, &object, NULL);
-			repl_type = odb_read_object_info(data->repo->objects, oid, NULL);
+			repl_type = odb_read_object_info(data->repo->objects, ref->oid, NULL);
 
-			printf("%s (%s) -> %s (%s)\n", refname, type_name(obj_type),
-			       oid_to_hex(oid), type_name(repl_type));
+			printf("%s (%s) -> %s (%s)\n", ref->name, type_name(obj_type),
+			       oid_to_hex(ref->oid), type_name(repl_type));
 		}
 	}
 
diff --git a/builtin/repo.c b/builtin/repo.c
index 9d4749f79be..f26640bd6ea 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -366,16 +366,13 @@ struct count_references_data {
 	struct progress *progress;
 };
 
-static int count_references(const char *refname,
-			    const char *referent UNUSED,
-			    const struct object_id *oid,
-			    int flags UNUSED, void *cb_data)
+static int count_references(const struct reference *ref, void *cb_data)
 {
 	struct count_references_data *data = cb_data;
 	struct ref_stats *stats = data->stats;
 	size_t ref_count;
 
-	switch (ref_kind_from_refname(refname)) {
+	switch (ref_kind_from_refname(ref->name)) {
 	case FILTER_REFS_BRANCHES:
 		stats->branches++;
 		break;
@@ -396,7 +393,7 @@ static int count_references(const char *refname,
 	 * While iterating through references for counting, also add OIDs in
 	 * preparation for the path walk.
 	 */
-	add_pending_oid(data->revs, NULL, oid, 0);
+	add_pending_oid(data->revs, NULL, ref->oid, 0);
 
 	ref_count = get_total_reference_count(stats);
 	display_progress(data->progress, ref_count);
diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 9da92b990d0..3578591b4f2 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -217,19 +217,17 @@ static int show_default(void)
 	return 0;
 }
 
-static int show_reference(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			  int flag UNUSED, void *cb_data UNUSED)
+static int show_reference(const struct reference *ref, void *cb_data UNUSED)
 {
-	if (ref_excluded(&ref_excludes, refname))
+	if (ref_excluded(&ref_excludes, ref->name))
 		return 0;
-	show_rev(NORMAL, oid, refname);
+	show_rev(NORMAL, ref->oid, ref->name);
 	return 0;
 }
 
-static int anti_reference(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			  int flag UNUSED, void *cb_data UNUSED)
+static int anti_reference(const struct reference *ref, void *cb_data UNUSED)
 {
-	show_rev(REVERSED, oid, refname);
+	show_rev(REVERSED, ref->oid, ref->name);
 	return 0;
 }
 
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 441babf2e35..10475a6b5ed 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -413,34 +413,32 @@ static int append_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int append_head_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			   int flag UNUSED, void *cb_data UNUSED)
+static int append_head_ref(const struct reference *ref, void *cb_data UNUSED)
 {
 	struct object_id tmp;
 	int ofs = 11;
-	if (!starts_with(refname, "refs/heads/"))
+	if (!starts_with(ref->name, "refs/heads/"))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (repo_get_oid(the_repository, refname + ofs, &tmp) || !oideq(&tmp, oid))
+	if (repo_get_oid(the_repository, ref->name + ofs, &tmp) || !oideq(&tmp, ref->oid))
 		ofs = 5;
-	return append_ref(refname + ofs, oid, 0);
+	return append_ref(ref->name + ofs, ref->oid, 0);
 }
 
-static int append_remote_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			     int flag UNUSED, void *cb_data UNUSED)
+static int append_remote_ref(const struct reference *ref, void *cb_data UNUSED)
 {
 	struct object_id tmp;
 	int ofs = 13;
-	if (!starts_with(refname, "refs/remotes/"))
+	if (!starts_with(ref->name, "refs/remotes/"))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
 	 */
-	if (repo_get_oid(the_repository, refname + ofs, &tmp) || !oideq(&tmp, oid))
+	if (repo_get_oid(the_repository, ref->name + ofs, &tmp) || !oideq(&tmp, ref->oid))
 		ofs = 5;
-	return append_ref(refname + ofs, oid, 0);
+	return append_ref(ref->name + ofs, ref->oid, 0);
 }
 
 static int append_tag_ref(const char *refname, const struct object_id *oid,
@@ -454,27 +452,26 @@ static int append_tag_ref(const char *refname, const struct object_id *oid,
 static const char *match_ref_pattern = NULL;
 static int match_ref_slash = 0;
 
-static int append_matching_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			       int flag, void *cb_data)
+static int append_matching_ref(const struct reference *ref, void *cb_data)
 {
 	/* we want to allow pattern hold/<asterisk> to show all
 	 * branches under refs/heads/hold/, and v0.99.9? to show
 	 * refs/tags/v0.99.9a and friends.
 	 */
 	const char *tail;
-	int slash = count_slashes(refname);
-	for (tail = refname; *tail && match_ref_slash < slash; )
+	int slash = count_slashes(ref->name);
+	for (tail = ref->name; *tail && match_ref_slash < slash; )
 		if (*tail++ == '/')
 			slash--;
 	if (!*tail)
 		return 0;
 	if (wildmatch(match_ref_pattern, tail, 0))
 		return 0;
-	if (starts_with(refname, "refs/heads/"))
-		return append_head_ref(refname, NULL, oid, flag, cb_data);
-	if (starts_with(refname, "refs/tags/"))
-		return append_tag_ref(refname, oid, flag, cb_data);
-	return append_ref(refname, oid, 0);
+	if (starts_with(ref->name, "refs/heads/"))
+		return append_head_ref(ref, cb_data);
+	if (starts_with(ref->name, "refs/tags/"))
+		return append_tag_ref(ref->name, ref->oid, ref->flags, cb_data);
+	return append_ref(ref->name, ref->oid, 0);
 }
 
 static void snarf_refs(int head, int remotes)
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 0b6f9edf86c..4803b5e5986 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -66,26 +66,25 @@ struct show_ref_data {
 	int show_head;
 };
 
-static int show_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-		    int flag UNUSED, void *cbdata)
+static int show_ref(const struct reference *ref, void *cbdata)
 {
 	struct show_ref_data *data = cbdata;
 
-	if (data->show_head && !strcmp(refname, "HEAD"))
+	if (data->show_head && !strcmp(ref->name, "HEAD"))
 		goto match;
 
 	if (data->patterns) {
-		int reflen = strlen(refname);
+		int reflen = strlen(ref->name);
 		const char **p = data->patterns, *m;
 		while ((m = *p++) != NULL) {
 			int len = strlen(m);
 			if (len > reflen)
 				continue;
-			if (memcmp(m, refname + reflen - len, len))
+			if (memcmp(m, ref->name + reflen - len, len))
 				continue;
 			if (len == reflen)
 				goto match;
-			if (refname[reflen - len - 1] == '/')
+			if (ref->name[reflen - len - 1] == '/')
 				goto match;
 		}
 		return 0;
@@ -94,18 +93,15 @@ static int show_ref(const char *refname, const char *referent UNUSED, const stru
 match:
 	data->found_match++;
 
-	show_one(data->show_one_opts, refname, oid);
+	show_one(data->show_one_opts, ref->name, ref->oid);
 
 	return 0;
 }
 
-static int add_existing(const char *refname,
-			const char *referent UNUSED,
-			const struct object_id *oid UNUSED,
-			int flag UNUSED, void *cbdata)
+static int add_existing(const struct reference *ref, void *cbdata)
 {
 	struct string_list *list = (struct string_list *)cbdata;
-	string_list_insert(list, refname);
+	string_list_insert(list, ref->name);
 	return 0;
 }
 
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index fcd73abe533..35f6cf735e5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -593,16 +593,12 @@ static void print_status(unsigned int flags, char state, const char *path,
 	printf("\n");
 }
 
-static int handle_submodule_head_ref(const char *refname UNUSED,
-				     const char *referent UNUSED,
-				     const struct object_id *oid,
-				     int flags UNUSED,
-				     void *cb_data)
+static int handle_submodule_head_ref(const struct reference *ref, void *cb_data)
 {
 	struct object_id *output = cb_data;
 
-	if (oid)
-		oidcpy(output, oid);
+	if (ref->oid)
+		oidcpy(output, ref->oid);
 
 	return 0;
 }
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 812774a5ca9..b7f323b5e4d 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -635,11 +635,7 @@ static void print_preparing_worktree_line(int detach,
  *
  * Returns 0 on failure and non-zero on success.
  */
-static int first_valid_ref(const char *refname UNUSED,
-			   const char *referent UNUSED,
-			   const struct object_id *oid UNUSED,
-			   int flags UNUSED,
-			   void *cb_data UNUSED)
+static int first_valid_ref(const struct reference *ref UNUSED, void *cb_data UNUSED)
 {
 	return 1;
 }
diff --git a/commit-graph.c b/commit-graph.c
index 474454db73d..f91af416259 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1851,18 +1851,16 @@ struct refs_cb_data {
 	struct progress *progress;
 };
 
-static int add_ref_to_set(const char *refname UNUSED,
-			  const char *referent UNUSED,
-			  const struct object_id *oid,
-			  int flags UNUSED, void *cb_data)
+static int add_ref_to_set(const struct reference *ref, void *cb_data)
 {
+	const struct object_id *maybe_peeled = ref->oid;
 	struct object_id peeled;
 	struct refs_cb_data *data = (struct refs_cb_data *)cb_data;
 
-	if (!peel_iterated_oid(data->repo, oid, &peeled))
-		oid = &peeled;
-	if (odb_read_object_info(data->repo->objects, oid, NULL) == OBJ_COMMIT)
-		oidset_insert(data->commits, oid);
+	if (!peel_iterated_oid(data->repo, ref->oid, &peeled))
+		maybe_peeled = &peeled;
+	if (odb_read_object_info(data->repo->objects, maybe_peeled, NULL) == OBJ_COMMIT)
+		oidset_insert(data->commits, maybe_peeled);
 
 	display_progress(data->progress, oidset_size(data->commits));
 
diff --git a/delta-islands.c b/delta-islands.c
index 36c94799d69..7cfebc4162b 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -390,8 +390,7 @@ static void add_ref_to_island(kh_str_t *remote_islands, const char *island_name,
 	rl->hash += sha_core;
 }
 
-static int find_island_for_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			       int flags UNUSED, void *cb)
+static int find_island_for_ref(const struct reference *ref, void *cb)
 {
 	struct island_load_data *ild = cb;
 
@@ -406,7 +405,7 @@ static int find_island_for_ref(const char *refname, const char *referent UNUSED,
 
 	/* walk backwards to get last-one-wins ordering */
 	for (i = ild->nr - 1; i >= 0; i--) {
-		if (!regexec(&ild->rx[i], refname,
+		if (!regexec(&ild->rx[i], ref->name,
 			     ARRAY_SIZE(matches), matches, 0))
 			break;
 	}
@@ -428,10 +427,10 @@ static int find_island_for_ref(const char *refname, const char *referent UNUSED,
 		if (island_name.len)
 			strbuf_addch(&island_name, '-');
 
-		strbuf_add(&island_name, refname + match->rm_so, match->rm_eo - match->rm_so);
+		strbuf_add(&island_name, ref->name + match->rm_so, match->rm_eo - match->rm_so);
 	}
 
-	add_ref_to_island(ild->remote_islands, island_name.buf, oid);
+	add_ref_to_island(ild->remote_islands, island_name.buf, ref->oid);
 	strbuf_release(&island_name);
 	return 0;
 }
diff --git a/fetch-pack.c b/fetch-pack.c
index fe7a84bf2f9..78c45d4a155 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -188,13 +188,9 @@ static int rev_list_insert_ref(struct fetch_negotiator *negotiator,
 	return 0;
 }
 
-static int rev_list_insert_ref_oid(const char *refname UNUSED,
-				   const char *referent UNUSED,
-				   const struct object_id *oid,
-				   int flag UNUSED,
-				   void *cb_data)
+static int rev_list_insert_ref_oid(const struct reference *ref, void *cb_data)
 {
-	return rev_list_insert_ref(cb_data, oid);
+	return rev_list_insert_ref(cb_data, ref->oid);
 }
 
 enum ack_type {
@@ -616,13 +612,9 @@ static int mark_complete(const struct object_id *oid)
 	return 0;
 }
 
-static int mark_complete_oid(const char *refname UNUSED,
-			     const char *referent UNUSED,
-			     const struct object_id *oid,
-			     int flag UNUSED,
-			     void *cb_data UNUSED)
+static int mark_complete_oid(const struct reference *ref, void *cb_data UNUSED)
 {
-	return mark_complete(oid);
+	return mark_complete(ref->oid);
 }
 
 static void mark_recent_complete_commits(struct fetch_pack_args *args,
diff --git a/help.c b/help.c
index 5854dd4a7e4..20e114432d7 100644
--- a/help.c
+++ b/help.c
@@ -851,18 +851,16 @@ struct similar_ref_cb {
 	struct string_list *similar_refs;
 };
 
-static int append_similar_ref(const char *refname, const char *referent UNUSED,
-			      const struct object_id *oid UNUSED,
-			      int flags UNUSED, void *cb_data)
+static int append_similar_ref(const struct reference *ref, void *cb_data)
 {
 	struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
-	char *branch = strrchr(refname, '/') + 1;
+	char *branch = strrchr(ref->name, '/') + 1;
 
 	/* A remote branch of the same name is deemed similar */
-	if (starts_with(refname, "refs/remotes/") &&
+	if (starts_with(ref->name, "refs/remotes/") &&
 	    !strcmp(branch, cb->base_ref))
 		string_list_append_nodup(cb->similar_refs,
-					 refs_shorten_unambiguous_ref(get_main_ref_store(the_repository), refname, 1));
+					 refs_shorten_unambiguous_ref(get_main_ref_store(the_repository), ref->name, 1));
 	return 0;
 }
 
diff --git a/http-backend.c b/http-backend.c
index 9084058f1e9..92e1733f140 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -513,18 +513,17 @@ static void run_service(const char **argv, int buffer_input)
 		exit(1);
 }
 
-static int show_text_ref(const char *name, const char *referent UNUSED, const struct object_id *oid,
-			 int flag UNUSED, void *cb_data)
+static int show_text_ref(const struct reference *ref, void *cb_data)
 {
-	const char *name_nons = strip_namespace(name);
+	const char *name_nons = strip_namespace(ref->name);
 	struct strbuf *buf = cb_data;
-	struct object *o = parse_object(the_repository, oid);
+	struct object *o = parse_object(the_repository, ref->oid);
 	if (!o)
 		return 0;
 
-	strbuf_addf(buf, "%s\t%s\n", oid_to_hex(oid), name_nons);
+	strbuf_addf(buf, "%s\t%s\n", oid_to_hex(ref->oid), name_nons);
 	if (o->type == OBJ_TAG) {
-		o = deref_tag(the_repository, o, name, 0);
+		o = deref_tag(the_repository, o, ref->name, 0);
 		if (!o)
 			return 0;
 		strbuf_addf(buf, "%s\t%s^{}\n", oid_to_hex(&o->oid),
@@ -569,21 +568,20 @@ static void get_info_refs(struct strbuf *hdr, char *arg UNUSED)
 	strbuf_release(&buf);
 }
 
-static int show_head_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			 int flag, void *cb_data)
+static int show_head_ref(const struct reference *ref, void *cb_data)
 {
 	struct strbuf *buf = cb_data;
 
-	if (flag & REF_ISSYMREF) {
+	if (ref->flags & REF_ISSYMREF) {
 		const char *target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-							     refname,
+							     ref->name,
 							     RESOLVE_REF_READING,
 							     NULL, NULL);
 
 		if (target)
 			strbuf_addf(buf, "ref: %s\n", strip_namespace(target));
 	} else {
-		strbuf_addf(buf, "%s\n", oid_to_hex(oid));
+		strbuf_addf(buf, "%s\n", oid_to_hex(ref->oid));
 	}
 
 	return 0;
diff --git a/log-tree.c b/log-tree.c
index 7d917f2a83d..1729b0c2012 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -147,9 +147,7 @@ static int ref_filter_match(const char *refname,
 	return 1;
 }
 
-static int add_ref_decoration(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			      int flags UNUSED,
-			      void *cb_data)
+static int add_ref_decoration(const struct reference *ref, void *cb_data)
 {
 	int i;
 	struct object *obj;
@@ -158,16 +156,16 @@ static int add_ref_decoration(const char *refname, const char *referent UNUSED,
 	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
 	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
 
-	if (filter && !ref_filter_match(refname, filter))
+	if (filter && !ref_filter_match(ref->name, filter))
 		return 0;
 
-	if (starts_with(refname, git_replace_ref_base)) {
+	if (starts_with(ref->name, git_replace_ref_base)) {
 		struct object_id original_oid;
 		if (!replace_refs_enabled(the_repository))
 			return 0;
-		if (get_oid_hex(refname + strlen(git_replace_ref_base),
+		if (get_oid_hex(ref->name + strlen(git_replace_ref_base),
 				&original_oid)) {
-			warning("invalid replace ref %s", refname);
+			warning("invalid replace ref %s", ref->name);
 			return 0;
 		}
 		obj = parse_object(the_repository, &original_oid);
@@ -176,10 +174,10 @@ static int add_ref_decoration(const char *refname, const char *referent UNUSED,
 		return 0;
 	}
 
-	objtype = odb_read_object_info(the_repository->objects, oid, NULL);
+	objtype = odb_read_object_info(the_repository->objects, ref->oid, NULL);
 	if (objtype < 0)
 		return 0;
-	obj = lookup_object_by_type(the_repository, oid, objtype);
+	obj = lookup_object_by_type(the_repository, ref->oid, objtype);
 
 	for (i = 0; i < ARRAY_SIZE(ref_namespace); i++) {
 		struct ref_namespace_info *info = &ref_namespace[i];
@@ -187,24 +185,24 @@ static int add_ref_decoration(const char *refname, const char *referent UNUSED,
 		if (!info->decoration)
 			continue;
 		if (info->exact) {
-			if (!strcmp(refname, info->ref)) {
+			if (!strcmp(ref->name, info->ref)) {
 				deco_type = info->decoration;
 				break;
 			}
-		} else if (starts_with(refname, info->ref)) {
+		} else if (starts_with(ref->name, info->ref)) {
 			deco_type = info->decoration;
 			break;
 		}
 	}
 
-	add_name_decoration(deco_type, refname, obj);
+	add_name_decoration(deco_type, ref->name, obj);
 	while (obj->type == OBJ_TAG) {
 		if (!obj->parsed)
 			parse_object(the_repository, &obj->oid);
 		obj = ((struct tag *)obj)->tagged;
 		if (!obj)
 			break;
-		add_name_decoration(DECORATION_REF_TAG, refname, obj);
+		add_name_decoration(DECORATION_REF_TAG, ref->name, obj);
 	}
 	return 0;
 }
diff --git a/ls-refs.c b/ls-refs.c
index c47acde07f3..64d02723691 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -75,42 +75,42 @@ struct ls_refs_data {
 	unsigned unborn : 1;
 };
 
-static int send_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-		    int flag, void *cb_data)
+static int send_ref(const struct reference *ref, void *cb_data)
 {
 	struct ls_refs_data *data = cb_data;
-	const char *refname_nons = strip_namespace(refname);
+	const char *refname_nons = strip_namespace(ref->name);
 
 	strbuf_reset(&data->buf);
 
-	if (ref_is_hidden(refname_nons, refname, &data->hidden_refs))
+	if (ref_is_hidden(refname_nons, ref->name, &data->hidden_refs))
 		return 0;
 
 	if (!ref_match(&data->prefixes, refname_nons))
 		return 0;
 
-	if (oid)
-		strbuf_addf(&data->buf, "%s %s", oid_to_hex(oid), refname_nons);
+	if (ref->oid)
+		strbuf_addf(&data->buf, "%s %s", oid_to_hex(ref->oid), refname_nons);
 	else
 		strbuf_addf(&data->buf, "unborn %s", refname_nons);
-	if (data->symrefs && flag & REF_ISSYMREF) {
+	if (data->symrefs && ref->flags & REF_ISSYMREF) {
+		int unused_flag;
 		struct object_id unused;
 		const char *symref_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-								    refname,
+								    ref->name,
 								    0,
 								    &unused,
-								    &flag);
+								    &unused_flag);
 
 		if (!symref_target)
-			die("'%s' is a symref but it is not?", refname);
+			die("'%s' is a symref but it is not?", ref->name);
 
 		strbuf_addf(&data->buf, " symref-target:%s",
 			    strip_namespace(symref_target));
 	}
 
-	if (data->peel && oid) {
+	if (data->peel && ref->oid) {
 		struct object_id peeled;
-		if (!peel_iterated_oid(the_repository, oid, &peeled))
+		if (!peel_iterated_oid(the_repository, ref->oid, &peeled))
 			strbuf_addf(&data->buf, " peeled:%s", oid_to_hex(&peeled));
 	}
 
@@ -131,9 +131,17 @@ static void send_possibly_unborn_head(struct ls_refs_data *data)
 	if (!refs_resolve_ref_unsafe(get_main_ref_store(the_repository), namespaced.buf, 0, &oid, &flag))
 		return; /* bad ref */
 	oid_is_null = is_null_oid(&oid);
+
 	if (!oid_is_null ||
-	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF)))
-		send_ref(namespaced.buf, NULL, oid_is_null ? NULL : &oid, flag, data);
+	    (data->unborn && data->symrefs && (flag & REF_ISSYMREF))) {
+		struct reference ref = {
+			.name = namespaced.buf,
+			.oid = oid_is_null ? NULL : &oid,
+			.flags = flag,
+		};
+
+		send_ref(&ref, data);
+	}
 	strbuf_release(&namespaced);
 }
 
diff --git a/midx-write.c b/midx-write.c
index c73010df6d3..f4dd875747a 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -697,28 +697,27 @@ static void prepare_midx_packing_data(struct packing_data *pdata,
 	trace2_region_leave("midx", "prepare_midx_packing_data", ctx->repo);
 }
 
-static int add_ref_to_pending(const char *refname, const char *referent UNUSED,
-			      const struct object_id *oid,
-			      int flag, void *cb_data)
+static int add_ref_to_pending(const struct reference *ref, void *cb_data)
 {
 	struct rev_info *revs = (struct rev_info*)cb_data;
+	const struct object_id *maybe_peeled = ref->oid;
 	struct object_id peeled;
 	struct object *object;
 
-	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
-		warning("symbolic ref is dangling: %s", refname);
+	if ((ref->flags & REF_ISSYMREF) && (ref->flags & REF_ISBROKEN)) {
+		warning("symbolic ref is dangling: %s", ref->name);
 		return 0;
 	}
 
-	if (!peel_iterated_oid(revs->repo, oid, &peeled))
-		oid = &peeled;
+	if (!peel_iterated_oid(revs->repo, ref->oid, &peeled))
+		maybe_peeled = &peeled;
 
-	object = parse_object_or_die(revs->repo, oid, refname);
+	object = parse_object_or_die(revs->repo, maybe_peeled, ref->name);
 	if (object->type != OBJ_COMMIT)
 		return 0;
 
 	add_pending_object(revs, object, "");
-	if (bitmap_is_preferred_refname(revs->repo, refname))
+	if (bitmap_is_preferred_refname(revs->repo, ref->name))
 		object->flags |= NEEDS_BITMAP;
 	return 0;
 }
diff --git a/negotiator/default.c b/negotiator/default.c
index c479da9b091..116dedcf830 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -38,11 +38,10 @@ static void rev_list_push(struct negotiation_state *ns,
 	}
 }
 
-static int clear_marks(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-		       int flag UNUSED,
-		       void *cb_data UNUSED)
+static int clear_marks(const struct reference *ref, void *cb_data UNUSED)
 {
-	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
+	struct object *o = deref_tag(the_repository, parse_object(the_repository, ref->oid),
+				     ref->name, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		clear_commit_marks((struct commit *)o,
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 616df6bf3af..0a272130fb1 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -75,11 +75,10 @@ static struct entry *rev_list_push(struct data *data, struct commit *commit, int
 	return entry;
 }
 
-static int clear_marks(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-		       int flag UNUSED,
-		       void *cb_data UNUSED)
+static int clear_marks(const struct reference *ref, void *cb_data UNUSED)
 {
-	struct object *o = deref_tag(the_repository, parse_object(the_repository, oid), refname, 0);
+	struct object *o = deref_tag(the_repository, parse_object(the_repository, ref->oid),
+				     ref->name, 0);
 
 	if (o && o->type == OBJ_COMMIT)
 		clear_commit_marks((struct commit *)o,
diff --git a/notes.c b/notes.c
index 9a2e9181fe6..8e00fd8c470 100644
--- a/notes.c
+++ b/notes.c
@@ -938,13 +938,11 @@ int combine_notes_cat_sort_uniq(struct object_id *cur_oid,
 	return ret;
 }
 
-static int string_list_add_one_ref(const char *refname, const char *referent UNUSED,
-				   const struct object_id *oid UNUSED,
-				   int flag UNUSED, void *cb)
+static int string_list_add_one_ref(const struct reference *ref, void *cb)
 {
 	struct string_list *refs = cb;
-	if (!unsorted_string_list_has_string(refs, refname))
-		string_list_append(refs, refname);
+	if (!unsorted_string_list_has_string(refs, ref->name))
+		string_list_append(refs, ref->name);
 	return 0;
 }
 
diff --git a/object-name.c b/object-name.c
index f6902e140dd..7e8109f25fb 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1444,18 +1444,16 @@ struct handle_one_ref_cb {
 	struct commit_list **list;
 };
 
-static int handle_one_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
-			  int flag UNUSED,
-			  void *cb_data)
+static int handle_one_ref(const struct reference *ref, void *cb_data)
 {
 	struct handle_one_ref_cb *cb = cb_data;
 	struct commit_list **list = cb->list;
-	struct object *object = parse_object(cb->repo, oid);
+	struct object *object = parse_object(cb->repo, ref->oid);
 	if (!object)
 		return 0;
 	if (object->type == OBJ_TAG) {
-		object = deref_tag(cb->repo, object, path,
-				   strlen(path));
+		object = deref_tag(cb->repo, object, ref->name,
+				   strlen(ref->name));
 		if (!object)
 			return 0;
 	}
diff --git a/pseudo-merge.c b/pseudo-merge.c
index 893b763fe45..0abd51b42c1 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -221,28 +221,25 @@ void load_pseudo_merges_from_config(struct repository *r,
 	}
 }
 
-static int find_pseudo_merge_group_for_ref(const char *refname,
-					   const char *referent UNUSED,
-					   const struct object_id *oid,
-					   int flags UNUSED,
-					   void *_data)
+static int find_pseudo_merge_group_for_ref(const struct reference *ref, void *_data)
 {
 	struct bitmap_writer *writer = _data;
+	const struct object_id *maybe_peeled = ref->oid;
 	struct object_id peeled;
 	struct commit *c;
 	uint32_t i;
 	int has_bitmap;
 
-	if (!peel_iterated_oid(the_repository, oid, &peeled))
-		oid = &peeled;
+	if (!peel_iterated_oid(the_repository, ref->oid, &peeled))
+		maybe_peeled = &peeled;
 
-	c = lookup_commit(the_repository, oid);
+	c = lookup_commit(the_repository, maybe_peeled);
 	if (!c)
 		return 0;
-	if (!packlist_find(writer->to_pack, oid))
+	if (!packlist_find(writer->to_pack, maybe_peeled))
 		return 0;
 
-	has_bitmap = bitmap_writer_has_bitmapped_object_id(writer, oid);
+	has_bitmap = bitmap_writer_has_bitmapped_object_id(writer, maybe_peeled);
 
 	for (i = 0; i < writer->pseudo_merge_groups.nr; i++) {
 		struct pseudo_merge_group *group;
@@ -252,7 +249,7 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
 		size_t j;
 
 		group = writer->pseudo_merge_groups.items[i].util;
-		if (regexec(group->pattern, refname, ARRAY_SIZE(captures),
+		if (regexec(group->pattern, ref->name, ARRAY_SIZE(captures),
 			    captures, 0))
 			continue;
 
@@ -269,7 +266,7 @@ static int find_pseudo_merge_group_for_ref(const char *refname,
 			if (group_name.len)
 				strbuf_addch(&group_name, '-');
 
-			strbuf_add(&group_name, refname + match->rm_so,
+			strbuf_add(&group_name, ref->name + match->rm_so,
 				   match->rm_eo - match->rm_so);
 		}
 
diff --git a/reachable.c b/reachable.c
index 22266db5233..b753c395530 100644
--- a/reachable.c
+++ b/reachable.c
@@ -83,18 +83,17 @@ static void add_rebase_files(struct rev_info *revs)
 	free_worktrees(worktrees);
 }
 
-static int add_one_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
-		       int flag, void *cb_data)
+static int add_one_ref(const struct reference *ref, void *cb_data)
 {
 	struct rev_info *revs = (struct rev_info *)cb_data;
 	struct object *object;
 
-	if ((flag & REF_ISSYMREF) && (flag & REF_ISBROKEN)) {
-		warning("symbolic ref is dangling: %s", path);
+	if ((ref->flags & REF_ISSYMREF) && (ref->flags & REF_ISBROKEN)) {
+		warning("symbolic ref is dangling: %s", ref->name);
 		return 0;
 	}
 
-	object = parse_object_or_die(the_repository, oid, path);
+	object = parse_object_or_die(the_repository, ref->oid, ref->name);
 	add_pending_object(revs, object, "");
 
 	return 0;
diff --git a/ref-filter.c b/ref-filter.c
index 30cc488d8ab..6837fa60a9b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2954,14 +2954,15 @@ struct ref_filter_cbdata {
  * A call-back given to for_each_ref().  Filter refs and keep them for
  * later object processing.
  */
-static int filter_one(const char *refname, const char *referent, const struct object_id *oid, int flag, void *cb_data)
+static int filter_one(const struct reference *ref, void *cb_data)
 {
 	struct ref_filter_cbdata *ref_cbdata = cb_data;
-	struct ref_array_item *ref;
+	struct ref_array_item *item;
 
-	ref = apply_ref_filter(refname, referent, oid, flag, ref_cbdata->filter);
-	if (ref)
-		ref_array_append(ref_cbdata->array, ref);
+	item = apply_ref_filter(ref->name, ref->target, ref->oid,
+				ref->flags, ref_cbdata->filter);
+	if (item)
+		ref_array_append(ref_cbdata->array, item);
 
 	return 0;
 }
@@ -2990,17 +2991,18 @@ struct ref_filter_and_format_cbdata {
 	} internal;
 };
 
-static int filter_and_format_one(const char *refname, const char *referent, const struct object_id *oid, int flag, void *cb_data)
+static int filter_and_format_one(const struct reference *ref, void *cb_data)
 {
 	struct ref_filter_and_format_cbdata *ref_cbdata = cb_data;
-	struct ref_array_item *ref;
+	struct ref_array_item *item;
 	struct strbuf output = STRBUF_INIT, err = STRBUF_INIT;
 
-	ref = apply_ref_filter(refname, referent, oid, flag, ref_cbdata->filter);
-	if (!ref)
+	item = apply_ref_filter(ref->name, ref->target, ref->oid,
+				ref->flags, ref_cbdata->filter);
+	if (!item)
 		return 0;
 
-	if (format_ref_array_item(ref, ref_cbdata->format, &output, &err))
+	if (format_ref_array_item(item, ref_cbdata->format, &output, &err))
 		die("%s", err.buf);
 
 	if (output.len || !ref_cbdata->format->array_opts.omit_empty) {
@@ -3010,7 +3012,7 @@ static int filter_and_format_one(const char *refname, const char *referent, cons
 
 	strbuf_release(&output);
 	strbuf_release(&err);
-	free_array_item(ref);
+	free_array_item(item);
 
 	/*
 	 * Increment the running count of refs that match the filter. If
diff --git a/reflog.c b/reflog.c
index 65ef259b4f5..ac87e20c4f9 100644
--- a/reflog.c
+++ b/reflog.c
@@ -423,16 +423,13 @@ int should_expire_reflog_ent_verbose(struct object_id *ooid,
 	return expire;
 }
 
-static int push_tip_to_list(const char *refname UNUSED,
-			    const char *referent UNUSED,
-			    const struct object_id *oid,
-			    int flags, void *cb_data)
+static int push_tip_to_list(const struct reference *ref, void *cb_data)
 {
 	struct commit_list **list = cb_data;
 	struct commit *tip_commit;
-	if (flags & REF_ISSYMREF)
+	if (ref->flags & REF_ISSYMREF)
 		return 0;
-	tip_commit = lookup_commit_reference_gently(the_repository, oid, 1);
+	tip_commit = lookup_commit_reference_gently(the_repository, ref->oid, 1);
 	if (!tip_commit)
 		return 0;
 	commit_list_insert(tip_commit, list);
diff --git a/refs.c b/refs.c
index 965381367e0..25f0579d610 100644
--- a/refs.c
+++ b/refs.c
@@ -426,17 +426,19 @@ int refs_ref_exists(struct ref_store *refs, const char *refname)
 					 NULL, NULL);
 }
 
-static int for_each_filter_refs(const char *refname, const char *referent,
-				const struct object_id *oid,
-				int flags, void *data)
+static int for_each_filter_refs(const struct reference *ref, void *data)
 {
 	struct for_each_ref_filter *filter = data;
 
-	if (wildmatch(filter->pattern, refname, 0))
+	if (wildmatch(filter->pattern, ref->name, 0))
 		return 0;
-	if (filter->prefix)
-		skip_prefix(refname, filter->prefix, &refname);
-	return filter->fn(refname, referent, oid, flags, filter->cb_data);
+	if (filter->prefix) {
+		struct reference skipped = *ref;
+		skip_prefix(skipped.name, filter->prefix, &skipped.name);
+		return filter->fn(&skipped, filter->cb_data);
+	} else {
+		return filter->fn(ref, filter->cb_data);
+	}
 }
 
 struct warn_if_dangling_data {
@@ -447,17 +449,15 @@ struct warn_if_dangling_data {
 	int dry_run;
 };
 
-static int warn_if_dangling_symref(const char *refname, const char *referent UNUSED,
-				   const struct object_id *oid UNUSED,
-				   int flags, void *cb_data)
+static int warn_if_dangling_symref(const struct reference *ref, void *cb_data)
 {
 	struct warn_if_dangling_data *d = cb_data;
 	const char *resolves_to, *msg;
 
-	if (!(flags & REF_ISSYMREF))
+	if (!(ref->flags & REF_ISSYMREF))
 		return 0;
 
-	resolves_to = refs_resolve_ref_unsafe(d->refs, refname, 0, NULL, NULL);
+	resolves_to = refs_resolve_ref_unsafe(d->refs, ref->name, 0, NULL, NULL);
 	if (!resolves_to
 	    || !string_list_has_string(d->refnames, resolves_to)) {
 		return 0;
@@ -466,7 +466,7 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
 	msg = d->dry_run
 		? _("%s%s will become dangling after %s is deleted\n")
 		: _("%s%s has become dangling after %s was deleted\n");
-	fprintf(d->fp, msg, d->indent, refname, resolves_to);
+	fprintf(d->fp, msg, d->indent, ref->name, resolves_to);
 	return 0;
 }
 
@@ -507,8 +507,15 @@ int refs_head_ref_namespaced(struct ref_store *refs, each_ref_fn fn, void *cb_da
 	int flag;
 
 	strbuf_addf(&buf, "%sHEAD", get_git_namespace());
-	if (!refs_read_ref_full(refs, buf.buf, RESOLVE_REF_READING, &oid, &flag))
-		ret = fn(buf.buf, NULL, &oid, flag, cb_data);
+	if (!refs_read_ref_full(refs, buf.buf, RESOLVE_REF_READING, &oid, &flag)) {
+		struct reference ref = {
+			.name = buf.buf,
+			.oid = &oid,
+			.flags = flag,
+		};
+
+		ret = fn(&ref, cb_data);
+	}
 	strbuf_release(&buf);
 
 	return ret;
@@ -1741,8 +1748,15 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 	int flag;
 
 	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
-				    &oid, &flag))
-		return fn("HEAD", NULL, &oid, flag, cb_data);
+				    &oid, &flag)) {
+		struct reference ref = {
+			.name = "HEAD",
+			.oid = &oid,
+			.flags = flag,
+		};
+
+		return fn(&ref, cb_data);
+	}
 
 	return 0;
 }
@@ -2753,14 +2767,10 @@ struct do_for_each_reflog_help {
 	void *cb_data;
 };
 
-static int do_for_each_reflog_helper(const char *refname,
-				     const char *referent UNUSED,
-				     const struct object_id *oid UNUSED,
-				     int flags UNUSED,
-				     void *cb_data)
+static int do_for_each_reflog_helper(const struct reference *ref, void *cb_data)
 {
 	struct do_for_each_reflog_help *hp = cb_data;
-	return hp->fn(refname, hp->cb_data);
+	return hp->fn(ref->name, hp->cb_data);
 }
 
 int refs_for_each_reflog(struct ref_store *refs, each_reflog_fn fn, void *cb_data)
@@ -2976,25 +2986,24 @@ struct migration_data {
 	uint64_t index;
 };
 
-static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			   int flags, void *cb_data)
+static int migrate_one_ref(const struct reference *ref, void *cb_data)
 {
 	struct migration_data *data = cb_data;
 	struct strbuf symref_target = STRBUF_INIT;
 	int ret;
 
-	if (flags & REF_ISSYMREF) {
-		ret = refs_read_symbolic_ref(data->old_refs, refname, &symref_target);
+	if (ref->flags & REF_ISSYMREF) {
+		ret = refs_read_symbolic_ref(data->old_refs, ref->name, &symref_target);
 		if (ret < 0)
 			goto done;
 
-		ret = ref_transaction_update(data->transaction, refname, NULL, null_oid(the_hash_algo),
+		ret = ref_transaction_update(data->transaction, ref->name, NULL, null_oid(the_hash_algo),
 					     symref_target.buf, NULL,
 					     REF_SKIP_CREATE_REFLOG | REF_NO_DEREF, NULL, data->errbuf);
 		if (ret < 0)
 			goto done;
 	} else {
-		ret = ref_transaction_create(data->transaction, refname, oid, NULL,
+		ret = ref_transaction_create(data->transaction, ref->name, ref->oid, NULL,
 					     REF_SKIP_CREATE_REFLOG | REF_SKIP_OID_VERIFICATION,
 					     NULL, data->errbuf);
 		if (ret < 0)
diff --git a/refs.h b/refs.h
index 4e6bd63aa86..68d235438c2 100644
--- a/refs.h
+++ b/refs.h
@@ -355,14 +355,32 @@ struct ref_transaction;
  */
 #define REF_BAD_NAME 0x08
 
+/* A reference passed to `for_each_ref()`-style callbacks. */
+struct reference {
+	/* The fully-qualified name of the reference. */
+	const char *name;
+
+	/* The target of a symbolic ref. `NULL` for direct references. */
+	const char *target;
+
+	/*
+	 * The object ID of a reference. Either the direct object ID or the
+	 * resolved object ID in the case of a symbolic ref. May be the zero
+	 * object ID in case the symbolic ref cannot be resolved.
+	 */
+	const struct object_id *oid;
+
+	/* A bitfield of `REF_` flags. */
+	int flags;
+};
+
 /*
  * The signature for the callback function for the for_each_*()
- * functions below.  The memory pointed to by the refname and oid
- * arguments is only guaranteed to be valid for the duration of a
+ * functions below.  The memory pointed to by the `struct reference`
+ * argument is only guaranteed to be valid for the duration of a
  * single callback invocation.
  */
-typedef int each_ref_fn(const char *refname, const char *referent,
-			const struct object_id *oid, int flags, void *cb_data);
+typedef int each_ref_fn(const struct reference *ref, void *cb_data);
 
 /*
  * The following functions invoke the specified callback function for
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8d7007f4aaa..eb3142f8f2d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3150,14 +3150,11 @@ static int parse_and_write_reflog(struct files_ref_store *refs,
 	return 0;
 }
 
-static int ref_present(const char *refname, const char *referent UNUSED,
-		       const struct object_id *oid UNUSED,
-		       int flags UNUSED,
-		       void *cb_data)
+static int ref_present(const struct reference *ref, void *cb_data)
 {
 	struct string_list *affected_refnames = cb_data;
 
-	return string_list_has_string(affected_refnames, refname);
+	return string_list_has_string(affected_refnames, ref->name);
 }
 
 static int files_transaction_finish_initial(struct files_ref_store *refs,
diff --git a/refs/iterator.c b/refs/iterator.c
index 17ef841d8a3..7f2e718f1c9 100644
--- a/refs/iterator.c
+++ b/refs/iterator.c
@@ -476,7 +476,14 @@ int do_for_each_ref_iterator(struct ref_iterator *iter,
 
 	current_ref_iter = iter;
 	while ((ok = ref_iterator_advance(iter)) == ITER_OK) {
-		retval = fn(iter->refname, iter->referent, iter->oid, iter->flags, cb_data);
+		struct reference ref = {
+			.name = iter->refname,
+			.target = iter->referent,
+			.oid = iter->oid,
+			.flags = iter->flags,
+		};
+
+		retval = fn(&ref, cb_data);
 		if (retval)
 			goto out;
 	}
diff --git a/remote.c b/remote.c
index df9675cd330..59b37151208 100644
--- a/remote.c
+++ b/remote.c
@@ -2315,21 +2315,19 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 	return 1;
 }
 
-static int one_local_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			 int flag UNUSED,
-			 void *cb_data)
+static int one_local_ref(const struct reference *ref, void *cb_data)
 {
 	struct ref ***local_tail = cb_data;
-	struct ref *ref;
+	struct ref *local_ref;
 
 	/* we already know it starts with refs/ to get here */
-	if (check_refname_format(refname + 5, 0))
+	if (check_refname_format(ref->name + 5, 0))
 		return 0;
 
-	ref = alloc_ref(refname);
-	oidcpy(&ref->new_oid, oid);
-	**local_tail = ref;
-	*local_tail = &ref->next;
+	local_ref = alloc_ref(ref->name);
+	oidcpy(&local_ref->new_oid, ref->oid);
+	**local_tail = local_ref;
+	*local_tail = &local_ref->next;
 	return 0;
 }
 
@@ -2402,15 +2400,14 @@ struct stale_heads_info {
 	struct refspec *rs;
 };
 
-static int get_stale_heads_cb(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-			      int flags, void *cb_data)
+static int get_stale_heads_cb(const struct reference *ref, void *cb_data)
 {
 	struct stale_heads_info *info = cb_data;
 	struct string_list matches = STRING_LIST_INIT_DUP;
 	struct refspec_item query;
 	int i, stale = 1;
 	memset(&query, 0, sizeof(struct refspec_item));
-	query.dst = (char *)refname;
+	query.dst = (char *)ref->name;
 
 	refspec_find_all_matches(info->rs, &query, &matches);
 	if (matches.nr == 0)
@@ -2423,7 +2420,7 @@ static int get_stale_heads_cb(const char *refname, const char *referent UNUSED,
 	 * overlapping refspecs, we need to go over all of the
 	 * matching refs.
 	 */
-	if (flags & REF_ISSYMREF)
+	if (ref->flags & REF_ISSYMREF)
 		goto clean_exit;
 
 	for (i = 0; stale && i < matches.nr; i++)
@@ -2431,8 +2428,8 @@ static int get_stale_heads_cb(const char *refname, const char *referent UNUSED,
 			stale = 0;
 
 	if (stale) {
-		struct ref *ref = make_linked_ref(refname, &info->stale_refs_tail);
-		oidcpy(&ref->new_oid, oid);
+		struct ref *linked_ref = make_linked_ref(ref->name, &info->stale_refs_tail);
+		oidcpy(&linked_ref->new_oid, ref->oid);
 	}
 
 clean_exit:
diff --git a/repack-midx.c b/repack-midx.c
index 6f6202c5bcc..349f7e20b53 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -16,25 +16,23 @@ struct midx_snapshot_ref_data {
 	int preferred;
 };
 
-static int midx_snapshot_ref_one(const char *refname UNUSED,
-				 const char *referent UNUSED,
-				 const struct object_id *oid,
-				 int flag UNUSED, void *_data)
+static int midx_snapshot_ref_one(const struct reference *ref, void *_data)
 {
 	struct midx_snapshot_ref_data *data = _data;
+	const struct object_id *maybe_peeled = ref->oid;
 	struct object_id peeled;
 
-	if (!peel_iterated_oid(data->repo, oid, &peeled))
-		oid = &peeled;
+	if (!peel_iterated_oid(data->repo, ref->oid, &peeled))
+		maybe_peeled = &peeled;
 
-	if (oidset_insert(&data->seen, oid))
+	if (oidset_insert(&data->seen, maybe_peeled))
 		return 0; /* already seen */
 
-	if (odb_read_object_info(data->repo->objects, oid, NULL) != OBJ_COMMIT)
+	if (odb_read_object_info(data->repo->objects, maybe_peeled, NULL) != OBJ_COMMIT)
 		return 0;
 
 	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
-		oid_to_hex(oid));
+		oid_to_hex(maybe_peeled));
 
 	return 0;
 }
diff --git a/replace-object.c b/replace-object.c
index 3eae0510745..03d0f1f083b 100644
--- a/replace-object.c
+++ b/replace-object.c
@@ -8,31 +8,27 @@
 #include "repository.h"
 #include "commit.h"
 
-static int register_replace_ref(const char *refname,
-				const char *referent UNUSED,
-				const struct object_id *oid,
-				int flag UNUSED,
-				void *cb_data)
+static int register_replace_ref(const struct reference *ref, void *cb_data)
 {
 	struct repository *r = cb_data;
 
 	/* Get sha1 from refname */
-	const char *slash = strrchr(refname, '/');
-	const char *hash = slash ? slash + 1 : refname;
+	const char *slash = strrchr(ref->name, '/');
+	const char *hash = slash ? slash + 1 : ref->name;
 	struct replace_object *repl_obj = xmalloc(sizeof(*repl_obj));
 
 	if (get_oid_hex_algop(hash, &repl_obj->original.oid, r->hash_algo)) {
 		free(repl_obj);
-		warning(_("bad replace ref name: %s"), refname);
+		warning(_("bad replace ref name: %s"), ref->name);
 		return 0;
 	}
 
 	/* Copy sha1 from the read ref */
-	oidcpy(&repl_obj->replacement, oid);
+	oidcpy(&repl_obj->replacement, ref->oid);
 
 	/* Register new object */
 	if (oidmap_put(&r->objects->replace_map, repl_obj))
-		die(_("duplicate replace ref: %s"), refname);
+		die(_("duplicate replace ref: %s"), ref->name);
 
 	return 0;
 }
diff --git a/revision.c b/revision.c
index cf5e6c1ec9e..5f0850ae5c9 100644
--- a/revision.c
+++ b/revision.c
@@ -1644,19 +1644,17 @@ struct all_refs_cb {
 	struct worktree *wt;
 };
 
-static int handle_one_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
-			  int flag UNUSED,
-			  void *cb_data)
+static int handle_one_ref(const struct reference *ref, void *cb_data)
 {
 	struct all_refs_cb *cb = cb_data;
 	struct object *object;
 
-	if (ref_excluded(&cb->all_revs->ref_excludes, path))
+	if (ref_excluded(&cb->all_revs->ref_excludes, ref->name))
 	    return 0;
 
-	object = get_reference(cb->all_revs, path, oid, cb->all_flags);
-	add_rev_cmdline(cb->all_revs, object, path, REV_CMD_REF, cb->all_flags);
-	add_pending_object(cb->all_revs, object, path);
+	object = get_reference(cb->all_revs, ref->name, ref->oid, cb->all_flags);
+	add_rev_cmdline(cb->all_revs, object, ref->name, REV_CMD_REF, cb->all_flags);
+	add_pending_object(cb->all_revs, object, ref->name);
 	return 0;
 }
 
diff --git a/server-info.c b/server-info.c
index 1d33de821e9..0a07c722e8b 100644
--- a/server-info.c
+++ b/server-info.c
@@ -148,23 +148,21 @@ static int update_info_file(struct repository *r, char *path,
 	return ret;
 }
 
-static int add_info_ref(const char *path, const char *referent UNUSED, const struct object_id *oid,
-			int flag UNUSED,
-			void *cb_data)
+static int add_info_ref(const struct reference *ref, void *cb_data)
 {
 	struct update_info_ctx *uic = cb_data;
-	struct object *o = parse_object(uic->repo, oid);
+	struct object *o = parse_object(uic->repo, ref->oid);
 	if (!o)
 		return -1;
 
-	if (uic_printf(uic, "%s	%s\n", oid_to_hex(oid), path) < 0)
+	if (uic_printf(uic, "%s	%s\n", oid_to_hex(ref->oid), ref->name) < 0)
 		return -1;
 
 	if (o->type == OBJ_TAG) {
-		o = deref_tag(uic->repo, o, path, 0);
+		o = deref_tag(uic->repo, o, ref->name, 0);
 		if (o)
 			if (uic_printf(uic, "%s	%s^{}\n",
-				oid_to_hex(&o->oid), path) < 0)
+				oid_to_hex(&o->oid), ref->name) < 0)
 				return -1;
 	}
 	return 0;
diff --git a/shallow.c b/shallow.c
index d9cd4e219cb..55b9cd9d3f2 100644
--- a/shallow.c
+++ b/shallow.c
@@ -626,14 +626,10 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 	free(tmp);
 }
 
-static int mark_uninteresting(const char *refname UNUSED,
-			      const char *referent UNUSED,
-			      const struct object_id *oid,
-			      int flags UNUSED,
-			      void *cb_data UNUSED)
+static int mark_uninteresting(const struct reference *ref, void *cb_data UNUSED)
 {
 	struct commit *commit = lookup_commit_reference_gently(the_repository,
-							       oid, 1);
+							       ref->oid, 1);
 	if (!commit)
 		return 0;
 	commit->object.flags |= UNINTERESTING;
@@ -742,16 +738,12 @@ struct commit_array {
 	size_t nr, alloc;
 };
 
-static int add_ref(const char *refname UNUSED,
-		  const char *referent UNUSED,
-		   const struct object_id *oid,
-		   int flags UNUSED,
-		   void *cb_data)
+static int add_ref(const struct reference *ref, void *cb_data)
 {
 	struct commit_array *ca = cb_data;
 	ALLOC_GROW(ca->commits, ca->nr + 1, ca->alloc);
 	ca->commits[ca->nr] = lookup_commit_reference_gently(the_repository,
-							     oid, 1);
+							     ref->oid, 1);
 	if (ca->commits[ca->nr])
 		ca->nr++;
 	return 0;
diff --git a/submodule.c b/submodule.c
index 35c55155f7b..40a5c6fb9d1 100644
--- a/submodule.c
+++ b/submodule.c
@@ -934,10 +934,7 @@ static void free_submodules_data(struct string_list *submodules)
 	string_list_clear(submodules, 1);
 }
 
-static int has_remote(const char *refname UNUSED,
-		      const char *referent UNUSED,
-		      const struct object_id *oid UNUSED,
-		      int flags UNUSED, void *cb_data UNUSED)
+static int has_remote(const struct reference *ref UNUSED, void *cb_data UNUSED)
 {
 	return 1;
 }
@@ -1255,13 +1252,10 @@ int push_unpushed_submodules(struct repository *r,
 	return ret;
 }
 
-static int append_oid_to_array(const char *ref UNUSED,
-			       const char *referent UNUSED,
-			       const struct object_id *oid,
-			       int flags UNUSED, void *data)
+static int append_oid_to_array(const struct reference *ref, void *data)
 {
 	struct oid_array *array = data;
-	oid_array_append(array, oid);
+	oid_array_append(array, ref->oid);
 	return 0;
 }
 
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 83b06d39a36..b1215947c5e 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -154,10 +154,9 @@ static int cmd_rename_ref(struct ref_store *refs, const char **argv)
 	return refs_rename_ref(refs, oldref, newref, logmsg);
 }
 
-static int each_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-		    int flags, void *cb_data UNUSED)
+static int each_ref(const struct reference *ref, void *cb_data UNUSED)
 {
-	printf("%s %s 0x%x\n", oid_to_hex(oid), refname, flags);
+	printf("%s %s 0x%x\n", oid_to_hex(ref->oid), ref->name, ref->flags);
 	return 0;
 }
 
diff --git a/upload-pack.c b/upload-pack.c
index 1e87ae95593..0d563ae74e9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -870,8 +870,8 @@ static void send_unshallow(struct upload_pack_data *data)
 	}
 }
 
-static int check_ref(const char *refname_full, const char *referent UNUSED, const struct object_id *oid,
-		     int flag, void *cb_data);
+static int check_ref(const struct reference *ref, void *cb_data);
+
 static void deepen(struct upload_pack_data *data, int depth)
 {
 	if (depth == INFINITE_DEPTH && !is_repository_shallow(the_repository)) {
@@ -1224,13 +1224,12 @@ static int mark_our_ref(const char *refname, const char *refname_full,
 	return 0;
 }
 
-static int check_ref(const char *refname_full, const char *referent UNUSED,const struct object_id *oid,
-		     int flag UNUSED, void *cb_data)
+static int check_ref(const struct reference *ref, void *cb_data)
 {
-	const char *refname = strip_namespace(refname_full);
+	const char *refname = strip_namespace(ref->name);
 	struct upload_pack_data *data = cb_data;
 
-	mark_our_ref(refname, refname_full, oid, &data->hidden_refs);
+	mark_our_ref(refname, ref->name, ref->oid, &data->hidden_refs);
 	return 0;
 }
 
@@ -1292,27 +1291,25 @@ static void write_v0_ref(struct upload_pack_data *data,
 	return;
 }
 
-static int send_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
-		    int flag UNUSED, void *cb_data)
+static int send_ref(const struct reference *ref, void *cb_data)
 {
-	write_v0_ref(cb_data, refname, strip_namespace(refname), oid);
+	write_v0_ref(cb_data, ref->name, strip_namespace(ref->name), ref->oid);
 	return 0;
 }
 
-static int find_symref(const char *refname, const char *referent UNUSED,
-		       const struct object_id *oid UNUSED,
-		       int flag, void *cb_data)
+static int find_symref(const struct reference *ref, void *cb_data)
 {
 	const char *symref_target;
 	struct string_list_item *item;
+	int flag;
 
-	if ((flag & REF_ISSYMREF) == 0)
+	if ((ref->flags & REF_ISSYMREF) == 0)
 		return 0;
 	symref_target = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						refname, 0, NULL, &flag);
+						ref->name, 0, NULL, &flag);
 	if (!symref_target || (flag & REF_ISSYMREF) == 0)
-		die("'%s' is a symref but it is not?", refname);
-	item = string_list_append(cb_data, strip_namespace(refname));
+		die("'%s' is a symref but it is not?", ref->name);
+	item = string_list_append(cb_data, strip_namespace(ref->name));
 	item->util = xstrdup(strip_namespace(symref_target));
 	return 0;
 }
diff --git a/walker.c b/walker.c
index 80737545172..409b646578a 100644
--- a/walker.c
+++ b/walker.c
@@ -226,14 +226,10 @@ static int interpret_target(struct walker *walker, char *target, struct object_i
 	return -1;
 }
 
-static int mark_complete(const char *path UNUSED,
-			const char *referent UNUSED,
-			 const struct object_id *oid,
-			 int flag UNUSED,
-			 void *cb_data UNUSED)
+static int mark_complete(const struct reference *ref, void *cb_data UNUSED)
 {
 	struct commit *commit = lookup_commit_reference_gently(the_repository,
-							       oid, 1);
+							       ref->oid, 1);
 
 	if (commit) {
 		commit->object.flags |= COMPLETE;
diff --git a/worktree.c b/worktree.c
index a2a5f51f29f..9308389cb6f 100644
--- a/worktree.c
+++ b/worktree.c
@@ -595,8 +595,15 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 		if (refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
 					    refname.buf,
 					    RESOLVE_REF_READING,
-					    &oid, &flag))
-			ret = fn(refname.buf, NULL, &oid, flag, cb_data);
+					    &oid, &flag)) {
+			struct reference ref = {
+				.name = refname.buf,
+				.oid = &oid,
+				.flags = flag,
+			};
+
+			ret = fn(&ref, cb_data);
+		}
 		if (ret)
 			break;
 	}

-- 
2.51.1.930.gacf6e81ea2.dirty

