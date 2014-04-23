From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v2 2/3] remote-helpers: move out of contrib
Date: Wed, 23 Apr 2014 15:10:05 +0200
Message-ID: <38F8C9C6-E186-4C42-B3F0-931AE73400FA@quendi.de>
References: <1398112633-23604-1-git-send-email-felipe.contreras@gmail.com> <1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_4D55D240-5B78-4F95-A1EF-9338581E0636"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 15:10:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcwwg-0001ku-20
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 15:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754881AbaDWNK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 09:10:28 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:48816 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753862AbaDWNKK (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Apr 2014 09:10:10 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WcwwC-0006rp-V8; Wed, 23 Apr 2014 15:10:08 +0200
In-Reply-To: <1398112633-23604-3-git-send-email-felipe.contreras@gmail.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1398258610;498819f9;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246827>


--Apple-Mail=_4D55D240-5B78-4F95-A1EF-9338581E0636
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 21.04.2014, at 22:37, Felipe Contreras <felipe.contreras@gmail.com> =
wrote:

> The remote-helpers in contrib/remote-helpers have proved to work, be
> reliable, and stable. It's time to move them out of contrib, and be
> distributed by default.

Really? While I agree that git-remote-hg by now works quite well for =
basic usage in simple situation, there are still unresolved bugs and =
fundamental issues with it.

E.g. I recently showed you a reproducible use case involving =
git-remote-hg that puts the helper into a broken state from which it is =
difficult for a normal user to recover. Namely when a hg branch has =
multiple heads, then git-remote-hg exports all of those to git, but only =
adds a git ref for one of them; after pruning unreferenced commits, the =
fast-import marks file references git commits that now are missing, =
prompting git fast-import to crash and trash the marks file. Afterwards, =
attempts to push or pull from the remote hg repository are answered with =
an error.

There are other ways to trigger variants of this, and these are not =
artificial, they occur in real life (this is how I run into the issue). =
There are more issues related to unresolved clashes between the git and =
hg ways of naming things. E.g. I am collaborating on a hg repository =
that has branches "foo" and "foo/bar" which git-remote-hg cannot handle =
because it translates them to git branch names, and, well, git cannot =
handle that.

It may be hard to deal with some of them, and admittedly I wouldn't =
necessarily expect that all of these are handled from the outset, i.e. =
"in version 1.0". But I think at the very least, users should be warned =
about these things.

More broadly speaking, there is currently no documentation at all in =
git.git for those remote helpers, which I find worrisome.

That said, I don't know what the criteria are for moving something out =
of contrib. Perhaps it is OK to move an undocumented remote-helper with =
known bugs out of contrib.


Cheers,
Max

--Apple-Mail=_4D55D240-5B78-4F95-A1EF-9338581E0636
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlNXu7AACgkQIpJVslrhe1le9gEAwA3hGuYlqqXIqQ6wOO4TMBl8
3zlM0/hhbNABMV3trXEBAKEntOUINsLM9FzHIlTPmVPfYwQwnaHVWMbgyDC73WMk
=9D3k
-----END PGP SIGNATURE-----

--Apple-Mail=_4D55D240-5B78-4F95-A1EF-9338581E0636--
