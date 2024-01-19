Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F04CB2B
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660825; cv=none; b=hcyBbAX3OFNJOdIJb5wB8MskEhWN4pF8u0lq6QITH/uZ5XQYj+fRyxEm3Wlp4xK5ZobnNZPjr3LZoi2HWf1OrkZ6XQnanMFCKszzetjbTSRcTWQulwMpSsyS4Aucd6trYa17gDCK6hv2GCZUsv0XZsWDK5c6GKXtikQkXPkkrPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660825; c=relaxed/simple;
	bh=1SQS+FoOL6ngAnr3xM6xX35xXO4N3Yp7YJ879Z7o2NI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgNyTtahs4Wjk0oP+XYHcQR60fw7koLf0feMJtLuB9POrg7O02+7olRJzHe0/huDyEKuOBOM7CkDZSJIHudkSvF+1R2TBZ875/zqTjg7BcT9g6kkIEZTPET5SGon5Yy4FjuUTikcY8X2eWqzof2WGmvuz6JeKskarM75ygMBVew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hfbx8lEb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XnHaIYlY; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hfbx8lEb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XnHaIYlY"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 0EE813200A61
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:22 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 19 Jan 2024 05:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705660822; x=1705747222; bh=bJBFCmcyOT
	2uQBAndiN6iJ2rp0VHWa/OVmEMvAomra8=; b=Hfbx8lEbVmoITgeYmiz2ICOgiw
	VwqCZE+a9SPU/CtHOJPSw9VHlLPzQQZ1kJFdbQ2PfjvdKAVDXBqNkVgaCMlVSZHq
	IXFWR5/cDeZoo8cd/m2aPQLAew/tPcyhzQvrrYm83NXfbfraZah1NyeePBNNYagT
	8jkNXoFyaBR5/Qnc5/hCIqa0AdMT+DK58nQ5ehazt4Yo3CLAZ7mWjfoUTzqQqZ6U
	QikVC8O7xI+7neaK20ukuTmd+iHpRD2F7oAVftCZxOvb5+hDXviCl4fuOuUjwfrt
	SzTKMOQzxp82ezhvWMVsFFibLIZb5BuohNyPFk9PAxxQAygzLXDLu0LHo5hA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705660822; x=1705747222; bh=bJBFCmcyOT2uQBAndiN6iJ2rp0VH
	Wa/OVmEMvAomra8=; b=XnHaIYlYVtIpLWB5AMzXo/OBt43QEgDjuBj+o8s/mpMl
	2Q/IV4T6ramfA7bPRIpvbWLi4Thi8pl/v6yPq8Wg9Nm4VM6BE4jTJAXG/DNRJ563
	MI0cB2u/JwVQRZc9bFSYhfjepf/MVPzfqCHl5S0aMQxhfckmWGDjIkpYKEonKW0k
	dMMx3mHZL6bOgH8F9WMaraYn9vnD/YjBtPGZG/b5E857OqyvmRk7uD+lhtu7K+8Y
	jbiF5zCS3h4nrh5y0kTgia4jxJ0zHRNgXh1Yjh55d9bmYBTrwhNenFqlwn2anKi9
	e3uruED0l0TdcR0CXYt0Hdw9dCluuRI4QZBiC5I9BA==
X-ME-Sender: <xms:llGqZd1Isap_Vy0N0vMGQ9_LL3cEqtWRbYOtjqCVM2Z52cd9lXEV0Q>
    <xme:llGqZUGwpA7--b7vIPm44nEOnTSaGultz213B84eWGFu4jK5tzl2XLi7Q_NJA-Y6B
    j7raq74BdFEkj_-Ww>
X-ME-Received: <xmr:llGqZd7JxQOJab-dziH71aLKCM2P8qj5k59QiMhsb4u5FW4k5iw5n2-bRcgFQbzu-SNQYk_Wnw50CmXEGkbmJIYjMWQyIpMlI6-P8zWTQ7JoKc0-hQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:llGqZa3THzAtJduWVuFgqWS_xk2cDhpCIHqDYJbhekSmyqBbhdptpA>
    <xmx:llGqZQFTentm2e8yQDH84prtGpGXFwGRemaDAxWJPwjJAS60GepiqA>
    <xmx:llGqZb_Zel0Tcz-hD37rAFOHcy8ApdQapxOsWJPtm_eds078LLlwBQ>
    <xmx:llGqZTxK3HQ-PC1USVKyr9am_Ltgr_kLLwsJMBkgWacpKkSPInLaGg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aad29d27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Jan 2024 10:37:24 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:40:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/7] refs: convert MERGE_AUTOSTASH to become a normal
 pseudo-ref
Message-ID: <c29576d2d7e0247be118dd9cd9ae3fac3c7b33c7.1705659748.git.ps@pks.im>
References: <cover.1705659748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D06/OD6LaRx6JJQu"
Content-Disposition: inline
In-Reply-To: <cover.1705659748.git.ps@pks.im>


