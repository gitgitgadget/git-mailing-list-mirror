Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75382657C7
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707463399; cv=none; b=DOTjI+Jt8w0vR99Dtda1fRzGQc3aitU6nBWlz3s2HbKKMHZprvsQzHyCDdnzj77LulICiLOAAVITGL2YcInUGB8EvTINjgJKgyZN6iDUdsakGaE7zG07DK0TJNyNNieEndU7E505Uq7W5w+DQEvipsvYnVWYfyZ/KDy5yAWFmsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707463399; c=relaxed/simple;
	bh=cXJBYpSlUIi/0cWJSRly7moQDQsvyDwebf0HA0up6lU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb/WXWZqZfsXcTE437Slqg/MIK4R/Pw2lfxmnzJi+S/BBUcje+qrNGwQl8WhzSvbPopqO7SUBS0k72P+jENHYuRYcNeq26Fo84SRqptngz5so5v3hjK+uI5qQjbQEDy2TXDmFnwW3s0tiQWvp2TGbI3xtcZEA0T/5h21ltmzXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mgde2LoT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xTz6d44i; arc=none smtp.client-ip=64.147.123.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mgde2LoT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xTz6d44i"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id AEDCD3200A94
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 02:23:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Fri, 09 Feb 2024 02:23:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707463396; x=1707549796; bh=HMj1VCPNuE
	HuOuV3I1MlT3rEpXOLJkg6EAOh8+ntx0E=; b=mgde2LoT71QxDCGU11iMeLtZJ5
	dabY5ZTiK8I8GJHav4K81jBH9UKaL/YGSxxQbr5U7/YjLr2CdZT9elbea6SLIarS
	46CWSbBaINWfUemQS976p+BDYZhkMvylkyL58SNOUTO1l61xXJEdPxmuOm3YYWb0
	PAGpCb4nKRk8YooXMGZ0sMscCH6OwAw97sDFf3dM+XiDqKmoXaFFTizVyxoyeFAR
	3ZZkl3ODdu1Y8Y01xp5T6exRpcqGSbz8ATpHbn8SgnlpMQAuuEWS1sqx/yW3uKeM
	UUX7UHZzBpN75ClFVKFqhdC/qhp82g97/udTByzEoyr98xvfHke1XPFn0Oqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707463396; x=1707549796; bh=HMj1VCPNuEHuOuV3I1MlT3rEpXOL
	Jkg6EAOh8+ntx0E=; b=xTz6d44i6qWSnhKKkdjUq03N3odFBu4bCxA1x1UXl2+Q
	WYrxPiWec+eWud4TiqoUAN2JgdSRv+bwj6E9B4V/SQLsoAgIAV+MsD52HQhp6VO5
	eNCwiy3jlJYqYkC0XROXGcH+siARgF/SFjWncoKiQF7e6jaKz94y6dna7dpQaPCc
	TZUKKq5NBrG5PdtAz5QloI6g5hFsGfQYyrLushv7k65CibyhG+17slKpCZvXoyHc
	GfGvs4vpc1hV5L1Q20jtv2x8ssRStCn1SBteicxMq4AVtPj1KpTlztZXI20vef76
	VDuqzNZmSPBCe9fP0BSn5psauSeFhgQSl91X2jX9Uw==
X-ME-Sender: <xms:5NLFZdzJ47HEcfGVnpzuSfDDA5h2UkWoAhklvefM3rpyubU4rhtTEg>
    <xme:5NLFZdS2HozXbXFoP2U1mpnko_DSYh7BNEnwhfw4t4FMNf7XPA7WCzg-GTNyHmQCW
    0XyiG8ZHxjMA65XRg>
X-ME-Received: <xmr:5NLFZXWoJpxrOgCtivsh47v3pgjpw0C5u9FIcMffCBA435oZ5Mo5GmMc7aYq010YXaM6yFVnNRdyyClsdzXOQOgTWM6RW0_JCDvYOAyc338ou4g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdehgddutdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:5NLFZfhDjj7L1mvVLXIFPyOf2b4ads7KMKFB8PGkfE14C8U-VlAmeg>
    <xmx:5NLFZfCEh2iM10Aedy5iCRkjsO3rx6nrJ01bdGMRSZSdthcFi7qkXw>
    <xmx:5NLFZYLWSXHv9XnIUR6L4FzuQQj2wYNSuvJFw2qUKkS8zzu3e4p63g>
    <xmx:5NLFZSp_0k__mvvOj_PzFGxCr-eSikQuItHq_IV52e8TKYCSY10iKQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 9 Feb 2024 02:23:15 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2b43e852 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 9 Feb 2024 07:19:40 +0000 (UTC)
