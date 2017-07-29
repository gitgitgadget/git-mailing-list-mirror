Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AD012047F
	for <e@80x24.org>; Sat, 29 Jul 2017 17:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752948AbdG2R6j (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 13:58:39 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42202 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752755AbdG2R6i (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 29 Jul 2017 13:58:38 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 899D8280AD;
        Sat, 29 Jul 2017 17:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1501351117;
        bh=nRE1anqjhrlvnW+Y1E2+7GhVBcU//hOEmc0vjJuLwnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wS8hVqe5LKIXFbvDhXeT7tO+vd5Qa8ukwWLEDswdzmYudsd4fbnAEWKRACoY/GNLK
         LP7MbrQy7NXwzHdLDSiNLM2SruS9MXEI4/4e+fSjnldCiOwXIFuPjN+YCFMj4gEqR5
         4G1KWFkA2hyNnTZHoZRDoj6aXsZengUp5k4jiO4XkVzPtdz0uLqANxo8FzFxd2YXGj
         9HdaS0rPltdwGjtdVT0y0k4h5CpD1VRMtvcplCIGQbbUZpr/s/EWXbBauhl3BKZeEG
         VPs8T/3KP7ePsQjtD6rAxXo+jJ9ik7dpi6u47WpovXsjVkKAZ4BVAnmXYZgnFxlQk6
         Q7o0/SXXDwNbEzPbKDWXXFjivqA4dr9FMRYcE6ERYgjZvyDavFtUEiLvJidqjQAW4N
         q32GG5L1OHHpYYZhZGbafVVmh8v+KXnV9r4ZKGII5lJpOv7KWBC+K8JwUu1InqN6BC
         7b/BBwhZdeHqX5Y2mZOTrvqrtjq7BBx9CnCBmvxOEsID157Icda
Date:   Sat, 29 Jul 2017 17:58:33 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] t6500: mark tests as SHA1 reliant
Message-ID: <20170729175833.4idan3befldn5vgp@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20170728171817.21458-1-sbeller@google.com>
 <20170728171817.21458-3-sbeller@google.com>
 <xmqq379gmco6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zorahjbmn3pzhxqv"
Content-Disposition: inline
In-Reply-To: <xmqq379gmco6.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.11.0-1-amd64)
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zorahjbmn3pzhxqv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 28, 2017 at 03:14:49PM -0700, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
>=20
> > The first test marked relies on hard coded sha1:
> >
> > 	# We need to create two object whose sha1s start with 17
> > 	# since this is what git gc counts.  As it happens, these
> > 	# two blobs will do so.
> > 	test_commit 263 &&
> > 	test_commit 410 &&
> >
> > The next two seem to rely on state from the first one, I did not
> > investigate.
>=20
> I am moderately negative on this approach, if it is meant to suggest
> the final shape of our test suite patch 1/2 started.
>=20
> This script may be a good example you can use to demonstrate a much
> better approach.  As the above comment in the test shows, we want to
> create two objects whose object names begin with "17", and running
> test_commit with 263 and 410 at this point in the test was a way to
> achieve that when Git uses SHA-1 as its hash.
>=20
> When we use a hash different from SHA-1, the exact strings 263 and
> 410 may change, but we should be able to find two other strings that
> has the same property (i.e. they results in objects that share the
> prefix "17").  Perhaps a better way forward for this kind of test is
> to parameterize these hardcoded constants and make it easier to use
> different values without having to change the rest of the script
> when we switch the hash function?  So perhaps have something like
>=20
> 	case "$GIT_HASH_FUNCTION" in
> 	SHA-1)=09
> 		TEST_17_1=3D"263 410" ;;
> 	CORRUPT-SHA-1)=09
> 		TEST_17_1=3D"something else" ;;
>         esac

One approach I had considered taking is having a helper of some sort
that wrapped a simple key/value store.  We could pass the wrapper the
SHA-1 value (or, if necessary, an arbitrary key) and have it return the
proper value based on the given hash function.

That does have the downsides that the values may not present in the
tests themselves, and that people adding new tests will of course need
to run the test suite twice.  But it does make the tests easier to read.

Opinions on the desirability of this approach are of course welcome.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--zorahjbmn3pzhxqv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAll8zMgACgkQv1NdgR9S
9otd3g/+JFwJhqVYD4T6noBMvnl38+dZmn7iU95XljZXSZxfcZ5UHGVGHPVkmNkd
Vlf42gdF+IoafxGMWo90NiM8xz4RHm2rEzVXuIX878XajYGt9oOxyNKUr0NssqnK
ykMkMVrBHiOo/51KVyClyCVjPd+U0BUkM5fKKRni8xbpv2UB9pHuJ7vNoiXKfAav
Es+DX8CMiK+qRqK94PnALHQ8x+j0oSri8UaUZyLr0Uv/D97n4/NFvW5B3wBDTZ6D
VA3DopgS1JYWfDeXV5aBDJj7RRrReSgup372M6vBmUYd4I0fBgCkv2RhGlPJaQUh
LOWREoQ4RCj5l/3CaI6f6643q2YjdIsGGhCFSUJAhx90RkmGvSmNUIoFaSjF9lCL
T5UNkIy/eYejxH6S+weS5VgIJy7eSNcP8CIQVnwYUUgpivutKtXRL+l+woAWHMrb
g6levYlhBuDadZ/1zB3RQxMWaunRiaFjhfkOz3QapX64s4WejzhsEXtu0yfhEcWT
XujR1Cr+6xMS7hfla6rXUsUiVaJw1sumrW1gmbAgvSfLPT9yRvHg4JbEatt2xfDF
GPuEYmd5OY5sCeyMIXqVeL1ewBTc+pXf1Qb/Nv/E+pW/ucLk5YjvyQpL9VMGm4Wn
vfAdi2spKF1cr8uCP2/cenAo/AGQw+n0gu0tDWLihmUB/v65zJM=
=IsDg
-----END PGP SIGNATURE-----

--zorahjbmn3pzhxqv--
