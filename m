Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C7785935
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408081; cv=none; b=MwcOi9ScNzrmb9o0X2PFt1+3BpmyPDyeCgtMK4derdxLg7ZZ5WUUkfOwx18HkgWAyL7O2nR9sdQuExk9L3mLP14V5Mi9exZws4AVHvqKcsWfaCZcIuCQ8PZdRNL72EZCsgO4uSR7a4OOkwb5q5sWIfZndKhPd6FuSsVE04kCZnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408081; c=relaxed/simple;
	bh=KNw1qcfIYYPFqADAk3ILdfynLT1V3gzR3eVTkb7nJC8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3lHbYy4H4Ywv+eFFIXKAPGlFVdE9ExYLuNcS/KQ1fADPWtqhPWeyVhZhEMI49iq9IWKTEDbMG1yX7F+vTxIjV+FVOevatUSmXlgsahR2q7pDecNbOOqB2Tk9LMjfa5T/KEpFtjFJWqhkBK0orjEHaEbVh83vOWyHeVXJabTtEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Tk5Timgy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CPZuh/Md; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Tk5Timgy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CPZuh/Md"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 30D331C000EF
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:47:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 03 Jun 2024 05:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408078; x=1717494478; bh=i+PeVsFR2F
	ZtMguTDnBmZOMOspMqp9V/r/EcE+5MGN4=; b=Tk5TimgyIv7ZxKZeVJ0/Ip97vL
	9ZdX2d8MjfNBNqobzVl/JfGXQS74rssJBIeFUJDJ4ZALDa7F5U8wk/AnwecKGrX8
	8n9uS94sccqB9WcHt6JQFf8YJXvk6nlsm4P0pT6iDVAiDJLz48CldQyaBogfWrQC
	reZCf19ysugpb75kghkbm5zyFU7gSUhhMpftQKYLw/QW6iNuxcX82aQTrMicdYGZ
	a7L9iZ37DgThoX5UbRyRmYSxeZusJ2qpEzkAx4/es8vVDA4M0xQ+YlF05VM3N+mG
	osj7Hc4PzBZekvkHwI3ZwD3YFP5Sl2PaOYM7LhTNuiZbfqhgUq2lHobJGVxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408078; x=1717494478; bh=i+PeVsFR2FZtMguTDnBmZOMOspMq
	p9V/r/EcE+5MGN4=; b=CPZuh/MdD/KsUJTERT0emnAtNd8aUX0ijjmgDRQP3DeL
	99DhjS/WW1pXVwVsQXzTwsAXqakbmfD4pIikAcHymYIsF5L+XOC73CGwkNwN2PMT
	6vOAReq8/AkxLzerLjIBRlSfQQiYu+MKAr5tj9cbU1n1yeqNQzml3xLn56JxAjHJ
	YdApua2N9KctQw6jtGHGNkA9vZJjfwMHlkH5nrr5MNEvGXyxbEMncIU3hkS8BoTu
	aokkvHKllV2mxQE2g6Q6VmPyil+KT+5RoSLutSXzP700+UcQD9qEhb0eD/OY86Z8
	kUP5HaheHHImJD+kZTiu6l107tbj4DL1YAQ+tAUPXw==
X-ME-Sender: <xms:TpFdZjVA5YNtN4-1XXZ1zDDLDEb-NVmm7iII8JwanX2T-7c2ek9olw>
    <xme:TpFdZrkQHo-GpBeNj7jNyH1BtLtjxyffhjN4T7e6JCUqc-NePzDwoK-jskicuJuI2
    CpCpljKaAPw6Fx0hA>
X-ME-Received: <xmr:TpFdZvasv8KMIxqIvHDebvFHdA3u6vusRXZ97kKVEc2JnfQiRcen3rRJVBs72onjb5A6QlwWr9RWpbgETxrMAXVnXr9-BGYszolpFwtGg83x-6Rm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:TpFdZuUUrSz0GFsBX4nUQzimuc7sVD2SGE0VXCAatifpjYroXb-OXA>
    <xmx:TpFdZtln15sL1kdbYrDhwnh_AO6ljdEJA6KdTWoYXffRAP5DFSgAZg>
    <xmx:TpFdZrfJ9kxZSmtrqznf7wMl8zEqCnjmD5ZGcI-685bVmPjQyhm_nA>
    <xmx:TpFdZnHen5cvtzDbjSRzI9ohxkuR6IVdMFPLT_RdmTPdPJdHp5umsA>
    <xmx:TpFdZtv3uZ1KLMMvRKr3vTH1yK7nElPq2mHJUGpYn0rszMUa8S7Y9itu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:47:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e418323a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:47:33 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:47:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 19/29] commit: fix leaking parents when calling
 `commit_tree_extended()`
Message-ID: <8ada8864d87b6396e63ac2224f0a9cdc73b2e2df.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Wq1L/6WTPH0SNeHz"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--Wq1L/6WTPH0SNeHz
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
2.45.1.410.g58bac47f8e.dirty


--Wq1L/6WTPH0SNeHz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkUoACgkQVbJhu7ck
PpQPGw//QmeqTl5tzZp2e9O2Z2pP7OH0uoQLt/+TB6hSKeG4e3p4MEH4oaBgO83H
LMAHSCjwsG80o/uIBfyM+3+BzNYjeVTdaVVG4u7aiWy6UghQSuIV87yGZqecGH+G
uMBGcGmoWym8542fHYsuVFX6YFyZtpdokmnLTtzmJ232pP4cPYz5/TXwRoI39+Lm
94OWtaO+XHhbxKo4TE8SWy8v3kwPr90UVqyazOwnivLIj7Cm9/wXpa8eyoCIwzRO
iHkQMgTJ+b9KtrjNeOO+otvI6zopOuJmSO69hShUUzDd5KqY4YWaXl0E4uZz7vWj
REnlNlDcqMm5YDAR0lCnGNEPnLqXLCA9hHu+GP43IiF5M8opKVJOlgYib75OkbsA
zLKfLDqNuTV9RYyhVTuax5eoAN2xNluvGlatoC3E1fUFRdOrgeza/j0Y5/Ixe4Zg
14Fwg/1NgnTkD4LCx8QdoYQuJWrWO2cfBJff7m6B64nPM7+kF2s2YJB23MwmcTxz
FuNdwfcW/C4D+y29TIblq1pUBfeY8DYb5jNvHPAvkGv3OTYb+HNBzKjCGKaLdxL1
uSOROK2g0TnYiAe/40/b3OVOeyvRdzAvBQorT8/rg+d1wgz+V3oJqBYz6rSGzrDH
OkOzli3bvvCWm+tMYU2wdBGvmUCZG5LhMZn3K5N7qgaW77ORmuI=
=ojIc
-----END PGP SIGNATURE-----

--Wq1L/6WTPH0SNeHz--
