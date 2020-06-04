Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360CDC433E0
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D153E206C3
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 07:35:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="neJv2SpF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="1hav8uPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgFDHfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:35:48 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:36821 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727916AbgFDHfr (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 4 Jun 2020 03:35:47 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 636F6CA7;
        Thu,  4 Jun 2020 03:35:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 04 Jun 2020 03:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=DFql89eN+vg8nTgoLm90whfJCDj
        qBPliO7y4T6EXp0U=; b=neJv2SpFCbvej0MeUmzzO7E7kX0b37D0zbbYiQb4NLz
        Rtbz0qZUfmvjEtk8x6DaO/Nh9ltaWe3OTwh6MJuvOL+jLFVthrgYNfP25bb2YmgQ
        sCyPS6GMRb5eIw/EAw9Ak/p6uruRLVhy4Ivj2foAMLVgE87Ba/JkOHbyOCYJaJOy
        gh3fzB8Cd+q+4rgxSaY78gxGbC/jk88ycoO7YhkGwK0zv8AqzSpM5gjs8uuY4axe
        IMUBPiSo6o1PzEmLflBVo0CZebsv7PvqRt96kq11azntl6x3OGxYqAp2uez/TBkV
        mwAR9ht82D2w5OMqiWcp9U5v0qeEjiz7BMTyUA09Q+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DFql89
        eN+vg8nTgoLm90whfJCDjqBPliO7y4T6EXp0U=; b=1hav8uPoTg2xAKDcJYeggP
        GLxzmjR8YhwZcULt2JTMaU0ZDlX0RrkfqeYTAzOm8NWiXlAvxbgT1Bt2o3EAOzuW
        0X5y6tXvjRbNNylZLP0fvmOEBaKZ8aw09rCeq0258kiYPk6Pzw9AZhCbNc218wFy
        cLLMb3yGLWGBbQLw7zZlz2hiX9mfNinIfklva4Kss2HN1pGmG36FYzMgjzHajLRA
        pmYosfz3li86p7E4Uiw9yKDxzu6bc5PnpugYaLm8v7Y4GwQIGVt+z8FxHGE0cjDw
        YyB1dd8TZegLw7NMu8fHgZOU3noWYa660E24mVbRB2yiWlOjLCWfjrmy0O58Yuxw
        ==
X-ME-Sender: <xms:UaTYXi-pQdEowj0xh11kl7QxLngtbmPjik543QwVeBl3nxHJEL5wTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrudegtddguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrddukeefrdduvddtrddujedu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:UaTYXitfPxhM8JhYUUPBwCCC3pmiFIUHTJxEYwPxJdSd2STnRsfd2w>
    <xmx:UaTYXoB_gD_o2zrGIHlRBA5vVcxPYvAR-DS6mN7PnPY55RzUov58DA>
    <xmx:UaTYXqe1Jkvvel5N7Sm4s6xUJigyAzpOsmicNr1uc4vHvhSzbckNxQ>
    <xmx:UqTYXpUMjhQ1n4Qbk8ucmitH3r5EXg3J8eANTkchDBTxy7QSg9Gc5g>
Received: from vm-mail.pks.im (x4db778ab.dyn.telefonica.de [77.183.120.171])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F1013061856;
        Thu,  4 Jun 2020 03:35:44 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f2b7214c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 4 Jun 2020 07:35:39 +0000 (UTC)
Date:   Thu, 4 Jun 2020 09:36:32 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] refs: implement reference transaction hook
Message-ID: <20200604073632.GA498923@tanuki.pks.im>
References: <1d1a94426f95d842e0e3ea6a1569c0c45239229c.1591086316.git.ps@pks.im>
 <04116cc57ab37eeb50bd51a065a7c06503493bf3.1591186875.git.ps@pks.im>
 <20200603165142.GA24049@syl.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <20200603165142.GA24049@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 03, 2020 at 10:51:42AM -0600, Taylor Blau wrote:
> Hi Patrick,
>=20
> On Wed, Jun 03, 2020 at 02:27:50PM +0200, Patrick Steinhardt wrote:
> > In order to test the impact on the case where we don't have any
> > "reference-transaction" hook installed in the repository, this commit
> > introduces a new performance test for git-update-refs(1). Run against an
> > empty repository, it produces the following results:
> >
> >   Test                                   HEAD~             HEAD
> >   ---------------------------------------------------------------------=
---------
> >   1400.2: update existing reference      2.05(1.58+0.54)   2.08(1.58+0.=
57) +1.5%
> >   1400.3: create and destroy reference   1.79(1.38+0.49)   1.82(1.39+0.=
51) +1.7%
> >
> > So the overhead is around ~1.5%. Given that git-update-refs(1) is a
> > near-direct wrapper around reference transactions, there likely is no
> > other command that is impacted much worse than this.
>=20
> This is a serious performance regression that is worth considering. For
> example, a 1.5% slow-down on average in reference transactions would
> cause be enough for me to bisect the regression down to see what
> changed.
>=20
> What are ways that this could be avoided? I bet that this would work
> quite well with Emily's work on hooks, where we could check in the
> configuration first whether a hook is even configured.
>=20
> Could this be integrated with that? If not, could you cache the result
> of whether or not the hook exists, and/or implement some mechanism to
> say something like, for eg., "only run reference transaction hooks
> core.blah =3D 1" is true?

