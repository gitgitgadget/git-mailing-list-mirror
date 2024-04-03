Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D4D1E880
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 04:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712119650; cv=none; b=ETI/HE6snixYUugaMWp8lE9/fQe6cvBiNb1BD66oZbVpLpev9nbzSd2ccqSHI1McPwxS6ajF96rBg5aOsiEnyFTomfMRzhL6taoZ20GmQkJvewwFcsp6zlulGGKAfetnINAkk66+U3EKhhps/Ku0wz/u2EsxsFyimoihDtno2uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712119650; c=relaxed/simple;
	bh=qzrGfu5nkmJ2BEJrgB3El/bjEMzzmeYcHJ45k7fdEgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ku9bBwXrwwz995ovSLuL7WojUVvsdOsNG2cSfO1qqcMouQhitXNvHwYbNvvN3NU+HBdHDEQ0lN1do3l46m5WXTMd6cDgJwdQ0bPaRT9kOR4jeV0l+ldAinVNRsW+pVfRdmFGH604aAYlfEXK2eKe4tNmyRtjUULkdK7q+xvMOtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Jp2VcXaZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BDNm74h0; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Jp2VcXaZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BDNm74h0"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 25B5913800A6;
	Wed,  3 Apr 2024 00:47:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 03 Apr 2024 00:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712119646; x=1712206046; bh=tjELGlc9VB
	bd/5lrND9cs+6/K1JX3W6GSt3yJLcp1Rw=; b=Jp2VcXaZxiKvTJL44faVm9OsAY
	3Pnay9kbbzlw8JZ+NbAkkPCrXr5ugMzfG+j1ii+YULtQH+W/wvWa8FCvadd9p+JK
	G+mFFUjm8p/MXqYSzfWZWgOqcKpBGRUZTRZ93ReF3uRCi91f7jj1LhfGv9DT2wRn
	c0G4VPSAQf6GQ43WVBWsSIJfAgX7gCKkwKbH1q5Ra65Pe9sOHodPltA4ZLQX2LJC
	A1j3CqVsI5kqMe2TrJLYKZzCBpbQ2DIF2Y4Wuceg5vu/SUs1DyejS0c4ej/7nXhO
	wYLmGTLkZZjrKZo+VRUFXjnlVVumUeMWC5etLX4DeAj5bFnnV9awGxhcDPMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712119646; x=1712206046; bh=tjELGlc9VBbd/5lrND9cs+6/K1JX
	3W6GSt3yJLcp1Rw=; b=BDNm74h0euCFykFL8sFUxyLqA/k0q9uVXun+MGZJRhXY
	w2uYtPBoBY+RlbdKOQfuKagn0NqRHLU7CiHPAkuowMRJsixqBsPLuZc9JevE9f4t
	rEmkIXomLO9uU6uEENYAO9gmi602ZpI0pLiueagcmVwkH1U5v6/ezNeUy09DYM1H
	SvFK9nQ/cqUTOkhaz0NvJOvl7auh9g7JqGl2DJv63EV+TQSHZDAD+AXyhS+496N5
	dQbRkoTLNpAZZTPVjIU9AOIti0KwnXQ9XnpVctn2hf3rVuH41Mrv9CMTvrer9cig
	f2tFqpq9DhKOcx0aQKe1dh6x0Lc3u65pa9Ra1mBvZg==
X-ME-Sender: <xms:Xd8MZrEAueFZz6KZhottu2qSm1FaZj_kTyTeCm6cOPugtb4pKvuGIQ>
    <xme:Xd8MZoVthrtGrKBpZQSGE7QnQsporAZ5e80lhP9rNYDpY6hPASLqdEpLtCSAVfMDC
    Ol5ONN0e82qmfflQw>
X-ME-Received: <xmr:Xd8MZtJ3nuLhnsdfPOowIFdcaGf8CJq5OIk3JJtWNIlc8t5SZlQAjm-eAccdR0jZiOVRo4V7rq-BoXFy0UgtkJALhnZVrr8SwxTY7Y2exxZJvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudeffedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Xd8MZpEcm7Mubb3qXHj_blUOwwTCFkvhHZJyTlL92WFtQFph0bYWhg>
    <xmx:Xd8MZhU0pSTI4OePFzoVhEcfhYROp_BcKEqQzfaVIDgz1XNik-zpGA>
    <xmx:Xd8MZkOnZMHV2Ci2FTL6KOMwRnCXX44ArwTHC9uW5Dbicxcbh-zXCA>
    <xmx:Xd8MZg37goRn3VU_GpclKVkSfVFAFE8MsuuC1Pvw-Y1v-vEw-KnXUA>
    <xmx:Xt8MZve4NVkvDReGSLqM2YnTpbTYmupbVRFxNiJkYtr9QVvzTAOd0Ohj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Apr 2024 00:47:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b8662666 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Apr 2024 04:47:11 +0000 (UTC)
