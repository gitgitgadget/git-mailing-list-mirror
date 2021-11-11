Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D39C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 12:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08A2160F21
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 12:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhKKMKE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 07:10:04 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:35731 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231739AbhKKMKD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Nov 2021 07:10:03 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 29EE75C0075;
        Thu, 11 Nov 2021 07:07:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 11 Nov 2021 07:07:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=e+cNi0De9vMGMp7Sa7gg2YKR33v
        1ExGwRhlpW8o4O4w=; b=XS8OAoK4sh+qjkncgmYpa0V0xI17Lj3b1kwTOURIg9v
        44l+YLOUuBvfZ/2DqQkLfuFX7ewjW9yeIO3vBwG7Zs+zMzoxGWO33qJl7eBaE51v
        +XVB3rWti2prf/1S7iKkEqku8b9i9xgvK+6M9OyRYl6NekZpx0A7Tj+4KnwaYvNx
        HM5sQ4wWY19x3v0ptx9clFasOHOtmoG7qUe/mpPhHmu8y6sVGmkuOXD3c9I7Pzen
        4YmOquvrzQ1dDV0Ih7Hyq+CqchFVs+ogOcMd7J3A+OqL92Ka5lrzc5DNXdnIe8bF
        aYeVCT+xb4P4GjyHAhovdR4bvvt+zxpBrJOWmEfIyfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=e+cNi0
        De9vMGMp7Sa7gg2YKR33v1ExGwRhlpW8o4O4w=; b=KRF1LwqCQBFhCRJ4sgBA3f
        MYq6uXotBkkEj+L1CUVxlvQhP7JzTTGJrz67T2LOTMfUtsx83qp2jK6+9G1zV5eK
        pxU70L/ZrbULXp95K1CzJ+5WX7hMoebAcWqTepzM0ZWhk1E1C84YhbyGIgoRddk0
        E+yKCHV4qbUAneGZ2yvtfzhVgNDCaJ9YMM7723vSP6YqdrmpxpAEdPE5asuxwrOI
        EtzPBZXAbmzJTKRfMkyRKM92WkuzsasdWcL4MtiO1fcHohlO73r96LAOP0s4nNCx
        1ZRcijXUOqPktti5os/GqMjJ6R2KZeWUygapptB5irrCDHZI8meJgdmuAmGN9n3w
        ==
X-ME-Sender: <xms:cQeNYaw6XnCBE9LbAiitDBIUjrnDDIQ84lSJC5UyT_rwrQfzDiSsng>
    <xme:cQeNYWSfWwcllSbYQMAVXT4JyXjEiW946EWjjEu_HzAHYRA_HLMjN8el0CWF7bMjC
    Nc73taGYqmWx9LUmA>
X-ME-Received: <xmr:cQeNYcUNxxJTz-jQ4eA6F-hZmWEXaiPEv9W1_CV3dGyNSKFch-c7JmDVqzxZQT7IByR2bpcfz2ETejjuJGzo8m2nT9Vn7Rtjtcal4k7Cvb-qwjLKtD50X_o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvddugdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjeeffeehveevhfeifeejveekffetvdeivedvffeftddtgeeiffdttdevuedttdefnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghdpvgdrhihouhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:cQeNYQhHn6E11j4mjGudVXaz96lrUNbo7aZACzdM9Yls-i5If5BPJw>
    <xmx:cQeNYcAyRpK-Bnc_NGFWrbzKbMr6MA9VZQy9e5Xe_XEW8kHM-_wjjA>
    <xmx:cQeNYRK4YiMRI5_dJFb_qXXT5c3vGh0bXBZqO7PamDhQ-2KV1b757g>
    <xmx:cgeNYe2ivwUrcuksxdJaAJMRDTRF6PNRSMONyo5JPAyHYjDpP0qOgg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Nov 2021 07:07:12 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9a34ba6f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 11 Nov 2021 13:51:42 +0000 (UTC)
Date:   Thu, 11 Nov 2021 13:06:48 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 3/3] refs: add configuration to enable flushing of refs
Message-ID: <YY0HWCgg2e/cAc5y@ncase>
References: <dd65718814011eb93ccc4428f9882e0f025224a6.1636029491.git.ps@pks.im>
 <cover.1636544377.git.ps@pks.im>
 <d9aa96913b1730f1d0c238d7d52e27c20bc55390.1636544377.git.ps@pks.im>
 <211110.86v910gi9a.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bgXJJep5bnFahmPN"
