Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607DF179AE
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085928; cv=none; b=LcQA5bNll1RzRT/pbcHHljR75XE8L1XHtxfAWJ59RtXQn7/Mmjf+F6Wc1nOybMPd1grcXpo8IuNttZsCphGgC/EboOF2AEyqrU/bxrxEs6st0Cnc4HeKFWFlxf/y/MJufLsjaq2hVbTZhL9xf3c0o3fCjRujyyZ4srKanKSaaMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085928; c=relaxed/simple;
	bh=a0tVLvUtwSccFMb8l8rQ7S6RbEmcje+68eVUSUxvvLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezI6zEDV0+/gp3DZaGW9YiINjBo6z+iURA/WxtzuxE3m3oXERQ1AfJnNyHQCTvv/bQIxxBJxaRqWB8JSAX8FHqHusmFMJ28ti0wuf7zOqr4C9r/8AXsEAqASYuIxsC30LmmxSH80v6mCs2vrDNinMvrLPbM4SXqsus6pMpNHlag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=n2eJVIhg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Z+226RYL; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="n2eJVIhg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Z+226RYL"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 1AA213200B0F;
	Wed, 24 Jan 2024 03:45:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 24 Jan 2024 03:45:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706085925; x=1706172325; bh=JyKQhLzkkU
	nYfRIeexj7pOoilWsMmqIoJlA7eOvWGk8=; b=n2eJVIhgUlUXOqx+B7EiVV02/5
	5yDPRKJpJ0MwV/SwmI05aT/Q7bwlI1l62HtWWJKjF2U7+JWmFwW48GRqnzCicry2
	FZza4x4BQpstmCo/qrg/gveAxWgIeGbVIzlXYTQ7RKYjVCBZ15CS1WKJETZL/GC1
	gHAkYHpo2NOaIkmnw+bfiTY3J9k0ivtgd9r/pYdqD1jc6V6S+m36J8tOnGzuPKj6
	Fb2/mkhXzBSr02nmr6VkyOihYEhRSuOZWX5Id07XaRNH0xYWNSKu9QbKAi/Hdxzf
	PHRbHuwyf4pDw21IiBlVW2lyJh1EBKCyRjQsGawiiZeX+2maNsXJ1mePPytg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706085925; x=1706172325; bh=JyKQhLzkkUnYfRIeexj7pOoilWsM
	mqIoJlA7eOvWGk8=; b=Z+226RYLTBe31xBXEhtcTAmMF+gxvU0Jz0/dY21/jq/8
	9dpECweCVKkneifRvjvljuT9Krj7ure/LVDMpqsOUY2aawO3Yrdv5am6vTajGIKT
	laF1Bdb16uWn5Fpun9jZIx8bI6EC3xPQPhOLDCN+4A+awcBYU2z55CbFnSQ7QF07
	fgracYs28FZE1wW21gujMlSBMvDWwZTXN2KfM2Bzto5lOwkBeOojlEHMDNB/0GVQ
	YhG3wa3NELVqOU47MV6jz+Rtss2r/zcBtZdVQoh8vcDwEr3qIVLHHbcslx7LsBKc
	ZwchhP3VmIOptGvrUD3V175cMT8h/7zmJJXNwThe5w==
X-ME-Sender: <xms:Jc6wZYxrsjKftsISSHV5vEQEKXtsvIBjrc338LVnZz0a_ryAdcUU3Q>
    <xme:Jc6wZcSunbe8lGyyNbPdEO6LqgH3aufgUDGiAiO-ardAmhzNMhsW18KphuSwWYL4T
    VjXEB3wmf5i4jCySQ>
X-ME-Received: <xmr:Jc6wZaXZN-UwIf5gcR5cntZ0sSJ4NCTXY_R7bnrATsKpycxSq3faFEcJAu9RM__nfL7tAKk0Q6LxqUH-VbTgk81T7NgDq5-2yXVlrXwColvUEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeltddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:Jc6wZWhVUcUdi6MI000xEpz7sbZfEAnkWl190vOA-F9eIU9guR_7Ww>
    <xmx:Jc6wZaCRgD47Og3CDtTLBQDrbUI33L8rQRtK8EcTG14LzGIURIgnMQ>
    <xmx:Jc6wZXJd-p-jgtrbhdGjZczgOodDEYvU_HZE4QuIqBb9AN7cFOKDxw>
    <xmx:Jc6wZd8nocwHkJ0_qYX7wsqq9Sus03bGZztVqW0TjuiySfEu0xqnLA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jan 2024 03:45:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id df5013da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jan 2024 08:42:18 +0000 (UTC)
