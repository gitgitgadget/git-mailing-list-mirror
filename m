Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25442CCD0
	for <git@vger.kernel.org>; Fri, 17 May 2024 08:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715933960; cv=none; b=GHDSXKh43HlA7NA4Expv6pNQA0492Qhx2N9w2c+ea0jx/0En8RBFYOmWW8wRbCuRraYnQT9CQoDL6YCe+kfyPG61JK8oHW4XIFXx7274stairHCtb1imu64i5oJyTuG0XHu6SrruscHHgC5B4GmT2yRoNx9cb8NuEQNFMiqMFfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715933960; c=relaxed/simple;
	bh=QW+MN7/lI/Qz9BnK3HFMp8mH7MtrgiPNjvjqkK4wASE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY7LbpOH6aes9MngOjyGZtZZyzNeUl9n+1GJ1pdwnnzBoiyOux/3jNym6uiFfXpkUtwct/1k8midZFpr6HuWeROuRPwokvVOxDtUY/E4ZnfaBXf7SXswkJwwwEjMHpvg1ITb0E2Sw4RewH4Rmlvb2FMya2yTHHrJwxj8EdSTxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hq0WsgSB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZyO45hvR; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hq0WsgSB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZyO45hvR"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id EE87B1800179;
	Fri, 17 May 2024 04:19:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Fri, 17 May 2024 04:19:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715933957; x=1716020357; bh=0g/qpNRPOV
	0A2HwwYHRA4haGO8oOblx0WRcfXjN1s50=; b=hq0WsgSBRELO7V3HvN8WiIl60o
	ILMLv5YiiQ9+oApCsA8h/Oj46R0PhVm/hhPDjDYTF8kd1zasdX8COvzLjRnqtBb1
	MnCfcTfvogiw93ylimh1AuCS/J0DaBhuF9AMiBoLNBpmDIm2+OpELBkcI9p38tJw
	kDEw6k/KWcfMqVn/PqHNiMsLE/+8DACdvwHzcxkpBzTJ3OD/Sr+YhQnfw5vFs4bH
	zRDsoXkTGsSx6SL5Xyg8DSPJSoWeCO0z6HGaCoeKcEzV/fswgzWOnwOOPzmvZUD7
	2JitK7UXMGQrETsBBADBtxwSFKYyivDosx+PVnyW9JWuxhbtzyaRiaG8oJMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715933957; x=1716020357; bh=0g/qpNRPOV0A2HwwYHRA4haGO8oO
	blx0WRcfXjN1s50=; b=ZyO45hvRaz8sUFKJxDCUl1zd2jfkjpA5CmV8lMQ/i9tm
	zRP1xuJsDUhI/IvMH4JkZR6Dr/IX4NHLm5IQEYo6NISfm8XJKwJgKB0k6gEO7xst
	DRB9E2f1AkOHjsbZekE/kP/b1idYZDYEfcSQjM0upCbcukyUlN9BnU3Hr3au0wIh
	8xHV9Cxw2hyoaCa+w1Uh6prllNURRRrDZ4D8LO9X0nXwAOw2dH8hpghd2StngX+D
	c6RwJLhNjaHEoVvwHw7ocW32K52z4PlfxZ5RcDcFJ/407js03RBlxDfK5nJ1EE57
	WjxPIolE+/FG3q8FrMW8FW2XBp0G55Yr33OGvGf6oQ==
X-ME-Sender: <xms:BRNHZoutuJ1IMkolwSvPJDZ9efAH115u5Pu6R0eMrttjRvKl42DDLA>
    <xme:BRNHZlfipuE40ksZcQemm28Su4OiZoGBf1QJinWdlBWiJMFEosXc6d3lSXw4wdvb2
    QZbbtWRio1EWxLTCw>
X-ME-Received: <xmr:BRNHZjzh_BQOtezCCXvs8hYG98y8UDWsnUVMcYip6y6bRVqrsaVmtjIYxUm5wEF1uIAv70Ln05cjKZPumDQ5RqscQDzi-40LH4yAlH9JxYIgXJNwhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehfedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:BRNHZrM6OxLlXwpxxgyeRpga-8Kc1qBEgkKBTHNfPvsTWYICsml_mA>
    <xmx:BRNHZo-UPI32J0r1NrOAwB03-xTuA0qQwyDLJUVPqA0KHVwEbtb9TA>
    <xmx:BRNHZjVX_ga_kuFhB8WPd3jek61k8py0FNMnBvha8mDYRPsmOLqMXg>
    <xmx:BRNHZhdRHkrYyKmYpI1yHgY9wMZUrWv8gspcDA9T8l1MnJg45T1BCg>
    <xmx:BRNHZnaOREo_VtbJ4Z1wS01TJPBdF9OcqhqcdCLfKYoGF0h8sOOX78uW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 May 2024 04:19:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 06c21804 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 May 2024 08:18:49 +0000 (UTC)
Date: Fri, 17 May 2024 10:19:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 13/16] refs: remove `dwim_log()`
Message-ID: <afa918488473acf1b8931d7c3565f3cffafb8740.1715929858.git.ps@pks.im>
References: <cover.1715929858.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X3Xs3TjY3WtItTop"
Content-Disposition: inline
In-Reply-To: <cover.1715929858.git.ps@pks.im>