Content-Disposition: inline
In-Reply-To: <211110.86v910gi9a.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bgXJJep5bnFahmPN
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 10, 2021 at 03:49:02PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Wed, Nov 10 2021, Patrick Steinhardt wrote:
>=20
> > [...]
> > Fix this by introducing a new configuration "core.fsyncRefFiles". This
> > config matches behaviour of "core.fsyncObjectFiles" in that it provides
> > three different modes:
> >
> >     - "off" disables calling fsync on ref files. This is the default
> >       behaviour previous to this change and remains the default after
> >       this change.
> >
> >     - "on" enables calling fsync on ref files, where each reference is
> >       flushed to disk before it is being committed. This is the safest
> >       setting, but may incur significant performance overhead.
> >
> >     - "batch" will flush the page cache of each file as it is written to
> >       ensure its data is persisted. After all refs have been written,
> >       the directories which host refs are flushed.
> >
> > With this change in place and when "core.fsyncRefFiles" is set to either
> > "on" or "batch", this kind of corruption shouldn't happen anymore.
> >
> > [1]: https://www.kernel.org/doc/Documentation/filesystems/ext4.txt
>=20
> With the understanding that my grokking of this approach is still
> somewhere between "uh, that works?" and "wow, voodoo FS magic!". ....
>=20
> I haven't looked at these changes in much daiter, or Neeraj's recent
> related changes but...
>=20
> > +core.fsyncRefFiles::
> > +	A value indicating the level of effort Git will expend in trying to m=
ake
> > +	refs added to the repo durable in the event of an unclean system
> > +	shutdown. This setting currently only controls loose refs in the obje=
ct
> > +	store, so updates to packed refs may not be equally durable. Takes the
> > +	same parameters as `core.fsyncObjectFiles`.
> > +
>=20
> ...my understanding of it is basically a way of going back to what Linus
> pointed out way back in aafe9fbaf4f (Add config option to enable
> 'fsync()' of object files, 2008-06-18).
>=20
> I.e. we've got files x and y. POSIX sayeth we'd need to fsync them all
> and the directory entry, but on some FS's it would be sufficient to
> fsync() just y if they're created in that order. It'll imply an fsync of
> both x and y, is that accurate?
>=20
> If not you can probably discard the rest, but forging on:
>=20
> Why do we then need to fsync() a "z" file in get_object_directory()
> (i.e. .git/objects) then? That's a new "z", wasn't flushing "y" enough?
>=20
> Or if you've written .git/objects/x and .git/refs/y I can imagine
> wanting to create and sync a .git/z if the FS's semantics are to then
> flush all remaining updates from that tree up, but here it's
> .git/objects, not .git. That also seems to contract this above:
>=20
> >       ensure its data is persisted. After all refs have been written,
> >       the directories which host refs are flushed.
>=20
> I.e. that would be .git/refs (let's ignore .git/HEAD and the like for
> now), not .git/objects or .git?

Yeah, .git/refs. Note that we need to flush refs in two locations though
given that there are common refs shared across worktrees, and then there
are worktree-specific refs. These may not even share the filesystem, so
there's not much we can do about this. We could play games with the
fsid, but I'm not sure it's worth it.

