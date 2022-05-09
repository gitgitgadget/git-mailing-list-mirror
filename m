Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C28EC4321E
	for <git@archiver.kernel.org>; Mon,  9 May 2022 06:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbiEIGcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 02:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiEIG3A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 02:29:00 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377BF13C4C9
        for <git@vger.kernel.org>; Sun,  8 May 2022 23:24:38 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D29C55C00E5;
        Mon,  9 May 2022 02:23:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 09 May 2022 02:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1652077419; x=1652163819; bh=peY4IYItXE
        unhBiD5C06443BiRR0coXqRKflSnhh/Pc=; b=MdOB7+5gNLwSAa7YQjCLhytBFc
        aqeFNw3V6Cj1lxBnPol3g72LsMEhJ332e3AHQHUIYt9cnMzw23FbBUKdVEW7eT3J
        uOtM5UDpwhn/A2cTeP4Q27z2g/dEaBUSxZOuxuJKO9lhwT/XdtmVsaXlLGFAqrRI
        n4NlgfzlpL6dz0d+kKsGV0A9w2Uxm2kY/shADyJPPdzVs43c79+OwQHhUvANjE51
        ngQ7J6BbG/mroypgyc82gwb6OoZhI2d1GhfE+MUEX5LNeOAtn1wxTlCR0l4/n8hv
        9n+Tb+z/FF89qmXFSeF91yAam9zByaKzZuFTQenRah8WidwewztrxunQgI0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1652077419; x=
        1652163819; bh=peY4IYItXEunhBiD5C06443BiRR0coXqRKflSnhh/Pc=; b=O
        GxOGgsRtURGuflmSo9gT+yFWMXMu8xLW0D6NpW07AbfxivlxARZ13PZjCy0lY3iI
        VLw4O5eKs1huUg3rpruyNNfpmBS0YFWSUrcZ7XyR/e2Zbd3mSyoNyGhueFaFqTNe
        f82Iz9ohHu7RLnRZEx1YxBlY3cj8MPBstKVmmZiLEDvO4fyIVhoP2OKLXCJklnAw
        ixBG/F0K//GKumxuXlupmhXy6iS/cKkCfSmdaw0ErDZlDRK0hCiZqu9CxKL5Q+7A
        HMxUxHaKgfG1DjJb/7yLtMpPizryyIESeBUr7mzsdfiOdXvGeaJcMKRyrdL9nK8V
        KJy2PFofurR+7CJ7FrIsA==
X-ME-Sender: <xms:a7N4YhDQVIWpOgnbDId-MTqlvNeBb73xrfITiUYMY_19mD-dxXVNAQ>
    <xme:a7N4YvgSwe5UttCGXxdp5eBZMNAHzx7KNvj5RmUikpBVhlsHIe9c3b-bJSmeHoVwK
    BUqNPIoH1vNZACCXg>
X-ME-Received: <xmr:a7N4Ysk7QKMU9GO7f690Gnz89OU7NPEYHTScp1dEyxbiClKCmVWC6ZIfTtnHRu6S4bY8NFt_Qyqyq_38l2mwBIBt-Jqe9f-hutrE7t_IJ4T2nC6fvTURyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeekgddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepleejteffveehgeegteekteeiudeiieeigeeigedtffehgeekhfejheefkefhveel
    necuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:a7N4Yrx2P-jtd6p7B0zitWDPgyt4Z0R6Pdz3_7rmBD1BA6HkiCJyAg>
    <xmx:a7N4YmQ6RqFpmRVnmdOuLLG9epAIHWpnIO7TdcWqjYiyjvtQHRbGKA>
    <xmx:a7N4YuZQc9D11ES5Ge8_eC_GSoQ26Yp519mMk7pKyNNU-HDvsvnwog>
    <xmx:a7N4YhewkLFxCGatwczOl_SvAcuRO9SIU3GTsCfWIbpqYfUe7sKZww>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 May 2022 02:23:38 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f1fcbd71 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 May 2022 06:23:36 +0000 (UTC)
Date:   Mon, 9 May 2022 08:23:35 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Michael Heemskerk via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Michael Heemskerk <mheemskerk@atlassian.com>
Subject: Re: [PATCH] refs: honor reference-transaction semantics when
 deleting refs
