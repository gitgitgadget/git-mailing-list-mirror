Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECF585627
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408027; cv=none; b=Mq/CMKm77xGpjAJ8PQ87T1wVnaIiJWqqSjc1o+SdRZT1LdaveRxf/iyTqU6OaXiai7+gpW4OtZvVnhnLM6VasyKR/x4FgW2eG4F5i6qxYFJZO9oHycL5nKEzZ86jVb9DHo5YLzp+ipJrXgPTqPJAkw9CUdtUHpXFJwgHWTcjdGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408027; c=relaxed/simple;
	bh=OD0FPgdsDZ7iZimdSELKs/7Jj8YDEwxIhuiIWIPE/D0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DBtMYNMr1IEKQrQFtD9+1yyNpuf+Yg/aoHKf9fX+VJ42+SLjriYlH2cykn7cegTLa9Hk9ifkKUyfjHkypji6SV/Pjf+khfrMXXONNDW3SL2kDQ0MlAwTjCYIFwSgTyE8NAoxuLggibsNorRZM8y8Ftp1Bt9gy41BrF7GH/qGykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F62s2mVi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bt29kAtN; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F62s2mVi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bt29kAtN"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2D9771800099
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:47:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408024; x=1717494424; bh=iE7d7C5POo
	pTDGuejXmACHRwwhrZikZpyNP9exvYWCk=; b=F62s2mViIxutdNhJD4ZzRXEwQQ
	wqCcsXWXJLs053OLEUHfr7uQMSOHhFwkMJ3MmhKfV+fcBnVv3exExxUY5Fdm1Vmv
	W8awHy1CoPPuBC8h8LTb6ruZjt3xOx6+AcDtzIQ3sZuFn4QGinNaH2n8AvMNfnme
	sMwgDkYJ1XeJlw+rriRdOWXtjqHHQaFaEocjy+SRo6spM2luZeRLBN4zLMxg27W4
	I49AEGIiad2aJJ2ZwoC0mL5SU6Oq6WXPDjCEsHH4EITyaADMqvlAnvQxddw4PFBb
	gXl15Id1kBDCV5/5OCX8Cpr8V3yyHHDGdNbi3pp8eell36IZmZ9qiNPZ5qFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408024; x=1717494424; bh=iE7d7C5POopTDGuejXmACHRwwhrZ
	ikZpyNP9exvYWCk=; b=bt29kAtNXoxsasyPOkYRZQ8K3+Z6kGHBhbcSivi5BgLA
	zeXh/UQXy/91IuiAcy5J43J5zQFMKteR/i1QpJsg/5DR8V8KkR+SyqqtD2f/TI1K
	69rqd9YR+yN6jxmrslTcLmVWsCLaY5YbAu7fhc4UWNeyrRlS4FMCsO4oYBqzd4yH
	NeKlFRoz0ebmNugZZkI6AASgM3RhAsQLwhddr7obPQJLGKVPKZEQWHWU90+ytXUq
	Qj2CqZbjbi/8qrUHZIMELEMX2V5MGiS7Q+EsksQKRYuB8vbJfFjQkQyWzunqThN7
	GaQb2C99Bo9tRoxD+wvSZQAOJoj75cxeM3xGHxHLVw==
X-ME-Sender: <xms:GJFdZifIn_Z2IszAyz1-UdzzYLhZWw00CwJ4QzRJcdGt-sDfDeQhOw>
    <xme:GJFdZsNexS3vLqbvxJ8Vu8qC8TSZUhIklVwCkmkcLpHwtLx5KUDvTUhQEzERUlcqg
    juIpEakV-9C6PLOxg>
