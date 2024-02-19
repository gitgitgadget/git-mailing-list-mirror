Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69290381C4
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353341; cv=none; b=FeN/VWf2LpnKKLegib66Q7JeLCUdLk3n/UV6BehJELA6XzQpGDZ6KQoUHGdAjZxK8zL0s9+Bm1ybnSxwdtcyOfkV4oAOICEpV5zbSPmbIkttLzi2+r8FnfjDYBae8nc1c0p87r5liEspyRZyfwhsEhf6SYZJRDVgvFNMisxfcl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353341; c=relaxed/simple;
	bh=eXy+2bSZ7umEt5iD9+ghuADYQunMbWrfhgewcZywWW4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mm2s3ZGzsY5QodV+dOaRSoZrk6j5CHtyXHBoZL98sFP/wZ3+3E3zqm1spfwbcYq2yLRMUfspswZg34RZ1QoFFxGZ7rSXFI4vpaoUv51LiNSXYeP8CNNT+iKiiXhYiga1MLN4iiVWVQwjMHWZ+Zn6Ait3SZoCEDI22UoH+DxR9d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YnjoSNvt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oV+I1x/B; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YnjoSNvt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oV+I1x/B"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 51A00138010B
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 19 Feb 2024 09:35:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708353338; x=1708439738; bh=AWuO8oFE0F
	Qm4KfiBNjXHokUwQTV98xDeP+sN/RV8ag=; b=YnjoSNvtQydZNoczpXuLif1Ok7
	75eZxgrkzywBSJNOJ7tg6YsW0kWbPDeQhj+AVwykndPQiXq6G71//quaUqx3w1Dx
	qK5+KsfjjGKzPMbo7efbwsxBZ9xjkp5f9F4yn39WCCkH9gDsiV5w/AGDN1ZTn/Tr
	KHUb6W5Vilc0u1wHnknjWfqS1GHIG5MJzIjAx1aENeQCo8tQjVny1TzKR9ZvgDk5
	rhNRlUryOfvQca0/vA3ey2C4RARfjjAUsNahHiWrifYTeydChd/JImeIP0yPP0RL
	PtRh+km+/D6M+Qi75BytF9F6gzBzxYg+bd1IMjNUkUs5Hp4c5Zske6CERbOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708353338; x=1708439738; bh=AWuO8oFE0FQm4KfiBNjXHokUwQTV
	98xDeP+sN/RV8ag=; b=oV+I1x/BPwT+M382ghwPZNs3iBZrGb/AsZQ96BpHgGPs
	XBSXZ6aQF3D5JznADIPlxTL6Rj7M8yciQwFNQqyscaJ32oJ3mtLuyW8QQBeeDwsv
	s8ykLXtYohg/cOChdq0IjwqYyKKIoSkwv0ZxDzdwlQ+2XVaup9gIGCudkik0+ku4
	4BmhZ1R3KWwGGMa4E4r2S45Go3J2Cd2TrC6oqXy7IrKmU93ZrKrM5VRJHh/ah9ID
	TCIc6w/X7lR/ulPvOY2AkQfIlC4d4B0f6+qz6Fj6jbeCODX9lZqTAuMsb+86r4h9
	ySDolfEsjOuqOSFUnbIsUP/nuSA1giZRf/sBAzuwmg==
X-ME-Sender: <xms:OmfTZZLhcUGycHL_EhXq-N6BBdvxzXAJGMhFlXPD28xhCOskotjDGA>
    <xme:OmfTZVJTtATnBqDEQIMSdqD72GOsGQduS5Tx8hwNQUkHTWfBzqC0Ece0u1-a8iczK
    SKngwDB9Ft9XYRaYA>
X-ME-Received: <xmr:OmfTZRt-m-amfVdTgVtEzceYRtGhfTvqWVHfpmnulS1ENuaOSIk0iMzS1jIK1acQajaXfMn9ncYPaP0jjebZhzspk6hYF18URqUAyGaQ5W4d8PzS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:OmfTZaZfSNMZrOr2u8pDM0EShBkV0a9L_m6c1NnboPCmmvxML_B3mw>
    <xmx:OmfTZQaiC1luV3ILcyi9fKMRHDMeSfg1oL-ZG2AnDHKn-_63jvz2FQ>
    <xmx:OmfTZeD8828PaGkSe4TKP-6wmZO41SaphkuZa7akKAZsWGSBATrb4A>
    <xmx:OmfTZbx5EThNT3bTGIH3PQN0wVFEZEMNCLkSqON4Tv-cf_vnW1gYWw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 19 Feb 2024 09:35:37 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b9765d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 19 Feb 2024 14:31:37 +0000 (UTC)
Date: Mon, 19 Feb 2024 15:35:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/6] refs: stop resolving ref corresponding to reflogs
Message-ID: <a7459b9483660d1a44df500aaee85ad38146eb02.1708353264.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YmuXj31R0eaBRnmK"
Content-Disposition: inline
In-Reply-To: <cover.1708353264.git.ps@pks.im>


