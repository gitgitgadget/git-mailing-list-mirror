Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D6BE7D0A3
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 17:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjIURLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 13:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjIURKa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:30 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2933DA27B
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 10:05:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C8B3B3200997;
        Thu, 21 Sep 2023 06:01:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 21 Sep 2023 06:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1695290481; x=1695376881; bh=7s
        S09CMiVTcuRsXqyWDsWs18W3WvIEMlyxD7Xgo225s=; b=ZZM6eMf2fe124ypBxb
        vk5nuXExQYrY+UD+YjNXcrB90BZAkqbzP0iN7xBq9Ms5xSioRzXm0A8a2hXdmbar
        gGt2/EBW7M7+kbRg7qNaXGPX3tSEEcX9vl6vnpjjE2cCoYq9hox3dnAxpEaQzWKn
        TIMHlCJOH1V7g95DbrjNn1Jpg6lrLrCCASat1EZp9gc1lrZGArKJEUX0J6ZYpQMT
        6D8rDmAA1ex0vSVNqtf5Cp6SkQMoIZx6o2UL0rzmxbJac3ozF/Syd+oGayPGxtRI
        LHtWD8Ve6+gLka1lSgwHqHRdUgCuBDl8OCK0z8yjZsyFFBEPxgBWsmNhKAh4aTWE
        2V1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1695290481; x=1695376881; bh=7sS09CMiVTcuR
        sXqyWDsWs18W3WvIEMlyxD7Xgo225s=; b=RZ2sizImZqO5PcVsncZ1KymaZy6Q+
        Cnt6a4cMRUKkg42QkD1CPQjUMMSnbVLZ95vqK0nSv5mUSInS557BSGx2L2Dp95QL
        +yLgrdcoREEfzfeDi/sFvgoSRZW7aN07BsGfNpTGZnYsu9wkxh+QXaVaEGOMZlfy
        1oc9vF71qC3gIQ07ORQe2Jrd6h8QFGywQhF/BMoVuhLBoTd9kJIGFo8BkPw5pQNc
        7E5sAJ9GpX9tjGrpjoCkCwnDXZ/r00eYmtVM9m1c7gZkIAx7ky/AlCvVCz3UCRQC
        NntQcLczg11NyllTc0nuC+nZcHMRWuxVYJnt8QkuGeaAyFh4dNuh2NifA==
X-ME-Sender: <xms:cBQMZXWNyCQCDq7NzRTsBM6dInAnTBANEXHxdMfKR4nCYGdicCuj3A>
    <xme:cBQMZfl0Tf7SuoIgrDJinNi9KmBwpa1TfM0r_osVPln3_LPZ7Rghhuo_LVmXAmtfR
    imrmZ2xncAEYySXHQ>
X-ME-Received: <xmr:cBQMZTbc_piaAxWB55LxXk7nexJ4hW7Qr1appH3Ajg6uPgdV3_QroX9C9zSc-aIkPiB8uoyOFzH3ATg0WyM5An_XwE70xltIZ3PGbrMfKp0LzId-1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudekiedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepudeuveevgeeugeeiveehuedtgeekvefgiefgueehkeeghfejleegudefjeeikeff
    necuffhomhgrihhnpehgihhthhhusgdrtghomhdpthigthdrihhtnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:cRQMZSWzBzm9feCFNIeaCb8c5KxaAxRrNNimhoIK_5rysDfr99f3BA>
    <xmx:cRQMZRlJmqt-ZBesjEWSHI2l5PcfFUbq6UnpLY1JWsufprk3NiBTfQ>
    <xmx:cRQMZfcxUECAXj4t3yka_TqcaGsnK7l-uVXSG2ZYjjbGq-svrE_bnQ>
    <xmx:cRQMZWwAssa64cxr2nzE5JIL1fuMKplyMBlW7y8v6bDFJECKUphlOg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Sep 2023 06:01:19 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 347bd9fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 21 Sep 2023 10:01:17 +0000 (UTC)
Date:   Thu, 21 Sep 2023 12:01:16 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 0/6] RFC: simple reftable backend
Message-ID: <ZQwUbFn3WiRHVkT-@tanuki>
References: <pull.1574.git.git.1695059978.gitgitgadget@gmail.com>
 <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nLli41OpcDAVNkf6"
Content-Disposition: inline
In-Reply-To: <pull.1574.v2.git.git.1695214968.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nLli41OpcDAVNkf6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 20, 2023 at 01:02:42PM +0000, Han-Wen Nienhuys via GitGitGadget=
 wrote:
