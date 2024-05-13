Received: from wfout2-smtp.messagingengine.com (wfout2-smtp.messagingengine.com [64.147.123.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31FBC1474B7
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588295; cv=none; b=bj+aRHE+WywAGM1kYRtzzYwrAjmvStNeloNqnBIeaIwltzM/ifHWD7hnXDzWyUIcaAmCsg57LxYAEh4CCFC+l7CoccMIYl4lWozMbkx2hH9PTgxaa6FK2rMdrXQumGLjPhc02+ihWmc70y09KNQwCsZomU9/gFi7FKFotpQN8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588295; c=relaxed/simple;
	bh=mRkSdMQnGTRzzOuCy151L5vlutbmWrOHiPporAr/Fk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgjE03ljLKCdA2yEMK6y9BolnJ0FgRxfoKomFI7jDA00BRj9oAqgUurU1tQWL/r0wQNMIy8pEOQtUZ44oz34WkgZie68tzvDNIJRbAOPiKV5bALFQawlCJ0VAyKZywApMOYqFzlieDTnpz3dXg2vFP0R5MnPROC0Vmk7gkA0bvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k2DsGKdp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=f5b7ch3Q; arc=none smtp.client-ip=64.147.123.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k2DsGKdp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="f5b7ch3Q"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id 4E4611C000E9;
	Mon, 13 May 2024 04:18:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 13 May 2024 04:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715588292; x=1715674692; bh=L+FnBqk1Gp
	h5hGc8E31RP3v/aBf2VUnJhRsPUBPROuo=; b=k2DsGKdpkAhFOUBYg0rkjtJP0z
	NudRSMW+2RRYGYJXTaSQRSDp1vdRycrdnwCBEXv3JjW4SkMnYhKYwDUU4CwJb5EH
	NwyZwOzlhkagXqvBFOieGIXZYWIcVTxrjfPbnzLV1WmUZQHOnv6b88AkAJ+2JkTX
	06bc6DfnSIomLB079HO2I81+Qeh3yG1n6/ggh1a0r4LCGWR5X9zQwDVp3lnH/xEF
	cwRHo2nQNPwyYH3VCuvO+VD87Tjb8Td+kMcn+td2+wdK+u8T+nXJYh4gKgN5mMIQ
	D8l7eJMrFbttxgvr2qJXESvnNGejS/nOaioZceJTtsAZibOXi6tnqiPleeqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715588292; x=1715674692; bh=L+FnBqk1Gph5hGc8E31RP3v/aBf2
	VUnJhRsPUBPROuo=; b=f5b7ch3QYGIIa8qDjA8UZxCeGzSdHrnxoAa+flrexbi7
	ngEZBVR8CD5eEZyYnoGKZM3Reb+GEs0XFg2qkYq4WNtGlMA6NUEaaQxZmjO0kIGW
	Hpt08kwyKpX31RsscGjNPJRRrvRJ1JHr8uDrIf1SDNHvi9l0c+mgRBq+CUouaAMG
	fts/X8VG4VKNdLHE03/HfOzVj0zRkLhEGUsn2UqOi14AMATKvjteRcmS9CRzRmiD
	dmZV28pgdt3YNxaPL84s9QjARMpPY1a96yxKRo+Gp29pFfMj6TUb5NeA/PGPsifG
	7FtqI3xk/PmdnRlDEowg0GElKMEnVY/eU+CFfQ+tEQ==
X-ME-Sender: <xms:xMxBZhK2HliI3VuOMv-CcYIzjoaQbhepNG0iFFAtMzTleEJaj18LKw>
    <xme:xMxBZtLNNdmE33QtQmGyodAtTmiccOpl3lezsuE19cX6z0uAZhCUPVEqSh5aIlrfM
    LLMDe_9zaY9z_v28g>
X-ME-Received: <xmr:xMxBZpumy6Onq-6DZLhsj500JuEhBV9YZVDUzOjuJLmOZUmrtw5GCscbkePBUo0ecGH_fKfMTM2ISM_0zxgiPxleS-9u_2k1zHVu1tWloKFj8bM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:xMxBZiaeLPviCEzCfU5tE93zvY9BAKGf_m5GUJ8jAW6RMaAyIvoVNQ>
    <xmx:xMxBZoY-YQNdkb2QH4n_SyZRFh28lSASb5aMyVPXz5ROqfH7m_ZbKw>
    <xmx:xMxBZmCfAidGFqANLKtkd3Px-JmrneTj4ulCYnA1eMjBbpunKGp1tQ>
    <xmx:xMxBZmata5bQ_RjaH868EvmyzpkQ5HMpbdHp7nt7PPlQVbvQ4qcHeg>
    <xmx:xMxBZvVCQwOvO6Pk0PHUDtU0_8_HKucg7X7amRurbhQ8ZHOjHch5u3Wu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:18:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 45894a5d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:17:52 +0000 (UTC)
Date: Mon, 13 May 2024 10:18:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 04/11] reftable/writer: improve error when passed an
 invalid block size
Message-ID: <8ec26646f2653aa77076ca6498d7618e7c7dffa9.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UfF4SWykKXqK49qS"
Content-Disposition: inline
In-Reply-To: <cover.1715587849.git.ps@pks.im>


--UfF4SWykKXqK49qS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The reftable format only supports block sizes up to 16MB. When the
writer is being passed a value bigger than that it simply calls
abort(3P), which isn't all that helpful due to the lack of a proper
error message.

Improve this by calling `BUG()` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index a043025b01..45b3e9ce1f 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -128,10 +128,8 @@ reftable_new_writer(ssize_t (*writer_func)(void *, con=
st void *, size_t),
 	if (_opts)
 		opts =3D *_opts;
 	options_set_defaults(&opts);
-	if (opts.block_size >=3D (1 << 24)) {
-		/* TODO - error return? */
-		abort();
-	}
+	if (opts.block_size >=3D (1 << 24))
+		BUG("configured block size exceeds 16MB");
=20
 	strbuf_init(&wp->block_writer_data.last_key, 0);
 	strbuf_init(&wp->last_key, 0);
--=20
2.45.GIT


--UfF4SWykKXqK49qS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBzMAACgkQVbJhu7ck
PpR1gA/+JsYvuNsaip68IbBWZiBeOUA5C/TQA2YaQhNYcz0ugeDuwLNBIaOnLY0q
cin5iShS9IcCTNp25WIAxsrl0wi6bH7cSNuT5AJdZBQpfthTZDBfBRMbxuSQg88L
pnEGFT9pTBnpskFTICyJZtHJnB/YlfwqkCkEC3cuACLOFkbLxhorxPf+32uWJBZG
2E733JpPQ5NkNmmpkv8l/y3mi10GxAFMMqhLn2dH4Itxa+OyO+hPuxEhuIdPRFaR
C1/yn4Lqf6es46jp420xuauQR5dz8gxrJmdaYvekGtLcp4d08uI3sKNvTEr9Jd1N
IkEXv7zLgX9Fc8DAYmV1g1H3TC8JYfwzJ75oap3IPhR9dgbbn1HSubgBHHHovVqD
C8l1UdYso5kb7X5DeoDamGx1UtT++yaK81HbNEEbrRJlAOrNyDzLD3yiYm/XVfbh
17CkKn+nddA+wcXR34rzkNHDq/LmIfPM7wmz6rrMexZyIC4V+bSnecqTaeuouEJR
rcbbpMRgH3Z6RH5tvgUecRD/HbcdgQRHqSUeDMPWzRX63ud5zWmTIKs2RgdVPT6b
PD+/+EqPzBSlc3HHnWpjuEfKibSQyYipLbZC5wfAGoqcBEh3rn03pbEcFO2PktCf
mu1xuPx4xKadUiKBqHhlRWQttZuGwho+R21ihKorWreLuNi+yzg=
=5I07
-----END PGP SIGNATURE-----

--UfF4SWykKXqK49qS--
