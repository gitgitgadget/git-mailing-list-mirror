Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21BF18CBFF
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723122289; cv=none; b=mku/JdcX4jHj0Mx3YucIu98ewkLkOZCd5Saa8nESrqtWzOe0ubdtfZYlvIJSbvoFz90WdE8tcbWqib8ZIAPmgmU7qkMSZ296VvN/C6PNxF107Y1dLDhz+MoFsRHzSo/7iToTf7j0rRcPPRhxw+fTRIHCLwC3o27WNLab/CV9ako=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723122289; c=relaxed/simple;
	bh=kCOwud3vZYBKCSj8hYKu8nqzdcA8pxNOqf5RiCPDfNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGg6T3pOHBaWu63tu93cMNNVC85957ELLvOPQndynp9PHufvecxvmra7WhyAg2Gewfg8ptI+PiecVOvPAqdDEcfZ/IHiOpw8aTGy1B004XF3rY0DfnV9Uau8TIgUVORo4+Ke1QHvidnMws3FWV0yA0WxTHi+1/7NEhNvbUCT9nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jo7F2syz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fe4ShwCd; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jo7F2syz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fe4ShwCd"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 323DD11482E3;
	Thu,  8 Aug 2024 09:04:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 08 Aug 2024 09:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723122287; x=1723208687; bh=XhxKlvhqCq
	2sYK04Hde/fqk1esfFejyLG8fRPHLOAl8=; b=Jo7F2syzswHmb/UY0MuEm8GFTR
	0h5TY21cyqmLL3t9fj0VQPzXCjjdpmtwdSNN6SbZ0pJL1uflTN5bc2O8BoL32F+b
	BQqleNY7mG37ZB4/B2ubyam1m1rkT84o/HIVeAB9PvGGMFz5UiKNBGEbtfd1b5VU
	49nHHmNKu8HNflZAzZ0hg3DwOhB9fRjuuf/eelOqisZDmVhAWygjg7CgPZie4qgs
	1E1xqqrH0y+8elcrIJk8frxhci7sXN9vv8N/4UruJfUJ3Wcp4aMF0XFUQcJLG3rG
	Vi949QPXWi9YwGq0KgH28uWU84Hg+5l2veorvERXMZWAyJZqt9OdkJJ5Weng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723122287; x=1723208687; bh=XhxKlvhqCq2sYK04Hde/fqk1esfF
	ejyLG8fRPHLOAl8=; b=fe4ShwCd1ZQaBD8Bx1QCY1TjWMFxX859YfdA8yl9ywif
	UvAa8ngx7c7Xql2isiZifPevIiPuDKCboJbBd/7fMbz+PBNWMx0B6bETTVVUCMH2
	t+JevoOyvJuzVl8AtUyOP4ditH5VTMYQGnUAEH5vqWZolxtlnjgMSXxq/h9SqPDu
	8ySMEwvy4Tl4XgaPtctOf0DR88HSrKEy2r8JfWkxl4UDLwK8EJnQCbadpViu+S/S
	FFNRvaFB17i74HxgvH+zjRX1m9P0ffRTlNHVcqiXjDq37g/ibDtp91+lN+ByC4lF
	TxqBGjTxMoqczF2xDNf0521thRfZ2wh1K/gAHDQW3A==
X-ME-Sender: <xms:b8K0Zvbg5SEtDUrU83K5K9bXbPjrcxco-ARqBnI_oQ7DoW1n2wVshg>
    <xme:b8K0Zubou_U-jdfFXLHbuYZt6TL5BH-8Neo5pWnXO_kccLa9ih9YHKvq9IpSz3JIX
    hIYzozOkKOcdqOhHw>
