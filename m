Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF6E5FF1E
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 11:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526464; cv=none; b=oSUUtyylvRJLbkl+xNP1xH4392ZsYdMPKvHxr3GxTjttr0eJI25OsZvkgsQ95B8GTCO5v/YXwBKItmWUNkXN3hyEn4MpkaszpS8zUDX1g0ViT5morNDrr3QrHwYwrhpAbufAZsCVO8+ByjD5Llpi1BMQ6Fgo4mb2T1wKZA19YoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526464; c=relaxed/simple;
	bh=iOYYorZj/B8H9xZYiefcRCXGBTi+WFz7xhF/V4FbI5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaqBqCcJCZF4KE1lGzonTOgc7R5Iqm+UcmrKHPXHxJN8hD8Rl/iBVy/ijSopXVXfV7jTjUEa30nZ70hKVgq6yuna3URB9hB9XJ7+YLy20su1j818v/7XxoKFVmEL9ec+LIRWo+GFKJSEHys7HyKeLXgAusj6VkoFcfwwINg8BZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IwKVV1fn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lvg9TqkX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IwKVV1fn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lvg9TqkX"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B70A5114009B;
	Mon, 29 Jan 2024 06:07:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 29 Jan 2024 06:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706526461; x=1706612861; bh=Ja6PFkyjAH
	G3jJmvCXf+nI3vXwrz6JnSZNSEutvu8sY=; b=IwKVV1fnYWOjZke+OlUkfBoVGY
	JH/C6gJZPLChUAv06wWpjyIgVTwOf/YhwK14HxkQYNh1XI/eRzdJAYucE70IKrQv
	DUPkZif4T15rh1Ok9xb7fMIT/J7nxrCCLO8zE/QHVkZnSy2KuG0ZkRkXkfZcLpmq
	cqJ0Ki7pBMWzIxVsF23RfMPtwJi/fA+SsvxPAA8cknG7RlMjQmPiqylqBn7N055O
	APJoF/1k6CVNf3+7uiMT2nZ2tpv54PhMY7B2FoDmFgP96Ou9V/7FkCU2EWbrt3eo
	jHRhHycPomqRCj4Yj2jhOYm/LxSWPy7jdfUtfZ4mVtPlWWRzAKsGE4WL81Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706526461; x=1706612861; bh=Ja6PFkyjAHG3jJmvCXf+nI3vXwrz
	6JnSZNSEutvu8sY=; b=Lvg9TqkX0+uJP8ZwNBXV3MqoJN4F1mhYQ8XoJwhSlO5W
	3aKh/1qDD9gF1MAhCVrzrL+qwVIa4XP1rk0YyCewPMEsYa6XSvqIngaVgVSemz8e
	YCfUXMnNUMztas6bcs5EVJyFCPL1g2reJSEt8gcexpN2yS1M5WUJ0hBfevjqIysx
	XHqWwWSqAJ2beWxXJzLoSbbYYVCWvk97pq1UiuRLJsTBRfdOoANDFJshgd7SYizB
	broz7ZS3lca3nnT9NscomavH+wVSP8vWYMHUBEnvdA1uJDs837XJvbBINp4d02Nt
	m4kvM3+ouFvdlzJLd7kAnGtoLaslMHw8iYDaR14Dxw==
X-ME-Sender: <xms:_Ya3ZdJiagKYZ91dsYT7vBh457-ctMinQXpWWVbhbPSSFLPZm6bFoA>
    <xme:_Ya3ZZLbohm-IpE9EC6Enbv9CEPNmqpWCuOwwFWyWYjCN2n5wAhnjNXfaImyPBM2r
    TvDNkM4qHEY2DjPNw>
