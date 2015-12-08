From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] format-patch: add an option to suppress commit hash
Date: Tue, 8 Dec 2015 01:02:27 +0000
Message-ID: <20151208010227.GC990758@vauxhall.crustytoothpaste.net>
References: <1449440196-991107-1-git-send-email-sandals@crustytoothpaste.net>
 <1449440196-991107-3-git-send-email-sandals@crustytoothpaste.net>
 <xmqqr3iym4rg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 02:02:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a66fv-0001d5-GW
	for gcvg-git-2@plane.gmane.org; Tue, 08 Dec 2015 02:02:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbbLHBCf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2015 20:02:35 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34602 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932072AbbLHBCe (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2015 20:02:34 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 465632808C;
	Tue,  8 Dec 2015 01:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1449536552;
	bh=sf22GYLIoT++4ffoZfCiol54Dp6XTxGghLAztCET4q4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EnUOmMfEFN9SsIsua4hg+oRa43mGCCtJF793w3TkRQL5ksXD1inzSZe/VT4xXbbhf
	 B4iA7wavnUSEFifW6W/JP9bpQYnbhKypd0jiDR1HFTXBH1o6x2Z7prIvxY23hyA8jm
	 Rg62gCS447UIupt0GLUDFMu4JaG/JMEB5gPcYObGlGeHf7u6WP11pxgTH2fv9p0Br6
	 qXKkX/Kpucf2S9nPeNF3CozwhGIslraTvbOzlR6U5OHgUAZ9hEYXgP1PWHV9OotpPX
	 c6Aeh65TJ6AnudHJe5ZWxhCp6J3OcghNeVe9oA5nYRrofUER0AhlQXeHtVE7yK0NUs
	 fbKYnCnFkhphU1Vm8wkE+O7h63ci0Gt4TBhzU91bZNnqNO17Ij0NMnh5/gjG4nMseR
	 Wyq51PgWvm1E04ozSwoVcHw69DFH469zmAdz0JvLc3uDe7Ed3XgQeUTPJQdZaka6YI
	 +X8EkfRC+ljDmqWYFvQi1zelbHz6CKBqZScMJVOV2rIzapp1bDf
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stefan Beller <stefanbeller@gmail.com>, Jeff King <peff@peff.net>
Content-Disposition: inline
In-Reply-To: <xmqqr3iym4rg.fsf@gitster.mtv.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282144>


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 07, 2015 at 11:34:59AM -0800, Junio C Hamano wrote:
> Two (big) problems with the option name.
>=20
>  - "--no-something" would mislead people to think you are removing
>    something, not replacing it with something else.  This option
>    does the latter (i.e. the first line of your output still has
>    40-hex; it's just it no longer has a useful 40-hex).

Right.  I originally considered removing that line altogether, but other
parts of Git rely on that header to process patches correctly.

>  - There are many places we use hexadecimal strings in format-patch
>    output and you are not removing or replacing all of them, only
>    the commit object name on the fake "From " line.  Saying "hash"
>    would mislead readers.

I'll reroll with the name --zero-commit, unless somebody comes up with a
better suggestion.

> > +test_expect_success 'format-patch --no-hash' '
> > +	git format-patch --no-hash --stdout v2..v1 >patch2 &&
> > +	cnt=3D$(egrep "^From 0+ Mon Sep 17 00:00:00 2001" patch2 | wc -l) &&
>=20
> Don't test "any number of '0'"; test 40 '0's.  This is because the
> line format was designed to be usable by things like /etc/magic to
> detect format-patch output, and we want to notice if/when we break
> that aspect of our output format.

My idea was to future-proof it against changes in the hash function,
although that's in the distant future.  I'll reroll with the change you
suggested.  I might drop in another patch to improve the existing tests
to cover the case without this option, as I think we just look for
"From " currently.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.9 (GNU/Linux)

iQIcBAEBCgAGBQJWZiwjAAoJEL9TXYEfUvaLmS8QAInufuBNG8GhflXfEq1eJkeF
DykQ5c7PNZRx2Z86plhzR00UeZiMXmRRxLMMtyXw4AtfCEtYgf05a4rnUpuG1g+u
z+YcnOuTtqB9Zt9reyneeYD3V6TcIn1RPNgthzPjtnaGRfW/05t8T6mpvBG6dyaw
1YMsfMjJKwHcHAt6DvK0PHOdoVqw3IzvA7n1qQ9deKgyQ+XMZfZa96QET5fu9SwJ
ExJxX/URw6JBkUO9VDRQfnlMTPli6zDUdsamO/BtkwXrFtnvkWjTQhMg/b12gv2l
F3ccFKFsvztERcDd5bGRoBsftTAx8MBNZ8h/E6FZuT3NJ7rNNcsM++RLiO37j9Gd
3K6szcdDn6SKgkcnDcl4r/cIzx3tEYi3iyjc3Vl+sxNl4YlhmCNt144wIkKKDzLi
Ol1mDI+AYg2Qnl4DeZEbBwwwqjvdROSJaH5fUs3b0K+6SJGsrZuPHQtRbF0+ll0q
4FA6oyPi2GtM6+7zKsJ7mD2TJBn9UQnXLKgO6uwGQuRn+4jrO7eqMq1P6mA5q40i
v9xnzZkYofZQukJc3Vfw9EXBvN7aJTFUJEz30SRRka3Rq8Lyc8P3DwcI2+LYoFlT
9tyovWYqelb/CWP8QaOVUnJkthIJpB+caVB2aqnghsu+5Cu4gt0FyYKFrwaH3/Vu
cMRcURDPQ3uykkGJaOnB
=goU/
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
