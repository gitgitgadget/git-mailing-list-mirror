Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E736C433FE
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 13:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F3623EB1
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 13:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbgLKNgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 08:36:09 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:39949 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726313AbgLKNfv (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Dec 2020 08:35:51 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 6AC5F632;
        Fri, 11 Dec 2020 08:35:05 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 11 Dec 2020 08:35:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=GiY2s9cqepI5Q4k8Kdq5Ul2y4C4
        Q8RNfHGq1LhUn5fQ=; b=uc3TCmAVRIRPaH1UzHTd0oCpixPguyska/bml6xW/6C
        XKqyiceHLVlcHcdF5EO/oMWE4A89JFt4Z1sqA6Esew6mp46xaQYf2+Sqmeu1UNTV
        YpvO3cqZYXpdUzC2a1IQkM3HxXiw2jbHl4x7YUu84umMSesjO7BVnr5qy7pkL4bx
        qSVoZBJORhUnduFQwXWyNh3QenryZlPtEVGjBvu7+HUjMrO2fkzfXqRY1Xmiuoiu
        n3WvbEw2bsVnlJORZPDLIyuL4gp/Pw9d9s8hw2tqPJEZYM4w6hNIIjP1YiNH16xe
        uG3CwH013vDSndrMTITWmPCcVNVrQU7ce6u5+86Mrag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=GiY2s9
        cqepI5Q4k8Kdq5Ul2y4C4Q8RNfHGq1LhUn5fQ=; b=PryowzWXM57EsUMREoYioS
        ZYvFiZqq9g3ASc17z+AEAuL9F6zfNb4jB2ZolZz/ocApSsFbFBZ78b9Gv+kVeZYw
        HWt8FqeyMAvMQ1MbXV5lsXks3pydX4yZQe1bhS/3jkSVzHArO6wL1d97v7rAwvF/
        gfP+In8vk19HxV1WPmw2ozULGQ/79hYHpqjc3LNz4Lfe4Qn8G9GLDSMYIaNN6nJT
        Ha9rsVqKZOoeD19sdlDh5Y8OiQ+S/K6LeB01k4eYB5iwomhbD8wzcZPFrG3FwPE7
        qwVzGNq6aqhlI84juTUK6DHtTnAuURjUQB2GBwHi4kqOoCF4Q8AGIjhlUt6BidaA
        ==
X-ME-Sender: <xms:iHXTX0UHEPappiM0WhRF-w7LgQkPYZ88bWHC8B4-qXoX33K4w3ojRg>
    <xme:iHXTX2YkF45A8VV_w1D079YTRrefmmYMv3Idh4wCrfqoJiFrZykKP9H7yT2YdP-76
    bN32OJqE1cEfF6HkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekvddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpedtffejieduudelhedvgfetieefleehjeetvdetudeitdetvddtfffffefhvdfggfen
    ucfkphepjeejrddukeefrdehvddruddvieenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:iHXTXy1Z1_lna1EG-QqdNWaGDVeYOFWhyrHEEN3s98HeFcrwMApHCA>
    <xmx:iHXTXwi04WQiFSKySJnUpa2YTIiPhI81KgP2C0XCfS-z8ADLdBwm6Q>
    <xmx:iHXTX-bqIyvkk_ausRiLgMpOQmShpA_JQTcdDhCTWPUEdr7171nWug>
    <xmx:iXXTXytWhiU2qWkPhxtjJMTGVZr4us26QOHjNBn_flYtITemVBIpXA>
Received: from vm-mail (x4db7347e.dyn.telefonica.de [77.183.52.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id D618E240062;
        Fri, 11 Dec 2020 08:35:03 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id 153f8ba7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Dec 2020 13:35:02 +0000 (UTC)
Date:   Fri, 11 Dec 2020 14:35:01 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/6] config: allow specifying config entries via env
Message-ID: <X9N1hcGl2rKH+CUU@ncase>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <87y2i7vvz4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="OtMXDCRIWDlwBn0R"
Content-Disposition: inline
In-Reply-To: <87y2i7vvz4.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--OtMXDCRIWDlwBn0R
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2020 at 04:29:35PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Wed, Dec 09 2020, Patrick Steinhardt wrote:
>=20
> > this is the fourth version of my patch series which aims to implement a
> > way to pass config entries via the environment while avoiding any
> > requirements to perform shell quoting on the user's side.
> >
> > Given that the What's Cooking report notes that my third version is
> > about to be dropped dropped because the `--config-env` way of doing
> > things is preferred, I've now adopted that approach. I've taken the
> > patch which Peff posted originally (with one change strchr->strrchr) and
> > added documentation and tests to it.
> >
> > This patch series still includes my old proposal as it would actually be
> > a better fit for our usecase at GitLab I have in mind, which is to put
> > all configuration which applies to all git commands into the commands
> > instead of using a config file for this. I have structured the series in
> > such a way though that those patches come last -- so if you continue to
> > think this approach shouldn't make it in, please feel free to drop
> > patches 3-6.
>=20
> To add even more to your headaches (sorry!) I hadn't really fully looked
> at that --config-env proposal.
>=20
> As noted in my per-patch reply in [1] it will still expose the key part
> of the key=3Dvalue, and in at least one place (url.<base>.insteadOf) the
> key is where we'll pass the user/password on the command-line still with
> that.

True, that's one of the things I don't quite like about `--config-env`.

> I'd much prefer either your 6/6 over --config-env for that reason & that
> --config-env makes it impossible to pass a key with "=3D" in. For "-c" I
> don't think that's much of an issue, but e.g. with
> "url.<base>.insteadOf" needing to take arbitrary passwords + us
> implicitly/explicitly advertising this as a "here's how you can pass the
> password" feature not being able to have "=3D" is more painful.
>=20
> I mildly prefer Jeff's suggestion of just getting GIT_CONFIG_PARAMETERS
> to the point where we could document it [2][3] to both of those, but
> that's mostly an asthetic concern of dealing with N values. It won't
> matter for the security aspect (but I think you (but haven't tested)
> that you still can't pass a "=3D", but your 6/6 does allow that).

Documenting the format would be interesting, but I'm still not quite
sure how it'd be used then. Using a separate `git shell-quote` binary
just to correctly convert the strings to what git would expect doesn't
seem ideal to me, also because it would mean a separate process for each
git invocation which wants to use GIT_CONFIG_PARAMETERS. On the other
hand, reimplementing the shellquoting functionality wherever you want to
use it doesn't sound ideal either.

[snip]

> I do that that whatever we go for this series would be much better if
> the commit messages / added docs explained why we're doing particular
> things, and to users why they'd use one method but not the other.

Makes sense. The commit messages do mention it, but docs don't. I plan
to take your explanation anyway as it's a lot better compared to what I
had, and it does explain why one would want to use `--config-env`.

> E.g. IIRC this whole series is because it's a hassle to invoke
> core.askpass in some stateful program where you'd like to just provide a
> transitory password. I think some brief cross-linking or explanation
> somewhere of these various ways to pass sensitive values around would be
> relly helpful.

It had been the original intention, yes. And it still is, but in fact
the usecase has broadened to also use it to get rid of our global git
config in Gitaly. Which is a little bit awkward to do with
`--config-env` or `-c`, as now a ps(1) would first show a dozen of
configuration values only to have the real command buried somewhere at
the back. It would have been easy to implement though with the
GIT_CONFIG_ envvars.

Granted, we could still do the same by just using GIT_CONFIG_PAREMETERS.
But I'm kind of hesitant to reimplement the shell-quoting procedures in
Gitaly, especially considering that we'd put untrusted data in there.

Patrick

--OtMXDCRIWDlwBn0R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/TdYQACgkQVbJhu7ck
PpRLjQ//TNdFe4s2ClAjMNIw1LSqjDfIvfdUsMSWR+Y5uAlZd4pb4+Gf4Quwnvpj
Yp+zc5EUteUOLLgDobke5i4jXa8Bi+M2Rm7hbHg0SoIzmyIAIlvbchGNiLnmhMkz
ZigTRMUFuMfeoR8EaIVoLy6Io9SWUh0YFLV1YXk5rmZFj+NnXhktqC55GeweF86X
5kopKofpoCXWfp1nFPL70q2JN4lZnu7za3j+PfKNtuKm+E1R4UECw2DiJXcrp4GH
//C2GP6HXtbJUrJQMxrB/RK6O2u1QpjgZv+lD1oVSj1U4QElpoRkrlDSZ1QCrexw
I/oQGP5rALgJtAZnKc1G+1cAJPDPIN7hyoDq9g9wLb/y06WD/POKwWXd+N+AGF/c
1U0vo6PcjM3zw5ZCov2G25+OFe9FHRykmDS9U9RHHOAJHclSHhd1cSAdeCwtRfFT
gPeb+mrA7Df136bKgY2m9IYwj6gR93gFo/t8ycaMCCf9MwM3q9SND/JP0sVnCr/C
TXpR3eBeol3Jdzzqc+6lCrzbPH7Qd4fNzMfNyE+otsAPOXtrjDEe4I+LhcKR2z2x
aFfpa2CAXPcUvfm9vSzlUzpnlcgivejs6YSnpvT3N1vKYQV6Yc/wwNAi62OQN2RT
mFg+6A8hDgqmGU1EpzLwOO0MKbItTMxLlkERV9Z+8onoUDyOeLQ=
=PVoe
-----END PGP SIGNATURE-----

--OtMXDCRIWDlwBn0R--
