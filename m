Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56784C627
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 10:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660815; cv=none; b=N2aaVv0PkPbjunAR16RJLmypr3QiA2lrjbWnc6Yb8wzGJoR5PPndo0d1idnStmWY4xRb6czphOEj5WSxfnSKVFqh1hNcEVu3048ph6L9VbzHLBiAV0/Q23dSRW8+vBTvKCBFt+06ythtaKPz9DDtSLlrMSmZEZK8dOoq6ghovWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660815; c=relaxed/simple;
	bh=IDwtMZMuqMbeSnGTfOtJFrBlJ9uCFChnpOjzRlipWP8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mu/WFUFrUgtEyx1azcmpJGkP39/XHKg7rX6+oUnrydylHzfWetS0h5DQ7/KlBkGNcy6Pv9ms19pJm8xJ41FOWoXoDb9ki+OOydyoi/vW3b/NohhDiNxKRRtMnt5210e7si2JE4NVCbCeyE4lQvDVzwfBo1xGX8O0gjstta0gEtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bMZoDYPY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PQfdc9Nd; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bMZoDYPY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PQfdc9Nd"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id EF8603200A61
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 19 Jan 2024 05:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705660812; x=1705747212; bh=NSX+C2FTPI
	CL7BHTLQzcbkAgHcAeiCAONrBtSHYDLBg=; b=bMZoDYPY+RpiKIqiJVJQX7lSrh
	70Z4CKxeJJ/kcfLEhH8OqH6FsWEUTxIW4fJ4lAWXk+XnBhk14wDKtYhpQWTQ+D8S
	kPG21uqeD9l4IDZCD3exubwCv2vIIw51+BXpD1YZXNXeSGtqEGMQVZ+s5W3lQrn9
	wIFHLC0Y13Rly8zbEUUiBm3gYVPcZnX96MDdHb3r3QHtCWKTM9JHEjR4bqzJYPOR
	L1IrqXM4sKDRTZIe1dbRzxnU+jE4pKywB/cX66NY2i6+84WHBXy3XwKmattnMKnk
	K/d3L/EMBPhY/4ue2RufWdmDReZwwGqFr57HaDC6n6g5PZxiadNfFmodes/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705660812; x=1705747212; bh=NSX+C2FTPICL7BHTLQzcbkAgHcAe
	iCAONrBtSHYDLBg=; b=PQfdc9Ndy0s7WeDA16u0MKd2qxOyd3v9gMCEDW9jsiWu
	b4KnXzu4wkVxYvHKz35MNZxwEsRjLCV1siHhdL+qrGvNTeuIWpC9laBmSAXpBx0P
	Rq3iY2tExcpCQ+KM50XqkAfO4WYi3VlR72kQrtT6qTBAUceNq/lLru//ZPFZ/Kam
	HgJ+wlAtRWuQxhcGbVIYT+NNUs7WEeb47LO7471WdY4RgT6oij5FjfMVIZTfd7FL
	s6lo0pDUcDabmKcmDN0AXnblhiVMlobDJ5BULPaZXemLrT6XzcaSUJE6UsazoMU+
	chd1hKvUl2tmaGiuI8x7keo/dcyQMUjsAc4wO9pAxA==
X-ME-Sender: <xms:jFGqZcmqo8IEhqASfmZAPciPejwrl6lZ7lQinvoptfxUFiBM05Lzhg>
    <xme:jFGqZb1pYvKKr_cwsyXQYfoNQBcv6_-bKgLtZJMcxOXoUdBdQFTPSAtiX7vEFSxjn
    WIE8X62FLa40vEnAw>
X-ME-Received: <xmr:jFGqZaorg_YBZo51YhViSY8D__P6mRCDk0Iv0hPiS2Is_24YjYW9Go3IKGKQTq1Ua_P_t7XJvda0aBGeb-9l_keF-kTrv6OPoux6gSHAPioAysC1uQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jFGqZYm_r8C5PwTztigfWcqFkDSBJ5GStSVV3SkEkeF6-VyeyDeiZQ>
    <xmx:jFGqZa1neY1-OdXIYFwYWeF8no3L8FqPkrnFxTrCrRc_iOtWozTo0g>
    <xmx:jFGqZfsuOWoQKxXFtzj-x4y92XlMM8AnDkoXwcw5zusb1hfayCOM6Q>
    <xmx:jFGqZTg3cXlriy2okFT60EUgh6uXV1KXTILzMp9FTnxEnb5BV4NcHw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 84912905 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Jan 2024 10:37:14 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:40:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/7] refs: convert AUTO_MERGE to become a normal pseudo-ref
Message-ID: <ae2df6316f79e372c51d59666d685e59981d2f98.1705659748.git.ps@pks.im>
References: <cover.1705659748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AM5BWWHqefFKgjQR"
Content-Disposition: inline
In-Reply-To: <cover.1705659748.git.ps@pks.im>


--AM5BWWHqefFKgjQR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 70c70de616 (refs: complete list of special refs, 2023-12-14) we have
inrtoduced a new `is_special_ref()` function that classifies some refs
as being special. The rule is that special refs are exclusively read and
written via the filesystem directly, whereas normal refs exclucsively go
via the refs API.

