Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B7A61F405
	for <e@80x24.org>; Wed, 19 Dec 2018 00:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbeLSASK (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Dec 2018 19:18:10 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:57780 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726512AbeLSASK (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 Dec 2018 19:18:10 -0500
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b469:672:eccb:defe])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 738306042F;
        Wed, 19 Dec 2018 00:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1545178687;
        bh=omdXaZIrlBR5EDps9a7BHmQYAP1kv1CYp7FOqdvCox0=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=hGXhmG9QVXTF9iUoeEg7RhHv8S+gKF3DsDju7g6v/GAf1a5Qc+R7altflLG72yW7c
         8DNTQwL2YPbLWnagOgFae39JeaInw8M9zZppKnWRCUIMH7k9b1+8uaZ4isy1DXOHBE
         PNp7FbpaMdSRRcfip+H4hNWyoMOxpzVhaBGeNWyljiyCC+5Xx/DyCcjNoX47jW6pbN
         QVesovz7L0CjcMyJHmlTmHkl8dshh+xK8rrHKLS2a4JYL18efbpbGFQCnV50NYuhrH
         uWpJLPsHPDtIyLVBx1FWBeagcEpNsJYIrfxPGZ7da549NImDj4+Zbe/Lt4xrrJhfsu
         d+dumXewWgZEU+zaToQMjPlxU3vyfm/EL9CZO3q+JpyOPvr007fFyYz93Kkzj3WZ0h
         29y80VOBMon42K/ox+HhMr701JA8Rl0ymyGkL7d+M18tdKgKsRTXcri0ztvk+N9Ztx
         thmsQWPwZhgelhYtbsGoNpb6pfCqW/zQwmHl0jhqJKYGOC8XP/E
Date:   Wed, 19 Dec 2018 00:18:01 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] setup: do not use invalid `repository_format`
Message-ID: <20181219001801.GA520988@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
References: <20181218072528.3870492-1-martin.agren@gmail.com>
 <20181218072528.3870492-3-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ikeVEW9yuYc//A+q"
Content-Disposition: inline
In-Reply-To: <20181218072528.3870492-3-martin.agren@gmail.com>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.18.0-2-amd64)
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ikeVEW9yuYc//A+q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 18, 2018 at 08:25:27AM +0100, Martin =C3=85gren wrote:
>  I fully admit to not understanding all of this setup code, neither in
>  its current incarnation, nor in terms of an ideal end game. This check
>  seems like a good thing to do though.

It's definitely complex.

> diff --git a/setup.c b/setup.c
> index 27747af7a3..52c3c9d31f 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1138,7 +1138,7 @@ const char *setup_git_directory_gently(int *nongit_=
ok)
>  				gitdir =3D DEFAULT_GIT_DIR_ENVIRONMENT;
>  			setup_git_env(gitdir);
>  		}
> -		if (startup_info->have_repository)
> +		if (startup_info->have_repository && repo_fmt.version > -1)
>  			repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
>  	}

I think this change is fine, because we initialize the value in
the_repository elsewhere, and if there's no repository, this should
never have a value other than the default anyway.

I looked at the other patches in the series and thought they looked sane
as well.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--ikeVEW9yuYc//A+q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.12 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlwZjjkACgkQv1NdgR9S
9osmYg/+Lhp8soTzcHnXHTOZJGJ9lnruWSZOFplHUZATUtukTt26Xu3BpTXvMT1A
GIqI64Jnf1GC1Kz2d05AnRI/VdRwmCcrdWNyIykymK57o7xVyKAcpo9aLL6pQB65
udcu+b/KlUTQLvhzVM6xmWqgClQoToZGQko1xEnNTmMZ/tEsoByNE954ay8fmduY
x6QUIuQPmVimeyCTWIJQvXEbWsKToDyacLMJYvvPMYm8Aq0QNkKaj7BQBk+DkhWO
bPup07u0nQPxUnUGuEh/6JkfLKdGNAbGGleBvnt9h3vnPsswHr5yvOwdI4wpMhGp
eIqzFBGU2z8JEqdKm4gfFRDek4WFDoAuGKS9odrRqnxBlWdjsgBH+cv3BqCxUAGn
0pq4OZuk/nEqg1fX1jiP3UFonOvxSJvQ60z3G7BwgP1MQUNejRqAHSwlbkDlCKnh
70SjfxjY/yUTU6RZ6MtY1hex98xii3fJSDTqNdcHCnjnwDaqSMntBtuXGnQ+sNci
2M+QBqzme/H86xVgkdI2i0DH33gkOeKMM3qNsh2DralreXPyF/xR8YUM5nGIAon2
fjGy0zrbi/g0/n95PUKs6mW/DmkRq/tvH8ZxebvuaFEWLCQNSIbkV2K3Ac5KhRpj
oSDfBb+MB3/UZapUk5/Hk7TqcSwl5vfqe++jBDTU0+XN+wLu1yg=
=j3M1
-----END PGP SIGNATURE-----

--ikeVEW9yuYc//A+q--
