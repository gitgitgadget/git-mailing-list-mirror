Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFA43839E
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 10:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759218; cv=none; b=QMveaF9Rvd9tst6BhjXcUomLGAJm1RRBYeUY42fNve6pXfMA4tHtgj/IxTYC2LX7r2F3NF8E/3mELLfemm6p85uIROZmDHqA2SM/FGgxBWbxTgnnfvWYx1mrReU23hTggXxkSp52APUxGTxKKejaBZSr0PKFKV+L6rcQK3HBFXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759218; c=relaxed/simple;
	bh=+4e2zK3QfQQbR+QQ/OhktXmEYc5Wp842d7P8eSIMLeE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSrHG9dDRSHBzmQFaaetscWL6k+7Irx6OmTMgTfCA4wwLskiQFhNLL+OKMxefhc4zoqJyPQzr8ZdzkizEqNqH4CwwwBZ6eEYclaTOwfWr2MMwfJuZ5hIOgY4ERbnk2XtJiMtIhmioS4R7JeDiQVNY/DMxiWvRcGA2TFuqQZplNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gz58Ru3B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IZktG0yE; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gz58Ru3B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IZktG0yE"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id F01C2138011E;
	Mon, 18 Mar 2024 06:53:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 18 Mar 2024 06:53:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1710759215; x=1710845615; bh=5nyKR3q0WE
	96Qv/b7bNr3VECpAzaHiW0RoNpbFDZvVk=; b=Gz58Ru3Bb+rHV36w71nji2+nvR
	TRGeQzlhGrN0iWyVfbV3LwrwPKW2QKI6E2b1LJeNIQj0VNOMSOQzqu3DI6v/kzE6
	B15uDDSqOXwG5nhcRftquzfRAKq626D2XHMBlCUh9n3ibko3hCe9BYAk8chLzmTO
	tMGl91deqIPJF320AdNAmEkCrmINokq86CDNyOAONhqDiGcVX1CCcBw1hFl8h80C
	cUizicO3z112hJ/GJv7jRJpkoMA+hRdKs/2VKx7qiuBqZGYmSlqKySgUmOLugBYO
	owxSuyQleR0L+8EQP8KIH0RdaTZPkBsifMNc4QhozLiVt0NaBg3mlkYNIMWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1710759215; x=1710845615; bh=5nyKR3q0WE96Qv/b7bNr3VECpAza
	HiW0RoNpbFDZvVk=; b=IZktG0yEJKlhE1QqGuWxQ6yqS6zxIGf6Ed2gx7F2uetQ
	MQPMs6iRr9/cvSEeisiHxCGWGoP2Pg33XnggNwPC993iI0J1PwRWa/ItKH8gsA/M
	afM4X71t2PM4PVGVncq9wKQWQriCIM8TkRyYCU3UOMLczYZvPy+zu+glT0Q7RpC0
	BLvJwD44dfc1IlLeE6QLF+4OuaojNPr3+wV5EaBCpCwvkqRHuwn9PDzsaColIS7F
	VfmOrEtk4KSr5QZFlGVBax4ZXWovb7esuEYdAhm+VI2yzDw0vO8xCd6YF6JOXY8Z
	5zxjEq/Uphn08Shc98y8yTeNkmYZD8TEHXFwdExbLw==
X-ME-Sender: <xms:Lx34ZSargrLoVoga0XfNzVyJhzX6LvUToxynzWfWdqKCaSQP6P4i8w>
    <xme:Lx34ZVYfZWqCnNB6wcbtRp6ZUXVziPIZXUZkVzkIuzp9v1imhLonZlCtaR7xcPFmL
    9Usr2cvCNJRF8oGmQ>
X-ME-Received: <xmr:Lx34Zc_z3ZULIWZrBUoVMPHrM30ouO_C8prvlABh9NGII3u7f0h6yGq2VObhGuGjfh9T_d7H-7u4--ttCV-gbvG0C9sOZh5F3QIX7HNT0ADI5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Lx34ZUo1RMJX0c1g7ZYS-iVCDIK0HWAhJK3W1dDIF-Vafsc3oupqew>
    <xmx:Lx34ZdrwZoemxhjWd1PoshzZJ0giVOUubgyyIZoeaKzHFDhwhVd_Zg>
    <xmx:Lx34ZSQFF7k-re99XK9tglGfTbkq7_UuxMzFYeekt7swWGloM2sceA>
    <xmx:Lx34ZdoZOeW6QVC4M0bEBM58r9HmzW7F6Xxqq0MBhBlbXRwC6i3kCQ>
    <xmx:Lx34ZUVrBSi377nqNDCTExyzY-x6dISiDQnc5xbHZA6VU3hsHU-Stw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Mar 2024 06:53:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5b01057d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 Mar 2024 10:48:43 +0000 (UTC)
Date: Mon, 18 Mar 2024 11:53:32 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Subject: [PATCH 15/15] builtin/gc: pack refs when using `git maintenance run
 --auto`
Message-ID: <71f4800d36bcc77d8f36c5fc7b48eccbb90e6a93.1710706119.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="TxdiRu2yOvYWA6t2"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--TxdiRu2yOvYWA6t2
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
2.44.0


--TxdiRu2yOvYWA6t2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX4HSsACgkQVbJhu7ck
PpTSxQ/+NuRqYr6k8jFo9xyqRwzb4sZq/PjMPmYDroJ3ClL17jXJ1PovmhKNvbb6
/oYsVSsBlhNVHdFbUa03PHzpp7XM6RA5B8HErKsXNfcZH/oP8oqRXr9IGEjO3c9o
4QFJf/EduFhoLqktVVLsQm82TnovYAOa4pu7Q9jcLWSATch8EGzmAqCkUn8BbOzx
D4eBmEkY8dxUoy45iLplneDfXDPFDTRlj2izIV7thwXHYe615/h9By3nLdHhbRqv
80yJCFnGAX8anSBXm3jASWrOcL1Bt6jwZW4+UY+EvXSjAqBUeC6FrDygOR+jBKgZ
CiGf+GB0jMKO3uXYBQ0bk2vJzfiKrYj7wXRr1Sg9eNpJT6sqa85pijT1W08HwwHX
b0E1Bpy50K4WzzQYGShBFxzwud8hyswSbtFcGqqHM65Am6QIjH2N3wT1SFqGDH5i
Clbgini8WnwmReyaiU9OtlaxrC+rTEQlQO8zHpZYj1QN8qj6k4tpQPaDG7LnlRXB
AGihqm77rdajKt+ELJGSaJN2WsPEy99aBuJkgDYB49H764/1iyhCjxCk+aQrk7oj
SzkOlHibbeByb7CTTWCXB3pw7jZSSy2ATNRLzI43ZSV/4VarKxMvmuQ1q2NNJ0Ze
6DufdRywDKmguKB3OS/VF5iCTtRp+nqT1h3ynOltHXQq5C3xZfo=
=OG7s
-----END PGP SIGNATURE-----

--TxdiRu2yOvYWA6t2--
