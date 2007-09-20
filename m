From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] new test from the submodule chapter of the user manual
Date: Thu, 20 Sep 2007 23:46:09 +0200
Message-ID: <20070920214609.GT16235@genesis.frugalware.org>
References: <20070920003413.GJ16235@genesis.frugalware.org> <7v1wcum0ox.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709201133590.28395@racer.site> <20070920170831.GQ16235@genesis.frugalware.org> <20070920175952.GC30391@tasint.org> <Pine.LNX.4.64.0709201946410.28395@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QxIEt88oQPsT6QmF"
Cc: Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 23:47:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYTsI-0004xH-P7
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 23:47:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbXITVrt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 17:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbXITVrt
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 17:47:49 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:42270 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751586AbXITVrt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 17:47:49 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx2.mail.elte.hu with esmtp (Exim)
	id 1IYTrT-0007EB-Dj
	from <vmiklos@frugalware.org>; Thu, 20 Sep 2007 23:47:09 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 0C27B1678013; Thu, 20 Sep 2007 23:46:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709201946410.28395@racer.site>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.0 required=5.9 tests=BAYES_05,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	-1.1 BAYES_05               BODY: Bayesian spam probability is 1 to 5%
	[score: 0.0443]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58809>


--QxIEt88oQPsT6QmF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 20, 2007 at 07:47:32PM +0100, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > > +test_expect_success "create the submodules" '
> > > +	for i in a b c d
> > > +	do
> > > +		mkdir $i &&
> > > +		cd $i &&
> > > +		git init &&
> > > +		echo "module $i" > $i.txt &&
> > > +		git add $i.txt &&
> > > +		git commit -m "Initial commit, submodule $i" &&
> > > +		cd ..
> > > +	done
> >=20
> > 	Silly question: why use the '&&' when you can 'set -e'?  As it
> > currently stands, a failure will still go back around the loop...
>=20
> A "set -e" will make the script exit AFAIR.  That's not what we want.  A=
=20
> simple "|| break" after the "cd .." will work, though.

i know i asked this on irc, but i still a bit confused. the target would
be to jump out from the loop and return 'false' if any of the items
fails

if i understand correctly then this is what Dscho proposes:

$ for i in a b; do echo $i && false || break; done
a
$ echo $?
0

this jumps out from the loop but does not return false

here is my version:

$ for i in a b; do echo $i && false; done
a
b

$ echo $?
1

this one detects the error but does not jump out from the loop. none of
them is perfect, but at least my version fails as long as the last cycle
fails (which is not problem as i think in most cases all or none of the
cycles will fail)

anyway, if you really want, i can change it, but i think it is not the
right thing to do

- VMiklos

--QxIEt88oQPsT6QmF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFG8uohe81tAgORUJYRAsbjAJ91NNhKEHls9WewIEs4Gqkoo6fvrACdHNj9
nV3Mm4ePoH7gr4PiiSSyX+g=
=U3sw
-----END PGP SIGNATURE-----

--QxIEt88oQPsT6QmF--
