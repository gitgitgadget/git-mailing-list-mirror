Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BA61E6750
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 12:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723034657; cv=none; b=Ps2sbBfy2XVrigF5/QgJez5jB9E/NtfPqC+7V9nqMiVIyEyjyhZmP2eTvafjrT5F+R4Y/h/dGo4rblrRve9+1PI70Pk4qX+xOth5zOfGuuDwgiOPR5C4WctdnoWNywtBK9ij8Lpgta6Es+R6N3wfpaKjUZnGMM3OTMdKWI6wRh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723034657; c=relaxed/simple;
	bh=W5DOTHjijoz5McRGzmwS+BeSsMFV0eKFNNvmU/w+CIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiRSIdd7DLC7A0fnhK/++4naD1lxmSEkcddx+NnuKkcFra7/30xryALFFPJ3GSTHL41mbw5WFiEUb1k0fENBusyipNqq4ZC/BLNGd4iulyrUA83q90gtPM8E0+NUK1i9pI5ZCK+QVcCDJ07lswEP8R3sUU+UKYwEce6dBailhgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nx/hvRC2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sEYZZgmq; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nx/hvRC2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sEYZZgmq"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6D9D01150DE1;
	Wed,  7 Aug 2024 08:44:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 07 Aug 2024 08:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723034655; x=1723121055; bh=pCgjG/TpmS
	jm214B3qSKmejk1cq2wG8Mqr0xeHMNk6k=; b=nx/hvRC2RCk2jfOfaszBiibvvC
	UQlwEcvH28f5F75NvwtHc73M2wiCXMZsbNRF06eoJre3ctmvIjH30ZmLmt3xfWIW
	8bB2E82LLyvUjYrGk4diz5xJ23zsX3/E2NBLLeENPq5pet/SRZ4yVNhjoxbuA14D
	2pt13MI8QFclhzpucyg8IxsMLPRJuV9iK67CjY2Z1j3iIJroUspY+xpbIVV4vE6Z
	LqPKKEUnxOoDs3QSJgjmAyMrYMEdBXMZBiF2/ZKXscWwx9oSWtLiRdZP2Mlo6rdn
	lhmY7aBPmh/gsq/SH8kt9LJu7zwyYpYGYMTwcpmtOROBiVeg1d+90BiH+zGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723034655; x=1723121055; bh=pCgjG/TpmSjm214B3qSKmejk1cq2
	wG8Mqr0xeHMNk6k=; b=sEYZZgmq3sOjIbPMhZ/PkWmEb8zB3u/9+G+tRaiWgzV2
	mlZuyG+j59ZjhCdwCufuHPJYAUU5Dni4z/JSdoBjysYXOh+eWbPoiD/ox6Ur0yrT
	BUI2olfEKSJYGC/dPqmb7GXoNd6ou5+Q7odLtgyZy8+XsSt0RPaJ9fZJKQDZeRdn
	1xxD0jhZb2jdF2DVo6UV3Qy3A5bR/BRYMndQt69NQWvPDu0744+V5yeZhXqPL1rr
	7ItKygn2AjADvW9vMmdiW1+Ty4iL9UTvy7kWeVuZPg28qm0XH+CStnMug2lFdn/o
	7vDTb7YvyivHx7BClTALpLiib3R/fVsEvURqmc9P/A==
X-ME-Sender: <xms:H2yzZnnrMayeTPo1dJtxn4ipGWSZ4DqLKrrivGMPlr9yPcygPLwwYA>
    <xme:H2yzZq0UUnS9y-x8RCp0QwUc9nUhNkcvIgREdJhk2tXl2yYssxWN_NhTsKSxqGWFM
    8e6qgxVvP-Uu93Yzw>
X-ME-Received: <xmr:H2yzZtqTYlJ0D05TD7j201E1YYU2FCZnwDX87u5pJyzC5t-k_JgNC1CAe5NtWXqWDv_ydYLsRtsp9IHjhnYCQF3ynq7e-F2kVNRY3EtFCPOnssXP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledtgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:H2yzZvk7qkJ4qvdKfhpYRzMee38iOHD5ERYTOm2RAROUmjrXbmssQA>
    <xmx:H2yzZl0DLciUJZZnqOy22WTOSyP_RdGEGkLUxdwyu8K3N9EUOkwFdg>
    <xmx:H2yzZuuY0uwWdeO_OiU3-jqLPI3imDTSrmVdhyBrP4LyWRY0iouv-w>
    <xmx:H2yzZpXPT0B42hXD1cB8UGmFBZA_5GkltN5NseKRhgbuIImdytHytA>
    <xmx:H2yzZuwQv0i7qpa10xZuZVvtXoXBsMWqLCEiGlH2iWTnDrN51P6uAeMr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Aug 2024 08:44:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 945217ad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Aug 2024 12:44:09 +0000 (UTC)
