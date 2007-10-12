From: Jan Hudec <bulb@ucw.cz>
Subject: Re: RCS keyword expansion
Date: Fri, 12 Oct 2007 14:57:51 +0200
Message-ID: <20071012125751.GB7865@efreet.light.src>
References: <Pine.LNX.4.64.0710111542420.23849@ds9.cixit.se> <86fy0hvgbh.fsf@blue.stonehenge.com> <20071011155956.GC11693@cs-wsok.swansea.ac.uk> <Pine.LNX.4.64.0710112144380.4174@racer.site> <Pine.LNX.4.62.0710120723480.11771@perkele.intern.softwolves.pp.se> <Pine.LNX.4.64.0710121057540.25221@racer.site> <Pine.LNX.4.64.0710121144001.3682@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Y7xTucakfITjPcLV"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Oct 12 15:03:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgK5u-0005SY-Ur
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 14:58:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759484AbXJLM6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 08:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbXJLM6J
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 08:58:09 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:34443 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753276AbXJLM6I (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 08:58:08 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 6587A57442;
	Fri, 12 Oct 2007 14:58:04 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id XLQpqzYXf9FS; Fri, 12 Oct 2007 14:57:58 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 48B5D572DD;
	Fri, 12 Oct 2007 14:57:55 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IgK5P-0003nU-B0; Fri, 12 Oct 2007 14:57:51 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710121144001.3682@ds9.cixit.se>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60687>


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 12, 2007 at 11:50:51 +0100, Peter Karlsson wrote:
> > But don't you see?  When switching branches, this totally breaks down.
>=20
> Why would it? If the file is the same on both branches, nothing would
> happen (it is still the same version), and if the file is different, it
> gets changed anyway, and a new keyword expansion would take place.

It does not -- the blob ID is the same. And you can indeed get $Id$ expanded
to that (see gitattributes(5)). However, that's the ONLY thing that is the
same. The date of last modification or ID of commit that last touched that
file might not.

Why? Because git tracks content, not history. The trees and blobs (files) a=
re
identified by SHA1 hashes of their content. Only commit objects add the
notion of history. Thus if two commits contain file with the same text, it's
the same file. Even if the file is the same in those commit purely by
accident.

> > No, really, IMHO it is enough to show either the commit name or the
> > blob name of the file. After all, you are not interested in the date
> > that this file was last committed, but in the _contents_.
>=20
> Yes, but I want it on the lowest addressable unit size, i.e on the file
> level (I could possibly want to have the last commit for a set of files
> when I have something that get generated from several sources, but that
> is rare for a regular website, unless since javascripts and stylesheets
> etc. are delivered separately).
>=20
> Already today when you do "git log" on a file, you get the log filtered
> for only changes to that file. So the mechanisms seem already to be
> there, I just need to figure out how to apply them to what I want.

Yes. But you need the (current) commit for that. Now if a file foo is the
same on branches A and B, switching between them will not touch that file,
but git log foo may well give you completely different results. That's why
there's no date or commit that last touched a file.

> > So why not go for the contents?  With CVS/SVN you only have the
> > chance to do that by date or version number. With git, we have a more
> > powerful way: we do it by a hash of the contents.
>=20
> Yes, but the hash if of "everything". I'm not interested in
> "everything" in this context, and I don't want to have a separate git
> repository for each file...
>=20
> > If it's not what you want, I suggest rethinking what you want ;-)
> > Otherwise it is scripting time for you.  It's easy enough with git.
>=20
> That's what I'm trying to figure out. I assume it would be possible to
> do with some kind of hook that is run on checkout. But I can't figure
> out how to do that.

If you read the (already mentioned) gitattributes(5) manpage, you'll find
description of smudge and clean filters. They will be applied to each file
written out to the tree and read back respectively. But be sure to understa=
nd
why you can't -- for principial, not techical reasons -- have the date or
commit ID expanded correctly in all cases.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--Y7xTucakfITjPcLV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHD29PRel1vVwhjGURArLkAJ0RZ+a1CzdepSobsxXFM6DGLcg3AQCeNeyA
7gWqcNaU7URsyXBFplEqJeE=
=kd1W
-----END PGP SIGNATURE-----

--Y7xTucakfITjPcLV--