Date: Wed, 3 Apr 2024 06:47:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 0/2] reftable/stack: use geometric table compaction
Message-ID: <ZgzfV5aI8UshiHzX@tanuki>
References: <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
 <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9QgOMjmo4++VmHAK"
Content-Disposition: inline
In-Reply-To: <pull.1683.v4.git.1712103636.gitgitgadget@gmail.com>


--9QgOMjmo4++VmHAK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 12:20:34AM +0000, Justin Tobler via GitGitGadget wr=
ote:
> Hello again,
>=20
> This is the fourth version my patch series that refactors the reftable
> compaction strategy to instead follow a geometric sequence. Changes compa=
red
> to v3:
>=20
>  * Changed env name from GIT_TEST_REFTABLE_NO_AUTOCOMPACTION to
>    GIT_TEST_REFTABLE_AUTOCOMPACTION and set the default to false. This

You probably mean true here, not false :)

>    should hopefully be a bit more intuitive since it avoids the double
>    negative.
>  * Updated the corresponding env var test in t0610-reftable-basics.sh to
>    assert on the number of tables added and be overall less fragile.
>  * Folded lines that were too long.
>  * Updated some comments in stack.c to more accurately explain that table
>    segment end is exclusive.
>  * Dropped reftable/stack: make segment end inclusive commit to keep segm=
ent
>    end exclusive and better follow expectations.
>=20
> Thanks for taking a look!

This version looks good to me, thanks!

Patrick

