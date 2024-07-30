Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306B6190477
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722324289; cv=none; b=JEjI2GLo5cplUytT3xPyIgvELc1cdeFZcW53LFzCOmGZ8ToiZuvM609OCKZeyLDr2QudRIV/QNonV88+Ey2+BhvpNGFDEWzjMRZ7Z1t3BPJ2NoGIfmfWR4a96HIa1skghXHLEN5geOAZQeKrrUfO2SmQQbFmlFIBHRgiXlm7Vgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722324289; c=relaxed/simple;
	bh=MdzWcQ7yHmgLE+L3VaAlFjj5nbR6WZvk5JcXzy7G/yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/T3PJXpTqWtEz0SL/SKCoRIAD7W+yOs8NmsT/JJYg2zES2CrBU+Krn9IyudeqdMXfdb+m5tPQwAMXwpwQuKhPCJRmfyVn3aheb1IE6VRVvLuViCp422ht870QjhScq2Q5hBsLaKDKbsdDNqrEOE6v2CiINooiO7750nba/8vjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RcZPAePT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zr7XA4cO; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RcZPAePT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zr7XA4cO"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id E71E513807CD;
	Tue, 30 Jul 2024 03:24:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 30 Jul 2024 03:24:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722324286; x=1722410686; bh=mhueC9fQTn
	q+qTvOn1oXUeB616GYuRXAaU50UiNcxTE=; b=RcZPAePTbg+azAGq0eLg6sJVAF
	hPREmCLPq89AWf6eEsp/0T8liRznZFCo8ym1xU9bK8P8rx11KEr4762Hjgz0bTF0
	pd45IAx60KZsSGZpTwHY8IrEbNzuOkPk3Eu4q5Mv1qminOOmNoWcwbd5K1H0yco2
	SnKY6SHVPKHR9gXHN2eWOgsiXpzA/kOeeHOSzAMVBOBTkBHu8eRGdsebKD5tfD3a
	Di4uBVbB0gsl4w5o8ZI9TxzlZlFu+4eGssz4yLWbyAfyCfNn+jQfVYLnF9lFAO3+
	9SA0Z2sh6xVva81+WPWv+fTF22TgJGSY2mseT2lHXbZnbT8l+hgskVoR3GtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722324286; x=1722410686; bh=mhueC9fQTnq+qTvOn1oXUeB616GY
	uRXAaU50UiNcxTE=; b=Zr7XA4cOCYpsZCqKNam27ko6XDvMis6AX0vmFAq6Plzx
	KsAPyq3WSTe/3QNaiX2sm8AUKIBVDmjfmsIGAIWaBxcemKTVVeNdI8AbcOLtYZlf
	DakQvh9gWELe4GKHGKwMKKJ2wmthiEpx09jpguPOJIA16tiKKYoOFc2zq9d1jcEi
	YuwzeqPH59uKrAEriurjZIzTBvme0k95z0ViIR2qkF4QVsqqzZV40u2GPWsSF5Xc
	YgldOY43Mz88tlFmJGjso7p+HOGL66WPKUL28lbuA+fNgR5iW79T9QmO1cDFfMuB
	zVmhwr/5vKPftDBsl//xmR6GWVIxBptZm5YuEiNUPA==
X-ME-Sender: <xms:PpWoZtWYABzmc2DDvLp7KJfeomcBWbal9dDjTi1F-rzHPHSBvmeUAw>
    <xme:PpWoZtmM4lfw9NQlUWNyrDg93bmsFmNpW1D_dJdqcEmtQT_ObNFNwEtlg5XCfCqJy
    2PdLWvEAEFyToW-XA>
X-ME-Received: <xmr:PpWoZpZGbfMxVMLBS42bL_wvgYm-vF1n5c44n1Yuiugbq1XoskvPal5t4E8-Csn5bDGyHBE6Kjmvvy9_NnCyEOhOcTzq-GpgHO1M9vDKJpu0YNY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimhdpnhgspghrtghpthhtoheptd
X-ME-Proxy: <xmx:PpWoZgU-HT5XbG_jcYIiVoC_UblfoAoq6bCQA5SaYNmmZUkZwgBPVg>
    <xmx:PpWoZnmqC3eD7C89BuNdV55M1-36i0T36G5ihgzR54V1f4F1ttsxhQ>
    <xmx:PpWoZtfnksHsM4FxOzRuTEIrnSnluZHNqXHeIZnQu32duxEvI4wqlw>
    <xmx:PpWoZhFyqQYznHkRR0PJ3ZxA-mJD26eK5JbWXcscVk8bG8JPp9ys5Q>
    <xmx:PpWoZgDSFno61EBh9hNM6uhJx1ljOtoPm70Gk-NT9Ny-CkPuVOqnYtcW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jul 2024 03:24:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 412f3b52 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Jul 2024 07:23:18 +0000 (UTC)
