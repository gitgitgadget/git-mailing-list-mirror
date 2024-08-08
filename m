Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E79718C331
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122373; cv=none; b=iCISLOAIKSa4g+OuJ/dA27bPyxcIyRYEtsBmpIk080yD5Btt+PvGHRUJpdDdjH9PcfImyHp9CNAJxON3KwtHSHKuV7LPuDX2xocRtZSoOqwugeA27OU2rJPYkhqYTygWwvPVdGFDcXXeCVN8WxT1fmaIbfSQ+WPwdm/8RyIoHaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122373; c=relaxed/simple;
	bh=6vBxEwUX/+0maFk629E1LSZcl/IJf10cwgdI51wNqBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAOI4TrN6+jZxRpGgLN+ykVSiCSB+cwqyva+eZ5EFp2y/ebOBO0AFv5RZxXRS7ftIxMrNdQeLtbelG+LCfpclnBrpqaVRiznyJE4AEPsCljGeA9+FTsqRoTBl8CEHCui1/QIpvy9YY85zOh7k1lpYa1B5XGXSJVqW1BQj0pJyU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HsMJdQHE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CApEIVTz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HsMJdQHE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CApEIVTz"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id D39E8138FC75;
	Thu,  8 Aug 2024 09:06:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 08 Aug 2024 09:06:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122370; x=1723208770; bh=kszWkZkhJS
	fCknC0FruFFyvOVDXw2o7g2mlXIWQ22DY=; b=HsMJdQHEyCJFfOAR7vCHzoicXn
	eOv23oDXq8Lvnl0EfwOrzjP0X57bg0Gtmp633oot677gJydXdQJOQq6MBWkzJUpj
	2vq9GWXkJop0+FryYfv/ekMBerZR71RwJUEmjE4pKVtcvNcJxDxnOLHqQS9yivAP
	B90EV6OioKNpdDlxOaS5pZ77X5fmffeBAe0/cbj+JmfTffZH1L3vugCfwVWtEmRy
	l4S9gi9Tm2essP+tsZYDvYmuWdsHb6pKxOpKR69nHyqa1BVYkSx7NRX7Kn0IVA2O
	yCgZHl6sv+Q2fIgRuAk7dg6ml/N7mAtPditF5ksQD4Wr3LnLyrTQnfXLjU3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122370; x=1723208770; bh=kszWkZkhJSfCknC0FruFFyvOVDXw
	2o7g2mlXIWQ22DY=; b=CApEIVTzhCaJYA59xMPEIxxFQDyyu3cz+kpFcXSfUY2g
	uZF36dKR2X2m3OMgNjlnSHkCH+DMUieED7YzR+9fIcBWS/f6xV7gduDVm3rJ14RP
	0vFw9ZR3FWN7nFzF/FTINhOIl6LTAzqRhzTMtzP/gz6dJygegOSoM4fBN66poAsI
	Y88KDylZD5+uB82AmRwNl/y4Km9STxwqlmQCuKXrqAIoRe2hBzaNxIEd8kSxr2q6
	VTefWemlqLsDUURV+sD+qlXl7KXaec0AIUslARmbvKFMavhfHoX8KnLc47ab84hY
	3qif+IDi2aTw56+dIqQzkNfwYsSIz3M0bwOaScmxcQ==
X-ME-Sender: <xms:wsK0ZuYdIpT6kjaoEaWW6GH3XPJZ7mfHfL31P8jpzsEFsCRcB1tLXw>
    <xme:wsK0ZhZ7YQXd0czJpUbl4R4zJR1Y7CEcLRJzLMG-R6ENce3ub4EL8sIIiOB1sCIgI
    FqHfKLH0e9rx9o3Aw>
X-ME-Received: <xmr:wsK0Zo-Ev2LFd3t9UxUONsDVLZ80TIxHdd4I-PbaMGSt6laB6HxKaJofQ37HjfRjyOgKzvG4pqgdk4MpO4Z2Ge0VJDkKV7EfZwCHO3JapVQ6I-al>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:wsK0ZgpXW5f069z25tp4vHJ0xA9m2zdssewMcElxWVR3roRp39jmOw>
    <xmx:wsK0ZprPkqcTCRW5YzSM1yomuq4ozktE-C4sHbRQnNZ1JQWyVTus0Q>
    <xmx:wsK0ZuRc5a4EWDcKUUYCvXF0FdzYFOMQKtfuZvOqHpbbBeW2gHoLPQ>
    <xmx:wsK0Zpr26lX8Gj534L8ISV_DqnSU8T3CXBT1zhNx9JhAgJ2DgwwYCQ>
    <xmx:wsK0ZgX73u4QUDPjSCIKg1bnZbVswZPulPB10pRZ-CDJufHGKi5HgjfI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:06:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ae3e4e96 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:06:02 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:06:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 20/22] builtin/log: fix leak when showing converted blob
 contents
Message-ID: <78882038333ae40bc4520d60e42b590c68a5dd8d.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AOJg/L7FHMUIMlS+"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--AOJg/L7FHMUIMlS+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `show_blob_object()`, we proactively call `textconv_object()`. In
case we have a textconv driver for this blob we will end up showing the
converted contents, otherwise we'll show the un-converted contents of it
instead.

When the object has been converted we never free the buffer containing
the converted contents. Fix this to plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c            | 1 +
 t/t4030-diff-textconv.sh | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index ff997a0d0e..1a684b68f2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -707,6 +707,7 @@ static int show_blob_object(const struct object_id *oid=
, struct rev_info *rev, c
=20
 	write_or_die(1, buf, size);
 	object_context_release(&obj_context);
+	free(buf);
 	return 0;
 }
=20
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index a39a626664..29f6d610c2 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'diff.*.textconv tests'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 find_diff() {
--=20
2.46.0.46.g406f326d27.dirty


--AOJg/L7FHMUIMlS+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wr4ACgkQVbJhu7ck
PpTmsg//VDNydSujBXxNYzzFWIjrkcdBMp0TdyuG75yCQd14u0UOPpNDypBz1wjh
nB+x4wYtAB53dwvDrkA4EU5NrUdEAbaHpKCUkyZbFRMRr/b97x+qhD1mbnPfhml6
G94rPBvf6aoroOc/x4AwPoMtZUBoS3FGBu9oNBBceW0U4N9aWWJdsWGjhIW462QB
F1X+XDqakzCqJzWrAUtpSRISB32wWK/ePWkzLOhf6R+VnmnAaxI6Cdut3r3bWQO3
PAtIWTWyYZwnuk1DsvdaGAmE73vQ/7lZbL9bUk4xRgZiFoZV0uRdSpktClHTH+wg
0H/WlwyLTIR3QCehcRhHm37987MVqjnWpGIDEtQ8K2E1vZINAlW9+wThhqLKzHLS
zItcFoWchbYNIZLdT7wOU6ss5dgUEZ6b3Gg0V7zwFrQcmGbbbcbdqmrK3yOMAMfT
p+dCbYkRT2VplRJ6EIZN8YA1EHOkgYkz4HNZBab5HRluUAYily72XgcNoHTcWxcT
dsFTqTh2NsmnON1Ptvh/3DpHJwIHN050Odo1ffuXxCQQ5HnPTRQ2/SWmZ4k+JPSC
LW00pV91mXb885SGHtqym9wFJnXLf5pIF9i6FOFjDNLwiaEUjeEeZD2g34Y+mhaU
lOQ1B4C708CyZkD2bpAP9gkKBsUWChpYF7l7wDiEaFWMO3/kWe8=
=GdvP
-----END PGP SIGNATURE-----

--AOJg/L7FHMUIMlS+--
