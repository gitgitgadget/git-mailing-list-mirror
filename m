Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90461B86DE
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013887; cv=none; b=c5U5WhuWuuzei04YIVaYMPDxsqwUJnlSRTs/NxVqq+oMmeArTs0vMBq2uQ9voo9zVrcR/iQ8E/JDjAdsJbIVIgtMtvze3atqEgeoOpBNxWwqyAF1FXPFxNFFtCblHWFoMEkw+LmjNYsyxVyEcHWUweCyXD7OrroKCXPQEALd390=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013887; c=relaxed/simple;
	bh=9IznPviJDDuH7eVFm4FqpYsGiIigLWu2RVpGvTgioEc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VVnxSS4iddop4iOn5Ns5o+hbpwTmbQMEhIFx+6QLMi+wBNODHp0Tw9rgHXPPpW+t4kE1tido57kIADEdQkfrqnr0fp1TDr9J7duo0lZqWREOMRipi2nq1n9n0JBLrzQtNaiNvV0hB1Zs3M/QDXvXOFp7tGaPi+cHrQtYxyneHNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f5JC9rnk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m1420FfF; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f5JC9rnk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m1420FfF"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7997C138FCC4
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 02:58:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 07 Aug 2024 02:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723013884; x=1723100284; bh=47eKXzqJmO
	hq7Ow0NwHHIvo6DkNc46yaNGuW3ycZgJE=; b=f5JC9rnk+eeN/wtSwsXVKsU+uQ
	fdZ8vi3MizJsb7dktyVw+ORFjcTpSHCCZLsPjey7KTBSOyITRtb9F9VkDwifD7Qg
	tPYrHBmH6rkcOHx1Q01AH8dddgp8xRWhO1rLVCCUATXdJ2OSt+LXB2OBNMmcdXvP
	DPZ8EsjzT2bJuqgXNuD3XjY8m5HdbkZSMKk1jc9PJJiVjkNCBW82xFyDciUGQ8sQ
	XjuQak5zP72fnLqxojtKYjJ4jPUAs3uLfjKzhaRmOMLGWOZ1MImSOi1Pwmphtkqe
	P+Tz2d9flHRPIK0okIyBXgtN2G7/ZnNwZXjfb5AKkCkJjj/yAcZ36NUinntg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723013884; x=1723100284; bh=47eKXzqJmOhq7Ow0NwHHIvo6DkNc
	46yaNGuW3ycZgJE=; b=m1420FfFOU18ZtfTJv6Y844+6gmosEksgxVBIDYbGAJI
	LCS47DARjj961mhDnfZFHGJqUg0kGyfI3kqfa9/nMmea1c+2hRMibtLT57silsf7
	OuBS0zwvS4QzCeHp+6Bi5cYtVfECANG4mPrftXNdEabGmRgfMXixUCBrcdJBm4tS
	K6X0dN09Fc4K5hQ96gwQld4SZUheSFj4rNm2xfBqRANHZ3urXyl6CTaOsQH02h9Y
	joqnOvsRCqXappXSo1Q83YQ5VI4d8o9YL4PCo7MqSTT+75ATJZWRQRn2jZOsBjfY
	B1ooqPdSRQva6/xDqU0Xe2XaMDMIdQhXrekcas56sQ==
X-ME-Sender: <xms:_BqzZjn7flazmkb50EF_c_UdDzaN-vCMT13HVsspVn0ybdlqZi_3OA>
    <xme:_BqzZm1JSDgcVdoK3rI-wrztrAxuJ7QQ5onVZka-s7Df6L9X9Dx8Nsxqv04M9HdJq
    ibSc5wRjVX3QeoqNw>
X-ME-Received: <xmr:_BqzZpqJmxZcMCJZgkgxBUhGYMjG0R6x-dRBuHW_UMjV_F4jOU04a-PqIHJJa1lj48pb7J8yvqs6lNUpiu4l0zOV23Ss-d4x7V57EE4JkCAQzdDS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeelgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:_BqzZrletQgi-fbS6V9hS8ZPKI2paCHmBKkB5CwtD9arGyo0f3PH1Q>
    <xmx:_BqzZh1PI6VxrrygrCf5NwuSKtzAcJaYerua-7PVv9mgeT7AL2SlBA>
    <xmx:_BqzZqtZv55dAhc8Uf3LcMyj5NlObXl0W_e_cP8KhP7P4GHsKvPX7g>
    <xmx:_BqzZlVhSuhIB4_GJyjDCf9qRRBlTkCA6aDwxAPiXF4wEt3B4q3bMg>
    <xmx:_BqzZi8oSngdTDB2w4Cloi2ZFzWF-Dsg4x01uU2xN904axXeNSUF-7Jl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 7 Aug 2024 02:58:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a70621f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 7 Aug 2024 06:57:59 +0000 (UTC)
