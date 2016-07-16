Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C7ED2018F
	for <e@80x24.org>; Sat, 16 Jul 2016 20:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbcGPUNZ (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 16:13:25 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:58972 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751666AbcGPUNY (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Jul 2016 16:13:24 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:395:747d:98e1:fc48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id BFFCA282AF;
	Sat, 16 Jul 2016 20:13:17 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1468699997;
	bh=RQhql+L8VR1MJjh/dAHsVbYiEzni5Iynj5g7VXlL9Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MI2u0sCxn06lLpfeBwuZ2T+RPTGCP66huh2wLJXDV3KgXZNotUBM4qAAqKe8RsVAh
	 sTtiAvPSC08J0aYIWdwrqAdGEzX2ZIt86qBcROzMB9FdD9TBrDhhXKdCKP8QWroGd8
	 znG9iQmNCLM0loe53ZltGLG6grtzD0UZSzSJwcwQFQpoEp8iKN6aLsk0uEH8jf/uyr
	 eD1gP5jcyOqnzKYOaObPxZQrXy1CJZn6Gw05lbongCVftI7odVwHKJpUuiPj041zJW
	 QcwWYZ1/PpvZYTK3fWueZLKqWavuhFqvtJJpmKqANWK8gz5mAbE35ZLsnXoSycoXcH
	 fESsyD+SHoy4xODA9WpvoJEjzCZWHvGsKmrIcRP2qhl5d//f/RIlcJtAtwpQBC0oeD
	 GMhIrCf6C/d1jrseWjNVmqSScaeGidiZg3YVebGKRXl6jcFcy69lTe7dLhv5HojyCD
	 /1WQP97fQB8tbn0n7mRvXy1XLcSpBpoXgLBmSmhs7nmaUEfU+bM
Date:	Sat, 16 Jul 2016 20:13:14 +0000
From:	"brian m. carlson" <sandals@crustytoothpaste.net>
To:	Herczeg Zsolt <zsolt94@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Git and SHA-1 security (again)
Message-ID: <20160716201313.GA298717@vauxhall.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Herczeg Zsolt <zsolt94@gmail.com>, git@vger.kernel.org
References: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <CAPp-Vrb_n6z39RLHZ4AeUaBFiJfL3_xX8Utfq7+bTgzZrza58Q@mail.gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.7.0-rc4-amd64)
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 16, 2016 at 03:48:49PM +0200, Herczeg Zsolt wrote:
> But - and that's the main idea i'm writing here - changing the storage
> keys does not mean you should drop your old hashes out. If you change
> the git data structure in a way, that it can keep multiple hashes for
> the same "link" in each objects (trees, commits, etc) you can keep the
> old ones right next to the new one. If you want to look up the
> referenced object, you must use the newest hash - which is the key.
> But if you want to verify some old hash, it's still possible! Just
> look up the objects by the new key, remove all the newer generation
> keys, and verify the old hash on that.
>=20
> A storage structure like this would allow a very great flexibility:
>  - You can change your hash algorithm in the future. If SHA-256
> becomes broken, it's not a problem. Just re-hash the storage, and
> append the new hashes the git objects.
>  - You can still verify your old hashes after a hash change - removing
> the new hashes from the objects before hashing should give you back
> the old objects, thus giving you the same hash as before.
>  - That makes possible for signed tags, and commits to keep their
> validity after hash change! With a clever-enough new format, you can
> even keep the validity of current hashes and signs. (To be able to do
> that, you should be able to calculate back the current format from the
> new format.)
>=20
> Moving git forward to a format like this would solve the weak-key
> problem in git forever. You would be able to configure your key algo
> on a per repository basis, you - and git - can do the daily work on
> the newest hashes, while still carrying the old hashes and signatures,
> in case you ever want to verify them. That would allow repositories to
> gracefully change hashes in case they need to, and to only
> compatibility limitation is that you must use a new enough git to
> understand the new storage format.
>=20
> What are your thoughts on this approach? Will git ever reach a release
> with exchangeable hash algorithm? Or should someone look for
> alternatives if there's a need for cryptographic security?

I'm working on adding new hash algorithm support in Git.  However, it
requires a significant refactor of the code base.  My current plan is
not to implement side-by-side data, for a couple reasons.

One is that it requires significantly more work to implement and
complicates the code.  It's also incompatible with all the refactoring
I've done already.

The second is that it requires that Git have the ability to store
multiple hashes at once, which is very expensive in terms of memory.
Moving from a 160-bit hash to a 256-bit hash (my current plan is
SHA3-256) requires 1.6=C3=97 the memory.  Storing both requires 2.6=C3=97 t=
he
memory.  If you add a third hash, it requires even more.  Memory is
often a constraint with using Git.

The current plan is to use git-fast-import and git-fast-export to handle
that conversion process, and then maybe provide wrappers to make it more
transparent.

Currently the process of the refactor is ongoing, but it is a free time
activity for me.

If you'd like to follow the progress roughly, you can do so by checking
the output of the following commands:

  git grep 'unsigned char.*20' | wc -l
  git grep 'struct object_id' | wc -l

You are also welcome to contribute, of course.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.13 (GNU/Linux)

iQIcBAEBCgAGBQJXipVZAAoJEL9TXYEfUvaLH7IQALVHENXrPfyO9IH/0jpzWV+R
4pKqOhpgbo9AOy5b8pYiEZp0OYgs5q5r9avXOo7qBAzYsNibBlFRu9sQtw/UmnK4
BmrhtkH6wHzpH3Z8VkPk4yhfiPS0Y1tQgAXKMCbe+5T/22sqrwLliO0Wdu+sM5Oa
S3zyjgSA4M3iSGeCrjmScve+FFc2Vw+pOD2paQvFzl5+mvjlwn+DhUsMwksX5E5w
0922vcUtyFt370YJPO4jGtL+L/9O1CWxSRiBtqAgKJe57WoD9X9ULZUhQ42Cvgjh
uBoayx6EwKaWT1qkyB1DG4X7xrLVtYj/oI8Te1Vh1h4YAMwR9ioqb0IM5xXxwlby
x8ge78NrbNnwFidQ2biUOqCnn7ZgtrzUP9x9+BQxcZMEwjSG7RuSThO2/vkS3cje
AAeO1uoH9tV/feJHiH/wCckjVx1qKzk5jzcUkA/kR0YiNkcJtbxw5ep1eXWFohZn
4ki1GhwZvhpybl9vUs4kYZ5gMgzOM474v8acviOpcvywaulY/AOVq/kTmd0nX3Q2
NufGPy1T1Q5mtbBVxyWacQ/9hIxafrWbpm5ihr2xQhfK1L9Y43+NBFws5tUkP+sR
65h4qInSbQy5B83/lU5+lwuBY80Rpw20QXXTxyi+YDkFe5Qfn1vOegZcjYISDHNh
0Wz2zQUZzeQ3bBGiCCy/
=UuVK
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
