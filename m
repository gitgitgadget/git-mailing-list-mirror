Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB361176FB6
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 09:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718097668; cv=none; b=PZODM7Flnqh9a1czK2pOfCrAACzGfBJB3STtUzCqR5WJVcNFbfvm39+FB3n9WWIcbDnQVqO1+2OWnKvhQLWbQydXWo2QlqMRdMp7OnbcbYRBPtYNoVZ2kNiKCH5QvTfu19nAN+mAeASI3XVW7r/di4XGNygB9ET7ek+gFmCXWBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718097668; c=relaxed/simple;
	bh=VGfVvlDUNbpeGIzT+25pAEFkmITqSPqrw2zQPKZ61bw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mOtv7wiHc1b+e5xUq3bI46mBWYAlqPBeIPaP+1FdI3vTBdiUDodVeI50jTJ25dIvKFYMELBHzoycyCSeMcXREfh6qoh2pp7cepgLPLY/EA4+1Ej4P2h5Zb+oiS0MJVYmaE83nUw04s0jz8LRcdX4+TRaNBAthKXcB/y6/Qeyz5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BCS/D7Qz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MdtGYC3e; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BCS/D7Qz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MdtGYC3e"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id 581AB1800071;
	Tue, 11 Jun 2024 05:21:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 11 Jun 2024 05:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718097665; x=1718184065; bh=F8RCdAmtal
	imrsN2lnMf3zLM/H4xK7LmugPTeD2n+2w=; b=BCS/D7QzvwusSbGX5opfN/9rie
	tabcD7OWxdyKeKqCVHkZKYKqq5nQClNvv2KeIiP3JkW2/CeBtKoxesNC8Ywiq4qA
	8C8K9HDfw5wVUd908PA0FoHu5LxZxwAPnrMEeZr6VutvulIVAtyqEqaSGN50oRX8
	AHcSEttSyE7+mRKAz2FvR1yvucZuNEM5voKJQWxZ4fuzwMZKn1g34shN0R19NFrP
	DaYRK37OgdqBjPP09d8mG80gCHxBPgloJ4rM0WW4aGbr1OQmn0uKjSzuAquCtlo5
	l3sS6bjsvRsuVCLJKh9Kc9td6MkfKW03GpgzGsnP+16oT7MMCMtpDSFR/sPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718097665; x=1718184065; bh=F8RCdAmtalimrsN2lnMf3zLM/H4x
	K7LmugPTeD2n+2w=; b=MdtGYC3eAN0sfKi88bGlbQkBCHKlgUHB9ZMZZt+oEM01
	9N4pVLVdz66kFGO13gfDd42tXfXqEmJZefWach7P3Ytkr9YkO/WaW7zc8uYawpNG
	wJG+u1cNy4+uvNFhz8tNBH9jsjResxa6m8sfmHLU3ZHa8c/rSSz4OXuwmMSNY1KH
	2qcHVbDa1kxtXvJu75jItnLuZfiV7SMl/z5o5jO8Trnkwi6MsQngzqsXKxYyBBCy
	J0+vHDB4bAyImCvOKVDOJ97YqDoYEBKrJi7DrbYjz3bg02WLmo6c86KGocUoJs3/
	j9b9bCB2MNREQUNbHwNmBMECnKc3hqdNEdjNWLODTw==
X-ME-Sender: <xms:ARdoZkvOzbqfhJt_lyQXiqZY2X4fGpWice74vW7Q9raA9UH_3s_yBw>
    <xme:ARdoZhdUEvDCGEw3jJUKtVjrUveDflmLyPXPIzfEIjhKUx6vyr630QV7cP8WZ7p6R
    teVuMyCxIJgA2Dttw>
X-ME-Received: <xmr:ARdoZvzP7h3OTVviq-MgbHojSsULVbY1G-GGvs8VLh7X0fZbczoXLkJtJXdbie7y8Z7S4WBo5_KcmAuSMOaCPcmUijNpe2n6Ax8LVX4mMKQ0A12vvPM0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddgudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ARdoZnNivtZJjrZzIpJkv3aYhQ6k_ZV8EPYF5aUZM4gRHrQ5I3XUPA>
    <xmx:ARdoZk8ByzM0lUQ6Hr7sBFDJcJP6Q21Jw0of7xf6iIPGxTVaDLIilQ>
    <xmx:ARdoZvUkV6ioAKOedQaPT5hIgYtWBBjWJvBJHe89-Z7NzlKHUMV36g>
    <xmx:ARdoZtdryPJn4My6ml5pGkjYyht5PcAlC_bP4JtVotz6kwcCfW48Bw>
    <xmx:ARdoZjZUQTu-b9FM2488ayfvhs5ZFAqH-1idBcIMUuOt76SuN6U2e5zm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jun 2024 05:21:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4f778b25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 11 Jun 2024 09:20:55 +0000 (UTC)
