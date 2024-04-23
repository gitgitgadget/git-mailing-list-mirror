Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36FFB208A0
	for <git@vger.kernel.org>; Tue, 23 Apr 2024 05:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713848893; cv=none; b=IrqjxpPJMYfuyAw11PKNIptMN9q1UIMUfdzGaUoi4EhSrv1muoCzeAt3py5206TI2fIjF42mmS/Z5eJdRQ7z0gsD1H/BFJfchmgwOB6CRqF6P1rjmW3yrapphE3RCiTt8QKILPVyauK+mDHTTK8wJXGf2aSkWByJ0M0SnoX5uQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713848893; c=relaxed/simple;
	bh=UKUB9B/V9JsZYKzwN0BFyVIxebH+1vn1kxQ8Lv/A0wg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ofmal7W8olZepgOd2QJwSf1OAP6WXItgkbYDMTVzp5HNdp7F1QNfK1jo5ehU+mfqH8sCYcMQO4kbJCSRpUgk2GSQbmlVTNirQGTAJqV3TT+ilsNhsszVBVaDjWX8wmy4H+JML58JzrZh8W7FfW66i+IyUlHpLFNpeROnzdmEMP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=azj+s9P9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D1DVqzbm; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="azj+s9P9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D1DVqzbm"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 46CB21380252;
	Tue, 23 Apr 2024 01:08:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 23 Apr 2024 01:08:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1713848891; x=1713935291; bh=HhU6cn4JKp
	YNWYgHZ3V5HAK3yx6kK/Fspr9w9tB7KaI=; b=azj+s9P9StK2XQKjDolkWErCrU
	3cLSVoHAZ6G2wIVI5KirJptosKmPKGiWsBDyng5HmqCMGWC2zhRnnnGH3GuONxVl
	1DQtwZ8x5RaC02wuMVV+nDTo1BveMqbp1WQI+xhUwVejHuErni0voWaxGewtnhNU
	1N49k7BuAazyPBJXMkKeaIwMEuMEOR/uti2LfCn18xHX7NTZ9KfSkaIO23SPTH3q
	V7xpUyCvv+BIcsBQ9Gb9s2m6CstK3sk2o3IWjn4B6OtuXrgpTq43gRCkVbOcFOPV
	agQ10J9OrjxXil1yJlkRDwxJNqZ9Q3doBgB48oENCKvvWDNsHUTCLS7vsHTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713848891; x=1713935291; bh=HhU6cn4JKpYNWYgHZ3V5HAK3yx6k
	K/Fspr9w9tB7KaI=; b=D1DVqzbmJ7ySOh5jBeN1SjKe4FRSSqejdQhx+MfVQ8O9
	vo3I+hO4eNhI13lnh9oDoq/qrqn4UPmy/GZdMfwcZKnyKKoWPW90c4olkpFfJnkG
	fOLnPbZXIuCQI2t2fZNf5VriPWA1Ud5YnYWO3ZaRrgjog/2srD8VsQ0BioDCNJWS
	M6qI97a+oYeufwGBdjN+aUTSAGvOUBpiJ8l0A7gA0zeU5Zr89DmVwDvquvPsJ5vs
	VM/difUXQPuXGQyl1/bjIQxvShNO+r5gL7Kbi/LhOK6FbLe6YvF+9U3eIsVSx1sc
	mTys9neGZEMmQyJyBFlUP0t4MeEqzGGbf0Fz5soTgQ==
X-ME-Sender: <xms:O0InZqpUdxgvJCMKiW1cYvPPTqGdwtZoM3rGxpxuIrvu2GzCFprYAQ>
    <xme:O0InZorkjWF1g9bDSm_HxUX3oVGr56seuht_OsyNkJohU6XgBpJF4uVbvR9CDqIHf
    wonYCfQINrFSuE58A>
X-ME-Received: <xmr:O0InZvOiVled0_coMQiiMu_rCIJEs9-CLvCysNHmUmGdJvIIDXSuG78I-nzW7JxDg0pbvji56tEKtqNwlU_MqQBGjk_YlaXflB3VVfF6mIN_tzAj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeltddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:O0InZp4fMT0yoll1R-hfy62eu0fqmrkrdVYTH0mQsjKth3wIWZo5jA>
    <xmx:O0InZp4uPpZbv1eZ0S0GH3xSeuN3ZEaIatfv9vfcgSxvjbObDFIv3Q>
    <xmx:O0InZphp6lT74tSVPO-9WX4XAZMBXx5PrMiJ4U91d7xO-XoxsAaSLA>
    <xmx:O0InZj4Xa10o0GSG1AfkM1ZnUPm6MKsrniQYovy7Q_0Id_KeBai4iQ>
    <xmx:O0InZs0PJcGtxlyyydNOpDBZXE5xaZGouPrgn6kh2gy5r7LhvNJu-eEf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Apr 2024 01:08:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0bf4843e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 23 Apr 2024 05:08:02 +0000 (UTC)
Date: Tue, 23 Apr 2024 07:08:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v2 09/12] builtin/bundle: abort "verify" early when there is
 no repository
Message-ID: <31182a1fc6a0123dd94fbfc3dce2bc49d7ff6086.1713848619.git.ps@pks.im>
References: <cover.1713519789.git.ps@pks.im>
 <cover.1713848619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oJetrBf/Qu9tt3UJ"
Content-Disposition: inline
In-Reply-To: <cover.1713848619.git.ps@pks.im>


--oJetrBf/Qu9tt3UJ
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
2.45.0-rc0


--oJetrBf/Qu9tt3UJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYnQjYACgkQVbJhu7ck
PpTQsRAAj1ghS99H5cRA/i1EItVtQjWqtMFZvVH6kfjgDindgHUEAs+9fRWuX34J
S6bCZD9Ul9WUrUWXs4EvVajjEp0sFnpwSA62q9KMD9MkcaW+2+gBrBPyZNsnY2Ed
Adbu5saykB5bwr8h2zrlbYL/XiUOIBjw6Ff3hJK9PvQxUUrUHpLJT1U19oLpzEia
LupxznSwe7hytfKutmdX74h5L2VuuuEE8hqT0pSzBVhoXFH1Nf5Cq72RfXdaQrmT
BYvcjUe9pbi/21rCo+8TEP6TIU+lerbJQThVmsh9H88Hn/MkAaqsbCYVwQetcfkR
ebN5yw1moAHda1H/dmjgEw1DsQ6f1F4eF4cGcbvG5R7VJeOjtpqe6+YuFTVypAsa
FmXsBJQ2XK50j3Lcw/tmFy6liETio9umiT7HnxU3IaybepqF/oFIusE2TVgwVW2w
EQuG0B0Azzyfp5VYsF5rKmAHkikrgTm/btDw5aNjzyMs+LQLtmI0640m4VX1lScl
47z0oPpoN6e3R6DuqsmmgcX1YO5hTRSqvie2cldGHCurKkQIQlEC6B/lRY2CwwES
65d2FDXZpsIHnHsrmqL0IGD5xxUuT2S7t3WRXuslxx5ezhCpNAiZQtzBzV5FXrox
QVyK7GrHbHuooNPWWeonU0SvsTuEUanuEpEez8UWRpIOXTbpVqA=
=kcWM
-----END PGP SIGNATURE-----

--oJetrBf/Qu9tt3UJ--
