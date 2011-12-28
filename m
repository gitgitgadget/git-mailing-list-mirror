From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: GIT and SSH
Date: Wed, 28 Dec 2011 10:15:12 +0000
Message-ID: <20111228101512.GA2192@beez.lab.cmartin.tk>
References: <loom.20111228T091942-66@post.gmane.org>
 <CA++fsGFOC6bV4gC+ozBKP3EmoAX4CcfTrHjjpMWPkh7vYOfgAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cNdxnHkX5QqsyA0e"
Cc: Reza Mostafid <m.r.mostafid@gmail.com>, git@vger.kernel.org
To: Dov Grobgeld <dov.grobgeld@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 28 11:15:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RfqXs-0002H8-6S
	for gcvg-git-2@lo.gmane.org; Wed, 28 Dec 2011 11:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab1L1KPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Dec 2011 05:15:17 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:52294 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752969Ab1L1KPP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Dec 2011 05:15:15 -0500
Received: from beez.lab.cmartin.tk (38.Red-83-34-194.dynamicIP.rima-tde.net [83.34.194.38])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 5CE06461B9;
	Wed, 28 Dec 2011 11:15:06 +0100 (CET)
Received: (nullmailer pid 9606 invoked by uid 1000);
	Wed, 28 Dec 2011 10:15:12 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Dov Grobgeld <dov.grobgeld@gmail.com>,
	Reza Mostafid <m.r.mostafid@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CA++fsGFOC6bV4gC+ozBKP3EmoAX4CcfTrHjjpMWPkh7vYOfgAw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187747>


--cNdxnHkX5QqsyA0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 28, 2011 at 11:55:24AM +0200, Dov Grobgeld wrote:
> Git supports multiple transport protocols. Among them are git, ssh,
> and https. (You can also use direct file system access, but it is
> questionable whether to call that a protocol). Each of the protocols
> have their advantages and drawbacks. The git protocol is only used for
> reading, and not for writing, but is supposed to be very fast. The
> common firewall filtering of the git protocol port 9418 is another
> problem. ssh is the prefered protocol for writing to a remote
> protocol. But if ssh is filtered, then http/https may be used, which
> is very slow for large repositories, but it has the advantage that it
> is the least blocked protocol.

Slow for large repositories? Are you thinking of the dumb HTTP
transport? That one shouldn't be used for doing any serious work. The
Smart HTTP transport is just the git smart protocol (the same one
git:// and ssh:// URLs speak) wrapped inside HTTP communication. The
negotiation phase is a more expensive than with either git or ssh, as
HTTP is stateless and you need to remind the remote what you want and
what you've already agreed on, but the actual transfer of data is done
the same way than with the others so overall it shouldn't be that
noticeable.

Now, to the OP's concerns: yes, the ssh transport does generate ssh
transport, as that's the whole point. You authenticate against the
remote machine's ssh daemon and run git-upload-pack or
git-receive-pack as needed (for fetching or pushing). If corporate
policy doesn't allow ssh you should either fix the policy or use the
smart HTTP protocol, though this involves messing with passwords and
their associated problems. I'm not saying ssh keys don't have their
complications, but I much prefer them.

We can't help you diagnose why your clone is stalling without more
information. It could be that the connection between the computers is
flaky, git trying to take too much memory on the remote or local
machines or any number of things. See if setting GIT_TRACE=1 in the
environment helps to see what's going on.

   cmn

--cNdxnHkX5QqsyA0e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO+uwwAAoJEHKRP1jG7ZzTCQ0H+wReBWPko1te4EJTBwYayOKq
H+Yjp5UUimJu+tjSpyxMBeZWHz62c2ldHgS7pA7qHgj+MVx7v/JWN6HgIq4XFOdO
qDFh7bT/VIDBO38BSLICGhwJv6ySt/fo/aVIqsfyRD5/DnrTECSLAYgDLYkOuykm
VEuvhu+rNaWDbHTtThSwGihZjEcQReszk06VgV4Nbly7yBPoYlz3Jqek007MfiYB
ew4/b4V4aBZwb+86+rjBDoioVZha2mq5ge28XmNU52sXnJGhnZr/Bu4jDv0CX1mr
QcprU2x+agkJQzoy7EhV1cAAXo5ABVuYnKB8qT5zdEDQWqz07WbPj8GyHMw8i5s=
=/hOO
-----END PGP SIGNATURE-----

--cNdxnHkX5QqsyA0e--
