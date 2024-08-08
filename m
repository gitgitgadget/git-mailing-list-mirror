Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9018E052
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 14:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723125982; cv=none; b=uccBf8r8YIP+SVYNEv1XMMpr5+asFPxc9bk0Ij3mZlaEaK4sOevgJ76QlksMV+pWwqbdOjuyEO4IJgJFQzs2pbSKCvHenYu2ou3vxa825buxs7K19tBqOlOuBSYwn6XDAgJQU1io3n4T5UYE4WPHmrytQnLwXFmxgiYZW3K2+C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723125982; c=relaxed/simple;
	bh=zSRmWXz8YtNmuUQPh+UfLweRj2dsGhMKqjk6U+SQoCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmCRTqkOjWV27OLgC+QtyA0glYu5PEk8KkBxRdOD4SEBvTwUzt3ocQEFBsz2a+iQHjj7s989e48wFKN6W4vMTVqU4xoMgarpGyj23n9JpiaXefZUOFlTv8veHYJmj94mP0mE0NzVyj2vxEZduHcTNAFXpksw+htc0jpHRaI8IhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RFK7oSH/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=spDzGRe5; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RFK7oSH/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="spDzGRe5"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7DBA91150DE1;
	Thu,  8 Aug 2024 10:06:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 08 Aug 2024 10:06:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723125979; x=1723212379; bh=Ef/0DA7jNJ
	voWwu8f4gJcGRb7IB2YrBZU1YZ92uLPLM=; b=RFK7oSH/Gmzb5MfBzohLcprscx
	hChsjgS5V6TIMOYgoWo7jIrBEQcCpTByZ7X+DzaBnQZodpHynRZZUk/aZcKJFkuv
	ZhRSCT1LxNTbcEb9ZvpVROuttj3qDyEceGjBmFSbZb2O1dvp/cy6JOV5E37XxqAr
	yfdRyV+Tg7zlPPWW1vb4kaV5qtHNJGHZIx4Y8Pw61wNn4jDk3swDomnfXQ4LjbcE
	KSpO+hJkV3GJKiuHxGMK39Grab9KveJVfPYLjVYBcRRBHyR35jX0IZlca2NPIN7f
	ue+nZk1yCb05rSKSUOrMyjsJW8l+2mEWC+mgmqm+/mTRNeAmnYi5PXP/fUjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723125979; x=1723212379; bh=Ef/0DA7jNJvoWwu8f4gJcGRb7IB2
	YrBZU1YZ92uLPLM=; b=spDzGRe507FfsdBelA+LzVoBQ5m5VKcACgfb1/e67swm
	EEj0LTT9jPuiUPmE4yJyV8FY+u1a106g8SO3Z28RaU0O+myNYoQ+HMeXVJp3+3rp
	wTCJGoCxkRGYKQZGGPK1nlItB1/NAJTPlF/0KYQ3OMCfGPG1ldKCOZgpDCRjRWWM
	PTOCAk9fgc16SOx1MQPGd2O6IDu8Ng659/qbYjUUG9qZDuf31+mlvueqH7dECrmT
	gqEC67cvkmxCI6EJ4338mNaZX6vqcDMyASgNn6lFn2CC9hFZQEP0u1kjnTe5sMAE
	f0rB9T4i6iIYSvYS+ohPeAho2GbNhzUFQYdQ9tVG4g==
X-ME-Sender: <xms:29C0Zq6F1hs3Em2N6-m_t14G3t414sDy8Fw41gW4gArXYaLwWylubA>
    <xme:29C0Zj5bz_6R9ko7qsvz6F_9ETj6V-URmnj5XsZ2cXx_3VA_yWF0ChXt5o6t18Rtt
    CQDuqaggNYrimuEfw>
X-ME-Received: <xmr:29C0Zpfly6KxaI-IR6KqkuzIr-VlH-5ORwuFhvV13U5oP6vG2dIpHQvvJnJgSQ3X1Z2BpX8kIgdHNdk_m_eXWQp-8emrVwa58hdQcjg7Qaor6b2p>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrledvgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeeh
    gfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:29C0ZnLXLV-Hzb5THUoH-eDDwyK3WkTV5ScSC4fFBDrAZoyv00mzHw>
    <xmx:29C0ZuLrcGtgoqiG6RjkoDmXmBhdQJCQlJFCKvY0mMRx2Y_meUQgdw>
    <xmx:29C0ZowXQCQqN59DV-m17DpTOkatRUWO6D0SBb3t7EqfqGQ2juSlsg>
    <xmx:29C0ZiJgH5QviBUl5jnvu-mu9hMetTDqrDr7BLb6YsQobE1dWKejEA>
    <xmx:29C0ZjERnOxICng2H5K4CqRrAEFVjzi7-LpLdrYpUfVIDx_iJrTkUP0M>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Aug 2024 10:06:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c66f223a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 8 Aug 2024 14:06:09 +0000 (UTC)
