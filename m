Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA3B7657D4
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 07:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463416; cv=none; b=V1LMVU3zyRWcdBz+brqhiPblvuWVKY8P5N1qAQfA5KvP1JTJ+o663n+Q3knmcjCkN8lKsjRGQ+f29zkBidKLx1J7I4p3uw7PFcaoYx9iY8YF4PJDoHYkiNm0yyjBG30bTatdXO6cwUbSisyd7vSPUXo5aH+f0JFyRjsxQMpWCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463416; c=relaxed/simple;
	bh=aCrJT8+1h5zY5QrgyUoBEKL/glZvvnUP6gFT6klsKJI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwpRIKUugWQ4ealThpgqiCWhnARx95228nfCwwUxc2DB+8eacgB34Fe1NFYhraRTCOqQJD5lgKuqXeq0jop1dRuFTA3YQS6vF71L1SKoxlYDbqnNAIpKgRB6iF6KE9efpUTFBGEvPivNvjsYWnFsEs8qVlz1GMdJYVC1bfIGq/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BzW71cEm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WGXrekFd; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BzW71cEm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WGXrekFd"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 1892B1C00090
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 02:23:34 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 09 Feb 2024 02:23:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707463413; x=1707549813; bh=y5nKa4n7m8
	Y9Drmb9oYWsqB6dpAQ9Q2FZrXcxXokAHM=; b=BzW71cEmIkZTLMokDnEYPUo/kv
	ubXpBCSXightWfCRysU6HfOClLB+wVa3QV2u5kWAb62a5n0cW497DkuHIUMtqWa4
	5UaXP19Tvp5wGOvOQfPmuBBJh26GUTmLAaVlJYLVDWFZ+u8QN6fvYlUh7wW9zzTb
	V6wsApWo5MZ8DyoIXqDy6XyDTSiWyOCoYdLVL5W848ojE3ze5QK+urOzvlMSM+7b
	S+JgdROr71SXl+znQSXYYn+pJVOXgzV6hEsWvnr8MSHDkq3ZMSrz1pS62DCQRQQq
	nFdCU7takYwUGvGu3IpK+rCq6xGj/n42fML6wTYuPyp82P2qwCjQVu1dY4Kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707463413; x=1707549813; bh=y5nKa4n7m8Y9Drmb9oYWsqB6dpAQ
	9Q2FZrXcxXokAHM=; b=WGXrekFdDAPpMKzSRhCt/vVEImqyikZNWl509VkVD2CF
	qZCtuRWfM4iUJNkJ5FXSFxfh8etCspcKkiBtQV+vhKQlUWsI8Kdh1aRYea2fCgCC
	PEhSTCyIbLNnswjteektiTBkj50fhB3UONrgeXWyRBc4g4czdwun0boPb5MxzXti
	FHDgOV5sJqBcHAz6nrF5U1319DXqDPbZ5NuzPlNOY3qG9g0HRVcBaF+RbC5g7oX7
	o/IgslCCSpHskpcplMVY1Q+ka2sf4Cr4oaphIcTBgW4O1c3eekU1RIRx7guVoazp
	/3AK2yC4XA/BvakFtm6rWVUAysBSaW9xt1g+O4mfeg==
X-ME-Sender: <xms:9dLFZZl6AjwP7RTkQ16tda7feHB17LbK9fhMSbmzMcGBF0LQIqZFFw>
    <xme:9dLFZU3FNcIVJQWcrarQDkb_9A7TveuHd61jYmfbFzEv5KRi3mqM08rWLBLlGHjr2
    dPJToYcxRFpi41EpQ>
X-ME-Received: <xmr:9dLFZfqHhKCbgGROeJB9d-N4wMQBIV2mzh20c8TtQ_XwyBVqUbgvjys4AS--X7BxoHCjRFUobI0HzRrA-CNeBv7akirI25LLOpauKWPk2u0B6Ko>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdehgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:9dLFZZnt89XoXkdqFKzp5-ympals85MhLyDoq1zFxChCLVaYSrBXVg>
    <xmx:9dLFZX1kozOOejyb-FBQ6HNlgRLbW0w7DA3m8H2D3bdvZdPgfOmUeA>
    <xmx:9dLFZYuz_FJvO65ZneZK8Iw9JpUMBW1-cQSJCAgsocFR57skAtkAbg>
    <xmx:9dLFZQ-zd44BTdC_QAauSkEONQIgBcU_q_n_02RrjqZol5Bn_HXaPvEZ508>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 9 Feb 2024 02:23:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6302ab74 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 9 Feb 2024 07:19:56 +0000 (UTC)
Date: Fri, 9 Feb 2024 08:23:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 6/7] t2011: exercise D/F conflicts with HEAD with the
 reftable backend
