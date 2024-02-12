Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 560A711CBE
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 08:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726773; cv=none; b=T0+fuBI3E7a4EgHP97Ny28bzJY1+XJgfTQXnr6qZNc586LpRBvjc3X4RmgWuQQAIjdlzQEeATFehxqfn8BriaUBn08fBUH0ihjz2oZ1vPhUWltZDuI8+l3CT3ipKq4v8dGHDu1GlZ5yGKJD7PTsHr0+Crgb8qE2mY83vRfcB324=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726773; c=relaxed/simple;
	bh=4HKk/LFukbUDGcCm7PpiZwJdzEamaMMK3u2W2WrdCio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zplg5SnYI4Knkbs5K/tRheP1WN4SL9UJPEIJS7xLjwriDJgd7uK3AuTVu0TTzOh6CDo9RCAXt8tUxt1XVNuA1TAb42anqFVYVe8wtbJIyWom4HPsTRBJPlOKvm6j9HIOmIq7/rrK2yyU5xjJmJoO77Wnn17pdXUjnH3yovURa9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=G47eDYA6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=q/9bbEpB; arc=none smtp.client-ip=66.111.4.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="G47eDYA6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="q/9bbEpB"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 5A0F75C0091;
	Mon, 12 Feb 2024 03:32:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 12 Feb 2024 03:32:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707726771; x=1707813171; bh=Xlms8ZWkWU
	HMuSbm6JfOSjwsihVm52vqi7v4sacYMyg=; b=G47eDYA6jqTz/RAlKzqhxRXov6
	98r61JSOzmdwvxpRJ7LyoZchKerWAOV8c8kbiQRfe8QsGG/LYXw97VtvOsBewvtD
	K+zvlQbK8+akuqaOO8C4J85vOsDxuSFQ0K3GkMVcnHakLq9HWG9JS4ar0zgIAXue
	zC1eqW08VrEmmtrcEZlTO/eaZduETBfy1ASiSFBvg6wyJyezcAik8IkQWLP8rr9b
	cVQgAf46cKV3fB98bdfarfrbNg8kJvTD14heHDj3Ngq8mCfkC2rdpK08bJJ2nrSz
	Uz+90jOEELBn1E4e3HpgGL/XDcEA3BhRDPlLUdtrouyj6DgEPavpgtJ0ZJAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707726771; x=1707813171; bh=Xlms8ZWkWUHMuSbm6JfOSjwsihVm
	52vqi7v4sacYMyg=; b=q/9bbEpBEkSNmIlpr82kL8QiKQHVJzAWvdGU7GNlAXp6
	YvA49Lswm7QkpRJQJlC6DTC75rHI8ZCNUTqfK5sAttPf93uecbFlsTtFG12ule+M
	Vf5AH9f6i+ED/rsJshd5ivaOnPOLoIjG/ip4asORyzCGOlEXkPU1F/f5Z1yDJEbO
	VMsC+QDudakDP3BSmikCsvsBE4Sy0ebQS69oszrG2bphUWCKLBj6MDQ8kM4f8gmC
	qNQ2WhtqQuDLpcBiAJCqU1Dk4BvefAYAwALV1mcABqE6nnY9lPDwjAbc/PX39KCE
	6/86OI41bbpiQ2ikOrLjHZmIpgHGwlI968GYNM+MbA==
X-ME-Sender: <xms:s9fJZaK7Xb0ndrpfpq9Ig5EAjqw6I76NSGeoGX1_4ztZSr4igDpjrQ>
    <xme:s9fJZSKMypSB3lHoKvnFYE-ImxFiEkTeOuSShKxtuypgiMrHzg0ECvVz5PDb2gpMg
    5Kx4cN9UwXk314UPw>
X-ME-Received: <xmr:s9fJZauO3PbNG7mOlPWD4LbQPTDPG5AHqPsxJcrWNGqBcZtFBa8azv2TjLAxRqjD8IN46z1hzLUz-YNOMA71RGLt2ubnuv-A2ihJhJI4OTXlacs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepteeuvefhhfdufedvgeeiueeileegtdfhgeeftdeuveejjedtgfejhedujeeutddu
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:s9fJZfbMnVi3W0CySaSt9TrAJL7spp9c26xAF8ncyj85du-t44jSAQ>
    <xmx:s9fJZRYNYQQ2BbyckPIF27tlukZRrjlpu4I3NEufdFdFINhT7lQatQ>
    <xmx:s9fJZbDyQrRt_PUav8P1APJJs7Av6VVQ9a8LUtb446IQYYFflRTRqg>
    <xmx:s9fJZQlnnCI_5j659RAUHHS_K8fBAtx6qXA9D2claRCmCeiJ3rpBCg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 03:32:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 54eea43e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Feb 2024 08:29:04 +0000 (UTC)
