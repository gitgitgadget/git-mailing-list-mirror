Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5C017624A
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097677; cv=none; b=HYpRFzEiQVDW9+pbi5yR4OWgsL0d5ngsv5dgkj1Kng3C2Ll1WrOn2S10VF+eRWVkHgAMdEmS+cv3XFN2QIs66Vk8+3Fa9GLwbAWlHEhKkU6aLWyntdTVULxhBRsUlckdN013RB2Pvs79wJ7vQIBsli48R1lz/l8AO8DgWiwDi2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097677; c=relaxed/simple;
	bh=YcfZaYG1CdaycKf413zUqrP7m6lLFdMkfkuNgoUGelc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lll0uiv5ZpajyPA+b/1MVew41PJax/LzA+8XNPCNnoiCFkHhXJp20OL5aaB0h3bUtt0CxqfJDOVQPzFoDNX4Sr82kITwMFGzNP77+BY4ArdUPotyo1PHLM9aq/3thK52gONNJ3m4bgJqMlt/IE4s2Sr8PRU80M/TFJSkkSMRHaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B1o9qI+W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lmXfxZQG; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B1o9qI+W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lmXfxZQG"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 44D5D1800076;
	Tue, 11 Jun 2024 05:21:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 11 Jun 2024 05:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097674; x=1718184074; bh=JNOUQfNsK3
	3VIKFzqF/MP92SGw+QfECLoCqWdfys3Kw=; b=B1o9qI+WEzNvJcQcM0XohYknwd
	rPchIKVlCpC9JvZcVzo8vSyU/8iO3QSdtIZcWEVlDvSac5T7q8x3njVThVytgTdF
	b3u39ZbDSpLajUOtFQ1GUatLFiLD2m4xNB8bhbqAX9naiK9TL8ZFIZWaRMkv/A1c
	/kNnl2qrEeQg9TtwH2oG4e+wHCV/H7oikzBM16ozOzgU9dUVYb9VVnqhSyXrt88h
	Mx6LQ/KYE3zpsEJQCvfuwdeifZTtO97oY/U5pqqxPEGRtiiFyz6JhO314Eg0qv36
	I27WhBbIz/xjn32l1vC2LIWjJKAQcwpgQ5N0vQA23XR2spHMbQmtLVA8Dj2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097674; x=1718184074; bh=JNOUQfNsK33VIKFzqF/MP92SGw+Q
	fECLoCqWdfys3Kw=; b=lmXfxZQGMkyR/gxpccUyQVC3A6kHfOJ85TgpFTaxM8TT
	CEWW0/uABDLAUCHycg1Ufgr4MtqexHQZacz4FYTZ/C1MZOJz4+GYN821vqejnBgi
	VLdAxAmCnktqmqfNvmYlyKKR3R2/Yd5AL8JXolCOucyP31PZlXzwRVAcju5QqutF
	gU0CLQiPxYDOAuitcX35A/7UL1xzhC7Carb5Zc9FYN2Scn/54z4sWywyH1XAF5HN
	zsalnb+y/9uMATDp3gHJD4ZkXZ0Fl8di21unir+TuVMv7I15R9D66JEJ5baV6rCh
	PfOZwzuQSWZ2l1w5J0YROGlrWha0R1kch2DuVSpGrw==
X-ME-Sender: <xms:ChdoZr91eOrnBXimH9lPje5goDDFQoIotsvRfPuQuQeNNr8MLWHEsA>
    <xme:ChdoZnvYHYUC1_m7BGb0D4ASSQ8M13dXXeV4wsEJaiVHNaJUpwp8oEXMhPv0CCCb_
    pNlegKKtbNc4Qf-xA>
