Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 313AD2023D
	for <e@80x24.org>; Sat,  4 Mar 2017 22:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752497AbdCDWtr (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Mar 2017 17:49:47 -0500
Received: from castro.crustytoothpaste.net ([75.10.60.170]:42748 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752317AbdCDWtp (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Mar 2017 17:49:45 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9BD63280AD;
        Sat,  4 Mar 2017 22:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1488667782;
        bh=hBJUoprR/+FQU/6SrxobVP677FLWLXN0yTnU/DYRjLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4Yez7bTPnXF7VR8Fl0E4lG/gP4Npzz8pEhuWFshvVbQKCTQlhDNdi0wlzupZvHnL
         P9j39iIC4U9YAeYkUTFp91WJVYxSh3krs6c9g9P0craTiRYMgoZSvqPRteOJXbl+lJ
         5VT8iJuM8J7FjK5PYrhM6gF5kouw6Fvf6j5eBh4SLWS7a3O0TCD48XJ98Hq+JVht3A
         LMgYj0wR/tvJJnTaGKVre1xgCNCK7DnxGVTBPB4RQeKH6pU7QigwQrx/HpudgVthfI
         SUJYfs3hGc5DXrB4M+fv3bEN2MGjwZyQZrtEDoDxOuwEdwzVzPiBmrU+Hg4BRHwony
         E9ku97FqgjcVi/yeBV4RVm+ph3ZB8fnZDUFsPBgCfY6iu59pNZjH6lLmtfmjPeESI9
         LsYXvDUeQMiNKFZELY1baa4el/yM4b5D3uVNDpjQ+ObvoU5CnG1gsRu3l03ht8IyIG
         4Sv06RFnz7UE9oiSHiuf5lsr/MJaRYHkw0GTkAaitlJblOHDCji
Date:   Sat, 4 Mar 2017 22:49:37 +0000
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
Message-ID: <20170304224936.rqqtkdvfjgyezsht@genre.crustytoothpaste.net>
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
References: <xmqqh93j1g9n.fsf@gitster.mtv.corp.google.com>
 <CA+dhYEVwLGNZh-hbcJm+kMR4W45VbwvSVY+7YKt0V9jg_b_M4g@mail.gmail.com>
 <20170226001607.GH11350@io.lakedaemon.net>
 <20170226173810.fp2tqikrm4nzu4uk@genre.crustytoothpaste.net>
 <CA+55aFzJtejiCjV0e43+9oR3QuJK2PiFiLQemytoLpyJWe6P9w@mail.gmail.com>
 <CACBZZX6fP_JpL+K3XUnke=4m4gZBLu-Afyz5yJkrRnGXHuhR8A@mail.gmail.com>
 <20170226215220.jckz6yzgben4zbyz@sigill.intra.peff.net>
 <22708.8913.864049.452252@chiark.greenend.org.uk>
 <20170228214724.w7w5f6n4u6ehanzd@genre.crustytoothpaste.net>
 <22712.24775.714535.313432@chiark.greenend.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4lwmervq67xqb3qc"
Content-Disposition: inline
In-Reply-To: <22712.24775.714535.313432@chiark.greenend.org.uk>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-2-amd64)
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4lwmervq67xqb3qc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2017 at 06:13:27PM +0000, Ian Jackson wrote:
> brian m. carlson writes ("Re: Transition plan for git to move to a new ha=
sh function"):
> > On Mon, Feb 27, 2017 at 01:00:01PM +0000, Ian Jackson wrote:
> > > Objects of one hash may refer to objects named by a different hash
> > > function to their own.  Preference rules arrange that normally, new
> > > hash objects refer to other new hash objects.
> >=20
> > The existing codebase isn't really intended with that in mind.
>=20
> Yes.  I've seen the attempts to start to replace char* with a hash
> struct.

My comment actually has nothing to do with the way struct object_id is
set up.  That actually can be trivially extended with a byte or two of
type.

Instead, I was referring to areas like the notes code.  It has extensive
use of the last byte as a type of lookup table key.  It's very dependent
on having exactly one hash, since it will always want to use the last
byte.

There are other, more subtle areas of the code that just don't handle
multiple hashes well.  Ideally we would remedy this, but I think
everyone is very eager to move away from SHA-1, and since nobody has
stepped up to volunteer to do that work, we should probably adopt a
solution that doesn't involve doing that.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--4lwmervq67xqb3qc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.18 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAli7RIAACgkQv1NdgR9S
9ouXfg//TjFHjddHlffTS3tXUpxzxI+qFFusGSUe//gZwLu+27RDB4vTG5ggNR3k
krqUZiLZd3BDjOF0fFP3JobJVXbpNdzswEg6aOIH4Kj/0QiKjPOlUwrEjUoxc1RV
aOwctCL0j5s0Vft5UuV7jXvHMJiLtK/sM935B3dSQOLCUfxLHs0sbeaaKlLrGVy7
LWmm5u+2VLsUoVEx70HDxX8E8WzUnQt9lMIa/e42BGUNY2RU2y4wyq1AtaGOJkYE
B28975lzdepjb4mFLLwd8FoEm9JKcPEjrz4oMaw5pmuYe9T4B5W80PkVyDjIaycM
K0NaIgcLNWZD+ZsFwYTtJe0fdxgoOmjDfVw/EU5u2F0TzHKu/XIINMuT1sCDDb3D
U/8QHbimYU9BO+iQw7gxMnX6/5UGJlXN8WxIZGt4ewT3Nl3plL1PUXix13QOreVd
m/kB2DuFCcdCkDKD37j4PhaCPwtEHeV5jqMMV2Ys5kzykL+WAkdg1t1qDeLqm+Cn
FMUwaH3KKuXDXfiqTJc03M2l67n33TrKplEfoZVMrxELXQg6CEt4jqFB8su+GYOD
EBgFzOg6haZz+mv6EJoE9RIMuMYQlc0IsOQCOjGtifgvD69y4iXdxJ+BfelDos04
wfHL3Cq8O07qkRBTR9UBK8HI2pZ5iTAKY3W3ByD7NKFEpaeFlDQ=
=AHkG
-----END PGP SIGNATURE-----

--4lwmervq67xqb3qc--
