Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 261C420401
	for <e@80x24.org>; Thu, 15 Jun 2017 22:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbdFOWlT (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 18:41:19 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:56624 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752516AbdFOWlS (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 15 Jun 2017 18:41:18 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 29F68280AD;
        Thu, 15 Jun 2017 22:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1497566476;
        bh=yCNPPekC6rgsq4OVbqhK8CfMdQNuZNHQqFxbk1Yu4D8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IWPtimMcaAS9Wb6FhY+zhuBT8ZBlAMeIEteiRlOXXwcoGG1gnLu2LmS5t32OwfYN1
         GDLcdRFn5ZgIcUsTgGyOdP2higWm8Tm4F5QqLmpsyp3qZckkEJI+H9ituf6lXQz8RU
         2osY66YZiJo+S+pysN0ByTQ+JxbHQjJGifeMmNIGaKTaJBUcAqiyz0ya87O2SkWzU5
         ZMHmBbrvqYCPGX0UtrdjyfJUoHaHrx1w1n5y/eqip2KL316qQyAAN8U0mBOBkPW7oz
         wT4jil7eorr6TecJCV3sfYgiw8LUzuuXX7ZwvO2OU3JVami08ZgJh925OX0+cM4FRV
         xUSc66fhEHBPNI+JjAK/5a4iWIBJQFgPAsK6OxzC5teemy/9Zmr2jQlImUmsfqJfa0
         Ds1W5kE2DANAOyRyQ+p+lFLEhf0BqlbIWDN1NFhe7GqjPe6FTJlQcZWopQ9yRpXfDk
         1D/LFzWxDKwhGaHzN7TNK1r7ssfWkKeX0FgdypwesWnU2E+DRUe
Date:   Thu, 15 Jun 2017 22:41:10 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Adam Langley <agl@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
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
Message-ID: <20170615224110.kvrjs3lmwxcoqfaw@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Adam Langley <agl@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio Hamano <gitster@pobox.com>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com>
 <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com>
 <20170306002642.xlatomtcrhxwshzn@genre.crustytoothpaste.net>
 <20170306182423.GB183239@google.com>
 <alpine.DEB.2.21.1.1706151122180.4200@virtualbox>
 <20170615110518.ordr43idf2jluips@glandium.org>
 <20170615130145.stwbtict7q6oel7e@sigill.intra.peff.net>
 <87shj1ciy8.fsf@gmail.com>
 <alpine.DEB.2.21.1.1706152123060.4200@virtualbox>
 <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="g5hlkzpyj7fj4q2c"
Content-Disposition: inline
In-Reply-To: <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--g5hlkzpyj7fj4q2c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2017 at 02:59:57PM -0700, Adam Langley wrote:
> (I was asked to comment a few points in public by Jonathan.)
>=20
> I think this group can safely assume that SHA-256, SHA-512, BLAKE2,
> K12, etc are all secure to the extent that I don't believe that making
> comparisons between them on that axis is meaningful. Thus I think the
> question is primarily concerned with performance and implementation
> availability.
>=20
> I think any of the above would be reasonable choices. I don't believe
> that length-extension is a concern here.
>=20
> SHA-512/256 will be faster than SHA-256 on 64-bit systems in software.
> The graph at https://blake2.net/ suggests a 50% speedup on Skylake. On
> my Ivy Bridge system, it's about 20%.
>=20
> (SHA-512/256 does not enjoy the same availability in common libraries how=
ever.)
>=20
> Both Intel and ARM have SHA-256 instructions defined. I've not seen
> good benchmarks of them yet, but they will make SHA-256 faster than
> SHA-512 when available. However, it's very possible that something
> like BLAKE2bp will still be faster. Of course, BLAKE2bp does not enjoy
> the ubiquity of SHA-256, but nor do you have to wait years for the CPU
> population to advance for high performance.

SHA-256 acceleration exists for some existing Intel platforms already.
However, they're not practically present on anything but servers at the
moment, and so I don't think the acceleration of SHA-256 is a
something we should consider.

The SUPERCOP benchmarks tell me that generally, on 64-bit systems where
acceleration is not available, SHA-256 is the slowest, followed by
SHA3-256.  BLAKE2b is the fastest.

If our goal is performance, then I would argue BLAKE2b-256 is the best
choice.  It is secure and extremely fast.  It does have the benefit that
we get to tell people that by moving away from SHA-1, they will get a
performance boost, pretty much no matter what the system.

BLAKE2bp may be faster, but it introduces additional implementation
complexity.  I'm not sure crypto libraries will implement it, but then
again, OpenSSL only implements BLAKE2b-512 at the moment.  I don't care
much either way, but we should add good tests to exercise the
implementation thoroughly.  We're generally going to need to ship our
own implementation anyway.

I've argued that SHA3-256 probably has the longest life and good
unaccelerated performance, and for that reason, I've preferred it.  But
if AGL says that they're all secure (and I generally think he knows
what he's talking about), we could consider performance more.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--g5hlkzpyj7fj4q2c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAllDDQUACgkQv1NdgR9S
9ota0g/+Mhan3HVM1G6N7xA4lW8lI6kgwDmw5UqW3x73B5lS5noVhUxF9YF9k6c0
Sa0lHEe6xJ/J0tg65NeV1XHQTJdKio0isoL8XUwsAVC0DW1v9IotVE7S2L2lt1m7
jALHIfg3+SuWaWJunnVmKfq73is7DLPQ5632dKrmtkpTfajdqxQTZaf04u6EhsiN
1+UmdioLuOj0ZimrmzAoXwyydVEX3zYB1qMrHlaLHa83SITBdRvZ2rBRo1Sg6qwP
l6V93Pgk31ZJZ8B6x3vbVs8d+Gzy33IHrL0IkLYrakl2+Tp4H94lFXMTQVApgeaI
3HobPicSmYrcBo5vEk3bGJ277Gv8YTV9iywcxQbb1aR1S8AHbeU1cttbVfClhxan
2udtQ7+xchgEealFxBGg6wX0SDX12007WDXiUx3IMc7+MPIup33jBSD/pIIe9Ldo
pbLN5osthiwqUpUHGuK7w7xuigJMv/6R1fsrhE552X2+h/Bw3m7wIs0lLHES+B7T
GvQq3f1aWSEaMQBLsc6rZYMfD6RQNYLzArG1Wl9hWmR76MubeaDYLAjXln/qD6fo
FHSIv0+pLLwYgSONkwzGSeLL2NcTlL2Txz7bCCyMEC2uoCjivtHy2xkd2W1D0Bb3
LszejhLm8d342EjdyzHlSsxfem31i2JMoE9c9XMeWpLmhy4m4jQ=
=RC3V
-----END PGP SIGNATURE-----

--g5hlkzpyj7fj4q2c--
