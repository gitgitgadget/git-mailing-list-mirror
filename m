Received: from wfout8-smtp.messagingengine.com (wfout8-smtp.messagingengine.com [64.147.123.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D82180620
	for <git@vger.kernel.org>; Tue,  9 Apr 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712656656; cv=none; b=sHuONC+Djrm0lIUh/QldvjL3gLCenly74ZYdYsmAAOmUcWjp+J3YHIMvDvKzp7ssZj8cAievmqR8/gFxT7isloesstnh3/G1mQdfYvwNJYcvTNQwaL6w3DVNiCCPCNbtplovUFVJ15SwZB8SpS/XIm3mYkP0uN1loI4tWaBjFmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712656656; c=relaxed/simple;
	bh=bSAUPiU6xTjwAPvCW1kHvbZIjHGoSjEIK7t1dgluahA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nalyrNoTmcRgqvJx0ZAk5sn1dhMzwcl5ft92cnliGqEJmdMMc8zuO5D2iNqOceh/c32LSCFm1N/opRmMn1jLsab/6ojbUSopMCww1mCp2GUAqio4AerNV8TRxtE4pdgsqgqOIOBJw3UF2Q7lM/Oi3mZ1+eRz7KzErFt9DY013iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NOQRMdgI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cz9a4O93; arc=none smtp.client-ip=64.147.123.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NOQRMdgI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cz9a4O93"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 0D2DF1C000B3;
	Tue,  9 Apr 2024 05:57:32 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 09 Apr 2024 05:57:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712656652; x=1712743052; bh=QIJtoTzFC2
	pYMeyR1t92m1EabLBJkpCjm9V+ByinDUc=; b=NOQRMdgIkRt98ILa3jxBnp6BBi
	5E9G1KdM6N9tg1EcdNztt38nEsSqbic7LUWl9XhMc+ArkFu6nXdYHDoCgO/s3E2z
	B9js23NyLgSFpdeAx4OGc7tWRVw4SLGE2Du4Pt/yKOPY7mhuiLHtBh55HbQD4Dg1
	PDRceRKT3OXd/+2FKfSU/78DO7F+ilgVgBR9HhozZ4KnSMlNm9y4cKtSKjblZptk
	bPTYwGDVRUdYnLRbD8IUFvqVk2rksAO3QMtIHdLmFmZAEELnuAWGQs2gDiZyCt1B
	/GOyd898V+GTTFU32HSu+R1L6ySysvvse7PlpuL0lqaicJTeVIo3AfKMYi6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712656652; x=1712743052; bh=QIJtoTzFC2pYMeyR1t92m1EabLBJ
	kpCjm9V+ByinDUc=; b=cz9a4O93qzXS6AU29fb58ic6PWK2TbG4/ZC8BMcHO0Ny
	k1YdVQM4wso+BVsUlJ6lLEF6BXE4ZkeIhjXWyU0b16Q4rhe+TT3YIKjrhXBcpZhB
	zmV1OK+owJ+jHO02PzLsXcbMed7CxSv0jJKOCtmPrARSSHBo+dsLlGpxQcbLXDQB
	ehpik+sNOOLVzfzoeStuSH6oHxCmy4AiOgpCUxwFwbBvFOlvVGJcbYq09nQPGU0s
	f25MDPkjgFvXoddyv/fmXQNICJVoAEMX6tJizQBARyaX4Xi9YJlcvl3E5r/tMWvV
	57Q+MZWABNbVVg7E4i3g9eruDXJFIaOlykILzm5vvA==
X-ME-Sender: <xms:CxEVZu5ocAvFBuinX7gOtJqz5NNWsy8jBc15qqGV5l03MUpJglxnng>
    <xme:CxEVZn6dgEQi-hZExCewgS9Dfw95uPt8ar76LMsftxCNZfrq2F3GdLP9jkddQN72X
    4Yq-XJGes_TivxYSg>
X-ME-Received: <xmr:CxEVZteayiNHBcQZ9oAChjN9LxCAJmS8d9R3aniVyRVFqjknHmVqIcbJCLb2TlHAdcc3zgSX4XiArHwovZiCAK9xwJu8FusSLaWqeI7lMmOZWG1o4Xc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:CxEVZrKDeLnsLAmpaJPw_w3cLOIAXJbe-JsFZUvG69jTUYxdNYbTUA>
    <xmx:CxEVZiLD_T5jYf20d1p-Yl0RM1sCgayGYQOzgHL_O7BDISJ1W0d5-Q>
    <xmx:CxEVZsw9m6_qTxA1JrlCGls3S5u8zs5O6ywMAtRlUvh_7p-6DjzsIw>
    <xmx:CxEVZmIpTJEonj3p-kgb4OlBIGn8m_E4hfD787t-101i8b2cpbOOWA>
    <xmx:DBEVZq_loT9SCxFIIk0t1QCMAENWHej4Hv46uyFQuO3tX-gwrNXxnEbY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Apr 2024 05:57:30 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4acda0eb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 9 Apr 2024 09:57:21 +0000 (UTC)
Date: Tue, 9 Apr 2024 11:57:27 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Han-Wen Nienhuys <hanwenn@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Luca Milanesio <luca.milanesio@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] t0610: make `--shared=` tests reusable
Message-ID: <f929e8ce00049d09052dbfc32869baaa50e68424.1712656576.git.ps@pks.im>
References: <xmqqle5n2sbf.fsf@gitster.g>
 <cover.1712656576.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N4+TgXZObr6uRWt1"
Content-Disposition: inline
In-Reply-To: <cover.1712656576.git.ps@pks.im>


--N4+TgXZObr6uRWt1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We have two kinds of `--shared=3D` tests, one for git-init(1) and one for
git-pack-refs(1). Merge them into a reusable function such that we can
easily add additional testcases with different umasks and flags for the
`--shared=3D` switch.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0610-reftable-basics.sh | 57 ++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 686781192e..a3269c20e0 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -96,23 +96,46 @@ test_expect_perms () {
 	esac
 }
=20
-for umask in 002 022
-do
-	test_expect_success POSIXPERM 'init: honors core.sharedRepository' '
+test_expect_reftable_perms () {
+	local umask=3D"$1"
+	local shared=3D"$2"
+	local expect=3D"$3"
+
+	test_expect_success POSIXPERM "init: honors --shared=3D$shared with umask=
 $umask" '
 		test_when_finished "rm -rf repo" &&
 		(
 			umask $umask &&
-			git init --shared=3Dtrue repo &&
+			git init --shared=3D$shared repo &&
 			test 1 =3D "$(git -C repo config core.sharedrepository)"
 		) &&
-		test_expect_perms "-rw-rw-r--" repo/.git/reftable/tables.list &&
+		test_expect_perms "$expect" repo/.git/reftable/tables.list &&
 		for table in repo/.git/reftable/*.ref
 		do
-			test_expect_perms "-rw-rw-r--" "$table" ||
+			test_expect_perms "$expect" "$table" ||
 			return 1
 		done
 	'
-done
+
+	test_expect_success POSIXPERM "pack-refs: honors --shared=3D$shared with =
umask $umask" '
+		test_when_finished "rm -rf repo" &&
+		(
+			umask $umask &&
+			git init --shared=3D$shared repo &&
+			test_commit -C repo A &&
+			test_line_count =3D 3 repo/.git/reftable/tables.list
+		) &&
+		git -C repo pack-refs &&
+		test_expect_perms "$expect" repo/.git/reftable/tables.list &&
+		for table in repo/.git/reftable/*.ref
+		do
+			test_expect_perms "$expect" "$table" ||
+			return 1
+		done
+	'
+}
+
+test_expect_reftable_perms 002 true "-rw-rw-r--"
+test_expect_reftable_perms 022 true "-rw-rw-r--"
=20
 test_expect_success 'clone: can clone reftable repository' '
 	test_when_finished "rm -rf repo clone" &&
@@ -371,26 +394,6 @@ test_expect_success 'pack-refs: does not prune non-tab=
le files' '
 	test_path_is_file repo/.git/reftable/garbage
 '
=20
-for umask in 002 022
-do
-	test_expect_success POSIXPERM 'pack-refs: honors core.sharedRepository' '
-		test_when_finished "rm -rf repo" &&
-		(
-			umask $umask &&
-			git init --shared=3Dtrue repo &&
-			test_commit -C repo A &&
-			test_line_count =3D 3 repo/.git/reftable/tables.list
-		) &&
-		git -C repo pack-refs &&
-		test_expect_perms "-rw-rw-r--" repo/.git/reftable/tables.list &&
-		for table in repo/.git/reftable/*.ref
-		do
-			test_expect_perms "-rw-rw-r--" "$table" ||
-			return 1
-		done
-	'
-done
-
 test_expect_success 'packed-refs: writes are synced' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
--=20
2.44.GIT


--N4+TgXZObr6uRWt1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYVEQYACgkQVbJhu7ck
PpREsQ//ddC0uaNq//DwxoSlQR5vbSCyIwgovT5JC6ITkjxqHXBgZOUwFEwKUzZZ
gUcqmfKozpNjRXPzsdvoAQKz9c3oHic7YOpVjHVZEY1Sm18TUjENP5HRd8omNm9L
wUUZh1Z4Cxa0JH8byg9p6k3fC84OQtXP3+Q5NwQE2RY7CR9vz2vq93a8+XmWklTL
HltSklMQOvDcxS8b4VHYP++ynIcK85cpPgcyhXz5LXP5BwR2T2+aNrXgF1B5Fqj5
0Dx8dP4Sr974XC8/Xc6G19wVOFFniWHfb7Bu0f4KACDfOuwcUw4z2UthMiZ1JeHn
BiE0/04W5ykXfRM9cUQJ6e5n7/prR+09l64eBKs4KWVcWMdtXemB+Mm4tR2MNmEh
MsWi0krm40LWEbA9NpSEKCAKRWcbF5aR6pazhAUxN+ud8usb8i1TcmHMAHVflDOu
CRiuljmLJBrO1uQj8u54vwyknODuVdvP6a0UsJ6N/zMSknPlAl+DWEdgfiMCbuoA
SlcBFNJ3ZoM1qAq4+ea2aI5H6tSm8dd4gb1/5gaTzsuwCGqK8CZD9qTZF/S0GyzM
JLgNaIaG4J2IxtDNn8swdvC6pjgU5RjHhoLCsWQ0S75/vpv5r+5D6tN/ndvJG+6R
H07XqvC3uCng4vhmpKUzLA2U3fK/1oR6UXn7K6Juaeyo7880fXE=
=jELo
-----END PGP SIGNATURE-----

--N4+TgXZObr6uRWt1--
