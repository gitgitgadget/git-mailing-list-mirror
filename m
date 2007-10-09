From: Jan Hudec <bulb@ucw.cz>
Subject: Re: git push (mis ?)behavior
Date: Tue, 9 Oct 2007 07:05:33 +0200
Message-ID: <20071009050533.GA2968@efreet.light.src>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <9D61974D-E08D-49F6-9C88-6BE446D53C74@zib.de> <7vodfnqndc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Cc: Steffen Prohaska <prohaska@zib.de>,
	Pierre Habouzit <madcoder@debian.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 07:10:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If7M9-0007KN-By
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 07:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751126AbXJIFJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 01:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbXJIFJ2
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 01:09:28 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:40478 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751126AbXJIFJ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 01:09:27 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id C841B57332;
	Tue,  9 Oct 2007 07:09:25 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id fjvDFe+32PPl; Tue,  9 Oct 2007 07:09:21 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id AFA045739D;
	Tue,  9 Oct 2007 07:09:19 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1If7Hh-00011N-6w; Tue, 09 Oct 2007 07:05:33 +0200
Content-Disposition: inline
In-Reply-To: <7vodfnqndc.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60357>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2007 at 00:07:27 -0700, Junio C Hamano wrote:
> Steffen Prohaska <prohaska@zib.de> writes:
>=20
> > When "remote.<name>.push" is set I'd expect "git push" to
> > choose only the 'right' remote.<name>.push lines, that is
> > the lines that have the current branch as the local ref.

I would like this for another reason and maybe in slightly different way.
Basically I would have configured something along the lines:
    [remote "origin"]
    push =3D refs/heads/*:refs/heads/jahu/*
and would want to choose, via option, whether I want to push all the branch=
es
or just the current one, but in any case with the renaming specified.

The idea behind this is to have a shared repository, but not shared branche=
s.
Everybody would have a subdirectory in refs/heads where he could push
anything that the others should see and than somebody else (either designat=
ed
integrator, or just anybody different) would do a quick review and merge it
into master.

Now I could of course push out everything, but usually I'd want to push
exactly the current branch, renaming it by the rule given, whether it alrea=
dy
existed in origin or not. Than there can be eg. a post-receive hook notifyi=
ng
the integrator that there is something for review.

> That would break the existing setup so it would not fly as a
> default, although it could be added as an option.

We can have an option and/or we can have some new parameter in .git/config.
Maybe:
    push =3D refs/heads/*:refs/heads/jahu/*
would mean to push always (ie. everything under refs/heads) and eg.:
    push =3D !refs/heads/*:refs/heads/jahu/*
would mean to push just current branch if it matches. Mixed setups would be
possible:
    push =3D refs/heads/*:refs/heads/jahu/* !master:master !next:next
would mean push everything to jahu/ and if current is master, push it to
master, or if current is next, push it to next.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHCwwdRel1vVwhjGURAuKFAKCVFZpW/X8Jf+V6r99kqVZrylZ2RACgvtPk
KmVOoaKdnJ3CM/o7v56R7cE=
=+Kd7
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
