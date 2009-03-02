From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFC PATCH] Windows: Assume all file names to be UTF-8 encoded.
Date: Mon, 2 Mar 2009 15:29:54 +0100
Message-ID: <200903021530.01165.trast@student.ethz.ch>
References: <alpine.DEB.2.00.0903020941120.17877@perkele.intern.softwolves.pp.se> <a2633edd0903020512u5682e9am203f0faccd0acf6a@mail.gmail.com> <alpine.DEB.2.00.0903021452010.17877@perkele.intern.softwolves.pp.se>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart123605264.gWjxFB3UOH";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Mon Mar 02 15:32:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le9BT-0001eg-GZ
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 15:31:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751791AbZCBOa1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 09:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbZCBOa0
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 09:30:26 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:48168 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751572AbZCBOa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 09:30:26 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Mar 2009 15:30:23 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 2 Mar 2009 15:30:23 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.19-3.2-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <alpine.DEB.2.00.0903021452010.17877@perkele.intern.softwolves.pp.se>
X-OriginalArrivalTime: 02 Mar 2009 14:30:23.0418 (UTC) FILETIME=[6C0571A0:01C99B43]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111941>

--nextPart123605264.gWjxFB3UOH
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Peter Krefting wrote:
> In the other project I worked on we ended up wrapping all file-related ca=
lls=20
> in our own porting interface, and then let each platform we compiled for=
=20
> implement their own methods for handling Unicode paths. For Windows it's=
=20
> trivial since all APIs are Unicode. For Unix-like OSes it's tricky as you=
=20
> have to take the locale settings into account, but fortunately the world =
is=20
> slowly moving towards UTF-8 locales, which eases the pain a bit.

Have you thought about all the consequences this would have for the
*nix people here? [*]

Even if you pretend that Git did always enforce UTF-8 paths in its
trees, so that there's no backward compatibility to be cared for,
you're still in a world of hurt when trying to check out such paths
under a locale (or whatever setting might control this new encoding
logic) that does not support the whole range of UTF-8.

Like, say, the C locale.

Next you get to see to it that the users can spell all filenames even
if their locale doesn't let them, since they'll want to do things like
'git show $rev:$file' with them.

With backwards compatibility it's even worse as you're suddenly
imposing extra restrictions on what a valid filename in the repository
must look like.


[*] I'm _extremely_ tempted to write "people using non-broken OSes",
but let's pretend to be neutral for a second.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart123605264.gWjxFB3UOH
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmr7WkACgkQqUud07tmzP3sGQCcCje0MX9AGhKyvZVYPTCT2hqU
h5gAoI57lrJxNmNw/p4zX5yvrnAhjick
=9wfi
-----END PGP SIGNATURE-----

--nextPart123605264.gWjxFB3UOH--
