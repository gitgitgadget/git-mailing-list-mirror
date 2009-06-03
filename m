From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Tue, 2 Jun 2009 19:18:40 -0700
Message-ID: <20090603021840.GE3042@orbis-terrarum.net>
References: <200905122329.15379.jnareb@gmail.com> <200906022339.08639.jnareb@gmail.com> <20090602232724.GN30527@spearce.org> <200906030250.01413.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QnBU6tTI9sljzm9u"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 03 04:19:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBg4K-0001Ys-Ag
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 04:19:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753753AbZFCCS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2009 22:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbZFCCS4
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Jun 2009 22:18:56 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:49891 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752932AbZFCCSz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2009 22:18:55 -0400
Received: (qmail 24431 invoked from network); 3 Jun 2009 02:18:56 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Wed, 03 Jun 2009 02:18:56 +0000
Received: (qmail 22453 invoked by uid 10000); 2 Jun 2009 19:18:40 -0700
Content-Disposition: inline
In-Reply-To: <200906030250.01413.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120576>


--QnBU6tTI9sljzm9u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> >>> 	"0008NAK\n"
> >> What does this server response mean? That served doesn't need more
> >> info?
> > It means the server is answering a prior flush from the client,
> > and is saying "I still can't serve you, keep tell me more have".
> Hmmm... the communication between server and client is not entirely
> clean. Do I understand correctly that this NAK is response to clients
> flush after all those "want" lines? And that "0009done" from client
> tells server that it should send everything it has?
Relatedly with the "done" message, I'm in the process of writing a hook
that allows the server to deny the client at this point, instead of
building and sending a pack.

Suggestions on other modifications that might be needed to integrate.=20
The hook:
- takes all want/have lines as input (maybe capabilities too?)
- returns 0/1
- on error, should also send a message to stderr, to be passed over the
  wire.

My intended use is to block initial clones while still allowing updates
(as long as you've got a tree at least commit X recent, I'll talk to
you). Initial and too-old clients get a message to go and download a
bundle instead.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--QnBU6tTI9sljzm9u
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkol3YAACgkQPpIsIjIzwiz1UQCgy5Di9dZnYcf9Z/B6eWiWcYP8
jRQAoNEUkJAAm2qaKXtVL2pBwNJOZHXM
=WXdy
-----END PGP SIGNATURE-----

--QnBU6tTI9sljzm9u--
