Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E6B1553BD
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 13:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722863268; cv=none; b=oat8CfX7FD7B8JHk5/YiKM1z41U5kdwKYJc2YkQ+5m1p6xxMylX1zkbdzO90aH+7WY4Rjhp1rBvJ2fQCKRoRwPFelQ7kYZC0/BlxV98G48UyrXzzNGRfsb15BZAwunZIWCRgQJN+56aHBEhmZsOjT55DHaQ69e3amWccc/6Z+QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722863268; c=relaxed/simple;
	bh=YtbwhYx/9xRYCzpbjSQEpYdvFaeI04O1SQW9Tew1puw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j51/b/3FZ4sqfY1WxbyNF9xulh87QiEuE7sSgsEDqOjBIv5tm5ggnoxl1UJwUfX1a5aywssz2+O8EBWNzILtZy4QYCRYyLvsys43KH15uxIlE951ZlQs8O9+KskehpfZW4XLflN51AYIpOV37IKyHVMLyLMaB043lFnlAbLrM3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ISKD8sPH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T8svHqvf; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ISKD8sPH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T8svHqvf"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 47B84138FC79;
	Mon,  5 Aug 2024 09:07:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 05 Aug 2024 09:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722863266; x=1722949666; bh=1bey1DrG++
	XMtdLjud32glRAexDw5z0xLuxrq4e+ytk=; b=ISKD8sPH76cxbP5yBFsCjWdpdv
	n5FBzOduzsVcgyIKe2HFJwbBi+Ho76zZQnW9Jo4OUwgfw+EamjaIYiGttA4y0/QC
	0m56qNSVNIIjTMfDupbcAmqVS598NZnjQ0cr7jGZn6TXOfb8FjdQRgdJISJmyED1
	n7JGciq6pLHvERwECKsyZ/oOS7wOeDApQiAbqEcFMf9n10RuOsHM2xUX0ifYKRwn
	MvvyC5tMPvL9Xq9Vl6PW9/UuTM9j6Zjlz4m1xhfEeqtDWVyl+QcL7dZ1WTJq7Mn2
	wnW0uIAV727h348bed3D2J6R0ZmNcefQiF9k0CtJWlAmRRs4fV1LTBond9OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722863266; x=1722949666; bh=1bey1DrG++XMtdLjud32glRAexDw
	5z0xLuxrq4e+ytk=; b=T8svHqvf2L6TIWbbPKHsa3IlvZRgRSlEd2LowHIeLbq7
	s3rLp8SK1Z+qHwC74KOIOZGDXQ73dFx7Q8XRSz5FVyk/LmfoRzWFeLtjDikmb8sR
	x2Z+0JB3qqxUHMfVDCzZLeFd0BUtcVRwC52PFkrypGXxsmucvLmVVVUsqd2JkPpp
	Op0P9qrGrSRsCZO9yIoCo1lQ+JqeOQmpIynYQGe3PTR3AiQqawLduZwsT0py9rWA
	RkjvRjq8WnRuHu4lSwOufRn0Sen1xLjsP30GWgOXtBdCS64B53M0kuOdXzYcpWXo
	daQu8iXWUkXy2/K1z0EFhNve/d6rx/Axy9raIok2mw==
X-ME-Sender: <xms:os6wZhN56u7_HdQVtdgdyhXrrz5KAAQ59yTzGN23ni1J7pulVHfrgg>
    <xme:os6wZj-7FsKNxQoBTUsR43sS9n2NjFjAEWGZDT03MFKfX-Euc0NO99o8SRewbHt88
    Cb42QIDjMsKt0CKBw>
X-ME-Received: <xmr:os6wZgSsXEfCI96mDPVRzHQt4S4xL62aUR9dgPkoZXYo0tau1Xl-apUq3_CaGGxji4o8VaVdfv8YrFQXsyZuxH-pS2U-r2loHQBH26Vom9VzfLud8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdeiudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:os6wZttBlPWTaxmHm2f4YBzrw1jQGclZT5maSgt2m68QQ4FKLNfhmg>
    <xmx:os6wZpeQcp-k8PZi8sKOC8bNo4x96bHCI6ZZ4a6svFcIK9D0JzJxAw>
    <xmx:os6wZp3WyY9Y0ud4-VluNr4c8qqyip7pYYI8R9LvMSavK9SFJfRQyQ>
    <xmx:os6wZl8AGwFPgPhVB5-XI_TidrTEEU6HJX1j7oMDBWK00Bdnuvg4vA>
    <xmx:os6wZt6SqVJxKS8l0PziW2Rjk2Kpq9O5fBBW02csGJ3pvityd7hwaOgu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 09:07:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 12d38d0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 13:07:43 +0000 (UTC)
