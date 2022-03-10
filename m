Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1441C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 22:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344384AbiCJWnZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 17:43:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiCJWnY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 17:43:24 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 280C5182BF0
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 14:42:23 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 5F5565A104;
        Thu, 10 Mar 2022 22:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646952142;
        bh=baH9R+GU7TYDLFkf0JHi5ZR8YBL1fE1+9PPr7jLknf4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=BaFnsqxR4i1hdCsNPg9Xq0/rPasiaELLz30uXHQyy3v9uFdpoN7gm9sRKBOUhzOsu
         l21jb9DGCXqA01Epiw+gd2CL71PeCPJaVrAWZwY6GQfUP83pKPnW3NgVt+4YMR1Ufx
         gLLq+o2AgWfMqJqUVQQAs1vjp0uEumoaaWrCJ7zTHjnohQ6b0dn+LciFzvzDKcBAVP
         2fsR9nwXiRm+rksitn5vQIXOX6owZxeZFe166GBx3EU3CpMKnWG2Ylqd8xCxv+zt+G
         mpDQRZJ5YNXdG/FJ+I9bVJs3dcQE5mU3G/xm0GrD6un404GST75A5A55s9GH6fVCiX
         vWUVtN7NQqvP3I9Zu/O5Njb3Zbe1Wr1IX7A7fO1pjyoxTwntlLn9ks8c2U4hpI4BQ4
         wAtBHsdD8EvDUaFBIuiWyX0/me19SeO3f5SyBlIKqEf9aw2u7/Xg7bOqrYok3qAHRr
         7IOq2NB9KJnyIGPnK0PqqdJRaafCc1QzhhdqhgfAP5Wi1c2XBUl
Date:   Thu, 10 Mar 2022 22:42:20 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 0/6] Importing and exporting stashes to refs
Message-ID: <Yip+zMYXVfcNJ03F@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <xmqq35jpei18.fsf@gitster.g>
 <Yipn+UiRw/GL6u2Y@camp.crustytoothpaste.net>
 <xmqqbkydcwt9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WTQ6BPkIVMYqXkWY"
Content-Disposition: inline
In-Reply-To: <xmqqbkydcwt9.fsf@gitster.g>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WTQ6BPkIVMYqXkWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-10 at 21:38:42, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > I do want to preserve my nice --first-parent property.  What I propose
> > to do is this: I'll take your approach and reverse the parents to
> > preserve the --first-parent chain and synthesize a predictable root
> > commit based on the fake ID information we use for stashes when nobody's
> > provided any.
>=20
> I am wondering if this can be made not an export format but a new
> mechanism to store stashes that we use without having to export and
> import.  Capping the series of "stash entry" commits with an extra
> commit that is continuously amended, and recording which stash entry
> has already been used (and not to be shown) etc., in the log message
> part of that commit, would give us "stash drop" without rewriting
> all the history and would easily bring us to feature parity with the
> reflog based implementation, I would hope?

I had thought of providing a different stash format via
extensions.stashFormat or something instead of this.  The problem becomes
backward compatibility: we essentially can't use stashes with older
versions, and a very common use case in development is to work inside a
Docker container or such where the version of Git is whatever the OS
happened to ship, so such a change can be painful.  It also impedes
working with the repository using libgit2, which is heavily used in some
environments (e.g., the Rust toolchain), until someone ports that change
there.

I'm not opposed to seeing such a format change where refs/stash itself
becomes pushable via a format change, but for my present use case, I
don't want to do that right now.  It's possible that I might write such
a series in the future, or someone else could write it, but I won't be
writing it at the present moment.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--WTQ6BPkIVMYqXkWY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYip+ywAKCRB8DEliiIei
geYwAP9QQMGsdmzWBMs3ZtWRB/N4VQS46rj1US3GyQ/K6h7ivQD+JtQQYhHGLhu2
v/4tuAIdoScze7bysaYZSPrdCjllOAo=
=8UHY
-----END PGP SIGNATURE-----

--WTQ6BPkIVMYqXkWY--
