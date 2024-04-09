Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579A182D62
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656659; cv=none; b=Cya5Q0O0+w1YCznT/77l75T/50VRi6OV4VDdNV48uAnSW95jduaiD5KD2Mt35X5zzqbgG+5a3QH2cyo8FAPSA1m0EDbX7/8iVJQnFCMyU/vuXrEEzSfzjeCGljDSysAMiOfhky/JUw/RlADl+Yo+Utu+6jXy4VPmT+6ELVblH50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656659; c=relaxed/simple;
	bh=Jvv3w/m9ZBENvpZYlW1kP6Y2rEEX6QHvqoznvSwP6oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgVf4a/ZcQ+XcSnClvGdCTTnigMN0SJdOXs71rmZrCVpkFUcxunqjUF6Ji/FwvjCuxAYhFmLljn3ArwA2F/9fz3gZ8RnWcGP5YVXYMPwekkXNa0/MyUzRdhyhK+xzT+JwrMwB7JCzJsElNHdqLbzZin1xIZesCQcpt18d2Ytgzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iz6MVXCS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sllzSX0X; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iz6MVXCS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sllzSX0X"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 168B6180010D;
	Tue,  9 Apr 2024 05:57:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 09 Apr 2024 05:57:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712656656; x=1712743056; bh=bA/iDYX+W9
	PfoMFGcyRgqOHaAbgGUfKgt5wfG+J1C60=; b=iz6MVXCSsBJAO6jvnEyM4frn/c
	JU4dmQpIeWbZAn2JDC/OqTxsV9+gCPyHwmYVit3kekYYlalUVl6HVT77q0RpS/Wa
	Xwomo4hYQYjtPk6VmXOlJEMyfT86mNS/mQhn6sauJYVwlQiofwAN+Afs8ezYmGcH
	bWZ8X1I8rMgeKisuvsbim6J1+FQUQEpAG72LgCTiNaegdwk0cAssG7jMFbSUuEGo
	ro3SfwlfAnwltXq9u1rGd1mZDbNHHMkMMb8VWQ06MA/xdxlhj66+Xmd2xqyJISqy
	V0Us9voPr+pp8yzv25iM2mVgEj17s8gw/y6Gcd4GSERCyWH8GCDu7xltMxAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712656656; x=1712743056; bh=bA/iDYX+W9PfoMFGcyRgqOHaAbgG
	UfKgt5wfG+J1C60=; b=sllzSX0XcCbdQBohTG9ne7qliaQ9bXjr7Bv/T0VIxbDv
	9wdgqXsiLlFgGSvnxACMzIRx6gc86PTlYezuVPxVv8qGbl8wxmTNScHdnSBr6q6a
	CR9KMVriPwIFCiN6j6vvCbwXnA5Usen7kdNs8sXBugAMrRKT3NA8Sl/UFiQx0L+1
	+9zZoBTGmtH2azKQQurJvLu9+IMCYnPJj5eHUhPt7TDPnK7G3f/ZS+bYFhSdU3hU
	8nuvfbddoZHJGXXPw5EM/1ArVm0oD2aRV0A9CYA42a5jJ2kpNCm3O0sjXg1eSFY2
	B/sxMOP515MWgeI7L2DjJ9szzF7MyoDPQk08SiPSlQ==
X-ME-Sender: <xms:EBEVZik_MTX7HjJGdnmuJo7XRpUnEHPEJbmqXdENqLsdQUD5S4Wpjg>
    <xme:EBEVZp3WePTDXyNOxzLAN8lxwEugUijQtUqVvq3FSrdqUGkx9v4jrO7B3C9Hm0ehc
    zJCEpgFSGKdZAliVQ>
X-ME-Received: <xmr:EBEVZgrHYJ6sqs7yAEBBD2mm9GTwv-URGQo0amt92AkvyjhRHZgSW7SWZmt4L4sQBWzw6VcOhYsYa_H7D37-3yUaoaChq3MVKbcJt2g_j_-TiCntPjQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EBEVZmknI9Da828w5E_qf5KeCGOT-adMZZEyKLoZFS0ykoTqv0fN0w>
    <xmx:EBEVZg3ib9Ptw8zwqn7uFoMjq3mIEBJGhERr6cCPiBbEO1LnQu0RdA>
    <xmx:EBEVZtuJnbZ1OmBS8E1phNyqwiXs7-mtwNhNFb0n_pL69RNeu60jvg>
    <xmx:EBEVZsUFcL3BLm_nYnTwOjQNPnf_7uAa1exob4DZa6YLPDrPi6P0EA>
    <xmx:EBEVZqrAAI6GNEi9gGUuU_8ij5rk0F3ivDZVvIW-0C1nzc7hYFv-ulG_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Apr 2024 05:57:34 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 53df742f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Apr 2024 09:57:26 +0000 (UTC)
Date: Tue, 9 Apr 2024 11:57:32 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] t0610: execute git-pack-refs(1) with specified umask
Message-ID: <a3bfea94365138e85cac473a83eb51e821dd0def.1712656576.git.ps@pks.im>
References: <xmqqle5n2sbf.fsf@gitster.g>
 <cover.1712656576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ooVc+z1WQQmYMzEC"
