Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0965FB8A
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 08:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863113; cv=none; b=KIgUmqTIGWn9OSX1sPLfr1ux5KSZQ5G3Nkgz6PM8hsUIKlB/TYHUW87PzH+Le/dCOXlJbOF8zdIGHSIZ7sa9TaKoq460yNDKM3X/vREsFngN72H2LZnW8vC/JPivLmXH4LpGuxuRJqmBoJMdTWgHE+bi4NnpHWUZpj4BUqEeRtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863113; c=relaxed/simple;
	bh=GlO5L5ECohTJXKvjGZlRS8ZhIl0AXgDZoCAodQvyOqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LiiOvjhHuW4s8cmuD8G3P26Biq5kH1j7Tfy8til85ttCK37x0bLWrLna7sGG2chjNYCSjdrcCeLSYYPkZqtnnnaxCBiG2VKHTBv/NJPHuBgKEq5YTGA8UKCwVwiztOhWW8EPinorvwnjskdu6ZWdp2Q4iSBIJejc1gz/eD93y68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PyhPoccm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VY6tDejE; arc=none smtp.client-ip=66.111.4.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PyhPoccm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VY6tDejE"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.nyi.internal (Postfix) with ESMTP id 4D2E95C00FE;
	Fri,  2 Feb 2024 03:38:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Fri, 02 Feb 2024 03:38:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706863109; x=1706949509; bh=+nNBxK1nrz
	XMl5gjhvKS1tlbI4k2kcn/pKHJ6aIv1qw=; b=PyhPoccmgtdIPdGtRSsosMxD2q
	RKdRLgQYel2fsitH9cFumiWGWw2VWz+16nqSmhsrcTYiNF4ig3Et5mwRcAfYbNkK
	ZjwP6EU/ZDVPdU2Gdor5viRgWUAsyphYzP7yRn08Qw2vXhJy5bBHIn5WrEGTInbR
	zXWLjHqK6xAp0F+BGM2013Zw5DBHRMeUgDdTh7SSclqcqYpteRJd54mI1/1PrEkS
	efwZev845JgXR6E/aaoy8pFp+Clwe84jTYJt381/VZT2d1J5XusTrPV6YDADSEPP
	td0v5MhRmTy8fdWKRLZIMWSvHEL1B+IFpTuKpww+NIabTCf4sJFMwQP78SPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706863109; x=1706949509; bh=+nNBxK1nrzXMl5gjhvKS1tlbI4k2
	kcn/pKHJ6aIv1qw=; b=VY6tDejEEwgZj9haSUvuhPS7BqEhkYIMgLSPOx433yGS
	zwcU0z8uRqv/6jEerXTH19xOWE/6xGSiCpbq+qK20stx7rbtdNTSfpWdX/bwPiHp
	WD1lHkP7tcuqN2LGZygqX8a9U3/PYm6aK5XtSUGAvvh9J3wXJYlPjAnE41LeeqvX
	X5wfOaPtyX9VqHjLK0P0vTWJPfCVzflvDt9YXKKq30//C9gCC2lbsLv6BYceUbda
	XjKxm7rifk5T0TSLhij+PeEwZYHiEzyBR1q1fRM2Lv8adbgsKYe2CbEPpmxFBEM5
	Oa4N7zYVN4JihG1VXOTJFrNDn6TX/yVhWaZ+gARL8w==
X-ME-Sender: <xms:Baq8Zc7urM1wnJloKD-6uhXfhl5XZvNFpXIgLf6PIRdfEykW9b0cIA>
    <xme:Baq8Zd7dDAODoprftQntxAYj7wVewZKmhD9U9ywHSf2ua3BlCAZRuX7ey8S7n9f_F
    tKx6SrOcvk8bjdV1Q>
