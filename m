Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB517B40B
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097649; cv=none; b=TSbhj3M004GKgv0KzOjQU7CteASig8eubnIQylVuERwjGjViGd3UBNuXp5vMRiFgWnY+pMDSb2cCkQ6HP5op8XNDW92gpHyoc5ldZ9mkAczwyRmVrmssK8ay87z9iy5cPXmIhVZK6lXe0iD4NGha7Ceu+m10iULK4jjWg5vW4QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097649; c=relaxed/simple;
	bh=NAVvJIFIbHiQxMiKALsIQxcnl33/A3ZBv8mDHJmZpK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aUC+fwN/2lrXBf2HbaTRgF1wSG5OKycWrYp70uqQ3i7U2fOYDZpvZnGTEK6xZckBlx43vmjbTMYyaCu9bz/LF+RoBVdFgZBQegU3MTU9UCcGzzSU5XU+wepphNLHxc4EHltfW1oK3T8fdSKTuYJLXpHRZ0mLiwwsDh1KRxoAu2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fvM2JdZW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OMDGhHZs; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fvM2JdZW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OMDGhHZs"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7BE191800115;
	Tue, 11 Jun 2024 05:20:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 11 Jun 2024 05:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097646; x=1718184046; bh=XrXttInpva
	6HK0/34FOd8iykCTOWBvj+yAfv+X3jiJM=; b=fvM2JdZWUxAW+iJUqCgvgaxEsw
	9IDYV5oGDW6WQ250ugJLSOyVXDPrbxTXR/AoU/f+IUSqylG8PXY0mEmcA7Tvfl1B
	K0y8qIvTWUkRwLkY0OE7SJ19GGPvo5tUKpr9keFqrck+29OAjpUzyYuf31AbEv8v
	fJbtBbH/wQ/ANxacKvUp09baMHi8Aw3eiFw2Cag5ZXJYXH6qik7RJgRJqyi8xbdS
	6I3MfS7RsxgIG2+2qD4BOpDWulk/TrrhcWB/uQxSCbaYwUKhjLRrbRzWLM3QRyYT
	tYR5KJnQC3eyRud3So9QX+QFq4IPVTKosyZ03FkNz9bQkueivr9jxzytX5+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097646; x=1718184046; bh=XrXttInpva6HK0/34FOd8iykCTOW
	Bvj+yAfv+X3jiJM=; b=OMDGhHZsyWekXKEgbycL6vomWw4XGQ/wfs6Hlafs9xPU
	5gCPMRvVmyMXQEpU/CuvoGjo6H1XriR0M8S22hc0dJVVNgq72Rtmby3hRth73gd5
	Sn9kfBGlC1jN+p9AeJHHmrwfvgUkOM3ud4kT/eIbch7XTIDVujuRU5OJ39OtE7Ji
	0UYMPt6Ww/O1pTEdc7iw1ZHAKRh+d4QhEPcBMakRxRlWqc7pCI0IlPpevxbdg/v8
	K9eq3I13eYwwjo0YLAda5eM3W9sfhNZhXXSwVc9QD/4ml17iUcMWmhF1ZQ/u6Z/y
	Jqw5tLuKnEpGizBe4pUqKHjOkuE3KC1oLpC1A4A7ag==
X-ME-Sender: <xms:7RZoZsGWfo-VPBIh05u1oZ5rTdQcE0j8uPV_z7_JuAhv8m59WMbiAQ>
    <xme:7RZoZlWyOXRflftEkmfPFSOzN31Rm6aiCu32Dslmgct-d7EniWdLrMMobW1uMYxrp
    N-rLmdBdkTXYpSPHw>