Message-ID: <YnizZ/a/hQ6hpRPB@ncase>
References: <pull.1228.git.1651676435634.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TTZOwBNSofy9sQwE"
Content-Disposition: inline
In-Reply-To: <pull.1228.git.1651676435634.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TTZOwBNSofy9sQwE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 04, 2022 at 03:00:35PM +0000, Michael Heemskerk via GitGitGadge=
t wrote:
> From: Michael Heemskerk <mheemskerk@atlassian.com>
>=20
> When deleting refs from the loose-files refs backend, files_delete_refs
> first rewrites packed-refs if any of the to-be-deleted refs were packed
> and then removes loose refs. While making those changes, it invokes the
> reference-transaction hook incorrectly; a single transaction is used to
> prepare and commit the changes to packed-refs, followed by another
> transaction per deleted ref, each with another prepared and committed
> reference-transaction hook invocation.
>=20
> This behaviour is problematic for a number of reasons. First of all,
> deleting a ref through `git branch -d` or `git tag -d` results in a
> different sequence of reference-transaction callbacks than deleting the
> same ref through `git update-ref`:
>=20
> - update-ref of a loose ref: aborted, prepared, committed
> - update-ref of a packed ref: prepared, prepared, committed, commited
> - branch -d: prepared, committed, aborted, prepared, committed
>=20
> The bigger problem is that the packed-refs update is committed before
> the prepared reference-transaction invocation is done for the loose
> ref. Returning a non-zero exit code from the second
> reference-transaction callback leads to an invalid sequence of
> reference-transaction callbacks:
>=20
> 1. prepared - hook returns 0, so the change is allowed to go through.
> 2. committed - git informs the hook that the changes are now final,
>    but are they really? Any loose refs may still survive if the
>    subsequent prepared callback is canceled.
> 3. aborted - 'fake' invocation from the packed-transaction because the
>    ref does not exist in packed-refs.
> 4. prepared - hook returns 1, so the change should be blocked.
> 5. aborted - git informs the hook that it has rolled back the change,
>    but it really hasn't; packed-refs has already been rewritten and
>    if the ref only existed as a packed ref, it is now gone.
>=20
> The changes to the reference-transaction invocations that were planned
> for git 2.36 but have been reverted make the problem more pronounced.
> Those changes suppress the 'fake' invocations for the packed-transaction
> (invocations 1-3 in the above list). In that case, the prepared callback
> in step 4 cannot prevent a ref from being deleted if it only existed in
> packed-refs.
>=20
> To address the issue, the use a separate transactions to update the
> packed and loose refs has been removed from files_delete_refs. Instead,
> it now uses a single transaction, queues up the refs-to-be-deleted and
> relies on the standard transaction mechanism to invoke the
> reference-transaction hooks as expected.
>=20
> Signed-off-by: Michael Heemskerk <mheemskerk@atlassian.com>
> ---
>     refs: honor reference-transaction semantics when deleting refs
>    =20
>     When deleting refs from the loose-files refs backend, files_delete_re=
fs
>     first rewrites packed-refs if any of the to-be-deleted refs were pack=
ed
>     and then removes loose refs. While making those changes, it invokes t=
he
>     reference-transaction hook incorrectly; a single transaction is used =
to
>     prepare and commit the changes to packed-refs, followed by another
>     transaction per deleted ref, each with another prepared and committed
>     reference-transaction hook invocation.
>    =20
>     This behaviour is problematic for a number of reasons. First of all,
>     deleting a ref through git branch -d or git tag -d results in a
>     different sequence of reference-transaction callbacks than deleting t=
he
>     same ref through git update-ref:
>    =20
>      * update-ref of a loose ref: aborted, prepared, committed
>      * update-ref of a packed ref: prepared, prepared, committed, commited
>      * branch -d: prepared, committed, aborted, prepared, committed
>    =20
>     The bigger problem is that the packed-refs update is committed before
>     the prepared reference-transaction invocation is done for the loose r=
ef.
>     Returning a non-zero exit code from the second reference-transaction
>     callback leads to an invalid sequence of reference-transaction
>     callbacks:
>    =20
>      1. prepared - hook returns 0, so the change is allowed to go through.
>      2. committed - git informs the hook that the changes are now final, =
but
>         are they really? Any loose refs may still survive if the subseque=
nt
>         prepared callback is canceled.
>      3. aborted - 'fake' invocation from the packed-transaction because t=
he
>         ref does not exist in packed-refs.
>      4. prepared - hook returns 1, so the change should be blocked.
>      5. aborted - git informs the hook that it has rolled back the change,
>         but it really hasn't; packed-refs has already been rewritten and =
if
>         the ref only existed as a packed ref, it is now gone.
>    =20
>     The changes to the reference-transaction invocations that were planned
>     for git 2.36 but have been reverted make the problem more pronounced.
>     Those changes suppress the 'fake' invocations for the packed-transact=
ion
>     (invocations 1-3 in the above list). In that case, the prepared callb=
ack
>     in step 4 cannot prevent a ref from being deleted if it only existed =
in
>     packed-refs.
>    =20
>     To address the issue, the use a separate transactions to update the
>     packed and loose refs has been removed from files_delete_refs. Instea=
d,
>     it now uses a single transaction, queues up the refs-to-be-deleted and
>     relies on the standard transaction mechanism to invoke the
>     reference-transaction hooks as expected.
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1228%2F=
mheemskerk%2Ffiles-delete-ref-reference-transaction-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1228/mheem=
skerk/files-delete-ref-reference-transaction-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1228
>=20
>  refs/files-backend.c             | 33 +++++++--------
>  t/t1416-ref-transaction-hooks.sh | 70 ++++++++++++++++++++++++++++++++
>  t/t5510-fetch.sh                 |  6 +--
>  3 files changed, 87 insertions(+), 22 deletions(-)
>=20
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 8db7882aacb..5c23277eda7 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -1265,44 +1265,39 @@ static int files_delete_refs(struct ref_store *re=
f_store, const char *msg,
>  	struct files_ref_store *refs =3D
>  		files_downcast(ref_store, REF_STORE_WRITE, "delete_refs");
>  	struct strbuf err =3D STRBUF_INIT;
> -	int i, result =3D 0;
> +	int i;
> +	struct ref_transaction *transaction;
> =20
>  	if (!refnames->nr)
>  		return 0;
> =20
> -	if (packed_refs_lock(refs->packed_ref_store, 0, &err))
> -		goto error;
> -
> -	if (refs_delete_refs(refs->packed_ref_store, msg, refnames, flags)) {
> -		packed_refs_unlock(refs->packed_ref_store);
> +	transaction =3D ref_store_transaction_begin(&refs->base, &err);
> +	if (!transaction)
>  		goto error;
> -	}
> -
> -	packed_refs_unlock(refs->packed_ref_store);
> =20
>  	for (i =3D 0; i < refnames->nr; i++) {
>  		const char *refname =3D refnames->items[i].string;
> -
> -		if (refs_delete_ref(&refs->base, msg, refname, NULL, flags))
> -			result |=3D error(_("could not remove reference %s"), refname);
> +		if (ref_transaction_delete(transaction, refname, NULL,
> +					   flags, msg, &err))
> +			goto error;
>  	}
> =20
> +	if (ref_transaction_commit(transaction, &err))
> +		goto error;
> +
> +	ref_transaction_free(transaction);
>  	strbuf_release(&err);
> -	return result;
> +	return 0;
> =20
>  error:
> -	/*
> -	 * If we failed to rewrite the packed-refs file, then it is
> -	 * unsafe to try to remove loose refs, because doing so might
> -	 * expose an obsolete packed value for a reference that might
> -	 * even point at an object that has been garbage collected.
> -	 */
>  	if (refnames->nr =3D=3D 1)
>  		error(_("could not delete reference %s: %s"),
>  		      refnames->items[0].string, err.buf);
>  	else
>  		error(_("could not delete references: %s"), err.buf);
> =20
> +	if (transaction)
> +		ref_transaction_free(transaction);
>  	strbuf_release(&err);
>  	return -1;
>  }