--D06/OD6LaRx6JJQu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Similar to the preceding conversion of the AUTO_MERGE pseudo-ref, let's
convert the MERGE_AUTOSTASH ref to become a normal pseudo-ref as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 branch.c         |  2 +-
 builtin/commit.c |  2 +-
 builtin/merge.c  | 27 +++++++++++++--------------
 path.c           |  1 -
 path.h           |  1 -
 refs.c           |  1 -
 repository.c     |  1 -
 repository.h     |  1 -
 8 files changed, 15 insertions(+), 21 deletions(-)

diff --git a/branch.c b/branch.c
index c8bd9519e6..6719a181bd 100644
--- a/branch.c
+++ b/branch.c
@@ -819,7 +819,7 @@ void remove_merge_branch_state(struct repository *r)
 	unlink(git_path_merge_mode(r));
 	refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
 			NULL, REF_NO_DEREF);
-	save_autostash(git_path_merge_autostash(r));
+	save_autostash_ref(r, "MERGE_AUTOSTASH");
 }
=20
 void remove_branch_state(struct repository *r, int verbose)
diff --git a/builtin/commit.c b/builtin/commit.c
index 65196a2827..6d1fa71676 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1877,7 +1877,7 @@ int cmd_commit(int argc, const char **argv, const cha=
r *prefix)
 				     &oid, flags);
 	}
=20
-	apply_autostash(git_path_merge_autostash(the_repository));
+	apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
=20
 cleanup:
 	strbuf_release(&author_ident);
diff --git a/builtin/merge.c b/builtin/merge.c
index ebbe05033e..8f819781cc 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -476,7 +476,7 @@ static void finish(struct commit *head_commit,
 	run_hooks_l("post-merge", squash ? "1" : "0", NULL);
=20
 	if (new_head)
-		apply_autostash(git_path_merge_autostash(the_repository));
+		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
 	strbuf_release(&reflog_message);
 }
=20
@@ -1315,7 +1315,8 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 	if (abort_current_merge) {
 		int nargc =3D 2;
 		const char *nargv[] =3D {"reset", "--merge", NULL};
-		struct strbuf stash_oid =3D STRBUF_INIT;
+		char stash_oid_hex[GIT_MAX_HEXSZ + 1];
+		struct object_id stash_oid =3D {0};
=20
 		if (orig_argc !=3D 2)
 			usage_msg_opt(_("--abort expects no arguments"),
@@ -1324,17 +1325,17 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
 		if (!file_exists(git_path_merge_head(the_repository)))
 			die(_("There is no merge to abort (MERGE_HEAD missing)."));
=20
-		if (read_oneliner(&stash_oid, git_path_merge_autostash(the_repository),
-		    READ_ONELINER_SKIP_IF_EMPTY))
-			unlink(git_path_merge_autostash(the_repository));
+		if (!read_ref("MERGE_AUTOSTASH", &stash_oid))
+			delete_ref("", "MERGE_AUTOSTASH", &stash_oid, REF_NO_DEREF);
=20
 		/* Invoke 'git reset --merge' */
 		ret =3D cmd_reset(nargc, nargv, prefix);
=20
-		if (stash_oid.len)
-			apply_autostash_oid(stash_oid.buf);
+		if (!is_null_oid(&stash_oid)) {
+			oid_to_hex_r(stash_oid_hex, &stash_oid);
+			apply_autostash_oid(stash_oid_hex);
+		}
=20
-		strbuf_release(&stash_oid);
 		goto done;
 	}
=20
@@ -1563,13 +1564,12 @@ int cmd_merge(int argc, const char **argv, const ch=
ar *prefix)
 		}
=20
 		if (autostash)
-			create_autostash(the_repository,
-					 git_path_merge_autostash(the_repository));
+			create_autostash_ref(the_repository, "MERGE_AUTOSTASH");
 		if (checkout_fast_forward(the_repository,
 					  &head_commit->object.oid,
 					  &commit->object.oid,
 					  overwrite_ignore)) {
-			apply_autostash(git_path_merge_autostash(the_repository));
+			apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
 			ret =3D 1;
 			goto done;
 		}
@@ -1655,8 +1655,7 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 		die_ff_impossible();
=20
 	if (autostash)
-		create_autostash(the_repository,
-				 git_path_merge_autostash(the_repository));
+		create_autostash_ref(the_repository, "MERGE_AUTOSTASH");
=20
 	/* We are going to make a new commit. */
 	git_committer_info(IDENT_STRICT);
@@ -1741,7 +1740,7 @@ int cmd_merge(int argc, const char **argv, const char=
 *prefix)
 		else
 			fprintf(stderr, _("Merge with strategy %s failed.\n"),
 				use_strategies[0]->name);