X-ME-Received: <xmr:_Ya3ZVsBlTmEswem1uG7V8SuxruOSQLnPBpMP5GFZbTlBOcEaxwucv97fKfJgBfHpUZ8WyndMQl16j8-_iuwamE5nvVLTVFjMdiBQnJ8eiME8Tl8qA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedtgedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:_Ya3ZebBcNKi1YF-I85mIFU7dSZJPzZvQZ0AVi_YBAzowIZFj4Vo5A>
    <xmx:_Ya3ZUb3glgM3fONUigTPdByL_pAPNdps2DoXDSy_cCxFZvuTAYUoQ>
    <xmx:_Ya3ZSDJWoOBICurzLtCvF_uOgmGfhEm_ZfuvVqQE-gxIQXSF5AwVw>
    <xmx:_Ya3ZZMgXqQ8Zs1vEUa9Iil9zOATnbr6qfVoBtjmzy_xBzWFg1UCkQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 06:07:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 99c31da4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jan 2024 11:04:23 +0000 (UTC)
Date: Mon, 29 Jan 2024 12:07:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>,
	Toon Claes <toon@iotcl.com>,
	Christian Couder <christian.couder@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v4 6/6] t: mark tests regarding git-pack-refs(1) to be
 backend specific
Message-ID: <53aea8236dbc515951c25b27cde65d948523cde6.1706525813.git.ps@pks.im>
References: <cover.1704802213.git.ps@pks.im>
 <cover.1706525813.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LnhNHISFmnmPcuU1"
Content-Disposition: inline
In-Reply-To: <cover.1706525813.git.ps@pks.im>


--LnhNHISFmnmPcuU1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Both t1409 and t3210 exercise parts of git-pack-refs(1). Given that we
must check the on-disk files to verify whether the backend has indeed
packed refs as expected those test suites are deeply tied to the actual
backend that is in use.

Mark the test suites to depend on the REFFILES backend.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1409-avoid-packing-refs.sh | 6 ++++++
 t/t3210-pack-refs.sh          | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index f23c0152a8..7748973733 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -5,6 +5,12 @@ test_description=3D'avoid rewriting packed-refs unnecessar=
ily'
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+if test_have_prereq !REFFILES
+then
+  skip_all=3D'skipping files-backend specific pack-refs tests'
+  test_done
+fi
+
 # Add an identifying mark to the packed-refs file header line. This
 # shouldn't upset readers, and it should be omitted if the file is
 # ever rewritten.
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 7f4e98db7d..c0f1f9cfb7 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -15,6 +15,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
+if test_have_prereq !REFFILES
+then
+  skip_all=3D'skipping files-backend specific pack-refs tests'
+  test_done
+fi
+
 test_expect_success 'enable reflogs' '
 	git config core.logallrefupdates true
 '
--=20
2.43.GIT


--LnhNHISFmnmPcuU1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW3hvkACgkQVbJhu7ck
PpQw/xAAiVfJ5DpGn4f4w/JMzRWITG++AB76gyYlc6giy776SEDT6GG65RE397dp
DY1CGQe0R558RuqRr9sifQMjuuscJOlO0cp9sbSLcDC0nwWXAb2mOjtTtLAqVsP2
Hq/TsfzkQRsP1CvI76KJAPAc59XLrECTNBS2giHHFUTOBzq5ETfAKgmMkjGXS7DZ
XyokszN0/itfD3ofzQDOHYLIog6wLjLFcmVibRtnVrXiitsSvznIZzYvulbmOveB
aFMTllAL4aLeKlNAyLzjDSMxu25Jcu2Kfs8hzsN5fVHxiwFRpA/iup9IdepQuTrK
+uhGmB8nSW22eScxBNVfDQMfF4kvKEJ89X68BKZcX2CevOfLRiP2Y30DzIUoEKbm
pGgMrGuKXgWcggYZ2/Bp7enbLUJpbMigoaBt2aYxy7MXkzMJ/RbxL6OKim1o76d3
/H1IO8ix6VS54lrOAOYCgxZc1Ys5f+gDzJ4MbIbtk1HR9L2u4fUZX4Zv9CakEcbM
f8uXKlI0O97fIaDg9Y5Bzk5ku822pW0rpZDwDPvJbe0HVrMR5gWJPLby6VsMsFwH
4b2YNO5kg05j1RtDUJEz0OcH/WcabQy86lJBiMe0oeuOPWB1RiFZ5Pray2OtSddE
B+MLLcWm1tdqj4U9P6fCJ3A0voW9ghLxUWQLsWfHcnue9iC8pOQ=
=jczs
-----END PGP SIGNATURE-----

--LnhNHISFmnmPcuU1--
