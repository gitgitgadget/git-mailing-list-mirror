From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH 4/4] git-rebase -i: New option to support rebase with
	merges
Date: Mon, 24 Mar 2008 12:14:13 +0100
Message-ID: <20080324111413.GA18488@alea.gnuu.de>
References: <1206308562-31489-1-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-2-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-3-git-send-email-joerg@alea.gnuu.de> <1206308562-31489-4-git-send-email-joerg@alea.gnuu.de> <alpine.LSU.1.00.0803232334130.4353@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9amGYk9869ThD9tj"
Cc: git@vger.kernel.org, B.Steinbrink@gmx.de
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 12:17:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdkgG-0001or-0A
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 12:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757920AbYCXLQu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 07:16:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757917AbYCXLQu
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 07:16:50 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:2340 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757915AbYCXLQt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 07:16:49 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 87E6F48802C; Mon, 24 Mar 2008 12:16:47 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jdkd3-00010a-J1; Mon, 24 Mar 2008 12:14:13 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jdkd3-0004ow-6a; Mon, 24 Mar 2008 12:14:13 +0100
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0803232334130.4353@racer.site>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78024>


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

Johannes Schindelin schrieb am Sun 23. Mar, 23:41 (+0100):
> On Sun, 23 Mar 2008, J=F6rg Sommer wrote:
>=20
> > @@ -150,7 +152,18 @@ pick_one () {
> >  		sha1=3D$(git rev-parse --short $sha1)
> >  		output warn Fast forward to $sha1
> >  	else
> > -		output git cherry-pick "$@"
> > +		if test t =3D "$LINEAR_HISTORY" &&
> > +			other_parents=3D"$(parents_of_commit $sha1 | cut -s -d' ' -f2-)" &&
> > +			test -n "$other_parents"
> > +		then
> > +			if test a"$1" =3D a-n
> > +			then
> > +				merge_opt=3D--no-commit
> > +			fi
> > +			redo_merge $sha1 $no_commit $other_parents
> > +		else
> > +			output git cherry-pick "$@"
> > +		fi
>=20
> Now, that is funny.  In case of --preserve-merges, I would have expected=
=20
> you to touch pick_one_preserving_merges(), not pick_one().
>=20
> I would find it highly illogical to try to redo merges _without_ -p.

Me too, but I think it's not possible to do what I want with -p. -p
misses a definition of the (new) parent of a commit. It tries to preserve
all commits from all branches. But going through the _list_ of commands
couldn't preserve this structure.

o--A--B
 \     \
  C--D--M--E

How should the graph look like after these commands:

pick A
pick C
squash E
# pick D
pick B
pick M

Should

pick A
pick B
pick C
pick D
pick M
pick E

give a same graph like

pick C
pick A
pick D
pick B
pick M
pick E

Bye, J=F6rg.
--=20
< Mr X.> jo: contact an admin to mount it for you
< jo> The admin is not, well how should I say it, he isn't very familiar wi=
th
      the system. What should I tell my admin, what he should do?
< Mr X.> taking a sun solaris administration course.

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH540Fwe0mZwH1VIARAlsqAJ4vxt9jiTzNhSYJ8deW5uZSlHW7/wCgiLr/
r+BTjVX4EhFlMUqlEOWdg8M=
=mgYU
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
