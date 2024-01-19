Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2482C3CF56
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705660835; cv=none; b=JC+Jk8zltLmJuiXKlvOaWere53gCrxazHIDhSJQfofI3lMedsTct62tHJtJr6eZZSgmiRwjp/S/6v2r5sUd2Yzy4KROk6aJ3qjOPZEjIeLXUz5PozYUfyRI+3k5G7GcHiu+53e+Pkz+QTf0iogcfniOEiEaM1qo9YV39Xcygw9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705660835; c=relaxed/simple;
	bh=+EqU5QYcgdBkv3S1xHyT3D8Gxu+Fwdq6SiK+P/FBlPw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLC53SUY3rbm4za3QMIEuDOnpzNgMxAZGdmmpBivFSwXJjGC0Uf6k94RCsZAcQ3Mjf/tmyliVfcvOMGc/y9/V4y054iNj8THEaxL11vtOr2N4nUPevjtUXQw1ii+Es7r4muCW0CLJqhPx/lylTdfWN7BSf/xpy3QzZZQz4XWbA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VsmAq/2T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Taim1kAY; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VsmAq/2T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Taim1kAY"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 449D93200AE3
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 19 Jan 2024 05:40:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705660832; x=1705747232; bh=2apY0USGlo
	68oLj4+sPCPPCaX8OUItIbwPHPciwt+Oc=; b=VsmAq/2TnXwrftIIqxFQtVrSZw
	YcxzaphiE+kHGUWBL7g5jMPVwyzBLlB3ARnfNoPqGjTzvdQUepvfEUCXdIhloep/
	Q5LzTsOh1n4UOKo8dr6JiX/FuAWJO+LEo4i2f74kM/lGbH/1YGS+mMYNMgC2nuP1
	ne7g4w5UNpEe/YP99ptycjkIDLoBp4u9cNuMFKeZqG6nz/aEDgk3T7+B9bRkhb5b
	7R0XM4thTw+xL8T4qe2cEujFWC9+Zdi444tgd/1+7qAjKUuWaQn2eywP/U3aJFo5
	NtoDe2YVdw2zq6Yp7MUtBZI3ADx1rbSVteE4mGAEPV0hpvnp6o0DYKyM0U3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705660832; x=1705747232; bh=2apY0USGlo68oLj4+sPCPPCaX8OU
	ItIbwPHPciwt+Oc=; b=Taim1kAY6IrxXC7/VbE71UPPZhV5J2LmpJVPnkJllSVO
	SLJqbGfGQRn/mDUVf5qHUM89a7qwgjLGtOLot2/nq9Q8RxmhDt1t7U1ZNjiV6rRs
	ZbLy7uWCrW+gcWBTgMtS2OJl0oKQ55nZ7SyOPfjuhz6O0rSy4iNY/cI8kRN/8mxH
	mqdTyMPMqbv2h0WkH+MdvUa7zbQ+pWvB4xRxpoEx5LlF3xtTaSUKk/1HNdIkdWh0
	Fxaf7ZyA9gXMnJtHD4fZLYRXAtAyIMzgYsdfoyH4HF5Zlt8iGKgPB1Jzme9AIwtw
	ZFCt08qYSfNTBDlAaU8SrjWrUd46M5btTiAeBWYK4g==
X-ME-Sender: <xms:oFGqZUmqoBzZ_39B59LKgUamATYRJBcTO2wToR7Ebx0MabuC8m-R5Q>
    <xme:oFGqZT0zqBobCw1G7WR3rJRow8N9_eD26MP5bvUEbpRSRlgOjmo_NMW0OXrq_YWtp
    M864oAqno8vAHyaSQ>
