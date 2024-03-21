Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140C83CD3
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711028850; cv=none; b=qfLiOYHpxCezOa2xrpolTVE67jVJ1dXiZ2jnJmevMSu6y3AP6uTGuPVZC6Gr25K/q2iQCInp0YQP7WKlyeMgBsfGFHsQUKKX/ILcdrTCFpAIPzak590HX2lX5c9+Fv4Nyy5tr6ZvfPV4cShYXWKDdBb0FCRXbHzRzXhi7Gb0GTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711028850; c=relaxed/simple;
	bh=cFVEiQWhOlirLnuR7vMNm2ViWQghDjA1iJc2lKgFC3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bM1lwHwXrigGEPT2vUX3MM/DjryRVtaG2ApfZ3rBcNtr3fA5rC8+MhJK4Du81BF0A3Mi2tEBA3Vi2295+Z6zg25hZJQQis/1d4c/I5sM0Nh0s6DQyK14stgibbPO6cYK9jdTzeM65/5C0JKvYYPnyE096dSFA3XYqdUqcFbk47c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iQUfntBS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q3pkbf+7; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iQUfntBS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q3pkbf+7"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 756B01C000A5;
	Thu, 21 Mar 2024 09:47:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 21 Mar 2024 09:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1711028846; x=1711115246; bh=OqPxXRUdPtyN/S9msVK83EpkO1EC1mZp
	fPASgqCirTg=; b=iQUfntBSaDoHP4bFaZQLvjE3/yizPO2b9tN5yxU6UsZxVkkY
	9eKGFo7z+tmuWmjGRX+Yuo99BjfLxUx2MjuuJEM4m3La5c7HL3kQhbP8TukURHUA
	iJI4UGLGj65HrIaemN6mIaPbjpL3IbCPNJIYihkoIVyyGlwslD/B7fq50SUJLqZ0
	azF0dxWdsAvQKLzQPMdzHgLVEtcxz5LRWOWzOrd0bs/OjsbdgYo/QoAzqzV052HN
	CpXvYzLR+nn/WeshtigE9Yyq7803pXdENMTmHV2i0N7dh+3AQbuSp/PqLL1Olv1d
	izZDpqePtFQ12HdnfzXaftbM23bjbXi4moR2nA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1711028846; x=1711115246; bh=OqPxXRUdPtyN/S9msVK83EpkO1EC1mZpfPA
	SgqCirTg=; b=q3pkbf+76/Mf+bMVMDdA/3N0dBvSE7ARtXnIkEZ91vqlZQmax4C
	sjAqMfGxiuVwhL1ladhnFUJcHZkwL0KBoHN9hMU0c9nbUwdzSwyB7Eq8pKlTB22S
	ubFWnBHFRDCcOEImv8v6C8bO8h1VEqX401tSitYGF3U7Lg1LG5vUGUxUt6lz/zJo
	KF9gPn51Co3ruvNCfvfk7Zs2tHKopVDGC6uQAomXO62PoxP1DAvk6TKMmDY1QVgb
	MoisSrEUNwvX9VPe5m4yrNWK46b7dekpNwusC759hn83urzcUHYdj0NCbVXIKvJm
	PkaHHFBTf7nArlCKhv+dLzO18UGNsVPx42Q==
X-ME-Sender: <xms:bjr8ZY6M-9SjLKc6-vuFwVdw5p-Pout8Iu9JxoWgyKQu4vMr1vTG-A>
    <xme:bjr8ZZ6IQK6A0KpC_XuULYFPzz0QQUksEQP-ickep1dM-b6eGRu8JzlE9Q-RA4d24
    QADOkes-jhc_kPSwQ>