> -Justin
>=20
> Justin Tobler (2):
>   reftable/stack: add env to disable autocompaction
>   reftable/stack: use geometric table compaction
>=20
>  reftable/stack.c           | 126 +++++++++++++++++++------------------
>  reftable/stack.h           |   3 -
>  reftable/stack_test.c      |  66 ++++---------------
>  reftable/system.h          |   1 +
>  t/t0610-reftable-basics.sh |  65 +++++++++++++++----
>  5 files changed, 132 insertions(+), 129 deletions(-)
>=20
>=20
> base-commit: c75fd8d8150afdf836b63a8e0534d9b9e3e111ba
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1683%2F=
jltobler%2Fjt%2Freftable-geometric-compaction-v4
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1683/jltob=
ler/jt/reftable-geometric-compaction-v4
> Pull-Request: https://github.com/gitgitgadget/git/pull/1683
>=20
> Range-diff vs v3:
>=20
>  1:  2fdd8ea1133 ! 1:  2a0421e5f20 reftable/stack: add env to disable aut=
ocompaction
>      @@ Commit message
>      =20
>           In future tests it will be neccesary to create repositories wit=
h a set
>           number of tables. To make this easier, introduce the
>      -    `GIT_TEST_REFTABLE_NO_AUTOCOMPACTION` environment variable that=
, when
>      -    set, disables autocompaction of reftables.
>      +    `GIT_TEST_REFTABLE_AUTOCOMPACTION` environment variable that, w=
hen set
>      +    to false, disables autocompaction of reftables.
>      =20
>           Signed-off-by: Justin Tobler <jltobler@gmail.com>
>      =20
>      @@ reftable/stack.c: int reftable_addition_commit(struct reftable_ad=
dition *add)
>        		goto done;
>       =20
>       -	if (!add->stack->disable_auto_compact)
>      -+	if (!add->stack->disable_auto_compact && !git_env_bool("GIT_TEST_=
REFTABLE_NO_AUTOCOMPACTION", 0))
>      ++	if (!add->stack->disable_auto_compact &&
>      ++	    git_env_bool("GIT_TEST_REFTABLE_AUTOCOMPACTION", 1))
>        		err =3D reftable_stack_auto_compact(add->stack);
>       =20
>        done:
>      @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction:=
 writes cause a
>        	test_line_count =3D 1 repo/.git/reftable/tables.list
>        '
>       =20
>      -+test_expect_success 'ref transaction: environment variable disable=
s auto-compaction' '
>      ++test_expect_success 'ref transaction: env var disables compaction'=
 '
>       +	test_when_finished "rm -rf repo" &&
>       +
>       +	git init repo &&
>       +	test_commit -C repo A &&
>      -+	for i in $(test_seq 20)
>      ++
>      ++	start=3D$(wc -l <repo/.git/reftable/tables.list) &&
>      ++	iterations=3D5 &&
>      ++	expected=3D$((start + iterations)) &&
>      ++
>      ++	for i in $(test_seq $iterations)
>       +	do
>      -+		GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C repo update-re=
f branch-$i HEAD || return 1
>      ++		GIT_TEST_REFTABLE_AUTOCOMPACTION=3Dfalse \
>      ++		git -C repo update-ref branch-$i HEAD || return 1
>       +	done &&
>      -+	test_line_count =3D 23 repo/.git/reftable/tables.list &&
>      ++	test_line_count =3D $expected repo/.git/reftable/tables.list &&
>       +
>       +	git -C repo update-ref foo HEAD &&
>      -+	test_line_count =3D 1 repo/.git/reftable/tables.list
>      ++	test_line_count -lt $expected repo/.git/reftable/tables.list
>       +'
>       +
>        check_fsync_events () {
>  2:  7e62c2286ae ! 2:  e0f4d0dbcc1 reftable/stack: use geometric table co=
mpaction
>      @@ reftable/stack.c: static int segment_size(struct segment *s)
>       -		if (fastlog2(min_seg.bytes) < fastlog2(sizes[prev]))
>       +	/*
>       +	 * Find the ending table of the compaction segment needed to rest=
ore the
>      -+	 * geometric sequence.
>      ++	 * geometric sequence. Note that the segment end is exclusive.
>       +	 *
>       +	 * To do so, we iterate backwards starting from the most recent t=
able
>       +	 * until a valid segment end is found. If the preceding table is =
smaller
>       +	 * than the current table multiplied by the geometric factor (2),=
 the
>      -+	 * current table is set as the compaction segment end.
>      ++	 * compaction segment end has been identified.
>       +	 *
>       +	 * Tables after the ending point are not added to the byte count =
because
>       +	 * they are already valid members of the geometric sequence. Due =
to the
>      @@ reftable/stack.c: static int segment_size(struct segment *s)
>       +	 * Example table size sequence requiring no compaction:
>       +	 * 	64, 32, 16, 8, 4, 2, 1
>       +	 *
>      -+	 * Example compaction segment end set to table with size 3:
>      ++	 * Example table size sequence where compaction segment end is se=
t to
>      ++	 * the last table. Since the segment end is exclusive, the last t=
able is
>      ++	 * excluded during subsequent compaction and the table with size =
3 is
>      ++	 * the final table included:
>       +	 * 	64, 32, 16, 8, 4, 3, 1
>       +	 */
>       +	for (i =3D n - 1; i > 0; i--) {
>      @@ reftable/stack_test.c: static void test_empty_add(void)
>       +	int l =3D 0;
>       +	if (sz =3D=3D 0)
>       +		return 0;
>      -+	for (; sz; sz /=3D 2) {
>      ++	for (; sz; sz /=3D 2)
>       +		l++;
>      -+	}
>       +	return l - 1;
>       +}
>       +
>      @@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction:=
 writes cause a
>       =20
>        	test_commit -C repo --no-tag B &&
>        	test_line_count =3D 1 repo/.git/reftable/tables.list
>      -@@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction=
: environment variable disables auto-compact
>      - 	do
>      - 		GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C repo update-re=
f branch-$i HEAD || return 1
>      - 	done &&
>      --	test_line_count =3D 23 repo/.git/reftable/tables.list &&
>      -+	test_line_count =3D 22 repo/.git/reftable/tables.list &&
>      -=20
>      - 	git -C repo update-ref foo HEAD &&
>      - 	test_line_count =3D 1 repo/.git/reftable/tables.list
>      +@@ t/t0610-reftable-basics.sh: test_expect_success 'ref transaction=
: env var disables compaction' '
>      + 	test_line_count -lt $expected repo/.git/reftable/tables.list
>        '
>       =20
>       +test_expect_success 'ref transaction: alternating table sizes are =
compacted' '
>       +	test_when_finished "rm -rf repo" &&
>      ++
>       +	git init repo &&
>       +	test_commit -C repo A &&
>      -+	for i in $(test_seq 20)
>      ++	for i in $(test_seq 5)
>       +	do
>       +		git -C repo branch -f foo &&
>       +		git -C repo branch -d foo || return 1
>      @@ t/t0610-reftable-basics.sh: test_expect_success 'worktree: pack-r=
efs in main rep
>        	test_when_finished "rm -rf repo worktree" &&
>        	git init repo &&
>        	test_commit -C repo A &&
>      --	git -C repo worktree add ../worktree &&
>      -+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C repo worktree a=
dd ../worktree &&
>      -+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C worktree update=
-ref refs/worktree/per-worktree HEAD &&
>      ++
>      ++	GIT_TEST_REFTABLE_AUTOCOMPACTION=3Dfalse \
>      + 	git -C repo worktree add ../worktree &&
>      ++	GIT_TEST_REFTABLE_AUTOCOMPACTION=3Dfalse \
>      ++	git -C worktree update-ref refs/worktree/per-worktree HEAD &&
>       =20
>       -	test_line_count =3D 3 repo/.git/worktrees/worktree/reftable/table=
s.list &&
>       -	test_line_count =3D 4 repo/.git/reftable/tables.list &&
>      @@ t/t0610-reftable-basics.sh: test_expect_success 'worktree: pack-r=
efs in worktree
>        	test_when_finished "rm -rf repo worktree" &&
>        	git init repo &&
>        	test_commit -C repo A &&
>      --	git -C repo worktree add ../worktree &&
>      -+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C repo worktree a=
dd ../worktree &&
>      -+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C worktree update=
-ref refs/worktree/per-worktree HEAD &&
>      ++
>      ++	GIT_TEST_REFTABLE_AUTOCOMPACTION=3Dfalse \
>      + 	git -C repo worktree add ../worktree &&
>      ++	GIT_TEST_REFTABLE_AUTOCOMPACTION=3Dfalse \
>      ++	git -C worktree update-ref refs/worktree/per-worktree HEAD &&
>       =20
>       -	test_line_count =3D 3 repo/.git/worktrees/worktree/reftable/table=
s.list &&
>       -	test_line_count =3D 4 repo/.git/reftable/tables.list &&
>      @@ t/t0610-reftable-basics.sh: test_expect_success 'worktree: pack-r=
efs in worktree
>        '
>       =20
>        test_expect_success 'worktree: creating shared ref updates main st=
ack' '
>      - 	test_when_finished "rm -rf repo worktree" &&
>      - 	git init repo &&
>      - 	test_commit -C repo A &&
>      -+	test_commit -C repo B &&
>      -=20
>      - 	git -C repo worktree add ../worktree &&
>      - 	git -C repo pack-refs &&
>       @@ t/t0610-reftable-basics.sh: test_expect_success 'worktree: creat=
ing shared ref updates main stack' '
>        	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/table=
s.list &&
>        	test_line_count =3D 1 repo/.git/reftable/tables.list &&
>       =20
>      --	git -C worktree update-ref refs/heads/shared HEAD &&
>      -+	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C worktree update=
-ref refs/heads/shared HEAD &&
>      ++	GIT_TEST_REFTABLE_AUTOCOMPACTION=3Dfalse \
>      + 	git -C worktree update-ref refs/heads/shared HEAD &&
>        	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/table=
s.list &&
>        	test_line_count =3D 2 repo/.git/reftable/tables.list
>      - '
>  3:  9a33914c852 < -:  ----------- reftable/stack: make segment end inclu=
sive
>=20
> --=20
> gitgitgadget

--9QgOMjmo4++VmHAK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYM31IACgkQVbJhu7ck
PpTnmw//TsZUIuWeJf0wkgMkAthVWp/cC1WDaiABr+2zf31Zu6D/ru+5WeBgfG9L
bm0tolM5vh86nE95GzD2Nv/YF5bvfSgu810DywI9FRm881qi6XPzqbfAMs2pFVn4
UKKSjiX85MG4Y09M5T0vIPUrPKZY8AqAZi2OAvZ1NU4GKDZyXI+FewEHmyhuOsde
kjOR+AlmOa/F2xGt90EAhD8dc/RTfPH+rLZeZUspjCCZ31l54JiVpuBpuOApqBC4
//jYO7PwI/WKEXDWlDCyz5e5PbmVEKaMeu2RglQL1VMC8qouaWyqca8yZpNHYtO8
eAs5OjVf/LKDu5pUCg86Uaus5cezoSKOanOAXkYjKIrbjngNxOCtp+II3lO0tCkB
9H//X+sM1Mifj5+kS2UQG9Ziyy9vEVY3txk1MjnB8NXj/Bb1lvYtvNopCq+51EDk
76EFN+8c8rRNtFQfDoXNi3YKgRASr6A/OnKZF0gE3L2ztxeQiGNYgwpAgf+3Repy
NDiPV/PXXb/SciPdNPlZ4+F5OdIoK9Jl4l0TUOsP9tsP8hhEN8HZ+b482pzNmILa
BB1oBDog8LB7sKapnbZ5FxuIV9jOAlyEHuElIRKd/TfwvXlTxDnwwapFQ7NCns/O
PM0NFJ3Oa8v3A38pq6JGAyFk1oC34V2m6pqTPPBls/hnPRSrzbU=
=dMv/
-----END PGP SIGNATURE-----

--9QgOMjmo4++VmHAK--
