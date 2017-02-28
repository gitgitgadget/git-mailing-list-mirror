Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 166C9202C9
	for <e@80x24.org>; Tue, 28 Feb 2017 21:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbdB1VtS (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 16:49:18 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:41734 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751623AbdB1VtP (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Feb 2017 16:49:15 -0500
Received: from genre.crustytoothpaste.net (wsip-98-185-58-71.no.no.cox.net [98.185.58.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7E11F280AF;
        Tue, 28 Feb 2017 21:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488318450;
        bh=D/ue40xiB2WDRG7k6N2hI1aepfE0q+H4SBwV87TIPcQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JllgCgYCd2dFv9Wo8EGAA+SFPnaowx0st5qTTdE0qDQbUq2gbWJGlCaT4YvKG9Ymz
         6B2jIbelKvo/l3l1tUcPpJzdCih93S/lr5u48kRJ7XuP8e9ecH6df9KQ/U7OamnNwf
         XAZ4kVBUxGUKiETrYui9Fvp5E4TtR4qKabDBXH1TdJx8TxD4gcjsR69D4ggWzkEQRl
         HG1YnBbk+5XeYIuCW+LiqnJ0lKw6Ag/qzLuU+78BtYu36Dtoo93mepmgOnaEg0HLLb
         ZtC+nREAvk3gh05n16jsWWXtEbAP2SwJvHuNoluFZ+nzfEFfU3Ts2grJIYKvXfA/mB
         TTDnMHJvhhCycqN17ETnBGkJtWxiLA0dvZxeLIS3y/1FzWgK7TxE/TSYmXrPbaGZzW
         7wkja0So602D+WLAYeEPIAAOOeEjSWJ3Gu2nsOzi+BqXy5a3+LPKh48AK+BCi99XpR
         1wyPZfF20iO83PHPrtkK3wi54Yea3ISK8oGGPDM/1bjPdIVKWUy
Date:   Tue, 28 Feb 2017 21:47:25 +0000
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
Message-ID: <20170228214724.w7w5f6n4u6ehanzd@genre.crustytoothpaste.net>
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
References: <xmqq7f4f4cqg.fsf@gitster.mtv.corp.google.com>
 <CA+dhYEVOyACM9ARP2deKVLm1hHOVsTah1WfGoNzGGKO6CGrQpw@mail.gmail.com>
 <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com>
 <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>
 <20170226001607.GH11350@io.lakedaemon.net>
 <20170226173810.fp2tqikrm4nzu4uk@genre.crustytoothpaste.net>
 <CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com>
 <CACBZZX6fP_JpL+K3XUnke=4m4gZBLu-Afyz5yJkrRnGXHuhR8A@mail.gmail.com>
 <20170226215220.jckz6yzgben4zbyz@sigill.intra.peff.net>
 <22708.8913.864049.452252@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lew7qjoxvy7mfdgb"
Content-Disposition: inline
In-Reply-To: <22708.8913.864049.452252@chiark.greenend.org.uk>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--lew7qjoxvy7mfdgb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 27, 2017 at 01:00:01PM +0000, Ian Jackson wrote:
> I said I was working on a transition plan.  Here it is.  This is
> obviously a draft for review, and I have no official status in the git
> project.  But I have extensive experience of protocol compatibility
> engineering, and I hope this will be helpful.
>=20
> Ian.
>=20
>=20
> Subject: Transition plan for git to move to a new hash function
>=20
>=20
> BASIC PRINCIPLES
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> We run multiple hashes in parallel.  Each object is named by exactly
> one hash.  We define that objects with identical content, but named by
> different hash functions, are different objects.

I think this is fine.

> Objects of one hash may refer to objects named by a different hash
> function to their own.  Preference rules arrange that normally, new
> hash objects refer to other new hash objects.

The existing codebase isn't really intended with that in mind.

It's not that I am arguing against this because I think it's a bad idea,
I'm arguing against it because as a contributor, I'm doubtful that this
is easily achievable given the state of the codebase.

> The intention is that for most projects, the existing SHA-1 based
> history will be retained and a new history built on top of it.
> (Rewriting is also possible but means a per-project hard switch.)

I like Peff's suggested approach in which we essentially rewrite history
under the hood, but have a lookup table which looks up the old hash
based on the new hash.  That allows us to refer to old objects, but not
have to share serialized data that mentions both hashes.

Obviously only the SHA-1 versions of old tags and commits will be able
to be validated, but that shouldn't be an issue.  We can hook that code
into a conversion routine that can handle on-the-fly object conversion.

We also can implement (optionally disabled) fallback functionality to
look up old SHA-1 hash names based on the new hash.

> We extend the textual object name syntax to explicitly name the hash
> used.  Every program that invokes git or speaks git protocols will
> need to understand the extended object name syntax.
>=20
> Packfiles need to be extended to be able to contain objects named by
> new hash functions.  Blob objects with identical contents but named by
> different hash functions would ideally share storage.
>=20
> Safety catches preferent accidental incorporation into a project of
> incompatibly-new objects, or additional deprecatedly-old objects.
> This allows for incremental deployment.

We have a compatibility mechanism already in place: if the
repositoryFormatVersion option is set to 1, but an unknown extension
flag is set, Git will bail out.

For network protocols, we have the server offer a hash=3Dfoo extension,
and make the client echo it back, and either bail or convert on the fly.
This makes it fast for new clients, and slow for old clients, which
encourages migration.

We could also store old-style packs for easy fetch by clients.

> TEXTUAL SYNTAX
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The object name textual syntax is extended.  The new syntax may be
> used in all textual git objects and protocols (commits, tags, command
> lines, etc.).
>=20
> We declare that the object name syntax is henceforth
>   [A-Z]+[0-9a-z]+ | [0-9a-f]+
> and that names [A-Z].* are deprecated as ref name components.

I'd simply say that we have data always be in the new format if it's
available, and tag the old SHA-1 versions instead.  Otherwise, as Peff
pointed out, we're going to be stuck typing a bunch of identical stuff
every time.  Again, this encourages migration.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--lew7qjoxvy7mfdgb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAli17+wACgkQv1NdgR9S
9oto6g//ZoSmMPEQhlN1IkYhF2BGGeSHXWm9XaQFeCloWqDVQcH4QtI57Ivvqawc
la2sNPrgnxJ35jfxpm2VV5axFC0dnmL7GKhK84x3NY/4ugAeYTpXjMSMGO+7P8Ze
WTCRD6cQYnN2rdQfnDDXSiDozeC3RztWB5uH5YAn//8UQKJLVv93l17I/FPe7u8w
jrQAQ2kAEbW6RC1dC8e4gEBdYvtmBKFlLs2D8sKw1OAJkWCaGrW5D3Jxd8vDSR0s
v0BVJDGpQ+17F1e2HSd/sI1xsnfnn5XfyXxZy8f4CKgcuvPukM+M3bdZUjEi4mzg
BZiPZpv1zZQxXY4RirvadxRXc5qma/CqqAVNXi2U39tthTiEOYgcd0butCJ0KqV/
Lvz8ufCq0AvDloHmS5NAoaQ9SNtuejgt6Fiu8Nb0b0E880nPArHNr4tyMDqnE7HP
I3Gg+PiuP3C0kbz9dYqCO+v6yBq27rht0l3Wnk0QSgc0TDV+C3fwlKt7n4Vx9LCe
YCJvSqvix2mwvcsSpVZ6dSm/90Dd7DxCK/cMHRyqmIZqjtUovNeg7mSMLAuAIxWG
lR+LAZUfMpPuo2U1KZYtcAyhYC+wrsh5JwXelB9U1xmXXm4EyIGqwBpQ3xhvvUHW
rz7sx+gQl9/3zK3RJtiJ+v0PY3DFDiVl6nBtomW6cSi6PW7bUno=
=H18A
-----END PGP SIGNATURE-----

--lew7qjoxvy7mfdgb--
