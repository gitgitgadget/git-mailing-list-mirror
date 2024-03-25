Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECD0194C96
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360963; cv=none; b=fdI+lZGAOcQB4HfsjJpWA0JEyuHNM1jRRGuR89F3T1zQs0zNidmtVA2QUd31RS7HT76V+XNFXuKH1XHNsBlOraP3s3VNpERjZ6ABXDK4ZBIhtJZFXTfJqyI3tcxCUnaGBboI1l+0Nx5sAIxabksdbr9KjjPdGrZiPN4neRFoqqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360963; c=relaxed/simple;
	bh=dZ4pqQZymqvXpsigrG8ikRjngF/vRXNi+Mqo7plMoT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKziFN5TiLTi02p4oZbKkcj19YICasT1iNt+6NrGhpyEABI2atBEVlOqLiVz9CfR0aWBJ8Yhd+y7d1x9slD6n791z1VvFri3Wbeq4QQuxA5heIbL8175cde8pOteGtbvpZYQxrP7ZZ7KwwiaBSVA0PjY/TGpojaz4ZSgT8v2IIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mpljk1hA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ty6U9P25; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mpljk1hA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ty6U9P25"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3C44011400A9;
	Mon, 25 Mar 2024 06:02:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 25 Mar 2024 06:02:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711360961; x=1711447361; bh=UmzKqMBWIm
	0m4AKIDI9HwXPX3O32Gm8aUhqiTlzRfrw=; b=Mpljk1hAAgWXmLFgUGr2zD2dn1
	a3FvnNgbqicMe6+SgQYYbJyQYD2cvl9E5u6hLFFZO0ZlKt+ijYo5xa/VELW2Nwa+
	5Wi7VwHmNBsIvYD6UloJQwjvOwKIX9Sb2eBcMNPq7oV0yQ6nx2+NfrCmbGavvyJW
	hg8yoQPrdWhbcSsrZT05lfKvQ+k/jKN+d81GmotBIknkvIeZu5to32CaCigxWmP1
	eTZBlm0Nm+PQO7fy5yDP4NiI8Aa0yX78unJ8DgcZEINLYPuT0Qk7lMeVaN50wgh3
	cdIOBYXFQ48qYKlpjyC13jOtfl6BMunnSzjjeRyt+Qu0BXPr9vKRYk7icRQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711360961; x=1711447361; bh=UmzKqMBWIm0m4AKIDI9HwXPX3O32
	Gm8aUhqiTlzRfrw=; b=ty6U9P25Esj9oIdbM0dGz6PsxOxc+Xy8OWEXb68zrPmp
	V/OQzWMvNw/c3W2zH+7aUZD6wz8wnN68/afk02Y8216qQbvCOWDkRIlckLMeNGjO
	Lgb1H6TKJJ6NVJR8hs4FlIvgUovmh3iiUdW19wx1hyTjUhiDmjc9jgWH6HB4t3RL
	tHav9vxJXfSwZ0cdzTuSJTKNwY7C5eOPwbH9WqLzMEkR0iq7HxWOCL20R8MRx/rm
	BTkCrih7J6j0ILYvc+UJbyKSTI5aQWVBK/hMPQX/QxLTFwHnbk1cr144hGVtQpV9
	HjwMLbxCw70bCSAAfxY9Fp+6HzBTpcSxVj6n6B0Y2w==
X-ME-Sender: <xms:wEsBZnL8GXxey1CymC6GnLShx088WG0OUOvFsJYkUuoZRgoOuOz2mA>
    <xme:wEsBZrIE7QwMH-XsaDkTYQRF3h5X4ySbBszvVvhHL8T8g-heQwDRuAbEwYqr69FVU
    yo0-p4FifmwSiHXMw>
X-ME-Received: <xmr:wEsBZvtDmxqhhczJKf5Lb9IGyknS0HSb7CopUn1EBdIHWDO7V0ejWTa3tocgc06oRevzem2E6hEQse3i0KCFdEn1YGCU-V9yPEUZj-1XKhDPDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:wEsBZgbgdm2SM7LrfiyweogJe_3-BjkethZiScD8exKr6ewMCugFjA>
    <xmx:wEsBZuaKrl5kP_kd9UVd2qTOWzu8N3TT4UGXKXEa5sUiF5k2Oq8fDQ>
    <xmx:wEsBZkBkCiJt5U_In2NS1t35caP34a5rWXxc1TTLTxxLZ69FvxssaA>
    <xmx:wEsBZsbAGzKBXx6I0UfK92d1S3sdDvVk23royWCIe6ddyrh_dPPpeA>
    <xmx:wUsBZlVi3t1RfIQ3GZoW22HPBz4wUfCzfTHDoHrxYrOmURWea5ZbJA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:02:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7d6d44fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:02:30 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:02:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 01/15] reftable/stack: fix error handling in
 `reftable_stack_init_addition()`
