Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389564CB2B
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 10:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660819; cv=none; b=IwR1kne/cb/k8G8eSKSJeFrA+FYS60V4CFOfnB9D7Qg81A5fmugU1V80IoAz5On9fyIqkpcCIc1Xcbq9fU130w5mEZDdWcNakfNLJUk/Y425NpE0o1b8QHnR4wsXuownoQIDg3ZpCN0EsREi4QPMQq3A3a/ccyG8PWL1wAPygnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660819; c=relaxed/simple;
	bh=Ionwfuf9oz7JxPUmTJc63/v1vgCe+V6tUHqSct7MphA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnVaIuTFPUg2/Z4SXz+m3dUnvm5Y5ch03aGNFMW0kLS7tmHIIYSusSeHzFI9wLPKX9kNlquuiyJOvlHd3vfJRT30lR6lYPVLsAPJfG+pGBmBqBBGrH8d8zDbFLm7vjXqsTcsY6/qn9edZlG6yI8p3uyjCNjXSqm1L9K9YkeBp0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N7nP/hZs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IoCyJOV6; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N7nP/hZs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IoCyJOV6"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 7655A3200A61
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 19 Jan 2024 05:40:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705660816; x=1705747216; bh=g02wHMbDSc
	QpQr93XuGiq01me6bjc/LiYvKuzH/uczo=; b=N7nP/hZsOZ6P+vWyNTUn2mZb0c
	I2mv/mBetZod/EPZo0y56BLRfu8HUDi6PSd78pwlytofnji756Z3dCEKs+vqaXnO
	u1eMbuKGiBZ6oMPHtn5gBc6W4Xyj3KPiJBg9FwNayFL37vpUv0vSJLcjpTqOMfOS
	17B25oYLuA7l02+JhS7DFFwZFlGsSnXbQrWeHZk8EjRnzXycJANNZqGy7qdk99jK
	/sTSX+Eycq8jghO6cXJriXpT70lJY3Eh4WYEaqJe9utkiNiohC7FKw3vwmEjRaF5
	5ZSj+9gvEQuy/EAYvljKsOMV8/ObJUv/P+9ofAxVuT9L/sfgOJ7qkO/GfZdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705660816; x=1705747216; bh=g02wHMbDScQpQr93XuGiq01me6bj
	c/LiYvKuzH/uczo=; b=IoCyJOV6Ksaam6J6jc6s4dWMwtZB+LXexMtulySesTWe
	9bdYvgWQC/4IM+eVXbzyIO8Rq22rd13exaWsZMzwaTSBwid281fYQZcd4UGnBP4o
	9x/+ON7E6Z68dx6JGnIluES3snTHPeJYHzIaQ32efElSUkkMkGeZsTe80sJ0nWfL
	NIvnn+PEI0xpQPSgVDwTwTZpoT5Ot/cd5M5T/voh2paCbWYM7Us5XRYdVT6snrep
	imvGH1XmFNT16nZIN61pP9tpsTZqpDy0LpzjuIadIgpCD87cYkpXfJrxeSE3IFSG
	wuiCPpeYkd+P3d1sTZdeIYwLKN9p3rtf/J8/+rAJiw==
X-ME-Sender: <xms:kFGqZbKOtTY6XYBCnb-rP-ktcYBFQA-lf60ixhF493tbU_fhVktnng>
    <xme:kFGqZfLJj5natW7A94Ei9AHnq5iGaHWEzRJfoYOa-KJIVc1yuYhTGjZlq8CJg3II1
    -maHcp-gPzEzoASCw>
X-ME-Received: <xmr:kFGqZTvAIJDwA-uD4AgCF4UU0QVzsxzcd8jdXlgRql88EaeVuAC1IaQAkomJmC3ttwFWiSrpn0CbT-EoWtFa4CZ4QACy80GGY1n5zRObSIK4Mhm-vw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:kFGqZUZH7m-j4_-uybauKW_t-uIaf8W5PgLdS_UBayfvI_mo08JX5g>
    <xmx:kFGqZSYBSWFzBzNszCH0epI_XmJNQcRraVNaNGeQUqbZgqrFTwgWug>
    <xmx:kFGqZYA9DIdFcXm_-oywMUL24mbjDyjoyBz2gmab4eVv4oWYiZZjEg>
    <xmx:kFGqZQ2JtAdhYBS9eUS6QKCoA17Q5dlL0AyGCelIMmTKgbyAKyntcQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 11f66a1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Jan 2024 10:37:19 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:40:15 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/7] sequencer: introduce functions to handle autostashes via
 refs
