From: Joey Hess <joey@kitenet.net>
Subject: Re: [PATCH] sha1_file: avoid bogus "file exists" error message
Date: Fri, 28 Nov 2008 09:00:15 -0800
Message-ID: <20081128170015.GA9744@kodama.kitenet.net>
References: <20081120185628.GA25604@kodama.kitenet.net> <20081126181928.GA31007@kodama.kitenet.net> <alpine.LFD.2.00.0811271233590.2883@sys-0.hiltweb.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bp/iNruPH9dso1Pn"
Cc: Git List <git@vger.kernel.org>
To: Ian Hilt <ian.hilt@gmx.com>
X-From: git-owner@vger.kernel.org Fri Nov 28 18:01:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L66is-00082V-47
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 18:01:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbYK1RAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 12:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751334AbYK1RAX
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 12:00:23 -0500
Received: from wren.kitenet.net ([80.68.85.49]:45702 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751286AbYK1RAX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 12:00:23 -0500
Received: from kodama.kitenet.net (adsl-76-200-143-96.dsl.pltn13.sbcglobal.net [76.200.143.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Joey Hess", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id ECA91314372;
	Fri, 28 Nov 2008 12:00:18 -0500 (EST)
Received: by kodama.kitenet.net (Postfix, from userid 1000)
	id 638631142DD; Fri, 28 Nov 2008 12:00:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0811271233590.2883@sys-0.hiltweb.site>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.94.1/8693/Fri Nov 28 07:00:04 2008 on wren.kitenet.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101879>


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ian Hilt wrote:
> On Wed, 26 Nov 2008, Joey Hess wrote:
> > Joey Hess wrote:
> > > Note that in both occasions that I've seen this failure, it has not b=
een
> > > due to a missing directory, or bad permissions
> >=20
> > Actually, it was due to bad permissions. :-) Once git was fixed to
> > actually say that, I figured out where to look to fix them.
>=20
> This is strange since write_loose_object() which calls create_tmpfile()
> checks for EPERM.  Perhaps this should be done in create_tmpfile()?

errno is clobbered by the mkdir in create_tmpfile(), that's what my patch
corrects.

I suspect that in my case, mkstemp failed with EACCES, not EPERM. git
was running as a group that did not have write access to (some) object
directories.

--=20
see shy jo

--bp/iNruPH9dso1Pn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iD8DBQFJMCOYd8HHehbQuO8RAmvVAKC2KvO4b9WKHdMkjFxqWGYdiIAQswCg3d9J
enspepZZVcSjyQPb1NLSrpI=
=1F5v
-----END PGP SIGNATURE-----

--bp/iNruPH9dso1Pn--