Message-ID: <b41b9b27cb8a7f7865cd9e128cb31d2a1a2e5cc5.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="feDoNZZhgfbxsJBO"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--feDoNZZhgfbxsJBO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `reftable_stack_init_addition()` we call `stack_uptodate()` after
having created the lockfile to check whether the stack was modified
concurrently, which is indicated by a positive return code from the
latter function. If so, we return a `REFTABLE_LOCK_ERROR` to the caller
and abort the addition.

The error handling has an off-by-one though because we check whether the
error code is `> 1` instead of `> 0`. Thus, instead of returning the
locking error, we would return a positive value. One of the callers of
`reftable_stack_init_addition()` works around this bug by repeating the
error code check without the off-by-one. But other callers are subtly
broken by this bug.

Fix this by checking for `err > 0` instead. This has the consequence
that `reftable_stack_init_addition()` won't ever return a positive error
code anymore, but will instead return `REFTABLE_LOCK_ERROR` now. Thus,
we can drop the check for a positive error code in `stack_try_add()`
now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 1ecf1b9751..92d9a7facb 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -590,8 +590,7 @@ static int reftable_stack_init_addition(struct reftable=
_addition *add,
 	err =3D stack_uptodate(st);
 	if (err < 0)
 		goto done;
-
-	if (err > 1) {
+	if (err > 0) {
 		err =3D REFTABLE_LOCK_ERROR;
 		goto done;
 	}
@@ -713,10 +712,6 @@ static int stack_try_add(struct reftable_stack *st,
 	int err =3D reftable_stack_init_addition(&add, st);
 	if (err < 0)
 		goto done;
-	if (err > 0) {
-		err =3D REFTABLE_LOCK_ERROR;
-		goto done;
-	}
=20
 	err =3D reftable_addition_add(&add, write_table, arg);
 	if (err < 0)
--=20
2.44.GIT


--feDoNZZhgfbxsJBO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS70ACgkQVbJhu7ck
PpSf9g/+Nd5nS5aFs5xX5iuPfmYpbzmeflJshAwlP0tG6P4NiXVxMyqf4rdE3JW/
mViTsoWyzJd+4ADRGi1z/QuP27Ebq4ZrEDT4w4D2YLhUH0I/YaBD61mjHPgdtRP/
3QI4h0g9lKlio1UWuhb6ooasEaVFp9ujAniiSqif2dmY/KVm+03TOsGeEOndoKl8
nlrmvZ2Yow2117nJGn90dYikUppIYl/PwhKSaG1Y0uMblFPlqQCJnCAkqVbrmE72
I/BrFO6bbnVs7hGamcXGgyEoWd7t4anXP59JJR6SAw66TJTtPx2Xez00wf4mzOw2
hnEo2Yt+WDD74YOCzxyyFZ8s8vQA9IxIOgQcjxA2NJUZt7sNtA+jMTYNJhhL04qX
DJXq+wgZgUcQz0wu7/tnXweXuOTw1oCPomRxqqPsxaHTs+DiuYnu16gfztQlf/dB
ykQBxhYgqMi8uzHUnHV3VY06XcT6AiOvscBmGCLLi1z8iw8TFYte9I/QQc/S072q
X0OMkKwyDLmL2fMxzSBK1lfcrENegT4j17SiGci0JwXzPYChrn2CKlgC3ULUf9xK
MsHBKD/tvNn9+qR2lG/De84QWbsPI8URLH5mnNg0W1YOjxgqRpi+BAJ4gP+e0CmC
fqi1CuwiNgJ7B6NNCeVPRs8dZJWzS7Y8y+eDaf6hXW/f4rbcR9M=
=+JJs
-----END PGP SIGNATURE-----

--feDoNZZhgfbxsJBO--