Date: Thu, 8 Aug 2024 16:06:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 0/9] reftable: improvements and fixes for compaction
Message-ID: <cover.1723123606.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="30UT7+utR4QprbRb"
Content-Disposition: inline
In-Reply-To: <cover.1722435214.git.ps@pks.im>


--30UT7+utR4QprbRb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that aims to improve the
way reftable stack perform compaction.

Changes compared to v2:

  - Drop the unused `reftable_write_options` structure in
    `write_n_ref_tables()`.

  - Fix a commit message typo.

  - Reorder some variable assignments to feel more natural.

Thanks!

Patrick

Patrick Steinhardt (9):
  reftable/stack: refactor function to gather table sizes
  reftable/stack: extract function to setup stack with N tables
  reftable/stack: test compaction with already-locked tables
  reftable/stack: update stats on failed full compaction
  reftable/stack: simplify tracking of table locks
  reftable/stack: do not die when fsyncing lock file files
  reftable/stack: use lock_file when adding table to "tables.list"
  reftable/stack: fix corruption on concurrent compaction
  reftable/stack: handle locked tables during auto-compaction

 reftable/stack.c           | 231 +++++++++++++++++++++++++++++--------
 reftable/stack_test.c      | 142 ++++++++++++++++++-----
 t/t0610-reftable-basics.sh |  21 ++--
 3 files changed, 310 insertions(+), 84 deletions(-)

Range-diff against v2:
 1:  6d2b54ba8e =3D  1:  6d2b54ba8e reftable/stack: refactor function to ga=
ther table sizes
 2:  ff17306cc0 !  2:  798a661824 reftable/stack: extract function to setup=
 stack with N tables
    @@ Commit message
         tests. This is fine though as we only care about the shape of the =
stack
         here, not the shape of each table.
    =20
    +    Furthermore, with this change we now start to disable auto compact=
ion
    +    when writing the tables, as otherwise we might not end up with the
    +    expected amount of new tables added. This also slightly changes the
    +    behaviour of these tests, but the properties we care for remain in=