Date: Tue, 11 Jun 2024 11:21:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 23/29] sequencer: fix memory leaks in
 `make_script_with_merges()`
Message-ID: <1cdd988c4521bd79a1303b6d455cb5a66680e45a.1718095906.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
 <cover.1718095906.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LRlGebfz4jGntCdI"
Content-Disposition: inline
In-Reply-To: <cover.1718095906.git.ps@pks.im>


--LRlGebfz4jGntCdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Fix some trivial memory leaks in `make_script_with_merges()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sequencer.c                       | 3 +++
 t/t3418-rebase-continue.sh        | 1 +
 t/t3421-rebase-topology-linear.sh | 2 ++
 t/t3434-rebase-i18n.sh            | 1 +
 4 files changed, 7 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index c581061b6d..20807ea7e5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -5951,6 +5951,9 @@ static int make_script_with_merges(struct pretty_prin=
t_context *pp,
 	strbuf_release(&oneline);
 	strbuf_release(&buf);
=20
+	oidset_clear(&interesting);
+	oidset_clear(&child_seen);
+	oidset_clear(&shown);
 	oidmap_free(&commit2todo, 1);
 	oidmap_free(&state.commit2label, 1);
 	hashmap_clear_and_free(&state.labels, struct labels_entry, entry);
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 127216f722..c0d29c2154 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -5,6 +5,7 @@ test_description=3D'git rebase --continue tests'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 . "$TEST_DIRECTORY"/lib-rebase.sh
diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-li=
near.sh
index 62d86d557d..737af80bb3 100755
--- a/t/t3421-rebase-topology-linear.sh
+++ b/t/t3421-rebase-topology-linear.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'basic rebase topology tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-rebase.sh
=20
diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
index a4e482d2cd..26a48d6b10 100755
--- a/t/t3434-rebase-i18n.sh
+++ b/t/t3434-rebase-i18n.sh
@@ -17,6 +17,7 @@ Initial setup:
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 compare_msg () {
--=20
2.45.2.436.gcd77e87115.dirty


--LRlGebfz4jGntCdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoFv0ACgkQVbJhu7ck
PpTdBQ//V9MOVe/NtpGoKDORJAtLk0mB7RFZLj5RhqGD5nnHm9mJPaWmvCMh2tA4
+CAW+Oq9WpC3U0XGs+vqTt3EB5CkpXg2nd3CmVLnvntGQ99kVYpyNjp2FL2ImPtw
tkytgkViNrRbi8IPx408LavfI8k59/Q5ci+ZRa0ZcHoJS9pKJRK0oHHu8I1NQig5
Yx5bJMwrrD3WSSzURohtKouIIQUpWFNCqbGoe4WEWn3Z46EOQ7OvXpL7Pnzie52c
5nJSRlUZjVgeupjREEEFkdD93XEe5rrVPwUkcL3DkrLfZa68Ept+5ZbIoVfR/SxF
8KPVCMdQn/OEaiW5bM3GpHv6RTIDQ1v4lf2J9SeisU6+nd/dxR3jM24g+OgFWq+w
mUvtzyh+2WPX9UVKYOMSlhN7A5qNULZPxBROGBe+T/nxHAtt9xa/ncs/A6xHaCkm
gUi7Uo1CBwAXBNXqnQ9TQqK/djlCEBzprG7zCLWcQ7h+U1H4R9gH2WulSwP3evgy
91Mr9vvMwmsGsQpM0gV49BxYwwFb/V0Dcd4JPnrUh9KKpTMwym9emSRHgl7idqkb
TUhtfwlruXe1cayjty2f3lmKjwMerRseCp+av/l/YkSvUUD9reMxBjB2PIpU6pFR
lI8jQJjtHQ16cHDt82tO/huCkQy3YHBz6SanZXqFbGIs47E/rfo=
=A+Gj
-----END PGP SIGNATURE-----

--LRlGebfz4jGntCdI--