Date: Mon, 12 Feb 2024 09:32:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, John Cai <johncai86@gmail.com>
Subject: [PATCH v2 5/7] reftable/block: swap buffers instead of copying
Message-ID: <2317aa43b95fc5f418504e9cf24b01048c3dbf8f.1707726654.git.ps@pks.im>
References: <cover.1706782841.git.ps@pks.im>
 <cover.1707726654.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X4EqccaeXrEaaywc"
Content-Disposition: inline
In-Reply-To: <cover.1707726654.git.ps@pks.im>


--X4EqccaeXrEaaywc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When iterating towards the next record in a reftable block we need to
keep track of the key that the last record had. This is required because
reftable records use prefix compression, where subsequent records may
reuse parts of their preceding record's key.

This key is stored in the `block_iter::last_key`, which we update after
every call to `block_iter_next()`: we simply reset the buffer and then
add the current key to it.

This is a bit inefficient though because it requires us to copy over the
key on every iteration, which adds up when iterating over many records.
Instead, we can make use of the fact that the `block_iter::key` buffer
is basically only a scratch buffer. So instead of copying over contents,
we can just swap both buffers.

The following benchmark prints a single ref matching a specific pattern
out of 1 million refs via git-show-ref(1):

  Benchmark 1: show-ref: single matching ref (revision =3D HEAD~)
    Time (mean =C2=B1 =CF=83):     155.7 ms =C2=B1   5.0 ms    [User: 152.1=
 ms, System: 3.4 ms]
    Range (min =E2=80=A6 max):   150.8 ms =E2=80=A6 185.7 ms    1000 runs

  Benchmark 2: show-ref: single matching ref (revision =3D HEAD)
    Time (mean =C2=B1 =CF=83):     150.8 ms =C2=B1   4.2 ms    [User: 147.1=
 ms, System: 3.5 ms]
    Range (min =E2=80=A6 max):   145.1 ms =E2=80=A6 180.7 ms    1000 runs

  Summary
    show-ref: single matching ref (revision =3D HEAD) ran
      1.03 =C2=B1 0.04 times faster than show-ref: single matching ref (rev=
ision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 1df3d8a0f0..44381ea6a3 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -342,8 +342,7 @@ int block_iter_next(struct block_iter *it, struct refta=
ble_record *rec)
 		return -1;
 	string_view_consume(&in, n);
=20
-	strbuf_reset(&it->last_key);
-	strbuf_addbuf(&it->last_key, &it->key);
+	strbuf_swap(&it->last_key, &it->key);
 	it->next_off +=3D start.len - in.len;
 	return 0;
 }
--=20
2.43.GIT


--X4EqccaeXrEaaywc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXJ168ACgkQVbJhu7ck
PpSMDA/9ES6H4uAxD9z5SBADqVYSpsORfCKYVqg0bh7IeftJfdCepiXFWf16lIli
eB8+q/9O4MV/KfbMfJZ6hUXsb81fyVAS8K81nUyQ+fYhSfSic87kz4OID6u2TPC4
/0C1YjyM+v+BK2M5bj2DeoDTWwa1JHPYbX738+4dwLsVl9/JkbgjXFfPh8X6aIgx
I430yjylGfTCJpp5HcctjQ5j3QvtR+Iii0eyKH3aI3o35LwBlMoi+A6e8VpvG6ZJ
jrQ3t6eeWden4Hq3QyWi5vrtThfT/oMkNVxu0ih40aMWoE0l+EGnQySZrxgMOJtK
UjSUxsDNZ2iapBngLV2hWkfS9jbSrQWz+3n9Nv8uoG5BcR9YL1m4RPQ43HcjLTbd
Shg0vki4Mjxjk3aCqXiGPj7d9AZ/F2zF8FKO+iB9HWaj+vAn7PoTSQiN8vAlgfOC
0TXzvt2uLcxbwbcN5lLiWTkYV0r+jV/1xBqMyH4q85vxFyIhp8etnpR2OrKTdJ8J
/ft+JpP45rgSzZ5attUYif55R+Z/Fkxgcd8jfXFlbKRcaBoNLr0SH3pcIEBunOSm
QFVuVsJwZKGcLyjCj89giWk+fUNSZm1jOkAH80JJCzKWQ4G8ovEPRhOnK1lDZxFc
iU9ndjXRZ70ehCbe9iRWTGZCCKJcv0BBlBOWNmo1UY1dIMBZx7I=
=gnLr
-----END PGP SIGNATURE-----

--X4EqccaeXrEaaywc--