--YmuXj31R0eaBRnmK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reflog iterator tries to resolve the corresponding ref for every
reflog that it is about to yield. Historically, this was done due to
multiple reasons:

  - It ensures that the refname is safe because we end up calling
    `check_refname_format()`. Also, non-conformant refnames are skipped
    altogether.

  - The iterator used to yield the resolved object ID as well as its
    flags to the callback. This info was never used though, and the
    corresponding parameters were dropped in the preceding commit.

  - When a ref is corrupt then the reflog is not emitted at all.

We're about to introduce a new `git reflog list` subcommand that will
print all reflogs that the refdb knows about. Skipping over reflogs
whose refs are corrupted would be quite counterproductive in this case
as the user would have no way to learn about reflogs which may still
exist in their repository to help and rescue such a corrupted ref. Thus,
the only remaining reason for why we'd want to resolve the ref is to
verify its refname.

Refactor the code to call `check_refname_format()` directly instead of
trying to resolve the ref. This is significantly more efficient given
that we don't have to hit the object database anymore to list reflogs.
And second, it ensures that we end up showing reflogs of broken refs,
which will help to make the reflog more useful.

Note that this really only impacts the case where the corresponding ref
is corrupt. Reflogs for nonexistent refs would have been returned to the
caller beforehand already as we did not pass `RESOLVE_REF_READING` to
the function, and thus `refs_resolve_ref_unsafe()` would have returned
successfully in that case.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c    | 12 ++----------
 refs/reftable-backend.c |  6 ++----
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 2b3c99b00d..741148087d 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2130,17 +2130,9 @@ static int files_reflog_iterator_advance(struct ref_=
iterator *ref_iterator)
 	while ((ok =3D dir_iterator_advance(diter)) =3D=3D ITER_OK) {
 		if (!S_ISREG(diter->st.st_mode))
 			continue;
-		if (diter->basename[0] =3D=3D '.')
+		if (check_refname_format(diter->basename,
+					 REFNAME_ALLOW_ONELEVEL))
 			continue;
-		if (ends_with(diter->basename, ".lock"))
-			continue;
-
-		if (!refs_resolve_ref_unsafe(iter->ref_store,
-					     diter->relative_path, 0,
-					     NULL, NULL)) {
-			error("bad ref for %s", diter->path.buf);
-			continue;
-		}
=20
 		iter->base.refname =3D diter->relative_path;
 		return ITER_OK;
diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 889bb1f1ba..efbbf23c72 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1659,11 +1659,9 @@ static int reftable_reflog_iterator_advance(struct r=
ef_iterator *ref_iterator)
 		if (iter->last_name && !strcmp(iter->log.refname, iter->last_name))
 			continue;
=20
-		if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->log.refname,
-					     0, NULL, NULL)) {
-			error(_("bad ref for %s"), iter->log.refname);
+		if (check_refname_format(iter->log.refname,
+					 REFNAME_ALLOW_ONELEVEL))
 			continue;
-		}
=20
 		free(iter->last_name);
 		iter->last_name =3D xstrdup(iter->log.refname);
--=20
2.44.0-rc1


--YmuXj31R0eaBRnmK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXTZzYACgkQVbJhu7ck
PpTjeBAApz/zGE+cTstVKZ0spSZoEwCsxqo42MMn2PFN/oHU3/Da3fsKIG1MTAJ6
EwnAbgdGMGmRfhwFCFiXU++bY+j7Ea3lIFDAL4s8+j/oRE6TIfwXanV8oA7Aw9Tu
Mvn0EIbF/q86SH3vDClJM+jvqIt39vfKI3MaRwPdklkDq/AHRYjd2G2tolUYJEzr
D0+TuUWBM5iQMb6Tj+mE+Pz8keONvtETHpgB8p7ioYCLFZCXDmkMb6JhLMcdNtq7
uEpH4CI3+aCUDud5uOI9/h/egrPywdzrf2wKzzP0KBt0rsq8uSEzVEIx0MSzwRPG
ypmQsO4J/CMIVQMV5njdBGdKoowbAnGy1LCJMX/EU/cobyt7wPN2IIefZJGmShSS
S2K0VtdKqZ3+YTotb4XgXD7nlRceFwBua8ee4LBKS+xG68X5oSfpemmC180baYhx
ke6o5P8P0ejVRA/1fSHdZ1DvVQzmPp8r7z2N6RtaJKKPGC1bX4ZQIGXcm6aHH5Bn
wpuTQX2htCQKdqFZMQRuCobdqlZctdEjh9K6YHZ3RSysJj1BEISl9JcGhYen/C7Z
7hzDTEqpYTMf0Y8Wr7BPspCKlXt8SGBrzzhQXuz2YpD6DBynKz1ivkTVthyeUQj+
/N/gFq4Y/CJKOMx88m7PSoikQIDnQNzFyoBTEd4unEHZbNhfVSY=
=LYRN
-----END PGP SIGNATURE-----

--YmuXj31R0eaBRnmK--