X-ME-Received: <xmr:GJFdZjjjUD0MHCkcNXgGJHHNc6-jeMKyx_vlZCjIUZ7w4V3YloPak27FoflZFz9cB61FCz6LpmFUYijh5gqDdUNVa6jAJbnTcH6MXoCkz24kMQfj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GJFdZv96GBQJt-QWewq2iJM5R64dQ-CS8JY2LJJe759LwwvL38_h9g>
    <xmx:GJFdZus8RU69MRIADeC9dEvd52Q401UIJn3Lj3XubMS9JcLYmYyhaA>
    <xmx:GJFdZmGuwPsVOKeNX2NNamaCeBYSbzEG11PEWrX6xhgH9Nb6z0bXbg>
    <xmx:GJFdZtP2vp9kREYSW2mrvycitekixQooprq4idGuBWtveqx7yQridQ>
    <xmx:GJFdZjVHvg5r46x7S9rbQoB02stppoMVKtqq69QZp_FLwTHfZIUZxcVE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:47:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 31c8a8a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:46:40 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:47:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 08/29] notes: fix memory leak when pruning notes
Message-ID: <17671dc9cfbf51e091575241565fb1460a498a7b.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lPEdPRWw6GjseDa3"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--lPEdPRWw6GjseDa3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `prune_notes()` we first store the notes that are to be deleted in a
local list, and then iterate through that list to delete those notes one
by one. We never free the list though and thus leak its memory. Fix
this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 notes.c                | 7 ++++++-
 t/t3306-notes-prune.sh | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/notes.c b/notes.c
index 6a157e34ce..244b5c4b1c 100644
--- a/notes.c
+++ b/notes.c
@@ -1219,11 +1219,16 @@ void prune_notes(struct notes_tree *t, int flags)
 	for_each_note(t, 0, prune_notes_helper, &l);
=20
 	while (l) {
+		struct note_delete_list *next;
+
 		if (flags & NOTES_PRUNE_VERBOSE)
 			printf("%s\n", hash_to_hex(l->sha1));
 		if (!(flags & NOTES_PRUNE_DRYRUN))
 			remove_note(t, l->sha1);
-		l =3D l->next;
+
+		next =3D l->next;
+		free(l);
+		l =3D next;
 	}
 }
=20
diff --git a/t/t3306-notes-prune.sh b/t/t3306-notes-prune.sh
index 8f4102ff9e..b6e9f643e3 100755
--- a/t/t3306-notes-prune.sh
+++ b/t/t3306-notes-prune.sh
@@ -2,6 +2,7 @@
=20
 test_description=3D'Test git notes prune'
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success 'setup: create a few commits with notes' '
--=20
2.45.1.410.g58bac47f8e.dirty


--lPEdPRWw6GjseDa3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkRUACgkQVbJhu7ck
PpSWbQ//Q6nIiaToJrPXM6Omf+BcOi/o6liAQbJPbqejuZozhNmyzCvNJ4Uy0kXr
c8evg14LplTT7K3zYcup41IlAQ9z8eCnYIPtJsPFpIn8Ee5e6yp7ZIVSAZQlECXd
/ld8xV5KRRcNPJZijWFFALVh+Vwaxon8w8AxnrJrvfCEUvTRRxSMDUkK4FsrsFCV
gbWDMBBi5zx7DdNsBV+Y/adzrOiQAwc8f5CFE0D0YmczW0EZA3BGXLm0RBNVlpa/
qOmHYTXRi5gqa+mtDn4+Daei6hNW7UTl1adCgzcHX9bLNoRwyHoeASzfVQCmjr6L
IsezoOu1Fl75k2/HH9LKUHpfSEh7dxQn8KXGLlxmN/gwvF7wqr7mJmaRINMf8oqO
7x+EtJd1Tr8AaXo2tVahwToEa3Ymz8jKbkLfilzrcniCTpV9ZO0hwnp0ldYGWuDe
4gwQlxTEZK3MEUswdinjENEkKhEnyY2/gg3tzohfkf6Np1H6mRkSSs5KgzIrfxhl
XYqEgXm+W8EbArO9lq+47WgCdFKyh/tBXpbdGljPzdZ7ZAJpxbAQ4gxj2qK5ji0K
PSIlWczYGnTGWu6pwFlgWL4UCbCzNdm748bVY62hn1WTre0DG2SXoCMqoKi76LWs
HYTqx0f7c3GaGb/2v2Rfj0zmW8lnuBVuzIKOemyllV3fEgA09O4=
=2768
-----END PGP SIGNATURE-----

--lPEdPRWw6GjseDa3--