Content-Disposition: inline
In-Reply-To: <cover.1712656576.git.ps@pks.im>


--ooVc+z1WQQmYMzEC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The tests for git-pack-refs(1) with the `core.sharedRepository` config
execute git-pack-refs(1) outside of the shell that has the expected
umask set. This is wrong because we want to test the behaviour of that
command with different umasks. The issue went unnoticed because most
distributions have a default umask of 0022, and we only ever test with
`--shared=3Dtrue`, which re-adds the group write bit.

Fix the issue by moving git-pack-refs(1) into the umask'd shell and add
a bunch of test cases that exercise behaviour more thoroughly.

Note that we drop the check for whether `core.sharedRepository` was set
to the correct value to make the test setup a bit easier. We should be
able to rely on git-init(1) doing its thing correctly. Furthermore, to
help readability, we convert tests that pass `--shared=3Dtrue` to instead
pass the equivalent `--shared=3Dgroup`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0610-reftable-basics.sh | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index a3269c20e0..8ffecefadc 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -105,8 +105,7 @@ test_expect_reftable_perms () {
 		test_when_finished "rm -rf repo" &&
 		(
 			umask $umask &&
-			git init --shared=3D$shared repo &&
-			test 1 =3D "$(git -C repo config core.sharedrepository)"
+			git init --shared=3D$shared repo
 		) &&
 		test_expect_perms "$expect" repo/.git/reftable/tables.list &&
 		for table in repo/.git/reftable/*.ref
@@ -122,9 +121,9 @@ test_expect_reftable_perms () {
 			umask $umask &&
 			git init --shared=3D$shared repo &&
 			test_commit -C repo A &&
-			test_line_count =3D 3 repo/.git/reftable/tables.list
+			test_line_count =3D 3 repo/.git/reftable/tables.list &&
+			git -C repo pack-refs
 		) &&
-		git -C repo pack-refs &&
 		test_expect_perms "$expect" repo/.git/reftable/tables.list &&
 		for table in repo/.git/reftable/*.ref
 		do
@@ -134,8 +133,17 @@ test_expect_reftable_perms () {
 	'
 }
=20
-test_expect_reftable_perms 002 true "-rw-rw-r--"
-test_expect_reftable_perms 022 true "-rw-rw-r--"
+test_expect_reftable_perms 002 umask "-rw-rw-r--"
+test_expect_reftable_perms 022 umask "-rw-r--r--"
+test_expect_reftable_perms 027 umask "-rw-r-----"
+
+test_expect_reftable_perms 002 group "-rw-rw-r--"
+test_expect_reftable_perms 022 group "-rw-rw-r--"
+test_expect_reftable_perms 027 group "-rw-rw----"
+
+test_expect_reftable_perms 002 world "-rw-rw-r--"
+test_expect_reftable_perms 022 world "-rw-rw-r--"
+test_expect_reftable_perms 027 world "-rw-rw-r--"
=20
 test_expect_success 'clone: can clone reftable repository' '
 	test_when_finished "rm -rf repo clone" &&
--=20
2.44.GIT


--ooVc+z1WQQmYMzEC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYVEQsACgkQVbJhu7ck
PpTmgRAAkqGHREWX4f4EaXZL15hb1XiHWKtLT9tWuVtPYfm4Qaou3m+hFcTXy+8A
C5O52aFC1MJ1myd7c0JubJummzm3VUiCD5NOGFl30ibVNPJnYwNWsGX+jUjz5tgk
sdI6fSoZqr7xtltU4CWOVBPsLCh1T/Z93WJNjEDuoyidQF/3XEyuDHkVnFc7tT6E
zKrvJpjp9k3fpmLE2YIsx/DBh910IQc9dU5HEnOD7rsO0GzQpJlmgKZjUd5H345k
BxN9WUmm/N4sufekwIaJTt6EPbqkckTY63B13zYdfPUi8vCAexJJrM0v3Vn+MyVQ
wyjVjci24Npx8PCVey+76frS8JyzmwTVx29HPgIh6/ccy0F6r4FtUmGzP/zGSYhh
3+7RQk6Cq20O4FihWn2xVNl/gXBeiJfsqYmfmLlF8UbgFQ82zVtOnlCOpVQ6z9wX
Chf28v5tGMqKlSlsdmMsmc6L2ymiZtpPmj4mgG2nLuRB03vNPzF7pSGnqGqRTGdo
IUzzlV3vCC9XOxVSy0Z3arptVdtwxsvQxeOE5/ML0plIxeDAijou2Vo528JXREKU
ciYm5Ka2GdWfqExkIZLl+q6YeNSuMIxwBqKHGNK8S2O8L6WUKy6P+VBuCF0sze5H
n4PiPB4RG6oUzgnQ/MAG04Ky+u2yznyexInc2+iw7mG5iYAsTWQ=
=HJ3H
-----END PGP SIGNATURE-----

--ooVc+z1WQQmYMzEC--
