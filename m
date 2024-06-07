Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D2A1527BA
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742796; cv=none; b=rFSCqM5ceWFokYmt+Ew5vc4LfdEF5bEK9ghH/9uOYhtJtVFIUiQPK3+SgXEXY37W2xaLSv+JhdspYEF2wgyfUeMUGUgbtgKF9mAmfv4b8QkfoZRsxxLtQxzMmIPGfL0TsYb30frdPJPFVb1eyT+1L872Ccjjp4CTjN4OwLBo7tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742796; c=relaxed/simple;
	bh=9XNtlwrmZtZYVWNEDGu9bbUwGx4gXO4K+vEZNxedlgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffxgYdyNTGdikGWwIXYOzHRf/mLGLQYB41Dm0ODFFR1yWQrk2Nn6zMO4j9vxB85QHCqjJgDailbq55fVcht/r1hobD/LqWApOSRvWTWU4AGB9z4ZpiMVs51eYRjGjyMv2DjAMBP9bwcUcjMOWqr5diG9kStedCJpb3qIZ01gSGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pVtDPo3p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gfgJOvYC; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pVtDPo3p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gfgJOvYC"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7D40313801E3;
	Fri,  7 Jun 2024 02:46:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 07 Jun 2024 02:46:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742793; x=1717829193; bh=ggQt4KAHdX
	pBEwMgGXIuy5lSqnqKCsfVLga6x+qPnP0=; b=pVtDPo3pabyovcxsJHo1hMGah6
	Mr4dkYAaY6RQR2b5tQ9H1AHS2sjkfUrBHSST7mVe0WL/1Zx03pZ2DRTJjDpVb/j1
	dwqfrnC05/Hl2j1PBYLXSHF9Fi8HVLb12Ua6Yne0vTb1/kAchM/z/JBcr3+feuk8
	b1fCWL0/G0OyDWq2tFauquhhAA/eHmYvyBaYURleyoXyaiuL/I4W9QemPaz26/uq
	84nQEn9E8OUF+AUPMyPuTonHtUlLdaCaoU8f1n6Xx/IlrGtRnQ9p2bARjG5Q6bh7
	8c4aYvInCac1Bswa3wOmbs9ONi9Rj30RFRNSoXIQxf3V4F9vvSFFz9bmz4bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742793; x=1717829193; bh=ggQt4KAHdXpBEwMgGXIuy5lSqnqK
	CsfVLga6x+qPnP0=; b=gfgJOvYC4mwydSzTSyLfDGw+5LF8fwCm1ibihGRPY5yJ
	/7D2umvQOPm556CWLXsGWDUzgXnDaZwzi/f/8gHwHNjrve0vCZSC+Nf8Do/bAQpz
	SObDhuonMBNuEv07jFFqDxfvuMBzGSn7ND1Phgruixi+rk6oVw6PG1Zf5T1bCOFG
	Jc/KnyBigA99qUUUmn/q8medrBLPlQ5DQjj/dFAYJr3Z7X2UIl7xbSdiASIc3rub
	/HlBp1yqtPba3Bto9DPlamGor1Zdek7TorJXDug8JHXcwqWotKEL4vgdnbJx5qSl
	WLXAw1S6gxUb74Hsg+TG+oovpseYDwqlRETvCBnJIg==
X-ME-Sender: <xms:yaxiZsjsWTKSQ0UajcodvaHlVP1u66-motemX6fNaIiEXQivH8TzaQ>
    <xme:yaxiZlCdWzueXNZ_rn3LS2dn9mIJ2jrG201rnGuOjeCSwF7gyXV_BtIlaAMczBc0E
    TdNgvhNTFhSGFYh6Q>
