Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140E6C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 07:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhLIHPx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 02:15:53 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:58199 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231664AbhLIHPw (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 9 Dec 2021 02:15:52 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 845295C0335;
        Thu,  9 Dec 2021 02:12:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 09 Dec 2021 02:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=qUCOCe908tVyivM9L4ngNYXl2fL
        oGS0Eaosa52do0oA=; b=IVBzcMtQnmXMdfSXLvikvy0xj7GYmuJ2qJATVa5aPu8
        rB1u+ILhHw6ULpirvyZSxa16wPpuE2rBqf59YRdHBPSPLO+WLe/PAt3CE2aBpEBV
        zlMtOd7ZtR9oMnermSdwARkAqocNUzzv8WVzc140NkHeCYc/X67j0UZkJIj0kqYD
        sMKLmwsTjUd8Kh00VE3Gn6yRjSDyrRBMjZqOfxtsrmgKFg1vXdZmhu5VL9WbCVqf
        fehqOVM+rXd0FxOvry0VPm1CWs5G9Ux9MtibD3PeZ83gK6WULoApBl0bkzSS1wjP
        9SrBg8oHfgWP1UUdfDy8Scwmv+4icdZlw9ilCEnEUyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=qUCOCe
        908tVyivM9L4ngNYXl2fLoGS0Eaosa52do0oA=; b=Fl3c4M9yT8QOrgtcbddBb3
        P6RdT9k03hX6A11ETbipEQnVzCY1eX4NDS/w6yrSVkWpsUdNsT5y0E/vd4qd6JLH
        s4vM2tge0IEcUfI/PIP9UHRXQUBegNBZqWl2IHsoC2TXNI9aa03CbGQMb7LlVhwA
        wWP6VNNMEtuUtQFyDbKD000Fz0COT7orGj3rsxHj2Kez7dzztRfjPnzDQwbmB2wp
        GkTbSdrnVgsQ94C1kfEON1dgzW7KhyWzItlowMXQS1rIDn8xvP7apPu29X6frgLh
        LruIJb2JTpaBTW9l7F2XDTPXv9RPD81GpSirLM6AE6OPL7QDvNGfZz6G4L4YiOxQ
        ==
X-ME-Sender: <xms:UqyxYUxdxQ_4DSAdGY88hAtU4q3L4pUjn2DOakgjfbpkllvdbzmmXg>
    <xme:UqyxYYQd4TpM1w3JH3CIYrsBuKyd4y1VhevGOWkLmyEY2FT_LiQoEHnzF5gnq5qKG
    I3Of7D0CNZM4hayAA>
X-ME-Received: <xmr:UqyxYWWBbvd_XEVaKEDjY-lYFw1CVcmv5MLrYqBzw3PqWMa-B45VkEUpKy7WU8oKXU4F4kAAzz_Pz9PAJsnDrDs3jNFMMaGvL8JkEgrCLNQx7UCnEbRKAVY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeelgddutdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:UqyxYShCTcZ_eO5L8HYd4SdrX6F7mRKBRHnUDtOBf0GZCL0U-En97Q>
    <xmx:UqyxYWDfeMHeNAaUp_E9cbkJ7kmDtI2y06NXxFlOQAkUFAP5KedJWA>
    <xmx:UqyxYTL4jaYBxztQTpXVyhQtJmPGlzZnpVWGYwsTfQTl4x3MjIFWKw>
    <xmx:U6yxYZN4_Kg0KMDtwAwdD5_v66_j9cNgRvBrGC94uJIiD5Jc6wLXSg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Dec 2021 02:12:17 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e1e21986 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 9 Dec 2021 08:41:12 +0000 (UTC)
Date:   Thu, 9 Dec 2021 08:11:34 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [RFC] fetch: update refs in a single transaction
Message-ID: <YbGsJnTQov6byXzF@ncase>
References: <259de62b26302c10f429d52bec42a8a954bc5ba3.1638886972.git.ps@pks.im>
 <CAP8UFD0Y-2aD6ywRFi49_emxzcLqrfyNpZ29fgsJ0FKc0njYqg@mail.gmail.com>
 <YbEgDBJPuGXQ+2t6@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sviOrU8wfjU+ur5j"
Content-Disposition: inline
In-Reply-To: <YbEgDBJPuGXQ+2t6@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--sviOrU8wfjU+ur5j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 08, 2021 at 04:13:48PM -0500, Jeff King wrote:
> On Wed, Dec 08, 2021 at 09:15:01AM +0100, Christian Couder wrote:
>=20
> > > Note that this slightly changes semantics of git-fetch(1): if we hit =
any
> > > unexpected errors like the reference update racing with another proce=
ss,
> > > then we'll now fail to update any references, too.
> >=20
> > So that's one difference between the "partial-update" and the
> > "non-atomic" modes, but what you say doesn't really make me confident
> > that it's the only one.
> >=20
> > Also are there people who are in cases where a lot of reference
> > updates are racing, and where it's important that in such cases at
> > least some ref updates succeed?
> >=20
> > If yes, then maybe the 3 modes could be kept and options for
> > "partial-update" and "non-atomic" could be added. "partial-update"
> > could be the default in case the reftable backend is used, while
> > "non-atomic" would still be the default when the files backend is
> > used.
>=20
> I think these three modes are hard to explain to users, because the
> failures which trigger for partial-update versus atomic depend on how
> things happen to be implemented. Just coming from a user's perspective,
> we might expect a breakdown like:
>=20
>   - problems like non-fast-forward are logical policy issues, and we'd
>     reject those without failing the whole transaction (in
>     partial-update mode)
>=20
>   - a system error like write() failing should be rare, and abandons the
>     whole transaction (in either mode)
>=20
> But there are some confusing cases:
>=20
>   - if somebody else takes the lock and updates the ref at the same
>     time, then that is handled in the ref transaction code. And so even
>     though it's closer to a logical policy issue, the patch here would
>     fail the whole transaction
>=20
>   - likewise name conflicts (writing "refs/foo" when "refs/foo/bar"
>     exists or vice versa) are more of a logical issue, but are also
>     handled by the transaction code.
>=20
> So I think we really have to teach the ref transaction code the notion
> of non-atomic transactions, or we'll end up leaking out all of those
> implementation details in user-facing behavior. I.e., the ref code needs
> to learn not to immediately abort if it fails one lockfile, but to
> optionally keep going (if the caller specified a non-atomic flag, of
> course).

That would probably be the most flexible approach for the future, too.
There's going to be several locations which could benefit from such a
change, where we do want to get the performance benefits of using a
single transaction while continuing to exhibit the same behaviour in
edge cases where only a subset of refs could be updated.

For what it's worth, I think that such a new mode should likely only
kick in when "preparing" a transaction: this is the last step before
"committing" it and would thus be the only place where the caller has a
chance to introspect what really has been queued up and what had to be
dropped from the transaction due to races or whatnot. As long as callers
get a list of all dropped refs, including why they have been dropped,
they can also still communicate this information to the user.

> For the files-backend code, I think system errors would naturally fall
> out in the same code. Failing to write() or rename() is not much
> different than failing to get the lock in the first place. So
> "partial-update" and "non-atomic" behavior would end up the same anyway,
> and we do not need to expose the third mode to the user.

I think I disagree here. Failing to write() to me is quite different
=66rom failing to take a lock: the first one is an unexpected system-level
error and brings us into a situation where we ain't got no clue why it
happened. The second one is a logical error that is entirely expected
given that lockfiles are explicitly designed for this failure mode, so
we know why they happen. With this in mind, I'd argue that we should
only continue with the transaction in the latter case, and abort on
unexpected system-level errors.

> For the reftable backend, syscalls are inherently covering all the refs
> anyway (we either commit the whole reftable update or not). So likewise
> there would be no different between partial-update and non-atomic modes
> (but they would both be different from the files backend).
>=20
> I suspect the surgery needed for the ref-transaction code to allow
> non-atomic updates would be pretty big, though. It involves checking
> every error case to make sure it is safe to continue rather than
> aborting (and munging data structures to mark particular refs as
> "failed, don't do anything further for this one").

I hope that it's not going to be that bad if we restrict it to the
"prepare" phase, but that may just be wishful thinking.

> So I dunno. All of my analysis assumes the breakdown of user
> expectations I gave above is a reasonable one. There may be others. But
> it seems like the behavior created by just this patch would be very hard
> to explain, and subject to change based on implementation details.
>=20
> -Peff

I think your analysis makes sense.

While I think that the three modes aren't as bad for a command like
git-fetch(1), the "single-tx-partial-update" mode would really only be a
special case of our current default, except that we use a single
transaction, only. Users shouldn't really need to care about this, and
we should do the right thing by default. The discussion mostly came to
live because our current implementation of reference transactions is
lacking the ability to handle this partial-update mode well (and it
didn't really have to until now), but pushing this technical limitation
onto the user is probably nothing we should do.

In the end I agree that we ought to extend the reftx mechanism to
support this usecase. While it's more work up-front, I expect that other
commands could benefit in a similar way without having to add
`--partial-atomic-reference-updates` switches to all of them.

Patrick

--sviOrU8wfjU+ur5j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGxrCUACgkQVbJhu7ck
PpR0cg/+NR+21GI+ifAtVIROt7r3mGk77vCYU+O+hoqfafrOhEMPuLJWK9V+hQgA
GV9WrErXXT2/30R2gQpx/v+QEZFXim/B8dmV5E7yYF0GX7oTzbtm5lrzjcioAMY4
sy92thqUWh6Pa34l+ZAxnH6VIgnIRqH+JBVs/CmKMkzgeJntYottWMzSXTiAurR0
3LPMeNR0nfFWsfkpx0tBNjEfBvR64ube5jOq64yhAuQMtUJggxEwMGPZfgGiSUmJ
I8gI8yHSS11JhFZoHf8Id9fP1EPBITqdhPvI0SnWZy0WL00HOOoEeyEZyv7HkX3z
5nRYmVrvDB1c5SgbZ9EzPck88TD0bar79DnZpL3BZW11Fl57bjskx6d1GZA3pDml
eclBUlzPCTA+L1GXRjn1iFku3SaVAiPSAgGLJhSc3IYdgMgRz6HjyeWOMVmpwDLv
Bn7QRYl8ssll64fvBLBuRXyhbpqZTkODKencMsdEzRFPkrCkE7Ole99pSDnvXs4h
e+wEQz9ntGmeg9LK2xFn2+FyswABBaImoV/plUrry314ZPlKsPw5rgLIDMcwiJBV
bmy0UzTbHCZSJvkM4+NYSF6zXcCr2Dq+uBClnDoKKb77fWhrq3dNKMZ5EZWN+qsN
IwWOQ4O/ByrJW0hJ7azXGAbSGxQ+csS667LQFENKLYiABoRUgBE=
=mLrL
-----END PGP SIGNATURE-----

--sviOrU8wfjU+ur5j--