I wasn't aware of her work until now, so I'll take a look.

Meanwhile, I toyed around with performance and tried out two different
caching mechanisms:

    - map-cache: `find_hook()` uses a map of hook names mapped to their
      resolved hook path (or `NULL` if none was found). This is a
      generic mechanism working across all hooks, but has some overhead
      in maintaining the map.

    - reftx-cache: `run_transaction_hook()` caches the path returned by
      `find_hook()`. It's got less overhead as it only caches the path,
      but obviously only applies to the reference-transaction hook.

In theory, we could go even further and cache the hook's file
descriptor, executing it via fexecve(3P) whenever it's required, but I
didn't go down that route yet. This would also solve the atomicity
issue, though, if the administrator replaces the reference-transactions
hook halfway through the transaction.

Benchmarking results are mixed, mostly in the sense that I can choose
which run of the benchmarks I take in order to have my own work look
better or worse, as timings vary quite a lot between runs. Which
probably hints at the fact that the benchmarks themselves aren't really
reliable. The issue is that a single git-update-ref(1) run finishes so
quick that it's hard to measure with our benchmarks, but spawning
thousands of them to get something different than 0.0s very much depends
on the operating system and thus fluctuates. On the other hand, if we
only spawn a single git-update-refs and have it perform a few thousand
ref updates, overhead of the hook will not show at all as it is only
executed once per prepare/commit of the transaction.

The following timings are for the case where we execute

    git update-ref refs/heads/update-branch PRE POST &&
    git update-ref refs/heads/update-branch POST PRE

respectively

    git update-ref refs/heads/new POST &&
    git update-ref -d refs/heads/new

a thousand times:

Test                                   master            ref-hook-no-cache =
      ref-hook-map-cache      ref-hook-reftx-cache
---------------------------------------------------------------------------=
---------------------------------------------------
1400.2: update existing reference      1.96(1.50+0.53)   2.00(1.54+0.53) +2=
=2E0%   2.02(1.54+0.55) +3.1%   1.98(1.52+0.52) +1.0%
1400.3: create and destroy reference   1.74(1.33+0.49)   1.77(1.38+0.47) +1=
=2E7%   1.77(1.36+0.48) +1.7%   1.76(1.35+0.49) +1.1%

For such a short-lived program like git-update-refs(1), one can see that
the overhead of using a map negatively impacts performance compared to
the no-cache case. But using the reftx-cache roughly cuts the overhead
in half as expected, as we only need to look up the hook once instead of
twice.

And here's the results if we use a single `git update-ref --stdin` with a
thousand reference updates at once:

Test                             master            ref-hook-no-cache       =
ref-hook-map-cache      ref-hook-reftx-cache
---------------------------------------------------------------------------=
---------------------------------------------
1400.2: git update-ref --stdin   0.21(0.09+0.12)   0.21(0.07+0.14) +0.0%   =
0.21(0.07+0.13) +0.0%   0.21(0.07+0.13) +0.0%

As expected, there's nothing much to be seen here because there's only a
single transaction for all ref updates and, as a result, at most two
calls to `access(refhook_path, X_OK)`.

Patrick

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl7YpH8ACgkQVbJhu7ck
PpQ56A/+NgqhwJ4RHSppiGOvPMYJAvzRlqhJrFZW8qxa52XFDKv+zJOh5cQHaExu
CW/7qDYKUA1UlAoNbYNrzJ3qXGlE7DJls/IwxmyihK/nmC7JR7ErUHTj8200Qhya
vRKwPm+4LM9f1ZunYtgiqQbR8Jk9HPvVvQ4XJexN0I4CmKf/0MgTpVd2WyiTOhCl
lMxafm1vA611FkM221h0mI3xhkr7JFyiSKzdysLQeUxGJW3RcG4QAPxhCEl1TIJV
A+cCU3RPLDiM3vgKmZ/k97oSGqL9okvjNayQ9UYPT7H7/PWGJ1osM6SvJBXSB6iP
4iq073tv9PWhO11dnJ1VZItCn7GShlTMcrUC2I+tNRws/jpfygd77zckM+BRTQGr
vYNjelGAjAqOhDvbAjSgDJnfrIfRGOUV2vtCTRoW9zDTP+gK2d9Xw6ZrgyifrFXN
SVvi3UAyb1lEjkWZFjbk4OIS+aa9qEsc4mPJCxe/4fecK6/63q3Cb606HELPX3dw
zpE5s1BusHV32lN1lQdbOO++HX1Jz6RYO3coPVdjqqH5fNRFyOZqL6aK4BvghwE4
AmLRQ/PobGD488ps9+rmdepBNqeYDt6FAzyf7SKAnyLi7x/gAfy8Rp7KVt/AgoGj
bi7+KkkgYqNeeUIJvPwGfRMjHmBLSBOp9g0sHcfKSmXpcG3/eEc=
=V+Yz
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
