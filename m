Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389D720B28
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209692; cv=none; b=Vr/RfhIbq+2g6edvkLCb3mlBamhkj4RRK3Q3+gZoEBYh58Km8MViOV2gzTj0jpW1FJpfKfRBwtMsD203Q1zXoTt7ErQtXodTWbZ0Nf1+ZpFet2B9tvIL5/BZDU9wwzkWpRB2nZ8AcMjiRge9l4e48jksa3501hrOPM3Tdh7C1iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209692; c=relaxed/simple;
	bh=r84xHDauTzLYtVYXfmU7xi9VSlCDWmNvCX0QWMonADw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GeS/w5p7MRL3ZtxiQWE2lpFCUHt2V9MhYx+DaqsRSasPfnOziMtvGnfPlB5QJ/69hbBJJRzCno+Z9bd1gOf24sLzsleC3lSrvXd2NZBpKlVk6yy/aQozPKYM3j8zwZvGFKZiDqcLzEB2ivBczifMqVhNuU3Xugh2hiuROFNP3bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MjVFA7Cb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WP+9hUeQ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MjVFA7Cb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WP+9hUeQ"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 309621380157;
	Thu,  4 Apr 2024 01:48:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Apr 2024 01:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209689; x=1712296089; bh=KK7Oca6/VB
	sIRU3wfEv7Kl12mFoKrxeQvLWECDYpjmE=; b=MjVFA7CbBCa+tj5b/rqS3jieDF
	/jDbThW/GwJOapfy3PrbL0/N6sPxLMWb/pgH/iHjPQ+Fp94o8ijaj7EVPYD4QTJe
	1aQUQIusflPCgr3u4ExJnZ9mX+BBt35IQGlVVSnsVATCyd7Bqs1l36iDbjB/t5Of
	vbWGkctMdHrOYath2ftRMmJK+SwFQJi5uADS34flbWw0fCLavx06vj/3xq1SzByT
	Kqxe/2M2yVyRgsW8iqmmV2SE99M8lZKbcyLWXT43ra3zAH5raPj4QQ8CECUFY6kH
	/osugEzK1aoZdAElqoH9zqbV4CP7kzN8UdQ8dUaUHZdIapzku4QnP0tClmoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209689; x=1712296089; bh=KK7Oca6/VBsIRU3wfEv7Kl12mFoK
	rxeQvLWECDYpjmE=; b=WP+9hUeQjZRat0Pct1kfJC3et7n/lfU0MUU1IoxkwoVX
	uXprKuXJdFcJmEQ2y94oKHfdpEa51vbSIIez25dAe/VLKCMG/tOgbBCQ9LTdHzXp
	KMGctYRAT/LQnAB8QGjAhqNzSjN8FanRqG1xkGr5hDizkhPv/3CyRKOCyUeiqIlp
	fk+8QA3rqUNnBOfNFYuMGqyKUMWeHFYf+qVmofO6tl6v3xOiFKFk9dnw2Fqs0YDu
	QBba/ShlDqRUTnya+vpXkUecSzFx4qLneylfdVaW5o3kvV5xSnif8Qa1+4RcFx4a
	yyeEQDQALzvqutbOAKPFWYlCmfWW1h5X4tnJRX+M7Q==
X-ME-Sender: <xms:GD8OZn2dMPWA7EenH-YsARHTMm5JY54KM8nnZjb1XpQpb9tE3i8NLA>
    <xme:GD8OZmF4Y_A25hp9CabSVxDygxjWs8nRxvHHirPrIm0lJRNymdHWEZoHBjoNA73X-
    b28aGQPW9-NpYLfpg>
X-ME-Received: <xmr:GD8OZn6_Tce-x68aVAd-E0vHZeNT-i75qvfacoXT01qDn2Sc8OiKVsKIWjXTyo5rkEbpUIBYEBflyljgvwWbe3aP3mpr9-HKlqzlkAnsMM5iICt9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:GT8OZs0oMcd5hfhAE465CVg-qibWox6isV1vWF0QqMlPrKs8uQnKtQ>
    <xmx:GT8OZqFR1pnSMi_deeonHuaSoOUvFgio508O7edXhcjUMIM-M-aymA>
    <xmx:GT8OZt8D6mxEbQESoE4466jefNqRo_AZhgFlhU4y6hKVH2dQWceosQ>
    <xmx:GT8OZnmRTwVVc8G6SbKdh3PY6tFB4BlVLz2kb7L0vT1diB9HX2dKvA>
    <xmx:GT8OZmh2Cp2Nr2NzqNKcDvqNxNp0WNn71LGMxSpPHmv0L0icAx8pStd5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:48:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 9221c8cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:48:04 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:48:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v2 00/11] reftable: optimize write performance
