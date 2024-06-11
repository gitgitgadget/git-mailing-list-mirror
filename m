Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE60176FB7
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097653; cv=none; b=qGrY5OO0QXMRoZIRCcbts4eqOzvKn5gsh8IYjtIUbjnqmFT8F6hqkFD/gVsHKUphh73LqfgfNQ1Vcv0LdQeiHgWFGWyeuhgQ3NdfcehkCf13uluaMS3yYQ88BsbdjOHKEhl4rn8icOxhSGAp1l1UC5Y1/6AvtmX+5TIvmoEP/Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097653; c=relaxed/simple;
	bh=o91lmRYNXQFWlMipyMhs2mxFbm7jxyft+Hs66Nq61Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iBsACQ0lzcny+2Ani27jgSp9zN10EQ7IGkkcSRmUWAwxSUXHqbGQpnp8aUqv8D/LWcsI32K1yxn2V2SgJPc0A/7NE2XtWS94qBVa4d498mOM8+/Ak52sNFgZ+Hh08ddUsbL60PqxQryIJglCNs7aW2GHtqyLxQyQ0RdOZbZkroo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cdLz6Bk7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RA7/KNy1; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cdLz6Bk7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RA7/KNy1"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 7217B180011C;
	Tue, 11 Jun 2024 05:20:51 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 05:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097651; x=1718184051; bh=lc1xXGNF27
	I26DDVVP+5oCuT41mIXh3s2fP0jor4UZM=; b=cdLz6Bk7oXdZkLukab+IvkWsiu
	5FUJWp9AOu56Gc9P9QwfCAA9EY97zUZRl8lpI/dY4p6Bf3AdQrQ+z0rhZGWBzcyd
	VG041qcJ3ZKnXn7goOHz5mZtOQ+DbKUIISx+rUfuL677N++ajUaED+9BsWIkTqQY
	+46nKK/Gmmh8+37CBAK5nm1Q/04EAWpu3cJejgOK9fPQk1ZYKR10JhuLLpV1f13p
	8ioaZzQcRUmOUr7mISsdLcMUTDp+C7V1TuC7XmZrPTAh5aNzvIy3evrI0LC1k/nG
	0qDh9Knabx4heZwdZOSz87VcsUbdLgene1ccUly5FQ3PovQ1t4JNua3c0LvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097651; x=1718184051; bh=lc1xXGNF27I26DDVVP+5oCuT41mI
	Xh3s2fP0jor4UZM=; b=RA7/KNy1RHFaSiF08G6TrInP5VVcFdTBZF44UksyCgVY
	eQ6MoKHA2jnYTzSxdlC5dZyJD3QVrMJt5Fmc4YsyWzj/3pdSMyXVpUtsjpAcfVuV
	Artwu+9Qkjp2gNWwEG6RE3wzqyRZl7UOvnbBL/ytnZQ0VqqE5MR8+xk0uHxe0xQn
	++TLna9ftLtrbtyeePIWZjyoIGKqkcXK4BAk0+8/pVJxIfJRZf4gcS2vAVM5r7NL
	+T7HnJekR5NVHn02vofElmjB406xnOjedDfmAkhA94mU6+oIyX6ZFi8/gksgAixS
	T/CxpIuYYZ60Vs87EcAacP98O1T/DDapZMSzu1n30w==
X-ME-Sender: <xms:8hZoZttktY29BrYUhy9dPK9OEqGMR_7l99Jc2thjHqwL6j7gu0Yu6Q>
    <xme:8hZoZmfPsnqHK4czhO4GIvWtTlrYggN_xaO_PDqf_d2s-s1chbKtPaei4nRkuhTif
    HpRmo-IPbb8QPa1GA>
X-ME-Received: <xmr:8hZoZgwxzWCIxaiPXJZ9ZD6i_dLBDVfL98Oftuh63ZCo7s8uUXPL6L2bOXR0h04AKH1ZEmcCehm9L21cTviTm0uDULBrfRNpQciTG8lG8_fawlgz7foh>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:8hZoZkMWYnU0snR13vvZDRSd9n7MQybdRZ_oLNgXEILiH5xuELmufw>
    <xmx:8hZoZt9wy_beiQydy2isRmba-P03IaFWe8KXdjer0NzGfQr9vPYH1g>
    <xmx:8hZoZkUFgsw2dv8Fk4I0Onn5gOTja0bxu0zb0o5ODWr1sDNebM92TA>
    <xmx:8hZoZufNUQjx8OdlnV3xxlmgabDZBl1J1XdvapmpIyDYqCoWqcMn2A>
    <xmx:8xZoZobuqaGsiKFnQ_4FDsLEO1UliW0jekySBgxWGspC0k7sjiFSa2J0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:20:50 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3a38f187 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:20:41 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:20:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 20/29] sequencer: fix leaking string buffer in
 `commit_staged_changes()`
