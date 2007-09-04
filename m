From: Jan Hudec <bulb@ucw.cz>
Subject: Re: .gitignore, .gitattributes, .gitmodules, .gitprecious?,
	.gitacls? etc.
Date: Tue, 4 Sep 2007 22:49:52 +0200
Message-ID: <20070904204952.GD3786@efreet.light.src>
References: <7vhcmmpxed.fsf@gitster.siamese.dyndns.org> <B4A2AE9980774365B5D14B442A7A22F6@ntdev.corp.microsoft.com> <46D23C48.6060904@vilain.net> <85ps19a5hm.fsf@lola.goethe.zz> <46D2ADF6.70100@vilain.net> <Pine.LNX.4.64.0708271226360.28586@racer.site> <46D33A15.1000003@vilain.net> <Pine.LNX.4.64.0708280942360.28586@racer.site> <46D4A4F8.9040004@vilain.net> <Pine.LNX.4.64.0708290007020.28586@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Cc: Sam Vilain <sam@vilain.net>, Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 04 22:50:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISfM0-0007iO-5y
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 22:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbXIDUt7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 16:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754346AbXIDUt6
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 16:49:58 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:39016 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754802AbXIDUt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 16:49:57 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 539CC57306;
	Tue,  4 Sep 2007 22:49:56 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id Qm5okYtV-8ll; Tue,  4 Sep 2007 22:49:54 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id DAB7A572D0;
	Tue,  4 Sep 2007 22:49:53 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1ISfLM-00052z-D5; Tue, 04 Sep 2007 22:49:52 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708290007020.28586@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57642>


--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 29, 2007 at 00:07:55 +0100, Johannes Schindelin wrote:
> On Wed, 29 Aug 2007, Sam Vilain wrote:
> > Johannes Schindelin wrote:
> > >> Ok, but let's say for a moment that file properties are allowed, and=
=20
> > >> that they are stored in the Reiser4 fashion. On filesystems that did=
 not=20
> > >> support this, it would be the only way to get at them - to go throug=
h=20
> > >> the index. Unless they were also mapped to regular files, or=20
> > >> filesystem-specific features somehow.
> > >=20
> > > Happily, file properties as well hidden as these have _no_ _place_ in=
=20
> > > source code that needs to be tracked.
> >=20
> > But you're restricting your statements to tidy, sane code bases.  Are
> > there any particular reasons that git shouldn't be able to track insane
> > code bases, with attributes etc?  It sure would shut up a whole load of
> > people.
>=20
> To the contrary.  People having those insane setups seem to be unable to=
=20
> admit it.  And I'm sure you saw some on this very list, like me.  They=20
> never shut up, they only get louder.

Whether it's insane depends on whether you want to keep git purely for
source control -- in which case they are definitely insane -- or want to
allow git to grow to a tool useful for other cases, like tracking content of
/etc, whole filesystem images and similar stuff -- in which case most of
those setups are not insane at all.

Personally I would vote for a middle ground. To keep core git simple, but to
provide enough hooks to build the other tools on top of it. Enough hooks in
this case would mean (at least the way I can imagine as workable) hooks to
run when transfering files between worktree and index and place for the hoo=
ks
to store the extra tracked information. This place could be some of special
named file (.gitxattrs or anything) which would be updated in index by the
hook, special index entries somehow related to individual filenames and/or
headers prepended to the blobs and trees. Any of those methods can be used
for storing permissions, acl, extended attributes and other random stuff and
different ones could be used by different hooks at the same time.

Each of those methods has it's advantages and disadvantages. The special
files are easiest to store if the hook is not available or can't represent
the data in given worktree -- simply make the special files regular. The
entries attached to files (which are equivalent of extended attributes) wou=
ld
work with standard merge on them (because they are handled individually) and
the headers to files would probably require least changes to git (I believe
they are implementable for files with git as is using the hook provided for
keyword expansion (or is it not there?)).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG3cTwRel1vVwhjGURAqnDAKDuc1z3VTCMKk1Gze0nMH+QjxUblwCfWiYL
6nz3U3mMiaNqDXSRJULRJnU=
=9H2V
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--
