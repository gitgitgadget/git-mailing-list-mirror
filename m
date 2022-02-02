Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D039C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 22:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347964AbiBBW5m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 17:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbiBBW5l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Feb 2022 17:57:41 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7CCC061714
        for <git@vger.kernel.org>; Wed,  2 Feb 2022 14:57:41 -0800 (PST)
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 0C47F5B224;
        Wed,  2 Feb 2022 22:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1643842660;
        bh=ATXY49siKCVrf2uJl/xHEK/CLjce0C/sftz30+0uWaM=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=u1zqnB5qEfSy07I+TGKVRFxfXi4bbUVw36gbNHP9g2Loh/Gd67UpdTbrAfpiRWVi+
         G2yFgbCMa02IFV+aAIRz1njUPSzDDAKhDFOV35ZVt4Ad17fEeoxnyY5V2vdvDtMOkJ
         o+iiAi47l2lZiAnCo8SOA+D2NBk3J7ntkmFgzG3vg6reMQn2qoBiJshBmOLKY7cA8Y
         pY69oWuHnlD1GcZkWZlgZ+ZTUqapWMlLKVUSXgShuWJG3Flj6wlz1QJ0CB+G1tURqo
         npjFDoh61mIBwZRa5wH5l2FiSl2scbPql+OsIxYHtNBQuyEnyliZqbRTmMnE7BlQKL
         4KTQCvIaMNiWBmnPUhd+w5gX21CroGL4tC+xhx6mSmwJhHA+Kl/VYlAUQmAEbsdo3o
         sMJFCo4nt//6Ikpi5YmECeRjnjxlC0YsSjG3FjeEZCR0yDUg+FgZP2JBPd10T0pieb
         P5BVTvTBkaMm0g9+BymZQFRuP15hkgPIVC+4lAhHE7/du1jnFJ0
Date:   Wed, 2 Feb 2022 22:57:37 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Greg Hurrell <greg@hurrell.net>
Cc:     git@vger.kernel.org
Subject: Re: git-checkout doesn't seem to respect config from include.path
Message-ID: <YfsMYTo1tND5JKNx@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Greg Hurrell <greg@hurrell.net>, git@vger.kernel.org
References: <ee1dd453-e698-440a-911b-d14389e33715@beta.fastmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="0UfrPxdQFE3+K/M2"
Content-Disposition: inline
In-Reply-To: <ee1dd453-e698-440a-911b-d14389e33715@beta.fastmail.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--0UfrPxdQFE3+K/M2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2022-02-02 at 16:04:26, Greg Hurrell wrote:
> However, when I try to run a command like `git checkout -b something`,
> Git dies with:
>=20
>     fatal: unknown style 'zdiff3' given for 'merge.conflictstyle'
>=20
> So, it looks like something in `git-checkout`'s option processing is
> causing it to disregard the override set via "include.path". In fact, it
> even disregards a value passed in with `-c` like this:
>=20
>     git -c merge.conflictStyle=3Ddiff3 checkout -b something
>=20
> Does this sound like a bug, or are my expectations off? I'd be happy to
> look into fixing this, but first would like to know whether it is
> expected behavior.

This definitely doesn't sound like the expected behavior here.  It's not
clear to me why this is happening, but it probably shouldn't be.  It
doesn't appear that we fail to call the config callback, since we've
been doing that since 2010.

What version of Git are you using that's not working?
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--0UfrPxdQFE3+K/M2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYfsMXwAKCRB8DEliiIei
gcn0AQDD8ZFfF9kc0ILXGL/9bd4Hb7GA3NHL13ikyymWcrmw4wD6AqHGEuDsEBzX
KvRbvq10eZVSkl41sKI+NYVJ68Ql7wQ=
=a9AV
-----END PGP SIGNATURE-----

--0UfrPxdQFE3+K/M2--
