Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092CA495CC
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717406914; cv=none; b=Sw6HBMXhbf3l58yY5jsTGGxpNomqCGLkCeU7Xa44Rn3eDQ9SJQq4MKa+pyvsVcAw66ODJ8cnHlTavbJsrCyJddAHsSQZ16Sb5rAK9lKp+FFatoOQtJ2PGRLIXhYFeUWaXoti00Nj4prZrCyrNvOr4Kl45bxtHaYZcZMAxPRaRFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717406914; c=relaxed/simple;
	bh=clkeZ+jXo8/3PMqtm6waPDvoZCn/lJsbiDKdQOkD4mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6vDfvoXhs2tyJ3A0uxFVDoixeNmfCkcN8cy6b0XRW037YywkuP0Y8otSq4c//u+/IejPtdkW+0bUYS64ARGwcYCBm8cgb//ljziXCdMNDM4PQjkSqYIlIxpKvBTZYtYyRa85ajhflc/zllGJtHUX8zF9T8/kQEalVeA7yftPk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z4aTUHm5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PWLtxhsL; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z4aTUHm5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PWLtxhsL"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id C51771C000F1;
	Mon,  3 Jun 2024 05:28:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 03 Jun 2024 05:28:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717406911; x=1717493311; bh=MP46eDlRxP
	yZcJpX1KNntWtdLU1JWblH+0pypi35fdE=; b=Z4aTUHm52N4xSWadFjykmgb/m8
	Z122j+5vlqtXw/mJb9/u6IOATgbsGSseXnGHqOb5RaaCMjyKBAF+FPVCYvK6doTL
	PKVR5NLjTS0ggPbZygnUiEK/h6rrXWXq+Z5LOKzXecZ620hMWjl1KNix8ovOSUhJ
	aaFuswYG9IgUOSFL9ULAsX+hDLfvhAFfYIZ8I1nReJw+H7KgiODQw/+pBJGyQU41
	Jmi81ErZygC1wcBjFWNP2t41O6hnG6Xamz/hA7wMhpYo5g+ytof3SHg7ypEKNFii
	niNOTWxoweoy3lCpY7KwCUiHFKLvPRJbtHkUA3maHzq9ndpuHBkwzwmtfiew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717406911; x=1717493311; bh=MP46eDlRxPyZcJpX1KNntWtdLU1J
	WblH+0pypi35fdE=; b=PWLtxhsLUyUAq+Lt+y5b2BzZmLiz57p6VEwmeJIT3XoF
	LKgB4rfyZUkoYsGvEyUHA4+gs1S2P++n2YZm97O5KlvwjT2qMhiLibC+kuGcVbbe
	1VxCBgk/IDzI+S+p/lGiW9LwJn1UTkappTdp9MBrc5gvLUYbMHFkD3S2GGI2MOdm
	RlxVXi9Rtvb3GzHq1KIJBNimIl2jiH0HnNNcRf7Mjpw7LAjgjfHNHeRxeB/sdzH+
	19cEz7LHOFCjo6ogEbnDO9h3qMKJXaZH0iFioUaKbJ/CDmaylvgUQN8WX7GyB2lE
	H52FhF+Sd8CvH6OZCLXD9unXTxNTDdQMWYXkdyvMoQ==
X-ME-Sender: <xms:v4xdZnlRnKIFzSZBugD1n5JMx3_wdqiJliQb20x0j9a26-_JgXENMA>
    <xme:v4xdZq2CQ__fVzbzWOZ5onWPu1pUBDHUHxCNJ8n_E_5DP43v75c1hXniBVJBJ9CwV
    Zg-9Amc2sQKt7_hYw>
X-ME-Received: <xmr:v4xdZtppAsyndlrP6aAiBtWba2WAdQZiFadmQSoBUdYvG2e7EetjEdGyybZhLnrg0xILHMKE9wMwkqlBVDCvyz-fx8iq-i6H8ZlW2wmB4wuMOGXi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:v4xdZvlZ_O0HA96mdOj7fafz-qIgrqXlYqGq-kcHvww3G8oZ5P6UCA>
    <xmx:v4xdZl3JFyn3dWdAWuQK9XYPpK8yxo35AQOWGz94Q-tfapUoP0Z5mg>
    <xmx:v4xdZuvmrKZYMPqRBWBNCy-iRY2_E_NfqRDrnB1ChsxIO0-U5xzMyg>
    <xmx:v4xdZpUFV2yj2VwMrN9tGgP2pNXH3JhFsVvBkzxY_yMpmLnHhiq3LA>
    <xmx:v4xdZuJ8579AWVbNIdI94JoBc16xtjz2Ssadg3nl8msV-w3qsxwTOUGt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:28:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 655de1d8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:28:05 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:28:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Karthik Nayak <karthik.188@gmail.com>,
	Todd Zullinger <tmz@pobox.com>
Subject: [PATCH v5 2/4] BreakingChanges: document upcoming change from "sha1"
 to "sha256"
