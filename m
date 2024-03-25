Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FF1189240
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711361021; cv=none; b=Xo6LzIpoUts4F78M/fz7SW6tJdAzgq4v688OQp0JQuq5/5rPZUxPuhX6O5cx6ifz5qgL0pB+GJkO4fhf32MKZlL+fXEe5RsNWvfs4Fd8yO2h8VOXghKcK9XaFH16raHTNHzHrbIebewWRwOaSAAk/abkkAmDD9xYTOkT6lxttZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711361021; c=relaxed/simple;
	bh=Nfg+GC6HqQ41R8yP/YI/uU/xN/pcLYMGvNsqivs/UbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uVx1IEt0lxPginHyGzAeWvyL9vKUplwSg+EvkpB7r4GGv9aMeKYfmQxCIhDBF3GaHoh5sYWdV2fP8+Rjur/hqnlNtLuPMyFjsBEYNohwFh3AII7vg9rfkOCRsJzwmzi9LaRIE3WVW+08/r66+qVix7q14Y/rs4cFGylcMXev9sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Oz7d6feP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hvd5y0kg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Oz7d6feP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hvd5y0kg"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id F189B11400A1;
	Mon, 25 Mar 2024 06:03:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 25 Mar 2024 06:03:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711361018; x=1711447418; bh=Sb0DuT8OEA
	+8riykvDTyEjwvGB9dWgk8HcZQQnJyLAQ=; b=Oz7d6fePwZ3u4ff9SxcHD5ZbDv
	UpxGPKWhC8kafy+HYRPbldWY1pzZ2xvUvuQiVnk6klkdz6aBdOIq86GM1HlQt6Xu
	VutAehb7J6slmX3/dmKC9NqxIk9cOJDrPn8VpS2nOb0xh5CdlsnK6iumeCAuPd1g
	8gLJwa4IPXMf3LHCzcX1M+XKbzPY6vMZzO7UUMSjMDhYSmKSth/k9uj8I4um/wQo
	84rHMHv3l75J9LsMaiNZzvpBhZYozS+tx2le+uDStijkIniGFZcBqp09zJqog7mD
	m1LWW27tHVzOLl15Cai7btfrm/4s4o3kHIfrIMMKO1NqN1iP6IRUvgT3WyRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711361018; x=1711447418; bh=Sb0DuT8OEA+8riykvDTyEjwvGB9d
	Wgk8HcZQQnJyLAQ=; b=Hvd5y0kgFG4aODEL5YEJZyjNGlpnpTP4qJzjqeHVnOVQ
	JmhSqplehi9X4d6QQ2JxtNRy9cIN7mj3VT3WhrLbKzRm+LbOENzkNRuIwkEU/Vhp
	f66myoWkrbLOdQa2Y48Z2Z8o1sUyEwCKnQaZwS114029QLuX3IYtCdlzCA+wGLpN
	k1Lhwtldg/y2dX+vCdp7x4pDUi2+c0nC48Cq5NpzokLkzH2YhG6/0nxz/bAq3Kjq
	LcE+kFUECemXmMmr9NpXiPa0HOdG1w9TGgp4G9hjMxZd1SIK3BhLsUJmAysfkHKQ
	UWF8MdUS8g0zxp5zdRJIdwsx8ncoYUlKeO9GWYh1Og==
X-ME-Sender: <xms:-ksBZl8GEZ_2LzlTdTMAq1X_m1j8ANgdPISnh8JxM0Rl_joVQWBCMA>
    <xme:-ksBZpssg4_KOzgxqRVyGk9Hd42Z0YXv_F6pM-QWHPq6QuGsRPIeOdl6oELg8bLnZ
    MTD5TmOyw_aEb6reA>
X-ME-Received: <xmr:-ksBZjCYMXVQoo9j6hnwyFNlyqRFmisilg5tVEJHR-KJYUf_cunXXYGFQM0NZKfs9YX7bRH9PqL6JNM3WHwM63FFiEvQ3QGt555KEf3Qp3zK6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:-ksBZpdY_KXniCdzeB8rhVdD7e3_IEsCKY9z83gAe-eoBFQ4N1sqng>
    <xmx:-ksBZqMmgT3a5LRB7ivPzoiI28GVUndp00WkMv6OJK0UQTp1PAjvoQ>
    <xmx:-ksBZrmB3rHN8vtxp3kTQeFTMr6RS7Fdb3AKpdUdKXJ4Q2le-7VYrA>
    <xmx:-ksBZksDcxsd07M_Q2Knb8oW6K4zrBX0m0WFd8XGrcaEVo_YLetSyg>
    <xmx:-ksBZnqQp1wlnSvnmqld6TkORL7QN4qOrcTGWC_79xeN9WsFk-vnOg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:03:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 365ad41e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:03:28 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:03:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 15/15] builtin/gc: pack refs when using `git maintenance
 run --auto`
Message-ID: <1bdea3b316b6ab88d5e9c8541e8f9348fc36c998.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="rSyw2kStFDwZeyqE"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--rSyw2kStFDwZeyqE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When running `git maintenance run --auto`, then the various subtasks
will only run as needed. Thus, we for example end up only packing loose
objects if we hit a certain threshold.