X-ME-Received: <xmr:oFGqZSr3QpFhRYismw2AtjYlFXWDGtNKHVyN-GpradtuzPqCfivY-Rq9l2n-UXeG53rZb3TLnl3rv-w7xj1Qlq8sCu94tOHLdMpLJE72al7UdzbT3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdektddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:oFGqZQllLo9f74zq1Qq5Y5EGk7HdD5zFoZtZlJxk67vSWZIS-dWkUA>
    <xmx:oFGqZS3fFtTLPyaDyxD8PsV-y8DvLthR30_GrBLS7ozztoahQ-LuNg>
    <xmx:oFGqZXsQoh7hhoxbLkwEBoSMTXwFBBp-1ZhMipCzTjWeTQL9-Fba5Q>
    <xmx:oFGqZbiwFqJcnJ9Y2OWa1kx6c2ta2InYzcZhiRNsqRJWKiyrj0eU0w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 19 Jan 2024 05:40:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 615feb14 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 19 Jan 2024 10:37:34 +0000 (UTC)
Date: Fri, 19 Jan 2024 11:40:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 7/7] Documentation: add "special refs" to the glossary
Message-ID: <2a0943a78d0db0f489962520536594845970e0b0.1705659748.git.ps@pks.im>
References: <cover.1705659748.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gHZsvGmX7Y55yVFE"
Content-Disposition: inline
In-Reply-To: <cover.1705659748.git.ps@pks.im>


--gHZsvGmX7Y55yVFE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Add the "special refs" term to our glossary.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/glossary-content.txt | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-co=
ntent.txt
index f7d98c11e3..d71b199955 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -638,6 +638,20 @@ The most notable example is `HEAD`.
 	An <<def_object,object>> used to temporarily store the contents of a
 	<<def_dirty,dirty>> working directory and the index for future reuse.
=20
+[[def_special_ref]]special ref::
+	A ref that has different semantics than normal refs. These refs can be
+	accessed via normal Git commands but may not behave the same as a
+	normal ref in some cases.
++
+The following special refs are known to Git:
+
+ - "`FETCH_HEAD`" is written by linkgit:git-fetch[1] or linkgit:git-pull[1=
]. It
+   may refer to multiple object IDs. Each object ID is annotated with meta=
data
+   indicating where it was fetched from and its fetch status.
+
+ - "`MERGE_HEAD`" is written by linkgit:git-merge[1] when resolving merge
+   conflicts. It contains all commit IDs which are being merged.
+
 [[def_submodule]]submodule::
 	A <<def_repository,repository>> that holds the history of a
 	separate project inside another repository (the latter of
--=20
2.43.GIT


--gHZsvGmX7Y55yVFE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWqUZ0ACgkQVbJhu7ck
PpRgIQ/9GHFSinNEX5Xix7tnd4bQjs5Xx7tke4T6XC/MlsVfPni5CiFg8jNu1VLi
DfDH+k+APo6o7Nad5SSgNGUTc732fZSnFE/rQM5Bb3ER0E4tKC6JO/IMLibB/Hzw
vT1srsIuwGl1Z4rO8RcITV6DWDTCZ37wX+hB7PMt6rL2CTzIG5qKDJKW7NpfHIfq
owLpEjpBla7oaeRdmTyDN3wPE0oj6wwd3GSZDwWmg3JnafFQi2A/CJudtnbEvxTa
DSBbsYTORN0Np4hU/I0EtZ7ptiBgZC/C6F0YKy3Gb9galHS1X2nSgLKTVsWppH3F
SmiWmVV8lUOFu04Y5+8qKLPnvMTwS6cvqYNBTVwsX2940ZI429YVnRWAmRnQvTiO
LvEIBn6t7vl2C5ScZJBgmSYwKt9BSU/fjbcxOQfj38KVf5kVeeEpj50CxWeAtNrZ
SD53WjcqwIHSUP4paRVHIMyg5MhTpq0e5CSOPbUsyefzW/4uWazkourixVeHqovW
lUwX/gcvwkf9eW+kzBJh+KaiARNS11taDejJ3tJ9SqFRTStiMc1IWPOeacSK3OoL
fJakAP6DAoHrAallGQI6j5dlXZO/a/6gQudyiaoBkobBAmwsgfbS38QfCT1r0sfr
inOFu53zD3jLlcSvBnwKth3W4aIdC5wB6/8Q3hG9d30GCmskwTY=
=Wxok
-----END PGP SIGNATURE-----

--gHZsvGmX7Y55yVFE--
