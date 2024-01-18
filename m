Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3992555C
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705585313; cv=none; b=kBUfHWODiJHLP5+sdZx7JTcZYfnzJa/pDJfLHP9wueJUDXpyWN4/QJrBzIOXOBfRr4yC2qzkR1W5djAzxOx2QsAtYK4q10EPUEYe6KiHFj64AAlDJhhQF4XDzwKzGCf0DnOGFDoF+6TyXGK8ZSRE/uoA/nOjRudZEK17B8zWUpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705585313; c=relaxed/simple;
	bh=i2/BISPmXju6k1/woeGE/iaBvlLObTW6qA3u/jypkyc=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=lARSm7xG/EtN1wT0uBQhBRPTkvhUC92P73WfWqyFjUHSPbtaRyf/F1sV8fZKyKqK7/RCMJlHeh7zcWbNTYUNuZvBPr63C7MbUm3VI3fJDW8wjD8rXPmfco/vjvnACMzqs1wrPWHTKYwoR6no/nDhi4ll7vD+M9vX/PnrNcMjlT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BuYCDuK1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AydqQqL8; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BuYCDuK1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AydqQqL8"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 8868C3200A89
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 08:41:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Thu, 18 Jan 2024 08:41:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1705585310; x=1705671710; bh=qXZLIegpfrEq324H8XmE3R4RlqMTmE1t
	ZngpoJDzWXA=; b=BuYCDuK1MKEEBWpZmPqszVEvdyPuX4sygM68t4nCTbxN8Yct
	vzCxHlk3GSWitbgVcbiGcpeaw1Zsi4cnUh8AqEwVkvtylchAYjk7ss0HqlGt+ZKQ
	n+0U0sYwBd4DHgkGHgY2K/6XUaxLPw04whELpZua5lZsjirlpICbtOHCJth0vu4a
	+2TIqT40x15gHPFJ/eQz2w7wIdK9ghBoUiUELqgIjvPNmhN8wXRm4zojpiJ3llbq
	DhldoeJKiu6pPMu8/NouC9KbvcuQAP/kvNnYPemFTqymNn3ucsEnfzSB3EHXOS6c
	4gb2sbNh/vcLf0SrXrBgET/nbu00JmOP8/iydQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1705585310; x=1705671710; bh=qXZLIegpfrEq324H8XmE3R4RlqMTmE1tZng
	poJDzWXA=; b=AydqQqL8SzAFvYDquL6Oi1L41xdP8U+Yyc5g6lQfosy0AV19HDp
	RieLt6ez5xCza+xU3HcYFzNEji05rxcNITKZuLnBJfnhcXUAgS0fjdnDVJeK4Der
	FcsHI7FOEFZ2WdP8yVaOtOTM2KqOb7ZuC8qF+sFoZyVCklGi8lNyZedvf+C5IwDd
	GsxM6wj8TNMSEis5jTOelBPMAEG6iG3oCuqSi5CxG7Ge5OPklmR1YOtchKV//dWs
	s2BV9IS8gt30W8FvYUXqxPNgwCooIyqGXwhMv0e8c7PmTxEgZebKdc0/OSIPjMc8
	E1mCQRJOjGk8e3QvFuABbXF5AVtPd+yk+wg==
X-ME-Sender: <xms:nSqpZa9jpV2E_7CcdLL1UrnArTg3euzuFHiWQCTuD_2oRcXtDbW_7g>
    <xme:nSqpZavHRGYnu0sTIjKCOAMnWsFXSfsvlvt0VUQbuAG7_TgvY5_96gfZv5bzDQIKR
    9SJOstmo1OW8coJng>
