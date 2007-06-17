From: Simon Hausmann <simon@lst.de>
Subject: Re: git-p4 fails when cloning a p4 depo.
Date: Sun, 17 Jun 2007 10:11:48 +0200
Message-ID: <200706171011.52492.simon@lst.de>
References: <1621f9fa0706080941k67d2878dud8cf06436c67aea0@mail.gmail.com> <1621f9fa0706081113w7bb765ebx74f03a7407b753cb@mail.gmail.com> <466DF32D.802@xs4all.nl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2116670.9MJ04T8crU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 17 10:11:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzpr7-0007QF-Ay
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 10:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754604AbXFQIL1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Jun 2007 04:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754419AbXFQIL0
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Jun 2007 04:11:26 -0400
Received: from verein.lst.de ([213.95.11.210]:52427 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753702AbXFQILZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jun 2007 04:11:25 -0400
Received: from luria.local (172.84-48-121.nextgentel.com [84.48.121.172])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l5H8BMo6024005
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Sun, 17 Jun 2007 10:11:23 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <466DF32D.802@xs4all.nl>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50339>

--nextPart2116670.9MJ04T8crU
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 12 June 2007 03:13:17 Han-Wen Nienhuys wrote:
> Benjamin Sergeant escreveu:
> > A perforce command with all the files in the repo is generated to get
> > all the file content.
> > Here is a patch to break it into multiple successive perforce command
> > who uses 4K of parameter max, and collect the output for later.
> >
> > It works, but not for big depos, because the whole perforce depo
> > content is stored in memory in P4Sync.run(), and it looks like mine is
> > bigger than 2 Gigs, so I had to kill the process.
>
> General idea of the patch is ok.  some nits:
> > +        chunk =3D ''
> > +        filedata =3D []
> > +        for i in xrange(len(files)):
>
> why not
>
>   for f in files:
>
> ?

It seems 'i' is used a bit later. Is there a nicer way to express this in=20
python?

> > +            f =3D files[i]
> > +            chunk +=3D '"%s#%s" ' % (f['path'], f['rev'])
> > +            if len(chunk) > 4000 or i =3D=3D len(files)-1:
>
> 4k seems reasonable enough, but can you take the min() with
> os.sysconf('SC_ARG_MAX') ?
>
> Can you address this and resend so we can apply the patch?
> Thanks.

Since I ran into the very problem of a too long commandline myself yesterda=
y I=20
took the liberty of adding the SC_ARG_MAX bit to Benjamin's patch and=20
comitting it then.


Simon

--nextPart2116670.9MJ04T8crU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGdOzIWXvMThJCpvIRAnCsAKDZdK6z2oKc88MpunEN7YVflwptKACcDe5u
bLbgZwpIcerZXTseWJgMl5I=
=kQIW
-----END PGP SIGNATURE-----

--nextPart2116670.9MJ04T8crU--
