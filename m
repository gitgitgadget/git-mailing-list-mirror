Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3292C68C
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933955; cv=none; b=PvlrFf9ctwaijDKnk1rFxaQa5L9x7ZzzC6PpW24XZ3GzbYW5ukB55hi0k5geTw7DJNk/vEfvu/PfQf35vqydc+q5ql1mMEZIcAmT4lJqUBJU2s1+zs9Aem76xERlC6hsRaMEFfy2IXTwOH/Q4vTn244n/UG39CQDiutwsHp3m8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933955; c=relaxed/simple;
	bh=wFM988INED51iI5iNFjo8rXZeguyl1hQwIv8tJs0Jlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MMa+UrrY+6doLmLGc9aiT8J+rhynPgTWWWhNLSPuhdMzw1duM3hXtIqO9Po0onXOj+THiRbtC+incTIdYF+EACrTV2zhn1veCrx4dSnmDQbtkcadRTb1oMwYVjZrHHydoymFmAWGcy73QMT483r5OjgwiYZFxnMc0sgMIR9YDh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V2d1L6A6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PKiwossO; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V2d1L6A6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PKiwossO"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 0F55E1C000BB;
	Fri, 17 May 2024 04:19:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 17 May 2024 04:19:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933952; x=1716020352; bh=Q2rVk68H1T
	7Z5cSIgXmfcHgNue9v4ZRkKZ1N3nSjx8M=; b=V2d1L6A6FQk3pVS3BxnITR5FmM
	eu6VPtYjMtlr2XaKIxS3IrmMfhGWuJfDrh/poINufMCbtPDEp0giszGJsq2uDci4
	M3KmKVb48ds3nXxM6UptqdTM8B8h1QyF5eRs1EFPnOSUD88n9TuN7G5BrrsW04MH
	P0ENRc+lbi7DFw+KiEi/OACp3nHnUEI2Ao9xeeQqykNG2Oeux9l/PK3sAoZl1L8t
	BYQtUastWS0QGNgh79HZpWI8Vu76VdO7JcDvfDp8uDNL9+5lTWJh01HVnBkRU32R
	oU5dlGIpz4+9Altp72FnOL2p28QtPB40Si5J9FzhNZgOpTbYmO53yv9/vZ3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933952; x=1716020352; bh=Q2rVk68H1T7Z5cSIgXmfcHgNue9v
	4ZRkKZ1N3nSjx8M=; b=PKiwossOGrU21NQssNezsniRwjP0970yUs4BiG8VrW9f
	KUEf+Irt4I8QoUYisO31/+YkI7DJ9/SNzZxGCoVzpBfpfWQv56ligGpto2BJ2eDk
	LkBvaYu9MDqnRQy+X0M8RloibFEz9V5xXv8DLy2vgH8Yws+HmpecapuEx7O9o0Ux
	69NgpQpY1mBGXWNUfdHN66u9pw8yBcFRbt7pvs4qqgRg+cC3RlK2X2GhjEVr5iqc
	eU2d6YpL5ov+mY48xMk4xu4iZDNvlNSYvDG5AklbXehTG2vpb8WcigIAKxEh3BP1
	S8bdSxmD7oXwcpHXrAYoyEMh8EQZ3mbAmaURlGeRAA==
X-ME-Sender: <xms:ABNHZqHjqQWgixhYyBAbktLK-HxV81x7_b4kA_qm1_MG9aKS_1V93g>
    <xme:ABNHZrWtOsqgGR6glI341Jzran9SO0u-xa4f4WNqAQhXHRI6uaTr3d7o30cGR9FDW
    tnERCgW_QsUE_BxlQ>
X-ME-Received: <xmr:ABNHZkLsSOPR57aEgmWbYUkz0Va4CRKd4pa5bxBnU5bV1LIQVel23f8TbXTecmfKPqEJSU4c1e4lS0w5TBWPq-cDhCJX8ZD-4MpKNaiw_s2P92jtTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ABNHZkFQC5hf28JRMw1v-Wkeg9NtMGlS7ao3AorSWdX4rzNFJwX_oA>
    <xmx:ABNHZgVWG31DlATEXE1-DZbfEDfhNT0keAqpXrUzoAk3rE8ZwYXNww>
    <xmx:ABNHZnO6bvehBPcoBBltCU0a1brtizXjUFsSaWkrMRf77cX8Oeyxcg>
    <xmx:ABNHZn1GSuQWiRuTmGXDTZX9QX-dCGq37P5YzvccGD1Oo4lWBkGYWQ>
    <xmx:ABNHZnTbWvAuWHHXGZpFfBinWmLCBFHLqlzCGihdZ_TVpFBfltriazfP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:19:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3f2af3f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:18:44 +0000 (UTC)
