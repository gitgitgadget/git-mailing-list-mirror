Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9988146A6D
	for <git@vger.kernel.org>; Mon, 13 May 2024 07:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715584519; cv=none; b=m/qmPdnN5pD+s9N+qp4yu937gytDKlDuYQSB68MKypCNFtYBKMouL01fXbBdraXtC9ymvzaWfUlmi77A5do35tKqr0r6XmJzjmaC2wEELrvr1qwDgg+n76O331KcxLtE4ocdWcVSKw5aY01yzfrhidCstLzNa1KF2Ailw67gMWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715584519; c=relaxed/simple;
	bh=cwR8RZ+MjJ/jR1GSUtvG7ceK+Op+3hw7TRxreQjcVqI=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VutgoNVbwqI+T7miBV67/3/b00T2bk5fwB3hcPBUFGJ9SAtT0/cFL60w5P6qb3jkTy7SLeT/WxUiuYorEdu+IcAyrvS0+iukcXi4poh46g8nTT9KUfLxALdqQ4VIr6QoJPvI1bPFkJw0HwUTKwvu0uFxzTuxHoHh2xHrO4VFMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WHx3ZvJ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Js8xhx9v; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WHx3ZvJ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Js8xhx9v"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id EB0EE18000EA
	for <git@vger.kernel.org>; Mon, 13 May 2024 03:15:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 13 May 2024 03:15:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715584516; x=1715670916; bh=cAw33wxL0r
	E1Of8yKWOb3wo7VdAzwQZSUWUj8Y78Wf0=; b=WHx3ZvJ9MszoHYPAWt/4+aEXWg
	ia4qsXWHzoZapjckNgnyvfq1W3gK2Utyg2BZMptqkGOhNM18i51C2ptTn+xFfE0B
	M3f4CsIM81B+ze7bbQeOncFIo+nlVVluWOqz8aHXKumXvWsJTDjH1q70VGosTNXU
	n5CbM7bvi6xe0dA+UJmWA+yYza9m0c9kXA64MHg0RqeglPm252cKhU3A7RFPB0lU
	p3aboY5EJYELuSDXSvC03NQu0rTLo0dp5ZqbLjZGoQTzuAbNdP/j700NrsEkx8cL
	825BxqA+t2pFVZJn+v+RJ/aOlK4+1VLMqYDzukN05kWMXyCwjY8qqU/1esXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715584516; x=1715670916; bh=cAw33wxL0rE1Of8yKWOb3wo7VdAz
	wQZSUWUj8Y78Wf0=; b=Js8xhx9vsosF9INOwOPqjXNOf79IAfAkhw9/jtJekZrH
	DTfw8Sn8MnG3jWj6l9qQHb78PLXNs0Sv+bQBiKQAEZnOrj2ZzRP3Wr/Gu1Wscz4K
	v8EYgMx/PvviVPyg66btuA+S5MclE6aT8292+OFcqXSrbxcODph2gCACfwNzp0Nw
	cVnctwqcUWM95pSLGpqO4Qp/+5Pv0Fo7FGSIGilCOpjI884FLOSKANj+wYAzLBhh
	XsVcC1xsPFMuZEEkMq9uLGm1yKsWCuVwPp8kRjVywLE96m3IDaP1/hQ6qFfYTqLu
	+AEYmvW4ptLXRUaQz1G2qGYsFm+7A0qIWq8/IJKkiw==
X-ME-Sender: <xms:BL5BZnIY1bzYhQs-Go1_B7FYagTZ_mC2sqy8K7NpLDmLikrDkHZZ1Q>
    <xme:BL5BZrLwv4fTVqigZy0fOUejWbH-2Xz5Z8_YzBUchgVq5E8uXIUTGJIJB7dh3VYGt
    SnoVxPDnqFiOvtdYg>
X-ME-Received: <xmr:BL5BZvu_cXYI1_j8IZNcOPnr1BaDMjmWvEew9DDqrtNSjrbSYRRwk9QVGp-xfn2t1NME-7YN97yelgS4l24piAvP2zaHrQE-MX0lSY-aoob8MsM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdegfedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:BL5BZgasMYshuwVDD2urRnq8DStLeRZ-vxySmy3uCdU4axozOrRnLg>
    <xmx:BL5BZuZmf-plug_dZ9xMz56pwwWh1YoPOOfLOxDj7fKntozImL1BNQ>
    <xmx:BL5BZkAQoB_D6n1prEU8cakCY2TXduWocYOBdc_KyuyDEjS0ZIWeWg>
    <xmx:BL5BZsb8XTMiJmvFYKJ_Jf795Kg4oYSd9y5OAC7Sroto2TJ0DcNPtg>
    <xmx:BL5BZhzyc3087PxmoV_aRXCPWAaLWBBykSLLT3coA7-LChMIZ2RGuCQd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 13 May 2024 03:15:15 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2e98752b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 13 May 2024 07:14:57 +0000 (UTC)
