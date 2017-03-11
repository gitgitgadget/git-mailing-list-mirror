Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BE811FC43
	for <e@80x24.org>; Sat, 11 Mar 2017 00:10:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755414AbdCKAKn (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 19:10:43 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:44152 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755129AbdCKAKm (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Mar 2017 19:10:42 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 91C15280AD;
        Sat, 11 Mar 2017 00:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1489191039;
        bh=aKa241GnJBs2x9h2UuC2/NqOFCSnc7tYKoG6eFIK9C4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m7QV5MIA1x+XRDQNFmfLXfEPbziNdPqlE2XgWsMoEK8mZtvUeS0YmbuYEyjbrVHWQ
         ImH6qTU1iAy7bzoVk+dhkI8BK7Q5TR38Rgch6/oiDrTLVj2Uix+yYYoY5TAlkzmpou
         2SoMEyNLbgoJd1Arkhn0hhOkoIZPvrSSQoe/R71YpbWD+9yzYlhiabRYlLcrAAYcML
         upgi9ItVvJIpx0AE1g0kZEAd5e7JLotmYA7KRKoQNUCE2MyzRwjxIwx5JSh52psCH6
         HjWJr2ImrPkS8rX5mM5RgqXObGGQFgGKwLtwpB0Yu9AGYPseegd8VR1suFMi4MRuDV
         67OPyJXcMEZYKpDs4/8GeWvaGu1rjch7nT7skU358yq1/vPNjFOgRD5gbsS4/d321Z
         99ITWblP9LuTDaQHXGZCmlGmeDwpwyKVQ8kr1H1lJfeY8WyT5sfoJRC8ESNWkEDkdv
         aCobYU2xbizMCOIZxkE7bPpwC464w4NhWKsgKtNvbgOY84hdq9S
Date:   Sat, 11 Mar 2017 00:10:31 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
Cc:     git@vger.kernel.org, gnupg-devel@gnupg.org
Subject: Re: Stable GnuPG interface, git should use GPGME
Message-ID: <20170311001031.f5534omsrzkrzfzb@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Bernhard E. Reiter" <bernhard.reiter@intevation.de>,
        git@vger.kernel.org, gnupg-devel@gnupg.org
References: <201703101100.15214.bernhard.reiter@intevation.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="saxsujudr2czbudl"
Content-Disposition: inline
In-Reply-To: <201703101100.15214.bernhard.reiter@intevation.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--saxsujudr2czbudl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2017 at 11:00:07AM +0100, Bernhard E. Reiter wrote:
> My use case today was signing and git by default found the `gpg` binary by
> default and the command failed. The reason is that I have `gpg2` installed
> and most applications use it right away. So git failed signing because
> the .gnupg configuration of the user was not ready for the old `gpg` whic=
h is
> still installed on Debian GNU/Linux for purposes of the operating system.=
 If
> git would have used libgpgme, gpgme would have choosen the most uptodate
> version of `gpg` available (or configured) without me intervening via
> gpg.program. Now because of this problem you could adding a check for `gp=
g2`
> and fallback to `gpg`, but even better would be to move to libgpgme. >:)

There are a couple potential problems I see with this approach.  First,
I'd want to know whether gpgme supports gpgsm, which I know some people
use to sign commits and tags.

Another issue is what happens to the git verify-* --raw output.  Some
people want the ability to script signature verification.  This can be
really important when you have automated systems verifying tags and
commits.

For example, running the following commands, we can determine that Junio
signs his tags with SHA-1 (algorithm 2), while I sign my commits with
SHA-512 (algorithm 10).

genre ok % git verify-tag --raw v2.12.0 2>&1 | grep VALIDSIG
[GNUPG:] VALIDSIG E1F036B1FEE7221FC778ECEFB0B5E88696AFE6CB 2017-02-24 14879=
62205 0 4 0 1 2 00 96E07AF25771955980DAD10020D04E5A713660A7
genre ok % git verify-commit --raw object-id-part10 2>&1 | grep VALIDSIG
[GNUPG:] VALIDSIG 5FC3A781776B26DF87F70C37BF535D811F52F68B 2017-03-06 14887=
60639 0 4 0 1 10 00 88ACE9B29196305BA9947552F1BA225C0223B187

There's literally no other way to get this information at the moment
(which is why I added the --raw option).  A gpgme implementation would
need to expose this same information, at which point, we might as well
have used gpg directly.

This is not an idle consideration; we have automated systems at work
that update software automatically and submit it for human review,
including verifying signatures and hashes.  This saves hundreds of hours
of staff time and results in better security.

Because the amount of the gpg API we actually use is very small, a user
who wants to use a custom signature program (say, OpenBSD's signify),
can actually write a simple wrapper that mimics it and use that instead.

Finally, I work on a development system where work is done both as an
unprivileged user and as root.  Because I use the same socket for both,
GnuPG screams bloody murder that the permissions are wrong.  I know this
is secure in my scenario, but without a custom wrapper, I have to deal
with GnuPG polluting my terminal every time I sign a commit or a tag.  A
gpgme implementation would need to honor the same wrapper script or
otherwise not scream to the terminal.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--saxsujudr2czbudl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAljDQHcACgkQv1NdgR9S
9ouA1hAAm9jxfmBC6nwWc5BCnbTZiLfGn9cZwnvSmcNct50T5WZjuhd3NA7MZEYS
W5UjL7zRHP9nZQjVTRtzOPTdkbuDFLPKbfv9amFxTk4GFQp6shRU6nFzPyFwftMf
u+QeVdZCGQo+W6aNar/LfwOQlHygjJVOQGSEkTnpSIUtyTtyd+0QYOE5jUtGYkSs
njWBgIcw1hL/wZmmf1u1sbfZwVC/3Gr0WgiJ8xdR/fSuNAf8IFVBKhSd4ortqZD8
btvt274PMELhy6O+OmmX2AUkIPlGtOqEZqY03ozoM7uyhTZjYfEijyR9M4dCfZy9
CQSdge+FDcNn8epYR0udY1AmM9B3kXQSbDMGPQTfmtJD+QM2YjpJGgKhrbdC3LoU
homLb69Z8pyrUs5GsPr6iVJ5Vjir9AU9z0+mOhOc+8zUKp9TvuxJ4MLT4XG7MkNd
lmZTp1K8j2ZMXu2qR1gqXFXE13JtrPyXOXom03gF12v5UzA2cupZrLLwo/H3zbaU
lpLeV7bhaqaHIZIAize8gD5ogOEPSNAFqDLfuW8v+i3+XhrxZ4UYQbOrE0cebHxY
9dhioXPKDudzr6pme+5T+zNqCpGOGpm7dgMJcGTzCgk3876GlXbNe6EGIh5G34Sk
jXSYFA1vSr+Y4i3zLe84mmZZYPsD4N55z+ALLhW5U49TgORsbSQ=
=9oCw
-----END PGP SIGNATURE-----

--saxsujudr2czbudl--