Message-ID: <144eb23617f679034581ec7ffefde8a803499d3b.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5wTKzCkUdLniK+be"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--5wTKzCkUdLniK+be
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're leaking the `rev` string buffer in various call paths. Refactor
the function to have a common exit path so that we can release its
memory reliably.

This fixes a subset of tests failing with the memory sanitizer in t3404.
But as there are more failures, we cannot yet mark the whole test suite
as passing.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c | 111 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 73 insertions(+), 38 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 475646671a..c581061b6d 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5146,33 +5146,47 @@ static int commit_staged_changes(struct repository =
*r,
 	struct replay_ctx *ctx =3D opts->ctx;
 	unsigned int flags =3D ALLOW_EMPTY | EDIT_MSG;
 	unsigned int final_fixup =3D 0, is_clean;
+	struct strbuf rev =3D STRBUF_INIT;
+	int ret;
=20
-	if (has_unstaged_changes(r, 1))
-		return error(_("cannot rebase: You have unstaged changes."));
+	if (has_unstaged_changes(r, 1)) {
+		ret =3D error(_("cannot rebase: You have unstaged changes."));
+		goto out;
+	}
=20
 	is_clean =3D !has_uncommitted_changes(r, 0);
=20
 	if (!is_clean && !file_exists(rebase_path_message())) {
 		const char *gpg_opt =3D gpg_sign_opt_quoted(opts);
-
-		return error(_(staged_changes_advice), gpg_opt, gpg_opt);
+		ret =3D error(_(staged_changes_advice), gpg_opt, gpg_opt);
+		goto out;
 	}
+
 	if (file_exists(rebase_path_amend())) {
-		struct strbuf rev =3D STRBUF_INIT;
 		struct object_id head, to_amend;
=20
-		if (repo_get_oid(r, "HEAD", &head))
-			return error(_("cannot amend non-existing commit"));
-		if (!read_oneliner(&rev, rebase_path_amend(), 0))
-			return error(_("invalid file: '%s'"), rebase_path_amend());
-		if (get_oid_hex(rev.buf, &to_amend))
-			return error(_("invalid contents: '%s'"),
-				rebase_path_amend());
-		if (!is_clean && !oideq(&head, &to_amend))
-			return error(_("\nYou have uncommitted changes in your "
-				       "working tree. Please, commit them\n"
-				       "first and then run 'git rebase "
-				       "--continue' again."));
+		if (repo_get_oid(r, "HEAD", &head)) {
+			ret =3D error(_("cannot amend non-existing commit"));
+			goto out;
+		}
+
+		if (!read_oneliner(&rev, rebase_path_amend(), 0)) {
+			ret =3D error(_("invalid file: '%s'"), rebase_path_amend());
+			goto out;
+		}
+
+		if (get_oid_hex(rev.buf, &to_amend)) {
+			ret =3D error(_("invalid contents: '%s'"),
+				    rebase_path_amend());
+			goto out;
+		}
+		if (!is_clean && !oideq(&head, &to_amend)) {
+			ret =3D error(_("\nYou have uncommitted changes in your "
+				      "working tree. Please, commit them\n"
+				      "first and then run 'git rebase "
+				      "--continue' again."));
+			goto out;
+		}
 		/*
 		 * When skipping a failed fixup/squash, we need to edit the
 		 * commit message, the current fixup list and count, and if it
@@ -5204,9 +5218,11 @@ static int commit_staged_changes(struct repository *=
r,
 				len--;
 			strbuf_setlen(&ctx->current_fixups, len);
 			if (write_message(p, len, rebase_path_current_fixups(),
-					  0) < 0)
-				return error(_("could not write file: '%s'"),
-					     rebase_path_current_fixups());
+					  0) < 0) {
+				ret =3D error(_("could not write file: '%s'"),
+					    rebase_path_current_fixups());
+				goto out;
+			}
=20
 			/*
 			 * If a fixup/squash in a fixup/squash chain failed, the
@@ -5236,35 +5252,38 @@ static int commit_staged_changes(struct repository =
*r,
 				 * We need to update the squash message to skip
 				 * the latest commit message.
 				 */
-				int res =3D 0;
 				struct commit *commit;
 				const char *msg;
 				const char *path =3D rebase_path_squash_msg();
 				const char *encoding =3D get_commit_output_encoding();
=20
-				if (parse_head(r, &commit))
-					return error(_("could not parse HEAD"));
+				if (parse_head(r, &commit)) {
+					ret =3D error(_("could not parse HEAD"));
+					goto out;
+				}
=20
 				p =3D repo_logmsg_reencode(r, commit, NULL, encoding);
 				if (!p)  {
-					res =3D error(_("could not parse commit %s"),
+					ret =3D error(_("could not parse commit %s"),
 						    oid_to_hex(&commit->object.oid));
 					goto unuse_commit_buffer;
 				}
 				find_commit_subject(p, &msg);
 				if (write_message(msg, strlen(msg), path, 0)) {
-					res =3D error(_("could not write file: "
+					ret =3D error(_("could not write file: "
 						       "'%s'"), path);
 					goto unuse_commit_buffer;
 				}
+
+				ret =3D 0;
+
 			unuse_commit_buffer:
 				repo_unuse_commit_buffer(r, commit, p);
-				if (res)
-					return res;
+				if (ret)
+					goto out;
 			}
 		}
=20
-		strbuf_release(&rev);
 		flags |=3D AMEND_MSG;
 	}
=20
@@ -5272,18 +5291,29 @@ static int commit_staged_changes(struct repository =
*r,
 		if (refs_ref_exists(get_main_ref_store(r),
 				    "CHERRY_PICK_HEAD") &&
 		    refs_delete_ref(get_main_ref_store(r), "",
-				    "CHERRY_PICK_HEAD", NULL, REF_NO_DEREF))
-			return error(_("could not remove CHERRY_PICK_HEAD"));
-		if (unlink(git_path_merge_msg(r)) && errno !=3D ENOENT)
-			return error_errno(_("could not remove '%s'"),
-					   git_path_merge_msg(r));
-		if (!final_fixup)
-			return 0;
+				    "CHERRY_PICK_HEAD", NULL, REF_NO_DEREF)) {
+			ret =3D error(_("could not remove CHERRY_PICK_HEAD"));
+			goto out;
+		}
+
+		if (unlink(git_path_merge_msg(r)) && errno !=3D ENOENT) {
+			ret =3D error_errno(_("could not remove '%s'"),
+					  git_path_merge_msg(r));
+			goto out;
+		}
+
+		if (!final_fixup) {
+			ret =3D 0;
+			goto out;
+		}
 	}