Date: Wed, 7 Aug 2024 08:58:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 17/20] config: don't have setters depend on `the_repository`
Message-ID: <1c1b27cbacc5c5d858363b8ed6ad8fe27f863574.1723013714.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5hCqF7yAF+mMd9S7"
Content-Disposition: inline
In-Reply-To: <cover.1723013714.git.ps@pks.im>


--5hCqF7yAF+mMd9S7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the setters that accept a `struct repository` still implicitly
rely on `the_repository` via `git_config_set_multivar_in_file()`. While
this function would typically use the caller-provided path, it knows to
fall back to using the configuration path indicated by `the_repository`.

Adapt those functions to instead use the caller-provided repository.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/config.c b/config.c
index ed39922dbb..831c9eacb0 100644
--- a/config.c
+++ b/config.c
@@ -3220,8 +3220,8 @@ int repo_config_set_worktree_gently(struct repository=
 *r,
 	/* Only use worktree-specific config if it is already enabled. */
 	if (r->repository_format_worktree_config) {
 		char *file =3D repo_git_path(r, "config.worktree");
-		int ret =3D git_config_set_multivar_in_file_gently(
-					file, key, value, NULL, NULL, 0);
+		int ret =3D repo_config_set_multivar_in_file_gently(
+					r, file, key, value, NULL, NULL, 0);
 		free(file);
 		return ret;
 	}
@@ -3613,10 +3613,10 @@ int repo_config_set_multivar_gently(struct reposito=
ry *r, const char *key,
 				    const char *value_pattern, unsigned flags)
 {
 	char *file =3D repo_git_path(r, "config");
-	int res =3D git_config_set_multivar_in_file_gently(file,
-							 key, value,
-							 value_pattern,
-							 NULL, flags);
+	int res =3D repo_config_set_multivar_in_file_gently(r, file,
+							  key, value,
+							  value_pattern,
+							  NULL, flags);
 	free(file);
 	return res;
 }
@@ -3626,8 +3626,8 @@ void repo_config_set_multivar(struct repository *r,
 			      const char *value_pattern, unsigned flags)
 {
 	char *file =3D repo_git_path(r, "config");
-	git_config_set_multivar_in_file(file, key, value,
-					value_pattern, flags);
+	repo_config_set_multivar_in_file(r, file, key, value,
+					 value_pattern, flags);
 	free(file);
 }
=20
--=20
2.46.0.dirty


--5hCqF7yAF+mMd9S7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazGvgACgkQVbJhu7ck
PpQstA/8CHRDZpKKIq6mIGj0/vhbeDfTWd3FeH3QvOuF6CQbZKMk65Tabp6VhIqT
pPozroqnJQkIrleMy3+Q/lEdBSq75GauLeUQgsrMiNTgO7shx2OI6xSDyx1FxHnE
jj4mZUVFPXEKygIFAsN7IsZ531zZIg6kCIYmb6BuSW3kYbABFlpTWcUiZagr4Z9t
6mN3BRP3lDgSf5bGCspFoKNc6ctC9nPgwHUQaTOKplA7bCtDNWCb8JRNZgjHZEW3
CdTcOJpitj3aL5LmH5O4oVVkz546BZK0LQ0yHYrJXX468+zhCzK9xKLJKxpX6HUW
gk82lIeP4snyRD9D8jnA/fMpPnsWR0NJZWlYt20XglGjCkggKyq0RG/LaZVFXtR5
/P9LwNjDKBt/VsjukEc5Q+Ivdn3PypFEiyo2BhVOkdgqw+dNZEhLyh67QPF0zKdH
2kufQSDFQB+/qUWcYaa2upXGqH0fk6S94blcoSxAg7HhopBH+l9sYDiC/B2ZEm4N
ouAsS8ESZ+K25Gd3MaLNyv2RWz48tK8CVQA+Elauw8yLNTfl8SWT1CBhef0JBZX0
dfEt162SxoayXZCG9Xwp0UfXyrArLq/rnfJur2ejHYRigGAdZjrscZeH6W1crftB
11BUwAGALrFolhG1pF3sU5lqGsWTRFNzUWzW0/AEPY5jYxQ0qcY=
=cE3m
-----END PGP SIGNATURE-----

--5hCqF7yAF+mMd9S7--