Date: Tue, 30 Jul 2024 09:24:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v2 3/5] Documentation: document naming schema for structs and
 their functions
Message-ID: <25f73b970dcf8b1d1e7629f75c157ee02cd10809.1722323818.git.ps@pks.im>
References: <cover.1721818488.git.ps@pks.im>
 <cover.1722323818.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="D+PG6mn5S6aDv44K"
Content-Disposition: inline
In-Reply-To: <cover.1722323818.git.ps@pks.im>


--D+PG6mn5S6aDv44K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We nowadays have a proper mishmash of struct-related functions that are
called `<verb>_<struct>` (e.g. `clear_prio_queue()`) versus functions
that are called `<struct>_<verb>` (e.g. `strbuf_clear()`). While the
former style may be easier to tie into a spoken conversation, most of
our communication happens in text anyway. Furthermore, prefixing
functions with the name of the structure they operate on makes it way
easier to group them together, see which functions are related, and will
also help folks who are using code completion.

Let's thus settle on one style, namely the one where functions start
with the name of the structure they operate on.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/CodingGuidelines | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 65fba3b810..a6a1ede204 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -541,6 +541,25 @@ For C programs:
    use your own debugger and arguments. Example: `GIT_DEBUGGER=3D"ddd --gd=
b"
    ./bin-wrappers/git log` (See `wrap-for-bin.sh`.)
=20
+ - The primary data structure that a subsystem 'S' deals with is called
+   `struct S`. Functions that operate on `struct S` are named
+   `S_<verb>()` and should generally receive a pointer to `struct S` as
+   first parameter. E.g.
+
+	struct strbuf;
+
+	void strbuf_add(struct strbuf *buf, ...);
+
+	void strbuf_reset(struct strbuf *buf);
+
+    is preferred over:
+
+	struct strbuf;
+
+	void add_string(struct strbuf *buf, ...);
+
+	void reset_strbuf(struct strbuf *buf);
+
 For Perl programs:
=20
  - Most of the C guidelines above apply.
--=20
2.46.0.dirty


--D+PG6mn5S6aDv44K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaolToACgkQVbJhu7ck
PpSExRAAnrdDOR8Ut2614wy/l7kWwiI5gXfAjtggaV0ouWQROgS1xXG9pBS71I8d
BTc6iSOAYpu/It5QX5aYYKKD0ekHlm9iNKG9ti8sLgmKIzsZokatIID4Xe7FzBMK
hggFVviYDcThuagIQBRYS9JronYxBU6jov/JXL/tBIIWaWGjzb8Znj5kVe+jrSmb
UWCEp+MavhY+SddCz6V4uq5G0lxHs30a327kRTP9sZm9U0Bf1/4S5e+eIQwDg0Mv
pOw8SQp/YEQTd47SZkBOkSh0f4orq3BP+RFsx3eHg+XEnMO5FE1on3uvK0sXJg/K
QeQf4avuf79mHSKHJqGPEnv04G5gzk7LYrD3hW8NmBtcv7PUfKvhHwkg9/mkwan8
wl8K2QcUaqi4w/7G0jaNS9nnYVQXXki5mKRMreX9ydttRLbGoyNdV7oVBuAvrIRY
/+tmGucBiCEoVn1/fPi3fX4GLtBcMz+4kkcEcuMLPfiw9FKsxcUOSPuwCy6wVlbp
BmSxBb53wD+ShIn6K+E741w6Pb4i6QmB6Rehqp29kMYssWr0NR8/wQA+qCQKU/md
Pz5gRcOzptAITNKP+3dAsMNns1JfrjdezxU9kDPmmSJOCLxQD8i0nx802g5n20TQ
WZfGRXc0gfBBY9IocKxN5yYqs0s6cIliE1armoYv7+51t71gs4M=
=xbOR
-----END PGP SIGNATURE-----

--D+PG6mn5S6aDv44K--
