Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D065BC19F2D
	for <git@archiver.kernel.org>; Tue,  9 Aug 2022 11:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbiHILGB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Aug 2022 07:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbiHILGA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Aug 2022 07:06:00 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5079E11C18
        for <git@vger.kernel.org>; Tue,  9 Aug 2022 04:05:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 232945C0059;
        Tue,  9 Aug 2022 07:05:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 09 Aug 2022 07:05:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1660043155; x=1660129555; bh=lFDA0VBcQI
        ISlHAXS2lRarN1tgAawmyl2TkkqDq5D2Q=; b=nn33BprumUWvMm9fJ4X9+Ctvqm
        3qiuZ9e2kKmwQqF8b9s8ZeT5bphkz2DpIREaUwoemN/qqbPZ4iz29s0ig/b0ztO9
        pidzPpo3Co6TiLeOsOt1XG3HAK0eKI78mqUel4aWeBdX5hvuNqX9zecV3hfwqOAV
        +59H4CTYnmz7f508gClVv5VvkdLs6ZIM+lzm0ERnOqGb4KFCqwDEZafp/dXejeqH
        QbL4KnoPT7pDcyWWuK9J23nDYxlF3WUurZexoZlJegVPFhQk2kWxcvN6fRTp6nYJ
        ophPFi/KQWXw5psd5V1bN+gu3NP9Y/Z45CRnXs3hMoKJnZWf7THOCCxErFLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1660043155; x=1660129555; bh=lFDA0VBcQIISlHAXS2lRarN1tgAa
        wmyl2TkkqDq5D2Q=; b=JZfsLzjE7h0yorikr7N00o5B2jNHACRbp8yQbLIKNW4q
        9YnmQHd2VCW+0nmu6rlc9eNA7Ri2YOFQMxcB9R7rKebGccNzP9dckW7gyOdliDhu
        S5B6VnM7Oromf8AwbB+8wugb8Y6IX4Kd0DtsoFK/Qi67ec/7XMlPooG/Zs/H1Hw9
        4VOowLV9AlnXPqVE9whZTv5L/oVPHDI7IgPxgviloGDcPpKvXJn4EARJYxvQsQWe
        s/JHvygvzsOlml4IbbUYxq02pcwoZVAjTCnjejCvrDnVNDjHIG3jLTv1/omjH9jE
        uSUDhws36jLrPL8g6Xph9grg6Xx+Ct/UBc05ZcFhmA==
X-ME-Sender: <xms:kj_yYuUY__6Z-VIqrPUKEXV_TCJxPb2Tt_gLwTzDdSPh8NABFhffXQ>
    <xme:kj_yYqlzDZTWpdrcpJG0B6H-Zhn0aGBnqiBNWZf8RKXus1yxZNInQSJuewnDl2_75
    i7J3FnL4uKPQj-yXg>
X-ME-Received: <xmr:kj_yYiZt0EQo0z0j9Ldo0Oxw1ZSGNvIh5xc1sls-48805ymKc4zz0BzD1ybl-0hfxTzGMy8L4aqdLzUANg7FnHgcnZF7-w502zuyyab73gveMyyacZwQtI-cqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegtddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepieevkedtgffgleeugfdvledvfedthfegueegfeevjeelueefkeegfeffhefglefg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:kj_yYlUJumaCWKjw9Tnc7yYaHSql58Dj89B2dN_REC65IVJqdMxnEw>
    <xmx:kj_yYokbOG7MwvjrOcbXRZ9soaPQbvR1exgDOgN7aCPbnm8L9hInkg>
    <xmx:kj_yYqdr0wcKmxac4ZR5W-B1HFiDevbk7QY7_4IveKqhOlIGq58jLQ>
    <xmx:kz_yYij_6H8dYNLnfk7KXFVj1zRL4HSCeerFr8BwSAf9PAglvsi9JA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Aug 2022 07:05:53 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 66b8c21e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 Aug 2022 11:05:48 +0000 (UTC)
