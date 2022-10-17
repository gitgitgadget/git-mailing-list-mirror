Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19C1C4332F
	for <git@archiver.kernel.org>; Mon, 17 Oct 2022 00:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJQAvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Oct 2022 20:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJQAv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Oct 2022 20:51:29 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE3E4D138
        for <git@vger.kernel.org>; Sun, 16 Oct 2022 17:51:27 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id D5ED85A569;
        Mon, 17 Oct 2022 00:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1665967886;
        bh=wlcs9vHb6LwtycTmzfLGr6asZVNFzexKFKYALZUxVdQ=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=N4QQ1iisGtH/GfnK2LJ4TY02bN2I8x6xjqKpYvcpSvs2sO6SnzkcqtABSAar/aejw
         icmx3346UViiAvoigYzefBLdzAIbQTji7EXLFq1bQNLLRnUNYQ1XCNkwrhr9CdY7ap
         Kt9jrfleXc0eaCb6RcyCOsgAoo9IPXmSiJ7mmQlKXkRuK3zM5K6JdRQf3O8s3ThcHl
         SiEQwiGX4EWIbdT4BytQHkzddWfJGUr0Xx6L6LghjBgPUU8FN5iAguZfcETfTbOkZA
         fwGwawaPOxbTsXiiY9rZp/xrgvd7EttJZejDjkz7e3dPHvm3QFLMfEkl2iwgJm12t6
         OGRAjjpqChT4ITCF9nlttQxyoI23csGIkzLakIR5DaNdVM3wPZZt9+nOcHxlrGJvVO
         f+9pQfobLKbp/nsY8ABKaYcFuxUleUg+rqyMpZogAFsU05wzcXOxbboMxe3JWJJMxt
         h9RCS2n1uh5J5/gIY9WflqdxlF1lSPJ5u6jYsa4uXGdBap4V6KU
Date:   Mon, 17 Oct 2022 00:51:25 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     kpcyrd <kpcyrd@archlinux.org>,
        rb-general@lists.reproducible-builds.org,
        arch-dev-public@lists.archlinux.org, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de
Subject: Re: git 2.38.0: Change in `git archive` output
Message-ID: <Y0ynDbG8CxwAt4Fj@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, kpcyrd <kpcyrd@archlinux.org>,
        rb-general@lists.reproducible-builds.org,
        arch-dev-public@lists.archlinux.org, git@vger.kernel.org,
        gitster@pobox.com, l.s.r@web.de
References: <20b14207-a6f2-033f-3419-271662bffba9@archlinux.org>
 <Y0ybi66K40+uH+im@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mGfpTbS1UpdKKPPG"
Content-Disposition: inline
In-Reply-To: <Y0ybi66K40+uH+im@coredump.intra.peff.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mGfpTbS1UpdKKPPG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-10-17 at 00:02:19, Jeff King wrote:
> Interesting. For a small input, they seem to produce the same file for
> me:
>=20
>   git init repo
>   cd repo
>   seq 1000 >file
>   git add file
>   git commit -m foo
>=20
>   git -c tar.tar.gz.command=3D'git archive gzip' \
>     archive --format=3Dtar.gz HEAD >internal.tar.gz
>   git -c tar.tar.gz.command=3D'gzip -cn' \
>     archive --format=3Dtar.gz HEAD >external.tar.gz
>   cmp internal.tar.gz external.tar.gz && echo ok
>=20
> but if I instead do "seq 10000", then the files differ. I didn't dig
> into the actual binary to see the source of the change. It might be
> something we can tweak (e.g., if it's how a header is represented, or if
> we can change the zlib parameters to find the same compressions).

I will say that trying to make two compression implementations produce
identical output is likely futile because it's almost always the case
that there are multiple identical ways to encode the same data.  Most
implementations are going to prefer improving size over consistency, so
there's little incentive to copy the same algorithm across
implementations. I believe even GNU gzip has changed its output in the
past as better optimizations were implemented.

I mean, don't let me stop you from trying to tweak things to see if you
can make it work, but in general I think it's likely that some
divergence is going to occur between implementations no matter what.

> I don't think we make promises about stable output from "git archive".
> We've fixed bugs in the tar-generating side before that lead to changes.
> But if we can easily make them the same, that might be worth doing.

Since this is on the reproducible builds list, I would be interested in
working with tar implementations to specify a profile of the pax format
that _is_ standardized, stable, and consistent and that Git and other
implementations could use to produce bit-for-bit identical tar archives
across versions, since this is a thing lots of people seem to want.  (If
that's of interest, please contact me off list.)

However, I don't think that trying to do that with compression formats
is likely to lead to a productive work product, so users who cared about
reproducibility would need to compare the uncompressed output.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--mGfpTbS1UpdKKPPG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.39 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCY0ynDQAKCRB8DEliiIei
gVvkAQDpIhiXbprsTxSdXwnZG4vQm/+X7uYxPnrGq10t0FXGhQD9HHcIYXTaYFdH
0/I44TmdIOMJIKb+nlKvP+Ul65bkZws=
=iptS
-----END PGP SIGNATURE-----

--mGfpTbS1UpdKKPPG--
