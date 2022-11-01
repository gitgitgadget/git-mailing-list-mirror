Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16AA5FA373D
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 07:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKAHU6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 03:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKAHU5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 03:20:57 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7F914016
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 00:20:55 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 8FB3B5C012E;
        Tue,  1 Nov 2022 03:20:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 01 Nov 2022 03:20:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667287253; x=1667373653; bh=Up8MxerPyg
        /AZnezfIzo270ZlzXuELChYWizTEXCt5U=; b=nCZtfHEPsiLLK4t26bHoZInl6o
        0jFkPmmzDvPAlY4GNwtlMIq+3+li4BXBqWdzkPK42wJ7rKBDZhySoPIZUxPh+P44
        4WwilVZDMpn0JC0itzq4nzsNS4ay/uDPaK4wsUI2/YP9YYqpDUQUUugoj03eQLFF
        HO0S2guqgGlRbgKCJb3kvFwuRpyzqwivdpM947FhFeK1anfjZKlWOE0iqRaSxjA0
        DIEngGJvqACXTlAOh8DCCmr0GX+nT0kuoyyjJl0kUQ1CGCl0FxGMA0E3ONjiuVcM
        ivzJq3EEZh7KRRm2EQXiOX3FWLR5EX3gyMtvAar/WoobKWooK0VQu8frrbIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667287253; x=1667373653; bh=Up8MxerPyg/AZnezfIzo270ZlzXu
        ELChYWizTEXCt5U=; b=rh0zm94wOS8MVdM7iMh0Ku2Wz5skWATMdib4g9b3NuOK
        OnhOqCxkdWmxW2xPQXwwh5BKcaJiwKlLnTbJ9NLQGY+fZH2LwYrQkYYpWzCxJg47
        7m73gwpXbKFXRMqJ4x6jSGUVas2juHjSp67Blug+5YLzpgEcks18RXu5dtXqYOu/
        VJZrfZA4N03dGNku9i6JPTRjIH0i7aaw9US/UWCUouVy0aJ+LeLkpRZcw4Ip5oFA
        ZG8Hck8EbapeHGW/J9mHrKKGpITA+1tkWjq9nj+LWrNjW9P0bVkShHhHKLAGcsLK
        89xoSCyngNJEOIiYovAy0eQeI3dZVFIcjgDFyslimA==
X-ME-Sender: <xms:1chgY2KS56HJ3HBtPHUlyEE7QwZAAdFOf2XfnMEDOYDrkrtKM07bsw>
    <xme:1chgY-J7azN_j-emTDk7eg2-liBh3w09-KBHAnoI8kWCmRfKuwjsKjmRXyFwxzDN1
    4op8TJxjNik-tm_zQ>
X-ME-Received: <xmr:1chgY2sjyZ1W9LM6uJeFsHxuHNgkucORVJgm2SnmsB50vECcjKGLEjSydvEuxvN8hsTBBDLGREXWVwkz7xscFN6x76Du18YpA4y2sr7oUdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudeggddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:1chgY7ai_ZkdJpYe4lftc6htjXKwkxEUFVHtJFNaHC3CcaRJdolB0A>
    <xmx:1chgY9aPOYGS9LMWL1aEIZEu2r0aR4vHWt4r7rbTXzZkhSBHj0KT6g>
    <xmx:1chgY3Ae62qk_vRAjb-B9wkXNgEJzLRkVGFHV0Fc0WQY88gNtRPaIA>
    <xmx:1chgY-Aisf9D-Ru8yachDIl9mO5f1IJNvJz4TQvHzvhyllDlB7czNQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Nov 2022 03:20:52 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 7212975f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Nov 2022 07:20:35 +0000 (UTC)
Date:   Tue, 1 Nov 2022 08:20:48 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] receive-pack: use advertised reference tips to
 inform connectivity check
Message-ID: <Y2DI0OL1bXhPS/JD@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <006e89f384be1227b922fb6fdc8755ae84cac587.1666967670.git.ps@pks.im>
 <Y17L0IjELU5QlOPL@nand.local>
 <Y1/fm1prlAs3U1NE@ncase>
 <Y2B2KeYX5X9vp+cf@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hX3xo7oV3hqqa3N5"
