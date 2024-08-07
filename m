Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543D01B4C55
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013823; cv=none; b=SOKw5MYZA6P8RXjhVVCc5L8onvIRqeimJqx7xc8kwJYQQIWH//pPAbC4oD78qj7J1yD3SY3k0DkyYkHjQShMqAwTFMrakwWoP8nnbZ1hFCEs/S8IbM0gtUy0qoNlfiFcMP+4eIZ/CgUtBNGDp56Ggp685Za366p1ny8onzHDIuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013823; c=relaxed/simple;
	bh=qXihFKikmPcuhBDJ+VXw4bq1vhfYIEq8tpHauXwIeV8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e1Pxd4lRsLmOZrfbHZmEuxHPEl9HFTSzJnt8186J+9YuQHlQ6Uo2uzvpKZv6YZH9FTivqur2aBqBcfuQLMy1pzqngUpWtpbrap3OGIdbJMK0yJSTbx3Uj646AAo+VX357yidvIE2B4rKkH4I7px3VJeaEGgR6J3VCtqBBVWLcOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lIMovo0y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O/22L1FE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lIMovo0y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O/22L1FE"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id F198A138CDF7
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:56:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 07 Aug 2024 02:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013819; x=1723100219; bh=+z8Ihh81hU
	+VHetWpubaMX8D8+1/vAOSGbBZ8kTKMzM=; b=lIMovo0y+z07m0tun115nfP2eV
	+lLKoknB6TptPDdjXU8fYLhmSoA7MwAsR9QdrM2g8isYiHY1j+HHi2TczvaBQYUn
	sH/zptoyvhZVRhE7n1mm1yuXj4eL8SLLGANrLq0uUZGHRYw51hzj0i3EhmA0YwBV
	6prwEs1thdrWSSDh3h/DPByAoPii6prSZXUFUJSJntmNFMvAC6Wj1LqJZ6Z1RybF
	Y2jwwN9beDa76e44fp+bxiKlkLbFQtOdh6I2gI4HaE8kfew3o/raoN7iR98RthPW
	d2WGxUXV4QnmgQdlsw4kpI69TkSApCxBer0Ttagex2VtO4keTnp5GUT1QIsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013819; x=1723100219; bh=+z8Ihh81hU+VHetWpubaMX8D8+1/
	vAOSGbBZ8kTKMzM=; b=O/22L1FEl+MF/WgQ+DhimwluPVYDmo3iUf5lvYqJwMRw
	6mdyUXdsMoohDv0FoRclUoyApgyaBoVJ0qoE7nNnPs6ySIJLDd/5nOSdKTmo9piq
	vzLNP4nS0ofR9pWBgu9Xfhl2lk5PYZ51OZgeLgwn5xEjBTAmqln0NQw9/6+1S59w
	92hDi+9k33UwmbTt6kvrksX8We419M7xRm3usYHyNxRe2WWl5IzDHbVW/Q9urCB9
	xIBZwOqp32L7N0jrYY8Vbl+2uRqvsA9F+p8g6RjoQKg8tVHML6+xgTHrSeJ+V1K3
	xTF3jiTHF9HLTcHOD5GF1rUCzUECK4WBe3HDy6+SwA==
X-ME-Sender: <xms:uxqzZtfgPG8fUu6i335II-m5a41TOgF3-rhHojM4VmkeKgPlFy_-CQ>
    <xme:uxqzZrMBFw9KNy3Z8SSKT-I55KWVt6w21Fm30Md9nC2A9JamMXH4L7bfVFE2XRYdy
    tZ4q1pw1xiYE5pTfw>
X-ME-Received: <xmr:uxqzZmjjttr5RfUDEprV3UKRfiD_6vvNVE7rzKz2AR8zs0vbHj4AEVoRljsNiIMZ4tKgGNDp1cs3sQOycTaqfuWzdVwiz1BcHW0UDerHcqhqqxLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:uxqzZm-v8Yg7tXkcQZiRu_TIhprNrU3S0NKLSU061yuXdo5zGtyDUQ>
    <xmx:uxqzZpswHavSEzKhtRpDtLpHTxHdqm7ipbtl6OaJBXfB0UA1PvOi7Q>
    <xmx:uxqzZlGQ484iuOGg2t326ZPcTU_tX40s52-LkqxbPgHUx9hki7N44g>
    <xmx:uxqzZgPK1kVlmQOQvZEa6moXI1hoGbxZPG1j0kW0b55cJQeyE_di-w>
    <xmx:uxqzZqWZfyrxShXFB3Dx94COte8pDD64BVnl8ALadPAjNqPUPRB--EYX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:56:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5fa178e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:56:54 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:56:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/20] editor: do not rely on `the_repository` for
 interactive edits
