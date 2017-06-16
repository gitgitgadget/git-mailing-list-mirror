Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E71C720401
	for <e@80x24.org>; Fri, 16 Jun 2017 00:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751763AbdFPARq (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 20:17:46 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:56692 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751644AbdFPARp (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 20:17:45 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id F15C3280AD;
        Fri, 16 Jun 2017 00:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1497572264;
        bh=KRVbZiuqxZMVQ8SXH0PwswVVYyC022KexmGcAqRxG14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3nnGqTkW4fZD98Lqugy9QIINT+UIHoAVwx4ojUkH+/TNFPpFYAWp26hTm+p49skX
         ZF9SxtZ0WXhTemydmfr5zSKpcVyMdIOg8kHhnAEzW4VfPYwFiEMvBTneNubNnqNdtn
         bC0NONpySHh9rXQFKtHSDqEjupw4YYA7VxHbbzvothywj4qTNFxP9lB9eJSC+gEaLV
         THZGSRa2Idrw6DfvmWZ2ZqszJr6cu7Oz3vCz7iBBTx7ZHRTLoECn81/Xpx4+qNkZgp
         d6AsoAaNE01KFp+yJeCju30RrYkW/Sjiundy38rX/wparuoNi1fqZvnRQ8cLvkFpbe
         Zq0d7wZUw5Q7oI64syVO1EvoyKhLQM+dUt7B+Ra/Ajr8egxXKNw4gEksw6rIYMYH3L
         ShLv7/JoSUdBtX4YYtOvdr2MBgdHY/cMW/0xTC1vECuGjwHXrplkmYGIHhB5DuQK5k
         m3EmDdNOKLiUz2VNpu8bRKfFuPISDbeHm0Ov+1VYn/HOorlNwT0
Date:   Fri, 16 Jun 2017 00:17:38 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Adam Langley <agl@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
Message-ID: <20170616001738.affg4qby7y7yahos@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Adam Langley <agl@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>
References: <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
 <20170306182423.GB183239@google.com>
 <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
 <20170615110518.ordr43idf2jluips@glandium.org>
 <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
 <87shj1ciy8.fsf@gmail.com>
 <alpine.DEB.2.21.1.1706152123060.4200@virtualbox>
 <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com>
 <20170615224110.kvrjs3lmwxcoqfaw@genre.crustytoothpaste.net>
 <CACBZZX5Z3kQHe_5TgOeuJSgzuvpQdaLo6RrgX_EvuZfdz856sA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="yapcqvk3xov7pke6"
Content-Disposition: inline
In-Reply-To: <CACBZZX5Z3kQHe_5TgOeuJSgzuvpQdaLo6RrgX_EvuZfdz856sA@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--yapcqvk3xov7pke6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 16, 2017 at 01:36:13AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjar=
mason wrote:
> On Fri, Jun 16, 2017 at 12:41 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > SHA-256 acceleration exists for some existing Intel platforms already.
> > However, they're not practically present on anything but servers at the
> > moment, and so I don't think the acceleration of SHA-256 is a
> > something we should consider.
>=20
> Whatever next-gen hash Git ends up with is going to be in use for
> decades, so what hardware acceleration exists in consumer products
> right now is practically irrelevant, but what acceleration is likely
> to exist for the lifetime of the hash existing *is* relevant.

The life of MD5 was about 23 years (introduction to first document
collision).  SHA-1 had about 22.  Decades, yes, but just barely.  SHA-2
was introduced in 2001, and by the same estimate, we're a little over
halfway through its life.

> So I don't follow the argument that we shouldn't weigh future HW
> acceleration highly just because you can't easily buy a laptop today
> with these features.
>=20
> Aside from that I think you've got this backwards, it's AMD that's
> adding SHA acceleration to their high-end Ryzen chips[1] but Intel is
> starting at the lower end this year with Goldmont which'll be in
> lower-end consumer devices[2]. If you read the github issue I linked
> to upthread[3] you can see that the cryptopp devs already tested their
> SHA accelerated code on a consumer Celeron[4] recently.
>=20
> I don't think Intel has announced the SHA extensions for future Xeon
> releases, but it seems given that they're going to have it there as
> well. Have there every been x86 extensions that aren't eventually
> portable across the entire line, or that they've ended up removing
> from x86 once introduced?
>=20
> In any case, I think by the time we're ready to follow-up the current
> hash refactoring efforts with actually changing the hash
> implementation many of us are likely to have laptops with these
> extensions, making this easy to test.

I think you underestimate the life of hardware and software.  I have
servers running KVM development instances that have been running since
at least 2012.  Those machines are not scheduled for replacement anytime
soon.

Whatever we deploy within the next year is going to run on existing
hardware for probably a decade, whether we want it to or not.  Most of
those machines don't have acceleration.

Furthermore, you need a reasonably modern crypto library to get hardware
acceleration.  OpenSSL has only recently gained support for it.  RHEL 7
does not currently support it, and probably never will.  That OS is
going to be around for the next 6 years.

If we're optimizing for performance, I don't want to optimize for the
latest, greatest machines.  Those machines are going to outperform
everything else either way.  I'd rather optimize for something which
performs well on the whole everywhere.  There are a lot of developers
who have older machines, for cost reasons or otherwise.

Here are some stats (cycles/byte for long messages):

                   SHA-256    BLAKE2b
Ryzen                 1.89       3.06
Knight's Landing     19.00       5.65
Cortex-A72            1.99       5.48
Cortex-A57           11.81       5.47
Cortex-A7            28.19      15.16

In other words, BLAKE2b performs well uniformly across a wide variety of
architectures even without acceleration.  I'd rather tell people that
upgrading to a new hash algorithm is a performance win either way, not
just if they have the latest hardware.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--yapcqvk3xov7pke6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllDI6IACgkQv1NdgR9S
9ov0eBAArwKs6PnUc02guXfft1xjBKrwFy8cF3zLr2tEb+pEpuAuA8Pl7e+05M0d
BKgq0ccM7L7nqKEAz1wJs9x/BYHRGxWi5OP136RXfxfNf73n3/k9v7LvzHKfNrsM
6phjQcq6ToiOMMjY09/w/raWpznoxoL60WqeSAFnP9wuiGY8jTuJyYLW20db8uaW
LxToHuFHHGZTkHEv8Ir28uHnkKSLhAmO+5PGZvyQwXGSyCZRF9G9MHt5sI9GPdPa
7Y/90EXYE2qCx58QSd+/b5tBVCiGEKOEevbKPivPTEjrKJLvaejZqDXWiKEaXbZq
rOQxFYANCrClOcuFnAVkusjuUFMWwm1xhkAx881ehnLnaQFWUWXAOBYwC7EvKiaZ
02XZ+Q/lpxOxpRYtRgaZtpSktcYaU01S+UuzR5cqZwaaw4Wio8QTXdZf44rHCQRS
yZd9ZUTIpTwkYC0jvKAw5F10m3mwqaQgmD1bZgcGkChWxIBs/D9o/zw+Sbakis/A
uZP3DwWXeD8FEy2sIJ/697cfJsk5/UVEtE5Inv8fe5XcOEVu9VbcoTp8UonEWJTS
706/Sq8ySVavlFBY8y+diHlg8ntVONYcv1KuNz3NKHfTYoXTxsk8XsIwFMt0BmI+
zTNvCedFm39dE/iVShXr04mQioSBvazsU8ZcUN3ZBXPaqe/PvHc=
=YvQs
-----END PGP SIGNATURE-----

--yapcqvk3xov7pke6--
