Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 815FCC433EF
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 00:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 673BD61407
	for <git@archiver.kernel.org>; Tue,  5 Oct 2021 00:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbhJEAGk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 20:06:40 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:54514 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229564AbhJEAGj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 Oct 2021 20:06:39 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id E8DF760426;
        Tue,  5 Oct 2021 00:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1633392259;
        bh=2npidwVEv/JM/f3u1LslruZ1GqJzyVtnqxNBsBvfISc=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=DCgRGwkV/ZVN1yhEuChqLb0WCCQ6zzPlIwI/yeq1gFjS18QY6CbWvOsRjum/KumR6
         AsIbwDnNQsMgaONTyRgz5sVR5PbJsFEc5MzWcPrP/zZuYiCgBXGyS4dFJvnE5M+Flm
         wjk5b5ipqBETl/NsrYQ392O4OB5qw9AJqA8Od4i46+JyUz/7YQvmDutYIpoSvrL5jr
         NwlRfk8Ht5tim+B3m/0yQe7zDOQaGLqPR+P2pv2uOw9Pg41aDQMDEiYcAqc1tDu1mU
         2qLJs90MQdV2XVsDu8tiwd2x6PVYf+RQKwJGlAvGfBMmYdiatJKeGCggh+8psAxS7f
         PqK8W3p6wSmX8zfbGvfBt7QdxSDWbZWPxiQoZhGSvzW1xbD0vQWjVyA0Nzfw41+IC9
         9JZyfMvhS4P07FVfB4FfW+TDHR02U2IqqEaYjOYPb/T3wFT8og0mG/YbHt6uRgISwt
         pfcY9tu7QRg9DfcQcEWla5csELVjvbHuyhOCSm00lCdGMvs3AKA
Date:   Tue, 5 Oct 2021 00:04:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Andrzej Hunt <andrzej@ahunt.org>, Eric Wong <e@80x24.org>,
        Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Subject: Re: [PATCH] hash: reduce size of algo member of object ID
Message-ID: <YVuWfXqlpZxORS8p@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>, Andrzej Hunt <andrzej@ahunt.org>,
        Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
References: <8da7bad2-b5a8-5aef-284b-dfa4e78556a9@web.de>
 <YVq3rqwz82RgpUfl@coredump.intra.peff.net>
 <YVq5XCyLDr0SPBzx@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BG5Y0qYDi0jS9q/5"
Content-Disposition: inline
In-Reply-To: <YVq5XCyLDr0SPBzx@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--BG5Y0qYDi0jS9q/5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-10-04 at 08:20:44, Jeff King wrote:
> Oh wait, I'm reading it totally wrong. Adding in the extra 4 bytes
> actually made it _faster_ than not having an algo field. Now I'm
> super-confused. I could believe that it gave us some better alignment,
> but the original struct was 32 bytes. 36 seems like a strictly worse
> number.

My guess is that the increased alignment means that memcpy can perform
much better.  Just because x86 has "fast" unaligned access doesn't mean
it's free; there remains a penalty for that, although other
architectures which support unaligned access have much worse ones.
memcpy and memcmp will perform better when they can use 32-bit chunks to
read without having to process the potentially unaligned pieces at the
beginning and end.

For the record, I have no particular stylistic opinion about whether we
should adopt the proposed patch, but of course if it's faster as it is,
we should probably leave it.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--BG5Y0qYDi0jS9q/5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYVuWfQAKCRB8DEliiIei
gbuJAQDareON9dC5zOY/5Qbf0bx4L9+s9+JvK+IjAevzJd13xgEAnmXULC9XpCo5
4mj9I7CnhK0un72WsNWNiGOC+GYjiwY=
=W5NY
-----END PGP SIGNATURE-----

--BG5Y0qYDi0jS9q/5--
