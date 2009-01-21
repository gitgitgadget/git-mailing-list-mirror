From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [VALGRIND PATCH for nth_last patch series] Fix invalid memory access
Date: Wed, 21 Jan 2009 10:18:57 +0100
Message-ID: <200901211019.01493.trast@student.ethz.ch>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901210113500.19014@racer> <7vwscpgi7t.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1336969.2WPxlZniUv";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 10:20:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPZFu-0007Wf-1G
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 10:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754079AbZAUJSt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 04:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753242AbZAUJSr
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 04:18:47 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:31250 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752931AbZAUJSq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 04:18:46 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 21 Jan 2009 10:18:44 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 21 Jan 2009 10:18:43 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.1.96; x86_64; ; )
In-Reply-To: <7vwscpgi7t.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 21 Jan 2009 09:18:43.0916 (UTC) FILETIME=[41B9E0C0:01C97BA9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106583>

--nextPart1336969.2WPxlZniUv
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Junio C Hamano wrote:
> We only accept "checkout: moving from A to B" newer style reflog entries,
> in order to pick up A.  There is no point computing where B begins at
> after running strstr to locate " to ", nor adding 4 and then subtracting 4
> from the same pointer.
[...]
> -	len =3D target - match - 4;
> -	if (target[len] =3D=3D '\n' && !strncmp(match, target, len))
> -		return 0;
> -
> +	len =3D target - match;

Actually the point of that exercise was to ignore branch (non)switches
of the form

  checkout: moving from A to A

I originally thought that this would be desirable behaviour, but now
that it causes so much trouble, I'm not that sure any more.  I still
think it would be more intuitive to not count them as switches (after
all git-checkout says 'Already on "$branch"'), but OTOH 'cd .; cd -'
also stays in the same directory.

Thanks for all the work you (both) are doing on this.  I hope to find
the time to read the current state of the series tonight.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1336969.2WPxlZniUv
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkl26IUACgkQqUud07tmzP2oUQCeKfA+Jh3bcmwzEwPjJigxVZLe
xAcAnRjEG9zxwT2jZkn+chlfjQQnd1E9
=BSts
-----END PGP SIGNATURE-----

--nextPart1336969.2WPxlZniUv--