=20
 	if (run_git_commit(final_fixup ? NULL : rebase_path_message(),
-			   opts, flags))
-		return error(_("could not commit staged changes."));
+			   opts, flags)) {
+		ret =3D error(_("could not commit staged changes."));
+		goto out;
+	}
+
 	unlink(rebase_path_amend());
 	unlink(git_path_merge_head(r));
 	refs_delete_ref(get_main_ref_store(r), "", "AUTO_MERGE",
@@ -5301,7 +5331,12 @@ static int commit_staged_changes(struct repository *=
r,
 		strbuf_reset(&ctx->current_fixups);
 		ctx->current_fixup_count =3D 0;
 	}
-	return 0;
+
+	ret =3D 0;
+
+out:
+	strbuf_release(&rev);
+	return ret;
 }
=20
 int sequencer_continue(struct repository *r, struct replay_opts *opts)
--=20
2.45.2.436.gcd77e87115.dirty


--5wTKzCkUdLniK+be
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFu4ACgkQVbJhu7ck
PpRHcA//R1+chvxMhzB4snYzJx5afDfj8piavjyTwRk4elZVG9gxogjpwRwIZ6n+
ZW9r+zmHIvxV2A1cU3mZldSGRWUdqkrQhs0y1vsbY8m6KoxlK3KLhwGvo5LJU0pp
n+38PJMZ6Mxq1AtgSzG//4c/+/6zy10gvz0xpLhXfUrgkQawJIkXuY+iSPqspmCl
SBZ2V5vxWLSftWMkLMUl+AK2YGKPWJ22GfR8npsJRmzcpQOArQIUaBiJMoZIVaeN
zePBJTFmojsXT6A0IWrEevRsaA+kuTx6iK2NhSnlI+xroANTc7yvX7z6QUoQSNB7
Hzm7pneCE8p2bXzb6ofxlUuB5h3QC9PDw24A5JdCEqVrcfuq85v4chmYmpGX1Gsp
ZyYKhnpu7NrOo0TXKScl41GTlfKf9n48K3yZmdTyx0//jnZzR1CrRoismD2WBMH2
mwG8micRLh6Hkgjbp47WC2E8xAsB3JgFrJ8A62ZNZS+P/oRGQWB4hfGVlBjPh2RL
AyzHKG9iHWNaNKLrYbKMq4RO9o2iMlWQMbmqUdMMYi8piunlDYSQPsN3Ryd0zWgv
yK9vPPFCkkhG8PI4EVRWgBWEWyiOCQIlFmtRwOrViCzNEYjSAOkm5h2YY00hOi45
Hbcgl96ngRlNrHyKwyh9bg0gWlTguiJ4O0cP9LX1Z9JMR4IJogE=
=G4I0
-----END PGP SIGNATURE-----

--5wTKzCkUdLniK+be--
