Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D120B134751
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846715; cv=none; b=mMXTt58cazkl7mwcwFlHfmm33lODZ+hSViz51Y8PWM0I06R3Ylv50yjTv3vkeVsWCTI1qc6QdMx6IcfOhr9LmmmEw0/P0tuQH+gncqsijR3Z7VNCTE8kexPc/V+j7yfKbICgKujb0Kt+iIMrNxNv4jytAILqPpSh1gdltvO6NaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846715; c=relaxed/simple;
	bh=29NLNaMne9BcWDHneTr/0xDnhRky03+2o8nupwC8+Y4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3mJV43PDWWotVd3pAAhimmSMGlyagSRb2ZgOwHo0qW+KSBwL/egmzI47rhWYtiuc82AN3yPPTkhTseJQRufKGcKXHs9xhreMs/MhkY9JIBhs+NJt3OKURp0YPPcyXCvS1F2U4zi6Rt7cF7OGXprmo7njmzhVD6CnlLPdYOm32U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t32E9/pN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hn7sHm3H; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t32E9/pN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hn7sHm3H"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id E485A1380282
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:05:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 16 May 2024 04:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846712; x=1715933112; bh=sDqH7sm5Sj
	cT57mZOUx/cTEE6+xN/O1tS8WjKfpwrXc=; b=t32E9/pNzZC88OiDk5uCL8UK+R
	3zqAQIDuKMlsFzR/rb77KPyaXmvL+L6WelI9M96+f+T3FOq/zbl4PVbUWK8d5/F5
	b3OicyQRF3o3+UpHVwqy9UBQRx3lmEQqrKInaeVYbKAHdM/YPRlxj0H3sB9OtNXE
	lLjNGmoYriFcH7NR6SplWy8D74hlsFhVdGz8rORxKoHE/RwDt3thITLUGtjmyzVs
	lW2yb4Zbr3lFttLpaABULDDe+3zGddAxjQF0iqFIwMHf+EFs4iVTZF8eQVaAa+U3
	RmR1IyaTjgzsWn6znMe+RDpApWmf/Afv5ZQHsIpsiFomgvDgYXZJlZeJEmaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846712; x=1715933112; bh=sDqH7sm5SjcT57mZOUx/cTEE6+xN
	/O1tS8WjKfpwrXc=; b=Hn7sHm3HEtBMKvFF2uEXUKikYYepL5RxMh0CrmN0cstG
	4epVngWCm+Xyb4i/EPkN97UUsewDvnekZGc+ZS4+398arRBtzxS+wbZRTELrmBFL
	e2YqUyLQwiCQD1G6XVHcQ1rsXn305chB2m9+QPFu/6+GCmjIu8Dsfp+bDKyETqzw
	eev2Emw2Jd7MuQktcQe0lX53AUz+koq3GNpFk4/mqCUDjlfUDo0QA3whKb1n5pls
	VCTT0cZB4+YU7wr2xigEV4otud2nhgQQ2zszYmovqeZ0xVjYnqzOxa07gRGXEDWP
	4NGRaX+Bzrib4w3UTmcB54hLlpHi0kK0wPL/Ri1HrA==
X-ME-Sender: <xms:OL5FZvl8byO64UPHfQpJpY59fQedE31l5QIfen_Whoryq2zbrlovfA>
    <xme:OL5FZi0IQqzktTShkPS4Pz0bS5oi9bAh89NYnEg7mCjljeWkVyl0nfM3PV3e1uUmb
    MIWp6Jce7VcNIY3HQ>
X-ME-Received: <xmr:OL5FZlpBUjJgJr5tuZq3u-HpW1c0XEbT1XYeAHK3rxXlJhDk6XmZZWcZ_08mlciqZTV3en_VXoZYJaZ0z4X9akSV5dnLb65SDJKoaR_gIYPAcQc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:OL5FZnkbmOPTXm-mRYyGIaRMgxWha697KU0U9sl5CbYmLxrPkD1l0w>
    <xmx:OL5FZt0sQg7jFi7q8ZYKzsA--LzfLe6X0Wa2PjmCe4ryS0lXJlezNw>
    <xmx:OL5FZmtEHgkDhYD3x1yhwW36fafBMhIG9k_jdjsBvOuZfZvQH2NmPg>
    <xmx:OL5FZhXVnGLF2ZiIyXg1OLDJ8ONqOn8cbkzaLf11bNBLyAqNiel3aA>
    <xmx:OL5FZu-8fwpOECTXAEudbNrzw5p6_lSuqsm3xvSrJGPu80hXLgGVgwiS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:05:12 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f19032ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:04:47 +0000 (UTC)
Date: Thu, 16 May 2024 10:05:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 12/16] refs: drop `git_default_branch_name()`
Message-ID: <09ca848e7d8a9c4f4d8927d8f01a1c3cb5d34e8c.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MNgHOlTJXMy8HDbK"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--MNgHOlTJXMy8HDbK
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
index 7aecf11bf4..3618c8f7a4 100644
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
index 9769a25edd..95c3437443 100644
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
index 4a738f4c90..15ad84d3be 100644
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


--MNgHOlTJXMy8HDbK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvjUACgkQVbJhu7ck
PpSNRg//WM2F9OrWhznkBtz4S2HLAKmaA112UTxeE4nt6tQhz84qVJIyKqqnOFSv
TEhBKNlRXu7vONrACn6vtmGETAEYwmpeiFmpIDRwZtokbY9GF40EUFxn1E2NN/Bm
OTAW7L9IxUEEbdEI/XtdWPUTBysC8rECszxpmjq309HQBkMuUkZEb/A7OjCiVJkG
FgSnWspOhw1lis9qBDuWUoaxtHUjf1JgCeA5int1tUxHCSwgAb5hGaGA4mEZaeOd
5d3Oo+NqJWi84K4IO1q7Xxz6RatTTuRWyHkm27Aze8880kx4611e9yN0mNN442vr
irbZ5Ku5km9YKono6VI3KNZvg0DAaLFl+38Y8CzDL2uqfMXWselOtpOZyMWoy2Xz
UQzo+RGiQYoXI+p//s3lD6aG7TjMn9oSh5fdTdEl7G1FabCgyhEBd2QAD//GvPep
43jQjrtnkjh8sPxuoP7der3kvNGA+ppHRjYAmlXAMdiIL0QMwXxfS9LUeLJMjki4
8eaUUyhUv8dSVCE8z0aLxZPSqVyKFhhP0blQGlbqfgEq8ADZPcRtRtuPVmR8RzNU
sp0a6Jh3ZaDBsPwcDQ4p3xX1VSI2/8LAB8OpzPuliwYk5OlCs19NrlnKsMOSt0cp
ZIHyVmMNuClcXO8Z1ktSQdJiFRc14jgxVnqxlF+2dknMqaK3M5Y=
=Oy9E
-----END PGP SIGNATURE-----

--MNgHOlTJXMy8HDbK--