The intent of that commit was to record the status quo so that we know
to route reads of such special refs consistently. Eventually, the list
should be reduced to its bare minimum of refs which really are special,
namely FETCH_HEAD and MERGE_HEAD.

Follow up on this promise and convert the AUTO_MERGE ref to become a
normal pseudo-ref by using the refs API to both read and write it
instead of accessing the filesystem directly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c         |  3 ++-
 builtin/rebase.c |  2 +-
 merge-ort.c      | 19 ++++++++++++-------
 path.c           |  1 -
 path.h           |  1 -
 refs.c           |  1 -
 repository.c     |  1 -
 repository.h     |  1 -
 sequencer.c      | 12 ++++++++----
 9 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/branch.c b/branch.c
index 534594f7f8..c8bd9519e6 100644
--- a/branch.c
+++ b/branch.c
@@ -817,7 +817,8 @@ void remove_merge_branch_state(struct repository *r)
 	unlink(git_path_merge_rr(r));
 	unlink(git_path_merge_msg(r));
 	unlink(git_path_merge_mode(r));
-	unlink(git_path_auto_merge(r));
+	refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
+			NULL, REF_NO_DEREF);
 	save_autostash(git_path_merge_autostash(r));
 }
=20
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 995818c28d..5b086f651a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -515,7 +515,7 @@ static int finish_rebase(struct rebase_options *opts)
 	int ret =3D 0;
=20
 	delete_ref(NULL, "REBASE_HEAD", NULL, REF_NO_DEREF);
-	unlink(git_path_auto_merge(the_repository));
+	delete_ref(NULL, "AUTO_MERGE", NULL, REF_NO_DEREF);
 	apply_autostash(state_dir_path("autostash", opts));
 	/*
 	 * We ignore errors in 'git maintenance run --auto', since the
diff --git a/merge-ort.c b/merge-ort.c
index 77ba7f3020..d72fd04f58 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -38,6 +38,7 @@
 #include "path.h"
 #include "promisor-remote.h"
 #include "read-cache-ll.h"
+#include "refs.h"
 #include "revision.h"
 #include "sparse-index.h"
 #include "strmap.h"
@@ -4659,9 +4660,6 @@ void merge_switch_to_result(struct merge_options *opt,
 {
 	assert(opt->priv =3D=3D NULL);
 	if (result->clean >=3D 0 && update_worktree_and_index) {
-		const char *filename;
-		FILE *fp;
-
 		trace2_region_enter("merge", "checkout", opt->repo);
 		if (checkout(opt, head, result->tree)) {
 			/* failure to function */
@@ -4687,10 +4685,17 @@ void merge_switch_to_result(struct merge_options *o=
pt,
 		trace2_region_leave("merge", "record_conflicted", opt->repo);
=20
 		trace2_region_enter("merge", "write_auto_merge", opt->repo);
-		filename =3D git_path_auto_merge(opt->repo);
-		fp =3D xfopen(filename, "w");
-		fprintf(fp, "%s\n", oid_to_hex(&result->tree->object.oid));
-		fclose(fp);
+		if (refs_update_ref(get_main_ref_store(opt->repo), "", "AUTO_MERGE",
+				    &result->tree->object.oid, NULL, REF_NO_DEREF,
+				    UPDATE_REFS_MSG_ON_ERR)) {
+			/* failure to function */
+			opt->priv =3D NULL;
+			result->clean =3D -1;
+			merge_finalize(opt, result);
+			trace2_region_leave("merge", "write_auto_merge",
+					    opt->repo);
+			return;
+		}
 		trace2_region_leave("merge", "write_auto_merge", opt->repo);
 	}
 	if (display_update_msgs)
diff --git a/path.c b/path.c
index 67e2690efe..f881c03171 100644
--- a/path.c
+++ b/path.c
@@ -1589,6 +1589,5 @@ REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
 REPO_GIT_PATH_FUNC(merge_mode, "MERGE_MODE")
 REPO_GIT_PATH_FUNC(merge_head, "MERGE_HEAD")
 REPO_GIT_PATH_FUNC(merge_autostash, "MERGE_AUTOSTASH")
-REPO_GIT_PATH_FUNC(auto_merge, "AUTO_MERGE")
 REPO_GIT_PATH_FUNC(fetch_head, "FETCH_HEAD")
 REPO_GIT_PATH_FUNC(shallow, "shallow")
diff --git a/path.h b/path.h
index 639372edd9..f387410f8c 100644
--- a/path.h
+++ b/path.h
@@ -176,7 +176,6 @@ const char *git_path_merge_rr(struct repository *r);
 const char *git_path_merge_mode(struct repository *r);
 const char *git_path_merge_head(struct repository *r);
 const char *git_path_merge_autostash(struct repository *r);
-const char *git_path_auto_merge(struct repository *r);
 const char *git_path_fetch_head(struct repository *r);
 const char *git_path_shallow(struct repository *r);
