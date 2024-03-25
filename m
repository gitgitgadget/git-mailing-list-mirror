Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A72194C92
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360962; cv=none; b=V9XlcV8/+FJH4joJf1dltXAnu0WXFKZZdST0hW/KbuB7JbbAXmNeXqOyKvETWF9+5VrDsR48lwclUpnYPuZ04OgeTR2LOijalHZxFWpswtdaUGzbJFrfbkbXRB4TTtamY1DXusV71U9THxtNytb8A5Xt5JTC/aNRaMN9OiEb18I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360962; c=relaxed/simple;
	bh=RR8T+00hJgeRY7OlwXPLcZOq5PwL3YQ57qjOvTuCHZA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Niug51Xzq6SIiTJ5sPHMyugudQE7b4bdyElXuZPf5kpFC42ICmWY9EgXY4dRMS2Y8byI+UATIxKXyk5bzlIsBkAxpD5qO6DP6anFT5IvWdtSsMkLaU7NnTNMK71RD8HG8UKOSjh/9aYsS/2YCBKuTs5HnrZJF3KPUGVx75HRh3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fItKUDaj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=chq/RAkS; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fItKUDaj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="chq/RAkS"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id A4A8413800AE;
	Mon, 25 Mar 2024 06:02:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 25 Mar 2024 06:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711360958; x=1711447358; bh=uHWA+uBx7o
	5Leut7leNxyraGrPuyM7aHQyW2KxdoOjI=; b=fItKUDajOy8pBiVr8zweJDmzkm
	PjKj6+hkw5oUb6NyI5pmjunuz2xeV6iyyriybtO/PIEgv0w813L+uPO8dx6FLfVm
	cvNZJjp/giklN1atSVrQ9htYJqrjp92cLsHpdGvBn/3iDY02gPTbAQ5dRxdO3hS6
	mgQfL7zp2AxQ4OG3zSjwgj4u0zNiS1nL/fX9k52VRjpzW52Y9iNsah/57Y3niBYZ
	UqcmPeiXKelRc4sRQpSs1FgsyxsAuvNJbr9OVlodl9eokcM9DwoefledDsh/aSlF
	I5Q2dzh7NLYRQctZvUOOexPthH2ISifoTx9C9e5FvfkRU82BHAs6NmIfmhog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711360958; x=1711447358; bh=uHWA+uBx7o5Leut7leNxyraGrPuy
	M7aHQyW2KxdoOjI=; b=chq/RAkSge1M36sIfWzhE8ifAtgh69ooWkPK9SVYVukF
	gOypgUHXztZsEKRGgQDm1gvvQ49XHJ9aQbZIqqzCcBr4uZkfARMLm1ZGgJXSeqSk
	hEBKcWIiVbiKfrDfFjvZwVBg0c5kQCKY77zGjIIWTEHjDNT2UfsG+JOrRKeGNJB6
	z74q6lmrlNr1/J2IkWXCvS7ZwTrz3VtZ7yIqHPH7jsDfLvCc94EfInUoz57d/N4y
	cMbfhtnTdbmpzJIQIbPr3uW/TbUFFBIchNhSxBUlrF959pKo2EmvkYzN6rW1tarN
	i90SnCLS8Jfa9/o4Ed83bLbqWuBn28qTwKd9h2NM4w==
X-ME-Sender: <xms:vksBZpmP759CChQhyB60f3bBQUQspRrpQ0KAl_9UVai_4rdlNgZO4A>
    <xme:vksBZk22BasuyctDUXXC1N_R5cSZ9W4F2IcN4YdjgGBgCVRnSf3IB-CRhVNNGF_Pf
    hMSMd75rU1rd9hILw>
X-ME-Received: <xmr:vksBZvoklL_eqfpZf4YoRYxcSvkFvex9nfZU8vVY_B7ba1Q5-cLMWBzb57C1vgShRZjNQLXsL3IwulKhykZSk_m8DaLfBG07dx4DVRfFjaadaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:vksBZpnGp9Kyw-PqaEH20GPNGy-OMaCIM0j54qT0zIfRuuP_dVvyNw>
    <xmx:vksBZn3JLG2TstPWdjROmOy3TbeEEOvo-OVaph8Rip9YoV4NUa7_0g>
    <xmx:vksBZou0Ol__aoVTScHkg676Q5Own64FFdrWGt9yIk_gT0_BgDRnFA>
    <xmx:vksBZrVS9bZAZP_OvaFmkOSXD5qNv_ULuiaoKvs9aEJVtdfcZB8w_w>
    <xmx:vksBZiSjGKhr4YJEj_YI5SpFYjweySFOqcZQuybTM1KLtXOnexeQAQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:02:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d79528af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:02:26 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:02:34 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 00/15] refs: introduce `--auto` to pack refs as needed
