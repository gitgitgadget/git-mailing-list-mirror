Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C48B381B1
	for <git@vger.kernel.org>; Tue, 23 Jul 2024 12:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721737901; cv=none; b=GlKxW6Vjkj6QCGK7ewnGnFuSj60/ZVF5XK/AcrGj18rf+bQOmkLzHUBRlPX1TzNAKvQ04BpZnL2ieCgCmOamLv+NBjqJZp6kun+ymshxbmGtRxDo02NMVVXVljcfQ+0Gd2maU2kozRYqFx3Ktg+OaXQ34P6lo6wBSTUcQCN5Gjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721737901; c=relaxed/simple;
	bh=YiK1oOyBVDv4hEZNLr63y8Ek/4Gc/sNWoiVSvNc4jjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dz4wh05fZ465pOT7TnO2/TtxjFESRO2mSOEZTuzrW76erya87msfgMN3MvwP9bgK/my7sJdxe8Y79pib6nRnTZFcBDdZKw6sGmbxdVIs/JG8Xp7nRw33KwNWWXKJHpi5IMcM4K/b1PPyANwgHf+FVu5G/ut1b0YMUUvRkWKlhGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kC/Rrm9c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mQbRoo1t; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kC/Rrm9c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mQbRoo1t"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 801CB1380614;
	Tue, 23 Jul 2024 08:31:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 23 Jul 2024 08:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721737898; x=1721824298; bh=w/yWTboFi6
	GMcclZwmMFFOP7MwCAz0A/2SVqq/m3tIg=; b=kC/Rrm9c144qLkYCnegoZuOCQ6
	Gd1NdL9CpGeDEiJ+JaSePqyNymZgqxPUORTNgqDoNk/bt9voHWU9zF90wLmXNmlF
	2H1WkzUBeRJpEJ55iekx8JiK9xgsfa4SqEFlDdefaH3z/yhH8AYLi1dxpmqKDIi6
	9pYJHTButp0UhUo782rgbmliBp7tGQm0fz8Zc0Oruh24owNZB45DlgvXM9vEkEHt
	N1oWDmQnTl3iB0Q+d2Aj9Fa2PhxNtPZXFJ6cXT8nVDreKEvrJihgqIncVK8KR4Q8
	bAFkcKEiXE6vGNlqPkoIajQ/8yNBdgukzp+5sZROcOQO5yN36go/FPJOYtbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721737898; x=1721824298; bh=w/yWTboFi6GMcclZwmMFFOP7MwCA
	z0A/2SVqq/m3tIg=; b=mQbRoo1tU9udy9ZnUW/iYTmM/KImhrgwkP/UfU9wkT6t
	GS1GlIj2euyt6eGNfG+OAiWgmAzoxi+1qC8PNxUnuP0H34T7xtWTT3kGzvcJrGPd
	hIBwXASSF2f94KWfScK3m8F4qD15WZMVAXKpp7GO3bJHw1SFlJ5NeBO7r7G+07n/
	M6FiCl0NlRQ4nMWpQBIayEys+Jj6c3AMzURIi786jxWRqySk3AdYUZ/MLZIEUiK0
	tkfXcSvru5DY4LdGnKAj1PHBocKUiG/EwVXdaio9rqUeQKxu5AKKF+kbKg28JKP3
	fgLujII37liMHwTiJWnfgSmVeqsJk3fj541oxJw03g==
X-ME-Sender: <xms:qaKfZrSOOwsQFEpDhheBsq3dj09wwVKw3gJKMNTm3qaCXUIXxpbxwQ>
    <xme:qaKfZsyWdzi_WiMszBt-yDrTfQxp8DJG7Fsi9o_T65nvaRK6jzcoblZVmyHF5xTPP
    Tkb_a_VTruLNac0JQ>
X-ME-Received: <xmr:qaKfZg3V1l9mrQ5XskYhKdxiq-YbjDXvkyzYRzJmxaL3TaD6ZTH-RmW0ONwGON0cTKL2DlR4TUUMsujKusNWcMrnbGrD_ZPLCHh0qGJdHvU8CUK1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrheelgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:qaKfZrDQwcSX0ovqD7Gn8P54MHxKk6GnOJh8gj3fIbZCCPEiuqvBEg>
    <xmx:qaKfZki_hyZS1ceWniaa7sicMT7-XpxeNq2nF2j69nlRflTzOSf5qQ>
    <xmx:qaKfZvq97aT7Sk1xGS2hSqcFEsXeKenuDTiJLsxtvK66t9IgGNaUPQ>
    <xmx:qaKfZvgQ_jLXpMYAn7MtGaKZoHAvnUuuIMzEYiImT-2cYLgLHrykmg>
    <xmx:qqKfZuZiv0K7ZdW5PJ1QJVD2NJT3jvB7fecMDgbbNYusxuqs-ypFqb5p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Jul 2024 08:31:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bce7cad0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Jul 2024 12:30:16 +0000 (UTC)
