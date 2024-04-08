Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B82D057
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579035; cv=none; b=q3DPLKZdDbS/SoKN6prxXAYMzRjQD7lLTf1//oVrUX+9tiSMeV/FnvdJ4pjqN78ohPq7pG2wk89zu22t8L3SfI9FrzWkga067fMCkHMUyxDlyaE/3dteDWyRK1fIfjuTtitn8nE7oNLqa6lbQgAxrZJZK3C10lUQemHomQvzL8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579035; c=relaxed/simple;
	bh=RU6az3oGjnq05sIv9iA5Ugh6nQcAkzzeIZhUFrvX6T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hr835fRWbcCCk5j+OkMt4SAeReZd5x+y0i/2orqpdr/2iMZqDdd+A3XQglRCFwxeEeMwl/UJQo30a4znRvxcWMyIWJ/2w3+7YR1eMSzPoDWJgp8SXP9MxWauSopMmCxL8EtuEmxoztFVexEZ7ljvN6y6ZL3jOM4kbUWeFbhepCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Uf4onUut; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BLB+53A0; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Uf4onUut";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BLB+53A0"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CD19C11400D6;
	Mon,  8 Apr 2024 08:23:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 08 Apr 2024 08:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712579032; x=1712665432; bh=3lRd/wOlwc
	bzSV23ZlYltmNFYy7Ip7CzaiRjQKDQx8k=; b=Uf4onUutiwNyUFnAjXCwf6dod7
	W9bxBnUebpmYKMEdFAmWcf37+W6C7JooN+/dpuwpa5uITAQJxUR9/BLknZanlfRw
	coPculsqyXgodngiy2L4R/EuyE+DGoq6KZZ+6FjcRtlMsSQRJHADiR9FHdycbLVM
	RoL7IHD3t11lgtlztDq3zfI0UVqhPQw/3cyzbzUni3NPBpi1v9WWSrNg6R0wR+b5
	b6jpymV4Z41agUV1bO6XW3quIebEJM2FBzWdKqFlAMzChWift28+15siJWUfBw6X
	kDORtmldfB6nMGJJ+ZzEEYgwjKfXtulNeePcJpe/krMhcA+6cfTf+aadJgtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712579032; x=1712665432; bh=3lRd/wOlwcbzSV23ZlYltmNFYy7I
	p7CzaiRjQKDQx8k=; b=BLB+53A09ZWfgGkYmcUUvWmyCPob25jgZckw22LwONVP
	1ZUU/RPiDX9CzkPmBFnjr28VCeklVZeo50dPDLkBv/NZFTKQiD4xTIhO3NZmNX3J
	oDpxRL/oHEJZpVLEzH9HPGgokbFUPtPLoYLiadz61LRqafCJS8dDqYO2k7w81sQJ
	QjfZsTD97A4iU5ddeSUK7uByQmEWGz+6UgW/K2SyaiCBMcw+abM//xJq/HDnquZl
	AIu++aJJJRgnetJ1tWORkWhMiQFlxZXmieiCLGJvn2cnrnNYi9th8r3GfLXB8Hdy
	5OPocBRHo4vX1JI5B0/bb/TM8q10mo+YYdQdN4RPew==
X-ME-Sender: <xms:2OETZhJxfAj4Lgz5-HqwIN7U194Rmhk6EPoWTjZeyehkWUM8UHjvLw>
    <xme:2OETZtJsIIsdxz04vwKE4MsVTcEhlRSzC5CjzP-s_j7c2Iznq9vBkY42VH5AQAew1
    sIia-rAzLz-E2gpiQ>
X-ME-Received: <xmr:2OETZptZi8PxzOI6RJSaB75cZywHaNsAIugDM5Fg1_v8c9WG3BxhBjBA9CUhVYcTwosenitM4QuSQ_oR3iaESC-J8sl8rD18aFKyH4ZH3YbvxmqUTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:2OETZibVnb7wOt6BsDWSM0GW3PId0fAs3Dqj2jMCTDA95H7SXfIa1w>
    <xmx:2OETZoap_6WSlSWTLU3-tup8C8vgvuAe4sfEhHOOGUWUzRYWacS94g>
    <xmx:2OETZmAumFw3IGHR27ejJF2hGbHeGIMsg6CuV3X6D3t6Wq8m1CY0BA>
    <xmx:2OETZmaQk5lBDPI6pLdpLKoVa7rajjS0a1gEuCDgjLGm29NaxXAMIQ>
    <xmx:2OETZgEA9K2HXmfmM0EJC7aX3haNaSvX4Ts3Mquns-Fa13woYbH-88RU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:23:51 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d8b2f583 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:23:43 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:23:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v3 00/11] reftable: optimize write performance
