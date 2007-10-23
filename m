From: martin f krafft <madduck@madduck.net>
Subject: Re: unmerging feature branches
Date: Tue, 23 Oct 2007 21:17:38 +0200
Message-ID: <20071023191738.GA24575@piper.oerlikon.madduck.net>
References: <20071023152445.GA10070@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0710230922240.30120@woody.linux-foundation.org> <20071023171611.GA18783@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0710231026011.30120@woody.linux-foundation.org> <20071023180825.GA20343@piper.oerlikon.madduck.net> <alpine.LFD.0.999.0710231115060.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
To: Linus Torvalds <torvalds@linux-foundation.org>,
	git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 23 21:18:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkPGJ-0002sF-Ln
	for gcvg-git-2@gmane.org; Tue, 23 Oct 2007 21:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbXJWTRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Oct 2007 15:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbXJWTRr
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Oct 2007 15:17:47 -0400
Received: from clegg.madduck.net ([82.197.162.59]:51828 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234AbXJWTRr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Oct 2007 15:17:47 -0400
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id E38B3A8068;
	Tue, 23 Oct 2007 21:17:55 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id 0C35A9F13B;
	Tue, 23 Oct 2007 21:17:39 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id 6FE774408; Tue, 23 Oct 2007 21:17:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710231115060.30120@woody.linux-foundation.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-2-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4574/Tue Oct 23 16:57:10 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62149>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Linus Torvalds <torvalds@linux-foundation.org> [2007.10.23.2024=
 +0200]:
> So it does look at the commits only in the sense that it uses the "shape"=
=20
> of the history (which is obviously built up from many individual commits!=
)=20
> but it never looks at any individual commit per se.

I don't follow what you mean with "shape". The following is
a history:

 o - x - o - o - o - m - o - A* - o - m2 - o - master
      \             /                /
       `o - A - L -' - F - o - o - T' - branch

A is a commit, A* is the commit which reverts (the data change by)
A. L and F are to mark the last and first commits before and after
the first merge m. T is the tip of 'branch'

After merge point m2, the change introduced by A will *not* be in
master. This much makes sense.

What did not make sense is how Git determines to leave it out. But
I think that after drawing the above, it's now clear:

by shape you mean the actual graph, and when 'branch' is merged into
master at m2, Git goes back in time to conclude that master...L must
already be present in master due to the intersection of the two
lines at m, and thus finds commit F as the "oldest direct
descendant" of m2. L is an older descendant of m2, but it's not
direct in the sense that there are multiple paths from m2 to L. Thus
Git will only merge F..T at m2.

Or as you put it:

> If Foo has had *new* commits in the meantime, those new commits
> will show up, of course, but the old commits have absolutely zero
> effect, because they will be part of the common history.

I think I am (moderately) clear again on the inner working of Git.
Sorry for the confusion.

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"the search for the perfect martini is a fraud. the perfect martini
 is a belt of gin from the bottle; anything else is the decadent
 trappings of civilization."
                                                            -- t. k.
=20
spamtraps: madduck.bogus@madduck.net

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHHkjRIgvIgzMMSnURAlicAJ4lVzhXjBe/dofjWZb6QzHe+dTEfQCg0wRs
JifCVaeQflMYfS9TGi5+VrU=
=wB6Q
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
