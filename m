Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA0714AD3D
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079006; cv=none; b=tcjdANnlnHteyaqGzQ3OQcnDj+9VcIZ9ncEaDHvbZS34cX4gqoybRHz3naaajRM6ctm/TzaeUKAqTL2bOGlxSrzeAXTCRCGshZSPB4l06Rbz79xuGwGRCrAmNi3Mj44OLtMqZBfrUwB8Aa7KhEwYzw77N+kF/X5Rjscdks8eE7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079006; c=relaxed/simple;
	bh=TUHku8Q2YcBw/+dfwxi4uuOkOWrE51gh+b8XfjtaGmI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HDae/XFeA9jdzQqGe8HF8EJaypNw5FGsXt+ZQ5izRNa9cBbm/vj90j5rDM3t9A/tidjzpFfT4UYV7CM3qCdrsmvXXk2Yx01TaKnF1yf4FrowHJCtrJg4GEGyaFniHiPH1HwIdr6/RKqkaE8QEz73HaI+JFCo4SHxZQPLjQTPZaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X11sNteP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eXl8l7Of; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X11sNteP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eXl8l7Of"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id BD4171C000D7
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:30:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 02 Apr 2024 13:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712079003; x=1712165403; bh=whNuf1I48I
	jBqJw38HGO+tS9NZ2TpvzD3T9r2zAk4GU=; b=X11sNtePMpS3qCRw4XPMntEVZ5
	bxop4qGJd7CaR7J8ok6edNS8WrpgT0thyB/b2u9eucj0GIPI5GtYNcJllhjm/Z3o
	171UuaItmpagFinI/2H2e7Jt4HX4SKQ2f1DcNiKhM2R8UN6lXF1nv8Pr85N/mM5n
	KqZfl3h0IAx+76w1lWdylLmY+CeWGSChZdszAMcn/uUbeIJZIWuzK9N7Hze/BX/U
	vazxtXO2Yra1KdfUVRlY/CcsJwK6bp/VJWnFhYiBiyS8vtV+pt/x1hERYpChl/Ap
	P1uEExy2nvOaxdx6gAd+6icUCh9LaHYcvdhfT9EYdlnPcU6mJahCrsq6Aq7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712079003; x=1712165403; bh=whNuf1I48IjBqJw38HGO+tS9NZ2T
	pvzD3T9r2zAk4GU=; b=eXl8l7OftsG4Bau5HN1F3gY23P/1yofzdbIamTx0gmnF
	6fyK6K6QfklbW7f1O7DeaOVhClRIXhGE1RYx4tqrCQcc6BbR0Iz7/uOMrq1i3WPq
	ukY9yMukAlHoL7tl0gH2U0h3A5Bc8I82sm0SjCZP14aKP2wTJPqAWSmouk/7fwxX
	nUm1hex963sOWD8HUGxDSjSg3Gm0nQWlgDf6LIJwYyo1bLhZG+ae/uy/NjS+1RtC
	AJpyu7zDJA1Qyknf1YxGRBlsE/PxWfkZXty77bUb+0cLSuXIdZfFwjweekRjRVOY
	oaGILV/r/axZm0f14KY5ZeR7kFbXcI+ZeCNqgviOBg==
X-ME-Sender: <xms:mkAMZjiv0KZHoacF713twAL-KRZ-R-eJJvRXVWuxWS5wK0bBw0_qcA>
    <xme:mkAMZgAH3eNtms__OXQoVUpWYhtFfjKN59joaPPtta0O5o7FL8IRmSZGMRzCYgAD4
    -ediZwJ35-RAirnLg>
X-ME-Received: <xmr:mkAMZjFTxgSeFYrw5XpltGwFbywHT9z8yDuiiwJoFKPey27d-Lz6XyXtyg4XZeWD7pva86STC8pUDdV54rJj0JMN9LsWl4kJuWMbXtS_-banWA4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgfejueevjeetudehgffffeffvdejfe
    ejiedvkeffgfekuefgheevteeufeelkeenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:mkAMZgTePqt_zY8ibJZLaFLiemjYBjazMKe0qMYSEByH4qM7sQet9Q>
    <xmx:mkAMZgzkL8UDMv-HNoGrb8wtlHU17duERebAaAz5vuCwH84CuuUm7w>
    <xmx:mkAMZm59PSBGL6Wh__EhMLo2CQFvBoK5qcy8YqynG_Bes5j62muwUg>
    <xmx:mkAMZlzN5HCxtGLESz0_-5fFLGiQi_YK2c7OdmTJSwf2yyXfOk2DiQ>
    <xmx:m0AMZr_mVlAq4sKp2ijjmZy1-Es6HTSiruluLj6MlzAkkms64qcdA9VM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Apr 2024 13:30:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 17fa49b3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Apr 2024 17:29:53 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:30:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/9] refs/reftable: skip duplicate name checks