> This series comes from a conversation with Patrick Steinhardt at Gitlab, =
who
> have an interest in a more scalable ref storage system.
>=20
> I unfortunately don't have business reasons to spend much time on this
> project anymore, and the original, sweeping migration has too many open
> questions.
>=20
> I thought of an alternate approach, and I wanted to show it as input to
> discussions at the contributor summit.
>=20
> I think the first part (everything before "refs: alternate reftable ref
> backend implementation") is a good improvement overall, and could be land=
ed
> separately without much tweaking.
>=20
> The second part ("refs: alternate reftable ref backend implementation" and
> follow-on) is something open for discussion: the alternative "packed
> storage" is based on reftable, but it could conceivably be a different ty=
pe
> of database/file format too. I think it's attractive to use reftable here,
> because over time more data (symrefs, reflog) could be moved into reftabl=
e.
>=20
> I'm offering this series as a RFC. I hope that someone else (Patrick?) can
> look into getting the bits and pieces of this merged.

I've added this topic to the Contributor's summit such that the project
can discuss what to do about the different proposals that exist around
next-gen reference backends. If the conclusion is that reftables and
this proposal here is still likely to land, then I'm happy to pick it up
and try to get it upstreamed.

I'll have a look at this RFC early next week.

Thanks!

Patrick

> Han-Wen Nienhuys (6):
>   refs: construct transaction using a _begin callback
>   refs: wrap transaction in a debug-specific transaction
>   refs: push lock management into packed backend
>   refs: move is_packed_transaction_needed out of packed-backend.c
>   refs: alternate reftable ref backend implementation
>   refs: always try to do packed transactions for reftable
>=20
>  Makefile                        |    1 +
>  config.mak.uname                |    2 +-
>  contrib/workdir/git-new-workdir |    2 +-
>  refs.c                          |   13 +-
>  refs/debug.c                    |   87 +-
>  refs/files-backend.c            |  216 ++--
>  refs/packed-backend.c           |  149 +--
>  refs/packed-backend.h           |   19 -
>  refs/refs-internal.h            |    5 +
>  refs/reftable-backend.c         | 1658 +++++++++++++++++++++++++++++++
>  refs/reftable-backend.h         |    8 +
>  11 files changed, 1929 insertions(+), 231 deletions(-)
>  create mode 100644 refs/reftable-backend.c
>  create mode 100644 refs/reftable-backend.h
>=20
>=20
> base-commit: bda494f4043963b9ec9a1ecd4b19b7d1cd9a0518
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-157=
4%2Fhanwen%2Fsimple-reftable-backend-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1574/h=
anwen/simple-reftable-backend-v2
> Pull-Request: https://github.com/git/git/pull/1574
>=20
> Range-diff vs v1:
>=20
>  -:  ----------- > 1:  e99f3d20056 refs: construct transaction using a _b=
egin callback
>  -:  ----------- > 2:  9a459259330 refs: wrap transaction in a debug-spec=
ific transaction
>  1:  dea0fbb139a ! 3:  8dedb23eb69 refs: push lock management into packed=
 backend
>      @@ Metadata
>        ## Commit message ##
>           refs: push lock management into packed backend
>      =20
>      -    Introduces a ref backend method transaction_begin, which for the
>      -    packed backend takes packed-refs.lock.
>      +    Take packed-refs.lock in the transaction_begin of the packed ba=
ckend.
>      =20
>           This decouples the files backend from the packed backend, allow=
ing the
>           latter to be swapped out by another ref backend.
>      @@ Commit message
>           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>      =20
>        ## refs.c ##
>      -@@ refs.c: struct ref_transaction *ref_store_transaction_begin(stru=
ct ref_store *refs,
>      - 						    struct strbuf *err)
>      - {
>      - 	struct ref_transaction *tr;
>      -+	int ret =3D 0;
>      - 	assert(err);
>      -=20
>      - 	CALLOC_ARRAY(tr, 1);
>      - 	tr->ref_store =3D refs;
>      -+
>      -+	if (refs->be->transaction_begin)
>      -+		ret =3D refs->be->transaction_begin(refs, tr, err);
>      -+	if (ret) {
>      -+		free(tr);
>      -+		return NULL;
>      -+	}
>      - 	return tr;
>      - }
>      -=20
>      -
>      - ## refs/debug.c ##
>      -@@ refs/debug.c: static int debug_init_db(struct ref_store *refs, s=
truct strbuf *err)
>      - 	return res;
>      - }
>      -=20
>      -+static int debug_transaction_begin(struct ref_store *refs,
>      -+				   struct ref_transaction *transaction,
>      -+				   struct strbuf *err)
>      -+{
>      -+	struct debug_ref_store *drefs =3D (struct debug_ref_store *)refs;
>      -+	int res;
>      -+	transaction->ref_store =3D drefs->refs;
>      -+	res =3D drefs->refs->be->transaction_begin(drefs->refs, transacti=
on,
>      -+						   err);
>      -+	trace_printf_key(&trace_refs, "transaction_begin: %d \"%s\"\n", r=
es,
>      -+			 err->buf);
>      -+	return res;
>      -+}
>      -+
>      - static int debug_transaction_prepare(struct ref_store *refs,
>      - 				     struct ref_transaction *transaction,
>      - 				     struct strbuf *err)
>      -@@ refs/debug.c: struct ref_storage_be refs_be_debug =3D {
>      - 	 * has a function we should also have a wrapper for it here.
>      - 	 * Test the output with "GIT_TRACE_REFS=3D1".
>      - 	 */
>      -+	.transaction_begin =3D debug_transaction_begin,
>      - 	.transaction_prepare =3D debug_transaction_prepare,
>      - 	.transaction_finish =3D debug_transaction_finish,
>      - 	.transaction_abort =3D debug_transaction_abort,
>      +@@ refs.c: int ref_transaction_abort(struct ref_transaction *transa=
ction,
>      + 	int ret =3D 0;
>      +=20
>      + 	switch (transaction->state) {
>      +-	case REF_TRANSACTION_OPEN:
>      +-		/* No need to abort explicitly. */
>      +-		break;
>      + 	case REF_TRANSACTION_PREPARED:
>      ++	case REF_TRANSACTION_OPEN:
>      ++		/* an OPEN transactions may have a lock. */
>      + 		ret =3D refs->be->transaction_abort(refs, transaction, err);
>      + 		break;
>      + 	case REF_TRANSACTION_CLOSED:
>      =20
>        ## refs/files-backend.c ##
>       @@ refs/files-backend.c: static int files_pack_refs(struct ref_stor=
e *ref_store,
>      @@ refs/files-backend.c: static int files_transaction_finish(struct =
ref_store *ref_
>       -		backend_data->packed_transaction =3D NULL;
>       -		if (ret)
>       -			goto cleanup;
>      -+	if (backend_data->packed_transaction) {=20
>      ++	if (backend_data->packed_transaction) {
>       +		if (backend_data->packed_transaction_needed) {
>       +			ret =3D ref_transaction_commit(packed_transaction, err);
>       +			if (ret)
>       +				goto cleanup;
>      -+			/* TODO: leaks on error path. */
>      ++
>       +			ref_transaction_free(packed_transaction);
>       +			packed_transaction =3D NULL;
>       +			backend_data->packed_transaction =3D NULL;
>      @@ refs/files-backend.c: static int files_initial_transaction_commit=
(struct ref_sto
>        		ref_transaction_free(packed_transaction);
>      =20
>        ## refs/packed-backend.c ##
>      +@@ refs/packed-backend.c: static int write_packed_entry(FILE *fh, c=
onst char *refname,
>      + 	return 0;
>      + }
>      +=20
>      +-int packed_refs_lock(struct ref_store *ref_store, int flags, struc=
t strbuf *err)
>      ++static int packed_refs_lock(struct ref_store *ref_store, int flags=
, struct strbuf *err)
>      + {
>      + 	struct packed_ref_store *refs =3D
>      + 		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
>      +@@ refs/packed-backend.c: int packed_refs_lock(struct ref_store *re=
f_store, int flags, struct strbuf *err)
>      + 	return 0;
>      + }
>      +=20
>      +-void packed_refs_unlock(struct ref_store *ref_store)
>      ++static void packed_refs_unlock(struct ref_store *ref_store)
>      + {
>      + 	struct packed_ref_store *refs =3D packed_downcast(
>      + 			ref_store,
>      +@@ refs/packed-backend.c: void packed_refs_unlock(struct ref_store =
*ref_store)
>      + 	rollback_lock_file(&refs->lock);
>      + }
>      +=20
>      +-int packed_refs_is_locked(struct ref_store *ref_store)
>      +-{
>      +-	struct packed_ref_store *refs =3D packed_downcast(
>      +-			ref_store,
>      +-			REF_STORE_READ | REF_STORE_WRITE,
>      +-			"packed_refs_is_locked");
>      +-
>      +-	return is_lock_file_locked(&refs->lock);
>      +-}
>      +-
>      + /*
>      +  * The packed-refs header line that we write out. Perhaps other tr=
aits
>      +  * will be added later.
>       @@ refs/packed-backend.c: int is_packed_transaction_needed(struct r=
ef_store *ref_store,
>       =20
>        struct packed_transaction_backend_data {
>      @@ refs/packed-backend.c: static void packed_transaction_cleanup(str=
uct packed_ref_
>        	transaction->state =3D REF_TRANSACTION_CLOSED;
>        }
>       =20
>      -+static int packed_transaction_begin(struct ref_store *ref_store,
>      -+				    struct ref_transaction *transaction,
>      +-
>      + static struct ref_transaction *packed_transaction_begin(struct ref=
_store *ref_store,
>      +-							struct strbuf *err) {
>      +-	struct ref_transaction *tr;
>      +-	CALLOC_ARRAY(tr, 1);
>      +-	return tr;
>       +				    struct strbuf *err)
>       +{
>       +	struct packed_ref_store *refs =3D packed_downcast(
>      @@ refs/packed-backend.c: static void packed_transaction_cleanup(str=
uct packed_ref_
>       +			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
>       +			"ref_transaction_begin");
>       +	struct packed_transaction_backend_data *data;
>      -+
>      -+	CALLOC_ARRAY(data, 1);
>      -+	string_list_init_nodup(&data->updates);
>      ++	struct ref_transaction *transaction;
>       +
>       +	if (!is_lock_file_locked(&refs->lock)) {
>       +		if (packed_refs_lock(ref_store, 0, err))
>      -+			/* todo: leaking data */
>      -+			return -1;
>      ++			return NULL;
>       +	}
>      ++	CALLOC_ARRAY(transaction, 1);
>      ++	CALLOC_ARRAY(data, 1);
>      ++	string_list_init_nodup(&data->updates);
>       +	transaction->backend_data =3D data;
>      -+	return 0;
>      -+}
>      -+
>      ++	return transaction;
>      + }
>      +=20
>        static int packed_transaction_prepare(struct ref_store *ref_store,
>      - 				      struct ref_transaction *transaction,
>      - 				      struct strbuf *err)
>       @@ refs/packed-backend.c: static int packed_transaction_prepare(str=
uct ref_store *ref_store,
>        			ref_store,
>        			REF_STORE_READ | REF_STORE_WRITE | REF_STORE_ODB,
>      @@ refs/packed-backend.c: static int packed_transaction_prepare(stru=
ct ref_store *r
>        	if (write_with_updates(refs, &data->updates, err))
>        		goto failure;
>       =20
>      -@@ refs/packed-backend.c: struct ref_storage_be refs_be_packed =3D {
>      - 	.name =3D "packed",
>      - 	.init =3D packed_ref_store_create,
>      - 	.init_db =3D packed_init_db,
>      -+	.transaction_begin =3D packed_transaction_begin,
>      - 	.transaction_prepare =3D packed_transaction_prepare,
>      - 	.transaction_finish =3D packed_transaction_finish,
>      - 	.transaction_abort =3D packed_transaction_abort,
>      =20
>        ## refs/packed-backend.h ##
>       @@ refs/packed-backend.h: struct ref_store *packed_ref_store_create=
(struct repository *repo,
>      @@ refs/packed-backend.h: struct ref_store *packed_ref_store_create(=
struct reposito
>        /*
>         * Return true if `transaction` really needs to be carried out aga=
inst
>         * the specified packed_ref_store, or false if it can be skipped
>      -
>      - ## refs/refs-internal.h ##
>      -@@ refs/refs-internal.h: typedef struct ref_store *ref_store_init_f=
n(struct repository *repo,
>      -=20
>      - typedef int ref_init_db_fn(struct ref_store *refs, struct strbuf *=
err);
>      -=20
>      -+typedef int ref_transaction_begin_fn(struct ref_store *refs,
>      -+				     struct ref_transaction *transaction,
>      -+				     struct strbuf *err);
>      -+
>      - typedef int ref_transaction_prepare_fn(struct ref_store *refs,
>      - 				       struct ref_transaction *transaction,
>      - 				       struct strbuf *err);
>      -@@ refs/refs-internal.h: struct ref_storage_be {
>      - 	ref_store_init_fn *init;
>      - 	ref_init_db_fn *init_db;
>      -=20
>      -+	ref_transaction_begin_fn *transaction_begin;
>      - 	ref_transaction_prepare_fn *transaction_prepare;
>      - 	ref_transaction_finish_fn *transaction_finish;
>      - 	ref_transaction_abort_fn *transaction_abort;
>  2:  a5cb3adc662 ! 4:  0b8919b05c4 refs: move is_packed_transaction_neede=
d out of packed-backend.c
>      @@ refs/files-backend.c: out:
>        	return ret;
>        }
>       =20
>      -+
>       +/*
>       + * Return true if `transaction` really needs to be carried out aga=
inst
>       + * the specified packed_ref_store, or false if it can be skipped
>      @@ refs/files-backend.c: out:
>        struct files_transaction_backend_data {
>        	struct ref_transaction *packed_transaction;
>        	int packed_transaction_needed;
>      -@@ refs/files-backend.c: struct ref_storage_be refs_be_files =3D {
>      - 	.delete_reflog =3D files_delete_reflog,
>      - 	.reflog_expire =3D files_reflog_expire
>      - };
>      -+
>      =20
>        ## refs/packed-backend.c ##
>       @@ refs/packed-backend.c: error:
>  3:  559c04cee99 ! 5:  d5669da57e3 refs: alternate reftable ref backend i=
mplementation
>      @@ Commit message
>           refs: alternate reftable ref backend implementation
>      =20
>           This introduces the reftable backend as an alternative to the p=
acked
>      -    backend. This simplifies the code, because we now longer have t=
o worry
>      -    about:
>      +    backend.
>      +
>      +    This is an alternative to the approach which was explored in
>      +    https://github.com/git/git/pull/1215/. This alternative is simp=
ler,
>      +    because we now longer have to worry about:
>      =20
>           - pseudorefs and the HEAD ref
>           - worktrees
>           - commands that blur together files and references (cherry-pick=
, rebase)
>      =20
>           This deviates from the spec that in
>      -    Documentation/technical/reftable.txt. It might be possible to u=
pdate
>      -    the code such that all writes by default go to reftable directl=
y. Then
>      -    the result would be compatible with an implementation that writ=
es only
>      -    reftable (the reftable lock would still prevent races) relative=
 to an
>      -    implementation that disregards loose refs. Or,  JGit could be a=
dapted
>      -    to follow this implementation.
>      +    Documentation/technical/reftable.txt. It might be possible to u=
pdate the
>      +    code such that all writes by default go to reftable directly. T=
hen the
>      +    result would be compatible with an implementation that writes o=
nly
>      +    reftable (the reftable lock would still prevent races), but som=
ething
>      +    must be done about the HEAD ref (which JGit keeps in reftable t=
oo.)
>      +    Alternatively, JGit could be adapted to follow this implementat=
ion:
>      +    despite the code being there for 4 years now, I haven't heard o=
f anyone
>      +    using it in production (exactly because CGit does not support i=
t).
>      =20
>           For this incremental path, the reftable format is arguably more
>           complex than necessary, as
>      =20
>           - packed-refs doesn't support symrefs
>      -    - reflogs aren't moved into reftable/
>      +    - reflogs aren't moved into reftable
>      =20
>           on the other hand, the code is already there, and it's well-str=
uctured
>           and well-tested.
>      =20
>      -    This implementation is a prototype. To test, you need to do `ex=
port
>      -    GIT_TEST_REFTABLE=3D1`. Doing so creates a handful of errors in=
 the
>      -    test-suite, most seemingly related to the new behavior of pack-=
refs
>      -    (which creates a reftable/ dir and not a packed-refs file.), bu=
t it
>      -    seems overseeable.
>      +    refs/reftable-backend.c was created by cannibalizing the first =
version
>      +    of reftable support (github PR 1215 as mentioned above). It sup=
ports
>      +    reflogs and symrefs, even though those features are never exerc=
ised.
>      +
>      +    This implementation is a prototype, for the following reasons:
>      +
>      +    - no considerations of backward compatibility and configuring an
>      +    extension
>      +    - no support for converting between packed-refs and reftable
>      +    - no documentation
>      +    - test failures when setting GIT_TEST_REFTABLE=3D1.
>      =20
>           Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
>      =20
>      @@ contrib/workdir/git-new-workdir: trap cleanup $siglist
>        	case $x in
>      =20
>        ## refs/files-backend.c ##
>      +@@
>      + #include "../git-compat-util.h"
>      ++#include "../abspath.h"
>      + #include "../config.h"
>      + #include "../copy.h"
>      + #include "../environment.h"
>       @@
>        #include "refs-internal.h"
>        #include "ref-cache.h"
>      @@ refs/files-backend.c
>        #include "../iterator.h"
>        #include "../dir-iterator.h"
>       @@ refs/files-backend.c: static struct ref_store *files_ref_store_c=
reate(struct repository *repo,
>      + 	struct files_ref_store *refs =3D xcalloc(1, sizeof(*refs));
>      + 	struct ref_store *ref_store =3D (struct ref_store *)refs;
>      + 	struct strbuf sb =3D STRBUF_INIT;
>      ++	int has_reftable, has_packed;
>      +=20
>      + 	base_ref_store_init(ref_store, repo, gitdir, &refs_be_files);
>        	refs->store_flags =3D flags;
>        	get_common_dir_noenv(&sb, gitdir);
>        	refs->gitcommondir =3D strbuf_detach(&sb, NULL);
>      -+
>      -+	/* TODO: should look at the repo to decide whether to use packed-=
refs or
>      -+	 * reftable. */
>      - 	refs->packed_ref_store =3D
>      +-	refs->packed_ref_store =3D
>       -		packed_ref_store_create(repo, refs->gitcommondir, flags);
>      -+		git_env_bool("GIT_TEST_REFTABLE", 0) =20
>      ++
>      ++	strbuf_addf(&sb, "%s/reftable", refs->gitcommondir);
>      ++	has_reftable =3D is_directory(sb.buf);
>      ++	strbuf_reset(&sb);
>      ++	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
>      ++	has_packed =3D file_exists(sb.buf);
>      ++
>      ++	if (!has_packed && !has_reftable)
>      ++		has_reftable =3D git_env_bool("GIT_TEST_REFTABLE", 0);
>      ++
>      ++	refs->packed_ref_store =3D has_reftable
>       +		? git_reftable_ref_store_create(repo, refs->gitcommondir, flags)
>       +		: packed_ref_store_create(repo, refs->gitcommondir, flags);
>       =20
>        	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdi=
r);
>        	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
>      =20
>      - ## refs/packed-backend.c ##
>      -@@ refs/packed-backend.c: static int write_packed_entry(FILE *fh, c=
onst char *refname,
>      - 	return 0;
>      - }
>      -=20
>      --int packed_refs_lock(struct ref_store *ref_store, int flags, struc=
t strbuf *err)
>      -+static int packed_refs_lock(struct ref_store *ref_store, int flags=
, struct strbuf *err)
>      - {
>      - 	struct packed_ref_store *refs =3D
>      - 		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
>      -@@ refs/packed-backend.c: int packed_refs_lock(struct ref_store *re=
f_store, int flags, struct strbuf *err)
>      - 	return 0;
>      - }
>      -=20
>      --void packed_refs_unlock(struct ref_store *ref_store)
>      -+static void packed_refs_unlock(struct ref_store *ref_store)
>      - {
>      - 	struct packed_ref_store *refs =3D packed_downcast(
>      - 			ref_store,
>      -@@ refs/packed-backend.c: void packed_refs_unlock(struct ref_store =
*ref_store)
>      - 	rollback_lock_file(&refs->lock);
>      - }
>      -=20
>      --int packed_refs_is_locked(struct ref_store *ref_store)
>      --{
>      --	struct packed_ref_store *refs =3D packed_downcast(
>      --			ref_store,
>      --			REF_STORE_READ | REF_STORE_WRITE,
>      --			"packed_refs_is_locked");
>      --
>      --	return is_lock_file_locked(&refs->lock);
>      --}
>      --
>      - /*
>      -  * The packed-refs header line that we write out. Perhaps other tr=
aits
>      -  * will be added later.
>      -
>        ## refs/refs-internal.h ##
>       @@ refs/refs-internal.h: struct ref_storage_be {
>        };
>      @@ refs/reftable-backend.c (new)
>       +#include "../worktree.h"
>       +#include "refs-internal.h"
>       +#include "reftable-backend.h"
>      ++#include "../repository.h"
>       +
>       +extern struct ref_storage_be refs_be_reftable;
>       +
>      @@ refs/reftable-backend.c (new)
>       +	return &ri->base;
>       +}
>       +
>      -+static int fixup_symrefs(struct ref_store *ref_store,
>      -+			 struct ref_transaction *transaction)
>      -+{
>      -+	struct strbuf referent =3D STRBUF_INIT;
>      -+	int i =3D 0;
>      -+	int err =3D 0;
>      -+
>      -+	for (i =3D 0; i < transaction->nr; i++) {
>      -+		struct ref_update *update =3D transaction->updates[i];
>      -+		struct object_id old_oid;
>      -+		int failure_errno;
>      -+
>      -+		err =3D git_reftable_read_raw_ref(ref_store, update->refname,
>      -+						&old_oid, &referent,
>      -+						/* mutate input, like
>      -+						   files-backend.c */
>      -+						&update->type, &failure_errno);
>      -+		if (err < 0 && failure_errno =3D=3D ENOENT &&
>      -+		    is_null_oid(&update->old_oid)) {
>      -+			err =3D 0;
>      -+		}
>      -+		if (err < 0)
>      -+			goto done;
>      -+
>      -+		if (!(update->type & REF_ISSYMREF))
>      -+			continue;
>      -+
>      -+		if (update->flags & REF_NO_DEREF) {
>      -+			/* what should happen here? See files-backend.c
>      -+			 * lock_ref_for_update. */
>      -+		} else {
>      -+			/*
>      -+			  If we are updating a symref (eg. HEAD), we should also
>      -+			  update the branch that the symref points to.
>      -+
>      -+			  This is generic functionality, and would be better
>      -+			  done in refs.c, but the current implementation is
>      -+			  intertwined with the locking in files-backend.c.
>      -+			*/
>      -+			int new_flags =3D update->flags;
>      -+			struct ref_update *new_update =3D NULL;
>      -+
>      -+			/* if this is an update for HEAD, should also record a
>      -+			   log entry for HEAD? See files-backend.c,
>      -+			   split_head_update()
>      -+			*/
>      -+			new_update =3D ref_transaction_add_update(
>      -+				transaction, referent.buf, new_flags,
>      -+				&update->new_oid, &update->old_oid,
>      -+				update->msg);
>      -+			new_update->parent_update =3D update;
>      -+
>      -+			/* files-backend sets REF_LOG_ONLY here. */
>      -+			update->flags |=3D REF_NO_DEREF | REF_LOG_ONLY;
>      -+			update->flags &=3D ~REF_HAVE_OLD;
>      -+		}
>      -+	}
>      -+
>      -+done:
>      -+	assert(err !=3D REFTABLE_API_ERROR);
>      -+	strbuf_release(&referent);
>      -+	return err;
>      -+}
>      -+
>      -+static int git_reftable_transaction_prepare(struct ref_store *ref_=
store,
>      -+					    struct ref_transaction *transaction,
>      -+					    struct strbuf *errbuf)
>      ++static struct ref_transaction *git_reftable_transaction_begin(stru=
ct ref_store *ref_store,
>      ++							      struct strbuf *errbuf)
>       +{
>       +	struct git_reftable_ref_store *refs =3D
>       +		(struct git_reftable_ref_store *)ref_store;
>       +	struct reftable_addition *add =3D NULL;
>      -+	struct reftable_stack *stack =3D stack_for(
>      -+		refs,
>      -+		transaction->nr ? transaction->updates[0]->refname : NULL);
>      -+	int i;
>      ++	struct ref_transaction *transaction =3D NULL;
>      ++	struct reftable_stack *stack =3D refs->main_stack;
>       +
>       +	int err =3D refs->err;
>       +	if (err < 0) {
>      @@ refs/reftable-backend.c (new)
>       +
>       +	err =3D reftable_stack_new_addition(&add, stack);
>       +	if (err) {
>      ++		strbuf_addf(errbuf, "reftable: transaction begin: %s",
>      ++			    reftable_error_str(err));
>       +		goto done;
>       +	}
>       +
>      -+	for (i =3D 0; i < transaction->nr; i++) {
>      -+		struct ref_update *u =3D transaction->updates[i];
>      -+		if ((u->flags & REF_HAVE_NEW) && !is_null_oid(&u->new_oid) &&
>      -+		    !(u->flags & REF_SKIP_OID_VERIFICATION) &&
>      -+		    !(u->flags & REF_LOG_ONLY)) {
>      -+			struct object *o =3D
>      -+				parse_object(refs->base.repo, &u->new_oid);
>      -+			if (!o) {
>      -+				strbuf_addf(
>      -+					errbuf,
>      -+					"trying to write ref '%s' with nonexistent object %s",
>      -+					u->refname, oid_to_hex(&u->new_oid));
>      -+				err =3D -1;
>      -+				goto done;
>      -+			}
>      -+		}
>      -+	}
>      -+
>      -+	err =3D fixup_symrefs(ref_store, transaction);
>      -+	if (err) {
>      -+		goto done;
>      -+	}
>      -+
>      ++	CALLOC_ARRAY(transaction, 1);
>       +	transaction->backend_data =3D add;
>      -+	transaction->state =3D REF_TRANSACTION_PREPARED;
>      -+
>       +done:
>      -+	assert(err !=3D REFTABLE_API_ERROR);
>      -+	if (err < 0) {
>      -+		if (add) {
>      -+			reftable_addition_destroy(add);
>      -+			add =3D NULL;
>      -+		}
>      -+		transaction->state =3D REF_TRANSACTION_CLOSED;
>      -+		if (!errbuf->len)
>      -+			strbuf_addf(errbuf, "reftable: transaction prepare: %s",
>      -+				    reftable_error_str(err));
>      -+	}
>      ++	return transaction;
>      ++}
>       +
>      -+	return err;
>      ++static int git_reftable_transaction_prepare(struct ref_store *ref_=
store,
>      ++					    struct ref_transaction *transaction,
>      ++					    struct strbuf *errbuf)
>      ++{
>      ++	transaction->state =3D REF_TRANSACTION_PREPARED;
>      ++	return 0;
>       +}
>       +
>       +static int git_reftable_transaction_abort(struct ref_store *ref_st=
ore,
>      @@ refs/reftable-backend.c (new)
>       +					   struct ref_transaction *transaction,
>       +					   struct strbuf *errmsg)
>       +{
>      ++	struct git_reftable_ref_store *refs =3D
>      ++		(struct git_reftable_ref_store *)transaction->ref_store;
>       +	struct reftable_addition *add =3D
>       +		(struct reftable_addition *)transaction->backend_data;
>       +	int err =3D 0;
>      @@ refs/reftable-backend.c (new)
>       +
>       +	err =3D reftable_addition_commit(add);
>       +
>      ++	if (!err)
>      ++		err =3D reftable_stack_auto_compact(refs->main_stack);
>       +done:
>       +	assert(err !=3D REFTABLE_API_ERROR);
>       +	reftable_addition_destroy(add);
>      @@ refs/reftable-backend.c (new)
>       +	.name =3D "reftable",
>       +	.init =3D git_reftable_ref_store_create,
>       +	.init_db =3D git_reftable_init_db,
>      ++	.transaction_begin =3D git_reftable_transaction_begin,
>       +	.transaction_prepare =3D git_reftable_transaction_prepare,
>       +	.transaction_finish =3D git_reftable_transaction_finish,
>       +	.transaction_abort =3D git_reftable_transaction_abort,
>  -:  ----------- > 6:  2cf743031ab refs: always try to do packed transact=
ions for reftable
>=20
> --=20
> gitgitgadget

--nLli41OpcDAVNkf6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUMFGsACgkQVbJhu7ck
PpQFJhAAkTWOnLisF3mXx8PI1rRm7svu1770QIQSSjJ4vCEtBt72hnFqSoPeeXag
jPu8fPIeOjdHcjRJFCThlospLGDsv7daNX6TWZeXWauwW9vZj5E1jJj7SenotZlA
vyCR+9I+5pPd/W0TgV4PkcpbEQLcnhnqW+ZxEM7UJrfOHA0byT9AYxBwfLJ8mTKy
nlxhcEBofa1VNa2zgpN4tQem+ejEgKrP9p2ROXDn+2Bw+En4beI8isI4K2EkK2N8
0/xpMil3aYa3pcOvB5oEUQ9xVetFZOjuagLtpB92UdpBk2t8WUw9sSfvyccaGhR2
S1itJleYi2YgIEnU1YKjnbi1rfOF7m+3D8m1yr5aok5Gh5gf21L1+nD+4bbdeUuC
3+SrtV/Dp0BqgBr7oqbY0wA7akmyz3KibZknrwI6AlF7kJJFYtI45z0xvYjK9KyK
aq2VPc23fmi+zWEDNyUPXO+PluXkVQUK8gB7VEPOl/Ri52ikTxy7dkcffytekfO7
/alzDMC1QZXFWnFGliwAuufFmn5WffuI5vcQZPpMlMP8eC+ZTnKK+BiPAz4tJ7OK
OS1MjYahOdEXeu/PPdR4feXNG/YnQMrDIeYpWQKyWBfdtNfNXkvF9/+sGHZzzDVh
cPxrstGQxA4Wmfd6yBVbm/VpnSOUmC9+FqgY7vtsihaXOyMHFhc=
=Pj4H
-----END PGP SIGNATURE-----

--nLli41OpcDAVNkf6--