Date: Fri, 9 Feb 2024 08:23:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/7] t0410: enable tests with extensions with non-default
 repo format
Message-ID: <feef6a3e6cd0d9096816d0a8a5789837fb784517.1707463221.git.ps@pks.im>
References: <cover.1707463221.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pUVwA2l7DW000oCs"
Content-Disposition: inline
In-Reply-To: <cover.1707463221.git.ps@pks.im>


--pUVwA2l7DW000oCs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In t0410 we have two tests which exercise how partial clones behave in
the context of a repository with extensions. These tests are marked to
require a default repository using SHA1 and the "files" backend because
we explicitly set the repository format version to 0.

Changing the repository format version to 0 is not needed though. The
"noop" extension is ignored as expected regardless of what the version
is set to, same as the "nonsense" extension leads to failure regardless
of the version.

Stop setting the version so that these tests can execute with SHA256 and
"reftable" repositories.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0410-partial-clone.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 6b6424b3df..d913f3c453 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -49,24 +49,22 @@ test_expect_success 'convert shallow clone to partial c=
lone' '
 	test_cmp_config -C client 1 core.repositoryformatversion
 '
=20
-test_expect_success SHA1,REFFILES 'convert to partial clone with noop exte=
nsion' '
+test_expect_success 'convert to partial clone with noop extension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
 	test_commit -C server my_commit2 1 &&
 	git clone --depth=3D1 "file://$(pwd)/server" client &&
-	test_cmp_config -C client 0 core.repositoryformatversion &&
 	git -C client config extensions.noop true &&
 	git -C client fetch --unshallow --filter=3D"blob:none"
 '
=20
-test_expect_success SHA1,REFFILES 'converting to partial clone fails with =
unrecognized extension' '
+test_expect_success 'converting to partial clone fails with unrecognized e=
xtension' '
 	rm -fr server client &&
 	test_create_repo server &&
 	test_commit -C server my_commit 1 &&
 	test_commit -C server my_commit2 1 &&
 	git clone --depth=3D1 "file://$(pwd)/server" client &&
-	test_cmp_config -C client 0 core.repositoryformatversion &&
 	git -C client config extensions.nonsense true &&
 	test_must_fail git -C client fetch --unshallow --filter=3D"blob:none"
 '
--=20
2.43.GIT


--pUVwA2l7DW000oCs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXF0uEACgkQVbJhu7ck
PpRMtg//QoRP4F+g3SYI1IbuUqMsezCbE8Ox6qHZgr6dTLqN5Te15OGNOdSXrbj9
IjKZ4nEnDSkYed0yg+MtzvqK2DHs/oaX4UIRC9N7ykuvqbv5tRCGdxfap+yvHKZq
vxU1aVlmn3IWEvIDdXdX61kCFVK9tTujL8uO/4zJF+oaWje+co0eLP0L4QrZznBW
/sBBSPTdZ9JGA6ufXDZ8X/ptkvSabFdrLT3okDMD5hcWRTvpo9AjXm+fUd+IkWuL
Ixt+d7myHMspC+gdw3LV7+KPvdOxIbMlkuR//c/bTJCJeQMlFDlRsvDEf3Z9GvnN
mTI8nBjuk40SLA+kCEwQ7SkzbVWoDpmwszHbYmn9KQdYAVjdabCLBRuxNwmm+Bg0
0/LibX6DcQrBkgdHqGNb8MqZaCmqM6TeIDv0YMcjNeybc18Q+7ahAk16/+fD/q67
p/95061mByOlDuL+sfO6UnsJzek9YsEL2RhvO2jvb603VK1G0rwkoi4im8Wrwv8c
9L9ScqLUCuaFsHJGF3LMFZS9A+V/h9QGS2peBPWtxsQOPnNq/Zub3WqS/ZMhS4lj
Mm2Jr2k2HNSePRv9mPXAPNDBJgFj0N3vylsXj0d0kf4YYfELR5Ip+V87NhBm+CsK
6Uw0eAtgAOTfBXosiS6ennY+YH4ptVNcz4zX2A8Ye1cwg+HG1zg=
=ug6M
-----END PGP SIGNATURE-----

--pUVwA2l7DW000oCs--