Message-ID: <ad8210ec65562452e5a3b3beadb2453941120b43.1712078736.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="B2AzdwD/IkOcavP2"
Content-Disposition: inline
In-Reply-To: <cover.1712078736.git.ps@pks.im>


--B2AzdwD/IkOcavP2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

All the callback functions which write refs in the reftable backend
perform D/F conflict checks via `refs_verify_refname_available()`. But
in reality we perform these D/F conflict checks a second time in the
reftable library via `stack_check_addition()`.

Interestingly, the code in the reftable library is inferior compared to
the generic function:

  - It is slower than `refs_verify_refname_available()`, even though
    this can probably be optimized.

  - It does not provide a proper error message to the caller, and thus
    all the user would see is a generic "file/directory conflict"
    message.

Disable the D/F conflict checks in the reftable library by setting the
`skip_name_check` write option. This results in a non-negligible speedup
when writing many refs. The following benchmark writes 100k refs in a
single transaction:

  Benchmark 1: update-ref: create many refs (HEAD~)
    Time (mean =C2=B1 =CF=83):      3.241 s =C2=B1  0.040 s    [User: 1.854=
 s, System: 1.381 s]
    Range (min =E2=80=A6 max):    3.185 s =E2=80=A6  3.454 s    100 runs

  Benchmark 2: update-ref: create many refs (HEAD)
    Time (mean =C2=B1 =CF=83):      2.878 s =C2=B1  0.024 s    [User: 1.506=
 s, System: 1.367 s]
    Range (min =E2=80=A6 max):    2.838 s =E2=80=A6  2.960 s    100 runs

  Summary
    update-ref: create many refs (HEAD~) ran
      1.13 =C2=B1 0.02 times faster than update-ref: create many refs (HEAD)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8a54b0d8b2..7515dd3019 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -247,6 +247,11 @@ static struct ref_store *reftable_be_init(struct repos=
itory *repo,
 	refs->write_options.block_size =3D 4096;
 	refs->write_options.hash_id =3D repo->hash_algo->format_id;
 	refs->write_options.default_permissions =3D calc_shared_perm(0666 & ~mask=
);
+	/*
+	 * We verify names via `refs_verify_refname_available()`, so there is
+	 * no need to do the same checks in the reftable library again.
+	 */
+	refs->write_options.skip_name_check =3D 1;
=20
 	/*
 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
--=20
2.44.GIT


--B2AzdwD/IkOcavP2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMQJcACgkQVbJhu7ck
PpTBEQ/+Kj5FoWb85mVDpgvnNuD9bhgbHCNdJmvXPUXe92OnZCWC7ebR+mM9JYb+
sTa7RD6GH+Td0FVjzUmM9mx6vL2i2WPyK5AQOnqa6ogrRqi5QU733H2QJ0iT0bWz
NB7LoMe3rNNN3/mxPuHTLTEH4ZwC3XNF0CtIfUyU81rTXjATn6XtZN3E0qFDvysZ
VSEntefno5Ir8RU6njnNWmFYPe2S/J4DhU/GfCoG3+rXShovUu6v0JzWe1WQs6ej
eQ/j2yx0zIAhX4woL9ASUuDdjquS74SQPFkGKRauFwef/S2E4tZ5ZFr7uVkBmPXH
9dPBZtjr1zCyxBdSw1DpeI8v/sAd8CIJU5PXv0Yqif/cL52POViN2Mhwx8PwVtbt
6G3wuNPg9gOcY5bb+DGNOYXg3MefWywwTFPRcUVIn8AbeRStpkdICI8HF+Be0PAr
T1XHPwMZV/WRBvYMyOAyeMMN2S9gV0mWGNwVWZwr6y2yBkqA4MB9hZpAo8H+YB4O
12iwgVOudXcD2+iJhIbVGsVZGRZrOAKGT4+m2kf75DnqJ3Qe1+5EtwMFNlyZcMEM
GyU2fIJnHCYjYITPveV5wOvdT0pfLOf8JIMfx5LUgTEg3qb6zRFa9m5PCKeZwbse
X/Ij/1UeyYnG8WK62DdG0NMcMdwlETcAkJNxFpTKPtHJNXAo2sY=
=YKqO
-----END PGP SIGNATURE-----

--B2AzdwD/IkOcavP2--
