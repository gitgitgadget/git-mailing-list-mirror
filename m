Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A1F85935
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408086; cv=none; b=DIXpBXg2AM+Is2IjX6yjDYWJgJj+h8DQG36AniQwNMEjRP2/ZCtgca18PP8UXcckQMorUz2Ap5uDho1z3/woRjFVCH5Tr9Ay5jkfMU9J14uvGROJusRweMUGvskVYfRzm1mNle+Le2f3f64k0tMynmGYgusP1589ALp1gHk+AdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408086; c=relaxed/simple;
	bh=QpVNQk9K7tn5lnLteSRCyrdzlX+WhE3h0Q3a/4YPA7U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ58WpvrhTv5thkeER2p02QTfidPxWgIjzbYIltaSv3e1M23n26NToSfERIPIrPNCxXBfnQGxH+F/Y54NB2VkTISHAGiLp3KE2tTEK/1f0db8THuGrcVmNLlU3WTuLaFQrB0hNeqTNwlWG7ECUucuKdvOcQ8qqq1ihU4zNwbp5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VuN88EhY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qPZlAbSy; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VuN88EhY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qPZlAbSy"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id A97591800076
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:48:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:48:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408084; x=1717494484; bh=wZxLIM1lzU
	eOHaEQjddLdnUzJlYBXjLEBZnFJX2QGgA=; b=VuN88EhYB6cIWKGaqu7Ubp4YAO
	c3/5hzqQ3iKilM79sTe/7TRctoiqtH1cBGOfSbCGuRHQKhXOPSmPru7dvW31Zioe
	EFBcLF+sZ0U2fEQ8WCpoSmGpLA4048mZXis1CIZXLUOSXSuG4fd65Gt/RFVsCWhG
	868mNpvzh4F790pPaJO7N1YjMQunlsqkkALkvWKIKzBzkxBWKJ2q5o/mJMbvivQr
	R1+Q5v/hGMlu6LmITS7Bm7zqpz/KK3oIrP9AZIZLbEfPu+FjpPosBuoUNvfVYvH1
	cCZyRuqwX3/zjtQbZS2RNm6Tbf5HJEZrRTjgA6g66z7tRsaPQ/fSLqeh/nWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408084; x=1717494484; bh=wZxLIM1lzUeOHaEQjddLdnUzJlYB
	XjLEBZnFJX2QGgA=; b=qPZlAbSyTzp8zYQk2Qexg2oVq/7TW5pHNwbZmKuwOFtT
	FIwp7m2pMg3PK1cNKrJcW0JOydPrG7Z6+czPtsYfoPWCBFDKpw2jmM099L6P8srJ
	vxUuAYL+Ozar9rcrue3a+D/kjt4mMbSIos0PZ53YknY4k6jKbXoUYvaueTYNLKVN
	Q2JjSkmWSN+CWEUGedAuJDT+LS0MmdtiYJr60t25LWW7TMk+xf6AWaFT1il9K94d
	kvRFhskBJfMw9bcPNTmZ/f4cvUYKt6fWE2m/CYOFZphoZJ81UsFq9Y036Ogjf6Lk
	1FX+YYXsH1xX1asx6Jp9CGkpZU6Ai7wFrRFdR7oJCA==
X-ME-Sender: <xms:VJFdZjKvKFwvcSqjQJJrtBD6Z7sluLcM4pWKrkQiK2y1J75KIRqAOA>
    <xme:VJFdZnKgx_CT4Gjuos8NsavusygjtjEqZghT2GXGfWajp7__RBL4kmi6gg9gHsc_1
    CUqWIshMNtqWNl6Mw>
X-ME-Received: <xmr:VJFdZrsUnpsMPBtR_Y4ve1NxKhSm1YA2pIOPBSzrgJVO8iA9JKgXjA2n9TZLuX7IHatWM8ZbTH0-zccHhpHVoRP-ZxnMdN6GfP1eq8-0-XkcPXhn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:VJFdZsZBNtQbeiBniKwsrZNLJjWOczW4Eeo4VcusTBN7wsxAUIalHA>
    <xmx:VJFdZqap_ayUCnT7MyeRji1ekvclqKtpnc2lPmdrhtB9rTNlqRvNTQ>
    <xmx:VJFdZgD8WmjDWKVDIdHpGz6Bldl17wjc5LGfgMwvl9ojnmX7rAPdbQ>
    <xmx:VJFdZobdwu-TcPVwzEh_9nSxi1XDrZ6of7IKjtQ-r3mm9t6JrBgbWw>
    <xmx:VJFdZtx_zaSte3fBTvbg7Gp9_y-qX9IjUm3d9tcDvI3QhDvBxw8EjhmF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:48:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 1e1a1c2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:47:38 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:48:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 20/29] sequencer: fix leaking string buffer in
 `commit_staged_changes()`
Message-ID: <48bcd0ac80ee0b60eeda2bcedf55003a5049f289.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wZQ3MtTg5BTLKgYg"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--wZQ3MtTg5BTLKgYg
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
 sequencer.c | 105 ++++++++++++++++++++++++++++++++++------------------
 1 file changed, 70 insertions(+), 35 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 475646671a..2ce807533f 100644
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
@@ -5242,8 +5258,10 @@ static int commit_staged_changes(struct repository *=
r,
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
@@ -5259,12 +5277,13 @@ static int commit_staged_changes(struct repository =
*r,
 				}
 			unuse_commit_buffer:
 				repo_unuse_commit_buffer(r, commit, p);
-				if (res)
-					return res;
+				if (res) {
+					ret =3D res;
+					goto out;
+				}
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
2.45.1.410.g58bac47f8e.dirty


--wZQ3MtTg5BTLKgYg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkU8ACgkQVbJhu7ck
PpTjig//dwWOY8r0b3pW+vKV3xtWLUvSy5RZFk5sfqrhxn3u1LSNaJMk/xYZQK8+
5kyvu/ETKk/GODVVlvKKtYa/Q5JwI9W/GmzH1YrBVbuKnRNOJzTFdhDTP8CJui/Q
hJ4SYBFHelozpar4pSQ4idI5/EyM8YSvxe4SLpkUuGyjrtB4B0OjLMweiXXQosnl
gX8vuqi1dwQFL8CJfpfu0ywbbgc/xUd0QAlLZg90s6BU3JmIUmzlEc8+G4AqYvZF
KkniLYReeTqpaAm0cBcLIX6T4ojpCjiW/aCw5+OZssiuprG93vXmlIMkjtlNzqd3
CG6zcRcIWgphS24NWqKjR1z7xVOEZZSm2MNnBcsbXY/hUDL6+PfbxmqVR5BSWw/s
ooXnavYMCc9yBiD3R+P80XcGwL0GBiEJNueEmfXDtTRIanl8qrg73WIPtEo4D0ry
Vud5WgsYET2cjOWLFSJ6DKWotXMyzRvfw+vzgvlIQgLNENq8onvrEAgkUQwuLeYw
BfBjwIuhu+nRY82ry3u8WL+G1oreE4xFLJEoZ4NLVhS3Py6KXCmQzrq3sqabF0sn
tAAZXOoHhI+PA+v/WZy6uRSB3/ZITyjVxc9kSWNEoJT4Zf3fzvk1DJojyh3xzVqT
x1yBVT6reJXLZiPlQuCj1QEjKRnFFDS5oxZKLsGzCvoed8+meFs=
=aIgj
-----END PGP SIGNATURE-----

--wZQ3MtTg5BTLKgYg--
