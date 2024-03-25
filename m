Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D0912B150
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360980; cv=none; b=E2LmCVqogwWsisjZDZFuMOox7MwFPQLnaEW/KKLn2jRnignSRPKkhxstZ/pS5BqSy62MVJuZtWTI1O7LYPLXotJeV8BDK1pMSVXH1WyqDOQB86o/Z3eO0Q8ti7pUUj5GCB2HFcIKS5B+HtEpMVaY5JRi6wTUilkVVjC63EX4Qj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360980; c=relaxed/simple;
	bh=Dag3uSfsvMAMrnQlKlshyBZUiai7vJ9CiQCu2qRrnI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EO+XBzN2t8GHcefHu3jdzgAEdBoOMty/VRpfgRwiKYzQTkvihTM+2Ap5HlC93VpijqSkgcANmR0jupeWGRrq8V5XDJTYpwleBp2QAqQu+fj9FCJKw4ENkQYBYb2wIdSnqI5+QJ7J1ZXNyaLTE6twPdypLB2YK1PRZiiABhlt9Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=X0KeWTtY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VqKJbyUn; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="X0KeWTtY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VqKJbyUn"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 9D20D13800B7;
	Mon, 25 Mar 2024 06:02:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 25 Mar 2024 06:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711360977; x=1711447377; bh=SngaOgt+ge
	Xdxk4pXVxHwT3nPVn888kE9+8fIPLEHbA=; b=X0KeWTtYI+gGELD5H+G5X2udzy
	a17W8mh0UTDj9QH8gpce2mIs46XhjVptAWhJq4iMHkFLioTCq3GEyJppeca5UZ3r
	EZu2TT3jKU3zD4WUY4AeJT/yLoC4g2dYfx49b8QCiLnQnXIPyfw/8bOq+T0vFl7r
	QbpD6ZwSr0uX0ars65JIIQLBkng7Z3bYDJ09yXSdFU0f+xmwePultABWDT6aWahn
	vvuqgwNR8/cYWBa/SLmCY/mDeu88cEQAVTWzxKa+ddlIur57ev4HrQD7QWKrV2NH
	UCorvc+zKwrp4wpt+J4PaD38CS33v5p4fl7/3vdWZlq4Zcxh7VX/9D2BUEpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711360977; x=1711447377; bh=SngaOgt+geXdxk4pXVxHwT3nPVn8
	88kE9+8fIPLEHbA=; b=VqKJbyUnZtz8o5E3o/thKIDcUuD9yxldeAGi539WN+ID
	6UHhbo2lZ+ty7BwdOl7I2Zdzg13w6K15QLsO8/xY2zlI3veI0iQGrVg3zrBiU3aH
	OhaVoFPvhpJevyk/VEcsrWilSUnSC48x4PTY5iLK3BB692nVIldDXeow82meKc8m
	xu+a0qU7Cnh0Bd5cc3IMATQPp8MLm1qPItQX4XCQJy8HQGp5VsO8XZctxdryZzrG
	KhKNKfUb8IT9s6j1/3NBApF32g8sMGPABN0S+b8FAm9Bc25/c+dldGi9wleKEOKX
	wlW3IoaoKgNOdR/jPPLOdNnEX3PCpX+hqBfZKFxPhQ==
X-ME-Sender: <xms:0UsBZj8JmWoh0VsosDKmPWNnYpPCy1p2Jqtjxr0eg_HuWlrIR36fvg>
    <xme:0UsBZvulgVGS5b8rD8ROZD41SFyI0KiIk4Qf07IMZQjz3GfKwfnM0aj7fIXW4h1Bx
    But0M9Y2zj_VXEZOA>
