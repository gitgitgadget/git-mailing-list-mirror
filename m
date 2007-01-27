From: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
Subject: Re: More precise tag following
Date: Sat, 27 Jan 2007 14:50:00 +0100
Message-ID: <45BB5888.9020608@fs.ei.tum.de>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.63.0701271352170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9E7A607AAECF6755B9C91A4B"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jan 27 14:50:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAnwq-0000gv-IY
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 14:50:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbXA0NuM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 08:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbXA0NuM
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 08:50:12 -0500
Received: from stella.fs.ei.tum.de ([129.187.54.7]:51638 "EHLO
	stella.fs.ei.tum.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752274AbXA0NuL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 08:50:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.fs.ei.tum.de (Postfix) with ESMTP id 762182816A;
	Sat, 27 Jan 2007 14:50:09 +0100 (CET)
X-Virus-Scanned: by amavisd-new at fs.ei.tum.de
Received: from stella.fs.ei.tum.de ([127.0.0.1])
	by localhost (stella.fs.ei.tum.de [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id PWpKJLwn9tel; Sat, 27 Jan 2007 14:50:09 +0100 (CET)
Received: from [62.216.202.61] (ppp-62-216-202-61.dynamic.mnet-online.de [62.216.202.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by stella.fs.ei.tum.de (Postfix) with ESMTP id 9D0A228165;
	Sat, 27 Jan 2007 14:50:08 +0100 (CET)
User-Agent: Mail/News 1.5.0.4 (X11/20060619)
In-Reply-To: <Pine.LNX.4.63.0701271352170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37957>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9E7A607AAECF6755B9C91A4B
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Johannes Schindelin wrote:
> It is slower than Subversion's counterpart, just because SVN's blame=20
> sucks. You cannot find out the _relevant_ information easily, i.e. once=
=20
> you merged something, the _merge_ gets attributed for the change (at le=
ast=20
> the last time I tried it).
>=20
> So, don't blame blame for being useful in git.

Your reasoning is backwards.  Git's blame (or fwiw, rev-list path.name) i=
s not slower because it is doing a better job (I can't tell, I don't use =
svn), but because it uses an algorithm which doesn't scale.  rev-list and=
 blame are O(number of commits between HEAD and root) and not O(number of=
 commits affecting path).  It might be sufficient for git.git, but certai=
nly not for projects with a long history.  we are talking KDE, FreeBSD, O=
Oo, something like this.  They each got about 400k commits.  It takes lit=
erally *minutes* to get a rev-list or a blame for a certain path.  The al=
gorithm simply does not scale.  And this has nothing to do with superior =
output, because hg does it in O(num_of_file_revs), so it *can* be done.

> Of course, you could introduce a cache, but then, I don't run blame _th=
at_=20
> often.

I don't think a cache is the right way.  I'd call the right idea "auxilla=
ry information".

> Besides, we already introduced an orthogonal historisation by reflogs, =
and=20
> your method would not cope gracefully with that, would it?

I don't see how reflogs can play into this.  After all we're talking abou=
t the series of commits the blob experienced to get into its current stat=
e, not the series of actions it took this repo to contain this blob.

cheers
  simon

--=20
Serve - BSD     +++  RENT this banner advert  +++    ASCII Ribbon   /"\
Work - Mac      +++  space for low =E2=82=AC=E2=82=AC=E2=82=AC NOW!1  +++=
      Campaign     \ /
Party Enjoy Relax   |   http://dragonflybsd.org      Against  HTML   \
Dude 2c 2 the max   !   http://golden-apple.biz       Mail + News   / \


--------------enig9E7A607AAECF6755B9C91A4B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (DragonFly)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFu1iLr5S+dk6z85oRAirTAKD+6uyHA+cwoKruvT+b5eTVytJ/fwCfZ4R/
anYr7hJ4duSOh12lZDBcdJY=
=eAVF
-----END PGP SIGNATURE-----

--------------enig9E7A607AAECF6755B9C91A4B--
