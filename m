Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CACE9202D7
	for <e@80x24.org>; Sun,  5 Mar 2017 23:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752500AbdCEXph (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Mar 2017 18:45:37 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42944 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752425AbdCEXpg (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 5 Mar 2017 18:45:36 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 57F5C280AD;
        Sun,  5 Mar 2017 23:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488757533;
        bh=5ZmQaja67Jz0kBdLSYhQv6OSw8fZ/X9wT9kuZsArODc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EdiwdkJThPn2Hj9ZlCtAp0rFrMvCn+b2br9FrdGDY+fXVddPm2CORiFy6AQEmrvIi
         Q/qSQzSy53oFyqLjDEjFr7y33bBD/cDwKwzeBoVpS5BamNjHQ4WQ6JYpwKjciFWlbJ
         2rczC/m3c6LI45yQy+sYFf1folrWTKVzbKrKjGV1ZrnkF5thzhKBQhm0juAFZuoGww
         i7MwtomtbE2kPSNVvCdOWO1zqaliL7UacFAU2V75qhNEQoQfZwmM23soyBAoHuMUod
         e4kQeJtdcLjB9vaivDqC/7qkY4mEV5ULMtsCgyNB3iiXN32lKMLhU0hZKPlrnxcL50
         ya0OInMBQQjP9uDHCHboqxZ/VaRKuvce+NlPVXB5hhYOgEV1ZUmoc3w5t7AhXjmmFz
         7j0ZHcT7VQy/Qf5AtB5b/iClbvuuJV7LmvmfYIOT/4LuCZ1wjlpLhQb02yH80nls4E
         kVqxfsYxuXC89BCpSWDyFmPCpRVpJnA8W3OCZIpvkxbNYwc0efx
Date:   Sun, 5 Mar 2017 23:45:27 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Cooper <git@lakedaemon.net>,
        ankostis <ankostis@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Joey Hess <id@joeyh.name>
Subject: Re: Transition plan for git to move to a new hash function
Message-ID: <20170305234527.qfsiopua6ygva46p@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Cooper <git@lakedaemon.net>, ankostis <ankostis@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, David Lang <david@lang.hm>,
        Joey Hess <id@joeyh.name>
References: <20170226001607.GH11350@io.lakedaemon.net>
 <20170226173810.fp2tqikrm4nzu4uk@genre.crustytoothpaste.net>
 <CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com>
 <CACBZZX6fP_JpL+K3XUnke=4m4gZBLu-Afyz5yJkrRnGXHuhR8A@mail.gmail.com>
 <20170226215220.jckz6yzgben4zbyz@sigill.intra.peff.net>
 <22708.8913.864049.452252@chiark.greenend.org.uk>
 <20170228214724.w7w5f6n4u6ehanzd@genre.crustytoothpaste.net>
 <22712.24775.714535.313432@chiark.greenend.org.uk>
 <20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net>
 <22716.5770.95842.704242@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bdf3yccppd7k7fmf"
Content-Disposition: inline
In-Reply-To: <22716.5770.95842.704242@chiark.greenend.org.uk>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bdf3yccppd7k7fmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 05, 2017 at 01:45:46PM +0000, Ian Jackson wrote:
> brian m. carlson writes ("Re: Transition plan for git to move to a new ha=
sh function"):
> > Instead, I was referring to areas like the notes code.  It has extensive
> > use of the last byte as a type of lookup table key.  It's very dependent
> > on having exactly one hash, since it will always want to use the last
> > byte.
>=20
> You mean note_tree_search ?  (My tree here may be a bit out of date.)
> This doesn't seem difficult to fix.  The nontrivial changes would be
> mostly confined to SUBTREE_SHA1_PREFIXCMP and GET_NIBBLE.
>=20
> It's true that like most of git there's a lot of hardcoded `sha1'.

I'm talking about the entire notes.c file.  There are several different
uses of "19" in there, and they compose at least two separate concepts.
My object-id-part9 series tries to split those out into logical
constants.

This code is not going to handle repositories with different-length
objects well, which I believe was your initial proposal.  I originally
thought that mixed-hash repositories would be viable as well, but I no
longer do.

> Are you arguing in favour of "replace git with git2 by simply
> s/20/64/g; s/sha1/blake/g" ?  This seems to me to be a poor idea.
> Takeup of the new `git2' would be very slow because of the pain
> involved.

I'm arguing that the same binary ought to be able to handle both SHA-1
and the new hash.  I'm also arguing that a given object have exactly one
hash and that we not mix hashes in the same object.  A repository will
be composed of one type of object, and if that's the new hash, a lookup
table will be used to translate SHA-1.  We can synthesize the old
objects, should we need them.

That allows people to use the SHA-1 hashes (in my view, with a prefix,
such as "sha1:") in repositories using the new hash.  It also allows
verifying old tags and commits if need be.

What I *would* like to see is an extension to the tag and commit objects
which names the hash that was used to make them.  That makes it easy to
determine which object the signature should be verified over, as it will
verify over only one of them.

> [1] I've heard suggestions here that instead we should expect users to
> "git1 fast-export", which you would presumably feed into "git2
> fast-import".  But what is `git1' here ?  Is it the current git
> codebase frozen in time ?  I don't think it can be.  With this
> conversion strategy, we will need to maintain git1 for decades.  It
> will need portability fixes, security fixes, fixes for new hostile
> compiler optimisations, and so on.  The difficulty of conversion means
> there will be pressure to backport new features from `git2' to `git1'.
> (Also this approach means that all signatures are definitively lost
> during the conversion process.)

I'm proposing we have a git hash-convert (the name doesn't matter that
much) that converts in place.  It rebuilds the objects and builds a
lookup table.  Since the contents of git objects are deterministic, this
makes it possible for each individual user to make the transition in
place.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--bdf3yccppd7k7fmf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAli8oxcACgkQv1NdgR9S
9ouRPg//Xve8sFcJzx0UZIgYLIYZSC+CjsnCM9wE6NmakrbZLpbqbZh8QfWQwSPf
J9OaXBAmM63ETohfPyQr90bdzLBI/bwP9V55WMwXO5Qhl3X4AcrBLXMkKjkG4WJu
Zcshq8BV+jS7HevEPdG9AbG6dK8e+uEt5rqNgl4TBSDuFfagkZ4eJ5Z7ml2B+nGt
o0070JV2EJmGr39ngQsp/ICN+eflLm/04UIN/stcnX1PCtXTtBfwkVRJCbMuwnmy
0rRSYAIJkBE+02Cxni6f1lI2LCc8zASyKxPwYGiokg211vaHQM5CItKRjxN+1Qi6
4lRs7tYE9V2eeTqZnIkWhWK+yfzX6nPAhsJfz8VKDn/GtNVLU10tisoCCTY+tYLF
6m3f2DadGl1KVww0s6mrvLlLjXM4hAwGw4Lw0Uus7S9c8FBS/5AQL0B/DswwlU6w
ke85pjztyMsbzLaP2eNAd/iLa3Q8rMjl7TnGtzVhtkqwrrsVZEVOyhRrIg1yAqh/
dlnj3Ai82Ho2rLbv7HXfNoS52uX1n/ghaehSJJdcRQBjmkcbvuf6+ROiTp/v5+z8
QyIeAMWv7NYIHhrIMYsXnZMufVvsNK9C9AKwrqrtkTFqK7mD5utfdjK+SVWL2myn
qY1HpMx13r0zN1HIFuD6QSelhbj/a+UIc/F/COZoU2wYQaqHQYQ=
=DlHo
-----END PGP SIGNATURE-----

--bdf3yccppd7k7fmf--
