Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4589E14E2C4
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669768; cv=none; b=pteiCASE01/DXzlQtwPuamWqz6hLhtNrnOeI9aYHtUGA5FW7xbDxck6bx+pAeur7vN5Hl9pDZYUZztTgQorW3k8tS2QH+k5AleVdjHVmDdSkweJ6NG/uCyQLknfX5lOxKfXwVxX7qVyUG7IEGe1wjk5mf+89e4A0NnbZJ5FTAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669768; c=relaxed/simple;
	bh=b0oUX+ETLnnUrPk+a/V/rilDXyb8gWoehVOpE46kM6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImVcBquyzvfBEl5CSPLN5FWsCK+R8oN2LfS8JmivhYp2MlVnWv9I9qcYIbYXR9j646QlTDQzGy1vtqY4XIoVANLZWb/KZozCgPTi7Hr/YoMs44kMcCFxUabgPYZDrquf65dS5uUs1l4JYThVLteL2Y2+me0zbEtP7OhYUsalZXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F7hrHgEn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VRMBVe95; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F7hrHgEn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VRMBVe95"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 62F011380149;
	Thu,  6 Jun 2024 06:29:26 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 06 Jun 2024 06:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669766; x=1717756166; bh=45c1C9cpal
	eCE/wUHN3r/f3HWkVEBuBeZ8AL6X9Z0Hw=; b=F7hrHgEnWnLhsJ7J3xuwwk3SFd
	U99wJT8+4mrVRGph26wKMPN4dz/6BHku4nzyvoRmJ/5qYFnCRhazb06ChOAm4SQi
	OfK171jf+N8+Z9YAUtsY8SiNI5qj44Fw3mNmcfKWjtSUazbpX98uH6jYoT+2+Byi
	0VglE1eW/Vc8MEKFILrZU3cJlzOdJVr1DIKkgwKpPu+1OnhLBtccSSguIKS43/sy
	6kyp4DYzJh/CSs5j9Nzu5l+p2ZvSQFZFgKYJ73Rmtly3UBNuQ9o302Yw7HI5pEKq
	zOJwv1R+0RJKCdX6rXpyVm/q+Kt2SpKTm9dPmljG47ReEdIQDE2RgQbkyW5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669766; x=1717756166; bh=45c1C9cpaleCE/wUHN3r/f3HWkVE
	BuBeZ8AL6X9Z0Hw=; b=VRMBVe95kCdE8KRU+hGvzYltyAndnPxNKCOb/utkMqtp
	OdYw1KG3WJu2hpP1pIeahI9Os0GBRvboEOVtesWbqtUldgWWeyhYJMhRfpvvxvVq
	GhSCuvFMiN8dVkRW4NWsqBrzuswqpB2HTO0Rayr6bJf55HnyrNXfJbKgLX/KhXek
	EQW+Q0sDt1ks6n+rzJxoV9HHS9ayYoF91IRO8sQW3ExX9p4d54TZanxOekBpIvnS
	BR+AhX39RhAfIIG9PG1l6MjbWskjGHjY2QRBErKqfkg2eccMVC0DKvrukL7gNDyL
	vWlkk2DSai5pM/EPVO5yh6FlLcDuAsuQf6fOChXD+g==
X-ME-Sender: <xms:ho9hZqNMiNiHIPsLZMUVXowU0_5_jK4II8-VKgtG5Dk8KfrzPduVeQ>
    <xme:ho9hZo8vHe-4J8nBQOKt9uHChwDMhG6wxce72DmaU6bEGdG_gcFA963IlRwAV5TsQ
    krLlQgPC4QDd8qdgg>
