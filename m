Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E5EAA1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 23:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfH1X11 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 19:27:27 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:58458 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726787AbfH1X11 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 28 Aug 2019 19:27:27 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:60b7:b124:ccfa:d51])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 641EF6042C
        for <git@vger.kernel.org>; Wed, 28 Aug 2019 23:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1567034844;
        bh=vzytfBt19QgWFAe5CzwlaZIW00k6yS4cLLVOppkqMxE=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=nTc3EOdWjSjFMr8CMmB0M1aY2Wa4HntrMUbLFX1wPF8nzo/GJdpI+ukBFSUmmcu3r
         D1kgZcRXXCZNLCS+95ETAE7ZcaWYWWLdao3XxZ4RcwMObBVqqdEctDzSIFajrr79gt
         igI6hFg8o4vx0oZkWTZ3R3Q3B19ICd269bXr0a09OyN+nQhoB64SL9kVeSh2lgSwYm
         Z+++gX3LTvhVwJllBC6TUPafZAez8f/P9cLYrTtYppoQPiTSsY6aiBum5Tgq0q3ymD
         sLlVzXAa1mHNq351Egfm5qoiQomoRUornGrJDLW2ymGIFGdeo953JiAzlgwT4jLoIr
         c4SKGeGCMOVpFlr2Wf3tV9nvUBcFrKXMp+PrMfAtb3fOsO+E0AsD4j2e+vdivFlmfG
         mfWVATSA67URVoufgEXORMAeu474msiZE/XhwmZrlvO13pf/QyWNHd2QJWDGIiRTxW
         Uam417z4daj77J3Z0alyW59THrIXBVuK/5Qgq9P49/CdutgcKx8
Date:   Wed, 28 Aug 2019 23:27:18 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Re: Is git clone followed by git verify-tag meaningful?
Message-ID: <20190828232718.GE11334@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20190828203224.GE26001@chatter.i7.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ffoCPvUAPMgSXi6H"
Content-Disposition: inline
In-Reply-To: <20190828203224.GE26001@chatter.i7.local>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.19.0-5-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ffoCPvUAPMgSXi6H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2019-08-28 at 20:32:24, Konstantin Ryabitsev wrote:
> Hi, all:
>=20
> If I know that a project uses tag signing, would "git clone" followed by
> "git verify-tag" be meaningful without a "git fsck" in-between? I.e. if an
> attacker has control over the remote server, can they sneak in any badness
> into any of the resulting files and still have the clone, checkout, and
> verify-tag return success unless the repository is fsck'd before verify-t=
ag?
>=20
> I assume that it would break during the checkout stage, but I wanted to
> verify my assumptions.

We pass the entire tag buffer to GnuPG, which means that we verify
exactly what is in the tag: no more, no less.  Whether that represents a
valid, usable tag with meaningful data is not verified, although of
course it can't be changed once written.

If you trust the signer to produce valid data, then you can verify the
tag and know that the data is correct.  If not, then you probably need
git fsck to verify that the data is usable and meets Git's standards.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ffoCPvUAPMgSXi6H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.17 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAl1nDdYACgkQv1NdgR9S
9ot38w/6A7Coyu2ACNNW6UouHQdEhiUlWR1MxGUZsStTEuNwicK9wYFfgxOn+/yr
Y5NVXVMfDwgBmwO7l9egdXskXGtYxOwcp9JJZ/SZiFvlkaxTz6DCbnqwCZ5QMdQI
zC1kF66/u76JmMpqNzndgoLHMI5B8HNh0q8JIuVX03xYmB4lMF5GC4bvYRpsC+qy
meXasmhVzH+B5sOoeTvtGNR3GW+MYYhSFOvdlZrWseUQUewFTEtUWX0HUfR7A3lR
md7VC2C3yYrOZyZnqYkL7/YlHE/HHbZSqY8FkT2clws8wdFPxEaB6BdXap2wuoc+
SVaJV72Mc61Csw4gxiFwiAj8tO9X6kMlayAc77RQ0gvRTCP1m2QohrqLafSBN2hO
x9E4u+rzrBVrE6C/we+RktjsUWFquQfvchYFj2fAiVEmVDblrbJnj4eXnubHCIyj
l5ExRSOoUNglHd8LcjA3QMu+KZY9cg6v99L6BN5I9Cc8Wy4r/AxVlCoIHZl4KMQo
l7O1MEsTUhLx0MDla+LhB2icu7bCrTcJYD5qRzrSHQzyrZedWjCV2HUGl0Kxl8Me
8z0WPLt0QHbh+Jgq2BlwdyqFL+Jyx0CUBrPgj6y8G3aerwOECoStGgZMdMF0Vmjq
u3xWW7K//QCqiZh50eg++sLCMxPfCluWKjN9wuJA73ryG1CWw7I=
=goJu
-----END PGP SIGNATURE-----

--ffoCPvUAPMgSXi6H--