X-ME-Received: <xmr:Baq8ZbdD2N-zMD2TvocflLnLyZz8meAVfGdjbShC12w_SmU0EIvMIJk_-K2CYZSj0un6h3bC3sZyK_lRZr17S23SgX4OiLvDgcAzJy23n1Qweg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedufedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepgedtgffhudfgfeefjeelkeefledthefhveeltdehlefgfeetudevfffhteefudeu
    necuffhomhgrihhnpehhthhtphgurdhshhdpuhhpuggrthgvrdhnvgifpdhuphgurghtvg
    drnhgrmhgvpdhuphgurghtvgdrvghmrghilhdpuhhpuggrthgvrdhtiienucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Baq8ZRKrgv_zXaWKYNeTMBp5CREDcJKdzK52I_5Ns6sWiSrDZPv97w>
    <xmx:Baq8ZQLHML1IXo-eiajsaF9ODJHmGo37KtxeNNMkFEvcczfsBIUspQ>
    <xmx:Baq8ZSwkTxNXU_BycSi_qJdprf-YI8iO6pmyaCKETSeYb_EWpsxC8w>
    <xmx:Baq8ZU1jrxhuCoXK_dL5GAyQxW5xl36fuuDPzxycst23ExP1YL0OkA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 03:38:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 390a0cad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Feb 2024 08:35:03 +0000 (UTC)
Date: Fri, 2 Feb 2024 09:38:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwen@google.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 0/2] refs: introduce reftable backend
Message-ID: <cover.1706862705.git.ps@pks.im>
References: <cover.1706601199.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GuXJXIQdxPEWftCR"
Content-Disposition: inline
In-Reply-To: <cover.1706601199.git.ps@pks.im>


--GuXJXIQdxPEWftCR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series that introduces the
reftable backend.

This version addresses the feedback by Karthik. I don't think it really
makes sense to spell out every change here -- the range diff should
likely be easier to digest.

Thanks!

Patrick

Patrick Steinhardt (2):
  refs: introduce reftable backend
  ci: add jobs to test with the reftable backend

 .github/workflows/main.yml                    |    9 +
 .gitlab-ci.yml                                |    9 +
 Documentation/ref-storage-format.txt          |    2 +
 .../technical/repository-version.txt          |    5 +-
 Makefile                                      |    1 +
 ci/lib.sh                                     |    2 +-
 ci/run-build-and-tests.sh                     |    3 +
 contrib/workdir/git-new-workdir               |    2 +-
 path.c                                        |    2 +-
 path.h                                        |    1 +
 refs.c                                        |    1 +
 refs/refs-internal.h                          |    1 +
 refs/reftable-backend.c                       | 2295 +++++++++++++++++
 repository.h                                  |    5 +-
 t/t0610-reftable-basics.sh                    |  887 +++++++
 t/t0611-reftable-httpd.sh                     |   26 +
 t/test-lib.sh                                 |    2 +
 17 files changed, 3246 insertions(+), 7 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100755 t/t0610-reftable-basics.sh
 create mode 100755 t/t0611-reftable-httpd.sh

Range-diff against v1:
1:  5598cd1307 ! 1:  d6548dcfad refs: introduce reftable backend
    @@ Commit message
             previously been deleting reflogs together with their refs to a=
void
             file/directory conflicts, which is not necessary anymore.
    =20
    +      - We can properly enumerate all refs. With the "files" backend i=
t is
    +        not easily possible to distinguish between refs and non-refs b=
ecause
    +        they may live side by side in the gitdir.
    +
         Not all of these improvements are realized with the current "refta=
ble"
         backend implementation. At this point, the new backend is supposed=
 to be
         a drop-in replacement for the "files" backend that is used by basi=