X-ME-Received: <xmr:nSqpZQD-sKlKBaZ69ypEcz0xI-nUZsrMRuS9NB4WYl3dMYUto1Y5bgaRa2VM8GzPNk-RY9Jc-zR8klNoEhtaWUZyuWfD0q0vQ9h4zKLvEYJF60A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:nSqpZSeSc7FdYKCK_SwqujAn-APBwxnCcSNAZo7PpI3nLDdkEmytmg>
    <xmx:nSqpZfMIvC1PG5TM9rCsPjZ23NlD50YknClWPEEqOlaVBG0glTkojA>
    <xmx:nSqpZcm9BOQyB03ITajxhTGpFtHt8TN1-aLeQ56gsZzzA46ZGrZVkg>
    <xmx:niqpZeYkXGfRoVHGxee7ZQrXuufwNKvd-xXOVJUZ-v_2WoD0QxUiig>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 18 Jan 2024 08:41:49 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1e351bc1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 18 Jan 2024 13:38:52 +0000 (UTC)
Date: Thu, 18 Jan 2024 14:41:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 0/2] reftable/stack: fix race in up-to-date check
Message-ID: <cover.1705585037.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OiitEmoLqVwjAwxQ"
Content-Disposition: inline


--OiitEmoLqVwjAwxQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

In 6fdfaf15 (reftable/stack: use stat info to avoid re-reading stack
list, 2024-01-11) we have introduced a new mechanism to avoid re-reading
the table list in case stat(3P) figures out that the stack didn't change
since the last time we read it.

Unfortunately, I've been able to hit a bug there that can happen under
very specific circumstances when a reading and writing process race with
each other. When the writer appends to the stack and then compacts it,
it may happen that we recycle the previously-used inode of "tables.list"
so that the resulting `struct stat` exactly matches the cached value of
the reading process.

The first patch is merely cosmetic, whereas the second patch fixes the
described race. The topic depends on ps/reftable-optimize-io, which has
introduced the issue.

Patrick

Patrick Steinhardt (2):
  reftable/stack: unconditionally reload stack after commit
  reftable/stack: fix race in up-to-date check

 reftable/stack.c  | 101 ++++++++++++++++++++++++++++++++++++++++++----
 reftable/stack.h  |   4 +-
 reftable/system.h |   1 -
 3 files changed, 96 insertions(+), 10 deletions(-)


base-commit: 718a93ecc06ed59dda4e6a5d91b1c2169275694f
--=20
2.43.GIT


--OiitEmoLqVwjAwxQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWpKpkACgkQVbJhu7ck
PpTQwQ/+M0za5CKErN2BuyqM34axTFnzZoS5+cU7gszwOlarE9eAekpaVAnPdlSk
VzzTw1jsbaIZF1GNZ7YDgpkm8ebULIgD7A1r5L3Fp/bVXr/Hslec0PVweZIURfSM
pjX+i/6WKleDVRrha3rsyVFBTz73cUPV9fha5ZUrvTsrN+Rdon7IxT15r3PHigON
xB4+S1rAzF1Nje3SHC/BT0MVjPeFWD6lvyWil8Fezi4bwKUV/ghTRU33QrdftibW
zmxFXwMxJd+Yz5Ivc+O3Z8WwDUWtg2YPZznhG/ssEGaba7XU3YfZ2f6lqwFKDmJn
ULIhpw1Gc1uFsEXwkBA/2zDJpd+X0wc7VSVKCUu+g8yj6dztDtmIHdJE9guxEDwd
fNbg65Hqo66j/zdZ7VMshjs8F3u3SYVT67/NBNN2VqtR8aqEY9HvlSibPrv/J7YD
IFgARf+mD9gt8pR63jffJ0pxbZKQor9s8zP0iUHpfxWAUHl0jQRrXq1eUqUClQCy
mvwD5P04yBFI8mwVqKCwn/cXpPKRqBSnWKWNFulrxgecsLrvbyRY9eyTaHbagnaW
D0r9zZ7hjPORvDOWJxJ9pnC+QERTkvBf8eBVlpLJAVE4vSylAMIEf/Vbh3G5GcqJ
SUaX6auPLP+kHBiGaEpip0ssqR3T2IDScLysarODss2igYKJtMg=
=V2DK
-----END PGP SIGNATURE-----

--OiitEmoLqVwjAwxQ--