Message-ID: <b36ffcbaa67dcdada630e2d582e75da623512743.1717402497.git.ps@pks.im>
References: <fc1a9fa03de7330f79dc56b0f2712834cb236b5a.1715070296.git.ps@pks.im>
 <cover.1717402497.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5SQdPJrh+d+uZXVH"
Content-Disposition: inline
In-Reply-To: <cover.1717402497.git.ps@pks.im>


--5SQdPJrh+d+uZXVH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Starting with 8e42eb0e9a (doc: sha256 is no longer experimental,
2023-07-31), the "sha256" object format is no longer considered to be
experimental. Furthermore, the SHA-1 hash function is actively
recommended against by for example NIST and FIPS 140-2, and attacks
against it are becoming more practical both due to new weaknesses
(SHAppening, SHAttered, Shambles) and due to the ever-increasing
computing power. It is only a matter of time before it can be considered
to be broken completely.

Let's plan for this event by being active instead of waiting for it to
happend and announce that the default object format is going to change
=66rom "sha1" to "sha256" with Git 3.0.

All major Git implementations (libgit2, JGit, go-git) support the
"sha256" object format and are thus prepared for this change. The most
important missing piece in the puzzle is support in forges. But while
GitLab recently gained experimental support for the "sha256" object
format though, to the best of my knowledge GitHub doesn't support it
yet. Ideally, announcing this upcoming change will encourage forges to
start building that support.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.txt | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/Documentation/BreakingChanges.txt b/Documentation/BreakingChan=
ges.txt
index ddce7cc301..904857a636 100644
--- a/Documentation/BreakingChanges.txt
+++ b/Documentation/BreakingChanges.txt
@@ -61,6 +61,30 @@ be changed to or replaced in case the alternative was im=
plemented already.
=20
 =3D=3D=3D Changes
=20
+* The default hash function for new repositories will be changed from "sha=
1"
+  to "sha256". SHA-1 has been deprecated by NIST in 2011 and is nowadays
+  recommended against in FIPS 140-2 and similar certifications. Furthermor=
e,
+  there are practical attacks on SHA-1 that weaken its cryptographic prope=
rties:
++
+  ** The SHAppening (2015). The first demonstration of a practical attack
+     against SHA-1 with 2^57 operations.
+  ** SHAttered (2017). Generation of two valid PDF files with 2^63 operati=
ons.
+  ** Birthday-Near-Collision (2019). This attack allows for chosen prefix
+     attacks with 2^68 operations.
+  ** Shambles (2020). This attack allows for chosen prefix attacks with 2^=
63
+     operations.
++
+While we have protections in place against known attacks, it is expected
+that more attacks against SHA-1 will be found by future research. Paired
+with the ever-growing capability of hardware, it is only a matter of time
+before SHA-1 will be considered broken completely. We want to be prepared
+and will thus change the default hash algorithm to "sha256" for newly
+initialized repositories.
++
+Cf. <2f5de416-04ba-c23d-1e0b-83bb655829a7@zombino.com>,
+<20170223155046.e7nxivfwqqoprsqj@LykOS.localdomain>,
+<CA+EOSBncr=3D4a4d8n9xS4FNehyebpmX8JiUwCsXD47EQDE+DiUQ@mail.gmail.com>.
+
 =3D=3D=3D Removals
=20
 =3D=3D Superseded features that will not be deprecated
--=20
2.45.1.410.g58bac47f8e.dirty


--5SQdPJrh+d+uZXVH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdjLoACgkQVbJhu7ck
PpRR5Q//Z1AwowcPkFGMGskw59WcOAtni6r2G/OpdjNcsKpEqxhKZgmbtg4rSgNX
E318UGevho3B6WtcRUsYOPvQkMoa8KIAd/55pvODYLEeRN3SpDeqqtdfMKi35ubD
uNd6ZegJUszhse0LMEDmsHBKUFRfcHZLL/ww8Gk5bEejF+wHjit8z1+zh3j5cEsJ
zLU4FPablVMdrMLvlpgeNXI4hNQ75whsC02OiTHBkZ7In4t+0MiCs/UKbm9k2UKx
P+FrNJKSNdfyAQJEMswTRwZT0YdyMzpYDai01YG+U1ixzjtg1VZsbT5jikyy5W7b
BbF0N08sO8bngvKZtpIkP7YYNs/+pN/l5z8SxxTZ/zExZJhSfPE6DaA2/RgruNZN
VUqKQUVSTHAYrdiAalIyNKVO0zqjaZu2TLCRG/MeB4oQ6l5+2+LjdZ5hIPdgsL0r
17VueoFZHdG5EKD0zV1l1+i8kd8FxkKuteuPcM4FWE9cvvlabfFdr2WtURLZvH5v
a+seRI0KDjNshGAaFhAZopFVONTab9UwgVWvOpdbrvMcP89OaI1YCQMm2q4APJfA
WLqLIQemV0uuau4cGvaiCPOlDnhOSmh8MGpCwoSDXNaKVh2hcZ0gIiRde73+KVVN
nWOfp9qz7vky/I9WYhASGCSM4NmqBA2FmwnP5sA0KA87dX06dq4=
=M+dC
-----END PGP SIGNATURE-----

--5SQdPJrh+d+uZXVH--