X-ME-Received: <xmr:bjr8ZXd3QBkVvhTRxGUKOOmUNEpfqWbPdiok50TdmqxfsGCDycZc5qPhqlwkGblUQtTCaI6_JRrYUKlLTLHZxblOvkTsh5DueD25ZBDrJ7hyGQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepledtveevteevhfefuddvgefgveehgeeiudeghf
    eijedtleffjefgtdevleefvdeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:bjr8ZdIzX0TNNScUvUcyBYockNfrJKkPLZAf1dbtVyV3tFKhxKtL7g>
    <xmx:bjr8ZcKA88Jgqo4jAIXhthHwRbYLQHfvXhbej1QeTLNHDvRVTwyZeQ>
    <xmx:bjr8Zey6Gjf8DTL0VisdDZoe6inaoJ_NkiXZWbSfMIgkKBRw4u6Vow>
    <xmx:bjr8ZQIwf-aB-g60IXQ7j2RZX77fgh7x5n-DZiY_IQfqk3AXa5zAag>
    <xmx:bjr8ZRH9cTiAYCy-ptCfbb_7kwPz2oE9GWXr_KgneDh4X3WBLDboHvmYELc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 09:47:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a4f3ff38 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 13:47:18 +0000 (UTC)
Date: Thu, 21 Mar 2024 14:47:20 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] t7800: fix quoting of looped test bodies
Message-ID: <cover.1711028473.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ev6UMgI6ujnk2wgC"
Content-Disposition: inline


--ev6UMgI6ujnk2wgC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

SZEDER made me aware [1] of a quoting issue with some test refactorings
in t7800 I recently introduced when refactoring the tests to run in a
loop. This patch series fixes those issues and also adds a paragraph to
"t/README" to document how this is supposed to be done properly.

Thanks!

Patrick

[1]: https://lore.kernel.org/git/20240308221229.GA1908@szeder.dev/

Patrick Steinhardt (3):
  t7800: improve test descriptions with empty arguments
  t7800: use single quotes for test bodies
  t/README: document how to loop around test cases

 t/README            | 19 +++++++++++++++++++
 t/t7800-difftool.sh | 40 ++++++++++++++++++++--------------------
 2 files changed, 39 insertions(+), 20 deletions(-)

--=20
2.44.0


--ev6UMgI6ujnk2wgC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8OmcACgkQVbJhu7ck
PpSDghAAmc+D/6K2naJ/rI+wAdjAhuPuyC1HIWTHK4ccHzLyB9VFQqU3cIPutlmP
n4b4S5RrNClsQKashkisOOs0HilXaXZKj6ATD66lMnCzOS6fV6bMJA/bid5ezRqk
aVFRTX4pqHsNJuc37+/Et53llk4Fnqp5SpVQ6tGVHOROXY/JGYjT9HWVyTfxArqP
YSiPEPt4cwtXlnE04S20OKukgFkfCISeRArFOxnVdUsOxGJUHVLcYN/nillyM+mp
fqN3XluivJhE00Es9exNGxbuOfJfihYqzA85VynEmS77e9fX9CHV/zTf3jGH3xPQ
pph0iP6ctBYyTNQB7OdYKAyHpQ/zq1LXfws8SeK3PnAeZCIihui1lsbvYSXzeZZv
u28rNkG4moGWWmkTUy5knxituMtIGPy/M5QlB0WQC3vJIqSRh6j+l4K48s5XMIzu
gcut2LMdvJmQwEm/q3ieftrZ34xuAHffAsBI/UrJGyApREI0az4imbGikTeZzHbX
vBUaCxbd2EkQ1X/uIxB+ZYQUNxfap9Hne0BX+KjXWG3q8c4+tLa5sBCoXubaShY8
uAOSaNejgHu2Bvdu7QvEIrXr/dOx4LhwSnSx+7sQhHnzEZXyqG0TJuVrmWjltV6d
UYuYFFfYU3N/mvdGgqGJm8et4nsAo9yh9Mtem1IZHXaXP8Itxok=
=lYIm
-----END PGP SIGNATURE-----

--ev6UMgI6ujnk2wgC--