Message-ID: <cover.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wAg4VShasFqEoh9y"
Content-Disposition: inline
In-Reply-To: <cover.1710706118.git.ps@pks.im>


--wAg4VShasFqEoh9y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that introduces the
`--auto` flag to repack refs as neeeded to git-pack-refs(1), git-gc(1)
and git-maintenance(1).

Changes compared to v1:

    - Clarified some of the commit messages.

    - Adjusted the stale comment of `stack_compact_range()`.

    - Added a unit test for failing auto-compaction.

    - Clarified a comment to explain why it is fine for auto-compaction
      to fail.

Thanks!

Patrick

Patrick Steinhardt (15):
  reftable/stack: fix error handling in `reftable_stack_init_addition()`
  reftable/error: discern locked/outdated errors
  reftable/stack: use error codes when locking fails during compaction
  reftable/stack: gracefully handle failed auto-compaction due to locks
  refs/reftable: print errors on compaction failure
  t/helper: drop pack-refs wrapper
  refs: move `struct pack_refs_opts` to where it's used
  refs: remove `PACK_REFS_ALL` flag
  refs/reftable: expose auto compaction via new flag
  builtin/pack-refs: release allocated memory
  builtin/pack-refs: introduce new "--auto" flag
  builtin/gc: move `struct maintenance_run_opts`
  t6500: extract objects with "17" prefix
  builtin/gc: forward git-gc(1)'s `--auto` flag when packing refs
  builtin/gc: pack refs when using `git maintenance run --auto`

 Documentation/git-pack-refs.txt | 15 +++++-
 builtin/gc.c                    | 86 +++++++++++++++++++--------------
 builtin/pack-refs.c             | 31 +++++++-----
 refs.h                          | 20 ++++----
 refs/reftable-backend.c         | 11 ++++-
 reftable/error.c                |  4 +-
 reftable/reftable-error.h       |  5 +-
 reftable/stack.c                | 44 +++++++++++------
 reftable/stack_test.c           | 45 ++++++++++++++++-
 t/helper/test-ref-store.c       | 20 --------
 t/oid-info/hash-info            | 12 +++++
 t/t0601-reffiles-pack-refs.sh   | 30 ++++++++++--
 t/t0610-reftable-basics.sh      | 79 ++++++++++++++++++++++++++++++
 t/t6500-gc.sh                   | 30 +++---------
 14 files changed, 307 insertions(+), 125 deletions(-)

Range-diff against v1:
 1:  1e39d93a45 !  1:  b41b9b27cb reftable/stack: fix error handling in `re=
ftable_stack_init_addition()`
    @@ Commit message
         error code check without the off-by-one. But other callers are sub=
tly
         broken by this bug.
    =20
    -    Fix this by checking for `err > 0` instead.
    +    Fix this by checking for `err > 0` instead. This has the consequen=
ce
    +    that `reftable_stack_init_addition()` won't ever return a positive=
 error
    +    code anymore, but will instead return `REFTABLE_LOCK_ERROR` now. T=
hus,
    +    we can drop the check for a positive error code in `stack_try_add(=
)`
    +    now.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
 2:  e837703ca1 =3D  2:  be7212006b reftable/error: discern locked/outdated=
 errors
 3:  ae2130ffda !  3:  95dda44672 reftable/stack: use error codes when lock=
