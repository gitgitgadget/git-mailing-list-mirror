Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32DC6994B
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519069; cv=none; b=laU2gApX+qSm3EseTHHzc+pzlR8jPc4HoVVDdgGlllrSy5RrtP/z7cTHyO+13OFlHbL65/r71XfheQYKWLaJWQQ9zoc5h+tue9YrMj/GCvv+8oTZGDbJhbfHROJpFc6NLJNWa3FyPZUGzWYHmYa5FhF0QcjdrgmXv5qLtyNwLSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519069; c=relaxed/simple;
	bh=Dkrq62JYt8Ag53T+dj2kWEFjherTlqsrpewL9kBOEBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VC96j6MGauDXiYybmjBOobhw4BdVhV0/Zu4yoiiigkgImd+s520L2GSclajb7c9W1H8Oey8JjA5599h3ltuq3gU8q39aOHNsPlSQrEkMfMjKLoC47MWAMwbhUxqJQ/tIAZzysRciOGzHVGnHkmSltPodxXfZensOu5dqmou60tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Hlny1nRj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=niMXl6t2; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Hlny1nRj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="niMXl6t2"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id DFB6F18000C8;
	Wed, 21 Feb 2024 07:37:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 21 Feb 2024 07:37:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708519066; x=1708605466; bh=+qgLSZta0o
	M6BH8hMduLHqojCPqZlORUo5mLKtH14JA=; b=Hlny1nRjHb2ZZebJ2Na0svwAFI
	qyJ0klAPlZZmHY6VqjaRTnOinV6NDCwohw76A6o9jFADwfy1hkBeeLkmfzCJ+l0E
	JrKMel5IDnCPUqdIlN6BmjOgHXl8vAP5/wbyzp4Y7wK8LefFLwmARIsVdePBCaQ/
	1Qt43vAqP5RrpxcPxbW3MbPZB8RI9TVNhbb4HGKdYP3qx2gOu51baDx58OcJtkaA
	pJak6b8AtAQCx5rrpNnhiQ4w9KeiGyDy55Jw4Z/0HKTn7yH9un+B+X7GHMlara8b
	zgzJqEDLWIrzWW1wYpIVeWmnDeDYWPE0GJwgV8yksAeVi0iNk0zACbP79U7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708519066; x=1708605466; bh=+qgLSZta0oM6BH8hMduLHqojCPqZ
	lORUo5mLKtH14JA=; b=niMXl6t2vztwHwMZfZNHEm+v2jKRuByc1DseZtybrsz8
	cdTTwYaLSGw2wc2alSZgnzHH8dbvj8k9t1JBcIGe+YWP/KrWPp5qLPFfZsdHxHSD
	AeBol2zSBeMC9qunh9h8VxSu9MHvzdESMXee6fZ0GKRWCO+lfPUEuw1rMNEn8+ys
	KYH9OFeI6mb0dVaLPxiH98f/S6JltEf/iYQ7FLs4fg2GwpJH330AOlGTuWGIzAVI
	kfQtWspm+5wOz6DVPsagcxSJXd3TNqZP+sImNBmmN7pKK1gWrK9sgePVMKj7j5/1
	H9CXJjnHraVZ45U2O2QjHlYiXImp7dM/MNeoVhwEfQ==
X-ME-Sender: <xms:mu7VZcPhdtwWs6tYv3La5ggN-JE8OEh4YE7tLJLEShuRKTlg8cpZyA>
    <xme:mu7VZS9uLS_5i7O5Au_N_5p7QS7ZeWkD6Qxf97CnbMLHYWwAsdTYvmnpJfV6-uCHA
    fLMb7Vquw3ZkcOjJA>
X-ME-Received: <xmr:mu7VZTR8CjSPbaPwKc8dI4QRD_VklZPFVmwCXtVnqOTsHrnCWriEeamDdT5j-Pp9M6xLEwlX741DaZw8r0GE2JUAkk-ptuy5f-xD3kn8eU8Z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeigeekle
    duvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:mu7VZUsG4XAcMum9kDMHWjgEQGKignrO3d6vy1y26oh-z-dw6-jAug>
    <xmx:mu7VZUfU3k7zfHlOF_stSUOUi0fPXThvENX0GRjL8f2KdGD9PBTZIg>
    <xmx:mu7VZY3I8ouvNe1WQNUWgQm4Jk7m0Gwaei5Pj8LycvCt8tLbiP-KGg>
    <xmx:mu7VZVqDnxQ3MOqf8uh_GmYae9ZL8BWRg78AGWifGrq_HUL4QdN4ca2CcXo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Feb 2024 07:37:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f623a2a4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Feb 2024 12:33:40 +0000 (UTC)
Date: Wed, 21 Feb 2024 13:37:43 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 7/8] refs: stop resolving ref corresponding to reflogs
Message-ID: <fc96d5bbabe7986d08eb1645549b5591784521e4.1708518982.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708518982.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tArJOrVIpRlRU3QT"
Content-Disposition: inline
In-Reply-To: <cover.1708518982.git.ps@pks.im>


--tArJOrVIpRlRU3QT
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
index c7aff6b331..6f98168a81 100644
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
index 4998b676c2..6c11c4a5e3 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1616,11 +1616,9 @@ static int reftable_reflog_iterator_advance(struct r=
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


--tArJOrVIpRlRU3QT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXV7pYACgkQVbJhu7ck
PpRiNw/+KW+qVVx1RSeFdOerYjGIfXAc86xKY85NdyjGi2uc3Nx6/iiJ+4WaP7ML
iKfM4SErlfO6f/UKIMG4gLjUyyXXaWBNwgQsgmiH74KEeCUfzFgxaWg0NB+8QLZ4
feCDw7UPUIzncTdX1qVcqy/LmRZ/IGcnFhlMg4ojeTyKN0plppaCQiBmHwGyGpAe
th0qAg/pNqequWfZw5grARWm7BgT2mVkz1WgAvie+hfilwrij6BL3HyxMxt1TKEE
JPHq2VeZo4nXeLGra3Yf93nof9T3y3XvP3cc7/KMhOXWWvWrwGtnnzUZVMePlIkk
c2PV8j8mmdXfipiQRXpRmwDPM0NirnVgZALLLXquH3fcucsxNEitst4skN9+Ir9K
pcoxkgWel1OT0yu2h9+vkYybdEaZAi9blCxwYBNapXEb4T8voo8D4mt/ClzdadTr
0vCp10Qg9xNtoo7wFdZJ5OCDtJWb4aV8DKk1YYjjEWX6p/2DRU3k3Rr+Tn7iUwAM
/W4GH92mZrhDoHZS3+/lBOf4GdjTEn9px5KjypsTF0+ZdajgsEL/+aO/EnQwwmBl
pliVNAH7dKP2jjSVqzrNbG9+v2X6MLztbqUhPCdfYywy7D+zrzv8zvoItVgHjGcv
6MLoj+nJibMT9kLZjfstMAn4C+I+Sfvbeff2D9sg/QxxV3+6Hxc=
=Kgrw
-----END PGP SIGNATURE-----

--tArJOrVIpRlRU3QT--
