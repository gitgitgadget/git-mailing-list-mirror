Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB0E2201B0
	for <e@80x24.org>; Sat, 25 Feb 2017 18:51:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbdBYSvA (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 13:51:00 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:40918 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751695AbdBYSu7 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 25 Feb 2017 13:50:59 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:f8da:200e:3546:3090])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A2386280AD;
        Sat, 25 Feb 2017 18:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488048656;
        bh=irq2AyALS2V+abofTL96L+EUWv+TRbMkptBLgnfgJqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dp5G7pvN+2W1KTQBc54hqlF93+RlDW4SI501LlQDgI0NdDIhgKiK1zaMCT3RjC105
         zwK9VKI3K+2Sdh+z2/iCvHl9ilLM2IpmLhhdUBCnTD5HCEdvJ0AlBTz2E0GXuqaRGL
         lz7SSRFQjBbyW93t5f4JVNkTNfAQv4sRbXYQ+6EpZXFqt5GfKQqxNBf4FDtwD82BnV
         GYGBGrslehrrHTij0HTa45TifO32U9WzBXN62sdBA7goUq/GH/WpL0syH1uHkjKfPk
         IWmQBFPOVXLBMe4+j5RRKRW5EVpRcemQ/UuHMRAeCMMVwamOp2lMA9gestbdvB1CHi
         UOBHTxy3cexOHCS2H4oA9jY2UYmuapFuMqmoqlsHeHkW3oOsvSjeso0OJ6fIU1wa+2
         +OCd5LYW6fkiuVW1oS7KbFyEUkG77yOqF/paYBhNhnkiL95fV4lWeXM9JlFlh1EEic
         L7pAhJkuUc2EQiaXE4YLC4OrYQzknesK79dwQCf91w7yvM7PU2b
Date:   Sat, 25 Feb 2017 18:50:50 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
Message-ID: <20170225185050.t6e5txrppofgelsf@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rg4ykdx3gehd6zye"
Content-Disposition: inline
In-Reply-To: <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rg4ykdx3gehd6zye
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 24, 2017 at 09:32:13AM -0800, Junio C Hamano wrote:
> Ian Jackson <ijackson@chiark.greenend.org.uk> writes:
>=20
> > I have been thinking about how to do a transition from SHA1 to another
> > hash function.
>=20
> Good.  I think many of us have also been, too, not necessarily just
> in the past few days in response to shattered, but over the last 10
> years, yet without coming to a consensus design ;-)
>=20
> > I have concluded that:
> >
> >  * We can should avoid expecting everyone to rewrite all their
> >    history.
>=20
> Yes.

There are security implications for old objects if we mix hashes, but I
suppose people who want better security will just rewrite history
anyway.

> As long as the reader can tell from the format of object names
> stored in the "new object format" object from what era is being
> referred to in some way [*1*], we can name new objects with only new
> hash, I would think.  "new refers only to new" that stratifies
> objects into older and newer may make things simpler, but I am not
> convinced yet that it would give our users a smooth enough
> transition path (but I am open to be educated and pursuaded the
> other way).

I would simply use multihash[0] for this purpose.  New-style objects
serialize data in multihash format, so it's immediately obvious what
hash we're referring to.  That makes future transitions less
problematic.

[0] https://github.com/multiformats/multihash
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--rg4ykdx3gehd6zye
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlix0goACgkQv1NdgR9S
9ouOMxAAh7kO7ymkmFEe3NLyS+YWApYEzmvbefsEMLMv+5CcX5bPtRsfuE7bOC+9
ZBfBwq5QomlRVaM5TydURUS5hdVnEQdKlRoaknIs0IAl7mL3Z4RkatWpQVMRkHtM
OmHQuXgCIFUQ7tR6apYZZk5o/wVKKFm47lXXeSsT/TXaSWHB2QbTYYnY5G3m6FzD
xLUACzRHTezmt2qlwmakB9mtEeOKtMpQvTSljVjp69z5/i8HnqBS62xI1bsbnCiG
wTy713xaHFo5TNqrcur1KZGZFWsFQ2xBjx3fRnJWfntqitE1YieKJ4OwIk7PGS8u
9pactLL0OBl1k9DqOicamjJccWK7rjAoB1h74N057aDvG/urkdkcLXyzcDosmewK
ibNWELrR/psJiprgn/KNSLPAZN2mHpACyUrs09+siFhVBlcP37rCn1+Z42caKTrY
rDlFtFiu6vSehLpgsh7ouG6I728nheNUBxASLJZih4qGJRAn8m1gUHnNiUfvBlvD
fAy6yJI7CJV1ZmFyE+r3jKgnDGDfVjjVcbbVzZYqQr/GkZ+YsqTErtCYFUIwKsS1
l+TB7jGVUvtfRuXsDZCQZe+nr3EYEKRBPHQvQ/tlqSVLC62+yGkwSnW3rbkGx9+P
nl0y7L/fvTkR1q4H/WrxoXpC/2RcVFJMzDeEuy0+2phgnRhucyE=
=nVCj
-----END PGP SIGNATURE-----

--rg4ykdx3gehd6zye--