Date: Fri, 17 May 2024 10:19:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 12/16] refs: drop `git_default_branch_name()`
Message-ID: <e02e76701f94a062337a303e90bf276fc9a5a0b9.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EXNXGQTLlBgR6DXb"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--EXNXGQTLlBgR6DXb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `git_default_branch_name()` function is a thin wrapper around
`repo_default_branch_name()` with two differences:

  - We implicitly rely on `the_repository`.

  - We cache the default branch name.

None of the callsites of `git_default_branch_name()` are hot code paths
though, so the caching of the branch name is not really required.

Refactor the callsites to use `repo_default_branch_name()` instead and
drop `git_default_branch_name()`, thus getting rid of one more case
where we rely on `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/clone.c |  5 ++++-
 builtin/var.c   |  2 +-
 refs.c          | 10 ----------
 refs.h          |  4 +---
 remote.c        | 12 ++++++++----
 setup.c         |  5 ++++-
 6 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 554b29768c..bd3e8302ed 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1468,6 +1468,7 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 	} else if (remote_head) {
 		our_head_points_at =3D NULL;
 	} else {
+		char *to_free =3D NULL;
 		const char *branch;
=20
 		if (!mapped_refs) {
@@ -1480,7 +1481,7 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 				"refs/heads/", &branch)) {
 			unborn_head  =3D xstrdup(transport_ls_refs_options.unborn_head_target);
 		} else {
-			branch =3D git_default_branch_name(0);
+			branch =3D to_free =3D repo_default_branch_name(the_repository, 0);
 			unborn_head =3D xstrfmt("refs/heads/%s", branch);
 		}
=20
@@ -1496,6 +1497,8 @@ int cmd_clone(int argc, const char **argv, const char=
 *prefix)
 		 * a match.
 		 */
 		our_head_points_at =3D find_remote_branch(mapped_refs, branch);
+
+		free(to_free);
 	}
=20
 	write_refspec_config(src_ref_prefix, our_head_points_at,
diff --git a/builtin/var.c b/builtin/var.c
index cf5567208a..5dc384810c 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -46,7 +46,7 @@ static char *pager(int ident_flag UNUSED)
=20
 static char *default_branch(int ident_flag UNUSED)
 {
-	return xstrdup_or_null(git_default_branch_name(1));
+	return repo_default_branch_name(the_repository, 1);
 }
=20
 static char *shell_path(int ident_flag UNUSED)
diff --git a/refs.c b/refs.c
index 5f1819b33e..83cd965a26 100644
--- a/refs.c
+++ b/refs.c
@@ -664,16 +664,6 @@ char *repo_default_branch_name(struct repository *r, i=
nt quiet)
 	return ret;
 }
=20
-const char *git_default_branch_name(int quiet)
-{
-	static char *ret;
-
-	if (!ret)
-		ret =3D repo_default_branch_name(the_repository, quiet);
-
-	return ret;
-}
-
 /*
  * *string and *len will only be substituted, and *string returned (for
  * later free()ing) if the string passed in is a magic short-hand form
diff --git a/refs.h b/refs.h
index e043b6cfa3..e906dbb44a 100644
--- a/refs.h
+++ b/refs.h
@@ -169,10 +169,8 @@ int dwim_log(const char *str, int len, struct object_i=
d *oid, char **ref);
 /*
  * Retrieves the default branch name for newly-initialized repositories.
  *
- * The return value of `repo_default_branch_name()` is an allocated string=
=2E The
- * return value of `git_default_branch_name()` is a singleton.
+ * The return value is an allocated string.
  */
-const char *git_default_branch_name(int quiet);
 char *repo_default_branch_name(struct repository *r, int quiet);
=20
 /*
diff --git a/remote.c b/remote.c
index ec8c158e60..85c390b199 100644
--- a/remote.c
+++ b/remote.c
@@ -305,7 +305,7 @@ static void read_remotes_file(struct remote_state *remo=
te_state,
 static void read_branches_file(struct remote_state *remote_state,
 			       struct remote *remote)
 {
-	char *frag;
+	char *frag, *to_free =3D NULL;
 	struct strbuf buf =3D STRBUF_INIT;
 	FILE *f =3D fopen_or_warn(git_path("branches/%s", remote->name), "r");
=20
@@ -333,7 +333,7 @@ static void read_branches_file(struct remote_state *rem=
ote_state,
 	if (frag)
 		*(frag++) =3D '\0';
 	else
-		frag =3D (char *)git_default_branch_name(0);
+		frag =3D to_free =3D repo_default_branch_name(the_repository, 0);
=20
 	add_url_alias(remote_state, remote, strbuf_detach(&buf, NULL));
 	refspec_appendf(&remote->fetch, "refs/heads/%s:refs/heads/%s",
@@ -345,6 +345,8 @@ static void read_branches_file(struct remote_state *rem=
ote_state,
 	 */
 	refspec_appendf(&remote->push, "HEAD:refs/heads/%s", frag);
 	remote->fetch_tags =3D 1; /* always auto-follow */
+
+	free(to_free);
 }
=20
 static int handle_config(const char *key, const char *value,
@@ -2388,11 +2390,13 @@ struct ref *guess_remote_head(const struct ref *hea=
d,
=20
 	/* If a remote branch exists with the default branch name, let's use it. =
*/
 	if (!all) {
-		char *ref =3D xstrfmt("refs/heads/%s",
-				    git_default_branch_name(0));
+		char *default_branch =3D repo_default_branch_name(the_repository, 0);
+		char *ref =3D xstrfmt("refs/heads/%s", default_branch);
=20
 		r =3D find_ref_by_name(refs, ref);
 		free(ref);
+		free(default_branch);
+
 		if (r && oideq(&r->old_oid, &head->old_oid))
 			return copy_ref(r);
=20
diff --git a/setup.c b/setup.c
index fec6bfd5fa..481b57d523 100644
--- a/setup.c
+++ b/setup.c
@@ -2046,6 +2046,7 @@ void create_reference_database(unsigned int ref_stora=
ge_format,
 			       const char *initial_branch, int quiet)
 {
 	struct strbuf err =3D STRBUF_INIT;
+	char *to_free =3D NULL;
 	int reinit =3D is_reinit();
=20
 	repo_set_ref_storage_format(the_repository, ref_storage_format);
@@ -2060,7 +2061,8 @@ void create_reference_database(unsigned int ref_stora=
ge_format,
 		char *ref;
=20
 		if (!initial_branch)
-			initial_branch =3D git_default_branch_name(quiet);
+			initial_branch =3D to_free =3D
+				repo_default_branch_name(the_repository, quiet);
=20
 		ref =3D xstrfmt("refs/heads/%s", initial_branch);
 		if (check_refname_format(ref, 0) < 0)
@@ -2077,6 +2079,7 @@ void create_reference_database(unsigned int ref_stora=
ge_format,
 			initial_branch);
=20
 	strbuf_release(&err);
+	free(to_free);
 }
=20
 static int create_default_files(const char *template_path,
--=20
2.45.1.190.g19fe900cfc.dirty


--EXNXGQTLlBgR6DXb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEvwACgkQVbJhu7ck
PpQS3A//bIEdsarvDkc8duCqdineB+2oPeP4x52c22FjmNeDlswrn+ybZovLi8X8
RAV+i8biLIlSVIuA1pJH08K4JGEJyT5QPKo1WWsNAVR0uz+xflDtdX8xlSQRQ5sd
OSocCodxcoPolPWXzUc6WfsXfacPOs4eq1huTvp1h3iFAhJE+s2SLRVWHFuf4mjG
fTYD3H2FYVaGQQ0C1yg5ehI767CaRtmEzgGYzWlV6CHk7Kd1HC0r/tq67aUcBQjI
AWq0rqlMACCvPfRyN1qoZb/NBSwcOztpZCygd0KUr7nS8JMz8wj3fr+pYQjtSOmG
WEWHt72Ox5Os0mL5KNPsaIJdiELSd4DXRsiR5CL2EO2H8SOoebjHF65u8EiKJmhZ
uXkN9ogkl1akjQJYLnqf6LCGplMNpRthZQfHoRlnLZNhH5PemWQPXUemPWWT0u72
94XN0o9w/+bp7c8zaFtvdIiZs6oih21CGGbJuCEnhBZW+HLmMuzY8fqOHkHmUMCu
At++52Lij28/trxnr1WxU8m9+TYLSilrkhn4OBMds84OqACWfgcqNkPBdZ+6qTlz
jpdiA2AUjxDgb/EwOQq8oVZ7tgEVNHqQHogFnlxIX4hRrdJR9hw17rv5Ov8hFdDg
dwuvLFjir77SseIaChIPdnDkxVcUTcyBriRr9sNPZIKMPGob4N8=
=TxNs
-----END PGP SIGNATURE-----

--EXNXGQTLlBgR6DXb--