Interestingly enough, the "pack-refs" task is actually _never_ executed
when the auto-flag is set because it does not have a condition at all.
As 41abfe15d9 (maintenance: add pack-refs task, 2021-02-09) mentions:

    The 'auto_condition' function pointer is left NULL for now. We could
    extend this in the future to have a condition check if pack-refs
    should be run during 'git maintenance run --auto'.

It is not quite clear from that quote whether it is actually intended
that the task doesn't run at all in this mode. Also, no test was added
to verify this behaviour. Ultimately though, it feels quite surprising
that `git maintenance run --auto --task=3Dpack-refs` would quietly never
do anything at all.

In any case, now that we do have the logic in place to let ref backends
decide whether or not to repack refs, it does make sense to wire it up
accordingly. With the "reftable" backend we will thus now perform
auto-compaction, which optimizes the refdb as needed.

But for the "files" backend we now unconditionally pack refs as it does
not yet know to handle the "auto" flag. Arguably, this can be seen as a
bug fix given that previously the task never did anything at all.
Eventually though we should amend the "files" backend to use some
heuristics for auto compaction, as well.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c                  | 12 +++++++++++-
 t/t0601-reffiles-pack-refs.sh | 10 ++++++++++
 t/t0610-reftable-basics.sh    |  2 +-
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index bf1f2a621a..3c874b248b 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -206,6 +206,16 @@ struct maintenance_run_opts {
 	enum schedule_priority schedule;
 };
=20
+static int pack_refs_condition(void)
+{
+	/*
+	 * The auto-repacking logic for refs is handled by the ref backends and
+	 * exposed via `git pack-refs --auto`. We thus always return truish
+	 * here and let the backend decide for us.
+	 */
+	return 1;
+}
+
 static int maintenance_task_pack_refs(MAYBE_UNUSED struct maintenance_run_=
opts *opts)
 {
 	struct child_process cmd =3D CHILD_PROCESS_INIT;
@@ -1298,7 +1308,7 @@ static struct maintenance_task tasks[] =3D {
 	[TASK_PACK_REFS] =3D {
 		"pack-refs",
 		maintenance_task_pack_refs,
-		NULL,
+		pack_refs_condition,
 	},
 };
=20
diff --git a/t/t0601-reffiles-pack-refs.sh b/t/t0601-reffiles-pack-refs.sh
index 219a495451..7d4ab0b91a 100755
--- a/t/t0601-reffiles-pack-refs.sh
+++ b/t/t0601-reffiles-pack-refs.sh
@@ -370,4 +370,14 @@ test_expect_success 'pack-refs does not drop broken re=
fs during deletion' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'maintenance --auto unconditionally packs loose refs' '
+	git update-ref refs/heads/something HEAD &&
+	test_path_is_file .git/refs/heads/something &&
+	git rev-parse refs/heads/something >expect &&
+	git maintenance run --task=3Dpack-refs --auto &&
+	test_path_is_missing .git/refs/heads/something &&
+	git rev-parse refs/heads/something >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index b37d8bf3b1..931d888bbb 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -387,7 +387,7 @@ test_expect_success 'pack-refs: compaction raises locki=
ng errors' '
 	test_cmp expect err
 '
=20
-for command in pack-refs gc
+for command in pack-refs gc "maintenance run --task=3Dpack-refs"
 do
 test_expect_success "$command: auto compaction" '
 	test_when_finished "rm -rf repo" &&
--=20
2.44.GIT


--rSyw2kStFDwZeyqE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS/cACgkQVbJhu7ck
PpRpmw/8CJSLEOEVaAsOQTJH8VheZUnszaKl9eYA8xhHl7qFBSh9+HiGPs9bE8zf
UXQ4YycnHRPpv5f3hUkLtmYU5rxa+pW8S7xpOf7cb2rATE9uQoyUffgNm7bqwkrr
0HHOAUmcZlCzd9aRmuItH8eAt2/NuJc5BnZ0ddXYfQBvgetQRMhzfdqgp8YLSg7g
zunoVFL9ge2z3VJesfMxcKFEAm2phaVfOqNJ+pHXCk/uYSQ6mFUkBtDnOL2jJULj
hGdGVofsl8C86S8dUs7Nzxbd1Kl08taP0PdBmrEy5D2cDSxI4COCKWjUe1Z3VRyh
Pd0PGf7HHxpiNWM+xdclHk8vSH6FBGvshpaQZe8cqaD+ZjgVfeW3jEUDnUQRiIfo
tcjaoC48NjDpoJZmrXCWkbXChY5wJG+Ad1yyItOqtAHOFjyCWX96DKyjXraa83gs
l6iCzjzDL684wHKbtjM1kK2zekttM5JJBodqzQRIuslfpqR+4qQD/+1hyFtQHoNK
HqwQHbH8qi4Qf8JcHOUJxs4pcRGosYeUsvIAkCO3v/ZNPtYYfh4lKu3TCWI/GYmZ
vVIluHC1ezCrw+xRdVP9r4tIIJJGdiDxBN/9Hb/8AMwh4CgQAx/JNIrnNLLIIXGO
5O0j+5PhzA6MRTjam3/QSz2cgC/W8NtiQI/nN+kvnfGP6/ydPo4=
=XsZx
-----END PGP SIGNATURE-----

--rSyw2kStFDwZeyqE--
