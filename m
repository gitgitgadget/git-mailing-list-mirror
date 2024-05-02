Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B895536134
	for <git@vger.kernel.org>; Thu,  2 May 2024 08:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637882; cv=none; b=attCoood1PSy6ikXCxuyWDiMFgv7CngM7jtHcJvBaTmb6lFksIhFg5HILhebonhq4rDoY0cIkY4gqRzJejc0mw1uWaNyQtXIlyg9n1MJQb6MyjHLhWccJcKuxXLmpaDVQIygei0Lp/JdFIr8ZjsRh0atond7cDAmRqtVHNzX0z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637882; c=relaxed/simple;
	bh=OpyRhZy8z8+HE4yPto3zXnjczv4ZRnD5pfMdUeXpFJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gO7RqH3ZxUcUR9hwxx6JpOiHNTteyFrOH1BZU/l9UEPZdXlAERJ/tvGhsisPKbRBggNN9NjN99T1ldYd8m3R9QcAGKpFhQlzalOOeXEnSw3D3PPGW57i2wdV7si0bEoUUeWzYy7Qqz4s98ZWee0hTUOtUr7YbPlpLx7AluN+sJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aGZtthe8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XPGMt3J6; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aGZtthe8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XPGMt3J6"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id CB2041380F8B;
	Thu,  2 May 2024 04:17:59 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 02 May 2024 04:17:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714637879; x=1714724279; bh=nhxc17gc2d
	kvk2vzCIu5bkyJ4TnJlnLGRMfHEKsAodg=; b=aGZtthe8BxjrqhQoS+jA7mKoTo
	vzbTPU3aQHI3vNIw0a4reS6ozQzWVcT86j1NMI8xoGaKwbktXgCqdkGbZj1yuAkF
	/YxbwkJLa3Yv//mGfQtQkZOkbz39AEC7E4QXaM0hiZeCTgZvmFlVqV6okImm5EWL
	BFrHyZfpBiwLozMAMgJucip6Ld3Eq49czbDKObFpIDFgoTd71SfKcfQVRyjnqJch
	pR9bVio1XYtzkeARXkfCWPG5rFZM+VlE28w7ylWq9XTNgeuvmxEviVF98Ng2gJEo
	sO5bTFTBy7SaFBHCd7F0Ld7iux6sZIDR5E9BgrvSK5xKg/RKV8exq7dT321g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714637879; x=1714724279; bh=nhxc17gc2dkvk2vzCIu5bkyJ4TnJ
	lnLGRMfHEKsAodg=; b=XPGMt3J6jF2FvC38m+NA4Dyo6NTw45orP+8mx6Ljv2V8
	GZzofFf1jFCa8T3nfTgPksz16HNFwuWijVNYH6zeafBuo88h3Z5Hzj6OeV2QsN1h
	2zXTjsOOKHmdynLnRNDmoT0Igd2DB+kaYeQoDcc47v4RNz5OXM5I+TG7afmM2a/c
	CGHrHfBQqoM1IDeny1mKjqQzR232kw9siwMa7vD9KT3i+bitMzmMRIdLPkOGkGs7
	e4CY1h2xf83DQExUDb9PSYLw6IBKjhjHj4gSn02RcQGDh1J4pRDXP3KoloB7nN80
	OWoRJl/zm1sD0sUkF5lmqj2XkeQOrdExLag4VsQ8Zg==
X-ME-Sender: <xms:N0wzZrn-_VGQ2RVl1urneTVOx_EamEHYau0kYccWafVikQlnvDs8zQ>
    <xme:N0wzZu3GgaRF7dWzjB8ApyjWEV59d_omIMMKvtPi7mMNXjJqe6nkpaM_fqaQtckwf
    tVnzjoZRSgk3czxVw>
X-ME-Received: <xmr:N0wzZhr51oNoPD2gL_WC_TykGz4HJyK_-fi5io8w8XD0seCBRLis6-58vOWZ4XNkvEZ7bsmlz5Ui5lswkEGoVzCH_5yPG9aHenHf3oAq9NGdmUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddukedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:N0wzZjnYMLup-kbrzZ7x-USD8X6uMEEtn1inmGto04BWQljLWm8jKw>
    <xmx:N0wzZp0K35TRF8y_6aNTgSOZSQE16BC9qcF12rhq6F2ZbjNEAI6gew>
    <xmx:N0wzZisvIzaIB4FrEXP2uHJUXMbDxVz3shMC4LJohHqUSmK6qSPaEw>
    <xmx:N0wzZtVIneGA9isGN4rkMp2PPbKQUhzMHU7ZbsiFNNJnpNbyJ3E8HQ>
    <xmx:N0wzZmnmTr42v64zjFpNmylwwQwlGWix4RtoEEmxyj6NhsLgmKrUfdQd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 04:17:58 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eb8866d2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 08:17:32 +0000 (UTC)
