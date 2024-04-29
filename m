Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B756134BF
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 06:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714372497; cv=none; b=S1EHL7lsjRctSDKE8TYL4fv/KeVXzUDbTGUEEiwyaVpFnwt7AQJ8reGaG2yR5BDdtl2S4Qk3X/Fr5VoGZMuvc4n94b6Ap7IznBpLEcfiE8k61hkITE0gA/vTzZ2eBS2AN/PMn1E1JxZa2CJrSgPla9e4mlOQ1smnQBHAT7jfdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714372497; c=relaxed/simple;
	bh=DiWouTnhsqP8DddfWFe3Ffs9WYgPVROVTySbRqtUXrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P1lj37lTbfFYqSHZGe7IHAN34ocv8mpXjeWcLxn6z07KmN/K2zEmEej0jwhV7AvezTdweBhOFnp/J77IibfQFagqCbbpjgcqnxmqV3DJ4lnQ+nO8zIKr7ozK0boTUMLtqWnztPP8FML/NtZms7uIWKBXZhqsQfQb3CtEWqmWV1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I8Cmm11M; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=M1VXn9rO; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I8Cmm11M";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M1VXn9rO"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9C96C138038A;
	Mon, 29 Apr 2024 02:34:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 29 Apr 2024 02:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714372495; x=1714458895; bh=P1ofyXoaHM
	yjdvFs1HWBS0/6OJLwX/IXpg/BO6SYGjA=; b=I8Cmm11MJY2w2XcPfrydFakPOk
	SLlSpBcrj9MRJ8wdJ/u2E/0iYylHLx7rhZ4dNogj07DrRL28GE6eh/EcNsX+3W3k
	NJv21gtcLCQ3v9kLhxh/7hTHXpip97FAlw5VQq249dEhibxixbqSM+H9qfZhU1SO
	maKW0pgwbBz7DmpUM3t1Ck0An4pJyMfOlSz2IrWJttXjsCgcfkYPQb2TatvNOOb4
	em8PEC4+iGRhgzHcuscNHLEVSC6U0crn+FnoIOj5njOP+BKet0NkMG13YkUP0LQ9
	DwVYzYbwQrdoh7PVAX3owgE3Ys8dK4ZOOs2Mf4/1y1dUPbBs0EGoCRYQAAhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714372495; x=1714458895; bh=P1ofyXoaHMyjdvFs1HWBS0/6OJLw
	X/IXpg/BO6SYGjA=; b=M1VXn9rO2USuI1vrOu8cZ1tDuRtI2XpvcbgNewaWMf+z
	R/GujX83maxxo9mJo5fw35XW3bSZvJMCIb2H0mxMkb481XUjA7kcphxNeVnsY3br
	FmPQs8XAUwO/eN9cVcgqkBQMzzxILPYEU3yX7wQah9ZShsHHw1A8MF/eWPxP8CPq
	vyX3fa0P5BTk7qePbhE55q6FQSlxhlm/bNGRHn8yZ24QmpeXWApA31Ru/vKDN697
	9FGDbEGcHV2yxg1N8FcHnVO9NPkh1BXfIhDu0ZRupUR74R8pAdZZBU8mNPUmkUEL
	5ykD4MpdrUW3CJT4VOBJ5uzopbSRTTlkhH7HDnQqAQ==
X-ME-Sender: <xms:jz8vZkQOY4xKQS38LtZDfi3kx_qJKurvs0bDlc7JwVNl8PHghGj_sA>
    <xme:jz8vZhxHpCsL9iF0dXkRgjI1Z56iCk4m4XdtMWO4JJrtLrffn0zZqWgLjAqoIeOvt
    c-JjEXXoAzuCd6b2w>