Message-ID: <abcf1f5cf428072d19639dc4209e0c1554f3eb53.1705659748.git.ps@pks.im>
References: <cover.1705659748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZdXJ0OiOW0UFPKpA"
Content-Disposition: inline
In-Reply-To: <cover.1705659748.git.ps@pks.im>


--ZdXJ0OiOW0UFPKpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We're about to convert the MERGE_AUTOSTASH ref to become non-special,
using the refs API instead of direct filesystem access to both read and
write the ref. The current interfaces to write autostashes is entirely
path-based though, so we need to extend them to also support writes via
the refs API instead.

Ideally, we would be able to fully replace the old set of path-based
interfaces. But the sequencer will continue to write state into
"rebase-merge/autostash". This path is not considered to be a ref at all
and will thus stay is-is for now, which requires us to keep both path-
and refs-based interfaces to handle autostashes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c | 66 +++++++++++++++++++++++++++++++++++++++++++++++++----
 sequencer.h |  3 +++
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 47c8d17cbb..91de546b32 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -4463,12 +4463,17 @@ static enum todo_command peek_command(struct todo_l=
ist *todo_list, int offset)
 	return -1;
 }
=20
-void create_autostash(struct repository *r, const char *path)
+static void create_autostash_internal(struct repository *r,
+				      const char *path,
+				      const char *refname)
 {
 	struct strbuf buf =3D STRBUF_INIT;
 	struct lock_file lock_file =3D LOCK_INIT;
 	int fd;
=20
+	if (path && refname)
+		BUG("can only pass path or refname");
+
 	fd =3D repo_hold_locked_index(r, &lock_file, 0);
 	refresh_index(r->index, REFRESH_QUIET, NULL, NULL, NULL);
 	if (0 <=3D fd)
@@ -4495,10 +4500,16 @@ void create_autostash(struct repository *r, const c=
har *path)
 		strbuf_reset(&buf);
 		strbuf_add_unique_abbrev(&buf, &oid, DEFAULT_ABBREV);
=20
-		if (safe_create_leading_directories_const(path))
-			die(_("Could not create directory for '%s'"),
-			    path);
-		write_file(path, "%s", oid_to_hex(&oid));
+		if (path) {
+			if (safe_create_leading_directories_const(path))
+				die(_("Could not create directory for '%s'"),
+				    path);
+			write_file(path, "%s", oid_to_hex(&oid));
+		} else {
+			refs_update_ref(get_main_ref_store(r), "", refname,
+					&oid, null_oid(), 0, UPDATE_REFS_DIE_ON_ERR);
+		}
+
 		printf(_("Created autostash: %s\n"), buf.buf);
 		if (reset_head(r, &ropts) < 0)
 			die(_("could not reset --hard"));
@@ -4509,6 +4520,16 @@ void create_autostash(struct repository *r, const ch=
ar *path)
 	strbuf_release(&buf);
 }
=20
+void create_autostash(struct repository *r, const char *path)
+{
+	create_autostash_internal(r, path, NULL);
+}
+
+void create_autostash_ref(struct repository *r, const char *refname)
+{
+	create_autostash_internal(r, NULL, refname);
+}
+
 static int apply_save_autostash_oid(const char *stash_oid, int attempt_app=
ly)
 {
 	struct child_process child =3D CHILD_PROCESS_INIT;
@@ -4586,6 +4607,41 @@ int apply_autostash_oid(const char *stash_oid)
 	return apply_save_autostash_oid(stash_oid, 1);
 }