X-ME-Received: <xmr:7RZoZmKkhWbDJaBrV_UHmLCu8Xikz6j9PAF-tMOiWhTsPmuT_Es_GPPpaRUK0W0b74YrSWxG3_c5tf03dBMl4jWysqI73OvdtCXt9S5B2jlFeIHHS2ru>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:7RZoZuF10oPIWeOKF69buKWMPtz5YhDqeCa-RH2TLZDaDl12k3Y7Xw>
    <xmx:7hZoZiUbNDwcS62JGj6GKaERZuCOM2ipog2BTUq1xWfftqTozdVAcg>
    <xmx:7hZoZhNplQ-tRzbkiBBxQumc39OtrIleGBfaSWslmaUeMWXW0cs_mg>
    <xmx:7hZoZp1gJql5xaOZHYkyKBNZ2cvy2U5j-WjATxwfUDCyrocr-5HUoQ>
    <xmx:7hZoZhS-7LDpeMfUf083DCgmdAaiOZtw-wWlW6jJRUfgUBC3CtOi-IbI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:20:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ecf42cef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:20:36 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:20:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 19/29] commit: fix leaking parents when calling
 `commit_tree_extended()`
Message-ID: <c1a1eb34aba9e824a7890f3b1429ceaf6a9cf7eb.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bYRcU2L0lBIYeD2r"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--bYRcU2L0lBIYeD2r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When creating commits via `commit_tree_extended()`, the caller passes in
a string list of parents. This call implicitly transfers ownership of
that list to the function, which is quite surprising to begin with. But
to make matters worse, `commit_tree_extended()` doesn't even bother to
free the list of parents in error cases. The result is a memory leak,
and one that the caller cannot fix by themselves because they do not
know whether parts of the string list have already been released.

Refactor the code such that callers can keep ownership of the list of
parents, which is getting indicated by parameter being a constant
pointer now. Free the lists at the calling site and add a common exit
path to those sites as required.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/am.c                       |  1 +
 builtin/commit-tree.c              | 11 ++++++++---
 builtin/commit.c                   |  3 ++-
 builtin/merge.c                    |  6 +++++-
 builtin/replay.c                   | 14 +++++++++-----
 builtin/stash.c                    |  9 ++++-----
 commit.c                           | 26 ++++++++++++--------------
 commit.h                           | 10 +++++-----
 notes-merge.c                      |  1 +
 notes-utils.c                      |  8 ++++++--
 notes-utils.h                      |  2 +-
 sequencer.c                        |  1 +
 t/t3403-rebase-skip.sh             |  1 +
 t/t3424-rebase-empty.sh            |  1 +
 t/t3505-cherry-pick-empty.sh       |  1 +
 t/t7505-prepare-commit-msg-hook.sh |  1 +
 16 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 4ba44e2d70..faccc45b13 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1718,6 +1718,7 @@ static void do_commit(const struct am_state *state)
=20
 	run_hooks("post-applypatch");
=20
+	free_commit_list(parents);
 	strbuf_release(&sb);
 }
=20
diff --git a/builtin/commit-tree.c b/builtin/commit-tree.c
index 1bb7819839..84bb450222 100644
--- a/builtin/commit-tree.c
+++ b/builtin/commit-tree.c
@@ -111,6 +111,7 @@ int cmd_commit_tree(int argc, const char **argv, const =
char *prefix)
 			N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_END()
 	};
+	int ret;
=20
 	git_config(git_default_config, NULL);
=20
@@ -132,11 +133,15 @@ int cmd_commit_tree(int argc, const char **argv, cons=
t char *prefix)
=20
 	if (commit_tree(buffer.buf, buffer.len, &tree_oid, parents, &commit_oid,
 			NULL, sign_commit)) {
-		strbuf_release(&buffer);
-		return 1;
+		ret =3D 1;
+		goto out;
 	}
=20
 	printf("%s\n", oid_to_hex(&commit_oid));
+	ret =3D 0;
+
+out:
+	free_commit_list(parents);
 	strbuf_release(&buffer);
-	return 0;
+	return ret;
 }
diff --git a/builtin/commit.c b/builtin/commit.c
index dcaf4efa03..d5713455e5 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1848,7 +1848,6 @@ int cmd_commit(int argc, const char **argv, const cha=
r *prefix)
 		rollback_index_files();
 		die(_("failed to write commit object"));
 	}