Message-ID: <cover.1712209149.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E84FwixQ4q4VCwnO"
Content-Disposition: inline
In-Reply-To: <cover.1712078736.git.ps@pks.im>


--E84FwixQ4q4VCwnO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that aims to optimize
write performance in the reftable backend. I've made the following
changes compared to v2:

  - Added a new patch to drop "reftable/refname.{c,h}" and related
    completely.

  - Reworded the commit message for the committer ident refactorings.

  - Added a new patch that unifies the code paths that release reftable
    writer resources.

  - Fixed a stale comment claiming that we retry deflating, which we
    don't.

Thanks!

Patrick

Patrick Steinhardt (11):
  refs/reftable: fix D/F conflict error message on ref copy
  refs/reftable: perform explicit D/F check when writing symrefs
  refs/reftable: skip duplicate name checks
  reftable: remove name checks
  refs/reftable: don't recompute committer ident
  reftable/writer: refactorings for `writer_add_record()`
  reftable/writer: refactorings for `writer_flush_nonempty_block()`
  reftable/writer: unify releasing memory
  reftable/writer: reset `last_key` instead of releasing it
  reftable/block: reuse zstream when writing log blocks
  reftable/block: reuse compressed array

 Makefile                   |   2 -
 refs/reftable-backend.c    |  75 +++++++++----
 reftable/block.c           |  80 ++++++++------
 reftable/block.h           |   4 +
 reftable/error.c           |   2 -
 reftable/refname.c         | 209 -------------------------------------
 reftable/refname.h         |  29 -----
 reftable/refname_test.c    | 101 ------------------
 reftable/reftable-error.h  |   3 -
 reftable/reftable-tests.h  |   1 -
 reftable/reftable-writer.h |   4 -
 reftable/stack.c           |  67 +-----------
 reftable/stack_test.c      |  39 -------
 reftable/writer.c          | 137 +++++++++++++++---------
 t/helper/test-reftable.c   |   1 -
 t/t0610-reftable-basics.sh |  35 ++++++-
 16 files changed, 230 insertions(+), 559 deletions(-)
 delete mode 100644 reftable/refname.c
 delete mode 100644 reftable/refname.h
 delete mode 100644 reftable/refname_test.c

Range-diff against v1:
 1:  14b4dacd73 =3D  1:  926e802395 refs/reftable: fix D/F conflict error m=
essage on ref copy
 2:  55db366e61 =3D  2:  6190171906 refs/reftable: perform explicit D/F che=
ck when writing symrefs
 3:  ad8210ec65 =3D  3:  80008cc5e7 refs/reftable: skip duplicate name chec=
ks
 -:  ---------- >  4:  3497a570b4 reftable: remove name checks
 4:  a9a6795c02 !  5:  f892a3007b refs/reftable: don't recompute committer =
ident
    @@ Commit message
         refs/reftable: don't recompute committer ident
    =20
         In order to write reflog entries we need to compute the committer's
    -    identity as it becomes encoded in the log record itself. In the re=
ftable
    -    backend, computing the identity is repeated for every single reflog
    -    entry which we are about to write in a transaction. Needless to sa=
y,
    -    this can be quite a waste of effort when writing many refs with re=
flog
    -    entries in a single transaction.
    +    identity as it gets encoded in the log record itself. The reftable
    +    backend does this via `git_committer_info()` and `split_ident_line=
()` in
    +    `fill_reftable_log_record()`, which use the Git config as well as
    +    environment variables to figure out the identity.
    +
    +    While most callers would only call `fill_reftable_log_record()` on=
ce or
    +    twice, `write_transaction_table()` will call it as many times as t=
here
    +    are queued ref updates. This can be quite a waste of effort when w=
riting
    +    many refs with reflog entries in a single transaction.
    =20
         Refactor the code to pre-compute the committer information. This r=
esults
         in a small speedup when writing 100000 refs in a single transactio=
n:
 5:  8e9d69e9e6 =3D  6:  4877ab3921 reftable/writer: refactorings for `writ=
er_add_record()`
 6:  1f903afdda =3D  7:  8f1c5b4169 reftable/writer: refactorings for `writ=
er_flush_nonempty_block()`
 -:  ---------- >  8:  41db7414e1 reftable/writer: unify releasing memory
 9:  6950ae4ea7 !  9:  e5c7dbe417 reftable/writer: reset `last_key` instead=
 of releasing it
    @@ reftable/writer.c: static void writer_reinit_block_writer(struct ref=
table_writer
      	block_writer_init(&w->block_writer_data, typ, w->block,
      			  w->opts.block_size, block_start,
      			  hash_size(w->opts.hash_id));
    -@@ reftable/writer.c: void reftable_writer_free(struct reftable_writer=
 *w)
    - 		block_writer_release(w->block_writer);
    - 		w->block_writer =3D NULL;
    - 	}
    -+	strbuf_release(&w->last_key);
    - 	reftable_free(w->block);
    - 	reftable_free(w);
    - }
     @@ reftable/writer.c: static int writer_finish_section(struct reftable=
_writer *w)
      	bstats->max_index_level =3D max_level;
     =20
 7:  86dab54dfe ! 10:  26f422703f reftable/block: reuse zstream when writin=