-		apply_autostash(git_path_merge_autostash(the_repository));
+		apply_autostash_ref(the_repository, "MERGE_AUTOSTASH");
 		ret =3D 2;
 		goto done;
 	} else if (best_strategy =3D=3D wt_strategy)
diff --git a/path.c b/path.c
index f881c03171..0fb527918b 100644
--- a/path.c
+++ b/path.c
@@ -1588,6 +1588,5 @@ REPO_GIT_PATH_FUNC(merge_msg, "MERGE_MSG")
 REPO_GIT_PATH_FUNC(merge_rr, "MERGE_RR")
 REPO_GIT_PATH_FUNC(merge_mode, "MERGE_MODE")
 REPO_GIT_PATH_FUNC(merge_head, "MERGE_HEAD")
-REPO_GIT_PATH_FUNC(merge_autostash, "MERGE_AUTOSTASH")
 REPO_GIT_PATH_FUNC(fetch_head, "FETCH_HEAD")
 REPO_GIT_PATH_FUNC(shallow, "shallow")
diff --git a/path.h b/path.h
index f387410f8c..b3233c51fa 100644
--- a/path.h
+++ b/path.h
@@ -175,7 +175,6 @@ const char *git_path_merge_msg(struct repository *r);
 const char *git_path_merge_rr(struct repository *r);
 const char *git_path_merge_mode(struct repository *r);
 const char *git_path_merge_head(struct repository *r);
-const char *git_path_merge_autostash(struct repository *r);
 const char *git_path_fetch_head(struct repository *r);
 const char *git_path_shallow(struct repository *r);
=20
diff --git a/refs.c b/refs.c
index 906c7e5f27..047c81b1c1 100644
--- a/refs.c
+++ b/refs.c
@@ -1875,7 +1875,6 @@ static int is_special_ref(const char *refname)
 	 */
 	static const char * const special_refs[] =3D {
 		"FETCH_HEAD",
-		"MERGE_AUTOSTASH",
 		"MERGE_HEAD",
 	};
 	size_t i;
diff --git a/repository.c b/repository.c
index a931e3b1b3..7aacb51b65 100644
--- a/repository.c
+++ b/repository.c
@@ -262,7 +262,6 @@ static void repo_clear_path_cache(struct repo_path_cach=
e *cache)
 	FREE_AND_NULL(cache->merge_rr);
 	FREE_AND_NULL(cache->merge_mode);
 	FREE_AND_NULL(cache->merge_head);
-	FREE_AND_NULL(cache->merge_autostash);
 	FREE_AND_NULL(cache->fetch_head);
 	FREE_AND_NULL(cache->shallow);
 }
diff --git a/repository.h b/repository.h
index 47e7d20b59..7a250a6605 100644
--- a/repository.h
+++ b/repository.h
@@ -67,7 +67,6 @@ struct repo_path_cache {
 	char *merge_rr;
 	char *merge_mode;
 	char *merge_head;
-	char *merge_autostash;
 	char *fetch_head;
 	char *shallow;
 };
--=20
2.43.GIT


--D06/OD6LaRx6JJQu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqUZMACgkQVbJhu7ck
PpSQnBAAq4lbLyE+W6V/Y86QH0ywxNVEaNO/Xg+CGPOwF1nlDWS/ZwnYxVCa2NZ8
ZuQMQR1JrjLMEAOnIz8pbIUpjQZkjlFndsdt+dKrNvL5sZ70WFvHNRWOo5rJNSKR
LqWvgqXS8LQM9PwuQIw8YgY9v7exoceZ7XQvHuEVQtL1YSn4R0Lp16i+WqBUbMDD
AKlTqPXKlqZsnfe/ylViofoPS7myFaItZCCxwMK/vaBhnTrvuQs0MB/jXge6tEGj
InH/5tv0138AVkIhKqkv7oEfYsZLEOiIQexa9jO32os37fohCj9wnHWevWLQP2KG
hlLqNZWwKW9uJp2F5ENSDHT7UsjMZ5ZxOgnVjCJJS3BK57mvAn3EP0Np5xfFTxvk
sZmaup+ZPFDRdvoDkaLYLOua7l6a7U2rBxdjbGUUudwDQPGSORHrheAfwMx86MyG
aXsgM3+mw+5WRd0joL2wpB7VSI8cVR7poJJdVYLAEbW727ioTg7TY41UJBmBDZsW
++StOrIAo1yzUofPWVKaEw5leaAS+YkBZYSokZZD3YCdXrOTQXfn+gIbU6BE3TNj
yqGuvRt36180g9GPuaDZ9eoFIwHXSPGPOZ+SyvQA9OHYJQx+AMH4QefUkxc/MvOm
9i7Itu9Jp3ItyIPcCoo541QPhC/BXgTmEPpkh+f8s2Lz/mz5tzM=
=98i7
-----END PGP SIGNATURE-----

--D06/OD6LaRx6JJQu--