Date: Mon, 5 Aug 2024 15:07:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/9] reftable: improvements and fixes for compaction
Message-ID: <cover.1722862822.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5avwf26PhWLqFQFs"
Content-Disposition: inline
In-Reply-To: <cover.1722435214.git.ps@pks.im>


--5avwf26PhWLqFQFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that aims to improve the
way reftable stack perform compaction.

Changes compared to v1:

  - Extract a test helper function that sets up a stack with N tables
    containing refs.

  - Reuse file descriptor that we have already stored in a local
    variable instead of calling `lock_file_fd()` a second time.

  - Remove a no-op change in the last patch.

  - Add a comment explaining why we have to allocate N+1 many table
    names.

  - Some typo fixes.

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
 reftable/stack_test.c      | 138 +++++++++++++++++-----
 t/t0610-reftable-basics.sh |  21 ++--
 3 files changed, 306 insertions(+), 84 deletions(-)

Range-diff against v1:
 1:  5d99191f5c =3D  1:  6d2b54ba8e reftable/stack: refactor function to ga=
ther table sizes
 -:  ---------- >  2:  ff17306cc0 reftable/stack: extract function to setup=
 stack with N tables
 2:  123fb9d80e !  3:  63e64c8d82 reftable/stack: test compaction with alre=
ady-locked tables
    @@ reftable/stack_test.c: static void test_reftable_stack_auto_compacti=
on(void)
     +	err =3D reftable_new_stack(&st, dir, &opts);
     +	EXPECT_ERR(err);
     +
    -+	for (size_t i =3D 0; i < 5; i++) {
    -+		struct reftable_ref_record ref =3D {
    -+			.update_index =3D reftable_stack_next_update_index(st),
    -+			.value_type =3D REFTABLE_REF_VAL1,
    -+			.value.val1 =3D { i },
    -+		};
    -+
    -+		strbuf_reset(&buf);
    -+		strbuf_addf(&buf, "refs/heads/branch-%04" PRIuMAX, (uintmax_t) i);
    -+		ref.refname =3D buf.buf;
    -+
    -+		err =3D reftable_stack_add(st, &write_test_ref, &ref);
    -+		EXPECT_ERR(err);
    -+	}
    ++	write_n_ref_tables(st, &opts, 5);
     +	EXPECT(st->merged->stack_len =3D=3D 5);
     +
     +	/*
    @@ reftable/stack_test.c: static void test_reftable_stack_add_performs_=
auto_compact
     +	err =3D reftable_new_stack(&st, dir, &opts);
     +	EXPECT_ERR(err);
     +
    -+	for (size_t i =3D 0; i < 3; i++) {
    -+		struct reftable_ref_record ref =3D {
    -+			.update_index =3D reftable_stack_next_update_index(st),
    -+			.value_type =3D REFTABLE_REF_VAL1,
    -+			.value.val1 =3D { i },
    -+		};
    -+
    -+		strbuf_reset(&buf);
    -+		strbuf_addf(&buf, "refs/heads/branch-%04" PRIuMAX, (uintmax_t) i);
    -+		ref.refname =3D buf.buf;
    -+
    -+		err =3D reftable_stack_add(st, &write_test_ref, &ref);
    -+		EXPECT_ERR(err);
    -+	}
    ++	write_n_ref_tables(st, &opts, 3);
     +	EXPECT(st->merged->stack_len =3D=3D 3);
     +
     +	/* Lock one of the tables that we're about to compact. */
 3:  1fa7acbddf =3D  4:  1989dafcb4 reftable/stack: update stats on failed =
full compaction
 4:  40d9f75cf2 =3D  5:  73e5d104eb reftable/stack: simplify tracking of ta=
ble locks
 5:  9233c36894 =3D  6:  e411e14904 reftable/stack: do not die when fsyncin=