X-ME-Received: <xmr:ChdoZpAG-LDQcnpSuGyievDJK49IgyukLlhzrDxYo5ZPosxJp_ubH9exnh4tXgs3LxNn35SVnNsjLfrR1xxdNbXxEJerc-G0SyEXfeXEwpqVUWkc8eHt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ChdoZneXI2H9R5veNKQaTKMjPQAbmk70WUraKtYXpCsiDA1o9sqz2A>
    <xmx:ChdoZgMsNGYQqYgtLTtd92ZOiUy8pQNoJk0uMwsbi7sDQFHZ6CqURg>
    <xmx:ChdoZpkLbBGzP5o0ACsBj8a0C1BBwRUbIbtO1NYH5bXjUXlNz17OWg>
    <xmx:ChdoZqv3FU89WETwXxENu4kxLVdSIToSJnVft0Om8WqGQAlAm6adaQ>
    <xmx:ChdoZlrr5vPTNLqqoz7lwPYwOiyO8P5j2b73_IRzJjxtOpJ-UiUWCwLV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:21:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id be3d0530 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:21:04 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:21:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 25/29] merge: fix leaking merge bases
Message-ID: <6f6456494cc63b28cf64057ee6555b29ac1147a6.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wM+tGVnMbtidWhlF"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--wM+tGVnMbtidWhlF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling either the recursive or the ORT merge machineries we need
to provide a list of merge bases. The ownership of that parameter is
then implicitly transferred to the callee, which is somewhat fishy.
Furthermore, that list may leak in some cases where the merge machinery
runs into an error, thus causing a memory leak.

Refactor the code such that we stop transferring ownership. Instead, the
merge machinery will now create its own local copies of the passed in
list as required if they need to modify the list. Free the list at the
callsites as required.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge-tree.c       |  1 +
 builtin/merge.c            |  2 ++
 commit.c                   |  2 +-
 commit.h                   |  2 +-
 log-tree.c                 |  1 +
 merge-ort-wrappers.c       |  2 +-
 merge-ort-wrappers.h       |  2 +-
 merge-ort.c                | 12 ++++++----
 merge-ort.h                |  2 +-
 merge-recursive.c          | 49 +++++++++++++++++++++++---------------
 merge-recursive.h          |  2 +-
 sequencer.c                |  1 +
 t/t3430-rebase-merges.sh   |  1 +
 t/t6402-merge-rename.sh    |  1 +
 t/t6430-merge-recursive.sh |  1 +
 t/t6436-merge-overwrite.sh |  1 +
 t/t7611-merge-abort.sh     |  1 +
 17 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 1082d919fd..dab2fdc2a6 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -482,6 +482,7 @@ static int real_merge(struct merge_tree_options *o,
 			die(_("refusing to merge unrelated histories"));
 		merge_bases =3D reverse_commit_list(merge_bases);
 		merge_incore_recursive(&opt, merge_bases, parent1, parent2, &result);
+		free_commit_list(merge_bases);
 	}
=20
 	if (result.clean < 0)
