Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612F7146D5C
	for <git@vger.kernel.org>; Mon, 13 May 2024 08:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715588279; cv=none; b=WcTaZIGMqO+wO0x71bNwApdFk08KIoWr4FsZlECJjlpCIa8Qx4TplXWLubApEZLhj3uUuXYSX4ZnR8qm3pbuGHmMwWwGDJwwU3yzPJweEtsNKb8t6sdrDFZK4YhrT7lW1RZ5jLeYsi4vF09ZvoBxHwUh3M8/1mSgAUM40xc3eEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715588279; c=relaxed/simple;
	bh=j+aEEX0U83IvxTDdxBm7/xc4AXfh9PLOC2WF1CNtj0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HsfjFHGvR2O5VUVmrmdAvXYOL/vWbncOObqH9X9EVHla7JU6xoLzf4PY3PTWmeGXUWQbonKvA5mmR1zo++iWiOU/XgGOVIXdiQE5QeoxsqiQeDU2pke5Pf/rxh2f3spEm/SC3F2370q9cEuCVXu6CBXMv4Fr4WWcKd+FEeo4464=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nb/6ixM6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GOEenmMR; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nb/6ixM6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GOEenmMR"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 6D9441800124;
	Mon, 13 May 2024 04:17:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 13 May 2024 04:17:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715588275; x=1715674675; bh=rrka1eF67T
	GOY+2IVCDZjAFdmjXtgqIRs+qjuNGYCxk=; b=nb/6ixM6ceaty3J9Fja4q7/77f
	LxfTXnNMIag8q9tNhKW4NZC6o829dTS++gu3O0TMKVyZwcydJvFW9m7fnW1Zec3X
	SzpMv8xuKesyh3yQi6FdoQ9tg2ngDBAdaslNnwopZtxhMEFZ8Al20ZI5g6o+1Szu
	jQcnDIJxDXVzJ4z5uY8UQrDU9Rr1Yrdf6Fxc9d7D2Tw3AZWvUg4ALkVhumZZQNgP
	7YhP+LoDzsvf3jsx0Edyl7u08ey7KNH7FDro0BErADYrJAEi99qRcojRmaaeZMAN
	gnURCR0qESYphryN8ZP30sOzP3bCCJeMy/UtsQnlyKDLyEk/YtXay7c1ie9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715588275; x=1715674675; bh=rrka1eF67TGOY+2IVCDZjAFdmjXt
	gqIRs+qjuNGYCxk=; b=GOEenmMRKfs0CYSaWt8am6Z/aj7EdL0aAY+Mq6ZCWWPo
	F62nVLtGHXuuyVgmDlTw42p+Vz3baWoT4KLtcKAAG2BhFmCHVhdxPbe2uXjAe9+o
	ykVd35LxLVOHzAT3tkLNGHjnhSvPU06lT7jpzBtymOcVlufhDTuF3C5L+k59wyG0
	bEIvGiwZue+z58i56e55YYkPiyHDy8mxJMwnQPGDmlTcr8sSLTeTJv9XQ0xiE1P8
	VROAWAsyTkCY7tXRfravRMbqlH3gIDPvaDgSMk+1Z/1Xiep22wiS9fSlPginrhyM
	eJvUzZf/7ApmD44aLENtALHF4hkpb4Kbw/dwx0yN2g==
X-ME-Sender: <xms:ssxBZiulmbQGFvjouGoz0u8CKWg112Jnrj8vTzw06w94yLDEvJfEzg>
    <xme:ssxBZncRasXTW5rqrMlKbrmOzoiU67PvCf7GIA7gD69UZ5TZ3O7Zg-mAy-daMpyyw
    hUtvVNNGZ5WfZH9SA>
X-ME-Received: <xmr:ssxBZtyx7pyIhpAtPNmFHuZGlu0Eu69-2oX7QESJaTafP-mXyPIkNImx6LZyk3L7e80qpD_4HGQu0X2C1PiOx8el0UKQ7TH8MKqcRccKIE1cM-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeggedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ssxBZtPOIEnxN_4PEk0322yDiLE0SJJJX-iQEfU-IokWn8JB_iD6ng>
    <xmx:ssxBZi9mkX2XBnslsq1CjA0tJUie7knm4WM4ll_qax6KJQaRibax3g>
    <xmx:ssxBZlVY8Y59DqFiahCcrGlbktwd-5J2w9_4BqDBKVjR9HXxecwoIQ>
    <xmx:ssxBZreLGEmynI5cBxWDKAm7xezPLe6DfQRD83phVPwiZhnMpR5K5w>
    <xmx:s8xBZmY6Vdp3hFMUuS5b4xf1fXNfjUslGTYVh_ku_cSMupJ93naNtaDz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 May 2024 04:17:53 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a6f05667 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 May 2024 08:17:33 +0000 (UTC)