cally
    @@ Commit message
             workloads we would likely also want to perform pack loose refs,
             which would likely change the picture.
    =20
    -            Benchmark 1: update-ref: create refs sequentially (refform=
at =3D files)
    +            Benchmark 1: update-ref: create refs sequentially (refform=
at =3D files, refcount =3D 1)
                   Time (mean =C2=B1 =CF=83):       2.1 ms =C2=B1   0.3 ms =
   [User: 0.6 ms, System: 1.7 ms]
                   Range (min =E2=80=A6 max):     1.8 ms =E2=80=A6   4.3 ms=
    133 runs
    =20
    -            Benchmark 2: update-ref: create refs sequentially (refform=
at =3D reftable)
    +            Benchmark 2: update-ref: create refs sequentially (refform=
at =3D reftable, refcount =3D 1)
                   Time (mean =C2=B1 =CF=83):       2.7 ms =C2=B1   0.1 ms =
   [User: 0.6 ms, System: 2.2 ms]
                   Range (min =E2=80=A6 max):     2.4 ms =E2=80=A6   2.9 ms=
    132 runs
    =20
    -            Benchmark 3: update-ref: create refs sequentially (refform=
at =3D files)
    +            Benchmark 3: update-ref: create refs sequentially (refform=
at =3D files, refcount =3D 1000)
                   Time (mean =C2=B1 =CF=83):      1.975 s =C2=B1  0.006 s =
   [User: 0.437 s, System: 1.535 s]
                   Range (min =E2=80=A6 max):    1.969 s =E2=80=A6  1.980 s=
    3 runs
    =20
    -            Benchmark 4: update-ref: create refs sequentially (refform=
at =3D reftable)
    +            Benchmark 4: update-ref: create refs sequentially (refform=
at =3D reftable, refcount =3D 1000)
                   Time (mean =C2=B1 =CF=83):      2.611 s =C2=B1  0.013 s =
   [User: 0.782 s, System: 1.825 s]
                   Range (min =E2=80=A6 max):    2.597 s =E2=80=A6  2.622 s=
    3 runs
    =20
    -            Benchmark 5: update-ref: create refs sequentially (refform=
at =3D files)
    +            Benchmark 5: update-ref: create refs sequentially (refform=
at =3D files, refcount =3D 100000)
                   Time (mean =C2=B1 =CF=83):     198.442 s =C2=B1  0.241 s=
    [User: 43.051 s, System: 155.250 s]
                   Range (min =E2=80=A6 max):   198.189 s =E2=80=A6 198.670=
 s    3 runs
    =20
    -            Benchmark 6: update-ref: create refs sequentially (refform=
at =3D reftable)
    +            Benchmark 6: update-ref: create refs sequentially (refform=
at =3D reftable, refcount =3D 100000)
                   Time (mean =C2=B1 =CF=83):     294.509 s =C2=B1  4.269 s=
    [User: 104.046 s, System: 190.326 s]
                   Range (min =E2=80=A6 max):   290.223 s =E2=80=A6 298.761=
 s    3 runs
    =20
    @@ refs/reftable-backend.c (new)
     +#include "../git-compat-util.h"
     +#include "../abspath.h"
     +#include "../chdir-notify.h"
    -+#include "../config.h"
     +#include "../environment.h"
     +#include "../gettext.h"
     +#include "../hash.h"
    @@ refs/reftable-backend.c (new)
     +#include "../reftable/reftable-stack.h"
     +#include "../reftable/reftable-record.h"
     +#include "../reftable/reftable-error.h"
    -+#include "../reftable/reftable-blocksource.h"
    -+#include "../reftable/reftable-reader.h"
     +#include "../reftable/reftable-iterator.h"
     +#include "../reftable/reftable-merged.h"
    -+#include "../reftable/reftable-generic.h"
     +#include "../setup.h"
     +#include "../strmap.h"
    -+#include "../worktree.h"
     +#include "refs-internal.h"
     +
     +/*
    @@ refs/reftable-backend.c (new)
     +struct reftable_ref_store {
     +	struct ref_store base;
     +
    ++	/*
    ++	 * The main stack refers to the common dir and thus contains common
    ++	 * refs as well as refs of the main repository.
    ++	 */
     +	struct reftable_stack *main_stack;
    ++	/*
    ++	 * The worktree stack refers to the gitdir in case the refdb is open=
ed
    ++	 * via a worktree. It thus contains the per-worktree refs.
    ++	 */
     +	struct reftable_stack *worktree_stack;
    ++	/*
    ++	 * Map of worktree stacks by their respective worktree names. The map
    ++	 * is populated lazily when we try to resolve `worktrees/$worktree` =
refs.
    ++	 */
     +	struct strmap worktree_stacks;
     +	struct reftable_write_options write_options;
     +
    @@ refs/reftable-backend.c (new)
     +	/*
     +	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
     +	 * This stack contains both the shared and the main worktree refs.
    ++	 *
    ++	 * Note that we don't try to resolve the path in case we have a
    ++	 * worktree because `get_common_dir_noenv()` already does it for us.
     +	 */
     +	is_worktree =3D get_common_dir_noenv(&path, gitdir);
     +	if (!is_worktree) {
    @@ refs/reftable-backend.c (new)
     +	/*
     +	 * If we're in a worktree we also need to set up the worktree reftab=
le
     +	 * stack that is contained in the per-worktree GIT_DIR.
    ++	 *
    ++	 * Ideally, we would also add the stack to our worktree stack map. B=
ut
    ++	 * we have no way to figure out the worktree name here and thus can't
    ++	 * do it efficiently.
     +	 */
     +	if (is_worktree) {
     +		strbuf_reset(&path);
    @@ refs/reftable-backend.c (new)
     +		}
     +
     +		 /*
    -+		  * Otherwise, if we either have no worktree refs anymore or if
    -+		  * the common ref sorts before the next worktree ref, we need
    -+		  * to figure out whether the next common ref belongs to the
    -+		  * main worktree. In that case, it should be ignored.
    ++		  * We now know that the lexicographically-next ref is a common
    ++		  * ref. When the common ref is a shared one we return it.
     +		  */
     +		if (parse_worktree_ref(iter_common->refname, NULL, NULL,
     +				       NULL) =3D=3D REF_WORKTREE_SHARED)
     +			return ITER_SELECT_1;
     +
    ++		/*
    ++		 * Otherwise, if the common ref is a per-worktree ref we skip
    ++		 * it because it would belong to the main worktree, not ours.
    ++		 */
     +		return ITER_SKIP_1;
     +	} else {
     +		return ITER_DONE;
    @@ refs/reftable-backend.c (new)
     +		}
     +
     +		if (u->type & REF_ISSYMREF) {
    ++			/*
    ++			 * The reftable stack is locked at this point already,
    ++			 * so it is safe to call `refs_resolve_ref_unsafe()`
    ++			 * here without causing races.
    ++			 */
     +			const char *resolved =3D refs_resolve_ref_unsafe(&refs->base, u->r=
efname, 0,
     +								       &current_oid, NULL);
     +
     +			if (u->flags & REF_NO_DEREF) {
    -+				/*
    -+				 * The reftable stack is locked at this point
    -+				 * already, so it should be safe to call
    -+				 * `refs_resolve_ref_unsafe()` here.
    -+				 */
     +				if (u->flags & REF_HAVE_OLD && !resolved) {
     +					strbuf_addf(err, _("cannot lock ref '%s': "
     +						    "error reading reference"), u->refname);
    @@ refs/reftable-backend.c (new)
     +				ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
     +				tombstone =3D &logs[logs_nr++];
     +				tombstone->refname =3D xstrdup(u->refname);
    -+				tombstone->value_type =3D REFTABLE_LOG_DELETION,
    ++				tombstone->value_type =3D REFTABLE_LOG_DELETION;
     +				tombstone->update_index =3D log.update_index;
     +			}
     +
    @@ refs/reftable-backend.c (new)
     +
     +	/*
     +	 * When deleting the old reference we have to use two update indices:
    -+	 * one to delete the old ref and its reflog, and once to create the =
new
    -+	 * ref and its reflog. They need to be staged with two separate indi=
ces
    -+	 * because the new reflog needs to encode both the deletion of the o=
ld
    -+	 * branch and the creation of the new branch, and we cannot do two
    -+	 * changes to a reflog in a single update.
    ++	 * once to delete the old ref and its reflog, and once to create the
    ++	 * new ref and its reflog. They need to be staged with two separate
    ++	 * indices because the new reflog needs to encode both the deletion =
of
    ++	 * the old branch and the creation of the new branch, and we cannot =
do
    ++	 * two changes to a reflog in a single update.
     +	 */
     +	deletion_ts =3D creation_ts =3D reftable_stack_next_update_index(arg=
->stack);
     +	if (arg->delete_old)
    @@ refs/reftable-backend.c (new)
     +	struct reftable_reflog_iterator *iter =3D
     +		(struct reftable_reflog_iterator *)ref_iterator;
     +
    -+	if (iter->err) {
    -+		ref_iterator_abort(ref_iterator);
    -+		return iter->err;
    -+	}
    -+
    -+	while (1) {
    -+		int flags, ret;
    ++	while (!iter->err) {
    ++		int flags;
     +
    -+		ret =3D reftable_iterator_next_log(&iter->iter, &iter->log);
    -+		if (ret < 0) {
    -+			ref_iterator_abort(ref_iterator);
    -+			return ITER_ERROR;
    -+		}
    -+		if (ret > 0) {
    -+			if (ref_iterator_abort(ref_iterator) !=3D ITER_DONE)
    -+				return ITER_ERROR;
    -+			return ITER_DONE;
    -+		}
    ++		iter->err =3D reftable_iterator_next_log(&iter->iter, &iter->log);
    ++		if (iter->err)
    ++			break;
     +
     +		/*
     +		 * We want the refnames that we have reflogs for, so we skip if
    @@ refs/reftable-backend.c (new)
     +		iter->base.refname =3D iter->log.refname;
     +		iter->base.oid =3D &iter->oid;
     +		iter->base.flags =3D flags;
    -+		return ITER_OK;
    ++
    ++		break;
     +	}
    ++
    ++	if (iter->err > 0) {
    ++		if (ref_iterator_abort(ref_iterator) !=3D ITER_DONE)
    ++			return ITER_ERROR;
    ++		return ITER_DONE;
    ++	}
    ++
    ++	if (iter->err < 0) {
    ++		ref_iterator_abort(ref_iterator);
    ++		return ITER_ERROR;
    ++	}
    ++
    ++	return ITER_OK;
     +}
     +
     +static int reftable_reflog_iterator_peel(struct ref_iterator *ref_ite=
rator,
    @@ refs/reftable-backend.c (new)
     +static struct reftable_reflog_iterator *reflog_iterator_for_stack(str=
uct reftable_ref_store *refs,
     +								  struct reftable_stack *stack)
     +{
    ++	struct reftable_merged_table *merged_table;
     +	struct reftable_reflog_iterator *iter;
    -+	struct reftable_merged_table *mt;
     +	int ret;
     +
     +	iter =3D xcalloc(1, sizeof(*iter));
    @@ refs/reftable-backend.c (new)
     +	iter->refs =3D refs;
     +	iter->base.oid =3D &iter->oid;
     +
    ++	ret =3D refs->err;
    ++	if (ret)
    ++		goto done;
    ++
     +	ret =3D reftable_stack_reload(refs->main_stack);
     +	if (ret < 0)
     +		goto done;
     +
    -+	mt =3D reftable_stack_merged_table(stack);
    -+	ret =3D reftable_merged_table_seek_log(mt, &iter->iter, "");
    ++	merged_table =3D reftable_stack_merged_table(stack);
    ++
    ++	ret =3D reftable_merged_table_seek_log(merged_table, &iter->iter, ""=
);
     +	if (ret < 0)
     +		goto done;
     +
    @@ refs/reftable-backend.c (new)
     +					iterator_select, NULL);
     +}
     +
    ++static int yield_log_record(struct reftable_log_record *log,
    ++			    each_reflog_ent_fn fn,
    ++			    void *cb_data)
    ++{
    ++	struct object_id old_oid, new_oid;
    ++	const char *full_committer;
    ++
    ++	oidread(&old_oid, log->value.update.old_hash);
    ++	oidread(&new_oid, log->value.update.new_hash);
    ++
    ++	/*
    ++	 * When both the old object ID and the new object ID are null
    ++	 * then this is the reflog existence marker. The caller must
    ++	 * not be aware of it.
    ++	 */
    ++	if (is_null_oid(&old_oid) && is_null_oid(&new_oid))
    ++		return 0;
    ++
    ++	full_committer =3D fmt_ident(log->value.update.name, log->value.upda=
te.email,
    ++				   WANT_COMMITTER_IDENT, NULL, IDENT_NO_DATE);
    ++	return fn(&old_oid, &new_oid, full_committer,
    ++		  log->value.update.time, log->value.update.tz_offset,
    ++		  log->value.update.message, cb_data);
    ++}
    ++
     +static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *=
ref_store,
     +						   const char *refname,
     +						   each_reflog_ent_fn fn,
    @@ refs/reftable-backend.c (new)
     +	mt =3D reftable_stack_merged_table(stack);
     +	ret =3D reftable_merged_table_seek_log(mt, &it, refname);
     +	while (!ret) {
    -+		struct object_id old_oid, new_oid;
    -+		const char *full_committer;
    -+
     +		ret =3D reftable_iterator_next_log(&it, &log);
     +		if (ret < 0)
     +			break;
    @@ refs/reftable-backend.c (new)
     +			break;
     +		}
     +
    -+		oidread(&old_oid, log.value.update.old_hash);
    -+		oidread(&new_oid, log.value.update.new_hash);
    -+
    -+		/*
    -+		 * When both the old object ID and the new object ID are null
    -+		 * then this is the reflog existence marker. The caller must
    -+		 * not be aware of it.
    -+		 */
    -+		if (is_null_oid(&old_oid) && is_null_oid(&new_oid))
    -+			continue;
    -+
    -+		full_committer =3D fmt_ident(log.value.update.name, log.value.updat=
e.email,
    -+					   WANT_COMMITTER_IDENT, NULL, IDENT_NO_DATE);
    -+		ret =3D fn(&old_oid, &new_oid, full_committer,
    -+			 log.value.update.time, log.value.update.tz_offset,
    -+			 log.value.update.message, cb_data);
    ++		ret =3D yield_log_record(&log, fn, cb_data);
     +		if (ret)
     +			break;
     +	}
    @@ refs/reftable-backend.c (new)
     +
     +		ret =3D reftable_iterator_next_log(&it, &log);
     +		if (ret < 0)
    -+			break;
    ++			goto done;
     +		if (ret > 0 || strcmp(log.refname, refname)) {
     +			reftable_log_record_release(&log);
     +			ret =3D 0;
    @@ refs/reftable-backend.c (new)
     +	}
     +
     +	for (i =3D logs_nr; i--;) {
    -+		struct reftable_log_record *log =3D &logs[i];
    -+		struct object_id old_oid, new_oid;
    -+		const char *full_committer =3D "";
    -+
    -+		oidread(&old_oid, log->value.update.old_hash);
    -+		oidread(&new_oid, log->value.update.new_hash);
    -+
    -+		/*
    -+		 * When both the old object ID and the new object ID are null
    -+		 * then this is the reflog existence marker. The caller must
    -+		 * not be aware of it.
    -+		 */
    -+		if (is_null_oid(&old_oid) && is_null_oid(&new_oid))
    -+			continue;
    -+
    -+		full_committer =3D fmt_ident(log->value.update.name, log->value.upd=
ate.email,
    -+					   WANT_COMMITTER_IDENT, NULL, IDENT_NO_DATE);
    -+		ret =3D fn(&old_oid, &new_oid, full_committer,
    -+			 log->value.update.time, log->value.update.tz_offset,
    -+			 log->value.update.message, cb_data);
    ++		ret =3D yield_log_record(&logs[i], fn, cb_data);
     +		if (ret)
    -+			break;
    ++			goto done;
     +	}
     +
    ++done:
     +	reftable_iterator_destroy(&it);
     +	for (i =3D 0; i < logs_nr; i++)
     +		reftable_log_record_release(&logs[i]);
    @@ refs/reftable-backend.c (new)
     +		goto done;
     +
     +	ret =3D reftable_stack_reload(stack);
    -+	if (ret)
    ++	if (ret < 0)
     +		goto done;
     +
     +	ret =3D reftable_merged_table_seek_log(mt, &it, refname);
    -+	if (ret)
    ++	if (ret < 0)
     +		goto done;
     +
     +	/*
    -+	 * Seek the reflog to see whether it contains any reflog entries whi=
ch
    -+	 * aren't marked for deletion.
    ++	 * Check whether we get at least one log record for the given ref na=
me.
    ++	 * If so, the reflog exists, otherwise it doesn't.
     +	 */
    -+	while (1) {
    -+		ret =3D reftable_iterator_next_log(&it, &log);
    -+		if (ret < 0)
    -+			goto done;
    -+		if (ret > 0 || strcmp(log.refname, refname)) {
    -+			ret =3D 0;
    -+			goto done;
    -+		}
    -+
    -+		ret =3D 1;
    -+		break;
    ++	ret =3D reftable_iterator_next_log(&it, &log);
    ++	if (ret < 0)
    ++		goto done;
    ++	if (ret > 0) {
    ++		ret =3D 0;
    ++		goto done;
     +	}
     +
    ++	ret =3D strcmp(log.refname, refname) =3D=3D 0;
    ++
     +done:
     +	reftable_iterator_destroy(&it);
     +	reftable_log_record_release(&log);
    @@ refs/reftable-backend.c (new)
     +			break;
     +		}
     +
    -+		tombstone.refname =3D (char *)arg->refname,
    -+		tombstone.value_type =3D REFTABLE_LOG_DELETION,
    ++		tombstone.refname =3D (char *)arg->refname;
    ++		tombstone.value_type =3D REFTABLE_LOG_DELETION;
     +		tombstone.update_index =3D log.update_index;
     +
     +		ret =3D reftable_writer_add_log(writer, &tombstone);
2:  bb694fa132 =3D 2:  63eafc9f5b ci: add jobs to test with the reftable ba=
ckend
--=20
2.43.GIT


--GuXJXIQdxPEWftCR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW8qgAACgkQVbJhu7ck
PpTApw/+JVFb8Mm9jwkq+FoKCzbk6VO5BgXyVHQzStAiHe1M6IyWGD/D+ZFE39Fg
jf6/TWdPryw0y4rt3WrJt6AiwIt1x27ojlvVBvcMQkEr8Mzud5o5HUGWhBsYLCM9
zwCxiMd1BC0C2mPPGjzB+8o9EwYQWeVy/5cH+E/RECefU6bBSMgTQ7VMHIgu/Hn+
IKzs1VFCmBdTJieJanrutEVZafvVkiLRGSL63LV7xltZvC/ynnH+7S4UwgPK4Q3b
C2kOGyxKAuzEtECB/d6txOwKDHAjgkTpdj+03kXTC7uPsYooa7CaYMlIS9qI5QfL
107VJQ00W4u+j2tWGfp8lwcHPLGSTCAv1x0qryGSBodLXKIQsErAtfVAzX9cOWWd
z8pvTp4e++kAoRVOSwZLJNkiZE0HpBcObPcukZXv3ZvVzcVqmlSwZNRpF27LUrnt
FvlKZmKwEBfkhBM44H8SBNzJAbV29whCu/dusbEBVxeE+DtI0s5nSibC/pGPLHj4
tBKurTzC6JTVIB/Pi8FVTgZkXen48smGsnU/5hoA25ytuBCzycOxrqsarhdrNIBt
+DzUrKI8CFhrt4M2VGWmgZSBwijNLUb96SYRl5nLGdAqoUzEGxkUQIMoZuS6gQ9I
uYF36PK2Q8+ORo4BOivtneu6GgDk9K0dzzfMwBo/tKPvAV8R0Cw=
=sFnG
-----END PGP SIGNATURE-----

--GuXJXIQdxPEWftCR--