X-ME-Received: <xmr:0UsBZhCGF9TjSo37u4ntkatIxgnUptySbiecHRdcWS7l2LsiN85knYg_cbw3MqPwjwdfySwLDzqvESfEHTK49NBzYTdMffucfs5qCEWjWCSrcA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:0UsBZvfgGSzjH32DOF_Fops1OSkwOIMSxXpLzym4GSJHN4l0SycnAQ>
    <xmx:0UsBZoN3GtmmUui1bEVKtkBe0PeRTpVDmc2WR7NjpoJ_qSd-GOX6Zw>
    <xmx:0UsBZhkxT39AY8O3V0Lnz2F2sH4cZ2GYgKYJ7Ksm6dhvvklTumbMJg>
    <xmx:0UsBZivvfb66iGwHe3BscklRoxUon8NehSskbnxTdbPr6MxKoqRFyw>
    <xmx:0UsBZloY8GAnfAa5fxIJnLB0Ol1_xtmZldKsAashwwsUSjXffWYcxA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:02:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 73df58f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:02:46 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:02:54 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 05/15] refs/reftable: print errors on compaction failure
Message-ID: <6615f25b0890c934a31902bed024eaa9146ec641.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MlMAcMqjL1zEdjbX"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--MlMAcMqjL1zEdjbX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When git-pack-refs(1) fails in the reftable backend we end up printing
no error message at all, leaving the caller puzzled as to why compaction
has failed. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c    |  6 +++++-
 t/t0610-reftable-basics.sh | 12 ++++++++++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index e206d5a073..694dc4845f 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1204,8 +1204,12 @@ static int reftable_be_pack_refs(struct ref_store *r=
ef_store,
 		stack =3D refs->main_stack;
=20
 	ret =3D reftable_stack_compact_all(stack, NULL);
-	if (ret)
+	if (ret < 0) {
+		ret =3D error(_("unable to compact stack: %s"),
+			    reftable_error_str(ret));
 		goto out;
+	}
+
 	ret =3D reftable_stack_clean(stack);
 	if (ret)
 		goto out;
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 5f2f9baa9b..a53d1dc493 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -375,6 +375,18 @@ test_expect_success 'pack-refs: compacts tables' '
 	test_line_count =3D 1 repo/.git/reftable/tables.list
 '
=20
+test_expect_success 'pack-refs: compaction raises locking errors' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo A &&
+	touch repo/.git/reftable/tables.list.lock &&
+	cat >expect <<-EOF &&
+	error: unable to compact stack: data is locked
+	EOF
+	test_must_fail git -C repo pack-refs 2>err &&
+	test_cmp expect err
+'
+
 test_expect_success 'pack-refs: prunes stale tables' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
--=20
2.44.GIT


--MlMAcMqjL1zEdjbX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS80ACgkQVbJhu7ck
PpQpJw//VQ4s52EVZcSyYOg4rCKebrf3PrByOL0PSHS1Lrnkf2TyDUHowcy/iDOR
2xS5Vu9h1d8wtx6Ssp8hHLnlFpNuEpldJJ7HxQW3rNlpAXKrRlg+slTE/8lDj3ju
UpLgAOU34gkR0lV3Yg9d0VDns6ZKxOnyV6/XppBW5sdDHgzPFhzidINc66Wf7Bre
yutK/CzyWRmMGXc4TC+QroVisUXeq5yy282MBp7QOMfowHGPXvQuLNE8+YbNXJDt
ol7eiXZ8bpBH851fAJMcQruKLSseDDQ6zyKWxpK9XJ+4auP1taek7BtjWVUHm3dq
Xu3jtRPEsFIOoIG1CbA+HHdywVdLZ5UrI5DU+aUk5575sUPZX4h5xU1xOv3tYG67
YGs/dK9MmKf54q9WbmiofxRXiQ7nT+FWudmC/KTKHif25b9W2G/8tBaoH/UlcOy9
fI6hUFl8cJgkIGm0eyBezxic/1KdGHMN09qXls59zYoyIBGaX3a/7KF4PYNr5N66
iKKV99czBO9yO7wXtBJ2PeEEYUVt8evMnzzfhnoZzhTsnXYdHOQ8Cy7llErBl+/q
I0npJqxFg4ncRyKNxrmBbD6TOsAHsXCn+mC3//HPlRjze0V/fvNM03tcnJW1ntku
qwtDkpLGpNkUIrF5Ipl2du/jakrBUQ8qZNoTKtK6fGwRu2c0e/U=
=tuYG
-----END PGP SIGNATURE-----

--MlMAcMqjL1zEdjbX--