=20
+static int apply_save_autostash_ref(struct repository *r, const char *refn=
ame,
+				    int attempt_apply)
+{
+	struct object_id stash_oid;
+	char stash_oid_hex[GIT_MAX_HEXSZ + 1];
+	int flag, ret;
+
+	if (!refs_ref_exists(get_main_ref_store(r), refname))
+		return 0;
+
+	if (!refs_resolve_ref_unsafe(get_main_ref_store(r), refname,
+				     RESOLVE_REF_READING, &stash_oid, &flag))
+		return -1;
+	if (flag & REF_ISSYMREF)
+		return error(_("autostash reference is a symref"));
+
+	oid_to_hex_r(stash_oid_hex, &stash_oid);
+	ret =3D apply_save_autostash_oid(stash_oid_hex, attempt_apply);
+
+	refs_delete_ref(get_main_ref_store(r), "", refname,
+			&stash_oid, REF_NO_DEREF);
+
+	return ret;
+}
+
+int save_autostash_ref(struct repository *r, const char *refname)
+{
+	return apply_save_autostash_ref(r, refname, 0);
+}
+
+int apply_autostash_ref(struct repository *r, const char *refname)
+{
+	return apply_save_autostash_ref(r, refname, 1);
+}
+
 static int checkout_onto(struct repository *r, struct replay_opts *opts,
 			 const char *onto_name, const struct object_id *onto,
 			 const struct object_id *orig_head)
diff --git a/sequencer.h b/sequencer.h
index 913a0f652d..dcef7bb99c 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -225,9 +225,12 @@ void commit_post_rewrite(struct repository *r,
 			 const struct object_id *new_head);
=20
 void create_autostash(struct repository *r, const char *path);
+void create_autostash_ref(struct repository *r, const char *refname);
 int save_autostash(const char *path);
+int save_autostash_ref(struct repository *r, const char *refname);
 int apply_autostash(const char *path);
 int apply_autostash_oid(const char *stash_oid);
+int apply_autostash_ref(struct repository *r, const char *refname);
=20
 #define SUMMARY_INITIAL_COMMIT   (1 << 0)
 #define SUMMARY_SHOW_AUTHOR_DATE (1 << 1)
--=20
2.43.GIT


--ZdXJ0OiOW0UFPKpA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqUY4ACgkQVbJhu7ck
PpTjBhAAmAaG+vIJZMTo2P5XfL/jlIO6+f25zaVL3wrZN2JxFiZM+SsTkTx2lT7y
4EwMcw9qvUNIn9s2tq2n7RMEY1JzjbkPD/jYSzUY7oqJjm2Vi+KxTdtzCnOQBPvr
ohIFkZp9rbR0bOI3p2b3UdEvgbnewugK2q0l10srLAg3Z2cX+gpBLsEwwCoZsA7S
c3IvU52PSd9ck4MmV4zNycIytynLtTvEl2BrTH6RoBQgVuK4LhRJzLA5/jmWSxjh
CJjnmky/cclAUnw4Xz/UJEKL9E/sRZ7ioPd6YbYSEXzz8kqPxy3iyBE4IvwcPlr2
fhCdWyFAYIFBVQaNx0llWCZyxUUZCjNj5fukEBBNPXLVl81BZXCQGwrGWgIka1Ix
LgG1N9uN9htqmkQx7nKdD9xJ2RGwcE+icTsQZa3Hu64V0Rbvb1qulCbsL/M/qBJa
Wi57PdqtCRfRyZbyPkR3UTMQgZtbEfDFePF3oIIPpGinXASAhhiPiCEIezXm6Cr+
L9w9OpeE5hXf/H898VumrcY23ZoWoasCejKeC9oUFQpMDeRn9fFvkZHNJIix44R9
5TiXz0tCnYlH1ssIXj8ySELOioy2MMYM9YQYgdEK8YecTt5l+v6aPzoC7k+y187x
UbsY3j+LHUC8nW2RbPIGfB2gYDzy6ne4Cf2OEIb6YTfYGf30QwI=
=ESD4
-----END PGP SIGNATURE-----

--ZdXJ0OiOW0UFPKpA--
