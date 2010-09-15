From: martin f krafft <madduck@madduck.net>
Subject: Re: Import existing (old) topic branches in topgit
Date: Wed, 15 Sep 2010 06:55:09 +0200
Message-ID: <20100915045509.GA16770@fishbowl.rw.madduck.net>
References: <AANLkTima2NsEWuT85oFZGpfCQrsrqy5KsQSOez3B9i-7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
To: Guilhem Bonnefille <guilhem.bonnefille@gmail.com>,
	Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 15 07:35:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovkee-0007L8-Lm
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 07:35:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753341Ab0IOFfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Sep 2010 01:35:22 -0400
Received: from seamus.madduck.net ([213.203.238.82]:54658 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753328Ab0IOFfV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Sep 2010 01:35:21 -0400
Received: from fishbowl.rw.madduck.net (tmo-101-187.customers.d1-online.com [80.187.101.187])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id B30E7411658;
	Wed, 15 Sep 2010 07:35:08 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 58F99217D5; Wed, 15 Sep 2010 06:55:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTima2NsEWuT85oFZGpfCQrsrqy5KsQSOez3B9i-7@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.35-trunk-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.96.1 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156224>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Guilhem Bonnefille <guilhem.bonnefille@gmail.com> [2010.09.14.2=
244 +0200]:
> But as I'm new to this tool, I don't know what's the best way to
> import existing branches in topgit.

There is tg-import, but it looks like it rewrites the history, which
you might not want.

This should be trivially possible, and it would be nice if TopGit
could help you, but for now you will have to do this manually. The
following is an example for the simple case when branch foo depends
on master, and you want to convert foo:

1. git checkout foo    # the topic branch
2. git update-ref refs/top-bases/foo $(git merge-base master HEAD)
3. echo master > .topdeps
4. git format-patch --stdout -s HEAD^ | sed -e 1d -e '/---/,$d' -e '/^Date:=
/d' > .topmsg
5. git add .top(deps|msg)
6. git commit -sm'convrting branch to topgit format'
7. tg summary

Now: will you write a new tg-import or tg-convert? ;)

Cheers,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
a: no.
q: should i include quotations after my reply?
=20
spamtraps: madduck.bogus@madduck.net

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAkyQUa0ACgkQIgvIgzMMSnVBBwCcDoAUXvSR4duV9aPR2IvRbNyy
u3MAoKdlOZkmMdc9UHr8oJqe4QPEJsTe
=9bDQ
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