Date: Thu, 2 May 2024 10:17:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH v3 10/10] refs: refuse to write pseudorefs
Message-ID: <6956fccced4d082c7fc304fb154147838ec43205.1714637671.git.ps@pks.im>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6N5pMGybjy01JXFu"
Content-Disposition: inline
In-Reply-To: <cover.1714637671.git.ps@pks.im>


--6N5pMGybjy01JXFu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Pseudorefs are not stored in the ref database as by definition, they
carry additional metadata that essentially makes them not a ref. As
such, writing pseudorefs via the ref backend does not make any sense
whatsoever as the ref backend wouldn't know how exactly to store the
data.

Restrict writing pseudorefs via the ref backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.c           | 7 +++++++
 t/t5510-fetch.sh | 6 +++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 50d679b7e7..7c3c7465a4 100644
--- a/refs.c
+++ b/refs.c
@@ -1307,6 +1307,13 @@ int ref_transaction_update(struct ref_transaction *t=
ransaction,
 		return -1;
 	}
=20
+	if (!(flags & REF_SKIP_REFNAME_VERIFICATION) &&
+	    is_pseudo_ref(refname)) {
+		strbuf_addf(err, _("refusing to update pseudoref '%s'"),
+			    refname);
+		return -1;
+	}
+
 	if (flags & ~REF_TRANSACTION_UPDATE_ALLOWED_FLAGS)
 		BUG("illegal flags 0x%x passed to ref_transaction_update()", flags);
=20
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 33d34d5ae9..4eb569f4df 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -518,7 +518,7 @@ test_expect_success 'fetch with a non-applying branch.<=
name>.merge' '
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.=
merge [1]' '
 	one_head=3D$(cd one && git rev-parse HEAD) &&
 	this_head=3D$(git rev-parse HEAD) &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head =3D "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head =3D "$(git rev-parse --verify HEAD)"
@@ -530,7 +530,7 @@ test_expect_success 'fetch from GIT URL with a non-appl=
ying branch.<name>.merge
 	one_ref=3D$(cd one && git symbolic-ref HEAD) &&
 	git config branch.main.remote blub &&
 	git config branch.main.merge "$one_ref" &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head =3D "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head =3D "$(git rev-parse --verify HEAD)"
@@ -540,7 +540,7 @@ test_expect_success 'fetch from GIT URL with a non-appl=
ying branch.<name>.merge
 # the merge spec does not match the branch the remote HEAD points to
 test_expect_success 'fetch from GIT URL with a non-applying branch.<name>.=
merge [3]' '
 	git config branch.main.merge "${one_ref}_not" &&
-	git update-ref -d FETCH_HEAD &&
+	rm .git/FETCH_HEAD &&
 	git fetch one &&
 	test $one_head =3D "$(git rev-parse --verify FETCH_HEAD)" &&
 	test $this_head =3D "$(git rev-parse --verify HEAD)"
--=20
2.45.0


--6N5pMGybjy01JXFu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzTDMACgkQVbJhu7ck
PpT7JQ/8CxsM/PgQB471XvX9seU0XmBaGDG7MgKW5wCjmOIwP7qI5TEB0DvOKc3B
8bgZuUaReshsqMxU+wjX6mx6z499fyEIY5TmK7h7olpfBmBBA/QHoNppCHwqoDtd
/Q6Ovqy1gkPRFo3SGM3RDbvGtTB2CGh4b/3haUZy+PmQ3zhkgYPJK0f+ujIIgMvx
zrguTU4CQX36rI5hLCeMP5VDqC6nJuv1AzT4GfHCkG5aAx/Ho0furyqOCQbVl5+1
FsRjaNAWiKd2mBQkSgj2kUkdSkDdsRU3S7NV88265apX/BpqlWb11E8qTQg1bgvy
wNJYRI8irD87hqluYXaDePqnrmIRilL+UmuaXxlL/N3ehh3ST9qB92IUNpKUawZx
NhmguUu+myjvGAg7Zv0iO8dz2wpTC70OlYbT51hVPAAcs3mzuIeisvdvn2EQV5Xi
Q7L0y0sEi/CCq7wlrGjENGqbpaS908VCeqPHSb12ELrbiwoEdgp5KRiv7RMZoZ1K
JZy0MtGYaJiV4VPVgjchpn6KsRbe88iroeNO2YyAnZOsiQryRpmbGSRdqZH1+6XA
LZG1zsqETjnShcFbQTDQrjvdgz27CFJD7d7bVjYdY1wy9VWqPTHdgegL9TV5H+ez
kwVNxiKl1RyiX8I8YeUuzqn16pzYmx49rmwmCDoCFSC2XKbGK/c=
=lCTb
-----END PGP SIGNATURE-----

--6N5pMGybjy01JXFu--