ing fails during compaction
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## reftable/stack.c ##
    +@@ reftable/stack.c: static int stack_write_compact(struct reftable_st=
ack *st,
    + 	return err;
    + }
    +=20
    +-/* <  0: error. 0 =3D=3D OK, > 0 attempt failed; could retry. */
    ++/*
    ++ * Compact all tables in the range `[first, last)` into a single new =
table.
    ++ *
    ++ * This function returns `0` on success or a code `< 0` on failure. W=
hen the
    ++ * stack or any of the tables in the specified range are already lock=
ed then
    ++ * this function returns `REFTABLE_LOCK_ERROR`. This is a benign erro=
r that
    ++ * callers can either ignore, or they may choose to retry compaction =
after some
    ++ * amount of time.
    ++ */
    + static int stack_compact_range(struct reftable_stack *st,
    + 			       size_t first, size_t last,
    + 			       struct reftable_log_expiry_config *expiry)
     @@ reftable/stack.c: static int stack_compact_range(struct reftable_st=
ack *st,
      					LOCK_NO_DEREF);
      	if (err < 0) {
 4:  37a18b91ca !  4:  50a3c37f92 reftable/stack: gracefully handle failed =
auto-compaction due to locks
    @@ Commit message
         invoking auto-compaction of the stack to keep the total number of =
tables
         at bay. This auto-compaction may fail though in case at least one =
of the
         tables which we are about to compact is locked. This is indicated =
by the
    -    compaction function returning a positive value. We do not handle t=
his
    -    case though, and thus bubble that return value up the calling chai=
n,
    -    which will ultimately cause a failure.
    +    compaction function returning `REFTABLE_LOCK_ERROR`. We do not han=
dle
    +    this case though, and thus bubble that return value up the calling
    +    chain, which will ultimately cause a failure.
    =20
    -    Fix this bug by handling positive return values.
    +    Fix this bug by ignoring `REFTABLE_LOCK_ERROR`.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ reftable/stack.c: int reftable_addition_commit(struct reftable_addit=
ion *add)
     +	if (!add->stack->disable_auto_compact) {
     +		/*
     +		 * Auto-compact the stack to keep the number of tables in
    -+		 * control. Note that we explicitly ignore locking issues which
    -+		 * may indicate that a concurrent process is already trying to
    -+		 * compact tables. This is fine, so we simply ignore that error
    -+		 * condition.
    ++		 * control. It is possible that a concurrent writer is already
    ++		 * trying to compact parts of the stack, which would lead to a
    ++		 * `REFTABLE_LOCK_ERROR` because parts of the stack are locked
    ++		 * already. This is a benign error though, so we ignore it.
     +		 */
      		err =3D reftable_stack_auto_compact(add->stack);
     +		if (err < 0 && err !=3D REFTABLE_LOCK_ERROR)
    @@ reftable/stack.c: int reftable_addition_commit(struct reftable_addit=
ion *add)
      done:
      	reftable_addition_close(add);
    =20
    + ## reftable/stack_test.c ##
    +@@ reftable/stack_test.c: static void test_reftable_stack_transaction_=
api_performs_auto_compaction(void)
    + 	clear_dir(dir);
    + }
    +=20
    ++static void test_reftable_stack_auto_compaction_fails_gracefully(void)
    ++{
    ++	struct reftable_ref_record ref =3D {
    ++		.refname =3D "refs/heads/master",
    ++		.update_index =3D 1,
    ++		.value_type =3D REFTABLE_REF_VAL1,
    ++		.value.val1 =3D {0x01},
    ++	};
    ++	struct reftable_write_options cfg =3D {0};
    ++	struct reftable_stack *st;
    ++	struct strbuf table_path =3D STRBUF_INIT;
    ++	char *dir =3D get_tmp_dir(__LINE__);
    ++	int err;
    ++
    ++	err =3D reftable_new_stack(&st, dir, cfg);
    ++	EXPECT_ERR(err);
    ++
    ++	err =3D reftable_stack_add(st, write_test_ref, &ref);
    ++	EXPECT_ERR(err);
    ++	EXPECT(st->merged->stack_len =3D=3D 1);
    ++	EXPECT(st->stats.attempts =3D=3D 0);
    ++	EXPECT(st->stats.failures =3D=3D 0);
    ++
    ++	/*
    ++	 * Lock the newly written table such that it cannot be compacted.
    ++	 * Adding a new table to the stack should not be impacted by this, e=
ven
    ++	 * though auto-compaction will now fail.
    ++	 */
    ++	strbuf_addf(&table_path, "%s/%s.lock", dir, st->readers[0]->name);
    ++	write_file_buf(table_path.buf, "", 0);
    ++
    ++	ref.update_index =3D 2;
    ++	err =3D reftable_stack_add(st, write_test_ref, &ref);
    ++	EXPECT_ERR(err);
    ++	EXPECT(st->merged->stack_len =3D=3D 2);
    ++	EXPECT(st->stats.attempts =3D=3D 1);
    ++	EXPECT(st->stats.failures =3D=3D 1);
    ++
    ++	reftable_stack_destroy(st);
    ++	clear_dir(dir);
    ++}
    ++
    + static void test_reftable_stack_validate_refname(void)
    + {
    + 	struct reftable_write_options cfg =3D { 0 };
    +@@ reftable/stack_test.c: int stack_test_main(int argc, const char *ar=
gv[])
    + 	RUN_TEST(test_reftable_stack_tombstone);
    + 	RUN_TEST(test_reftable_stack_transaction_api);
    + 	RUN_TEST(test_reftable_stack_transaction_api_performs_auto_compactio=
n);
    ++	RUN_TEST(test_reftable_stack_auto_compaction_fails_gracefully);
    + 	RUN_TEST(test_reftable_stack_update_index_check);
    + 	RUN_TEST(test_reftable_stack_uptodate);
    + 	RUN_TEST(test_reftable_stack_validate_refname);
    +
      ## t/t0610-reftable-basics.sh ##
     @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction: e=
mpty transaction in empty repo' '
      	EOF
 5:  f336db817c =3D  5:  6615f25b08 refs/reftable: print errors on compacti=
on failure
 6:  999d0c2bb8 =3D  6:  e84b797728 t/helper: drop pack-refs wrapper
 7:  072627d82c =3D  7:  809094ffec refs: move `struct pack_refs_opts` to w=
here it's used
 8:  919abe8eb9 =3D  8:  cf966fc584 refs: remove `PACK_REFS_ALL` flag
 9:  61ebcb2d52 =3D  9:  5d7af236d4 refs/reftable: expose auto compaction v=
ia new flag
10:  ff163a621d =3D 10:  23c6c20e4e builtin/pack-refs: release allocated me=
mory
11:  8727f08bab =3D 11:  eb48ac0329 builtin/pack-refs: introduce new "--aut=
o" flag
12:  65c9ff3ee5 =3D 12:  94cb036345 builtin/gc: move `struct maintenance_ru=
n_opts`
13:  817de1a88f =3D 13:  9657c67b3b t6500: extract objects with "17" prefix
14:  474cf66b26 ! 14:  3eaff8289b builtin/gc: forward git-gc(1)'s `--auto` =
flag when packing refs
    @@ Commit message
         backend, which will continue to eagerly pack refs. But it does ens=
ure
         that the "reftable" backend only compacts refs as required.
    =20
    -    This change does not impact git-maintenance(1) as it won't ever en=
d up
    -    executing the pack-refs task when run with `--auto`.
    +    This change does not impact git-maintenance(1) because this comman=
d will
    +    in fact never run the pack-refs task when run with `--auto`. This =
issue
    +    will be addressed in a subsequent commit.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
15:  71f4800d36 =3D 15:  1bdea3b316 builtin/gc: pack refs when using `git m=
aintenance run --auto`
--=20
2.44.GIT


--wAg4VShasFqEoh9y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS7kACgkQVbJhu7ck
PpSt2g/+NnCm6A3JI318qgXXRa06v9xOTyqcrUmodiAe8Ci3ABQuwzSTZYCqtIue
nTcOYYDs8BaohaEep0B4BS3UlovKb/TPR7+WTI+inuzXsYckRz7P4teqAqWZoxGK
F1cC+h7pNFmCUyljNk1b5oPQiFsBQ3nFa6QJm3zkdTWsjf0q1zUmXqigIY5MUeV0
UtAY1XLjlkIFIbJgY7DDHc1dHgwKZPVjIM+YGEt5vE2h0huWJ/Q3F8u1cw8vBCl3
/29elowtkIROZIAnj3of7VLAIGqM3+pUPd3UYv4xU5M2RV0tGLV08/nL3y7WgzRO
nzd5TXXtirLOarGLIv1+Y9D79h3yLv0hdhzFKcGMvYMHwV2WpiKlAbztn1mi0SIs
hLTjXChoRgdrTlrhyx8K2VNS8d6vGR2R3DVvR3XyCDAeYLo/VMk/nlKV9IXpcK1a
drybQyzqpY60+YYzeLGUGEakf22gtYJ+N0x7N/Jo/Xp66fezHIsMJQJl20bhZazP
5EAh9I/24RGNAlned0biwoR0NZTK9HmxiR5Fo8lLAP2bJREscficbxaOUPyvPqjm
jeGKFDWFTP5lM3Aj04cMYeG1LSgzalUXIhTXDoxGcVqQGxK+h9aERp45HyQKDR+y
bTNyoyWlo2+7Pi8lRBEfOcsbT7/On2/P4a9zWqoGXgfzMLOnlqM=
=LzA5
-----END PGP SIGNATURE-----

--wAg4VShasFqEoh9y--
