Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B580F6EB7A
	for <git@vger.kernel.org>; Thu, 16 May 2024 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715846720; cv=none; b=oRRs32ga3GwDZ4tlAvx9spdcxAYMLSDCg0kjDuZqBdcM78JufsV6X7B+lmaYtKXNRSs2bgF2z+fqrM9SuXDb1CtSGp0DKrLyDD4ufw4tvH3yIfF8UF2SF8mtoSIQHfvYyNxJxYHZk/l3y5pjduVUzwSggZOseIRiI2iiVOu29Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715846720; c=relaxed/simple;
	bh=UkcZLLGo6apXJ+9UVKOEn/mYkigcX9mekUsCpbGztDE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFGKveJme0OWMK70dbCV8tDBjjyL+SREe1eQeeFSCffJqb7Mt1rLZQIa9/DllAsE2bGE6QOdNK6P7h53B0eocf62Ht7R9zVtmOtlAc6nftkE8/grDQIUBEBy+858OleYm6X3bmIrha6YNIttVlxhPiJG7tXRN987zk74rqfp4Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kXdYXAWy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hOUo75Wj; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kXdYXAWy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hOUo75Wj"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DE1F3114006F
	for <git@vger.kernel.org>; Thu, 16 May 2024 04:05:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 May 2024 04:05:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715846717; x=1715933117; bh=wp53xAXT2z
	7YH2gofho6DPDe69XaV3HuEPogUPr4QAo=; b=kXdYXAWyQ0FUAZaHgAiNRPllHE
	Eo0xn5k70n9s7f2jSkNqtTum9EXLCdBZHNBV0vqgrWDKxXUwj5ZUaR3hAb5GgMmx
	7HLKK0tOikOYIs2g/9KlmFW3JUcyRv0ZI5cLMh2+CYcd59F/ncgvTshEK/g73tPx
	4vnVLqQv9Fl9Fmv12GEuVuxIFYZIBoZhg1znA8gzbxx/fbUfOa3MyilYnxNB07TS
	PS5RSE8dvvsh+AD5L8mPPQBnlHWdys8a6S+g2BCueQ9j3A7rCxPpY6jY0plb8wE5
	4Vx9F2+4KQlH/Ukg64/xCmY+/HZeoEXKvQIjPlI7clhlRY2m1SB/n4WMVpNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715846717; x=1715933117; bh=wp53xAXT2z7YH2gofho6DPDe69Xa
	V3HuEPogUPr4QAo=; b=hOUo75WjDJ5f/iHl2kY6r+NpyPd2a5jOIfunjDfIK0BA
	57HLyykMFWuoLPRNUAhAR3w3zE2bmWDSnKx5AbN73EcOP6MKieuBwEhcL1SIge9I
	eJxPT8QMGR4YqHvrXdOSKrZTOKqh1rhudBI08WkbrMUUV/LnB6HZ8yeA/T02jXy2
	0UR0TggalJOSfa5obufH2T5JVHu4OV4rzNVkBXkD1pxMnmF+BZeWre/KuUE1MBww
	FVgmHRd1fQgvybQAkTOBUbzlI82vhKut1I4OWujNcHKOdJ/FZViG7EqcqJFyMz+D
	W+/aGYjT+eUXIJPsBBPHvivKqQSfgDZ3aLrDhTmV+A==
X-ME-Sender: <xms:Pb5FZgZJP5DpVDuHdsC9vGJu75OnTZPK1YgZkcOYvwi82QW9Xvo76A>
    <xme:Pb5FZraXCxSOWWlIMyhphNDW27j3i2NhixwikuFePctLvHZkoVooyPFtbJ-j0tk6y
    bmQGsLrlQ2p0azMPQ>
X-ME-Received: <xmr:Pb5FZq90ZZrTNGfptKA2lSh7BxneEhrhi2BxQ9S_UPvKxLp1ytFb1vKohExJ38OY8ljfQdIfRy-OoJeutuCZSvA78Uc6ymjjvIJcYO0Nn_Di9LU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehtddgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepgeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Pb5FZqpUP3xdIzk7NVj4KJVPN8jptsrF3cxkaqwM0Qfar_3N0y1hKw>
    <xmx:Pb5FZrqMA4J7WqTv99zJsWewGdByqiuCfNy33mEHiL2nWEZF-LfP_Q>
    <xmx:Pb5FZoSjUBR4r0ZhCoo32_svHBEUK3znZDMrA3wEO8LIfPa1oLSt4A>
    <xmx:Pb5FZrrIi8GkEASLvEDJhoxLigHooq_22nrTcL0OfQ6XRiS6WnpBsg>
    <xmx:Pb5FZkCLqEeAGs6KVX25oqgEnHp9YHycUOQgYTgrqbS_4EgcMfme-U9M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 16 May 2024 04:05:17 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7129f1b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 16 May 2024 08:04:52 +0000 (UTC)
Date: Thu, 16 May 2024 10:05:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 13/16] refs: remove `dwim_log()`
Message-ID: <da10714a45b933ea6306892343e2bb37a2abaa1e.1715836916.git.ps@pks.im>
References: <cover.1715836916.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oZf5Y8OJGnucpjw/"
Content-Disposition: inline
In-Reply-To: <cover.1715836916.git.ps@pks.im>


--oZf5Y8OJGnucpjw/
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
index 3618c8f7a4..723bf7af20 100644
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
index 95c3437443..fe0b6b44c5 100644
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


--oZf5Y8OJGnucpjw/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZFvjkACgkQVbJhu7ck
PpT1hQ/9HHbiWv2KyaNiTXW255gfVzX4EDJbVY6GzrOZwYQhbYJz4l4I4Lo66SoM
hm0JvgJw6HQqUOQlhB1vWysDh/y+SUElVhURjpnDgzXM2Qr3r+qnYQk5rD/HzOrO
nrITIeLWX+FGpnBRU4g6EJ66jnrNQS5YPi4fJ88jKGpLOjhMkJS8Lg0kWL3bSlcl
vAZyo08iThyOYLKfi8yVwRtk0uMPkWM3FEyZ/DLyyFVbpuZLkMaj2iOMeXSRZCxt
GuhOhEZmrMezxyI12Y6Fx6MqNqEiygJJ3PKMVjDW5mZrCiR+zDD2T3+swCrDbQL6
Ebloi+JVr+Nbi4tOpwODB1xdV/sqQgSemIWlAxERQmaOSaPCSiF29i5an0u2WCDF
X+AGet9shPeQmhVhoJFuhn/TgDZU+P2I7gx7exvFHUAnjo9SyRrrFIXMp8Wa3+a2
EszpR85E95fw0xGUyLKJwLDM4h431X6t4B/EDCBtvta1kTC/D801JQMXI1mebVoo
WgOghc1wazGPQhuwRLAXRIAX8povAMb1HeOaVh07TdBwZBeCZifYPcO7kDlKbrgu
c8fUW9FOnDncc0cFuN+l6FT3eC28cC6OijzN+t/+a3P11zGoa7bmo0RxNKuNCOzY
VjObSHZnUvt/LPFtmvq8JPZk/6zV8o8kqSS07Msu87N0m/BdRn8=
=qRLZ
-----END PGP SIGNATURE-----

--oZf5Y8OJGnucpjw/--