Message-ID: <cover.1712578837.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zjhon+F/s4R2Qwic"
Content-Disposition: inline
In-Reply-To: <cover.1712078736.git.ps@pks.im>


--Zjhon+F/s4R2Qwic
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the first version of my patch series that aims to optimize write
performance with the reftable backend.

Changes compared to v2:

    - The series now deepends on ps/reftable-binsearch-update at
      d51d8cc368 (reftable/block: avoid decoding keys when searching
      restart points, 2024-04-03). This is to resolve a merge conflict
      with that other series which has landed in "next" already.

    - Dropped the "reftable_" prefix from newly introduced internal
      reftable functions.

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
 refs/reftable-backend.c    |  75 ++++++++++----
 reftable/block.c           |  80 ++++++++------
 reftable/block.h           |   4 +
 reftable/error.c           |   2 -
 reftable/refname.c         | 206 -------------------------------------
 reftable/refname.h         |  29 ------
 reftable/refname_test.c    | 101 ------------------
 reftable/reftable-error.h  |   3 -
 reftable/reftable-tests.h  |   1 -
 reftable/reftable-writer.h |   4 -
 reftable/stack.c           |  67 +-----------
 reftable/stack_test.c      |  39 -------
 reftable/writer.c          | 137 +++++++++++++++---------
 t/helper/test-reftable.c   |   1 -
 t/t0610-reftable-basics.sh |  35 ++++++-
 16 files changed, 230 insertions(+), 556 deletions(-)
 delete mode 100644 reftable/refname.c
 delete mode 100644 reftable/refname.h
 delete mode 100644 reftable/refname_test.c

Range-diff against v2:
 1:  926e802395 =3D  1:  bb735c389a refs/reftable: fix D/F conflict error m=
essage on ref copy
 2:  6190171906 =3D  2:  fe3f00d85a refs/reftable: perform explicit D/F che=
ck when writing symrefs
 3:  80008cc5e7 =3D  3:  763c6fdfcd refs/reftable: skip duplicate name chec=
