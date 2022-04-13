Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D84C433F5
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 01:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbiDMBO4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Apr 2022 21:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiDMBOy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Apr 2022 21:14:54 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D1A81FA76
        for <git@vger.kernel.org>; Tue, 12 Apr 2022 18:12:35 -0700 (PDT)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id B7AB25A0CA;
        Wed, 13 Apr 2022 01:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1649812353;
        bh=lYpP8HKJaEbpoDLvO6SebLxuYk68ahU4U4BTZ5gwHPc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=cFW4vZ3vJ+kQeXOMH/Tm15k0SRxxNF54b/okrnag0n1XMkwma0fBj9CqyniPjMksx
         o3K4B0E5nVJZ2Rz1ZAF7AtcMGW0sdr27a8rE8V8WlVri8OjpjDnygapTiiLu2idUmQ
         MIFCNUXpmMdZxuBoJ+LoLaL33kNSZdnreAyUttGSUk1EQWfRDAR3GF8rHIp+x7dwri
         sxHPk/SuqYtTj977QRQTWTwXfdzxLsu95V7muslBta2E2T8WRg4CPleFw/nSQvSdp7
         uUvSEP4j0CgZDMGZClmL7920Atwkkz11zlwG0b7ouqEITwa+R5OKfrsvMeTcjRc+9x
         SBzZLfpp8Fqqc7jnDI7mEdVkHQDmut6/kVdI8jJ8ml8xeQaFFVxNxDG3KcVt/jyNQ4
         ivr8AIj9MaqX2U1cnXukSWBUkIOF6AEyMrsIYmDGPh5ZyJVFsgsJIRresNB/LJTg7j
         /M7ynz1xDIQzvrMpmjMYVeFuUeqNpD8mYc8lkdneGrEzANLT8K8
Date:   Wed, 13 Apr 2022 01:12:32 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 4/4] builtin/stash: provide a way to import stashes
 from a ref
Message-ID: <YlYjgLcnNH8V1yj0@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <20220407215352.3491567-5-sandals@crustytoothpaste.net>
 <20220412201435.803424-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Tfsrd9c9OEfi2nTr"
Content-Disposition: inline
In-Reply-To: <20220412201435.803424-1-jonathantanmy@google.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Tfsrd9c9OEfi2nTr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-04-12 at 20:14:34, Jonathan Tan wrote:
> This seems like you're using the commit message as the reflog message -
> is this necessary? For what it's worth, all tests still pass if I
> replace "msg" with "NULL".

I think that's what the existing stash code does, and so I did the same
here.  It's not strictly necessary, but it's a nice to have.

I didn't think it worth testing, because I don't think we test it
elsewhere, either.

> It might be worth adding tests that check that the exported stashes are
> in the expected format (to ensure that we can read stashes exported from
> another Git version) but I don't think that has to block the submission
> of this patch set.

There's a tiny patch for that for the base commit, but you're right that
some more tests wouldn't hurt.  I can send a followup patch or two as
part of a new series.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--Tfsrd9c9OEfi2nTr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYlYjfgAKCRB8DEliiIei
gV0+AP90BWN3c0bH61dwLbtsal0Zz6fCscTPtOAH82W27bbLFQEA37Rx9KOU5pdC
jBtOIG0YUIcfBnzC7EPFhTOPBV8Q3go=
=wAxi
-----END PGP SIGNATURE-----

--Tfsrd9c9OEfi2nTr--