Content-Disposition: inline
In-Reply-To: <Y2B2KeYX5X9vp+cf@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--hX3xo7oV3hqqa3N5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 31, 2022 at 09:28:09PM -0400, Taylor Blau wrote:
> On Mon, Oct 31, 2022 at 03:45:47PM +0100, Patrick Steinhardt wrote:
> > On Sun, Oct 30, 2022 at 03:09:04PM -0400, Taylor Blau wrote:
> > > On Fri, Oct 28, 2022 at 04:42:27PM +0200, Patrick Steinhardt wrote:
> > > > This strategy has the major downside that it will not require any o=
bject
> > > > to be sent by the client that is reachable by any of the repositori=
es'
> > > > references. While that sounds like it would be indeed what we are a=
fter
> > > > with the connectivity check, it is arguably not. The administrator =
that
> > > > manages the server-side Git repository may have configured certain =
refs
> > > > to be hidden during the reference advertisement via `transfer.hideR=
efs`
> > > > or `receivepack.hideRefs`. Whatever the reason, the result is that =
the
> > > > client shouldn't expect that any of those hidden references exists =
on
> > > > the remote side, and neither should they assume any of the pointed-=
to
> > > > objects to exist except if referenced by any visible reference. But
> > > > because we treat _all_ local refs as uninteresting in the connectiv=
ity
> > > > check, a client is free to send a packfile that references objects =
that
> > > > are only reachable via a hidden reference on the server-side, and we
> > > > will gladly accept it.
> > >
> > > You mention below that this is a correctness issue, but I am not sure
> > > that I agree.
> > >
> > > The existing behavior is a little strange, I agree, but your argument
> > > relies on an assumption that the history on hidden refs is not part of
> > > the reachable set, which is not the case. Any part of the repository
> > > that is reachable from _any_ reference, hidden or not, is reachable by
> > > definition.
> > >
> > > So it's perfectly fine to consider objects on hidden refs to be in the
> > > uninteresting set, because they are reachable. It's odd from the
> > > client's perspective, but I do not see a path to repository corruption
> > > with thee existing behavior.
> >
> > Indeed, I'm not trying to say that this can lead to repository
> > corruption.
>=20
> I definitely agree with that. I have thought about this on-and-off since
> you sent the topic, and I am pretty certain that there is no path to
> repository corruption with the existing behavior. It would be worth
> updating the commit message to make this clearer.

Fair enough, I can try to do that.

> > But security-related or not, I think it is safe to say that any packfile
> > sent by a client that does not contain objects required for the updated
> > reference that the client cannot know to exist on the server-side must
> > be generated by buggy code.
>=20
> Maybe, though I think it's fine to let clients send us smaller packfiles
> if they have some a-priori knowledge that the server has objects that it
> isn't advertising. And that can all happen without buggy code. So it's
> weird, but there isn't anything wrong with letting it happen.

Well, I don't see how to achieve both at the same time though: we can
either limit the set of uninteresting tips to what we have announced to
the client, or we allow clients to omit objects that have not been
announced. These are mutually exclusive.

So if we take the stance that it was fine to send packfiles that omit
hidden objects and that this is something we want to continue to support
then this patch series probably becomes moot. Doing the proposed
optimization means that we also tighten the rules here.

> > [snip]
> > > Why do we see a slowdown when there there aren't any hidden reference=
s?
> > > Or am I misunderstanding your patch message which instead means "we s=
ee
> > > a slow-down when there are no hidden references [since we still must
> > > store and enumerate all advertised references]"?
> >
> > I have tried to dig down into the code of `revision.c` but ultimately
> > returned empty-handed. I _think_ that this is because of the different
> > paths we use when reading revisions from stdin as we have to resolve the
> > revision to an OID first, which is more involved than taking the OIDs as
> > returned by the reference backend. I have tried to short-circuit this
> > logic in case the revision read from stdin is exactly `hash_algo->hexsz`
> > long so that we try to parse it as an OID directly instead of trying to
> > do any of the magic that is required to resolve a revision. But this
> > only speed things up by a small margin.
> >
> > Another assumption was that this is overhead caused by using stdin
> > instead of reading data from a file, but flame graphs didn't support
> > this theory, either.
> >
> > > If the latter, could we avoid invoking the new machinery altogether? =
In
> > > other words, shouldn't receive-pack only set the reachable_oids_fn() =
to
> > > enumerate advertised references only when the set of advertised
> > > references differs from the behavior of `--not --all`?
> >
> > Yeah, I was taking a "wait for feedback and see" stance on this. We can
> > easily make the logic conditional on whether there are any hidden refs
> > at all.
>=20
> Yeah, I think that this would be preferable. I'm surprised that your
> data doesn't support the idea that the slowdown is caused by reading
> from stdin instead of parsing `--not --all`. I'd be curious to see what
> you have tried so far.
>=20
> I'm almost certain that forcing rev-list to chew through a bunch of data
> on stdin that is basically equivalent to saying `--not --all` is going
> to be the source of the slowdown.