g log blocks
    @@ reftable/block.c: int block_writer_finish(struct block_writer *w)
     +		w->zstream->avail_in =3D src_len;
     +
     +		/*
    -+		 * We want to perform all decompression in a single
    -+		 * step, which is why we can pass Z_FINISH here. Note
    -+		 * that both `Z_OK` and `Z_BUF_ERROR` indicate that we
    -+		 * need to retry according to documentation.
    -+		 *
    -+		 * If the call fails we retry with a bigger output
    -+		 * buffer.
    ++		 * We want to perform all decompression in a single step, which
    ++		 * is why we can pass Z_FINISH here. As we have precomputed the
    ++		 * deflated buffer's size via `deflateBound()` this function is
    ++		 * guaranteed to succeed according to the zlib documentation.
     +		 */
     +		ret =3D deflate(w->zstream, Z_FINISH);
     +		if (ret !=3D Z_STREAM_END) {
    @@ reftable/block.h: license that can be found in the LICENSE file or at
      	uint8_t *buf;
      	uint32_t block_size;
     =20
    -
    - ## reftable/writer.c ##
    -@@ reftable/writer.c: void reftable_writer_free(struct reftable_writer=
 *w)
    - {
    - 	if (!w)
    - 		return;
    -+	if (w->block_writer) {
    -+		block_writer_release(w->block_writer);
    -+		w->block_writer =3D NULL;
    -+	}
    - 	reftable_free(w->block);
    - 	reftable_free(w);
    - }
 8:  9899b58dcf ! 11:  4f9df714da reftable/block: reuse compressed array
    @@ reftable/block.c: int block_writer_finish(struct block_writer *w)
      		w->zstream->next_in =3D w->buf + block_header_skip;
      		w->zstream->avail_in =3D src_len;
     @@ reftable/block.c: int block_writer_finish(struct block_writer *w)
    - 		 * buffer.
    + 		 * guaranteed to succeed according to the zlib documentation.
      		 */
      		ret =3D deflate(w->zstream, Z_FINISH);
     -		if (ret !=3D Z_STREAM_END) {
--=20
2.44.GIT


--E84FwixQ4q4VCwnO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOPxQACgkQVbJhu7ck
PpTRSA/+KjnnnR+7sTNenKeduE7Ps1/yp7X+FuaVe9/BgjHWozoPDe2dfDOp3OJU
dWMtetksFxlBkMqHb+2kvAeejLTjJhwpRfjvqo9xC4HTwK0Xrb8GrunSu/5+y+KU
u0Tkbh3shaW+iUZlGO2/tBzVzNLPzkD6mcP9kx0XWZvfsqIhUb95pb+NFxNnkFOq
7YX4AY/RQtgG4nN/L4wcZoIFjnDLnz9OyqnKg9fFiuW62yvExpxyzszcRiNVs2D7
3s8ozTSRGWNOToJC0wd1Z0Vz7wsqn7zAtCqJ9/3jYduKwfEIxdalbwgLnzO6CAta
DDr/hsw/CDi1+rD3oOnBZlzez3X+sxv50IrMJqJBtPpHlEi8ppHLeoeXCHGeAr1H
VK0r9DfzvV033sCIiP2yAhnYAUl3KJ1V8NTBPWbtdbYJNa8wivqFsp3zHlfa6uYg
0e80pyqPwrD9mou1zFoQwODD+NspiZazE9r/p/KQLoM3pi5yvfjpQ7qaW1QynulR
xqCx8LbWDYOIt2LdafzDxzbr9MZJnZcxBgP49gKVS/jFTiyKdfHVOINyAsJ+Pkek
hRzV2NKkHvPr8ITRUWB6KcvoLGsmC7mDavTPjb0pgtOfW99ZFATXkXY8YVwR0Eq7
HyDgck0msbTwDKl8SiKT+7t7tUpFFfQxeC7EGUu59z4xwYQSe4Y=
=Shau
-----END PGP SIGNATURE-----

--E84FwixQ4q4VCwnO--