Message-ID: <c2556fff9e25aabab237c5902aff64f65b0a953f.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MnTTkIvIeTm1r9ss"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--MnTTkIvIeTm1r9ss
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We implicitly rely on `the_repository` when editing a file interactively
because we call `git_path()`. Adapt the function to instead take a
`sturct repository` as parameter so that we can remove this hidden
dependency.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 add-patch.c |  3 ++-
 editor.c    | 12 +++++++-----
 editor.h    |  3 ++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/add-patch.c b/add-patch.c
index 46f6bddfe5..4e3aa02ed8 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1140,7 +1140,8 @@ static int edit_hunk_manually(struct add_p_state *s, =
struct hunk *hunk)
 				"removed, then the edit is\n"
 				"aborted and the hunk is left unchanged.\n"));
=20
-	if (strbuf_edit_interactively(&s->buf, "addp-hunk-edit.diff", NULL) < 0)
+	if (strbuf_edit_interactively(&s->buf, "addp-hunk-edit.diff", NULL,
+				      the_repository) < 0)
 		return -1;
=20
 	/* strip out commented lines */
diff --git a/editor.c b/editor.c
index d1ba2d7c34..6c461dd253 100644
--- a/editor.c
+++ b/editor.c
@@ -134,13 +134,15 @@ int launch_sequence_editor(const char *path, struct s=
trbuf *buffer,
 }
=20
 int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
-			      const char *const *env)
+			      const char *const *env, struct repository *r)
 {
-	char *path2 =3D NULL;
+	struct strbuf sb =3D STRBUF_INIT;
 	int fd, res =3D 0;
=20
-	if (!is_absolute_path(path))
-		path =3D path2 =3D xstrdup(git_path("%s", path));
+	if (!is_absolute_path(path)) {
+		strbuf_repo_git_path(&sb, r, "%s", path);
+		path =3D sb.buf;
+	}
=20
 	fd =3D open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
 	if (fd < 0)
@@ -157,6 +159,6 @@ int strbuf_edit_interactively(struct strbuf *buffer, co=
nst char *path,
 		unlink(path);
 	}
=20
-	free(path2);
+	strbuf_release(&sb);
 	return res;
 }
diff --git a/editor.h b/editor.h
index 8016bb5e00..d4c4d216ac 100644
--- a/editor.h
+++ b/editor.h
@@ -1,6 +1,7 @@
 #ifndef EDITOR_H
 #define EDITOR_H
=20
+struct repository;
 struct strbuf;
=20
 const char *git_editor(void);
@@ -29,6 +30,6 @@ int launch_sequence_editor(const char *path, struct strbu=
f *buffer,
  * If `path` is relative, it refers to a file in the `.git` directory.
  */
 int strbuf_edit_interactively(struct strbuf *buffer, const char *path,
-			      const char *const *env);
+			      const char *const *env, struct repository *r);
=20
 #endif
--=20
2.46.0.dirty


--MnTTkIvIeTm1r9ss
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGrgACgkQVbJhu7ck
PpQm6A/+MXN5cMr54uVqU+ErmNph5ifId3jg4Wl3L7HZkJTpW77t4mWfd0zkqWYh
S7NZPjKP6Voe51S55EAO3eMngmiFrPnRyyyMdQJwdr9vnQBbXZF2gUXGyhMAcAjH
+KMwOPnb0+HEmSjmqkSVT+U5fgYBVIhgq1IMhmQBayfsQFlmNfGv01IX7bx44lbr
tVdB8/9HaFSIqoOQJ6xWaNB4nuOvoL3DEukkf2L2bE+xsuIO2JIYPUHscSokBjM3
35yHKwqd5RKLN2mxnisErLElRaY11QCgKmRs5nkDXiWjxdupQTu0OEnkF2/fsehf
9/3M0VLTTfKEK/8Nl+tlxSdIzjtpT1Ol72fq+NGlzrpWAoE7wVmODxvY1FGact6f
L7JMBiQUd8+ImNQLyyQbbUo6p9u0TO9rxuIXMdnxdMg5v6vxxb/Hkh6cHdTKZSxf
qgkwDFGT3y6GvioLQADtqyMTdb+/qYYA6kRd8ICB+KMOJUhtOy4lB0V7mM2OAsuK
PJ5cp+cPerOi6e9sb2mxhu7NKvNOnjmT3HxHNxyy/KI50wSJteJMzHQZsLkEQ8na
ap1Q6GP0ECMg8TT1MHv/FJMuX7H5gjZCvLhXVvoWjum6D43bjy6eTVmurwbmVKai
YugjA1U4zt1nLE9VuPNmjFAk0fxuqVECtA+O7CHr5CKwPy+Gbd0=
=HJ9W
-----END PGP SIGNATURE-----

--MnTTkIvIeTm1r9ss--