diff --git a/builtin/merge.c b/builtin/merge.c
index 682c6ed868..1120a6e2f8 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -746,6 +746,8 @@ static int try_merge_strategy(const char *strategy, str=
uct commit_list *common,
 		else
 			clean =3D merge_recursive(&o, head, remoteheads->item,
 						reversed, &result);
+		free_commit_list(reversed);
+
 		if (clean < 0) {
 			rollback_lock_file(&lock);
 			return 2;
diff --git a/commit.c b/commit.c
index f674eca320..1386b12df1 100644
--- a/commit.c
+++ b/commit.c
@@ -680,7 +680,7 @@ unsigned commit_list_count(const struct commit_list *l)
 	return c;
 }
=20
-struct commit_list *copy_commit_list(struct commit_list *list)
+struct commit_list *copy_commit_list(const struct commit_list *list)
 {
 	struct commit_list *head =3D NULL;
 	struct commit_list **pp =3D &head;
diff --git a/commit.h b/commit.h
index 442e50ff24..acabb05785 100644
--- a/commit.h
+++ b/commit.h
@@ -181,7 +181,7 @@ struct commit_list *commit_list_insert_by_date(struct c=
ommit *item,
 void commit_list_sort_by_date(struct commit_list **list);
=20
 /* Shallow copy of the input list */
-struct commit_list *copy_commit_list(struct commit_list *list);
+struct commit_list *copy_commit_list(const struct commit_list *list);
=20
 /* Modify list in-place to reverse it, returning new head; list will be ta=
il */
 struct commit_list *reverse_commit_list(struct commit_list *list);
diff --git a/log-tree.c b/log-tree.c
index 41416de4e3..91b96d83a0 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -1047,6 +1047,7 @@ static int do_remerge_diff(struct rev_info *opt,
 	log_tree_diff_flush(opt);
=20
 	/* Cleanup */
+	free_commit_list(bases);
 	cleanup_additional_headers(&opt->diffopt);
 	strbuf_release(&parent1_desc);
 	strbuf_release(&parent2_desc);
diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index 4acedf3c33..d6f6135996 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -48,7 +48,7 @@ int merge_ort_nonrecursive(struct merge_options *opt,
 int merge_ort_recursive(struct merge_options *opt,
 			struct commit *side1,
 			struct commit *side2,
-			struct commit_list *merge_bases,
+			const struct commit_list *merge_bases,
 			struct commit **result)
 {
 	struct tree *head =3D repo_get_commit_tree(opt->repo, side1);
diff --git a/merge-ort-wrappers.h b/merge-ort-wrappers.h
index 0c4c57adbb..90af1f69c5 100644
--- a/merge-ort-wrappers.h
+++ b/merge-ort-wrappers.h
@@ -19,7 +19,7 @@ int merge_ort_nonrecursive(struct merge_options *opt,
 int merge_ort_recursive(struct merge_options *opt,
 			struct commit *h1,
 			struct commit *h2,
-			struct commit_list *ancestors,
+			const struct commit_list *ancestors,
 			struct commit **result);
=20
 #endif
diff --git a/merge-ort.c b/merge-ort.c
index eaede6cead..8ed8a4c9dc 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -5071,11 +5071,12 @@ static void merge_ort_nonrecursive_internal(struct =
merge_options *opt,
  * Originally from merge_recursive_internal(); somewhat adapted, though.
  */
 static void merge_ort_internal(struct merge_options *opt,
-			       struct commit_list *merge_bases,
+			       const struct commit_list *_merge_bases,
 			       struct commit *h1,
 			       struct commit *h2,
 			       struct merge_result *result)
 {
+	struct commit_list *merge_bases =3D copy_commit_list(_merge_bases);
 	struct commit *next;
 	struct commit *merged_merge_bases;
 	const char *ancestor_name;
@@ -5085,7 +5086,7 @@ static void merge_ort_internal(struct merge_options *=
opt,
 		if (repo_get_merge_bases(the_repository, h1, h2,
 					 &merge_bases) < 0) {
 			result->clean =3D -1;
-			return;
+			goto out;
 		}
 		/* See merge-ort.h:merge_incore_recursive() declaration NOTE */
 		merge_bases =3D reverse_commit_list(merge_bases);
@@ -5129,7 +5130,7 @@ static void merge_ort_internal(struct merge_options *=
opt,
 		opt->branch2 =3D "Temporary merge branch 2";
 		merge_ort_internal(opt, NULL, prev, next, result);
 		if (result->clean < 0)
-			return;
+			goto out;
 		opt->branch1 =3D saved_b1;
 		opt->branch2 =3D saved_b2;
 		opt->priv->call_depth--;
@@ -5152,6 +5153,9 @@ static void merge_ort_internal(struct merge_options *=
opt,
 					result);
 	strbuf_release(&merge_base_abbrev);
 	opt->ancestor =3D NULL;  /* avoid accidental re-use of opt->ancestor */
+
+out:
+	free_commit_list(merge_bases);
 }
=20
 void merge_incore_nonrecursive(struct merge_options *opt,
@@ -5181,7 +5185,7 @@ void merge_incore_nonrecursive(struct merge_options *=
opt,
 }
=20
 void merge_incore_recursive(struct merge_options *opt,
-			    struct commit_list *merge_bases,
+			    const struct commit_list *merge_bases,
 			    struct commit *side1,
 			    struct commit *side2,
 			    struct merge_result *result)
diff --git a/merge-ort.h b/merge-ort.h
index ce56ec1a78..6af97c0828 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -59,7 +59,7 @@ struct merge_result {
  *           first", 2006-08-09)
  */
 void merge_incore_recursive(struct merge_options *opt,
-			    struct commit_list *merge_bases,
+			    const struct commit_list *merge_bases,
 			    struct commit *side1,
 			    struct commit *side2,
 			    struct merge_result *result);
diff --git a/merge-recursive.c b/merge-recursive.c
index 832c8ef3f3..1ac0316cce 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3633,15 +3633,16 @@ static int merge_trees_internal(struct merge_option=
s *opt,
 static int merge_recursive_internal(struct merge_options *opt,
 				    struct commit *h1,
 				    struct commit *h2,
-				    struct commit_list *merge_bases,
+				    const struct commit_list *_merge_bases,
 				    struct commit **result)
 {
+	struct commit_list *merge_bases =3D copy_commit_list(_merge_bases);
 	struct commit_list *iter;
 	struct commit *merged_merge_bases;
 	struct tree *result_tree;
-	int clean;
 	const char *ancestor_name;
 	struct strbuf merge_base_abbrev =3D STRBUF_INIT;
+	int ret;
=20
 	if (show(opt, 4)) {
 		output(opt, 4, _("Merging:"));
@@ -3651,8 +3652,10 @@ static int merge_recursive_internal(struct merge_opt=
ions *opt,
=20
 	if (!merge_bases) {
 		if (repo_get_merge_bases(the_repository, h1, h2,
-					 &merge_bases) < 0)
-			return -1;
+					 &merge_bases) < 0) {
+			ret =3D -1;
+			goto out;
+		}
 		merge_bases =3D reverse_commit_list(merge_bases);
 	}
=20
@@ -3702,14 +3705,18 @@ static int merge_recursive_internal(struct merge_op=
tions *opt,
 		opt->branch1 =3D "Temporary merge branch 1";
 		opt->branch2 =3D "Temporary merge branch 2";
 		if (merge_recursive_internal(opt, merged_merge_bases, iter->item,
-					     NULL, &merged_merge_bases) < 0)
-			return -1;
+					     NULL, &merged_merge_bases) < 0) {
+			ret =3D -1;
+			goto out;
+		}
 		opt->branch1 =3D saved_b1;
 		opt->branch2 =3D saved_b2;
 		opt->priv->call_depth--;
=20
-		if (!merged_merge_bases)
-			return err(opt, _("merge returned no commit"));
+		if (!merged_merge_bases) {
+			ret =3D err(opt, _("merge returned no commit"));
+			goto out;
+		}
 	}
=20
 	/*
@@ -3726,17 +3733,16 @@ static int merge_recursive_internal(struct merge_op=
tions *opt,
 		repo_read_index(opt->repo);
=20
 	opt->ancestor =3D ancestor_name;
-	clean =3D merge_trees_internal(opt,
-				     repo_get_commit_tree(opt->repo, h1),
-				     repo_get_commit_tree(opt->repo, h2),
-				     repo_get_commit_tree(opt->repo,
-							  merged_merge_bases),
-				     &result_tree);
-	strbuf_release(&merge_base_abbrev);
+	ret =3D merge_trees_internal(opt,
+				   repo_get_commit_tree(opt->repo, h1),
+				   repo_get_commit_tree(opt->repo, h2),
+				   repo_get_commit_tree(opt->repo,
+							merged_merge_bases),
+				   &result_tree);
 	opt->ancestor =3D NULL;  /* avoid accidental re-use of opt->ancestor */
-	if (clean < 0) {
+	if (ret < 0) {
 		flush_output(opt);
-		return clean;
+		goto out;
 	}
=20
 	if (opt->priv->call_depth) {
@@ -3745,7 +3751,11 @@ static int merge_recursive_internal(struct merge_opt=
ions *opt,
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-	return clean;
+
+out:
+	strbuf_release(&merge_base_abbrev);
+	free_commit_list(merge_bases);
+	return ret;
 }
=20
 static int merge_start(struct merge_options *opt, struct tree *head)
@@ -3827,7 +3837,7 @@ int merge_trees(struct merge_options *opt,
 int merge_recursive(struct merge_options *opt,
 		    struct commit *h1,
 		    struct commit *h2,
-		    struct commit_list *merge_bases,
+		    const struct commit_list *merge_bases,
 		    struct commit **result)
 {
 	int clean;
@@ -3895,6 +3905,7 @@ int merge_recursive_generic(struct merge_options *opt,
 	repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
 	clean =3D merge_recursive(opt, head_commit, next_commit, ca,
 				result);
+	free_commit_list(ca);
 	if (clean < 0) {
 		rollback_lock_file(&lock);
 		return clean;
diff --git a/merge-recursive.h b/merge-recursive.h
index 839eb6436e..3136c7cc2d 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -104,7 +104,7 @@ int merge_trees(struct merge_options *opt,
 int merge_recursive(struct merge_options *opt,
 		    struct commit *h1,
 		    struct commit *h2,
-		    struct commit_list *merge_bases,
+		    const struct commit_list *merge_bases,
 		    struct commit **result);
=20
 /*
diff --git a/sequencer.c b/sequencer.c
index 20807ea7e5..131443c242 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4315,6 +4315,7 @@ static int do_merge(struct repository *r,
 	strbuf_release(&ref_name);
 	rollback_lock_file(&lock);
 	free_commit_list(to_merge);
+	free_commit_list(bases);
 	return ret;
 }
=20
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index 59b5d6b6f2..36ca126bcd 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -21,6 +21,7 @@ Initial setup:
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
 . "$TEST_DIRECTORY"/lib-log-graph.sh
diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 2738b50c2a..729aac9842 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -4,6 +4,7 @@ test_description=3D'Merge-recursive merging renames'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 modify () {
diff --git a/t/t6430-merge-recursive.sh b/t/t6430-merge-recursive.sh
index ca15e6dd6d..555f00f78a 100755
--- a/t/t6430-merge-recursive.sh
+++ b/t/t6430-merge-recursive.sh
@@ -5,6 +5,7 @@ test_description=3D'merge-recursive backend test'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-merge.sh
=20
diff --git a/t/t6436-merge-overwrite.sh b/t/t6436-merge-overwrite.sh
index 4f4376421e..ccc620477d 100755
--- a/t/t6436-merge-overwrite.sh
+++ b/t/t6436-merge-overwrite.sh
@@ -7,6 +7,7 @@ Do not overwrite changes.'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
diff --git a/t/t7611-merge-abort.sh b/t/t7611-merge-abort.sh
index d6975ca48d..992a8f9874 100755
--- a/t/t7611-merge-abort.sh
+++ b/t/t7611-merge-abort.sh
@@ -25,6 +25,7 @@ Next, test git merge --abort with the following variables:
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup' '
--=20
2.45.2.436.gcd77e87115.dirty


--wM+tGVnMbtidWhlF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFwYACgkQVbJhu7ck
PpQVHw/9GpYuAKNWfWQa9QpxNmWcfJzA3uzbbg8hwsbBeFk+dn7/txZIZ8+uOrW6
2kof70oZwCZz6t4QD6LLtEt8+GicF+Gy2wAGIANolKv9Ne/fxuqDK72DjsXMZUJS
fT2GKa+2JNIqUFpACv6kNQIfPySwLruCa3QDTcnrl4tAlf+e13Dkx/YWuf6uEzRQ
Qdy7MBp934CkeGpj6ODrTv4vcqFolVYaFZjbVzJjCtabf0zHkSdTFwZ9FRA0Ruul
2XtTHaI56bPs/oSwdxAVHIUXkF4XTOnBHsaIxk7evhmBmxu9+Go7ciGsoYchchBu
j0LXcQaaxTyGO1GY4d6zmut/3uu8N6lHsD+i7kX48MTKFGDEf5pvYBHaFW9zsRVU
V9W9bTAR63UWHsyfZuxbNqey4hmJoFkFrvRsk0xYrC7ANkFh6oc4yODrV+UEqXlE
9Ti1EJ0z9ReBb81LLIsYven/dIZZcectVT8OyNhEi4kQTTzlwpse0Hl7lbse6OnG
cbtPz76pz7YGb1dolrdEudYe3+fyt9rQfyCmqDCvJ8pQI4eKHoh9w9yAkvuHSoBP
jVQWkR8rfSc3jYWZDqz1R0Mmg7NqtvglkD38CZQi0baaKW53w9dSIvyp1AYfSQyb
I0/VPlepHHnQB4YikKOO2IVxI1/v5gs+a3h0Gg+UppWBk5ZU/n0=
=DxoI
-----END PGP SIGNATURE-----

--wM+tGVnMbtidWhlF--