I was basically benchmarking these two commands in the repository with
7m refs:

    # old-style connectivity check
    $ git commit-tree HEAD^{tree} -m commit -p HEAD >newtip
    $ git rev-list --objects --quiet --stdin --not --all <newtip

    # new-style connectivity check
    $ ( git for-each-ref --format=3D'^%(objectname)' ; $ git commit-tree HE=
AD^{tree} -m commit -p HEAD ) >oldandnewtips
    $ git rev-list --objects --quiet --stdin <oldandnewtips

I may have another look today and maybe share some flame graphs if I
continue to not see anything obvious.

> > > >  	if (check_connected(iterate_receive_command_list, &data, &opt))
> > > >  		set_connectivity_errors(commands, si);
> > > >
> > > > @@ -2462,6 +2473,7 @@ int cmd_receive_pack(int argc, const char **a=
rgv, const char *prefix)
> > > >  {
> > > >  	int advertise_refs =3D 0;
> > > >  	struct command *commands;
> > > > +	struct oidset announced_oids =3D OIDSET_INIT;
> > >
> > > This looks like trading one problem for another. In your above exampl=
e,
> > > we now need to store 20 bytes of OIDs 6.8M times, or ~130 MiB. Not the
> > > end of the world, but it feels like an avoidable problem.
> >
> > We store these references in an `oidset` before this patch set already,
> > but yes, the lifetime is longer now. But note that this set stores the
> > announced objects, not the hidden ones. So we don't store 6.8m OIDs, but
> > only the 250k announced ones.
>=20
> Hmm, OK. I wonder, could rev-list be given a `--refs=3D<namespace>`
> argument which is equal to the advertised references? Or something that
> implies "give me all of the references which aren't hidden?"
>=20
> If we call that maybe `--visible-refs=3Dreceive` (to imply the references
> *not* in receive.hideRefs), then our connectivity check would become:
>=20
>     git rev-list --stdin --not --visible-refs=3Dreceive
>=20
> or something like that. Not having to extend the lifetime of these OIDs
> in an oidset would be worthwhile. Besides, having a new rev-list option
> is cool, too ;-).

That is indeed an interesting idea. It would likely both fix the issue
of extended memory lifetime of the announced OIDs as well as fixing the
slowdown caused by using `--stdin` for them.

Patrick

--hX3xo7oV3hqqa3N5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNgyM8ACgkQVbJhu7ck
PpTCOw//R+uDQXydrY8vReR/Yagih9wQYGV0x8CNgHLF9Xwh1zwRS/RnWFFR/TwA
rhPmYzylfngOUmPoRluaOIWOP7Cn9s8Ew5xv4D2HJx1leycKkEjHwjBfzD405dFE
PHrLA3DNC7mZuMA35oNVQbRglAlPnLVtwcU3Zk+gWNCY7lTPcWAw5zJ/TQyVOqyw
wLBJB66Ls1Dbl2c5jLPrLUlvzivhli6LMiGvMpefeLX+vaXdklwMo6goxUq39TGU
Ul/t4Muiy08UUgjgkopBsIWXZENiqCF0LtuJyfBx0X5A21cwFDtaLYXj6tFRCjpc
0fS1Q8HXmq6+sPFOqfUA6snUdVGylmApLDbkqPkyPjhLXf/6BBdM5rdzsILZm0z3
7F3baaRWZpJFx49y52XQXr3tGo1+QDC4SgzrLza+ZVeYeY1ltbzHC7FDL+oUw06R
RqXb3wSfoNpxeNaBsLyG1qPjYnvm1cPk51McG5gHgoY+0QT62OuPKyHQ0J4WPeuO
Oefd05taPCvvZe7SYMzDaQlEv9XD7p7FjbEl+erUPJSOXMTt9r9LhwNcf72oLqKY
l2jACpiurMq4UCe7Ujp1wLFBhSC+oYtkCy57fAL2Ch9lmW0IRfrPcrqoHqqa+fTj
nw7XExyrUge8nBxYb88r+8TuQssgX9v6g/lnXlzLAYqso48Kk8Q=
=mFkL
-----END PGP SIGNATURE-----

--hX3xo7oV3hqqa3N5--
