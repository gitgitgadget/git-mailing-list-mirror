Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E16DCC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 21:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbiCJVGF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 16:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiCJVGC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 16:06:02 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 880E9186BA3
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 13:05:00 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id BB92E5A104;
        Thu, 10 Mar 2022 21:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1646946299;
        bh=2rAq/sQ1teXjM/0mkxYwLEutYyVCljqnoVboywaPesY=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=Y+lZOSQnWZ61GrNRhVNPmYaCOdSnjdUii1gCDo8WwzMT0wKYDRnezD2MU81zOsVYV
         ccsFxQCpqgbSleNdps1t5OseKyapaZMCcLFdUFD/sKtWRGFMebSjl6RwpBv00aQTeB
         wgNAx8HqFGxac/7njbTz8i9/qg/09I79OCpRtD2cq8FLNp48meLYPB+2A8DygeDxBo
         R1XjoDc5RjjAVuB7lFDv6U831wdULZy3kVJshHKWKtupXU7gKDBVelFKbO9JQomzzg
         lPpMLaZxLHkZA8JW1BEXRpP2VYRI8g43MrCI8we9nb7g3wicJgSNTZGtqj1i9Qw2FW
         OUCcUcY+R9pDPGuQhKTk9/nSSIAnxtxbZN3qdM0bOe8NEb8AOGA/Oqbc8lcB/5mVSH
         bZxU0zVh4rz1YO3C+tndMdhOCblXMUGUST92b4Q01OgzmV0XZdD96px0RZkVBS7ygP
         1IN3WkdmZheT/3kDzSN4q9C8tRI0pcp/fM9mLUOa8IuYp4JB9uz
Date:   Thu, 10 Mar 2022 21:04:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 0/6] Importing and exporting stashes to refs
Message-ID: <Yipn+UiRw/GL6u2Y@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <dstolee@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <20220310173236.4165310-1-sandals@crustytoothpaste.net>
 <xmqq35jpei18.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MW/e2vKpHkP4Thw0"
Content-Disposition: inline
In-Reply-To: <xmqq35jpei18.fsf@gitster.g>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MW/e2vKpHkP4Thw0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-03-10 at 19:14:59, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > ...  The commits used in a stash export are nearly
> > identical to those used in the stashes, with one notable change: the
> > first parent of a stash is a pointer to the previous stash, or an empty
> > commit if there is no previous stash.  All of the other parents used in
> > the stash commit are present following it in their normal order.
> > ...
> > We intentionally attempt to exactly round-trip commits between stashes,
> > although we don't do so for the exported data due to the base commit not
> > having identical timestamps.  Preserving the commits exactly lets us
> > more efficiently test our code and it also permits users to more easily
> > determine if they have the same data.
>=20
> Hmph, out of reflog entries stash@{0}, stash@{1}, stash@{3}, if we
> create a chain of commits A, B, C such that
>=20
> 	A^2 =3D B, A^1 =3D stash@{0}
> 	B^2 =3D C, B^1 =3D stash@{1}
> 	         C^1 =3D stash@{2}
>=20
> then the original stash entry commits can be recreated identically,
> and after you export the stash as "A", you can "import" from it
> without creating any new commit to represent the stash entries, no?

True, that's an alternative approach.  Mine has the nice ability that
you can see the items in the stash with log --first-parent, which I
found to be useful in my testing.  We could of course change yours
to have that property as well by reversing the order, but then the last
item in the chain would have a base commit or a different pattern.

Yours does have the nice ability that we can see the actual original
stash commits as well.

> When we create A, if we use a predictable commit log message and
> the same author/committer ident as A^1 (i.e. stash@{0}), and do it
> the same for B and C, then no matter who exports the stash and at
> which time, we'd get an identical result, I would presume.

True.

I do want to preserve my nice --first-parent property.  What I propose
to do is this: I'll take your approach and reverse the parents to
preserve the --first-parent chain and synthesize a predictable root
commit based on the fake ID information we use for stashes when nobody's
provided any.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--MW/e2vKpHkP4Thw0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYipn+QAKCRB8DEliiIei
gSSTAP46sNHVk3o+z1vindHvFwYkcGSIbfovBW39tAjei6pKggEAxpjNPU7z1lSV
dw9KslhNJR1kPogDasMdVxvcsPKz7ww=
=e2Y6
-----END PGP SIGNATURE-----

--MW/e2vKpHkP4Thw0--