Date: Mon, 13 May 2024 10:17:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 00/11] reftable: expose write options as config
Message-ID: <cover.1715587849.git.ps@pks.im>
References: <cover.1714630191.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Qk9da2qAGlsKFjJw"
Content-Disposition: inline
In-Reply-To: <cover.1714630191.git.ps@pks.im>


--Qk9da2qAGlsKFjJw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the third version of my patch series that exposes several write
options of the reftable library via Git configs.

Changes compared to v2:

  - Adapted patch 2 such that we now pass options as const pointers
    instead of by value.

  - Removed a confusing sentence in the documentation of the restart
    points in patch 8.

Other than that I decided to rebase this on top of the current "master"
branch at 0f3415f1f8 (The second batch, 2024-05-08). This is because the
revamped patch 2 would cause new conflicts with 485c63cf5c (reftable:
remove name checks, 2024-04-08) that didn't exist in v2 of this patch
series yet. Rebasing thus seemed like the more reasonable option.

Patrick

Patrick Steinhardt (11):
  reftable: consistently refer to `reftable_write_options` as `opts`
  reftable: pass opts as constant pointer
  reftable/writer: drop static variable used to initialize strbuf
  reftable/writer: improve error when passed an invalid block size
  reftable/dump: support dumping a table's block structure
  refs/reftable: allow configuring block size
  reftable: use `uint16_t` to track restart interval
  refs/reftable: allow configuring restart interval
  refs/reftable: allow disabling writing the object index
  reftable: make the compaction factor configurable
  refs/reftable: allow configuring geometric factor

 Documentation/config.txt          |   2 +
 Documentation/config/reftable.txt |  48 +++++
 refs/reftable-backend.c           |  49 ++++-
 reftable/block.h                  |   2 +-
 reftable/constants.h              |   1 +
 reftable/dump.c                   |  12 +-
 reftable/reader.c                 |  63 +++++++
 reftable/reftable-reader.h        |   2 +
 reftable/reftable-stack.h         |   2 +-
 reftable/reftable-writer.h        |  10 +-
 reftable/stack.c                  |  58 +++---
 reftable/stack.h                  |   5 +-
 reftable/stack_test.c             | 118 ++++++------
 reftable/writer.c                 |  23 +--
 t/t0613-reftable-write-options.sh | 286 ++++++++++++++++++++++++++++++
 15 files changed, 566 insertions(+), 115 deletions(-)
 create mode 100644 Documentation/config/reftable.txt
 create mode 100755 t/t0613-reftable-write-options.sh