Date:   Tue, 9 Aug 2022 13:05:46 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Michael Heemskerk <mheemskerk@atlassian.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH 9/9] refs: reimplement refs_delete_refs() and run hook
 once
Message-ID: <YvI/ipxGZ3rPZ/OQ@ncase>
References: <20220729101245.6469-1-worldhello.net@gmail.com>
 <20220729101245.6469-10-worldhello.net@gmail.com>
 <CAJDSCnMHHdYGeyXKj=ztUKBv2vRTn5BEXUR_7fAfATJxn_uwww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="clEVYY8y5gJnxVrD"
Content-Disposition: inline
In-Reply-To: <CAJDSCnMHHdYGeyXKj=ztUKBv2vRTn5BEXUR_7fAfATJxn_uwww@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--clEVYY8y5gJnxVrD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 02, 2022 at 02:42:01PM +0200, Michael Heemskerk wrote:
> Let me re-share some questions/suggestions/objections I got on a patch I
> shared with similar changes:
> https://lore.kernel.org/git/pull.1228.git.1651676435634.gitgitgadget@gmai=
l.com/
>=20
> There's a lot to like about the change; it fixes the incorrect invocation=
 of
> the reference-transaction hooks when (bulk) deleting refs, but there is a
> down-side that Patrick pointed out. We never got to a satisfactory soluti=
on,
> so let me reshare his feedback to pick up the discussion.
>=20
> Patrick:
> > I really like these changes given that they simplify things, but I
> > wonder whether we can do them. In the preimage we're eagerly removing
> > loose refs: any error encountered when deleting a reference is recorded,
> > but we keep on trying to remove the other refs, as well. With the new
> > behaviour we now create a single transaction for all refs and try to
> > commit it. This also means that we'll abort the transaction when locking
> > any of the refs fails, which is a change in behaviour.
> >
> > The current behaviour is explicitly documented in `refs.h:refs_delete_r=
efs()`:
> >
> >     /*
> >      * Delete the specified references. If there are any problems, emit
> >      * errors but attempt to keep going (i.e., the deletes are not done=
 in
> >      * an all-or-nothing transaction). msg and flags are passed through=
 to
> >      * ref_transaction_delete().
> >      */
> >    int refs_delete_refs(struct ref_store *refs, const char *msg,
> >                          struct string_list *refnames, unsigned int fla=
gs);
> >
> > There are multiple callsites of this function via `delete_refs()`. Now
> > honestly, most of these callsites look somewhat broken:
> >
> >     - `bisect.c` simply does its best to clean up bisect state. This
> >       usecase looks fine to me.
> >
> >    - `builtin/branch.c` reports the branches as deleted even if
> >       `delete_refs()` failed.
> >
> >     - `builtin/remote.c` also misreports the deleted branches for the
> >       `prune` verb. The `rm` verb looks alright: if deletion of any
> >       branch failed then it doesn't prune the remote's config in the end
> >       and reports an error.
> >
> >     - `builtin/fetch.c` also misreports deleted branches with `--prune`.
> >
> > So most of these commands incorrectly handle the case where only a
> > subset of branches has been deleted. This raises the question whether
> > the interface provided by `refs_delete_refs()` is actually sensible if
> > it's so easy to get wrong. It doesn't even report which branches could
> > be removed and which couldn't. Furthermore, the question is whether new
> > backends like the reftable backend which write all refs into a single
> > slice would actually even be in a position to efficiently retain
> > semantics of this function.
> >
> > I'm torn. There are valid usecases for eagerly deleting refs even if a
> > subset of deletions failed, making this change a tough sell, but most of
> > the callsites don't actually handle this correctly in the first place.

Thanks a lot for revoicing my concerns here. I also agree that overall
the changes are very much what I'd love to have as they simplify the
implementation and fix the issues at the same time.

> At the time, the only solution I could see was to switch to
> transaction-per-ref semantics, but this results in bad performance when
> deleting tens of thousands of refs.
>=20
> One option might be to optimistically try to delete the refs in a single
> transaction. If that fails for whatever reason and multiple ref deletions=
 are