ks
 4:  3497a570b4 !  4:  2a5f07627a reftable: remove name checks
    @@ reftable/refname.c (deleted)
     -#include "refname.h"
     -#include "reftable-iterator.h"
     -
    --struct find_arg {
    --	char **names;
    --	const char *want;
    +-struct refname_needle_lesseq_args {
    +-	char **haystack;
    +-	const char *needle;
     -};
     -
    --static int find_name(size_t k, void *arg)
    +-static int refname_needle_lesseq(size_t k, void *_args)
     -{
    --	struct find_arg *f_arg =3D arg;
    --	return strcmp(f_arg->names[k], f_arg->want) >=3D 0;
    +-	struct refname_needle_lesseq_args *args =3D _args;
    +-	return strcmp(args->needle, args->haystack[k]) <=3D 0;
     -}
     -
     -static int modification_has_ref(struct modification *mod, const char =
*name)
    @@ reftable/refname.c (deleted)
     -	int err =3D 0;
     -
     -	if (mod->add_len > 0) {
    --		struct find_arg arg =3D {
    --			.names =3D mod->add,
    --			.want =3D name,
    +-		struct refname_needle_lesseq_args args =3D {
    +-			.haystack =3D mod->add,
    +-			.needle =3D name,
     -		};
    --		int idx =3D binsearch(mod->add_len, find_name, &arg);
    --		if (idx < mod->add_len && !strcmp(mod->add[idx], name)) {
    +-		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &args=
);
    +-		if (idx < mod->add_len && !strcmp(mod->add[idx], name))
     -			return 0;
    --		}
     -	}
     -
     -	if (mod->del_len > 0) {
    --		struct find_arg arg =3D {
    --			.names =3D mod->del,
    --			.want =3D name,
    +-		struct refname_needle_lesseq_args args =3D {
    +-			.haystack =3D mod->del,
    +-			.needle =3D name,
     -		};
    --		int idx =3D binsearch(mod->del_len, find_name, &arg);
    --		if (idx < mod->del_len && !strcmp(mod->del[idx], name)) {
    +-		size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &args=
);
    +-		if (idx < mod->del_len && !strcmp(mod->del[idx], name))
     -			return 1;
    --		}
     -	}
     -
     -	err =3D reftable_table_read_ref(&mod->tab, name, &ref);
    @@ reftable/refname.c (deleted)
     -	int err =3D 0;
     -
     -	if (mod->add_len > 0) {
    --		struct find_arg arg =3D {
    --			.names =3D mod->add,
    --			.want =3D prefix,
    +-		struct refname_needle_lesseq_args args =3D {
    +-			.haystack =3D mod->add,
    +-			.needle =3D prefix,
     -		};
    --		int idx =3D binsearch(mod->add_len, find_name, &arg);
    +-		size_t idx =3D binsearch(mod->add_len, refname_needle_lesseq, &args=
);
     -		if (idx < mod->add_len &&
     -		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
     -			goto done;
    @@ reftable/refname.c (deleted)
     -			goto done;
     -
     -		if (mod->del_len > 0) {
    --			struct find_arg arg =3D {
    --				.names =3D mod->del,
    --				.want =3D ref.refname,
    +-			struct refname_needle_lesseq_args args =3D {
    +-				.haystack =3D mod->del,
    +-				.needle =3D ref.refname,
     -			};
    --			int idx =3D binsearch(mod->del_len, find_name, &arg);
    +-			size_t idx =3D binsearch(mod->del_len, refname_needle_lesseq, &arg=
s);
     -			if (idx < mod->del_len &&
    --			    !strcmp(ref.refname, mod->del[idx])) {
    +-			    !strcmp(ref.refname, mod->del[idx]))
     -				continue;
    --			}
     -		}
     -
     -		if (strncmp(ref.refname, prefix, strlen(prefix))) {
 5:  f892a3007b =3D  5:  1ca7d9b6cf refs/reftable: don't recompute committe=
r ident
 6:  4877ab3921 =3D  6:  deabf82186 reftable/writer: refactorings for `writ=
er_add_record()`
 7:  8f1c5b4169 =3D  7:  d47ad49d49 reftable/writer: refactorings for `writ=
er_flush_nonempty_block()`
 8:  41db7414e1 !  8:  76d4a1f73b reftable/writer: unify releasing memory
    @@ reftable/writer.c: void reftable_writer_set_limits(struct reftable_w=
riter *w, ui
      	w->max_update_index =3D max;
      }
     =20
    -+static void reftable_writer_release(struct reftable_writer *w)
    ++static void writer_release(struct reftable_writer *w)
     +{
     +	if (w) {
     +		reftable_free(w->block);
    @@ reftable/writer.c: void reftable_writer_set_limits(struct reftable_w=
riter *w, ui
     -	if (!w)
     -		return;
     -	reftable_free(w->block);
    -+	reftable_writer_release(w);
    ++	writer_release(w);
      	reftable_free(w);
      }
     =20
    @@ reftable/writer.c: int reftable_writer_close(struct reftable_writer =
*w)
     -	block_writer_release(&w->block_writer_data);
     -	writer_clear_index(w);
     -	strbuf_release(&w->last_key);
    -+	reftable_writer_release(w);
    ++	writer_release(w);
      	return err;
      }
     =20
 9:  e5c7dbe417 =3D  9:  722ab0ee28 reftable/writer: reset `last_key` inste=
ad of releasing it
10:  26f422703f =3D 10:  962a96003b reftable/block: reuse zstream when writ=
ing log blocks
11:  4f9df714da =3D 11:  323892841a reftable/block: reuse compressed array

base-commit: 7774cfed6261ce2900c84e55906da708c711d601
--=20
2.44.GIT


--Zjhon+F/s4R2Qwic
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4dIACgkQVbJhu7ck
PpRnlg/+OJ5zMwVx0y/JVs8Pt7gcdF9cJ2OXsUAlZW1rX5QxzSLGcsrw6ADUGllr
5harU4djQwCneyb25g/mbJhvhajs3jANaa+DzK+NHaIH7clVin7EVpmeRxPy1ZFL
HgQGcJqwjTS/X1tYUwLdOMfU9GD1yqGMBJ9q3CNYYP2Far5Y1WYLUf0paR/MwT4R
6BOanvNc2XTfYnymm9SGI3Kg184XkwYj9tm9VyOo4bdlm96Tr4NtkIVHlRkhK7R0
yrsue3cNaTuabtjzSgzKUMLWk9xpeKiXiteSbV+8QtBBOAoFuKO5fOn2TFwQicn0
PmHPDYhUQreYwVTPbBLKA3In+BgoybIOUBLcSvRaM3QT8Dw92SvnTy5cdiWQCdYV
zVBKZW4EXJs04AROZ1+GUgxjomPggQfxRqNOjhE5LwE2anK0mIl3bHxwp1va/fQJ
VcrDsvCMhrflbGG4RZ1zXbHX8rcIdeDpM3Q969eSZtFAZogkxxf7m30QqhpZChRR
STNS04ixKxeNOYpejhxMUBZ1Vd+6FUMB5YYOKEJFwxJ28e8kf3qZxWdH2C3rAZbI
mXSvAjqv/t3WxhC/zX6vc8+UQzXM6skrVm10xVNgZsNhOnjQoLY7n7YXRZukSQV5
nFIKxJPRRDUCoem8XdpyZhgheLBBSE/Wh1+HTpYcS0+67gYkF9c=
=Nx1Q
-----END PGP SIGNATURE-----

--Zjhon+F/s4R2Qwic--