Date: Tue, 23 Jul 2024 14:31:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH] refs: fix format migration on Cygwin
Message-ID: <d031aef5552d894784650a8c6580925e877df794.1721731179.git.ps@pks.im>
References: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yZnE2wDjJsxpw7/p"
Content-Disposition: inline
In-Reply-To: <aacb4067-a16b-4953-a72f-3c66efd3cf25@ramsayjones.plus.com>


--yZnE2wDjJsxpw7/p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It was reported that t1460-refs-migrate.sh fails when using Cygwin with
errors like the following:

    error: could not link file '.git/ref_migration.sr9pEF/reftable' to '.gi=
t/reftable': Permission denied

As some debugging surfaced, the root cause of this is that some files of
the newly-initialized ref store are still open when the target format is
the "reftable" format, and Cygwin refuses to rename open files.

Fix this issue by closing the new ref store before renaming its files
into place. This is a slight change in behaviour compared to before,
where we kept the new ref store open and then updated the repository's
ref store to point to it.

While we could re-open the new ref store after we have moved files
around, this is ultimately unnecessary. We know that the only user of
`repo_migrate_ref_storage_format()` is the git-refs(1) command, and it
won't access the ref store after it has been migrated anyway. So
reinitializing the ref store would be a waste of time. Regardless of
that it is still sensible to leave the repository in a consistent state.
But instead of reinitializing the ref store, we can simply unset the
repo's ref store altogether and let `get_main_ref_store()` lazily
initialize the new ref store as required.

Reported-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index bb90a18875..915aeb4d1d 100644
--- a/refs.c
+++ b/refs.c
@@ -2843,6 +2843,14 @@ int repo_migrate_ref_storage_format(struct repositor=
y *repo,
 		goto done;
 	}
=20
+	/*
+	 * Release the new ref store such that any potentially-open files will
+	 * be closed. This is required for platforms like Cygwin, where
+	 * renaming an open file results in EPERM.
+	 */
+	ref_store_release(new_refs);
+	FREE_AND_NULL(new_refs);
+
 	/*
 	 * Until now we were in the non-destructive phase, where we only
 	 * populated the new ref store. From hereon though we are about
@@ -2874,10 +2882,14 @@ int repo_migrate_ref_storage_format(struct reposito=
ry *repo,
 	 */
 	initialize_repository_version(hash_algo_by_ptr(repo->hash_algo), format, =
1);
=20
-	free(new_refs->gitdir);
-	new_refs->gitdir =3D xstrdup(old_refs->gitdir);
-	repo->refs_private =3D new_refs;
+	/*
+	 * Unset the old ref store and release it. `get_main_ref_store()` will
+	 * make sure to lazily re-initialize the repository's ref store with
+	 * the new format.
+	 */
 	ref_store_release(old_refs);
+	FREE_AND_NULL(old_refs);
+	repo->refs_private =3D NULL;
=20
 	ret =3D 0;
=20
@@ -2888,8 +2900,10 @@ int repo_migrate_ref_storage_format(struct repositor=
y *repo,
 			    new_gitdir.buf);
 	}
=20
-	if (ret && new_refs)
+	if (new_refs) {
 		ref_store_release(new_refs);
+		free(new_refs);
+	}
 	ref_transaction_free(transaction);
 	strbuf_release(&new_gitdir);
 	return ret;
--=20
2.46.0.rc1.dirty


--yZnE2wDjJsxpw7/p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmafop8ACgkQVbJhu7ck
PpR09xAAnELJ0dan8GNiPnr2ai8x76/YU+BsEj30xdKzx3xgZRnukKFkv9IWJVU6
h+hMtXdPtgfxDJ+F0eucV8mkOdjAynFtVU4/Un/5EGW2VDwGwhY4YpSaHO1bqW1M
/o35Xex3umGgJejebmz1RPZ9A37MV/iYVwDG35q9Kms8aVgZeG2vny0sj7FAH0lJ
M6FrfE4DnN67qMhoJvVYv2n/TkMnQdq/8gVGwm8tUT1UkTdX3U5seUBDyB6NXHIe
kSKdQVmILVCFcbPw0aIro1KFcg01Tr8iJqcajzE2QNaDShkntnq8n0cMAdWX+Xgy
NADYLZOn9c0kS88cj6Sr/QPZMIaBWxZ5mUGe9o1u+/rRR4PafsJEhDN2nJvBKzwI
SSEMwPhE6xtrh546SXT70ZCyUlThzTtlITJ8zutIuhvD7SB71Fp9qs5wjWUYoV6u
ZoOUjWhUkozWMO/G6mNfIk28rqleRocZNmqEUQqBNYRzFyz5W6Fc5Udex6aVrPF6
y97h5RraV9HXezAlTlc66n63EKBvK6GpKtLuHG9dIWNwtmvPEgASJY4rm7rsIDRN
LPiahA+mbT7R8OSIpEgJAEDDC/OHIsoqmW2AUpGXI5aaIX8eRSSUMTUEl7PlBBSd
zsdbzZkXpFQpuxtW0fSeZME24uKOAdZXRBMJjUC3GL+bAvRb+G4=
=ow/M
-----END PGP SIGNATURE-----

--yZnE2wDjJsxpw7/p--