> requested, we could fall back to a transaction-per-ref approach. That'd k=
eep
> the common case fast, and still provide best effort deletes.
>=20
> Thoughts?

The biggest downside I can think of with this approach is that it's now
undeterministic whether we run the hooks once for all references, or
once for all references plus once for every single reference we're about
to delete when there was e.g. a racy deletion. That makes it hard to use
the hook e.g. in setups where we vote on reference updates as it can be
that due to racy behaviour we now see different behaviour on different
nodes.

I'm still torn. Ideally, I'd just bite the bullet and say that
`refs_delete_refs()` is atomic insofar that it will only ever delete all
references or none, and not a best-effort implementation. But that is a
change I'm still scared to make given that it sounds like an easy way to
run into regressions.

Unfortunately I still don't have an easy answer for how to properly fix
this, sorry :/

Patrick

> Cheers,
> Michael Heemskerk
>=20
> On Fri, Jul 29, 2022 at 12:13 PM Jiang Xin <worldhello.net@gmail.com> wro=
te:
> >
> > From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> >
> > When delete references using "git branch -d" or "git tag -d", there will
> > be duplicate call of "reference-transaction committed" for same refs.
> > This is because "refs_delete_refs()" is called twice, once for
> > files-backend and once for packed-backend, and we used to reinvented the
> > wheel in "files_delete_refs()" and "packed_delete_refs()". By removing
> > "packed_delete_refs()" and reimplement "files_delete_refs()", the
> > "reference-transaction" hook will run only once for deleted branches and
> > tags.
> >
> > The behavior of the following git commands and the last two testcases
> > have been fixed in t1416:
> >
> >  * git branch -d <branch>
> >  * git tag -d <tag>
> >
> > A testcase in t5510 is broken because we used to call the function
> > "packed_refs_lock()", but it is not necessary if the deleted reference
> > is not in the "packed-refs" file.
> >
> > Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> > ---
> >  refs/files-backend.c             | 21 ++++++-------
> >  refs/packed-backend.c            | 51 +-------------------------------
> >  t/t1416-ref-transaction-hooks.sh |  4 +--
> >  t/t5510-fetch.sh                 | 17 +++++++++++
> >  4 files changed, 29 insertions(+), 64 deletions(-)
> >
> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 8baea66e58..21426efaae 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -1268,31 +1268,27 @@ static int files_pack_refs(struct ref_store *re=
f_store, unsigned int flags)
> >  static int files_delete_refs(struct ref_store *ref_store, const char *=
msg,
> >                              struct string_list *refnames, unsigned int=
 flags)
