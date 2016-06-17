Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99FA81FEAA
	for <e@80x24.org>; Fri, 17 Jun 2016 21:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479AbcFQVGA (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 17:06:00 -0400
Received: from kitenet.net ([66.228.36.95]:59918 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753109AbcFQVF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 17:05:59 -0400
X-Question: 42
Authentication-Results:	kitenet.net;
	dkim=pass (1024-bit key; unprotected) header.d=joeyh.name header.i=@joeyh.name header.b=ZxKJa1Ii;
	dkim-atps=neutral
DKIM-Signature:	v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
	t=1466197550; bh=kbqxHrxqVmaQuXIAvmpnM6qRXQsxK0rs0kTj9P4dI9A=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=ZxKJa1IiiDwUhJKTPKvT046zVIWviVX5imjIRjkVO0LubN5jqsSrVUnBoLZ8K+3+4
	 9JGRdVFxDm62VahIkYFK2dpynuCwW21AGvpvL7wkodN8uKDe4lkLm0RPE7hJ7qP3kv
	 N7FABhnR0hQRKunB+bW6Vw28WUCiPCRIwEsV7q5Y=
Date:	Fri, 17 Jun 2016 17:05:50 -0400
From:	Joey Hess <id@joeyh.name>
To:	git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] extend smudge/clean filters with direct file
 access
Message-ID: <20160617210550.GA25887@kitenet.net>
References: <1466195481-23209-1-git-send-email-joeyh@joeyh.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <1466195481-23209-1-git-send-email-joeyh@joeyh.name>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Spam-Status: No, score=-93.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_PBL,RCVD_IN_RP_RNBL,
	RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,SPF_SOFTFAIL,USER_IN_WHITELIST autolearn=no
	autolearn_force=no version=3.4.1
X-Spam-Checker-Version:	SpamAssassin 3.4.1 (2015-04-28) on kite.kitenet.net
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Doing a quick benchmark of this new interface and git-annex's use of it, git
checkout of a 1 gigabyte file with git-annex providing the smudge filter to=
ok:

    19 seconds using the smudge interface
    11 seconds using smudgeToFile
    0.1 seconds with smudgeToFile and annex.thin set
         (while also saving 1 gb of disk space!)

So around 2x speed improvement due to not needing to pipe the file content
through the filter, even without git-annex's annex.thin tricks.

--=20
see shy jo

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIVAwUBV2RmLskQ2SIlEuPHAQIuHg//SeTJPZpqqvcD3k5Ig8HeUd0BKU44T6yE
BYwTBrpvSnpl/OnTvhV5zqdyhGbetRHljNPLCMdezP7aatQC0Cn2pm3sGJJ/vrB2
R/y27t/V+5GdSJY2KUrrwr0ul7hd6k1Mr8HQaOn6SmuYz52M34LBMHlcTkvveOx1
emCpmYt+OnqXmyfBEZskiOdAsnqxGhhxZrdb7NQ1Z58CBFA1HZ+i13nxRTxe/Tme
0dHikxOcHyey9W8Wq5whWkgckB8ADnILvV7Ppg1UwMNHO1PlAuHAK1E0B2wVlm8E
DFUU+ZJsWl1iMXZ7zEkCtsFfWkC7vD59YGfc/KtevEHRfwgB95wFVvw7sbo6K987
7Yf+VZfw2ll6Dt9cuRXnHXOfrwn4+5TcNFHXQFXI4/c/dvtJyaLRGioJK90kFmDU
NEeuCzzs7Mu973TXfUdSe+QUjzXMtvUl6ILFej/oc1ZTshZ61CsOa29Hd69dzf6R
g4/p+/FijUR8ukr5+vFE9bAALQxE04R4V78lcgcVUBoAXkDlILHkMV9Bv1MIG+Eg
xYFex2V92kjqGzR4qXffyVFkGJRDn0dBlbYZCuRioJQX1QgguL4hkZYWiJIdjWjt
B76n1QjECqZ+jQE0oW+V93/xCPjOMTD9AbZG1cvIDrD1XTJVyJXicIZ4qNWauF3q
HVkhes/OzAM=
=eF1g
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--