Range-diff against v2:
 1:  7efa566306 !  1:  71f4e31cf7 reftable: consistently refer to `reftable=
_write_options` as `opts`
    @@ reftable/stack.c: static uint64_t *stack_table_sizes_for_compaction(=
struct refta
      	int overhead =3D header_size(version) - 1;
      	int i =3D 0;
      	for (i =3D 0; i < st->merged->stack_len; i++) {
    -@@ reftable/stack.c: static int stack_check_addition(struct reftable_s=
tack *st,
    - 	int len =3D 0;
    - 	int i =3D 0;
    -=20
    --	if (st->config.skip_name_check)
    -+	if (st->opts.skip_name_check)
    - 		return 0;
    -=20
    - 	err =3D reftable_block_source_from_file(&src, new_tab_name);
     @@ reftable/stack.c: int reftable_stack_clean(struct reftable_stack *s=
t)
      int reftable_stack_print_directory(const char *stackdir, uint32_t has=
h_id)
      {
 2:  e6f8fc09c2 !  2:  f1c9914a77 reftable: consistently pass write opts as=
 value
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
    =20
      ## Commit message ##
    -    reftable: consistently pass write opts as value
    +    reftable: pass opts as constant pointer
    =20
         We sometimes pass the refatble write options as value and sometime=
s as a
         pointer. This is quite confusing and makes the reader wonder wheth=
er the
    @@ Commit message
         to get updated when some values aren't set up. This is quite unexp=
ected,
         but didn't cause any harm until now.
    =20
    -    Refactor the code to consistently pass the options as a value so t=
hat
    -    they are local to the subsystem they are being passed into so that=
 we
    -    can avoid weirdness like this.
    +    Adapt the code so that we do not modify the caller-provided values
    +    anymore. While at it, refactor the code to code to consistently pa=
ss the
    +    options as a constant pointer to clarify that the caller-provided =
opts
    +    will not ever get modified.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    - ## reftable/merged_test.c ##
    -@@ reftable/merged_test.c: static void write_test_table(struct strbuf =
*buf,
    + ## refs/reftable-backend.c ##
    +@@ refs/reftable-backend.c: static struct reftable_stack *stack_for(st=
ruct reftable_ref_store *store,
    + 				    store->base.repo->commondir, wtname_buf.buf);
    +=20
    + 			store->err =3D reftable_new_stack(&stack, wt_dir.buf,
    +-							store->write_options);
    ++							&store->write_options);
    + 			assert(store->err !=3D REFTABLE_API_ERROR);
    + 			strmap_put(&store->worktree_stacks, wtname_buf.buf, stack);
      		}
    +@@ refs/reftable-backend.c: static struct ref_store *reftable_be_init(=
struct repository *repo,
      	}
    + 	strbuf_addstr(&path, "/reftable");
    + 	refs->err =3D reftable_new_stack(&refs->main_stack, path.buf,
    +-				       refs->write_options);
    ++				       &refs->write_options);
    + 	if (refs->err)
    + 		goto done;
     =20
    --	w =3D reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
    -+	w =3D reftable_new_writer(&strbuf_add_void, &noop_flush, buf, opts);
    - 	reftable_writer_set_limits(w, min, max);
    -=20
    - 	for (i =3D 0; i < n; i++) {
    -@@ reftable/merged_test.c: static void write_test_log_table(struct str=
buf *buf,
    - 		.exact_log_message =3D 1,
    - 	};
    - 	struct reftable_writer *w =3D NULL;
    --	w =3D reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
    -+	w =3D reftable_new_writer(&strbuf_add_void, &noop_flush, buf, opts);
    - 	reftable_writer_set_limits(w, update_index, update_index);
    -=20
    - 	for (i =3D 0; i < n; i++) {
    -@@ reftable/merged_test.c: static void test_default_write_opts(void)
    - 	struct reftable_write_options opts =3D { 0 };
    - 	struct strbuf buf =3D STRBUF_INIT;
    - 	struct reftable_writer *w =3D
    --		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    -+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
    +@@ refs/reftable-backend.c: static struct ref_store *reftable_be_init(=
struct repository *repo,
    + 		strbuf_addf(&path, "%s/reftable", gitdir);
     =20
    - 	struct reftable_ref_record rec =3D {
    - 		.refname =3D "master",
    + 		refs->err =3D reftable_new_stack(&refs->worktree_stack, path.buf,
    +-					       refs->write_options);
    ++					       &refs->write_options);
    + 		if (refs->err)
    + 			goto done;
    + 	}
    =20
    - ## reftable/readwrite_test.c ##
    -@@ reftable/readwrite_test.c: static void write_table(char ***names, s=
truct strbuf *buf, int N,
    - 		.hash_id =3D hash_id,
    - 	};
    - 	struct reftable_writer *w =3D
    --		reftable_new_writer(&strbuf_add_void, &noop_flush, buf, &opts);
    -+		reftable_new_writer(&strbuf_add_void, &noop_flush, buf, opts);
    - 	struct reftable_ref_record ref =3D { NULL };
    - 	int i =3D 0, n;
    - 	struct reftable_log_record log =3D { NULL };
    -@@ reftable/readwrite_test.c: static void test_log_buffer_size(void)
    - 					   .message =3D "commit: 9\n",
    - 				   } } };
    - 	struct reftable_writer *w =3D
    --		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    -+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
    -=20
    - 	/* This tests buffer extension for log compression. Must use a random
    - 	   hash, to ensure that the compressed part is larger than the origi=
nal.
    -@@ reftable/readwrite_test.c: static void test_log_overflow(void)
    - 		},
    - 	};
    - 	struct reftable_writer *w =3D
    --		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    -+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
    -=20
    - 	memset(msg, 'x', sizeof(msg) - 1);
    - 	reftable_writer_set_limits(w, update_index, update_index);
    -@@ reftable/readwrite_test.c: static void test_log_write_read(void)
    - 	struct reftable_block_source source =3D { NULL };
    - 	struct strbuf buf =3D STRBUF_INIT;
    - 	struct reftable_writer *w =3D
    --		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    -+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
    - 	const struct reftable_stats *stats =3D NULL;
    - 	reftable_writer_set_limits(w, 0, N);
    - 	for (i =3D 0; i < N; i++) {
    -@@ reftable/readwrite_test.c: static void test_log_zlib_corruption(voi=
d)
    - 	struct reftable_block_source source =3D { 0 };
    - 	struct strbuf buf =3D STRBUF_INIT;
    - 	struct reftable_writer *w =3D
    --		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    -+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
    - 	const struct reftable_stats *stats =3D NULL;
    - 	char message[100] =3D { 0 };
    - 	int err, i, n;
    -@@ reftable/readwrite_test.c: static void test_table_refs_for(int inde=
xed)
    -=20
    - 	struct strbuf buf =3D STRBUF_INIT;
    - 	struct reftable_writer *w =3D
    --		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    -+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
    -=20
    - 	struct reftable_iterator it =3D { NULL };
    - 	int j;
    -@@ reftable/readwrite_test.c: static void test_write_empty_table(void)
    + ## reftable/dump.c ##
    +@@ reftable/dump.c: static int compact_stack(const char *stackdir)
    + 	struct reftable_stack *stack =3D NULL;
      	struct reftable_write_options opts =3D { 0 };
    - 	struct strbuf buf =3D STRBUF_INIT;
    - 	struct reftable_writer *w =3D
    --		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    -+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
    - 	struct reftable_block_source source =3D { NULL };
    - 	struct reftable_reader *rd =3D NULL;
    - 	struct reftable_ref_record rec =3D { NULL };
    -@@ reftable/readwrite_test.c: static void test_write_object_id_min_len=
gth(void)
    - 	};
    - 	struct strbuf buf =3D STRBUF_INIT;
    - 	struct reftable_writer *w =3D
    --		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    -+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
    - 	struct reftable_ref_record ref =3D {
    - 		.update_index =3D 1,
    - 		.value_type =3D REFTABLE_REF_VAL1,
    -@@ reftable/readwrite_test.c: static void test_write_object_id_length(=
void)
    - 	};
    - 	struct strbuf buf =3D STRBUF_INIT;
    - 	struct reftable_writer *w =3D
    --		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    -+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
    - 	struct reftable_ref_record ref =3D {
    - 		.update_index =3D 1,
    - 		.value_type =3D REFTABLE_REF_VAL1,
    -@@ reftable/readwrite_test.c: static void test_write_empty_key(void)
    - 	struct reftable_write_options opts =3D { 0 };
    - 	struct strbuf buf =3D STRBUF_INIT;
    - 	struct reftable_writer *w =3D
    --		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    -+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
    - 	struct reftable_ref_record ref =3D {
    - 		.refname =3D "",
    - 		.update_index =3D 1,
    -@@ reftable/readwrite_test.c: static void test_write_key_order(void)
    - 	struct reftable_write_options opts =3D { 0 };
    - 	struct strbuf buf =3D STRBUF_INIT;
    - 	struct reftable_writer *w =3D
    --		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    -+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
    - 	struct reftable_ref_record refs[2] =3D {
    - 		{
    - 			.refname =3D "b",
    -@@ reftable/readwrite_test.c: static void test_write_multiple_indices(=
void)
    - 	struct reftable_reader *reader;
    - 	int err, i;
     =20
    --	writer =3D reftable_new_writer(&strbuf_add_void, &noop_flush, &write=
r_buf, &opts);
    -+	writer =3D reftable_new_writer(&strbuf_add_void, &noop_flush, &write=
r_buf, opts);
    - 	reftable_writer_set_limits(writer, 1, 1);
    - 	for (i =3D 0; i < 100; i++) {
    - 		struct reftable_ref_record ref =3D {
    -@@ reftable/readwrite_test.c: static void test_write_multi_level_index=
(void)
    - 	struct reftable_reader *reader;
    - 	int err;
    +-	int err =3D reftable_new_stack(&stack, stackdir, opts);
    ++	int err =3D reftable_new_stack(&stack, stackdir, &opts);
    + 	if (err < 0)
    + 		goto done;
     =20
    --	writer =3D reftable_new_writer(&strbuf_add_void, &noop_flush, &write=
r_buf, &opts);
    -+	writer =3D reftable_new_writer(&strbuf_add_void, &noop_flush, &write=
r_buf, opts);
    - 	reftable_writer_set_limits(writer, 1, 1);
    - 	for (size_t i =3D 0; i < 200; i++) {
    - 		struct reftable_ref_record ref =3D {
    =20
    - ## reftable/refname_test.c ##
    -@@ reftable/refname_test.c: static void test_conflict(void)
    - 	struct reftable_write_options opts =3D { 0 };
    - 	struct strbuf buf =3D STRBUF_INIT;
    - 	struct reftable_writer *w =3D
    --		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, &opts);
    -+		reftable_new_writer(&strbuf_add_void, &noop_flush, &buf, opts);
    - 	struct reftable_ref_record rec =3D {
    - 		.refname =3D "a/b",
    - 		.value_type =3D REFTABLE_REF_SYMREF,
    + ## reftable/reftable-stack.h ##
    +@@ reftable/reftable-stack.h: struct reftable_stack;
    +  *  stored in 'dir'. Typically, this should be .git/reftables.
    +  */
    + int reftable_new_stack(struct reftable_stack **dest, const char *dir,
    +-		       struct reftable_write_options opts);
    ++		       const struct reftable_write_options *opts);
    +=20
    + /* returns the update_index at which a next table should be written. =
*/
    + uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
    =20
      ## reftable/reftable-writer.h ##
     @@ reftable/reftable-writer.h: struct reftable_stats {
    @@ reftable/reftable-writer.h: struct reftable_stats {
      reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size=
_t),
      		    int (*flush_func)(void *),
     -		    void *writer_arg, struct reftable_write_options *opts);
    -+		    void *writer_arg, struct reftable_write_options opts);
    ++		    void *writer_arg, const struct reftable_write_options *opts);
     =20
      /* Set the range of update indices for the records we will add. When =
writing a
         table into a stack, the min should be at least
    =20
      ## reftable/stack.c ##
    -@@ reftable/stack.c: int reftable_addition_add(struct reftable_additio=
n *add,
    - 	tab_fd =3D get_tempfile_fd(tab_file);
    +@@ reftable/stack.c: static int reftable_fd_flush(void *arg)
    + }
    +=20
    + int reftable_new_stack(struct reftable_stack **dest, const char *dir,
    +-		       struct reftable_write_options opts)
    ++		       const struct reftable_write_options *_opts)
    + {
    + 	struct reftable_stack *p =3D reftable_calloc(1, sizeof(*p));
    + 	struct strbuf list_file_name =3D STRBUF_INIT;
    ++	struct reftable_write_options opts =3D {0};
    + 	int err =3D 0;
     =20
    - 	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush, &ta=
b_fd,
    --				 &add->stack->opts);
    -+				 add->stack->opts);
    - 	err =3D write_table(wr, arg);
    ++	if (_opts)
    ++		opts =3D *_opts;
    + 	if (opts.hash_id =3D=3D 0)
    + 		opts.hash_id =3D GIT_SHA1_FORMAT_ID;
    +=20
    +@@ reftable/stack.c: int reftable_stack_print_directory(const char *st=
ackdir, uint32_t hash_id)
    + 	struct reftable_merged_table *merged =3D NULL;
    + 	struct reftable_table table =3D { NULL };
    +=20
    +-	int err =3D reftable_new_stack(&stack, stackdir, opts);
    ++	int err =3D reftable_new_stack(&stack, stackdir, &opts);
      	if (err < 0)
      		goto done;
    -@@ reftable/stack.c: static int stack_compact_locked(struct reftable_s=
tack *st,
    +=20
    +
    + ## reftable/stack_test.c ##
    +@@ reftable/stack_test.c: static void test_reftable_stack_add_one(void)
    + 	};
    + 	struct reftable_ref_record dest =3D { NULL };
    + 	struct stat stat_result =3D { 0 };
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	err =3D reftable_stack_add(st, &write_test_ref, &ref);
    +@@ reftable/stack_test.c: static void test_reftable_stack_uptodate(voi=
d)
    + 	/* simulate multi-process access to the same stack
    + 	   by creating two stacks for the same directory.
    + 	 */
    +-	err =3D reftable_new_stack(&st1, dir, opts);
    ++	err =3D reftable_new_stack(&st1, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    +-	err =3D reftable_new_stack(&st2, dir, opts);
    ++	err =3D reftable_new_stack(&st2, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	err =3D reftable_stack_add(st1, &write_test_ref, &ref1);
    +@@ reftable/stack_test.c: static void test_reftable_stack_transaction_=
api(void)
    + 	};
    + 	struct reftable_ref_record dest =3D { NULL };
    +=20
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	reftable_addition_destroy(add);
    +@@ reftable/stack_test.c: static void test_reftable_stack_transaction_=
api_performs_auto_compaction(void)
    + 	struct reftable_stack *st =3D NULL;
    + 	int i, n =3D 20, err;
    +=20
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	for (i =3D 0; i <=3D n; i++) {
    +@@ reftable/stack_test.c: static void test_reftable_stack_auto_compact=
ion_fails_gracefully(void)
    + 	char *dir =3D get_tmp_dir(__LINE__);
    + 	int err;
    +=20
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	err =3D reftable_stack_add(st, write_test_ref, &ref);
    +@@ reftable/stack_test.c: static void test_reftable_stack_update_index=
_check(void)
    + 		.value.symref =3D "master",
    + 	};
    +=20
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	err =3D reftable_stack_add(st, &write_test_ref, &ref1);
    +@@ reftable/stack_test.c: static void test_reftable_stack_lock_failure=
(void)
    + 	struct reftable_stack *st =3D NULL;
    + 	int err, i;
    +=20
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    + 	for (i =3D -1; i !=3D REFTABLE_EMPTY_TABLE_ERROR; i--) {
    + 		err =3D reftable_stack_add(st, &write_error, &i);
    +@@ reftable/stack_test.c: static void test_reftable_stack_add(void)
    + 	struct stat stat_result;
    + 	int N =3D ARRAY_SIZE(refs);
    +=20
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	for (i =3D 0; i < N; i++) {
    +@@ reftable/stack_test.c: static void test_reftable_stack_log_normaliz=
e(void)
    + 		.update_index =3D 1,
    + 	};
    +=20
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	input.value.update.message =3D "one\ntwo";
    +@@ reftable/stack_test.c: static void test_reftable_stack_tombstone(vo=
id)
    + 	struct reftable_ref_record dest =3D { NULL };
    + 	struct reftable_log_record log_dest =3D { NULL };
    +=20
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	/* even entries add the refs, odd entries delete them. */
    +@@ reftable/stack_test.c: static void test_reftable_stack_hash_id(void)
    + 	struct reftable_stack *st_default =3D NULL;
    + 	struct reftable_ref_record dest =3D { NULL };
    +=20
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	err =3D reftable_stack_add(st, &write_test_ref, &ref);
    + 	EXPECT_ERR(err);
    +=20
    + 	/* can't read it with the wrong hash ID. */
    +-	err =3D reftable_new_stack(&st32, dir, opts32);
    ++	err =3D reftable_new_stack(&st32, dir, &opts32);
    + 	EXPECT(err =3D=3D REFTABLE_FORMAT_ERROR);
    +=20
    + 	/* check that we can read it back with default opts too. */
    +-	err =3D reftable_new_stack(&st_default, dir, opts_default);
    ++	err =3D reftable_new_stack(&st_default, dir, &opts_default);
    + 	EXPECT_ERR(err);
    +=20
    + 	err =3D reftable_stack_read_ref(st_default, "master", &dest);
    +@@ reftable/stack_test.c: static void test_reflog_expire(void)
    + 	};
    + 	struct reftable_log_record log =3D { NULL };
    +=20
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	for (i =3D 1; i <=3D N; i++) {
    +@@ reftable/stack_test.c: static void test_empty_add(void)
    + 	char *dir =3D get_tmp_dir(__LINE__);
    + 	struct reftable_stack *st2 =3D NULL;
    +=20
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	err =3D reftable_stack_add(st, &write_nothing, NULL);
    + 	EXPECT_ERR(err);
    +=20
    +-	err =3D reftable_new_stack(&st2, dir, opts);
    ++	err =3D reftable_new_stack(&st2, dir, &opts);
    + 	EXPECT_ERR(err);
    + 	clear_dir(dir);
    + 	reftable_stack_destroy(st);
    +@@ reftable/stack_test.c: static void test_reftable_stack_auto_compact=
ion(void)
    + 	int err, i;
    + 	int N =3D 100;
    +=20
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	for (i =3D 0; i < N; i++) {
    +@@ reftable/stack_test.c: static void test_reftable_stack_add_performs=
_auto_compaction(void)
    + 	char *dir =3D get_tmp_dir(__LINE__);
    + 	int err, i, n =3D 20;
    +=20
    +-	err =3D reftable_new_stack(&st, dir, opts);
    ++	err =3D reftable_new_stack(&st, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	for (i =3D 0; i <=3D n; i++) {
    +@@ reftable/stack_test.c: static void test_reftable_stack_compaction_c=
oncurrent(void)
    + 	int err, i;
    + 	int N =3D 3;
    +=20
    +-	err =3D reftable_new_stack(&st1, dir, opts);
    ++	err =3D reftable_new_stack(&st1, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	for (i =3D 0; i < N; i++) {
    +@@ reftable/stack_test.c: static void test_reftable_stack_compaction_c=
oncurrent(void)
    + 		EXPECT_ERR(err);
      	}
     =20
    - 	wr =3D reftable_new_writer(reftable_fd_write, reftable_fd_flush,
    --				 &tab_fd, &st->opts);
    -+				 &tab_fd, st->opts);
    - 	err =3D stack_write_compact(st, wr, first, last, config);
    - 	if (err < 0)
    - 		goto done;
    +-	err =3D reftable_new_stack(&st2, dir, opts);
    ++	err =3D reftable_new_stack(&st2, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	err =3D reftable_stack_compact_all(st1, NULL);
    +@@ reftable/stack_test.c: static void test_reftable_stack_compaction_c=
oncurrent_clean(void)
    + 	int err, i;
    + 	int N =3D 3;
    +=20
    +-	err =3D reftable_new_stack(&st1, dir, opts);
    ++	err =3D reftable_new_stack(&st1, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	for (i =3D 0; i < N; i++) {
    +@@ reftable/stack_test.c: static void test_reftable_stack_compaction_c=
oncurrent_clean(void)
    + 		EXPECT_ERR(err);
    + 	}
    +=20
    +-	err =3D reftable_new_stack(&st2, dir, opts);
    ++	err =3D reftable_new_stack(&st2, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	err =3D reftable_stack_compact_all(st1, NULL);
    +@@ reftable/stack_test.c: static void test_reftable_stack_compaction_c=
oncurrent_clean(void)
    + 	unclean_stack_close(st1);
    + 	unclean_stack_close(st2);
    +=20
    +-	err =3D reftable_new_stack(&st3, dir, opts);
    ++	err =3D reftable_new_stack(&st3, dir, &opts);
    + 	EXPECT_ERR(err);
    +=20
    + 	err =3D reftable_stack_clean(st3);
    =20
      ## reftable/writer.c ##
     @@ reftable/writer.c: static struct strbuf reftable_empty_strbuf =3D S=
TRBUF_INIT;
    @@ reftable/writer.c: static struct strbuf reftable_empty_strbuf =3D ST=
RBUF_INIT;
      reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size=
_t),
      		    int (*flush_func)(void *),
     -		    void *writer_arg, struct reftable_write_options *opts)
    -+		    void *writer_arg, struct reftable_write_options opts)
    ++		    void *writer_arg, const struct reftable_write_options *_opts)
      {
      	struct reftable_writer *wp =3D reftable_calloc(1, sizeof(*wp));
    - 	strbuf_init(&wp->block_writer_data.last_key, 0);
    +-	strbuf_init(&wp->block_writer_data.last_key, 0);
     -	options_set_defaults(opts);
     -	if (opts->block_size >=3D (1 << 24)) {
    ++	struct reftable_write_options opts =3D {0};
     +
    ++	if (_opts)
    ++		opts =3D *_opts;
     +	options_set_defaults(&opts);
     +	if (opts.block_size >=3D (1 << 24)) {
      		/* TODO - error return? */
      		abort();
      	}
     +
    ++	strbuf_init(&wp->block_writer_data.last_key, 0);
      	wp->last_key =3D reftable_empty_strbuf;
     -	REFTABLE_CALLOC_ARRAY(wp->block, opts->block_size);
     +	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
 3:  aa2903e3e5 !  3:  ef14bf7195 reftable/writer: drop static variable use=
d to initialize strbuf
    @@ reftable/writer.c: static void writer_reinit_block_writer(struct ref=
table_writer
      struct reftable_writer *
      reftable_new_writer(ssize_t (*writer_func)(void *, const void *, size=
_t),
      		    int (*flush_func)(void *),
    - 		    void *writer_arg, struct reftable_write_options opts)
    - {
    - 	struct reftable_writer *wp =3D reftable_calloc(1, sizeof(*wp));
    --	strbuf_init(&wp->block_writer_data.last_key, 0);
    -=20
    - 	options_set_defaults(&opts);
    - 	if (opts.block_size >=3D (1 << 24)) {
     @@ reftable/writer.c: reftable_new_writer(ssize_t (*writer_func)(void =
*, const void *, size_t),
    - 		abort();
      	}
     =20
    + 	strbuf_init(&wp->block_writer_data.last_key, 0);
     -	wp->last_key =3D reftable_empty_strbuf;
    -+	strbuf_init(&wp->block_writer_data.last_key, 0);
     +	strbuf_init(&wp->last_key, 0);
      	REFTABLE_CALLOC_ARRAY(wp->block, opts.block_size);
      	wp->write =3D writer_func;
 4:  5e7cbb7b19 !  4:  8ec26646f2 reftable/writer: improve error when passe=
d an invalid block size
    @@ Commit message
    =20
      ## reftable/writer.c ##
     @@ reftable/writer.c: reftable_new_writer(ssize_t (*writer_func)(void =
*, const void *, size_t),
    - 	struct reftable_writer *wp =3D reftable_calloc(1, sizeof(*wp));
    -=20
    + 	if (_opts)
    + 		opts =3D *_opts;
      	options_set_defaults(&opts);
     -	if (opts.block_size >=3D (1 << 24)) {
     -		/* TODO - error return? */
 5:  ed1c150d90 =3D  5:  c4377180ef reftable/dump: support dumping a table'=
s block structure
 6:  be5bdc6dc1 =3D  6:  70720af4d3 refs/reftable: allow configuring block =
size
 7:  05e8d1df2d =3D  7:  b3fe81b7b7 reftable: use `uint16_t` to track resta=
rt interval
 8:  bc0bf65553 !  8:  2b15795707 refs/reftable: allow configuring restart =
interval
    @@ Documentation/config/reftable.txt: readers during access.
     +
     +reftable.restartInterval::
     +	The interval at which to create restart points. The reftable backend
    -+	determines the restart points at file creation. The process is
    -+	arbitrary, but every 16 or 64 records is recommended. Every 16 may be
    ++	determines the restart points at file creation. Every 16 may be
     +	more suitable for smaller block sizes (4k or 8k), every 64 for larger
     +	block sizes (64k).
     ++
 9:  6bc240fd0c =3D  9:  b128d584a5 refs/reftable: allow disabling writing =
the object index
10:  9d4c1f0340 ! 10:  fb1ca02e77 reftable: make the compaction factor conf=
igurable
    @@ reftable/stack.c: license that can be found in the LICENSE file or at
     +#include "constants.h"
      #include "merged.h"
      #include "reader.h"
    - #include "refname.h"
    + #include "reftable-error.h"
     @@ reftable/stack.c: static int segment_size(struct segment *s)
      	return s->end - s->start;
      }
11:  e1282e53fb =3D 11:  d341741eb0 refs/reftable: allow configuring geomet=
ric factor
--=20
2.45.GIT


--Qk9da2qAGlsKFjJw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZBzKwACgkQVbJhu7ck
PpRImBAArSOroZ/U9k/BI8+em/QlrB955MENfOEL7H4/U8rnVmOECMkfM0dKYrxd
hh/Kn6LYUybT+IVb24WKapfwlsB2rdUoz8zPdSJp9uPGv3V4+x+iO4earuSzMkGC
JBhD+qy2kxRc2UYsdtlrhconhYR9JrDcPwS9FUJnKeNrfdT01HpGUAO7Z/G4z3+0
nltLyHZejmDghhdOQGvpcC+jrVOQfwodvuMlUJvFA9cLkoPXYtWTf2Sjbspc51BT
0hqvmvQzytZQvgDQjqJFdXf8yuKWLMYXVzdlNlNhMJIEdqVaD9u0ITHS+OTDSLMd
fEWyUgeyKPI6d/k2bUL12YjZa0zgw4vvkSug0LsLbsp+J1YmROp89ylFjyGA3qxt
QLVaTcPT9VIonFrJb+JZH6eWVkLBqjpwmRaURK+5/4B/UNqlbf5u3R5KcpUAiiNH
CuZuwUfU3X/ClL9uVAWmkNUACP1L+Nq697x+csbTEyhaK77uVQCU7PFyoM2MZINa
ljo/Pj7WMf/Wa0LaM6yd2COqnzn1d957JpTjVdM4/YC9wtxwyQ0hL9VO3gFSAAvN
kCKtNBnq6vOfO2ls2fa1O9qedpphnVjJvBryBUtCnzpn60EjFWUnVZ5hbHJHIyPl
6KloTZT8nCuflSG7tV+PLkayKCd4iO97LRj5LaCs20B1qf61uIA=
=X0iu
-----END PGP SIGNATURE-----

--Qk9da2qAGlsKFjJw--