--X3Xs3TjY3WtItTop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Remove `dwim_log()` in favor of `repo_dwim_log()` so that we can get rid
of one more dependency on `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/reflog.c | 2 +-
 reflog-walk.c    | 4 ++--
 reflog.c         | 2 +-
 refs.c           | 5 -----
 refs.h           | 1 -
 5 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index b4650cea16..0d2ff95c6e 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -378,7 +378,7 @@ static int cmd_reflog_expire(int argc, const char **arg=
v, const char *prefix)
 		char *ref;
 		struct expire_reflog_policy_cb cb =3D { .cmd =3D cmd };
=20
-		if (!dwim_log(argv[i], strlen(argv[i]), NULL, &ref)) {
+		if (!repo_dwim_log(the_repository, argv[i], strlen(argv[i]), NULL, &ref)=
) {
 			status |=3D error(_("%s points nowhere!"), argv[i]);
 			continue;
 		}
diff --git a/reflog-walk.c b/reflog-walk.c
index f11b97e889..5f09552c5c 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -191,8 +191,8 @@ int add_reflog_for_walk(struct reflog_walk_info *info,
 		reflogs =3D read_complete_reflog(branch);
 		if (!reflogs || reflogs->nr =3D=3D 0) {
 			char *b;
-			int ret =3D dwim_log(branch, strlen(branch),
-					   NULL, &b);
+			int ret =3D repo_dwim_log(the_repository, branch, strlen(branch),
+						NULL, &b);
 			if (ret > 1)
 				free(b);
 			else if (ret =3D=3D 1) {
diff --git a/reflog.c b/reflog.c
index 8861c2d606..3c80950186 100644
--- a/reflog.c
+++ b/reflog.c
@@ -409,7 +409,7 @@ int reflog_delete(const char *rev, enum expire_reflog_f=
lags flags, int verbose)
 	if (!spec)
 		return error(_("not a reflog: %s"), rev);
=20
-	if (!dwim_log(rev, spec - rev, NULL, &ref)) {
+	if (!repo_dwim_log(the_repository, rev, spec - rev, NULL, &ref)) {
 		status |=3D error(_("no reflog for '%s'"), rev);
 		goto cleanup;
 	}
diff --git a/refs.c b/refs.c
index 83cd965a26..43c5fef734 100644
--- a/refs.c
+++ b/refs.c
@@ -775,11 +775,6 @@ int repo_dwim_log(struct repository *r, const char *st=
r, int len,
 	return logs_found;
 }
=20
-int dwim_log(const char *str, int len, struct object_id *oid, char **log)
-{
-	return repo_dwim_log(the_repository, str, len, oid, log);
-}
-
 int is_per_worktree_ref(const char *refname)
 {
 	return starts_with(refname, "refs/worktree/") ||
diff --git a/refs.h b/refs.h
index e906dbb44a..82022d300c 100644
--- a/refs.h
+++ b/refs.h
@@ -164,7 +164,6 @@ int expand_ref(struct repository *r, const char *str, i=
nt len, struct object_id
 int repo_dwim_ref(struct repository *r, const char *str, int len,
 		  struct object_id *oid, char **ref, int nonfatal_dangling_mark);
 int repo_dwim_log(struct repository *r, const char *str, int len, struct o=
bject_id *oid, char **ref);
-int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
=20
 /*
  * Retrieves the default branch name for newly-initialized repositories.
--=20
2.45.1.190.g19fe900cfc.dirty


--X3Xs3TjY3WtItTop
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZHEwEACgkQVbJhu7ck
PpQllRAAh2NyM800OL25c5LlzvdKshMm3TlMTFoUlMyz2eyeTyUY6/ppIdrNFEmc
vRHp52U4xJA5zgv84fSjHeLYgOT2qZeYyJNoQKIX5C50IK3ETrf0FrR/TnUFegWx
UCgHwVYN2BJBDEpmBposyxbZTsbUbMUv5apJITIyERKsO69GrjEOfsZ+AuwwYRYB
FmNDuQhEbkLWvDZy5xh5Y2RUlnayow/cGVueBWWb2Pu6NimiG/dtAi/gwZLeCNPh
YG602fKLHgG3wDL0cnVc5lsd/BoRdv6eenm9hkiq9Za2cOa37G6G32twq3OS0Wgp
D+AAEImyPxEsaYW10qNI0UI7lIglTOTvwLrjjEO7+gbgyZSak28il9gYfaLpl1Ha
R1anJQpYr+QBRKw0TcF8KWALiC9cPdHUWIns/747SGTEqY2pup2d43hsL4nwejar
g79iqKdIWXsVk4f7WE/Xk9d2cEHQxkG3pabs0Sm364qLt7TkfGtk3/qRpxvByguB
ySIdkS5ZCa+n0GAPX58UKfkS4R+/djZjWunU/fELOxlQQcVn2GjZa9QbxDrvNBsp
vRKKhXmoRU4qHYZF8wdS6LWR6eP5nnLZu4b/1BwgbzkxKShhO5QpFUfO9kOQRKfl
i1FIcuPxn0Jwcj0+UNjgydMBC33i2xQNb3G97Au0MC+XytXbIeY=
=7iqO
-----END PGP SIGNATURE-----

--X3Xs3TjY3WtItTop--
