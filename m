Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB598593F
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408072; cv=none; b=sE8AxhisDOJzEhij4ccbH2OBR4fiBaxFddcUsCUck+pqD5lEex4PA5mKX6bGOGSso53Cymtjg8g/yQXcFJUVxrZnxzEK5I3QJ7hVEMXf75uAiTYAqkGEeAKg8i4mHYEo/KcLz6Q+QwatSfgqurGQ7HVcIIlSt+syYcmc5vDTxbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408072; c=relaxed/simple;
	bh=NZm+UFyTtssCqQWw5/i0gl+ddA1AuA2NhvVF4zYBXR4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx+z+BnTO0mQKcHxPdsrHzk4O5hNVhVoEwhQDlYjodxU1Nonl+i1Z40zxhteX/oFw6wtoZzMqO1/j8p7xxj3oXZv7jYCSBg5MatRdQD4sqTGpHT9D9a3bWzxrCYSSbpOnVSTcSy41HsG13Vf2QpP0fiVQzpL1dWfGhF7wG5GnJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gUaxdBu9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hzQIp5Pd; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gUaxdBu9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hzQIp5Pd"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 1E0041C000D7
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:47:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 03 Jun 2024 05:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408069; x=1717494469; bh=+SXVMm6A64
	kVGMS0UIE2jKculL9culuT6lr3aihFRUA=; b=gUaxdBu90mv2MlIqFOOH6yoSUK
	UPJiygUsZPAf2jN2WaY4APcwcyoTqxy+MzCge4gaOumu+so+WLeg0YF0HXSxqttY
	YqANb4vhV9iKJAmxlVueAQyGs8CfZbXe5Zd+IQ49jauKEi6J1a9ZC04ZREirk6Yy
	XbO5G12w0QauSp5RERjvyhTN81A9eQw60crV36+pb5orRfE03zF9YldkPgEg/gIM
	6xTseYiSLBw7myjIe3MhYKbHaGiVajXWHBhyBqapKA24ZuFKKGCsqT4ONaqLFUP0
	EJstUYKIFl6p1Z4D2xmPbbGld/CCd7EtmLuJ8Pz5yHsjI2GX/izUUHFY4J9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408069; x=1717494469; bh=+SXVMm6A64kVGMS0UIE2jKculL9c
	uluT6lr3aihFRUA=; b=hzQIp5Pd0cdoBpIx5LT08+++FRa0QwmwSyldv9ewfb7/
	A0tw90HmE/VRgiix1U0zKPFyqIvyxwxaAk09m03XF/zlM91QCqBxsOjOdjg5s1Xf
	wh63LdPCYQh8u2r3n7/SJ/D/tXeqeOSfrZGHVHEMPzBF04CLb/4uaOxHBLEGi03g
	xuor6pARbS5euf8VAY+D83c15w5vddck8BXIwCzawXflueHKv/sHBdPQsK9ojKJO
	WnGwp5jOQuVwYb2c6/ACdwhEB8o5WLAu8H+97jLOWgOx/31wMpL7huFKnEvJFRpG
	Xr3qIs9BwN0yRupOUSYaed8SEyewyZaVEhLNq4Cbhw==
X-ME-Sender: <xms:RZFdZv86PaVzf1mlYFL5Dc8qYpp5IYqTm2FPKRoKBPsKKnz0x2zMbg>
    <xme:RZFdZrtUHSuQj_0wWXymK-5g_zNuyQ20Fj_pc0YwRi58hnypzpzMyGdGqAgDOpt3C
    A9HcSBTXHi7wAL1VA>
X-ME-Received: <xmr:RZFdZtBtYfM93Yl8Fde5BloVJbgS_41kd2QBIC6ywPWrh9IjU897qqi31uzg73WLAumLtKqZWxoqIail1b0VXZ0tBC5holkpGZoM-RsRJFKS4FOx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepfeenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:RZFdZrcNyAk181UH230mHPCmj_4gqL6Zw6l_ZleSq4s3RgumAfQ-0A>
    <xmx:RZFdZkMFeHkpbBDmJFvp1LmGzHH80W9om2w1djuF3pcQpm1-YRbEIQ>
    <xmx:RZFdZtkLfwGZRJQVCg3MwVs8rJJT19aExMBc1qgmK7WI6Fu3P4h1lQ>
    <xmx:RZFdZuuSZlQGE2oLDjcHTHrrY8eg--QyuAwz_I0_xEq0KjDDwWoDOA>
    <xmx:RZFdZu14GEOcpoMIcRpgGQ3HzsqqhMaZoC4Ud4TQox9fEPCs7jRzlcgm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:47:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id eee4c816 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:47:24 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:47:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 17/29] rerere: fix various trivial leaks