X-ME-Received: <xmr:b8K0Zh8mqZM71PaqmK2xExKKwy4AOm_Jjk6nI0O8LtL2G0Z4Cd_VGSp5jNVnpe9mnO80JY7bd4ZXV1xeenbzadB_MXt8wY7mBKhn-SJPLPJ5mB5e>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjrghmvghssehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:b8K0ZlqBvCJrKIWkEeoPcmKsExDgq7rC8hFZ8GFVXO4XVEw5KStZVQ>
    <xmx:b8K0Zqqzta1po2AuKyLjcyVwUfH8pbm0Z_WHsbBMixx5vxGVbFr1wg>
    <xmx:b8K0ZrTXZsMiq0DaEzWnO-hbDJ_6AhlABdWpHC3c9PTc_Op1idFbuw>
    <xmx:b8K0ZiohI_1Gdi35rubkEzQNzVCE431jgRYw8k8k2gPBatO0AgL9dQ>
    <xmx:b8K0ZtX_5u7OnLiFqaBUnh4UikxsiF6aurG_IuMtz2BRl1QHBj2l9f2A>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 09:04:46 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 21239cad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 13:04:39 +0000 (UTC)
Date: Thu, 8 Aug 2024 15:04:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 03/22] object-file: fix memory leak when reading corrupted
 headers
Message-ID: <43a38a2281f25db837dc9b5a59ecbe12214ac7bf.1723121979.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723121979.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+1Be7ScS5PQrCbKI"
Content-Disposition: inline
In-Reply-To: <cover.1723121979.git.ps@pks.im>


--+1Be7ScS5PQrCbKI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reading corrupt object headers in `read_loose_object()`, then we
bail out immediately. This causes a memory leak though because we would
have already initialized the zstream in `unpack_loose_header()`, and it
is the callers responsibility to finish the zstream even on error. While
this feels weird, other callsites do it correctly already.

Fix this leak by ending the zstream even on errors. We may want to
revisit this interface in the future such that the callee handles this
for us already when there was an error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c   | 1 +
 t/t1450-fsck.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/object-file.c b/object-file.c
index 065103be3e..7c65c435cd 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2954,6 +2954,7 @@ int read_loose_object(const char *path,
 	if (unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
 				NULL) !=3D ULHR_OK) {
 		error(_("unable to unpack header of %s"), path);
+		git_inflate_end(&stream);
 		goto out;
 	}
=20
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8a456b1142..280cbf3e03 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -6,6 +6,7 @@ test_description=3D'git fsck random collection of tests
 * (main) A
 '
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
--=20
2.46.0.46.g406f326d27.dirty


--+1Be7ScS5PQrCbKI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma0wmsACgkQVbJhu7ck
PpS9KxAAp9AdEgqhrl+de0sDuN3GHWoHr0O+OWlfSxu3P6dlZgVvEVYgC/Pg732L
QBbu6/x/YlhENTe3km0rSRregwr/D43mS5+S2bXbo6h0VNdsIBCwIGf5LPIhlG2r
o6e+URk9728yzxrxJoy4nDPApt3cx45FXyfCuDQjmc+QMG6vWL5vkG/7j4xzdilk
Lh3U/D8R+HJjXrlmFX9Rv/qEkkmAWZ6ytuSbOkHpX0cNyy38ipAD78sjHSZZLb7M
7jhHS2eXqVKMwJlO8Qa4s7Zpt/SVsCqIkQx1GGLIWQ3QtcBPgk0w7idqXFoZ9Tcb
yL4Ms8l/6j4xAMTFk4SfEVRPnRq87nbVxhLRDRfJ3E6UOZCE7bIpCJSTvaJtT5hn
83Bvj5idy/CpsBx9jzj3hubFcA3HpHcQH8R6illUOVF22MqKNhhamv5Halvqskpt
F/cptwOTveoFmmuE3HeGBqyeTqXMGUJKJ1DVEHMx8vgVXVOFaEAxaveHRADvBnHR
YCfao3ur0XORhjs5/LldhAdWnoH+FpXaNj2QXB0YlpLf1gNoimqoXmrwwJ24ePXf
gxSuVvASBdTr++4lNWjiGIojXMJQL+1vgW0rIvyrBKcAvh/aTjd+0m4pQRpnOwIh
LXuknxHZuoiFCGCdR2NtU2SkeADRB0TPdMKkINOTuvk5FRtc/yc=
=xoGP
-----END PGP SIGNATURE-----

--+1Be7ScS5PQrCbKI--