Date: Wed, 24 Jan 2024 09:45:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 5/6] t5526: break test submodule differently
Message-ID: <066c297189f6e09ee9f0defa9998932d8072c854.1706085756.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1706085756.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TWWdgXiyXN/JoSF2"
Content-Disposition: inline
In-Reply-To: <cover.1706085756.git.ps@pks.im>


--TWWdgXiyXN/JoSF2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 10f5c52656 (submodule: avoid auto-discovery in
prepare_submodule_repo_env(), 2016-09-01) we fixed a bug when doing a
recursive fetch with submodule in the case where the submodule is broken
due to whatever reason. The test to exercise that the fix works breaks
the submodule by deleting its `HEAD` reference, which will cause us to
not detect the directory as a Git repository.

While this is perfectly fine in theory, this way of breaking the repo
becomes problematic with the current efforts to introduce another refdb
backend into Git. The new reftable backend has a stub HEAD file that
always contains "ref: refs/heads/.invalid" so that tools continue to be
able to detect such a repository. But as the reftable backend will never
delete this file even when asked to delete `HEAD` the current way to
delete the `HEAD` reference will stop working.

Adapt the code to instead delete the objects database. Going back with
this new way to cause breakage confirms that it triggers the infinite
recursion just the same, and there are no equivalent ongoing efforts to
replace the object database with an alternate backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5526-fetch-submodules.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 7ab220fa31..5e566205ba 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -771,7 +771,7 @@ test_expect_success 'fetching submodule into a broken r=
epository' '
 	git -C dst fetch --recurse-submodules &&
=20
 	# Break the receiving submodule
-	test-tool -C dst/sub ref-store main delete-refs REF_NO_DEREF msg HEAD &&
+	rm -r dst/sub/.git/objects &&
=20
 	# NOTE: without the fix the following tests will recurse forever!
 	# They should terminate with an error.
--=20
2.43.GIT


--TWWdgXiyXN/JoSF2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWwziEACgkQVbJhu7ck
PpSW/g//Vwc6efixK1D8rOgUZtsfbd3BjA6y0+6cMl2xAVSVkv67rhBmVHHx5MxL
Pla7w3FNl4B5F+8mTebX4sbxENcdIQocUaZRP9yd9U4h3+APYYB9iUmaqy1n7cOe
2RChZU4q57TGFjbxAGzekJMBPHt688FVWzyefC+qIqpcDY9weDJARm39/aaqHS1Z
BBoXfOPCCiBdIkm8cdV6c+3s9pjgzEmfEEa88r0t6rzEXQXzesteYXyHcKsDpKIT
ClUZqbkbN7HWpf7saMe9BhxDzpLWiI5wnyUFJTkTWS0+lcgrW2lVOO8hRUJZAoc6
Ev8lb4Szj2p5C7vW59DI/CD61OmoJaO1zZwtJ8HQ64ue0EotyPG3tB96aOxSUVlU
kREz331hxw1DrM5ptmKxagMecovIdA655WijN0om+lBcGarKGUct6qjkHepalj9Z
EQLNjWQmVenn9t0NnGG3AgGzE9ThkV5rIL4pjU7pziQ+glSzqzzmNBxSQ4P1tXQR
Bv+kEwpD7TFFXPFYvDQ97F/bLxcyjElDJhrG5XjEw1uTnMXQKewZ8ldA7LCJeKCo
6RATi0em8/YmWf1FEnMPaHon/dPeWLBcC8dyGnflmU4XhV3tHjUmIkBkxiK3uqyX
uEwMKw+OHA1Z0ZzJ9gPf4XvFG4B+UiMF/15Wqs8Iw8DjoXdChzU=
=4EqR
-----END PGP SIGNATURE-----

--TWWdgXiyXN/JoSF2--
