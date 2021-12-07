Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE569C433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 08:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhLGI2P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 03:28:15 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44887 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232440AbhLGI2O (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Dec 2021 03:28:14 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 39A0E5C0254;
        Tue,  7 Dec 2021 03:24:44 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 07 Dec 2021 03:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=ps8pFRNlkDbnXRWkCj+h2JNsHbx
        1/XZhjp3xSFpOR60=; b=VwbtYT7ObTvhHP0kcXQ4tr/aH7eqW5RKxLexmbPKDxw
        GQ2sRLmtGqUV5CcGihCsLWPO6TCJR09tq80DSNr5BUeyP5xKJOlB+cNY2JhtlfKz
        zzpyKARFiZXHlHWu+8SGwMMC5K0FjJ0kekG3hZCEW9vkISaks8qlb2bK3P6yU10q
        nEoNsMyjh0ynn79ln238boUvXMXkOwFui58Uy2Tdb7GfVPEAvHeJJ5YtW7V17G9Z
        U7whHEmjYsG5PF4rEbr4o75R8cnuRioO0RfWxYoRm9oVs7F0UybgnJ31djzkLCvI
        mfluoMuSCAeEpmquBVoZ6da6ExuX23hsCnOxCbPiNgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=ps8pFR
        NlkDbnXRWkCj+h2JNsHbx1/XZhjp3xSFpOR60=; b=DkWSKWUPx4DTZMBFy3c/Uy
        8XSFnFUQBHO2I+IGcw06Fy+oH9wNplaH83fI4+skDC2g/RdEPQx/1JqcPAURhLD8
        HLUWn1d9MgrkZZ9RGYrQ1LP9rHPhRhWdIpu72GSrg8Xeoc40kDLwLl/z6dVOEfOB
        piHuXc0U6m8FfMpfXelO4OoETABHgVTDMADq4U3Zl6/aqmK4qFiD+QKgIkrXdXAZ
        jCgVWMnBu7zYc5jz7Jg8Z0nMFzZtju7tXLvRfoVvLb5M5t/nRqKDBTl6k/Ubt7tH
        swYHltx3HIvaBTvNLa+fjgAItFWBMIVLd6MRSTBz2rNDX1MFsk0NSIkMdv4brylg
        ==
X-ME-Sender: <xms:SxqvYdNBzlug80-BGGTKH_eo0WgHhxVAjL4jqyIOTK6PSGDHe8jv7A>
    <xme:SxqvYf-0b1ZDy0enrha4BT-9OC0JYA5W8w4y5DOyJmQvU89JMUuLsy6vh0Gv4Xlxh
    GMtkqg2QSnctZ0m9A>
X-ME-Received: <xmr:SxqvYcSCoR42brjcv9L0_c7WfL5tWW1niXs3ZQKVR0YBnF2LqpPFAxK9uYCU8Arq0j9piaHcHR4plH94NSSEHQ3JAlCtqAqTJpUmIhq_EBu-MThT_AgDu7Ez>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrjeeggdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejjedtiefggeekgfejheevveejjeevuedvtdeikeffveelgeelhffggfejjeeffeen
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:SxqvYZsx1O_Zgy2G19KWgowWXxOi0FOa6SL3WoDgWbm37MGfBuV27Q>
    <xmx:SxqvYVclEiOBDXWMCSSraKnv_1wrfASPvjnD_mOLgiX6qlDxwp6KJA>
    <xmx:SxqvYV2sYJu3fI6rDNmH3ieMHuDPeRaaTQyk-Qf1vioHkZ6sPd3OTA>
    <xmx:TBqvYWrm5fVkCOfzotIaDNh2jP58quA6qItvna8av8IbkgbIuwyLQw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Dec 2021 03:24:43 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9f05d633 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 7 Dec 2021 09:54:23 +0000 (UTC)
Date:   Tue, 7 Dec 2021 09:24:00 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Waleed Khan <me@waleedkhan.name>, git@vger.kernel.org
Subject: Re: Bug report: Strange behavior with `git gc` and
 `reference-transaction` hook
Message-ID: <Ya8aIAAOlValUL2o@ncase>
References: <CAKjfCeBcuYC3OXRVtxxDGWRGOxC38Fb7CNuSh_dMmxpGVip_9Q@mail.gmail.com>
 <CAGyf7-FoRyVtQHa2ETQtRA6fD7x0GDhKVPg+eAajhgPNrsw_OQ@mail.gmail.com>
 <YZaWqTwPOyQz0/mu@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jJs51Zi5GOLT8umN"
Content-Disposition: inline
In-Reply-To: <YZaWqTwPOyQz0/mu@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jJs51Zi5GOLT8umN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 18, 2021 at 01:08:41PM -0500, Jeff King wrote:
> [+cc pks]
>=20
> On Wed, Nov 17, 2021 at 04:52:46PM -0800, Bryan Turner wrote:
>=20
> > > The expected behavior would be that the latest reference transaction
> > > hook refers to the state of the references on disk. That is, either
> > > `master` should point to 0 (be deleted), or it should have said that
> > > `master` pointed to `e197d1`.
> > >
> > > But if we actually examine `master`, it's set to `e197d1`, just as you
> > > would expect. The GC should have been a no-op overall.
> >=20
> > One of the subtasks of "git gc" is "git pack-refs". If you inspect in
> > more detail, I suspect you'll find that "refs/heads/master" was loose
> > before "git gc" ran (as in, there was a file
> > "$GIT_DIR/refs/heads/master") and "packed-refs" either didn't have a
> > "refs/heads/master" entry or had a different hash. (Loose refs always
> > "win" over packed, since ref updates only write loose refs.)
>=20
> It seems totally broken to me that we'd trigger the
> reference-transaction hook for ref packing. The point of the hook is to
> track logical updates to the refs. But during ref packing that does not
> change at all; the value remains the same. So I don't think we should be
> triggering the hook at all, let alone with confusing values.
>=20
> This snippet shows a simple case that I think is wrong:
>=20
> -- >8 --
> git init -q repo
> cd repo
>=20
> cat >.git/hooks/reference-transaction <<\EOF
> #!/bin/sh
> echo >&2 "=3D=3D> reference-transaction $*"
> sed 's/^/  /'
> EOF
> chmod +x .git/hooks/reference-transaction
>=20
> echo >&2 "running commit..."
> git commit --allow-empty -qm foo
> echo >&2 "running pack-refs..."
> git pack-refs --all --prune
> -- >8 --
>=20
> It produces:
>=20
>   running commit...
>   =3D=3D> reference-transaction prepared
>     0000000000000000000000000000000000000000 77bcab0d950aee3021e8aa13a15d=
40e7a9a5f71b HEAD
>     0000000000000000000000000000000000000000 77bcab0d950aee3021e8aa13a15d=
40e7a9a5f71b refs/heads/main
>   =3D=3D> reference-transaction committed
>     0000000000000000000000000000000000000000 77bcab0d950aee3021e8aa13a15d=
40e7a9a5f71b HEAD
>     0000000000000000000000000000000000000000 77bcab0d950aee3021e8aa13a15d=
40e7a9a5f71b refs/heads/main
>   running pack-refs...
>   =3D=3D> reference-transaction prepared
>     0000000000000000000000000000000000000000 77bcab0d950aee3021e8aa13a15d=
40e7a9a5f71b refs/heads/main
>   =3D=3D> reference-transaction committed
>     0000000000000000000000000000000000000000 77bcab0d950aee3021e8aa13a15d=
40e7a9a5f71b refs/heads/main
>   =3D=3D> reference-transaction prepared
>     77bcab0d950aee3021e8aa13a15d40e7a9a5f71b 0000000000000000000000000000=
000000000000 refs/heads/main
>   =3D=3D> reference-transaction committed
>     77bcab0d950aee3021e8aa13a15d40e7a9a5f71b 0000000000000000000000000000=
000000000000 refs/heads/main
>=20
> I think the final four invocations should be skipped entirely. They're
> pointless at best (nothing actually changed), and extremely misleading
> at worst (they look like the ref ended up deleted!).
>=20
> -Peff

Yeah, I agree that this is something that is totally misleading.

For what it's worth, we also hit a similar case in production at GitLab,
where we use the hook to do voting on ref updates across different
nodes. Sometimes we observed different votes on a subset of nodes, and
it took me quite some time to figure out that this was dependent on
whether a ref was packed or not. We're now filtering out transactions
which consist only of force-deletions [1], which are _likely_ to be
cleanups of such packed refs. But this is very clearly a hack, and I
agree that calling the hook for=20

In the end, these really are special cases of how the "files" backend
works and thus are implementation details which shouldn't be exposed to
the user at all. With these implementation details exposed, we'll start
to see different behaviour of when the hook is executed depending on
which ref backend you use, which is even worse compared to the current
state where it's at least consistently misleading.

As Peff said, the hook should really only track logical changes and not
expose any implementation details.

Patrick

[1]: https://gitlab.com/gitlab-org/gitaly/-/blob/3ef55853e9e161204464868390=
d97d1a1577042d/internal/gitaly/hook/referencetransaction.go#L58

--jJs51Zi5GOLT8umN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmGvGh8ACgkQVbJhu7ck
PpTCFQ/+KitA3RK31gv+9xuds1fIqH4IwvMH1AzLt5uZmR4Wb6lMo1XZEWU1GAlW
wHSdu6qFt9bfdUP5xGm/mB9xuSFc3rbUEmzWKIRQHGOHiDO0srsqopExByi3cKjh
28R1t/57/XjKyCbyKaSgdST328EhK1KWfmIFBxaoIqlQTBdZkJMoahIe/i7Lflsy
gLgEhQDXvhrnFsvtuVyL9D4bM3lorb+DOW5CfQtmAVcdcZFpXiIDxitw1Jl1AopE
9ijXxsikds5J70lHHw7zNAWvoqB7lqT6CfvRNJNr6bPXY39Mz0ms2noV0oofySNl
EjsYW0NoqcRM4bDCt+f+vKIh2S3XhiG2RjmxwL6zI3Dsz3rGAtF7jp/oPPYJ/mMa
JntPEgNfjMRfXtV/cIwulE6TWjWL96TVJo+Tr9JyuM4RYPUNiMQT2nRrykFVWy+s
/C8R1NrJyHoHNSDd9mxpv59DGG/JsEk8Iv4ZbHkb+QE3mYPf+xy8ehA087Ter0f+
SMlLq87AmLAdU1u6WNwUIVvvqe1/VmNRJjuHuFWrwwjUI/xdWZtsf7SJgoNSbZqx
cDZAxnLwcwTAAZC9EOghRh8neZZW9mcKB3EZu443a//18zwomBxrtY4OzGpiSm4s
zN1s0dbxMqoe4tNGBtqXpzHlMc1XKbOj/dLXuFEKiefisVg+tcg=
=FsWd
-----END PGP SIGNATURE-----

--jJs51Zi5GOLT8umN--