I really like these changes given that they simplify things, but I
wonder whether we can do them. In the preimage we're eagerly removing
loose refs: any error encountered when deleting a reference is recorded,
but we keep on trying to remove the other refs, as well. With the new
behaviour we now create a single transaction for all refs and try to
commit it. This also means that we'll abort the transaction when locking
any of the refs fails, which is a change in behaviour.

The current behaviour is explicitly documented in `refs.h:refs_delete_refs(=
)`:

    /*
     * Delete the specified references. If there are any problems, emit
     * errors but attempt to keep going (i.e., the deletes are not done in
     * an all-or-nothing transaction). msg and flags are passed through to
     * ref_transaction_delete().
     */
    int refs_delete_refs(struct ref_store *refs, const char *msg,
                         struct string_list *refnames, unsigned int flags);

There are multiple callsites of this function via `delete_refs()`. Now
honestly, most of these callsites look somewhat broken:

    - `bisect.c` simply does its best to clean up bisect state. This
      usecase looks fine to me.

    - `builtin/branch.c` reports the branches as deleted even if
      `delete_refs()` failed.

    - `builtin/remote.c` also misreports the deleted branches for the
      `prune` verb. The `rm` verb looks alright: if deletion of any
      branch failed then it doesn't prune the remote's config in the end
      and reports an error.

    - `builtin/fetch.c` also misreports deleted branches with `--prune`.