=20
diff --git a/refs.c b/refs.c
index 20e8f1ff1f..906c7e5f27 100644
--- a/refs.c
+++ b/refs.c
@@ -1874,7 +1874,6 @@ static int is_special_ref(const char *refname)
 	 * (normal ones).
 	 */
 	static const char * const special_refs[] =3D {
-		"AUTO_MERGE",
 		"FETCH_HEAD",
 		"MERGE_AUTOSTASH",
 		"MERGE_HEAD",
diff --git a/repository.c b/repository.c
index d7d24d416a..a931e3b1b3 100644
--- a/repository.c
+++ b/repository.c
@@ -263,7 +263,6 @@ static void repo_clear_path_cache(struct repo_path_cach=
e *cache)
 	FREE_AND_NULL(cache->merge_mode);
 	FREE_AND_NULL(cache->merge_head);
 	FREE_AND_NULL(cache->merge_autostash);
-	FREE_AND_NULL(cache->auto_merge);
 	FREE_AND_NULL(cache->fetch_head);
 	FREE_AND_NULL(cache->shallow);
 }
diff --git a/repository.h b/repository.h
index f5269b3730..47e7d20b59 100644
--- a/repository.h
+++ b/repository.h
@@ -68,7 +68,6 @@ struct repo_path_cache {
 	char *merge_mode;
 	char *merge_head;
 	char *merge_autostash;
-	char *auto_merge;
 	char *fetch_head;
 	char *shallow;
 };
diff --git a/sequencer.c b/sequencer.c
index 6f620f5717..47c8d17cbb 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2408,7 +2408,8 @@ static int do_pick_commit(struct repository *r,
 		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
 				NULL, REF_NO_DEREF);
 		unlink(git_path_merge_msg(r));
-		unlink(git_path_auto_merge(r));
+		refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
+				NULL, REF_NO_DEREF);
 		fprintf(stderr,
 			_("dropping %s %s -- patch contents already upstream\n"),
 			oid_to_hex(&commit->object.oid), msg.subject);
@@ -2818,7 +2819,8 @@ void sequencer_post_commit_cleanup(struct repository =
*r, int verbose)
 		need_cleanup =3D 1;
 	}
=20
-	unlink(git_path_auto_merge(r));
+	refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
+			NULL, REF_NO_DEREF);
=20
 	if (!need_cleanup)
 		return;
@@ -4766,7 +4768,8 @@ static int pick_commits(struct repository *r,
 			}
 			unlink(rebase_path_author_script());
 			unlink(git_path_merge_head(r));
-			unlink(git_path_auto_merge(r));
+			refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
+					NULL, REF_NO_DEREF);
 			refs_delete_ref(get_main_ref_store(r), "", "REBASE_HEAD",
 					NULL, REF_NO_DEREF);
=20
@@ -5123,7 +5126,8 @@ static int commit_staged_changes(struct repository *r,
 		return error(_("could not commit staged changes."));
 	unlink(rebase_path_amend());
 	unlink(git_path_merge_head(r));
-	unlink(git_path_auto_merge(r));
+	refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
+			NULL, REF_NO_DEREF);
 	if (final_fixup) {
 		unlink(rebase_path_fixup_msg());
 		unlink(rebase_path_squash_msg());
--=20
2.43.GIT


--AM5BWWHqefFKgjQR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqUYgACgkQVbJhu7ck
PpTxyA//cNBWxBqYxjBmlFunJaB9/7RmeNMfUF37jeAKrRqm9WLKS+k/RaHuyIVF
IQtgctNe3TgHuFaen6vP18zfH1QFp+BBNanHK9cVnPM/WBynOdW9iW26nokIaDVG
CHA6VdLSNFLsOj536/e/cDlHmz4aXwP771YS+6YaQkwhIUiBIB8h6x1YT4ZgtB98
zvsBZ1/q17SAv16g72AmWmBpd38B8uk3HiS85yX5G11l3u5dkipPDDx+1E3i2sU0
optbz8lWoXmRtC4mtuVpszowDIAJoYwEHwI45daSsjUkFIQxPeZ/9stbesrXAXIO
Gj6MP4K1PpVE+Bb3OuLzhsMZ0bVj1TH1NpWQWU2+m54dTrW3cxuaivzeFooOie+x
Ja0R5WwR9tWOlPWlepAGQYDghQsxgcejNr5HQkNnOddlfyFXjc/pWzSdFs9HBvO3
ba/ilaoPmC3qxboF7DiidHFHAP7JkoX2p/aqiSZPeCqT3X8AQ+ZuzLiyUYytlMhr
jsQ55aBnNNJEIPbr0GTEVhm6TWROIVzFIF9EIh2InZNZWhfi9qs87iY2QbgeyBLn
lvZoR6GLbCqQXq5aZ8z9J5gzC3ugwJkhuQVJXa7MYoEpWWs02+UWsP3djh/IT4QN
NABTjX6dKdGkwkpaX5e9GCBzJmWL3OvmDeLinLVvOzuMPU0ZdAM=
=XeO/
-----END PGP SIGNATURE-----

--AM5BWWHqefFKgjQR--