Date: Mon, 13 May 2024 09:15:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 2/2] builtin/hash-object: fix uninitialized hash function
Message-ID: <1e010f798ce50e51100bd46564a69ddbd31d29ea.1715582857.git.ps@pks.im>
References: <cover.1715582857.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KSdK3nYZjwMNJxwp"
Content-Disposition: inline
In-Reply-To: <cover.1715582857.git.ps@pks.im>


--KSdK3nYZjwMNJxwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The git-hash-object(1) command allows users to hash an object even
without a repository. Starting with c8aed5e8da (repository: stop setting
SHA1 as the default object hash, 2024-05-07), this will make us hit an
uninitialized hash function, which subsequently leads to a segfault.

Fix this by falling back to SHA-1 explicitly when running outside of a
Git repository. Eventually, we should expose this function as a command
line option to the users so that they can pick which object hash to use
by themselves.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/hash-object.c  | 7 +++++++
 t/t1007-hash-object.sh | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/hash-object.c b/builtin/hash-object.c
index 82ca6d2bfd..0855f4f8aa 100644
--- a/builtin/hash-object.c
+++ b/builtin/hash-object.c
@@ -123,6 +123,13 @@ int cmd_hash_object(int argc, const char **argv, const=
 char *prefix)
 	else
 		prefix =3D setup_git_directory_gently(&nongit);
=20
+	/*
+	 * TODO: Allow the hash algorithm to be configured by the user via a
+	 *       command line option when not using `-w`.
+	 */
+	if (nongit)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	if (vpath && prefix) {
 		vpath_free =3D prefix_filename(prefix, vpath);
 		vpath =3D vpath_free;
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 64aea38486..4c138c6ca4 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -260,4 +260,10 @@ test_expect_success '--literally with extra-long type'=
 '
 	echo example | git hash-object -t $t --literally --stdin
 '
=20
+test_expect_success '--stdin outside of repository' '
+	nongit git hash-object --stdin <hello >actual &&
+	echo "$(test_oid hello)" >expect &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.45.GIT


--KSdK3nYZjwMNJxwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBvgAACgkQVbJhu7ck
PpSB4A/8C1yeSyLu60ESp5mI+909sGnGeioZdsQ1Bd+CPaFsjGmeanEfReJNvL3G
+LIJBoe0gocUpAiS2mX9kYDq0UENWAf+tZaQatElB/P6taTLDHY5n20GHKSFFNuY
CN5G9TQSqAYKnV0rLNkUOid9vPrdrUW5KP0+C7iXHRPFPgv7Ij1v6QbEoGmtLm3r
z3UPxoO3qv5AQxuDthTzlwOSnKzMcRldx438HlG+EX/Fqscaaxsvzzk6mq6ppTVK
6hArcaSleIJXCm0MjgiKEYmgHJHH/QPJJFAEHK9ZSCtTyEDOL+hQ8BzdaAM0dqTN
B5YxZTFSB04QbQh7c1CyN/IEXm4YqOTW4FBK8+NDcv03GaaJoZ89l24EVBM/p3dw
zXMVnwT2TX+lceIdw6p9HtGaxzhx/VeF/o8reKjwF+ehA738Z9gjPhLMzS0EM8kq
uqrkrYvapedeHzcbWQdEl4N3PdE/oHyHzErvfW+z1wsrVAVrLO4/6jNuYaqg2thY
mW0eOu94LRLTwpOtKr/mC3HbNZge8xJBMCTgx6sisfH4bRanBCT6We/G8M7PTJPL
HJ9PENagC+OgrQVrLAl+1YQavyHzUlEvNcsMhbjFIf8ubb41FO4zVHGTKHMIjfId
RN/6L3HKUMufnxEZWhS1sEmyFkefhtolexYuiJcoLoHVu49Alwc=
=f5kg
-----END PGP SIGNATURE-----

--KSdK3nYZjwMNJxwp--
