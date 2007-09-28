From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git push (mis ?)behavior
Date: Fri, 28 Sep 2007 08:58:23 +0200
Message-ID: <20070928065823.GB19299@artemis.corp>
References: <20070927130447.GH10289@artemis.corp> <7v3awzvrpr.fsf@gitster.siamese.dyndns.org> <9D61974D-E08D-49F6-9C88-6BE446D53C74@zib.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Y7xTucakfITjPcLV";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 08:58:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ib9o0-00055A-RA
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 08:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757258AbXI1G60 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 02:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756741AbXI1G60
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 02:58:26 -0400
Received: from pan.madism.org ([88.191.52.104]:35671 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756728AbXI1G6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 02:58:25 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BF28E21144;
	Fri, 28 Sep 2007 08:58:24 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 1131FCB44; Fri, 28 Sep 2007 08:58:24 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Steffen Prohaska <prohaska@zib.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <9D61974D-E08D-49F6-9C88-6BE446D53C74@zib.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59373>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 28, 2007 at 06:52:47AM +0000, Steffen Prohaska wrote:
>=20
> On Sep 27, 2007, at 9:22 PM, Junio C Hamano wrote:
>=20
> >
> >So what's the desired semantics?
> >
> >The current semantics is:
> >
> >   "git push" says "you do not say to which repository?" and
> >   consults "branch.<current>.remote" but defaults to 'origin'
> >   if unconfigured.
> >
> >   "git push <name>" (or using the <name> determined as above)
> >   says "you do not say which branches?" and consults
> >   "remote.<name>.push" to find branches to push out, but
> >   defaults to 'matching branches' if unconfigured.
> >
> >What you would want to change is the fallback behaviour for
> >unconfigured "remote.<name>.push".  I think it is sensible to
> >have an option to make it push only the current branch.
>=20
> I'm not sure that changing the fallback behaviour for unconfigured
> "remote.<name>.push" is sufficient.
>=20
> When "remote.<name>.push" is set I'd expect "git push" to
> choose only the 'right' remote.<name>.push lines, that is
> the lines that have the current branch as the local ref.
> "git push" would only push the current branch, which could be pushed
> to 0 or more branches on the remote side. If no "remote.<name>.push"
> contains the current branch as a local ref nothing would happen
> (maybe a warning?). If several "remote.<name>.push" have the current
> branch as the local ref the branch would be pushed to several
> remote branches. But other branches than the current branch
> would _never_ be pushed if no argument is given to 'git push'.

  I'm not really sure that it makes sense, as by default, git push won't
create a new remote ref. So unless you have a branch that matches some
remote ref, but that you never want to push, even when on it and typing
git push... there is nothing that could happen by mistake.

  So if you don't want to push such a branch, ever, then you should IMHO
not name it in a way that it matches a refspec in the first place, and
be safe.

  So I do not believe we need that extra complexity.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG/KYPvGr7W6HudhwRAtngAJ9QA57zDK6nM2qZxnubyHhC6/tRRgCghOb3
P1uygmUbhUOXEicCf4Rn/6U=
=X6Oi
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
