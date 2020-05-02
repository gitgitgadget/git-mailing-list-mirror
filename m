Return-Path: <SRS0=N0vB=6Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBECCC3A5A9
	for <git@archiver.kernel.org>; Sat,  2 May 2020 19:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5A5420735
	for <git@archiver.kernel.org>; Sat,  2 May 2020 19:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588446277;
	bh=G6YpqruZJUtRwUxQBbHc7i3eLlNHCEqqkQca1r2Lw/Q=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=RNq+6wUSUAKmMlCnsmspZvID+OLL5QMZCz86ddBhq5h5BEtGNG5CvBJLvjhbA6yv7
	 rO3VJ0GYKzwabF6CAX3Jsv2QBhyi74F1VAKC5iNDesLp1SnqVs3+FI0NLAEzWI6wcB
	 CjsmGAGE9a7VbbF+r/utPnBfAl6ivlWiUdRfir9E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbgEBTEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 May 2020 15:04:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:41136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728406AbgEBTEg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 May 2020 15:04:36 -0400
Received: from localhost (p5486C608.dip0.t-ipconnect.de [84.134.198.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BE8F20731;
        Sat,  2 May 2020 19:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588446276;
        bh=G6YpqruZJUtRwUxQBbHc7i3eLlNHCEqqkQca1r2Lw/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=XAMgEvszhoRhumucQ930JXRvhET/iZWZyU+MrFqllObjhvbJU9R10FJpeXxRwW1NQ
         SO2CkIHEaG8cIz0rE3FBm7Mn4iorCoy3NtMv3VJN5ChfHv/mHV30ZOVuUpz0a48yLb
         OY7RWCVttidQSI8KmKMIyg2oM+49edmeJ/APKwog=
Date:   Sat, 2 May 2020 21:04:33 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     git@vger.kernel.org
Cc:     Thomas Koutcher <thomas.koutcher@online.fr>,
        Jonas Fonseca <jonas.fonseca@gmail.com>
Subject: tig: bug when binding to 'generic'?
Message-ID: <20200502190433.GB25220@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z6Eq5LdranGa6ru8"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--z6Eq5LdranGa6ru8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

here is a minimal, problematic .tigrc:

===
bind	generic	F	!echo "Hello World!"
===

This works for most views, but not for 'main' where it still toggles the
refs. Adding a specific 'main' binding works:

===
bind	main	F	!echo "Hello World!"
===

It also works if I bind the 'generic' command to an unused key, e.g. '4'.

Discovered with Debian's 2.4.1, but confirmed against HEAD of today.

A bug?

Thanks,

   Wolfram


--z6Eq5LdranGa6ru8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl6txD0ACgkQFA3kzBSg
KbZm4RAAkWoISNECaa8wXPPNAl968Ddv+JWZjnf6AiLxxFllUAn/ZpdXPvu6f1kY
VJz5fyabjmuoyrHHXQWxJD+8yPNRcIQKeawjv0nz6V2NxmUmRGtkPwsuQJgfZsvu
AoILPCKrntZdqaYDMthVsOfMv/opnX4GeXJNRz/8Gn8apreJLUBsvJEPrgYu8nUO
yH2/W8bbxlSmXKaVWMQwP/yrXIEZJUdxKdPK+IJgyl4regIja9xVYzoJxIK0kkd7
B5jvIdsaSK3IgAfno45+K5QuU9+fkGl55hCGxi83qJmfdKzY+4IfpGgfwouYoBaC
Xo2D8yex+RKA/yoWMCoTvdJsKChCYcprWhcougAu+spLHi33obrIc1kOBlJj1jOr
81dwiMLf1J/1JcWt+gWzK9ObJIxcOQ9Tgx1r6NAQ4fH3mEdQ2nhCwZDck6CrWZW1
gbxA+Yif+PXyqwohO9cBNNge//Fxyhy/Z+2JCO41OyjeFFsefo+VjqkjDeMa6Uc3
sp8RM/H8mqME48Y9VHvZWCGnhTkFtlH7etPmYNMzZhymG3r+1bjvQ8riXf1QpWWC
fvB+7WzwfDrQCNspg+IotDhR/+4kvjOVFfZXV1rxmiH/xzXGjpjq9AugHlv0KJak
RBod2afsrFBRDs7BIJMDYgNMpzTvGyYGWY3gyXATi5Vjq7NjZSA=
=nBti
-----END PGP SIGNATURE-----

--z6Eq5LdranGa6ru8--