Message-ID: <cadeb09b9594bffabe9ab183f7efba3f85ebdc59.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BanmFc0nDhELSuIz"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--BanmFc0nDhELSuIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We leak various different string lists in the rerere code. Free those to
plug them.

Note that the `merge_rr` variable is intentionally being free'd with the
`free_util` parameter set to 1. The `util` field is used there to store
the IDs of every rerere item and thus needs to be freed, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 rerere.c                      | 3 +++
 t/t1021-rerere-in-workdir.sh  | 1 +
 t/t3504-cherry-pick-rerere.sh | 1 +
 t/t7600-merge.sh              | 1 +
 4 files changed, 6 insertions(+)

diff --git a/rerere.c b/rerere.c
index c7e1f8fd25..10382da55c 100644
--- a/rerere.c
+++ b/rerere.c
@@ -849,6 +849,8 @@ static int do_plain_rerere(struct repository *r,
 	if (update.nr)
 		update_paths(r, &update);
=20
+	string_list_clear(&conflict, 0);
+	string_list_clear(&update, 0);
 	return write_rr(rr, fd);
 }
=20
@@ -912,6 +914,7 @@ int repo_rerere(struct repository *r, int flags)
 		return 0;
 	status =3D do_plain_rerere(r, &merge_rr, fd);
 	free_rerere_dirs();
+	string_list_clear(&merge_rr, 1);
 	return status;
 }
=20
diff --git a/t/t1021-rerere-in-workdir.sh b/t/t1021-rerere-in-workdir.sh
index 0b892894eb..69bf9476cb 100755
--- a/t/t1021-rerere-in-workdir.sh
+++ b/t/t1021-rerere-in-workdir.sh
@@ -4,6 +4,7 @@ test_description=3D'rerere run in a workdir'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success SYMLINKS setup '
diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index 4581ae98b8..597c98e9c5 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -5,6 +5,7 @@ test_description=3D'cherry-pick should rerere for conflicts'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 test_expect_success setup '
diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index e5ff073099..041f1077b0 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -29,6 +29,7 @@ Testing basic merge operations/option parsing.
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
=20
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-gpg.sh
=20
--=20
2.45.1.410.g58bac47f8e.dirty


--BanmFc0nDhELSuIz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkUEACgkQVbJhu7ck
PpQTYBAAgxeBpae7R91p+O8WusI8n1R+8YuzRibl3QoQ5bE+BUPO56BasjW27Dpy
LdJSV6+8wxTau+u2iP8LVcqmjndh0urV74rFpYBk+Kscc/QpCWbkx5g2lqnjXeuY
SyzcRHjBqn1v8KRza4ICHrnLZxZSohp8zr+t52n0O+hYtX0/LH6VKzipB/LdMkLi
rXvSBKyqMrLYqSwgRF8Q11IS6uwg4IXK245OdvIpBf8OY6GRqLLEL7JpyZZ4pF/r
czFzEw5wxwjJDxD8vGr9fScMLGohQt9HO0lGTbX1GjjeLd+29CMcvqtEIJkptW7S
S6y1u/RUsJ6Ckfc7Ch2ri8LPTnBJUixvoffAsdIyJ7f1v8EGLjPS0uvy+Mhw1wva
ufhCkNzsgU/Mr3utwFaNAA6iMB9NisiKcgcdGOvwgykhP/9mqzabwKkQQ9zSqNU1
g5Wnyol4jAwf1wNyF2Ri7NaP4M7J0jtF/Fh51uNi0HQ/njN267g8HbvqFzpt/apt
XfoJrL07DGVPcA9qPx9kWconbGW5sAXaHRGu7jCiawZEmsLauV6QrWQA4E8awOuq
PTrOQC70GT1jL6WUApdqQN6dcPceEmYvD1AIUATt7LMiF03ZzS1aENBVafujn72H
zc/ZDyLqdwbX+cHmGl+rBjImpZ8nC/5SaENGvg6dRqgoBMxvFKc=
=N7zF
-----END PGP SIGNATURE-----

--BanmFc0nDhELSuIz--
