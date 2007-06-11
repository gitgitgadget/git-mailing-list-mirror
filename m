From: Simon Hausmann <simon@lst.de>
Subject: Re: Asking again... [Re: how to properly import perforce history?]
Date: Mon, 11 Jun 2007 20:42:12 +0200
Message-ID: <200706112042.16331.simon@lst.de>
References: <20070608202236.GJ25093@menevado.ms.com> <200706111656.33696.simon@lst.de> <81b0412b0706110844i12ebe52m21735815cc06effa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4770197.g5srIs7F7C";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 20:42:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxoqG-0000gq-ED
	for gcvg-git@gmane.org; Mon, 11 Jun 2007 20:42:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754048AbXFKSmI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jun 2007 14:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754421AbXFKSmI
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jun 2007 14:42:08 -0400
Received: from verein.lst.de ([213.95.11.210]:40416 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753671AbXFKSmG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2007 14:42:06 -0400
Received: from luria.local (172.84-48-121.nextgentel.com [84.48.121.172])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l5BIg1o6012278
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Mon, 11 Jun 2007 20:42:02 +0200
User-Agent: KMail/1.9.7
In-Reply-To: <81b0412b0706110844i12ebe52m21735815cc06effa@mail.gmail.com>
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49866>

--nextPart4770197.g5srIs7F7C
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 11 June 2007 17:44:04 Alex Riesen wrote:
> On 6/11/07, Simon Hausmann <simon@lst.de> wrote:
> > *plug* You could try with git-p4 from http://repo.or.cz/w/fast-export.g=
it
> > . It should be just a matter of calling
> >
> >         git-p4 clone //depot/path
>
> Can I suggest you add a target directory mapping to your tool?
> Something like:
>
>   git-p4 clone //depot/project/path [libs/project/path] [rev-range]

I'm not sure I understand the libs/project/path part, but the revision rang=
e=20
can be specified in p4-like syntax as part of the depot path. For example

	git-p4 clone //depot/path@12,435

to import from revision 12 up to 435. The revision range is more or less=20
passed directly to "p4 changes", with the exception of "@all".

Han-Wen implemented also support for importing multiple depot paths at the=
=20
same time (and tracking them in one git branch).

> The way Perforce handles branches and directories leads to
> the problem that it actually cannot cleanly support neither of
> them, and it is very hard to untangle a big repo which
> historically has had many projects living in it.
> Especially if some idiot actually tried to "do branching".

I agree, even with a lot of discipline it's very hard to do a 100% accurate=
=20
import with logical branches.

The environment I'm working in is not too big and fairly liberal and=20
reasonably disciplined. I'm using p4 branch mappings to "map" some branches=
=20
from perforce to git, which for sure isn't perfect but works overall fine. =
Of=20
course that doesn't cover p4 integration changes, but just for tracking=20
multiple "logical" p4 branches it works great (for me at least :).

> And, BTW, don't you have a small problem with filenames with
> spaces and quoting?

I'm not aware of any problems. For example in our depot we have filenames w=
ith=20
spaces in them and they appear just fine in my git import. Did you run into=
=20
any specific case? It could very well be that there's a bug somewhere that=
=20
I'm just not hitting myself, so I'm curious :)


Simon

--nextPart4770197.g5srIs7F7C
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGbZeIWXvMThJCpvIRAiABAKDJfDivhboOMWA7vfTKmPkXUFrKzgCgxfEx
KZZdRNd8aDHQJue4cNdKpVA=
=QCOv
-----END PGP SIGNATURE-----

--nextPart4770197.g5srIs7F7C--