Message-ID: <64d2548bbc47c4131aaf1684e6df2185034ba447.1707463221.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jodFI4meZsi//YXe"
Content-Disposition: inline
In-Reply-To: <cover.1707463221.git.ps@pks.im>


--jodFI4meZsi//YXe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Some of the tests in t2011 exercise whether it is possible to move away
=66rom a symbolic HEAD ref whose target ref has a directory-file conflict
with another, preexisting ref. These tests don't use git-symbolic-ref(1)
but manually write HEAD. This is supposedly done to avoid using logic
that we're about to exercise, but it makes it impossible to verify
whether the logic also works for ref backends other than "files".

Refactor the code to use git-symbolic-ref(1) instead so that the tests
work with the "reftable" backend, as well. We already have lots of tests
in t1404 that ensure that both git-update-ref(1) and git-symbolic-ref(1)
work in such a scenario, so it should be safe to rely on it here.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t2011-checkout-invalid-head.sh | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-he=
ad.sh
index 3c8135831b..04f53b1ea1 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -29,36 +29,33 @@ test_expect_success REFFILES 'checkout notices failure =
to lock HEAD' '
 	test_must_fail git checkout -b other
 '
=20
-test_expect_success REFFILES 'create ref directory/file conflict scenario'=
 '
+test_expect_success 'create ref directory/file conflict scenario' '
 	git update-ref refs/heads/outer/inner main &&
-
-	# do not rely on symbolic-ref to get a known state,
-	# as it may use the same code we are testing
 	reset_to_df () {
-		echo "ref: refs/heads/outer" >.git/HEAD
+		git symbolic-ref HEAD refs/heads/outer
 	}
 '
=20
-test_expect_success REFFILES 'checkout away from d/f HEAD (unpacked, to br=
anch)' '
+test_expect_success 'checkout away from d/f HEAD (unpacked, to branch)' '
 	reset_to_df &&
 	git checkout main
 '
=20
-test_expect_success REFFILES 'checkout away from d/f HEAD (unpacked, to de=
tached)' '
+test_expect_success 'checkout away from d/f HEAD (unpacked, to detached)' '
 	reset_to_df &&
 	git checkout --detach main
 '
=20
-test_expect_success REFFILES 'pack refs' '
+test_expect_success 'pack refs' '
 	git pack-refs --all --prune
 '
=20
-test_expect_success REFFILES 'checkout away from d/f HEAD (packed, to bran=
ch)' '
+test_expect_success 'checkout away from d/f HEAD (packed, to branch)' '
 	reset_to_df &&
 	git checkout main
 '
=20
-test_expect_success REFFILES 'checkout away from d/f HEAD (packed, to deta=
ched)' '
+test_expect_success 'checkout away from d/f HEAD (packed, to detached)' '
 	reset_to_df &&
 	git checkout --detach main
 '
--=20
2.43.GIT


--jodFI4meZsi//YXe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXF0vEACgkQVbJhu7ck
PpTHnQ//UjAaRY3+ahVYucR8TPpxwKNgTlyQw89DWrgNJZQ/qK8BOsgvQCMW5l/S
HAJ5WLuDNTO+cOuddqqfg14+RLprHmngtyyDagNbQkVV3Dmx1mc3GY/0SXJ+Vw6A
luQHaq2pnObWJIzjAdOGdekGWeT6++88pnwAgr4WGW57J9/w/lXpPfn+/grPPDoX
6sdkcieowgfyX6dexKOulXL2Dj3DI8e4AnI8GtyXoxSW1sQ4Oaa6P+QuOW+Gdzy2
81Mkzb9fJz5OxMRcCpxVqcbLN+GMPsNYUo4nRT64UcByKR5B8NaAfaxhzS3sZfGE
6qVC47yW7FU1d7Vgqss4yXdxxPDTRJNSTcrFDyJ63R0J8GT65jRR0rDNISzg1Wih
9/y3BDQfPf5jWvSIwlloezKeWfld+gDCgZFItQrODThmRrlXbwTV5OMR7FJphbjw
orEPKNf0tQjaOP2SDi/HotG3QBp49+dJfgODTUbFHb2+JitHT+FV+i7YqXNCSK9V
/RjoYWVZwkJlKsxhlRou/H07WTDYjIZKKRISqil7sT5BL7axqofjZ0p7GyegcmXD
61cABzqQsJqT65iV4kXg+Ksar2Mdfmjtgv6VjoKgtx+Pb8gjMKkvOOWXEMyAF4Mg
CSuaaY72YDbum7K9jxPQxo30avEqGcmmSHIqHW52enRHD5XH11A=
=L0gc
-----END PGP SIGNATURE-----

--jodFI4meZsi//YXe--
