From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Workflow: split repository?
Date: Fri, 12 Oct 2007 16:30:43 +0200
Message-ID: <20071012143043.GD7865@efreet.light.src>
References: <200710121421.39159.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="veXX9dWIonWZEC6h"
Cc: Git Mailing List <git@vger.kernel.org>
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Fri Oct 12 16:38:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgLXZ-0007Ok-IO
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 16:31:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbXJLOav (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 10:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754267AbXJLOav
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 10:30:51 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:47649 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751818AbXJLOau (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 10:30:50 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 91C9257509;
	Fri, 12 Oct 2007 16:30:48 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id O-WKrN2xGOKK; Fri, 12 Oct 2007 16:30:45 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 1D4D2574EA;
	Fri, 12 Oct 2007 16:30:45 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IgLXH-00042Q-Ds; Fri, 12 Oct 2007 16:30:43 +0200
Content-Disposition: inline
In-Reply-To: <200710121421.39159.wielemak@science.uva.nl>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60693>


--veXX9dWIonWZEC6h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2007 at 14:21:39 +0200, Jan Wielemaker wrote:
> Hi,
>=20
> I've got a big active project, until yesterday managed using CVS. As
> with any distributed academic research project the repository has become
> a nice mess where most files are in the wrong place and there are
> several almost independent sub-projects living in directories.
>=20
> The plan is/was to
>=20
> 	* Convert everything to GIT (done, through cvs2svn)
> 	* Everyone keeps hacking on their bits, while one is starting
> 	to reorganise the structure by moving files and directories
> 	and changing import headers, and other file references in
> 	a GIT branch.
> 	* Now we merge the continued work and the reorganisation to
> 	end up with a nice clean hierarchy :-)
> 	* Split the big project into multiple projects.  One of the
> 	reasons is that we want to make part of them public.  Others
> 	we cannot publish as they contain copyrighted data.  I understand
> 	we can reunite them using GIT sub modules.
>=20
> Does this make sense?

It might make more sense to convert bit by bit, to separate git repositorie=
s.
Would save you some git-filter-branch work.

> While splitting we want to *loose* history information for some of the
> projects.  That is easy: simply create a new repository from the current
> files.  For some however we would like to *preserve* the history.  This
> means we would like to pick a hierarchy with its history.  After quite
> a bit of reading, I get the impression this cannot be done.  Am I right?

It can, but you have to be aware of the pitfalls. Git allows you to create
a new history, which is defined modification of the original history. There
is git-filter-branch command, that can create a repository with just
a subtree and such. But it's a new, independent, history. You can't merge
between the old and new one (but you can rebase the few commits someone made
while you were converting) and anyone who has the old history in his repo
will still have it.

> Is the only way to create a GIT repositiory right away from a subset of
> the CVS for which we want to preserve the history?

No, it's not. It will save you work if you can do as much splitting as
possible during the conversion, ie. convert the bits you know will be
separate separately (and combine them using submodules as appropriate).

But if you have bits that will take a lot of work to factor out, you can
convert to git, make the other code ready to use a submodule and than use
git-filter-branch to extract the right bits of history for the submodule.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--veXX9dWIonWZEC6h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHD4UTRel1vVwhjGURAoMBAKDEw+mjC27V9scc5fO4IGkEI5N/vgCcCJAI
4xVQ4Ms241H0N5IE3tQ4buk=
=SxHx
-----END PGP SIGNATURE-----

--veXX9dWIonWZEC6h--