So most of these commands incorrectly handle the case where only a
subset of branches has been deleted. This raises the question whether
the interface provided by `refs_delete_refs()` is actually sensible if
it's so easy to get wrong. It doesn't even report which branches could
be removed and which couldn't. Furthermore, the question is whether new
backends like the reftable backend which write all refs into a single
slice would actually even be in a position to efficiently retain
semantics of this function.

I'm torn. There are valid usecases for eagerly deleting refs even if a
subset of deletions failed, making this change a tough sell, but most of
the callsites don't actually handle this correctly in the first place.

> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-h=
ooks.sh
> index 27731722a5b..e3d4fe624f7 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -133,4 +133,74 @@ test_expect_success 'interleaving hook calls succeed=
' '
>  	test_cmp expect target-repo.git/actual
>  '
> =20
> +test_expect_success 'hook allows deleting loose ref if successful' '
> +	test_when_finished "rm actual" &&
> +	git branch to-be-deleted $PRE_OID &&
> +	test_hook reference-transaction <<-\EOF &&
> +		echo "$*" >>actual
> +	EOF
> +	cat >expect <<-EOF &&
> +		aborted
> +		prepared
> +		committed
> +	EOF
> +	git branch -d to-be-deleted &&
> +	test_cmp expect actual &&
> +	test_must_fail git rev-parse refs/heads/to-be-deleted
> +'
> +
> +test_expect_success 'hook allows deleting packed ref if successful' '
> +	test_when_finished "rm actual" &&
> +	git branch to-be-deleted $PRE_OID &&
> +	git pack-refs --all --prune &&
> +	test_hook reference-transaction <<-\EOF &&
> +		echo "$*" >>actual
> +	EOF
> +	cat >expect <<-EOF &&
> +		prepared
> +		prepared
> +		committed
> +		committed
> +	EOF
> +	git branch -d to-be-deleted &&
> +	test_cmp expect actual &&
> +	test_must_fail git rev-parse refs/heads/to-be-deleted
> +'
> +
> +test_expect_success 'hook aborts deleting loose ref in prepared state' '
> +	test_when_finished "rm actual" &&
> +	test_when_finished "git branch -d to-be-deleted" &&
> +	git branch to-be-deleted $PRE_OID &&
> +	test_hook reference-transaction <<-\EOF &&
> +		echo "$*" >>actual
> +		exit 1
> +	EOF
> +	cat >expect <<-EOF &&
> +		aborted
> +		prepared
> +		aborted
> +	EOF

It's not really clear why we get the first "aborted" result here. I know
that it is because we didn't queue up any refs to the packed backend,
and thus we don't even try to prepare the transaction. But it's likely
confusing to a reader and might thus warrant a comment. On the other
hand this is going away anyway if and when my patch series lands again
that stops calling the hook from the nested packed backend.

> +	test_must_fail git branch -d to-be-deleted &&
> +	test_cmp expect actual &&
> +	git rev-parse refs/heads/to-be-deleted
> +'
> +
> +test_expect_success 'hook aborts deleting packed ref in prepared state' '
> +	test_when_finished "rm actual" &&
> +	test_when_finished "git branch -d to-be-deleted" &&
> +	git branch to-be-deleted $PRE_OID &&
> +	git pack-refs --all --prune &&
> +	test_hook reference-transaction <<-\EOF &&
> +		echo "$*" >>actual
> +		exit 1
> +	EOF
> +	cat >expect <<-EOF &&
> +		prepared
> +		aborted
> +	EOF
> +	test_must_fail git branch -d to-be-deleted &&
> +	test_cmp expect actual &&
> +	git rev-parse refs/heads/to-be-deleted
> +'
> +