-	free_commit_extra_headers(extra);
=20
 	if (update_head_with_reflog(current_head, &oid, reflog_msg, &sb,
 				    &err)) {
@@ -1890,6 +1889,8 @@ int cmd_commit(int argc, const char **argv, const cha=
r *prefix)
 	apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
=20
 cleanup:
+	free_commit_extra_headers(extra);
+	free_commit_list(parents);
 	strbuf_release(&author_ident);
 	strbuf_release(&err);
 	strbuf_release(&sb);
diff --git a/builtin/merge.c b/builtin/merge.c
index daed2d4e1e..50b0c87a95 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -895,7 +895,7 @@ static void prepare_to_commit(struct commit_list *remot=
eheads)
 static int merge_trivial(struct commit *head, struct commit_list *remotehe=
ads)
 {
 	struct object_id result_tree, result_commit;
-	struct commit_list *parents, **pptr =3D &parents;
+	struct commit_list *parents =3D NULL, **pptr =3D &parents;
=20
 	if (repo_refresh_and_write_index(the_repository, REFRESH_QUIET,
 					 SKIP_IF_UNCHANGED, 0, NULL, NULL,
@@ -911,7 +911,9 @@ static int merge_trivial(struct commit *head, struct co=
mmit_list *remoteheads)
 			&result_commit, NULL, sign_commit))
 		die(_("failed to write commit object"));
 	finish(head, remoteheads, &result_commit, "In-index merge");
+
 	remove_merge_branch_state(the_repository);
+	free_commit_list(parents);
 	return 0;
 }
=20
@@ -937,8 +939,10 @@ static int finish_automerge(struct commit *head,
 		die(_("failed to write commit object"));
 	strbuf_addf(&buf, "Merge made by the '%s' strategy.", wt_strategy);
 	finish(head, remoteheads, &result_commit, buf.buf);
+
 	strbuf_release(&buf);
 	remove_merge_branch_state(the_repository);
+	free_commit_list(parents);
 	return 0;
 }
=20
diff --git a/builtin/replay.c b/builtin/replay.c
index 6bf0691f15..0448326636 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -52,11 +52,11 @@ static struct commit *create_commit(struct tree *tree,
 				    struct commit *parent)
 {
 	struct object_id ret;
-	struct object *obj;
+	struct object *obj =3D NULL;
 	struct commit_list *parents =3D NULL;
 	char *author;
 	char *sign_commit =3D NULL; /* FIXME: cli users might want to sign again =
*/
-	struct commit_extra_header *extra;
+	struct commit_extra_header *extra =3D NULL;
 	struct strbuf msg =3D STRBUF_INIT;
 	const char *out_enc =3D get_commit_output_encoding();
 	const char *message =3D repo_logmsg_reencode(the_repository, based_on,
@@ -73,12 +73,16 @@ static struct commit *create_commit(struct tree *tree,
 	if (commit_tree_extended(msg.buf, msg.len, &tree->object.oid, parents,
 				 &ret, author, NULL, sign_commit, extra)) {
 		error(_("failed to write commit object"));
-		return NULL;
+		goto out;
 	}
-	free(author);
-	strbuf_release(&msg);
=20
 	obj =3D parse_object(the_repository, &ret);
+
+out:
+	free_commit_extra_headers(extra);
+	free_commit_list(parents);
+	strbuf_release(&msg);
+	free(author);
 	return (struct commit *)obj;
 }
=20
diff --git a/builtin/stash.c b/builtin/stash.c
index 1ed0a9a5d9..46b981c4dd 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1416,6 +1416,9 @@ static int do_create_stash(const struct pathspec *ps,=
 struct strbuf *stash_msg_b
 		goto done;
 	}
=20
+	free_commit_list(parents);
+	parents =3D NULL;
+
 	if (include_untracked) {
 		if (save_untracked_files(info, &msg, untracked_files)) {
 			if (!quiet)
@@ -1461,11 +1464,6 @@ static int do_create_stash(const struct pathspec *ps=
, struct strbuf *stash_msg_b
 	else
 		strbuf_insertf(stash_msg_buf, 0, "On %s: ", branch_name);
=20
-	/*
-	 * `parents` will be empty after calling `commit_tree()`, so there is
-	 * no need to call `free_commit_list()`
-	 */
-	parents =3D NULL;
 	if (untracked_commit_option)
 		commit_list_insert(lookup_commit(the_repository,
 						 &info->u_commit),
@@ -1487,6 +1485,7 @@ static int do_create_stash(const struct pathspec *ps,=
 struct strbuf *stash_msg_b
 	strbuf_release(&commit_tree_label);
 	strbuf_release(&msg);
 	strbuf_release(&untracked_files);
+	free_commit_list(parents);
 	return ret;
 }
=20
diff --git a/commit.c b/commit.c
index 1d08951007..f674eca320 100644
--- a/commit.c
+++ b/commit.c
@@ -1262,7 +1262,7 @@ int remove_signature(struct strbuf *buf)
 	return sigs[0].start !=3D NULL;
 }
=20
-static void handle_signed_tag(struct commit *parent, struct commit_extra_h=
eader ***tail)
+static void handle_signed_tag(const struct commit *parent, struct commit_e=
xtra_header ***tail)
 {
 	struct merge_remote_desc *desc;
 	struct commit_extra_header *mergetag;
@@ -1359,17 +1359,17 @@ void verify_merge_signature(struct commit *commit, =
int verbosity,
 	signature_check_clear(&signature_check);
 }
=20
-void append_merge_tag_headers(struct commit_list *parents,
+void append_merge_tag_headers(const struct commit_list *parents,
 			      struct commit_extra_header ***tail)
 {
 	while (parents) {
-		struct commit *parent =3D parents->item;
+		const struct commit *parent =3D parents->item;
 		handle_signed_tag(parent, tail);
 		parents =3D parents->next;
 	}
 }
=20
-static int convert_commit_extra_headers(struct commit_extra_header *orig,
+static int convert_commit_extra_headers(const struct commit_extra_header *=
orig,
 					struct commit_extra_header **result)
 {
 	const struct git_hash_algo *compat =3D the_repository->compat_hash_algo;
@@ -1403,7 +1403,7 @@ static int convert_commit_extra_headers(struct commit=
_extra_header *orig,
 }
=20
 static void add_extra_header(struct strbuf *buffer,
-			     struct commit_extra_header *extra)
+			     const struct commit_extra_header *extra)
 {
 	strbuf_addstr(buffer, extra->key);
 	if (extra->len)
@@ -1517,7 +1517,7 @@ void free_commit_extra_headers(struct commit_extra_he=
ader *extra)
 }
=20
 int commit_tree(const char *msg, size_t msg_len, const struct object_id *t=
ree,
-		struct commit_list *parents, struct object_id *ret,
+		const struct commit_list *parents, struct object_id *ret,
 		const char *author, const char *sign_commit)
 {
 	struct commit_extra_header *extra =3D NULL, **tail =3D &extra;
@@ -1649,7 +1649,7 @@ static void write_commit_tree(struct strbuf *buffer, =
const char *msg, size_t msg
 			      const struct object_id *tree,
 			      const struct object_id *parents, size_t parents_len,
 			      const char *author, const char *committer,
-			      struct commit_extra_header *extra)
+			      const struct commit_extra_header *extra)
 {
 	int encoding_is_utf8;
 	size_t i;
@@ -1690,10 +1690,10 @@ static void write_commit_tree(struct strbuf *buffer=
, const char *msg, size_t msg
=20
 int commit_tree_extended(const char *msg, size_t msg_len,
 			 const struct object_id *tree,
-			 struct commit_list *parents, struct object_id *ret,
+			 const struct commit_list *parents, struct object_id *ret,
 			 const char *author, const char *committer,
 			 const char *sign_commit,
-			 struct commit_extra_header *extra)
+			 const struct commit_extra_header *extra)
 {
 	struct repository *r =3D the_repository;
 	int result =3D 0;
@@ -1715,10 +1715,8 @@ int commit_tree_extended(const char *msg, size_t msg=
_len,
 	nparents =3D commit_list_count(parents);
 	CALLOC_ARRAY(parent_buf, nparents);
 	i =3D 0;
-	while (parents) {
-		struct commit *parent =3D pop_commit(&parents);
-		oidcpy(&parent_buf[i++], &parent->object.oid);
-	}
+	for (const struct commit_list *p =3D parents; p; p =3D p->next)
+		oidcpy(&parent_buf[i++], &p->item->object.oid);
=20
 	write_commit_tree(&buffer, msg, msg_len, tree, parent_buf, nparents, auth=
or, committer, extra);
 	if (sign_commit && sign_commit_to_strbuf(&sig, &buffer, sign_commit)) {
@@ -1814,7 +1812,7 @@ int commit_tree_extended(const char *msg, size_t msg_=
len,
 define_commit_slab(merge_desc_slab, struct merge_remote_desc *);
 static struct merge_desc_slab merge_desc_slab =3D COMMIT_SLAB_INIT(1, merg=
e_desc_slab);
=20
-struct merge_remote_desc *merge_remote_util(struct commit *commit)
+struct merge_remote_desc *merge_remote_util(const struct commit *commit)
 {
 	return *merge_desc_slab_at(&merge_desc_slab, commit);
 }
diff --git a/commit.h b/commit.h
index 62fe0d77a7..442e50ff24 100644
--- a/commit.h
+++ b/commit.h
@@ -260,19 +260,19 @@ struct commit_extra_header {
 	size_t len;
 };
=20
-void append_merge_tag_headers(struct commit_list *parents,
+void append_merge_tag_headers(const struct commit_list *parents,
 			      struct commit_extra_header ***tail);
=20
 int commit_tree(const char *msg, size_t msg_len,
 		const struct object_id *tree,
-		struct commit_list *parents, struct object_id *ret,
+		const struct commit_list *parents, struct object_id *ret,
 		const char *author, const char *sign_commit);
=20
 int commit_tree_extended(const char *msg, size_t msg_len,
 			 const struct object_id *tree,
-			 struct commit_list *parents, struct object_id *ret,
+			 const struct commit_list *parents, struct object_id *ret,
 			 const char *author, const char *committer,
-			 const char *sign_commit, struct commit_extra_header *);
+			 const char *sign_commit, const struct commit_extra_header *);
=20
 struct commit_extra_header *read_commit_extra_headers(struct commit *, con=
st char **);
=20
@@ -306,7 +306,7 @@ struct merge_remote_desc {
 	struct object *obj; /* the named object, could be a tag */
 	char name[FLEX_ARRAY];
 };
-struct merge_remote_desc *merge_remote_util(struct commit *);
+struct merge_remote_desc *merge_remote_util(const struct commit *);
 void set_merge_remote_desc(struct commit *commit,
 			   const char *name, struct object *obj);
=20
diff --git a/notes-merge.c b/notes-merge.c
index 6a9a139b12..f3cc84f45d 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -661,6 +661,7 @@ int notes_merge(struct notes_merge_options *o,
 		commit_list_insert(local, &parents);
 		create_notes_commit(o->repo, local_tree, parents, o->commit_msg.buf,
 				    o->commit_msg.len, result_oid);
+		free_commit_list(parents);
 	}
=20
 found_result:
diff --git a/notes-utils.c b/notes-utils.c
index 671d1969b1..3198c14e4d 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -9,10 +9,11 @@
=20
 void create_notes_commit(struct repository *r,
 			 struct notes_tree *t,
-			 struct commit_list *parents,
+			 const struct commit_list *parents,
 			 const char *msg, size_t msg_len,
 			 struct object_id *result_oid)
 {
+	struct commit_list *parents_to_free =3D NULL;
 	struct object_id tree_oid;
=20
 	assert(t->initialized);
@@ -27,7 +28,8 @@ void create_notes_commit(struct repository *r,
 			struct commit *parent =3D lookup_commit(r, &parent_oid);
 			if (repo_parse_commit(r, parent))
 				die("Failed to find/parse commit %s", t->ref);
-			commit_list_insert(parent, &parents);
+			commit_list_insert(parent, &parents_to_free);
+			parents =3D parents_to_free;
 		}
 		/* else: t->ref points to nothing, assume root/orphan commit */
 	}
@@ -35,6 +37,8 @@ void create_notes_commit(struct repository *r,
 	if (commit_tree(msg, msg_len, &tree_oid, parents, result_oid, NULL,
 			NULL))
 		die("Failed to commit notes tree to database");
+
+	free_commit_list(parents_to_free);
 }
=20
 void commit_notes(struct repository *r, struct notes_tree *t, const char *=
msg)
diff --git a/notes-utils.h b/notes-utils.h
index d9b3c09eaf..c54b1fe141 100644
--- a/notes-utils.h
+++ b/notes-utils.h
@@ -20,7 +20,7 @@ struct repository;
  */
 void create_notes_commit(struct repository *r,
 			 struct notes_tree *t,
-			 struct commit_list *parents,
+			 const struct commit_list *parents,
 			 const char *msg, size_t msg_len,
 			 struct object_id *result_oid);
=20
diff --git a/sequencer.c b/sequencer.c
index 30513e87bf..475646671a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -1711,6 +1711,7 @@ static int try_to_commit(struct repository *r,
=20
 out:
 	free_commit_extra_headers(extra);
+	free_commit_list(parents);
 	strbuf_release(&err);
 	strbuf_release(&commit_msg);
 	free(amend_author);
diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index a1911c4a9d..4f1d6e8ea6 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -8,6 +8,7 @@ test_description=3D'git rebase --merge --skip tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3424-rebase-empty.sh b/t/t3424-rebase-empty.sh
index 1ee6b00fd5..515c949ae3 100755
--- a/t/t3424-rebase-empty.sh
+++ b/t/t3424-rebase-empty.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'git rebase of commits that start or become empty'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup test repository' '
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index 9748443530..ead3fb4680 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -5,6 +5,7 @@ test_description=3D'test cherry-picking an empty commit'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t7505-prepare-commit-msg-hook.sh b/t/t7505-prepare-commit-ms=
g-hook.sh
index 2128142a61..b88383df9e 100755
--- a/t/t7505-prepare-commit-msg-hook.sh
+++ b/t/t7505-prepare-commit-msg-hook.sh
@@ -5,6 +5,7 @@ test_description=3D'prepare-commit-msg hook'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'set up commits for rebasing' '
--=20
2.45.2.436.gcd77e87115.dirty


--bYRcU2L0lBIYeD2r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFuoACgkQVbJhu7ck
PpTARBAAgvm52rCQgITgVasb1Kt5DsqMbam/2qkh7EQkaSMKyyA1TUIPHeJN66aa
OZ50YQK7hZpeUKF76+fdJuvoxuySZRMW6fB+NDqcr405zpnXyRjiGnq01YB8o+i3
XsmPSFQg+c9KTn91KhhiyJQwcDZRmC8aS68YoeRZaMl/9J0Ik4gTrpwOrNEOy1/B
/GZ7GMzxy3X6HuEkqvSQ2W77eRyuPu/BG7jD+aeMZ5EXYW60908jHVLsbqFhIUcT
Qdb7AncdYW0qk/FhJzpCxg3y+xFGPtfuxPWv1BGJhth+/eDbUugRJkIpLpy2NFxj
TKBj45SMmUzaaagv0Wgi20PoLeJYufdtf+wFPTv6OKZTeVgeaUXdUeTRB0t1oCKN
GpAbXPMLT14hPynM1UEG3tGV70S20Wn88yG3ZpSLXS1un79HKgYle1at0W9XTuTl
nvOKqRRVNNEZpzgYwNQP2KiRLSBDsXr11/RdtY8trSilTuf+zlMuTqkv4e0BuPaD
tOV47IpqadXd0BzIo1sK+r6pUeaZK0ZbpTDnIXAwZt7W2TElRt4IFRVB7RygyWr1
LnEeih2pvQfNDckTvb9xchwlkbsMoXq+gJf5b31h8ngkMS6w+IQUiU0ghjZGg39k
NL8qmlsRH99WckMz2A1tCnfBYn/P9I7REhP5+wrh05uwU5EXc9g=
=FvQd
-----END PGP SIGNATURE-----

--bYRcU2L0lBIYeD2r--