g lock file files
 6:  9703246156 !  7:  b868a518d6 reftable/stack: use lock_file when adding=
 table to "tables.list"
    @@ Commit message
         compacting the stack, we manually handle the lock when adding a new
         table to it. While not wrong, it is at least inconsistent.
    =20
    -    Refactor the code to consistenly lock "tables.list" via the `lock_=
file`
    +    Refactor the code to consistently lock "tables.list" via the `lock=
_file`
         subsytem.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    @@ reftable/stack.c: int reftable_addition_commit(struct reftable_addit=
ion *add)
      		goto done;
      	}
     =20
    --	err =3D fsync_component(FSYNC_COMPONENT_REFERENCE, lock_file_fd);
    -+	err =3D fsync_component(FSYNC_COMPONENT_REFERENCE,
    -+			      get_lock_file_fd(&add->tables_list_lock));
    - 	if (err < 0) {
    - 		err =3D REFTABLE_IO_ERROR;
    - 		goto done;
    - 	}
    -=20
     -	err =3D rename_tempfile(&add->lock_file, add->stack->list_file);
     +	err =3D commit_lock_file(&add->tables_list_lock);
      	if (err < 0) {
 7:  b746565bf0 !  8:  ff17414d26 reftable/stack: fix corruption on concurr=
ent compaction
    @@ Commit message
         Letting concurrent processes modify the "tables.list" file while w=
e are
         doing the compaction is very much part of the design and thus expe=
cted.
         After all, it may take some time to compact tables in the case whe=
re we
    -    are compacting a lot or very large tables.
    +    are compacting a lot of very large tables.
    =20
         But there is a bug in the code. Suppose we have two processes whic=
h are
         compacting two slices of the table. Given that we lock each of the
    @@ Commit message
         process will always impact what the other process needs to write t=
o the
         "tables.list" file.
    =20
    -    Right now , we do not check whether the "tables.list" has been
    -    changed after we have locked it for the second time in (5). This h=
as the
    +    Right now, we do not check whether the "tables.list" has been chan=
ged
    +    after we have locked it for the second time in (5). This has the
         consequence that we will always commit the old, cached in-core tab=
les to
         disk without paying to respect what the other process has written.=
 This
         scenario would then lead to data loss and corruption.
    @@ reftable/stack.c: static int stack_compact_range(struct reftable_sta=
ck *st,
     +		last_to_replace =3D last + (new_offset - first);
     +		first_to_replace =3D new_offset;
     +	} else {
    ++		/*
    ++		 * `fd_read_lines()` uses a `NULL` sentinel to indicate that
    ++		 * the array is at its end. As we use `free_names()` to free
    ++		 * the array, we need to include this sentinel value here and
    ++		 * thus have to allocate `stack_len + 1` many entries.
    ++		 */
     +		REFTABLE_CALLOC_ARRAY(names, st->merged->stack_len + 1);
     +		for (size_t i =3D 0; i < st->merged->stack_len; i++)
     +			names[i] =3D xstrdup(st->readers[i]->name);
 8:  dc22178307 !  9:  1ef560feb1 reftable/stack: handle locked tables duri=
ng auto-compaction
    @@ reftable/stack.c: static int stack_compact_range(struct reftable_sta=
ck *st,
      		}
     =20
      		/*
    -@@ reftable/stack.c: static int stack_compact_range(struct reftable_st=
ack *st,
    - 	 * delete the files after we closed them on Windows, so this needs to
    - 	 * happen first.
    - 	 */
    --	err =3D reftable_stack_reload_maybe_reuse(st, first < last);
    -+	err =3D reftable_stack_reload_maybe_reuse(st, first_to_replace < las=
t_to_replace);
    - 	if (err < 0)
    - 		goto done;
    -=20
     @@ reftable/stack.c: static int stack_compact_range(struct reftable_st=
ack *st,
     =20
      static int stack_compact_range_stats(struct reftable_stack *st,

base-commit: 39bf06adf96da25b87c9aa7d35a32ef3683eb4a4
--=20
2.46.0.dirty


--5avwf26PhWLqFQFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzp0ACgkQVbJhu7ck
PpSrOw/6A0WvR6+kMxklT71YSVOYXymGFMz+jGD9Aco+fLsIcIT4ITTIqJuVCQca
mFnvBUtTERndNICjfZLYdp1/KHq6scKTJluN2WRp3k3IKYJAl+X/aW4759p9Fw9A
04+FjLvZbCHiW/9owMQrZt9G2yYlkof0r0q8DMIPp4eBgZxUmMSTeGWqmx/ooYgi
zjJdhWSdMFYGzLPUjZ0KPfjmKfjSyzkt4m9yW6iChH8PC1cBksEqSAQFXJzMgjK0
OmswwFI0dy06t/8fljdNroHbZ+kmcbYVJrofpUQF7cbQdhpsVjnZXEiAy8hRyFN1
FMI5Hi2f7/4Vs9XBz74VAFxiOfY5kIrkNv13zO2ZL6goZdmoJusUJArsNizCtBhD
OznQgSJnCkHYFOd/taCQ4zQK4NQ13WHCSXFdpKXCHOBrdfds19Z6vZV26EkrRhhL
Wh3OXyuKrZKBcP37KQRd0dDsEtNLWuDcbTWCC+NdHpASl0BpxGl2jkSJbOFjW0lM
M6ov5n18UDgIgppoJH/9EUhuC3nOWQsbIaFOPiUtLvVR8ycJJ7vctk6BL/4aDjt/
XthfTS3Mp5ren9S8T4Dvs0Xl7oMNQy0pPadPBGOcxID0VaCn2HohiaFmlCUwUQAk
FByBMDwYYFNIIxfaBhrZE6wNUu5aeQxAUFKonX+Ial34du/fFCM=
=9gcN
-----END PGP SIGNATURE-----

--5avwf26PhWLqFQFs--