tact.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## reftable/stack_test.c ##
    @@ reftable/stack_test.c: static int write_test_ref(struct reftable_wri=
ter *wr, voi
      }
     =20
     +static void write_n_ref_tables(struct reftable_stack *st,
    -+			       struct reftable_write_options *opts,
     +			       size_t n)
     +{
     +	struct strbuf buf =3D STRBUF_INIT;
    ++	int disable_auto_compact;
     +	int err;
     +
    ++	disable_auto_compact =3D st->opts.disable_auto_compact;
    ++	st->opts.disable_auto_compact =3D 1;
    ++
     +	for (size_t i =3D 0; i < n; i++) {
     +		struct reftable_ref_record ref =3D {
     +			.update_index =3D reftable_stack_next_update_index(st),
    @@ reftable/stack_test.c: static int write_test_ref(struct reftable_wri=
ter *wr, voi
     +		EXPECT_ERR(err);
     +	}
     +
    ++	st->opts.disable_auto_compact =3D disable_auto_compact;
     +	strbuf_release(&buf);
     +}
     +
    @@ reftable/stack_test.c: static void test_reftable_stack_compaction_co=
ncurrent(voi
     -		err =3D reftable_stack_add(st1, &write_test_ref, &ref);
     -		EXPECT_ERR(err);
     -	}
    -+	write_n_ref_tables(st1, &opts, 3);
    ++	write_n_ref_tables(st1, 3);
     =20
      	err =3D reftable_new_stack(&st2, dir, &opts);
      	EXPECT_ERR(err);
    @@ reftable/stack_test.c: static void test_reftable_stack_compaction_co=
ncurrent_cle
     -		err =3D reftable_stack_add(st1, &write_test_ref, &ref);
     -		EXPECT_ERR(err);
     -	}
    -+	write_n_ref_tables(st1, &opts, 3);
    ++	write_n_ref_tables(st1, 3);
     =20
      	err =3D reftable_new_stack(&st2, dir, &opts);
      	EXPECT_ERR(err);
 3:  63e64c8d82 !  3:  949f748823 reftable/stack: test compaction with alre=
ady-locked tables
    @@ reftable/stack_test.c: static void test_reftable_stack_auto_compacti=
on(void)
     +	err =3D reftable_new_stack(&st, dir, &opts);
     +	EXPECT_ERR(err);
     +
    -+	write_n_ref_tables(st, &opts, 5);
    ++	write_n_ref_tables(st, 5);
     +	EXPECT(st->merged->stack_len =3D=3D 5);
     +
     +	/*
    @@ reftable/stack_test.c: static void test_reftable_stack_add_performs_=
auto_compact
     +	err =3D reftable_new_stack(&st, dir, &opts);
     +	EXPECT_ERR(err);
     +
    -+	write_n_ref_tables(st, &opts, 3);
    ++	write_n_ref_tables(st, 3);
     +	EXPECT(st->merged->stack_len =3D=3D 3);
     +
     +	/* Lock one of the tables that we're about to compact. */
 4:  1989dafcb4 =3D  4:  478f945a45 reftable/stack: update stats on failed =
full compaction
 5:  73e5d104eb =3D  5:  812a45f3d2 reftable/stack: simplify tracking of ta=
ble locks
 6:  e411e14904 =3D  6:  d7d34e7253 reftable/stack: do not die when fsyncin=
g lock file files
 7:  b868a518d6 =3D  7:  37a757649a reftable/stack: use lock_file when addi=
ng table to "tables.list"
 8:  ff17414d26 !  8:  b27cb325fc reftable/stack: fix corruption on concurr=
ent compaction
    @@ reftable/stack.c: static int stack_compact_range(struct reftable_sta=
ck *st,
     +		 * We have found the new range that we want to replace, so
     +		 * let's update the range of tables that we want to replace.
     +		 */
    -+		last_to_replace =3D last + (new_offset - first);
     +		first_to_replace =3D new_offset;
    ++		last_to_replace =3D last + (new_offset - first);
     +	} else {
     +		/*
     +		 * `fd_read_lines()` uses a `NULL` sentinel to indicate that
    @@ reftable/stack.c: static int stack_compact_range(struct reftable_sta=
ck *st,
     +		REFTABLE_CALLOC_ARRAY(names, st->merged->stack_len + 1);
     +		for (size_t i =3D 0; i < st->merged->stack_len; i++)
     +			names[i] =3D xstrdup(st->readers[i]->name);
    -+		last_to_replace =3D last;
     +		first_to_replace =3D first;
    ++		last_to_replace =3D last;
     +	}
     +
      	/*
 9:  1ef560feb1 !  9:  dc2fea145d reftable/stack: handle locked tables duri=
ng auto-compaction
    @@ Commit message
         this situation by instead compacting tables which aren't locked. T=
o do
         so, instead of locking from the beginning of the slice-to-be-compa=
cted,
         we start locking tables from the end of the slice. Once we hit the=
 first
    -    table that is locked already, we abort. If we succeded to lock two=
 or
    +    table that is locked already, we abort. If we succeeded to lock tw=
o or
         more tables, then we simply reduce the slice of tables that we're =
about
         to compact to those which we managed to lock.
    =20
--=20
2.46.0.46.g406f326d27.dirty


--30UT7+utR4QprbRb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAma00NUACgkQVbJhu7ck
PpT+kg//cYDTxu23iwfRRZnanpbncUoRDucDFn4XyFiEBAYdrVeClqJkCF8kOqgU
3dhcCxc2MVh6Uv0gEXdrIG+Q3mOyZv9AeigWX2c60NkWxf7+sXRw1TDFm7BLHHBQ
QkVAiQL29ehVZ3rbeNDn8f5ZeH2PFpDhCubrHJLI+8xX1vbPglmdIgKUOF9zfP/w
BKbzavIZT393MZ+/Mgh44IN9t0UrqLcFQSc9JiJG+7z8OzgLQGmtqMIxVBya+i8N
mQjmlBhSmv9kiCXoa447zFgE/RMe2uXGRKUgllJz6+NK8ZvaAJWC35Ssw5ZLym6g
dGAV0ykZInMTqWDtNpj4aUy6uZEul9Q+98sgoxdn0LwCV6Ou3gH6RYwvgSx3Nsj6
miITzjci0Wu7Id8sSrlPrSOeMILJWgmvbI6c4eDqe5lPxMJZ/SRceAL577p58DMF
+fVWPMXjW7e3ypO10HkoxCAuz+X5g2D9mOgnA8x0YldFEpR09jPbLkTLZzDWuZRq
hWHRzCLPttQikmHt+7z8BGXX4g3kY6FN4WOEZeiERCw+9L/gAKuGOq34UTCP/F1k
ppeMdtTA3N/J/whFMpDMPorQ85wTkg+5PKh50CWbN51EkySUAGruERmG/POIFYe9
spE6k9pLVypukhJy0jyR2WKJ8ngz4/3y4HfHz0QAJdZG/xs56C8=
=8TBm
-----END PGP SIGNATURE-----

--30UT7+utR4QprbRb--
