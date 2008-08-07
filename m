From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git filter-branch --subdirectory-filter, still a mistery
Date: Thu, 7 Aug 2008 09:50:03 +0200
Message-ID: <200808070950.23754.trast@student.ethz.ch>
References: <200808061539.50268.J.Wielemaker@uva.nl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2425043.dvKWvMBq62";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Wielemaker <J.Wielemaker@uva.nl>
X-From: git-owner@vger.kernel.org Thu Aug 07 09:51:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR0HG-0001DA-GF
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 09:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753590AbYHGHuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 03:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754238AbYHGHuP
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 03:50:15 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:47193 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753068AbYHGHuO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 03:50:14 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 Aug 2008 09:50:12 +0200
Received: from cx-public-docking-1-043.ethz.ch ([129.132.149.43]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 7 Aug 2008 09:50:12 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <200808061539.50268.J.Wielemaker@uva.nl>
X-OriginalArrivalTime: 07 Aug 2008 07:50:12.0813 (UTC) FILETIME=[39139FD0:01C8F862]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91566>

--nextPart2425043.dvKWvMBq62
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Jan Wielemaker wrote:
[...]
> 	% git filter-branch --subdirectory-filter packages/chr HEAD
>=20
> This indeed creates a nice directory holding only the contents of
> packages/chr.  But, starting qgit I see that all commits, also those
> that had absolutely nothing to do with this dir are still there.

The trick is to rewrite all refs, not just HEAD.  I usually proceed as
follows:

  cp -a repo repo.old  # just to keep a backup
  cd repo
  git filter-branch --subdirectory-filter somedir -- --all

The --all tells it to rewrite as many refs as possible.  Note that the
=2D- is required.  Also note that refs/original/* will still point to
the old commits, so they won't "just vanish".  You may want to clone
the repository or delete them manually once you are sure the
filter-branch did the right thing.

=2D Thomas


--nextPart2425043.dvKWvMBq62
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkiaqT8ACgkQqUud07tmzP005gCfdgquOBKJlCuN325mrmPnhvUM
u0IAoI0mBXWBPeyT8wa5VyfLa6FIL5Px
=laL0
-----END PGP SIGNATURE-----

--nextPart2425043.dvKWvMBq62--