X-ME-Received: <xmr:yaxiZkEzePJX43kWSZ_GJtM03L6ez-rBSDKQxJbQ2Mv7rPTBclE8pOT-mkjJtQNSCQ38_PRYAG632eTyMVaGPCJikvTMPCLgi1bQ-qyB4-I9KCxz>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:yaxiZtSkCR6da4HHKPKa-fCpaxUG2UD6c6pN0Fdg4HBhvz6zXRZ_pw>
    <xmx:yaxiZpxq5XvhBM3KPcqIr_9dR-hTVm-BbIPdyDGUoAKYsrGtLb7FFQ>
    <xmx:yaxiZr4oLe-sQa9Pm4zu0HmE33iio8CV5sq9dq2gPfVMuAgIaJ4VlQ>
    <xmx:yaxiZmyemi4L-ttyenq3FVZo3nd-zm0NkYHwpwPxUPxA89map9R1Ug>
    <xmx:yaxiZh-oPqxtvj5h5S-QqKNiquvGc9jrZpdYj80hnQATur4g7ZCqt4b2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:46:32 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id db41c8c2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:46:30 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:46:29 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 1/4] ci: fix check for Ubuntu 20.04
Message-ID: <70fa755b4ffd396904c9f20f8a783ab194699d77.1717742752.git.ps@pks.im>
References: <20240606080552.GA658959@coredump.intra.peff.net>
 <cover.1717742752.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DImO/uuKYPwlv/Ok"
Content-Disposition: inline
In-Reply-To: <cover.1717742752.git.ps@pks.im>


--DImO/uuKYPwlv/Ok
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In 5ca0c455f1 (ci: fix Python dependency on Ubuntu 24.04, 2024-05-06),
we made the use of Python 2 conditional on whether or not the CI job
runs Ubuntu 20.04. There was a brown-paper-bag-style bug though, where
the condition forgot to invoke the `test` builtin. The result of it is
that the check always fails, and thus all of our jobs run with Python 3
by accident.

Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 1f4059b1b8..814578ffc6 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -328,7 +328,7 @@ ubuntu-*)
 	# Python 2 is end of life, and Ubuntu 23.04 and newer don't actually
 	# have it anymore. We thus only test with Python 2 on older LTS
 	# releases.
-	if "$distro" =3D "ubuntu-20.04"
+	if test "$distro" =3D "ubuntu-20.04"
 	then
 		PYTHON_PACKAGE=3Dpython2
 	else
--=20
2.45.2.436.gcd77e87115.dirty


--DImO/uuKYPwlv/Ok
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZirMQACgkQVbJhu7ck
PpQYkg/9HIWTGsB8QQx2ASub+cq2ts1iH3EXQjJKsULutSwJMbBIZ14IkWdW3lM4
mdMVvH+ppyOS9UCBaqxFhUJCBz5zsGvl3MI7I1r5LSIRqVyUfSn10kLLfJGQGN6U
XAP00sBPCii0vofjlyB71fb8KhQtjIwL00BvKOpKTv7bFbBTg0FjISwVbGT5NqH4
BdW1h3oksIe3cxTb9mae+W44hMywwz8RviPa63YOU7ROC4UTHk+O7rqwE6w5Zjpk
4r178/bYY++mjMiMuTtn4onPBvPBOMLDks6Phs9iTilG6g1tOFNCRjH206tcaDQ6
UjW8UNprrAgteQzicIHqArau0N0Vop8aUAyw1m+cFrVJLm4agNpYWSm9BlgzTEMf
th/200zZQDW7huxmLDFom2ZS/k26yjhkx0OdrWqUYGV9usolwsHkMO+OjBh1m/gi
/vC6LEALO10n79dDFRhnKw5HngXn6xL0b/oDBr1qQJfRrwq/tNkSu8xQ45h5Oz7z
4mXFWVcSGhsJdRVE7xO+WtbRgbnospPiDzKZrtjan6vDIH3Loa0aQgIbTvNS5jNn
8X0FUR6e+4WPb65QRNur7QdalyvN/yweXDag7ny9xXNzEMI+lnNx6bLJG8OWMz2X
A6SbDZPnzSyzLtiu7otpBdBG9zLVovlTmxdyC/cdVYPqd0gwFwg=
=vFHm
-----END PGP SIGNATURE-----

--DImO/uuKYPwlv/Ok--
