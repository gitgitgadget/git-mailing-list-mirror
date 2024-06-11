Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6321B178375
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097596; cv=none; b=QeVRzH3qU1G6BawaU4qSzcQuRn6bD9JIlvyywbCus+9A+21fi5eOcxtFRr5d6KIQAVdJ2BdZuR9rzYA9TA6Bh3xC7aCn/azdkcG/SwYocOm4ca754fm05KTxmKCOx6QxBwnpnDhyNB6+P/Hd+tCUlQcx8TTZbgDKvGiGKdQyTos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097596; c=relaxed/simple;
	bh=OhOhpVgsiPiOaI2lFq9yHH4kTlMsQdz0CqQ5S6txciI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIf3YWywArgQm2ptwJZMXTwvBUrAjkUy0zAbFl9NkBt46p005gQizg3TuPs5zzObot0su4p+YJyJ6xuD/TPXkX00TdDSWZLyw9TvqRVMdHndj5Q2aagG51cVjCl2TLUewuMLPi5XE01LZFALHpG2RgiKrbhODMprgXYPLjPvTDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fD0/yG87; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hfeWoEhg; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fD0/yG87";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hfeWoEhg"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 6D9771C0010B;
	Tue, 11 Jun 2024 05:19:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 11 Jun 2024 05:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097594; x=1718183994; bh=KMyvkW3kZ1
	TcQvW4GzOagVC0xiku1yA49zm1ByIfAYI=; b=fD0/yG871vPR2bhaog8nWiv9+N
	XoxmjUis/RJpFLhq0wI7uGvT/qM8SBqAjj8hcbZPeuy0K22PhZw8TRRiU5l2dYiQ
	rina9Ok10zBM3sKF/oC+M9qFNasBOiAp8G0OqgbEiBzPzqw8lIGpgSjn2keE2Dd2
	/Nuc+tcuczkCrlXamc9A0YFUDyuh0G2CYynAuYBm/Pt8WYhXfGfWFU6Zxez/Ueul
	EXMS6/YpSqUDFb7hJ/QKG49y/GgzpQADowkSRbQSLvvMJwA1/1SuKEm8vyYx9QvI
	0swlblY/yaP3xW6ZMyrbmvldc1YlrTfSdp+RnxBKkiV9clDX37MutY1Z9q5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097594; x=1718183994; bh=KMyvkW3kZ1TcQvW4GzOagVC0xiku
	1yA49zm1ByIfAYI=; b=hfeWoEhgJ0+p4CvVZ1l5WtWvifxM3Kama1LsBy/XlqHW
	a3Aw3kpWXEDlJeRHfHJjE/2zxEMWjoQwt4JKYyFBXklqJ46OwwwUFjRihquDC3wj
	soOw/22EH081gwV6EWBn54ITXfsy2qvCN0kLAKtq/GJeKpUns8qNB4E15O8dkuf+
	JlqFwPfmTIa7c7zG7BCAvWi/nBvrPp4rrflVomGn7H6ZHcbCyZXkhCVsqul0U9nv
	dAnzuWOcJ5XOCkHJfGlQqoFGnmU9TN0bEVG0yyQ4etnMc114q3RdyHweg+fwKXE8
	JEXlSzpP3l+RzRCEYbajfdkTyjaWfMDqscIIF1H3Zw==
X-ME-Sender: <xms:uRZoZmvp7MVe4bo9x-VUTcpW12dH09o5051MTy7dubngY4KvwEx6oA>
    <xme:uRZoZregL2C7znZZ6CFgO2jjUhVpbnQLruah-L7dRi42JKPw4R4iblUcxrEz2B2y2
    J_dILbGXku94g58mg>
X-ME-Received: <xmr:uRZoZhwwwJBG-ljw1oKl-GYtvnP-Bx6RcqG3S8I2-NffhpNh3x0j4atdul5V7rwxvp8-ChGEaO2KYXBUF5uMYLrJ2pPN6dR2-mKVdH9F-gC2ETMOKkVj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:uRZoZhMQwTPpwBpz4VY2QmlP1zgwG5om9SMOSRoe2fsZhs86T3713g>
    <xmx:uRZoZm-ubAWlWbntAwgpzshcyiuD7yf8BNEqu21--5-F2emofQB1Cg>
    <xmx:uRZoZpWbOIW6ZyJp17yf8jeDpqoswXM3L2dLIvzf1wrQlnpYnFHtIQ>
    <xmx:uRZoZvet26rg4wE-E9HjrtCcll6Xye0_b4zUEzFQzvjHanLu5awmqg>
    <xmx:uhZoZtb-HkIZWtDeDsPy2llE2pGqoHrapZHBC4GMDXdUkzs6e3X1wLy2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:19:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 43e515ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:19:43 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:19:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 08/29] notes: fix memory leak when pruning notes
Message-ID: <3ea5e5c6bd2a3d85b7afe542e2a7e92676ae17ae.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3o0EIOjBaY44cSv6"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--3o0EIOjBaY44cSv6
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
2.45.2.436.gcd77e87115.dirty


--3o0EIOjBaY44cSv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFrUACgkQVbJhu7ck
PpSSUQ//Q/302PHbVY2tFqE1nTlSCIGKKwoNoUgxWH8sjBONB7og6bWqntI1Tp2C
WUNxnoLYC2tVjLOJgMsYtkrMJBO/H9XqFLwXMuveBFu/p8/IOra3SsTm/P1Zg2iF
KZkVaCqhJN5YTTk7EUVJqI8KPhOnsODifJyT0ePUqnJmBnI17n42pxLwWculBq5D
PYBZXAtTfhqWLYKBry9EgfBMtOfg11rsMb+zxR3gkjChqoeybV8Yc4OhZIS9Z46K
QZ8cEMwxrz0+R4pWvXm1osh87GxY4o3rOhBzRFXhg/psSafZK7ExLXUrVzm2V2p5
wodKUSyZp33LDoT5nn+q5Wckpz5gq221OyYkeXJdhCrMnzyE/pbCkedO8fYZDQK5
uC8iTpucrUu0CceL53/cnVe8xPeQwQbvqOxPx80lmrJ5cfEu+nfgzdfrs9zXdmNF
fNfWTZwwQ0EcX0BZkFAvaZpl9aKc0GmvqcHknYJbKX4G20enPesQJzjCPo3D+Vq0
FHvpo8jD7HkBjjtPRXS5nHiCXg1w1IWmC1ryhUUzv2TX0UDuhr+ZlV+XHWb0c00n
cig7/EVFvB+6LC+GysR/iEqc8l2b9CSTJ4pn/1SYAusohOme/FjtMfi5zQo7dtX5
Z7q6io4hFbUlpf1wFnYpZ7uv3HSq7gb/lDjS12d4wo3WzpXos7M=
=uqYP
-----END PGP SIGNATURE-----

--3o0EIOjBaY44cSv6--
