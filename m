Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64395F554
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708420009; cv=none; b=nz2b6Lslv2MeWm/fG3DOZ0NtGLIRMCRPJ7oF514cRGmKeB/FFHm7Ckj1XOozLH8hu8A/jyvbEO7x3M0SygYmClHOsCL7FxoGKkiSSyBtERmHpVR2hKWTlLwkZZah8YIgssxeOISh4+1d2xmn4l04HHJvjrWfLp+KkZ8Egj7xIWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708420009; c=relaxed/simple;
	bh=4U0Du7RuKPhNCkZfjheXWtJB/Dhxm+ijOZvL+g7/MPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs8+LhMHDpApUwD/AG7ySuPTbxpllwGV0+1lU5pb2XQymUPV8/0cZkSZyKAmuuGvsrvHG+4b/ECFU4uiP2yJI9EOf9303B6qTgt4wtvbSoKMmRjQhwfUS11VvYdSHimrWu0W0V45NYT0Kg6eS/2YMp5NLWXGYzJ4pEtGtG0VZgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ntB7cFk7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VCI7sn7M; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ntB7cFk7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VCI7sn7M"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id BFE281C00096;
	Tue, 20 Feb 2024 04:06:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 20 Feb 2024 04:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708420006; x=1708506406; bh=1P2fekKHlu
	WRGEtM4D5bbxqudF6kwIO9Eb7+LxzUMcE=; b=ntB7cFk7c5Ep9HQj44T2dgESwD
	taaYZ+OR+bv1FvyV43PtAGeuG0bJwD/WfnBzyyEXzwf0NDGq99FEPNzcBom1dY7B
	bQcKyrdtzdAHuXEjXt3+Ao8R6ceK3JlRmIkmUXdQdKyjxkOsfW/WpELUV5S9WLaV
	mZKDp+TfInLcBOPUh4d1CNJWJUK0u1SXOyKSspEaA21M/5MqSgOrYf/ZmuM36pk5
	eDIk8lYcsReRLhVOY0VJKwkWsh90ZKoyThiSrVU1lNUIKHy+cX7taCTkjA00RPri
	jY4vxBKqLc9t/YGT3QGanYmT0K19krbLa+7RcKEdKD4Zx00wi7FMQHoYHHCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708420006; x=1708506406; bh=1P2fekKHluWRGEtM4D5bbxqudF6k
	wIO9Eb7+LxzUMcE=; b=VCI7sn7M+m1wxTD/m5QPAeipbptlNkwyNc1oeAtIhU7+
	xXvuMt/5DaQxi7RRsmDxnOox9XDP4MXMZDfjWfBhGif8itx9seqG+dBigBoLdGhn
	YGsucpntiJHXANp4Co8Kj8DPRIj+iG3lUAQIQ4l39z56ltJRxyNKZGbae7KbdPv7
	n8D3uuMhAIr0gg8KD4nroKSfdPtm/xEjIifNzT3wvoMKdMLduOylSoX6XmEqgTR5
	itdONR8kAN1cemUQ0tzfn8amo1XPs6b3KYGKMhJhoJgwSfz5Sx2KwuxscbBD+4CC
	lL3hdFD+NgtrMsg67D3/0RBFjlD8o1o423mIvYdOuw==
X-ME-Sender: <xms:pmvUZfVRhKAtsbwjRGEBNfqIq2p4cB6oZpmul3AbLTTcCq7944Pocg>
    <xme:pmvUZXkfy4VlkiJL_mCN8kxLcH-ky813cgDQza2SV3XO4q3RYr0BnPkiY0fgStTNc
    hxDaiWioJq_EVvcYQ>
X-ME-Received: <xmr:pmvUZbZ0r17J1MrH8mt0RS4QDRHNiElLJqBBpZchAZkvFNIIkBxxZtQi360kCNKfLVs5fbuJrWKOci303XxMupQIhkku4uDnF_1ZQvOZAlGgHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfe
    efgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:pmvUZaWhO6TwUk0ATZbfhn-YevhP8u2ow_JdLaKtoXApoLY3UmRJgg>
    <xmx:pmvUZZnV_dZMKl9Q_qDTcg7X3GD-nQ-OoHI5xNW2X7he67EbUp3afg>
    <xmx:pmvUZXcE7q848GzyqyfmyP1B_bFeFwvz6ijq-N48-xGLBEj6Vlm3yw>
    <xmx:pmvUZeycSgE5_rWQrju7KBIRUwkABNNPu_r_5Q_FqvGQGG9riv4D-lEiyw8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 04:06:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2386328e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 09:02:42 +0000 (UTC)
Date: Tue, 20 Feb 2024 10:06:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/7] refs: stop resolving ref corresponding to reflogs
Message-ID: <7928661318a635022b65db543bd551018057c11f.1708418805.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708418805.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zTJIlHoHnESGHB+L"
Content-Disposition: inline
In-Reply-To: <cover.1708418805.git.ps@pks.im>


--zTJIlHoHnESGHB+L
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
index 48cc60d71b..4726b04baa 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2129,17 +2129,9 @@ static int files_reflog_iterator_advance(struct ref_=
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
index 5247e09d58..f3200a1886 100644
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


--zTJIlHoHnESGHB+L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUa6IACgkQVbJhu7ck
PpTS0g/9EHiUtEX0mzh3fQmzEhQsXRwWtYPHuw8KAwIZudsVmYJ5M4mEhff3BFgl
CAcEN0sfOfUTzIXttRpw8JZpcMTg6wvqEUTtLv6efrTiN4wMIp1/6KVp3e4vpW/k
YHeXw5FrFaSTOfYwVysn/2RdX2/6yO3Vbct6kT+7ZyVmkN9NN1t/qx1Imo3aebQf
QzkzWsiSXmobFxY313B9FbmsWJKIRphw5JQphtBEaLttOnr6IE4Rq+9TXXs8WIlg
A1W5TYjpG+bkgipaFtaO13QFOrCe4sGFIf0tBfMi3Fdbcol/JHZ6cbLk+OJezG1C
W4INBN0RCgI2HOm2liVZ9DYHfuDVuDGQlFE52phdgUCqLZVoIjOjGHd0UGtxJ1dm
+bi+8J8kD0EnsR5F2BlZ1JfXbscDaGx/CsivZd5Cl/rInwQBtVtcI9g9vGhddgO9
5yT1KyH/1KcBHoJoxRy9/AQt9kNpIVcL+hrk7OJraFWLIvuTFFTmdlfrn9LWP2MY
Zfd7wYiAgiMTyuJnpqE6aAo3TLSNMFKDxKA/F5vkmh/SFjQqImH1yoJPILRXyVBL
8CoiP6i/mKen/WAoGsVoIc1FlmJ7X8Yx18BFly1z630EfQmiutuCPwtW0bPzZmB3
Oii2ZPmujsjb0KNAGbhxffPD4fevWdn4hnuUrXtUX23S1fTatQ4=
=I9GH
-----END PGP SIGNATURE-----

--zTJIlHoHnESGHB+L--