> And again, forging on but more generally [continued below]...
>=20
> > +	if (!strcmp(var, "core.fsyncreffiles")) {
>=20
> UX side: now we've got a core.fsyncRefFiles and
> core.fsyncWhateverItWasCalled in Neeraj series. Let's make sure those
> work together like say "fsck.*" and "fetch.fsck.*" do, i.e. you'd be
> able to configure this once for objects and refs, or in two variables,
> one for objects, one for refs...

Honestly, I'd prefer to just have a global variable with per-subsystem
overrides so that you can say "Please batch-sync all files by default,
but I really don't care for files in the worktree". Kind of goes into
the same direction as your RFC.

[snip]
> > @@ -2665,7 +2719,7 @@ static int files_transaction_prepare(struct ref_s=
tore *ref_store,
> >  		files_downcast(ref_store, REF_STORE_WRITE,
> >  			       "ref_transaction_prepare");
> >  	size_t i;
> > -	int ret =3D 0;
> > +	int ret =3D 0, sync_flags =3D 0;
> >  	struct string_list affected_refnames =3D STRING_LIST_INIT_NODUP;
> >  	char *head_ref =3D NULL;
> >  	int head_type;
> > @@ -2777,8 +2831,14 @@ static int files_transaction_prepare(struct ref_=
store *ref_store,
> >  					&update->new_oid, NULL,
> >  					NULL);
> >  		}
> > +
> > +		sync_flags |=3D sync_loose_refs_flags(update->refname);
> >  	}
> > =20
> > +	ret =3D sync_loose_refs(refs, sync_flags, err);
> > +	if (ret)
> > +		goto cleanup;
> > +
> >  	if (packed_transaction) {
> >  		if (packed_refs_lock(refs->packed_ref_store, 0, err)) {
> >  			ret =3D TRANSACTION_GENERIC_ERROR;
>=20
> ...[continued from above]: Again, per my potentially wrong understanding
> of syncing a "x" and "y" via an fsync of a subsequent "z" that's
> adjacent on the FS to those two.
>=20
> Isn't this setting us up for a really bad interaction between this
> series and Neeraj's work? Well "bad" as in "bad for performance".
>=20
> I.e. you'll turn on "use the batch thing for objects and refs" and we'll
> do two fsyncs, one for the object update, and one for refs. The common
> case is that we'll have both in play.
>=20
> So shouldn't this go to a higher level for both so we only create a "z"
> .git/sync-it-now-please.txt or whatever once we do all pending updates
> on the .git/ directory?

Good question. Taking a different stance would be to say "I don't ever
want to write a ref referring to an object which isn't yet guaranteed to
be persistent". In that case, writing and syncing objects first and then
updating refs would be the correct thing to do and wouldn't need
coordination on a higher level.

> I can also imagine that we'd want that at an even higher level, e.g. for
> "git pull" surely we'd want it not for refs or objects, but in
> builtin/pull.c somewhere because we'll be updating the .git/index after
> we do both refs and objects, and you'd want to fsync at the very end,
> no?
>=20
> None of the above should mean we can't pursue a more narrow approach for
> now. I'm just:
>=20
>  1) Seeing if I understand what we're trying to do here, maybe not.

Personally, my most important bullet point is that I want to get rid of
the corrupt refs we see in production every now and then. As Peff
pointed out in another email, it _might_ be sufficient to just flush out
the page cache for those without synchronizing any metadata at all. But
none of us seems to be sure that this really works the way we think it
does.

>  2) Encouraging you two to think about a holistic way to configure some
>     logical conclusion to this topic at large, so we won't end up with
>     core.fsyncConfigFiles, core.fsyncObjectFiles, core.fsyncIndexFile,
>     core.fsyncRefFiles, core.fsyncTheCrapRebaseWritesOutFiles etc. :)

Yeah, I agree with you on this point. We definitely don't want to end up
with twenty different knobs to sync objects, refs, packed-refs, configs,
reflogs et al, and we're currently steering into that direction. Having
a central knob core.fsync which directs defaults for all subsystems
would be very much preferable if you ask me, where specific subsystems
can then be changed as the user sees fit.

What I think is important though is that we should have the right
defaults in place. It doesn't help to say "fsync is slow" as an excuse
to not do them at all by default, where the result is that users get a
corrupt repository.

Patrick

--bgXJJep5bnFahmPN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGNB1cACgkQVbJhu7ck
PpSYSQ/9Gfs1UOw+yHSZ8oDCKn1jPNhR3hrbk2hiYvi/XgUsoioe6G/n09Bp+o2E
8C5CGdEplKTIYIBHRVccINk4Dmmao6YwCphnrcqiGHD0yPkKAlygQ5AFtmyguFaX
NAG8wgQS1zMK8wqvwg9+PnyJWomIWyo3Wc6foSjvKuik+IXBT2TtjS/mX+AshKX3
ql8ZnBeIb4BwDrbhz5VGD8XouuCVG91KzqifBtgyGX47dp2d9iqDhrsaLAbsp1MV
IhInsDZbSy0lrnY5kOaUBzjVE333ZIwEPUT8P/Px4ly59s8YpmM/rbEMKe4Sysxw
9pnMvXG6kmhaibEGD7tHmTs3Mv6CVhphQmHpAxAG4YnOURCwc2Od7q4T+TuDcvKb
3ckWu6hN1mUkRmJiLz8TOXixX3vhHSTI07CWdaMVpbO2DDiHIYGFRYrhbtz1PjVW
nIq5y6Q8YwdMkc2Wk6RwVd6PasO/wsQXgokSPLKjwvZozTLFFBWy8b/ysN62B1ur
vbINTiHRTNd2quosrvmDdiaZZDN9io8sWuAJQL5mBBkp8Ob7tNp33zTeZzK8uBoB
KNhI9S8LbPjxxEmLw/9c/grz2laV0zr0ot51OIKxgG2041ewuB9dK+k52aNRHdRO
AsoxtiOOOy6Uily0VxYy5IPrpqw6r/NG0OS2nTXWBfSGuL1zqII=
=6HAO
-----END PGP SIGNATURE-----

--bgXJJep5bnFahmPN--
