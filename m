Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDD8C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 13:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbiBQNEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 08:04:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240639AbiBQNEe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 08:04:34 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB362A8D31
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 05:04:19 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7A5E23201E88;
        Thu, 17 Feb 2022 08:04:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 17 Feb 2022 08:04:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to; s=fm3; bh=y
        nLZLWB6NF/oLmoS7xHEWxzsK9SguniZSsxnsNfWUQk=; b=I+WTN3qcNsb4sLfYZ
        Mrs1BFdEZIVRCeJiaediz0V+kvO0dRNP9iuhpMTFTVLiWTi7vi8SX0YWB9PBhiBj
        ZXL6/kCt9pNEn4hc08EJ611SJun0xbUTkz24gevYSXAIjBO+0NZTP26NMxO7WS1t
        xP4CBNCk7DQOgcjxJVJRv8ul5SieVYIgVCfheZcliQfIclVjPj7lRh08TuwTv0yc
        OZ/htBPbnd2JhAeAPRreIhm0Yg/Dou6Ew6n/TlmX5sbK7eut3cXgMoilAhrgAVVy
        9SYRiny4wPJWY6mpEdDlExkorrAoYQvpMWv4IFZvntkJqx9a+quxkFZoh2rmRyMy
        ZL4Jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=ynLZLWB6NF/oLmoS7xHEWxzsK9SguniZSsxnsNfWU
        Qk=; b=O1UGHiJDeRRIoTaCWhio4s1puU3PnR9HUJ+ySDp16BpMiFaSPBA4xAutK
        68lMcJ7IxKFqFaGNRyBaxuD+IZ01ZuwUwS63iqvdBB+Da5CjEE5XTOt3DEMsPlku
        2Nt+Khe92/EpF8voAN2ZX7nviKARcbOjc2umCqJb0dQgrgXjRWXSril4hJzxQt5r
        jXNzUWCOgBACzUPbxZJ5CNFgmDyqCRZiVgO79SBY8L0E4wWzaYZ94NQZiXEfKNx/
        1mGpCUAeuN3vu4q/kL5RGgH9daZRxrgb5BpmO+cYlZp/+jnrnXr0De9IT079w6NN
        lbP7UbdbqV9OHfki3MhjPoZM6hQtQ==
X-ME-Sender: <xms:z0cOYosC6XgljpSV9nryS8eiBscaR5aXrvCDy1OqNP23jrCkW6qspA>
    <xme:z0cOYlcTmf2dNDFm-oudt-Gn5N1j1HW7mq8kXPL0Nfy34ANWUsC9cQkRtHH9Wsw8b
    wvMGDFsHW3ESVsC7Q>
X-ME-Received: <xmr:z0cOYjy-Ib9VIjCNrQnBv8NhFergfGpt-RQPrONr69BR1T7Bw0Gj_Hi4felRx9vXxy33J__G_8EsED-eiZuOIVQ124_nD75pyC8kI45pDvdLyKj9j64nGZk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepje
    eifedvueelfffgjeduffdvgefhiefgjefgvddvfeduvefffeevfffhgfekieffnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:z0cOYrNTe17VtmJoqNSl3_yp_H9HUbNeJWv5gzq989NUDBe6baH2IA>
    <xmx:z0cOYo85_aYrah5iQnpQdIrOAOJl-aq4zwa-GDVQS1BvAy9fdNMmUg>
    <xmx:z0cOYjWYQi5uK2xqDWRf9sj3f8QE7VPsSJGoaDGrV--JJ6VYyxt47Q>
    <xmx:0EcOYqJJ2qy2o4K6K1ixGcx6ynVoXmgfueJrlPjuj3PLi-XFIBou6w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 08:04:14 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 542e58f9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 13:04:13 +0000 (UTC)
Date:   Thu, 17 Feb 2022 14:04:11 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/7] fetch: improve atomicity of `--atomic` flag
Message-ID: <cover.1645102965.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qA08DMnHQF0MnBYW"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qA08DMnHQF0MnBYW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

in c7b190dabd (fetch: implement support for atomic reference updates,
2021-01-12), I have added a new `--atomic` flag to git-fetch(1) which is
supposed to make it an all-or-nothing operation: either all refs are
updated, or none is. I have recently discovered though that there were
two oversights: neither pruning of refs via `--prune` nor the tag
backfill mechanism are currently covered by this flag, which breaks the
promise.