X-ME-Received: <xmr:jz8vZh3HBfoP30TtgmxeC_NeqJCXU9-xjP0FJH_CEzvapTGPOihK7jR9wAQ0yimidUQwf6MeCec0nNm1Ty1vpaWYNXLzlxTGJraP7wLmCq-H4RAY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddutddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:jz8vZoBB-Z7rZg7c_IQuXfzudGI5qW2_DvLPf5efY7nctuFALiejRQ>
    <xmx:jz8vZtinPT96OKd80ywoJ2EjxmyJNlyst88KcNUV2-rNcF_VupcXoA>
    <xmx:jz8vZkojE94G64aQZqWDEZuPdtedRUUlOtYmcvacPzEcxue_H2jJNQ>
    <xmx:jz8vZggUsOaN5JAiPqkUPOtmmHeom3G5-Pp_tRpDfAzLVDQMqwfilg>
    <xmx:jz8vZtcbPUuh7llzjkqPSqQbcKs8rXuQYSvhXYTkdwv1o-J9kbq7MRL6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 02:34:54 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eaa4bee7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Apr 2024 06:34:35 +0000 (UTC)
Date: Mon, 29 Apr 2024 08:34:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 09/13] builtin/bundle: abort "verify" early when there is
 no repository
Message-ID: <f3b23d28aa7443052eed80c1fbc90c994c2c910b.1714371422.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1714371422.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5GNjcsNY7S4YCjQ1"
Content-Disposition: inline
In-Reply-To: <cover.1714371422.git.ps@pks.im>


--5GNjcsNY7S4YCjQ1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Verifying a bundle requires us to have a repository. This is encoded in
`verify_bundle()`, which will return an error if there is no repository.
We call `open_bundle()` before we call `verify_bundle()` though, which
already performs some verifications even though we may ultimately abort
due to a missing repository.

This is problematic because `open_bundle()` already reads the bundle
header and verifies that it contains a properly formatted hash. When
there is no repository we have no clue what hash function to expect
though, so we always end up assuming SHA1 here, which may or may not be
correct. Furthermore, we are about to stop initializing `the_hash_algo`
when there is no repository, which will lead to segfaults.

Check early on whether we have a repository to fix this issue.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/bundle.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 3ad11dc5d0..d5d41a8f67 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -140,6 +140,11 @@ static int cmd_bundle_verify(int argc, const char **ar=
gv, const char *prefix) {
 			builtin_bundle_verify_usage, options, &bundle_file);
 	/* bundle internals use argv[1] as further parameters */
=20
+	if (!startup_info->have_repository) {
+		ret =3D error(_("need a repository to verify a bundle"));
+		goto cleanup;
+	}
+
 	if ((bundle_fd =3D open_bundle(bundle_file, &header, &name)) < 0) {
 		ret =3D 1;
 		goto cleanup;
--=20
2.45.0-rc1


--5GNjcsNY7S4YCjQ1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYvP4sACgkQVbJhu7ck
PpSznQ//dbxUrqtmDuNSUWs4sl1ltXc7/LkFI++iK8GdV+wsVki+8PyN3ld90zci
43QGohepAyJU+4PHu5z29pQ5EruwcQ+5AzkYT792R7BZoezXSylM7f5Oun8MExwV
adBr1lLQYv5dIY/4Mm3StJzM77Q+aZENcRul0AckhvHRm07RbUYX+qGEVUgoqX1/
S7ksSe+1td8vEgS70KMREKtI8U2a0Y6lUQQa9mCcQXtTkrx1/mnG2BiwRz2DX8+M
GnNbqnWBKgapgfIM+p6SuPMsIxh8jbdZUkq3p3eiz+5b8g5qJ04+AQT88T5AyS60
nlfes4j2R2PyAKyEIdxYlyGXJhavWFUnSFRkAvEbvn5MH96GTeUcH2ESvBGXbLce
/Nt7BHtjzV6MMBNIhDUmYgs1fnN1y4RvHmglE0nCIxJR7oD4vpLbuuRBjZEFnHyh
CpAzMSNJOHjkRt2xmnRjLSGGoLVhf3BojJmxaeGMlq4Lov5YLdACMAS8jDfYxK9o
K/RpfNHALrycQ8dRuAK4UsvRp2sph2isuB83vKrmXPSSZ0BigyZTEN6oi5rK8r1U
49CvoB2t4FDHOEADH5ZGw7dCP1CtQc+22y9uY3VbViY4n7Fmt3+nY7kn54EYQhl0
gifRfgtR+e1dipsl7UfJFwMkHezS214jDB3wWnXpspcXNEyA2k8=
=BGww
-----END PGP SIGNATURE-----

--5GNjcsNY7S4YCjQ1--
