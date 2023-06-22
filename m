Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED5BEB64DA
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 21:25:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjFVVZT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 17:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjFVVZS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 17:25:18 -0400
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813511BFA
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 14:25:17 -0700 (PDT)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id DB8285A210;
        Thu, 22 Jun 2023 21:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1687469116;
        bh=/UnX3TI105OJTTCQHQAuzSxXjULWj8x61xIISL30mDM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=qfZ6fGm6x8KGoG3FSeQ2JXFwA64e4fGFI4K/1E0LjwO+vZf94W59JuhR5gHK76kXi
         QiV/QUlCDRVqjz983KcdKrHpKH4MJ2V8yRFIldy7mPJ+qc3Ul/t3yp4WYDslj1uzr4
         2VMSElwtIUxDoRheVyhdTkz6PAcplbn792zc6o9Ms6iXjXn/afzA3fhkCggtoM8o10
         pQxUqErcHKMOGVio58LT/2mBqsoOreeGkT3tbXzoSW7iqqsrmeLxxaIx+ntSb8plCP
         km9Y/a9urh5dqysTB6lsaGqueRVasS7UDw6BtBdWlKpUXJ6Y1uLsixU0KLMEsWn8tv
         CSnWKhu+TvVXYr6/2yKlgN8RVicSUjGHYvKpBmSIPSKRAvD1OJi2ewV5hbRyjcCohR
         RfFbtqu26JuHBtd+AJsljkL72uuQiQpgH1jmdA3cKK3lpkqb5s69Iyv+g/2Sctjsuh
         nBL5HC0cYFp33H3hjdRNFTTVlmFm7709phFwFIn5uWlaC+R/EM+
Date:   Thu, 22 Jun 2023 21:25:14 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        Calvin Wan <calvinwan@google.com>
Subject: Re: [PATCH 1/3] var: add support for listing the shell
Message-ID: <ZJS8Ot+dHDRXZD/t@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>, Calvin Wan <calvinwan@google.com>
References: <20230622195059.320593-1-sandals@crustytoothpaste.net>
 <20230622195059.320593-2-sandals@crustytoothpaste.net>
 <CAPig+cSTR6oHeYjcHZ7m2CKYcFo2eistxz_X-7J2rhd7h+uf3g@mail.gmail.com>
 <xmqqjzvvdx7g.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YdmeRmzlQcQ1d3R+"
Content-Disposition: inline
In-Reply-To: <xmqqjzvvdx7g.fsf@gitster.g>
User-Agent: Mutt/2.2.9 (2022-11-12)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--YdmeRmzlQcQ1d3R+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023-06-22 at 21:05:39, Junio C Hamano wrote:
> Correct.  I also suspect that we want to add test_path_is_executable
> helper next to test_path_is_{file,dir,missing} helpers and list it
> in t/README.  One downside of your approach is that the output from
> the command is only in $shpath and cannot be observed easily in the
> $TRASH_DIRECTORY after the test fails, but with such a helper we can
> report the problematic path when the expectation fails.

At first glance, I thought that was a good idea, too, but unfortunately
there is no way to make that work on Windows.  That's why all of our
tests skip those assertions with POSIXPERM, and why my tests
specifically look for something different on Windows.

We could in theory just make it always succeed there, but my concern
with writing such a function is that people will think it works
generally, when in fact it does not.  That's why, typically throughout
the codebase, we specifically use "test -x".
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--YdmeRmzlQcQ1d3R+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.40 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZJS8OgAKCRB8DEliiIei
gd+9AQCo6TMX3H/vXBGfgsyMqPJA0LDRtZg96Zo1KJQulsqGQgD/VTGaKWXi+5Bw
eL4HRxxvZiASGYOqOCN3HgfI8+9wXAw=
=bU35
-----END PGP SIGNATURE-----

--YdmeRmzlQcQ1d3R+--