This is the second version of my patch series which fixes these
problems. Due to a semantic conflict with
ps/avoid-unnecessary-hook-invocation-with-packed-refs and a textual
conflict with c9e04d905e (fetch --prune: exit with error if pruning
fails, 2022-01-31) it now applies on top of the former branch merged
with 45fe28c951 (The fourth batch, 2022-02-16).

Changes compared to v1:

    - Commit messages have been improved.

    - A code comment has been fixed to not talk about the past anymore,
      but instead state what the section of code is supposed to do.

    - I have introduced a new patch 5/7 which provides an interface to
      access queued updates in reference transactions without requiring
      access to "refs/refs-internal.h".

    - Removed unnecessary shebangs in tests when using `write_script`.

    - Rebased the series to fix a conflict with c9e04d905e, mentioned
      above.

Thanks for all the feedback!

Patrick

Patrick Steinhardt (7):
  fetch: increase test coverage of fetches
  fetch: backfill tags before setting upstream
  fetch: control lifecycle of FETCH_HEAD in a single place
  fetch: report errors when backfilling tags fails
  refs: add interface to iterate over queued transactional updates
  fetch: make `--atomic` flag cover backfilling of tags
  fetch: make `--atomic` flag cover pruning of refs

 builtin/fetch.c      | 192 +++++++++++++++++++++++++++++--------------
 refs.c               |  16 ++++
 refs.h               |  14 ++++
 t/t5503-tagfollow.sh |  74 +++++++++++++++++
 t/t5510-fetch.sh     |  29 +++++++
 5 files changed, 263 insertions(+), 62 deletions(-)

Range-diff against v1:
1:  e133c14f56 ! 1:  b4ca3f1f3b fetch: increase test coverage of fetches
    @@ Metadata
      ## Commit message ##
         fetch: increase test coverage of fetches
    =20
    -    The `--atomic` flag is missing test coverage for pruning of deleted
    -    references and backfilling of tags, and of course both aren't cove=
red
    -    correctly by this flag. Furthermore, we don't have tests demonstra=
ting
    -    error cases for backfilling tags.
    +    When using git-fetch(1) with the `--atomic` flag the expectation i=
s that
    +    either all of the references are updated, or alternatively none ar=
e in
    +    case the fetch fails. While we already have tests for this, we do =
not
    +    have any tests which exercise atomicity either when pruning delete=
d refs
    +    or when backfilling tags. This gap in test coverage hides that we =
indeed
    +    don't handle atomicity correctly for both of these cases.
    =20
    -    Add tests to cover those testing gaps.
    +    Add test cases which cover these testing gaps to demonstrate the b=
roken
    +    behaviour. Note that tests are not marked as `test_expect_failure`=
: this
    +    is done to explicitly demonstrate the current known-wrong behaviou=
r, and
    +    they will be fixed up as soon as we fix the underlying bugs.
    +
    +    While at it this commit also adds another test case which demonstr=
ates
    +    that backfilling of tags does not return an error code in case the
    +    backfill fails. This bug will also be fixed by a subsequent commit.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ t/t5503-tagfollow.sh: test_expect_success 'new clone fetch main and =
tags' '
     +	#
     +	# To trigger failure we simply abort when backfilling a tag.
     +	write_script clone3/.git/hooks/reference-transaction <<-\EOF &&
    -+		#!/bin/sh
    -+
     +		while read oldrev newrev reference
     +		do
     +			if test "$reference" =3D refs/tags/tag1
    @@ t/t5503-tagfollow.sh: test_expect_success 'new clone fetch main and =
tags' '
     +	test_must_fail git -C clone3 fetch --atomic .. $B:refs/heads/somethi=
ng &&
     +
     +	# Creation of the tag has failed, so ideally refs/heads/something
    -+	# should not exist. The fact that it does is demonstrates that there=
 is
    -+	# missing coverage in the `--atomic` flag.
    ++	# should not exist. The fact that it does demonstrates that there is
    ++	# a bug in the `--atomic` flag.
     +	test $B =3D "$(git -C clone3 rev-parse --verify refs/heads/something=
)"
     +'
     +
    @@ t/t5503-tagfollow.sh: test_expect_success 'new clone fetch main and =