X-ME-Received: <xmr:ho9hZhQSXNkXPU5TXN6dbm_0yjCGaRxD1tDymiNqlwgFLg2fkAwwMQDMHTX0kJOYDgJ-VaW2OmT3-lDgmEWO56sKwt_ofVCiAFpgHj7Hrhw731DX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ho9hZqsWxYs60VQY_hyGTFvgx5Uk5gaZyKPC2OSjQZagRij_5n02rw>
    <xmx:ho9hZicNMAG_3dZut8dTS27LuXE6FOOIKMX8zQPm_bAqXomdwPuzrA>
    <xmx:ho9hZu0_ISAJl98N_L9Gl5D6lNTCVVnO0QWnhacBMX8wzr1QbuYQBg>
    <xmx:ho9hZm-3sHQlGCrSl3mMkcOKRSC3y6i-aQT3ZejY-t6HluPsVTir5A>
    <xmx:ho9hZh4lspVJSfkYymbyffAab7z8NQpRONMVHrq7kV1XPOdSZ6d2Lxhs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:29:25 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0d042a11 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:28:55 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:29:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 21/27] mailmap: always store allocated strings in mailmap
 blob
Message-ID: <f990bbeb858d4e3facfe079d62c4b292daef8c52.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uxJExIz2vsdgDVy4"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--uxJExIz2vsdgDVy4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Same as with the preceding commit, the `git_mailmap_blob` may sometimes
contain an allocated string and sometimes it may contain a string
constant. This is risky and can easily lead to bugs in case the variable
is getting re-assigned, where the code may then try to free the previous
value to avoid memory leaks.

Safeguard the code by always storing allocated strings in the variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 mailmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index b2efe29b3d..3d1e092fef 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -216,7 +216,7 @@ int read_mailmap(struct string_list *map)
 	map->cmp =3D namemap_cmp;
=20
 	if (!git_mailmap_blob && is_bare_repository())
-		git_mailmap_blob =3D "HEAD:.mailmap";
+		git_mailmap_blob =3D xstrdup("HEAD:.mailmap");
=20
 	if (!startup_info->have_repository || !is_bare_repository())
 		err |=3D read_mailmap_file(map, ".mailmap",
--=20
2.45.2.409.g7b0defb391.dirty


--uxJExIz2vsdgDVy4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhj4IACgkQVbJhu7ck
PpTdag/+LNPAXN0FU8dc4l/EOhktCDvLxKDEbPhzeVrAc1YWauaLAcYF8nc6sbrZ
yd6VC0RcBZ6BT1BJBj8D+QlWZRaFHVsgEp74lj5c8eBCyaRJKvrDWSPfILr254dH
1Iqim3I+JzCPNAySaWYL/WotYSm1eLeh3C2GeDLTFlW7rjzwFIwngSYY2tU64QrO
L+vcCtFQMh+jWf3gKIgFHI+jE7YpUbwhPlnqQ2fLbUPZ+fWWBIrWx1KJCvcp5n02
tsJ0Ep9WAY6xD4pcwUWxZiMxRjn6nLtTHG7wVK3odlQ+Bcmc2naklfvccwZj/bP+
CHada970YS4ItBoOpR/FuaHvD6CFrvb1WqV4d/ER6akiKR2ViuN1zYML/wERDSLu
eRQjoRxgqNaXnfRbJBkdd7WBYjO3EwojYOe80vz6814pl9hmhEGBUbHEJShUNA6R
L2jO5xAEkNwZH7qh+JsXIWdntW6uJgX/ONtQHtVVIzkyM2Q9nxYZ5HvyHAnvZ0zX
1aPkK7S+VignAqvrXqkGKmEsAfFyMWekTU7Cct8vr18NA6ZhyDbHS1n8al8f0mKM
iSU4DNYcFM+1o1XRs1KtqAgszQDD1TaVJZR7x8VJBlVZ+f4D5UGGWRyfW1aY3c0l
7gQvo+bSNLtLoP0AO0DYQIHA8oLeo6sHo6vjpD6Y5hzZt7NjsHU=
=xsVW
-----END PGP SIGNATURE-----

--uxJExIz2vsdgDVy4--