=46rom your description one more interesting case is when the packed-refs
transaction is committed, but the loose-refs backend is aborted. It's a
bit harder to test given that we have no way to indicate what backend
the reftx hook is being invoked from though.

One thing that worries me is that these patches kind of set the current
behaviour of driving the reftx hook via both packed and loose backend
into stone. My patch series that got reverted is going to change that
behaviour though so that we don't execute the hook from the packed
backend, and consequentially we'd have to change all these tests again
to match the new behaviour. This makes it a lot harder to argue though
that we can safely switch to the new behaviour without breaking any
assumptions when we even codified our current assumptions into tests.

Taking a step back I wonder whether my previous approach to just hide
the hook for the packed backend was the right thing to do though. An
alternative would be to instead expose additional information to the
hook so that it can decide by itself whether it wants to execute the
hook or not. This could e.g. trivially be done by exposing a new
"GIT_REFS_BACKEND" environment variable to the reftx hook that gets set
to either "packed-refs", "loose-refs" or "reftables" depending on which
backend is currently in use. Equipped with this information a hook
script can then easily ignore any updates to the packed-refs file by
itself without having to change the way it is invoked right now and thus
we wouldn't regress any currently existing hooks.

>  test_done
> diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> index 4620f0ca7fa..8b09a99c2e8 100755
> --- a/t/t5510-fetch.sh
> +++ b/t/t5510-fetch.sh
> @@ -169,10 +169,10 @@ test_expect_success REFFILES 'fetch --prune fails t=
o delete branches' '
>  	git clone . prune-fail &&
>  	cd prune-fail &&
>  	git update-ref refs/remotes/origin/extrabranch main &&
> -	: this will prevent --prune from locking packed-refs for deleting refs,=
 but adding loose refs still succeeds  &&
> -	>.git/packed-refs.new &&
> +	: this will prevent --prune from locking refs/remotes/origin/extra for =
deletion &&
> +	>.git/refs/remotes/origin/extrabranch.lock &&
> =20
> -	test_must_fail git fetch --prune origin
> +	test_must_fail git fetch --prune origin > outputs 2> errors

It would be nice to have an explanation why exactly this change is
needed, and why it is fine that the visible behaviour changes here.

Patrick

> =20
>  test_expect_success 'fetch --atomic works with a single branch' '
>=20
> base-commit: 0f828332d5ac36fc63b7d8202652efa152809856
> --=20
> gitgitgadget

--TTZOwBNSofy9sQwE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmJ4s2YACgkQVbJhu7ck
PpQIWQ//RpSs+0TFK4xdBYfcMsYHfIfdw0Ehf1q4pnIQMjjXuS6cOWcHvQKvcPop
e0BPvGLZJbSpa8sYaJ34TMeUZL/Qslyw2cslbZuWvvbJzBSIhP0kVnlQFAPkImUs
8QGdQOsXAK1thtEE5RwC7ByiPaCrm0+sKFcTmPDb9hKR2F0G+TiztQWx0o0DjjGq
15Rzt0c9F8QxqpRtzpKlek3E6yb9nWhxro68VaR+AI79+frqlOfa/AUhFsUTY+IC
Q6TXDbR0w8g1JQlOcv5ueWq/N8jsy+Yc93ij4eJY5+s+4Y5UpME8V+h4ATXP4kSa
lgIggkRTZcHbVS2XMZAOvuDnhrkkX33q6Q1kx22gD42+0t+gNW8Kp6J2VGletduy
w+spBY8wJXxciGt9ySZQNFTz0+wOSR051cxlONTg+nAdmEZIDKjnMU3Y45oG9AZ1
9nwG0GhrNjwbV18N2422aMCgfJJioOt7B3mA14DJrHUNMzaQkztUgCZJoe+7bwMH
oFBHttRAx187ya9yUz+j5uq3ZZRgyKTU1zM1jktS6lr0WHra02oaRF/um4+8ddyB
doUz3bgdiAAv0cIMrEJ7rMc/HWdsd/uryPoV6HZIEJl4ic5vY6+XHMbgmaIeiPrb
/xYXoqBoyk1OOJPuwOFJib8dua9dGy17saKegeXdnsHKIEGhGIw=
=N7My
-----END PGP SIGNATURE-----

--TTZOwBNSofy9sQwE--