tags' '
     +	git init clone5 &&
     +
     +	write_script clone5/.git/hooks/reference-transaction <<-EOF &&
    -+		#!/bin/sh
    -+
     +		while read oldrev newrev reference
     +		do
     +			if test "\$reference" =3D refs/tags/tag1
2:  64c94e7a28 ! 2:  b0a067bbc1 fetch: backfill tags before setting upstream
    @@ Commit message
             4. We backfill tags pointing into the history we have just fet=
ched.
    =20
         It is quite confusing that we fetch objects and update references =
in
    -    both (2) and (4), which is further stressed by the point that we r=
equire
    -    a `skip` label which jumps from (3) to (4) in case we fail to upda=
te the
    +    both (2) and (4), which is further stressed by the point that we u=
se a
    +    `skip` goto label to jump from (3) to (4) in case we fail to updat=
e the
         gitconfig as expected.
    =20
         Reorder the code to first update all local references, and only af=
ter we
    @@ builtin/fetch.c: static void backfill_tags(struct transport *transpo=
rt, struct r
      	int retcode =3D 0;
      	const struct ref *remote_refs;
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
    - 		}
    + 			retcode =3D 1;
      	}
      	if (fetch_and_consume_refs(transport, ref_map, worktrees)) {
     -		free_refs(ref_map);
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      		goto cleanup;
      	}
     =20
    -+	/* if neither --no-tags nor --tags was specified, do automated tag
    -+	 * following ... */
    ++	/*
    ++	 * If neither --no-tags nor --tags was specified, do automated tag
    ++	 * following.
    ++	 */
     +	if (tags =3D=3D TAGS_DEFAULT && autotags) {
     +		struct ref *tags_ref_map =3D NULL, **tail =3D &tags_ref_map;
     +
3:  4059d5034b ! 3:  0b9d04622d fetch: control lifecycle of FETCH_HEAD in a=
 single place
    @@ Commit message
         which is essentially duplicate work.
    =20
         Improve the lifecycle of updating FETCH_HEAD by opening and commit=
ting
    -    it once in `do_fetch()`, where we pass the structure down to code =
which
    -    wants to append to it.
    +    it once in `do_fetch()`, where we pass the structure down to the c=
ode
    +    which wants to append to it.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
      	if (prune) {
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
    - 				   transport->url);
    - 		}
    + 		if (retcode !=3D 0)
    + 			retcode =3D 1;
      	}
     -	if (fetch_and_consume_refs(transport, ref_map, worktrees)) {
     +
4:  54fdee845b ! 4:  bc1e396ae0 fetch: report errors when backfilling tags =
fails
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     -			backfill_tags(transport, tags_ref_map, &fetch_head, worktrees);
     +		if (tags_ref_map) {
     +			/*
    -+			 * If backfilling tags succeeds we used to not return
    -+			 * an error code to the user at all. Instead, we
    -+			 * silently swallowed that error and updated the local
    -+			 * state of the repository. We now notify the user of
    -+			 * any such errors, but we continue to make sure that
    -+			 * FETCH_HEAD and the upstream branch are configured as
    -+			 * expected.
    ++			 * If backfilling of tags fails then we want to tell
    ++			 * the user so, but we have to continue regardless to
    ++			 * populate upstream information of the references we
    ++			 * have already fetched above.
     +			 */
     +			if (backfill_tags(transport, tags_ref_map, &fetch_head, worktrees))
     +				retcode =3D 1;
-:  ---------- > 5:  fac2e3555a refs: add interface to iterate over queued =
transactional updates
5:  55dbe19a1a ! 6:  331ee40e57 fetch: make `--atomic` flag cover backfilli=
ng of tags
    @@ Commit message
         Note that we also have to start passing the transaction into
         `find_non_local_tags()`: this function is responsible for finding =
all
         tags which we need to backfill. Right now, it will happily return =
tags
    -    which we have already been updated with our local references. But =
when
    -    we use a single transaction for both local references and backfill=
ing
    -    then it may happen that we try to queue the same reference update =
twice
    -    to the transaction, which consequentially triggers a bug. We thus =
have
    -    to skip over any tags which have already been queued. Unfortunatel=
y,
    -    this requires us to reach into internals of the reference transact=
ion to
    -    access queued updates, but there is no non-internal interface righ=
t now
    -    which would allow us to access this information.
    +    which have already been updated with our local references. But whe=
n we
    +    use a single transaction for both local references and backfilling=
 then
    +    it may happen that we try to queue the same reference update twice=
 to
    +    the transaction, which consequently triggers a bug. We thus have t=
o skip
    +    over any tags which have already been queued.
    =20
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
    =20
      ## builtin/fetch.c ##
    -@@
    - #include "cache.h"
    - #include "config.h"
    - #include "repository.h"
    --#include "refs.h"
    -+#include "refs/refs-internal.h"
    - #include "refspec.h"
    - #include "object-store.h"
    - #include "oidset.h"
     @@ builtin/fetch.c: static void clear_item(struct refname_hash_entry *=
item)
    + 	item->ignore =3D 1;
      }
     =20
    ++
    ++static void add_already_queued_tags(const char *refname,
    ++				    const struct object_id *old_oid,
    ++				    const struct object_id *new_oid,
    ++				    void *cb_data)
    ++{
    ++	struct hashmap *queued_tags =3D cb_data;
    ++	if (starts_with(refname, "refs/tags/") && new_oid)
    ++		(void) refname_hash_add(queued_tags, refname, new_oid);
    ++}
    ++
      static void find_non_local_tags(const struct ref *refs,
     +				struct ref_transaction *transaction,
      				struct ref **head,
      				struct ref ***tail)
      {
     @@ builtin/fetch.c: static void find_non_local_tags(const struct ref *=
refs,
    - 	const struct ref *ref;
    - 	struct refname_hash_entry *item =3D NULL;
    - 	const int quick_flags =3D OBJECT_INFO_QUICK | OBJECT_INFO_SKIP_FETCH=
_OBJECT;
    -+	int i;
    -=20
    - 	refname_hash_init(&existing_refs);
    - 	refname_hash_init(&remote_refs);
      	create_fetch_oidset(head, &fetch_oids);
     =20
      	for_each_ref(add_one_refname, &existing_refs);
    @@ builtin/fetch.c: static void find_non_local_tags(const struct ref *r=
efs,
     +	 * If we already have a transaction, then we need to filter out all
     +	 * tags which have already been queued up.
     +	 */
    -+	for (i =3D 0; transaction && i < transaction->nr; i++) {
    -+		if (!starts_with(transaction->updates[i]->refname, "refs/tags/") ||
    -+		    !(transaction->updates[i]->flags & REF_HAVE_NEW))
    -+			continue;
    -+		(void) refname_hash_add(&existing_refs,
    -+					transaction->updates[i]->refname,
    -+					&transaction->updates[i]->new_oid);
    -+	}
    -+
    ++	if (transaction)
    ++		ref_transaction_for_each_queued_update(transaction,
    ++						       add_already_queued_tags,
    ++						       &existing_refs);
     +
      	for (ref =3D refs; ref; ref =3D ref->next) {
      		if (!starts_with(ref->name, "refs/tags/"))
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
      	if (prune) {
     @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
    - 		}
    + 			retcode =3D 1;
      	}
     =20
     -	if (fetch_and_consume_refs(transport, ref_map, &fetch_head, worktree=
s)) {
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
     +		find_non_local_tags(remote_refs, transaction, &tags_ref_map, &tail);
      		if (tags_ref_map) {
      			/*
    - 			 * If backfilling tags succeeds we used to not return
    -@@ builtin/fetch.c: static int do_fetch(struct transport *transport,
    - 			 * state of the repository. We now notify the user of
    - 			 * any such errors, but we continue to make sure that
    - 			 * FETCH_HEAD and the upstream branch are configured as
    --			 * expected.
    -+			 * expected. The exception though is when `--atomic`
    -+			 * is passed: in that case we'll abort the transaction
    -+			 * and don't commit anything.
    + 			 * If backfilling of tags fails then we want to tell
    + 			 * the user so, but we have to continue regardless to
    + 			 * populate upstream information of the references we
    +-			 * have already fetched above.
    ++			 * have already fetched above. The exception though is
    ++			 * when `--atomic` is passed: in that case we'll abort
    ++			 * the transaction and don't commit anything.
      			 */
     -			if (backfill_tags(transport, tags_ref_map, &fetch_head, worktrees))
     +			if (backfill_tags(transport, transaction, tags_ref_map,
    @@ t/t5503-tagfollow.sh: test_expect_success 'atomic fetch with failing=
 backfill' '
      	test_must_fail git -C clone3 fetch --atomic .. $B:refs/heads/somethi=
ng &&
     -
     -	# Creation of the tag has failed, so ideally refs/heads/something
    --	# should not exist. The fact that it does is demonstrates that there=
 is
    --	# missing coverage in the `--atomic` flag.
    +-	# should not exist. The fact that it does demonstrates that there is
    +-	# a bug in the `--atomic` flag.
     -	test $B =3D "$(git -C clone3 rev-parse --verify refs/heads/something=
)"
     +	test_must_fail git -C clone3 rev-parse --verify refs/heads/something=
 &&
     +	test_must_fail git -C clone3 rev-parse --verify refs/tags/tag2
6:  682f16117b ! 7:  2ad16530e5 fetch: make `--atomic` flag cover pruning o=
f refs
    @@ builtin/fetch.c: static int do_fetch(struct transport *transport,
      		 * don't care whether --tags was specified.
      		 */
      		if (rs->nr) {
    --			prune_refs(rs, ref_map, transport->url);
    -+			prune_refs(rs, transaction, ref_map, transport->url);
    +-			retcode =3D prune_refs(rs, ref_map, transport->url);
    ++			retcode =3D prune_refs(rs, transaction, ref_map, transport->url);
      		} else {
    - 			prune_refs(&transport->remote->fetch,
    --				   ref_map,
    -+				   transaction, ref_map,
    - 				   transport->url);
    + 			retcode =3D prune_refs(&transport->remote->fetch,
    +-					     ref_map,
    ++					     transaction, ref_map,
    + 					     transport->url);
      		}
    - 	}
    + 		if (retcode !=3D 0)
    =20
      ## t/t5510-fetch.sh ##
     @@ t/t5510-fetch.sh: test_expect_success 'fetch --atomic --prune execu=
tes a single reference transact
    + 	head_oid=3D$(git rev-parse HEAD) &&
    +=20
    + 	# Fetching with the `--atomic` flag should update all references in a
    +-	# single transaction. It is currently missing coverage of pruned
    +-	# references though, and as a result those may be committed to disk
    +-	# even if updating references fails later.
    ++	# single transaction.
      	cat >expected <<-EOF &&
      		prepared
      		$ZERO_OID $ZERO_OID refs/remotes/origin/scheduled-for-deletion
--=20
2.35.1


--qA08DMnHQF0MnBYW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOR8sACgkQVbJhu7ck
PpQ64hAAkY5JX0F+ak4XCWJelt2zFw5zbr7TyGjCKsMCvFQ05WICkpLlZ8ws3uGU
bP3yZTSlspNYnsO4Jwv/P4bYTR47eDhKOxhqjoYndi0wKkM4zcZUdDL63LuANjI1
pacwR6e6lmNJbJmqB0isFraZzsccVBYovLkGVPAw9rLl+AnuCHAWiAM6SDegq6Gd
Qa/HtEm574jmwlvAyKrDCTmHh1WsvY+sbZZ7tW0Njx8KrzM7O3d2mt1jAuH9iWzs
Tezdbg6mvAO7cADqaCT/kQU5e4zx0DmIU85bNImdAmp3GLaxzEYb5M0zCHd4sp4g
BxREcgLIoU3RXrAoSCSuuqQlR/idVUzWfRTDBVkeXb2T97jetRxrjM/AiUNy6AuG
jMjZKhHp+KcPLdnrAbfhY2c4XW3cQfm+t57ZPeIbkZ/QaRXFJHRLL6fMRXHL1lUr
Kqp9Aodu8/ZQV15hipWOaU7uqfdmSQvqDEJpQvT4N59tBX2MyT0+MVqFu7QJjhRQ
KsqHgkUgKXuBg7zWc8Ht7q9ZSdp6965WY93z7dEzTkgyiA2R6ubwpCqM5sA9yncV
HTjsWy8QUCCx/toCfBdlhJumvu9adoTh5JIEzir/ja7NIbx++I1+9Oo6O30Hj7Nr
w2Vog8HV6jA7cmVzJoMck85ez0DTGHaHc/bfXWvNyh5QtIWtNAo=
=dCE4
-----END PGP SIGNATURE-----

--qA08DMnHQF0MnBYW--