> >  {
> > -       struct files_ref_store *refs =3D
> > -               files_downcast(ref_store, REF_STORE_WRITE, "delete_refs=
");
> > +       struct ref_transaction *transaction;
> >         struct strbuf err =3D STRBUF_INIT;
> >         int i, result =3D 0;
> >
> >         if (!refnames->nr)
> >                 return 0;
> >
> > -       if (packed_refs_lock(refs->packed_ref_store, 0, &err))
> > -               goto error;
> > -
> > -       if (refs_delete_refs(refs->packed_ref_store, msg, refnames, fla=
gs)) {
> > -               packed_refs_unlock(refs->packed_ref_store);
> > +       transaction =3D ref_store_transaction_begin(ref_store, &err);
> > +       if (!transaction)
> >                 goto error;
> > -       }
> > -
> > -       packed_refs_unlock(refs->packed_ref_store);
> >
> >         for (i =3D 0; i < refnames->nr; i++) {
> >                 const char *refname =3D refnames->items[i].string;
> > -
> > -               if (refs_delete_ref(&refs->base, msg, refname, NULL, fl=
ags))
> > +               if (ref_transaction_delete(transaction, refname, NULL,
> > +                                          flags, msg, &err))
> >                         result |=3D error(_("could not remove reference=
 %s"), refname);
> >         }
> > +       if (ref_transaction_commit(transaction, &err))
> > +               goto error;
> >
> > +       ref_transaction_free(transaction);
> >         strbuf_release(&err);
> >         return result;
> >
> > @@ -1309,6 +1305,7 @@ static int files_delete_refs(struct ref_store *re=
f_store, const char *msg,
> >         else
> >                 error(_("could not delete references: %s"), err.buf);
> >
> > +       ref_transaction_free(transaction);
> >         strbuf_release(&err);
> >         return -1;
> >  }
> > diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> > index 97b6837767..fdb7a0a52c 100644
> > --- a/refs/packed-backend.c
> > +++ b/refs/packed-backend.c
> > @@ -1519,55 +1519,6 @@ static int packed_initial_transaction_commit(str=
uct ref_store *ref_store,
> >         return ref_transaction_commit(transaction, err);
> >  }
> >
> > -static int packed_delete_refs(struct ref_store *ref_store, const char =
*msg,
> > -                            struct string_list *refnames, unsigned int=
 flags)
> > -{
> > -       struct packed_ref_store *refs =3D
> > -               packed_downcast(ref_store, REF_STORE_WRITE, "delete_ref=
s");
> > -       struct strbuf err =3D STRBUF_INIT;
> > -       struct ref_transaction *transaction;
> > -       struct string_list_item *item;
> > -       int ret;
> > -
> > -       (void)refs; /* We need the check above, but don't use the varia=
ble */
> > -
> > -       if (!refnames->nr)
> > -               return 0;
> > -
> > -       /*
> > -        * Since we don't check the references' old_oids, the
> > -        * individual updates can't fail, so we can pack all of the
> > -        * updates into a single transaction.
> > -        */
> > -
> > -       transaction =3D ref_store_transaction_begin(ref_store, &err);
> > -       if (!transaction)
> > -               return -1;
> > -
> > -       for_each_string_list_item(item, refnames) {
> > -               if (ref_transaction_delete(transaction, item->string, N=
ULL,
> > -                                          flags, msg, &err)) {
> > -                       warning(_("could not delete reference %s: %s"),
> > -                               item->string, err.buf);
> > -                       strbuf_reset(&err);
> > -               }
> > -       }
> > -
> > -       ret =3D ref_transaction_commit(transaction, &err);
> > -
> > -       if (ret) {
> > -               if (refnames->nr =3D=3D 1)
> > -                       error(_("could not delete reference %s: %s"),
> > -                             refnames->items[0].string, err.buf);
> > -               else
> > -                       error(_("could not delete references: %s"), err=
=2Ebuf);
> > -       }
> > -
> > -       ref_transaction_free(transaction);
> > -       strbuf_release(&err);
> > -       return ret;
> > -}
> > -
> >  static int packed_pack_refs(struct ref_store *ref_store, unsigned int =
flags)
> >  {
> >         /*
> > @@ -1595,7 +1546,7 @@ struct ref_storage_be refs_be_packed =3D {
> >
> >         .pack_refs =3D packed_pack_refs,
> >         .create_symref =3D NULL,
> > -       .delete_refs =3D packed_delete_refs,
> > +       .delete_refs =3D NULL,
> >         .rename_ref =3D NULL,
> >         .copy_ref =3D NULL,
> >
> > diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction=
-hooks.sh
> > index df75e5727c..f64166f9d7 100755
> > --- a/t/t1416-ref-transaction-hooks.sh
> > +++ b/t/t1416-ref-transaction-hooks.sh
> > @@ -744,7 +744,7 @@ test_expect_success "branch: rename branches" '
> >         test_cmp_heads_and_tags -C workdir expect
> >  '
> >
> > -test_expect_failure "branch: remove branches" '
> > +test_expect_success "branch: remove branches" '
> >         test_when_finished "rm -f $HOOK_OUTPUT" &&
> >
> >         cat >expect <<-EOF &&
> > @@ -873,7 +873,7 @@ test_expect_success "tag: update refs to create loo=
se refs" '
> >         test_cmp_heads_and_tags -C workdir expect
> >  '
> >
> > -test_expect_failure "tag: remove tags with mixed ref_stores" '
> > +test_expect_success "tag: remove tags with mixed ref_stores" '
> >         test_when_finished "rm -f $HOOK_OUTPUT" &&
> >
> >         cat >expect <<-EOF &&
> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> > index b45879a760..22de7ac9ec 100755
> > --- a/t/t5510-fetch.sh
> > +++ b/t/t5510-fetch.sh
> > @@ -168,6 +168,8 @@ test_expect_success REFFILES 'fetch --prune fails t=
o delete branches' '
> >         cd "$D" &&
> >         git clone . prune-fail &&
> >         cd prune-fail &&
> > +       git update-ref refs/remotes/origin/extrabranch main~ &&
> > +       git pack-refs --all &&
> >         git update-ref refs/remotes/origin/extrabranch main &&
> >         : this will prevent --prune from locking packed-refs for deleti=
ng refs, but adding loose refs still succeeds  &&
> >         >.git/packed-refs.new &&
> > @@ -175,6 +177,21 @@ test_expect_success REFFILES 'fetch --prune fails =
to delete branches' '
> >         test_must_fail git fetch --prune origin
> >  '
> >
> > +test_expect_success REFFILES 'fetch --prune ok for loose refs not in l=
ocked packed-refs' '
> > +       test_when_finished "cd \"$D\"; rm -rf \"prune-ok-ref-not-packed=
\"" &&
> > +       cd "$D" &&
> > +       git clone . prune-ok-ref-not-packed &&
> > +       (
> > +               cd prune-ok-ref-not-packed &&
> > +               git update-ref refs/remotes/origin/extrabranch main &&
> > +               : for loose refs not in packed-refs, we can delete them=
 even the packed-refs is locked &&
> > +               :>.git/packed-refs.new &&
> > +
> > +               git fetch --prune origin &&
> > +               test_must_fail git rev-parse refs/remotes/origin/extrab=
ranch --
> > +       )
> > +'
> > +
> >  test_expect_success 'fetch --atomic works with a single branch' '
> >         test_when_finished "rm -rf \"$D\"/atomic" &&
> >
> > --
> > 2.36.1.25.gc87d5ad63a.dirty
> >

--clEVYY8y5gJnxVrD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmLyP4kACgkQVbJhu7ck
PpRRzw/8DuLjIuH5Yi3ULZS8DfS3TigH6QlR6feEYO3muHTOXL7ldd+VDDfLucoy
nShfH7i3Lgb+t9tyCsF0G8CygDNvezZKRm5ej9V9hqu/oyjSiaawQ/HqSHPPSVJv
w7mi/GUY44gGxPAwfL2KZ6w7SfLTLTZlXN/U+6xZjdS5q/UiPbbEVrJYsdoaHZBU
nXYjvxbCokLoHjVV0wY1xPc32I833Jh+T90E0GmscZt+LOuYiNdTvlmre7XTGA7N
xzkpuWSqezEK9KRPd4nan/djayXFt3e8TtLk+O2j5ndMW020vb0EReYl3kUfMzu2
Qa4JwbmI8RoIMFoiJt55o/qGfhV5Ll80F7mZFWgNoT2D+O2JBoz8oQh9iFCh5/UI
bW35V12r4JidUOsaTJOuT1Daiz41tKFTEQ/6YoLZycmNN1RAFdmUqgY7Any7RmX+
qDCb9FoUkhYzPqe7OziVpTPo6gxDrAugdD2w+BI36aBIkiFC1RDrvCzRKlgp8de1
DPA87fdTA4ASQPKBRm6tJ0lffMxYmfgt0tZL9eoFAd1M/3EBMvokR6CguHQu9O/C
utFLfE0V6rNfqfeESVpXO+0p3JwmZarerTJDgVtZiLIxNwlMFouTiuBEQ5oJNmLC
qKPh0MAEAwCWWP93Mb7sV5rZpJZdf2BI/uK1YqCiSfuYzyb1WmQ=
=6q1I
-----END PGP SIGNATURE-----

--clEVYY8y5gJnxVrD--