Date: Wed, 7 Aug 2024 14:44:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Jeppe =?utf-8?B?w5hsYW5k?= <joland@gmail.com>
Subject: [PATCH 6/6] object: fix leaking packfiles when closing object store
Message-ID: <8dc7cc76d588ffe143d1d35e78e6eb86ed6d0b20.1723032100.git.ps@pks.im>
References: <CA+osTZVApTAMogBDMaPDEVViJHrFT=BOer=Py4fjTvpsifzfKA@mail.gmail.com>
 <cover.1723032100.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nWRtOPo4Cy76Ziw0"
Content-Disposition: inline
In-Reply-To: <cover.1723032100.git.ps@pks.im>


--nWRtOPo4Cy76Ziw0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When calling `raw_object_store_clear()`, we close and free several
resources associated with the object store. Part of that is to close and
free all the packfiles, which is handled by `close_object_store()`.

That function really only ends up closing the packfiles though, but it
doesn't free them. And in fact it can't, as that function is being
called via `run_command()` when `close_object_store =3D 1`, which is done
e.g. when we execute git-maintenance(1). At that point, other structures
may still have references on those packfiles, and thus we cannot free
them here. So while it is in fact intentional that we really only close
them, the result is a memory leak because `raw_object_store_clear()`
does not free them, either.

Fix the leak by freeing the packfiles in `raw_object_store_clear()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object.c                               | 9 +++++++++
 t/t7424-submodule-mixed-ref-formats.sh | 1 +
 2 files changed, 10 insertions(+)

diff --git a/object.c b/object.c
index 0c0fcb76c0..d756c7f2ea 100644
--- a/object.c
+++ b/object.c
@@ -614,6 +614,15 @@ void raw_object_store_clear(struct raw_object_store *o)
=20
 	INIT_LIST_HEAD(&o->packed_git_mru);
 	close_object_store(o);
+
+	/*
+	 * `close_object_store()` only closes the packfiles, but doesn't free
+	 * them. We thus have to do this manually.
+	 */
+	for (struct packed_git *p =3D o->packed_git, *next; p; p =3D next) {
+		next =3D p->next;
+		free(p);
+	}
 	o->packed_git =3D NULL;
=20
 	hashmap_clear(&o->pack_map);
diff --git a/t/t7424-submodule-mixed-ref-formats.sh b/t/t7424-submodule-mix=
ed-ref-formats.sh
index 998a5d82e9..812496dc3b 100755
--- a/t/t7424-submodule-mixed-ref-formats.sh
+++ b/t/t7424-submodule-mixed-ref-formats.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'submodules handle mixed ref storage formats'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_ref_format () {
--=20
2.46.0.dirty


--nWRtOPo4Cy76Ziw0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmazbBsACgkQVbJhu7ck
PpRG0xAAml2Gmnlf2GMx5A0jYerHM9jTROE213R76NsssmQ33lNNurj3vDeg/qIz
EY0qysUOSFL2qshxYhFgAqt7uPJ7VW3FAoOfYCv1TzQ2mxNvlsowb3lrw9OGKpVF
BLlqwpTv3cXuShNTtnVq0AD4sTNNrQ/oAd7QXspqRQIKooRl8jcjzYrkDG50B0ex
KyUpQn9zl/wNtxb4b5hYJvINyeVOvZp+iGWTq5pTVdRUL/1SqAEan+rBWY1koAyk
eLGIMHAsfnzRzbjjl9ddBUcWHa9zj7FQsmPeOasM0w+rJ1Z9YL7/lV1zt1KqbXOr
gcXBKwsF3ET/CmxK7ARJIy33sR2fst33MROzUYI4tLIiBseFLchvAIX8xP7KhNA2
+Ma7Ds6IE2F5J/Dx4Rn79a4AJ/Jr1vimsZoTWKh3XzObOHUbhdHGjDUfOsiksUwZ
ZnpzOZfACDFGDn1PxZpRzu51erVYi1/y66cTGqZyo7luWobr1l56byZIXwOSBlRO
oyWakOaE+vBPo8CgsL+G4Wld/c2y7kOGQsHE3V0IH7W0Jv1qbZAXADUkVyTuhvBw
Kq+TiRbKyD0eUcY0000oDn2eGUFEoxImOMRofLsGyiE0wjv2vN/3rOqlTacpHpbh
aPNlgTXpfpE4G3eg90Jo7yCxDGq9RYAbEbn86d1fQGlDTsblNLQ=
=9boA
-----END PGP SIGNATURE-----

--nWRtOPo4Cy76Ziw0--
