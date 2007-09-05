From: Johan Herland <johan@herland.net>
Subject: Re: People unaware of the importance of "git gc"?
Date: Wed, 5 Sep 2007 10:13:31 +0200
Message-ID: <200709051013.39910.johan@herland.net>
References: <alpine.LFD.0.999.0709042355030.19879@evo.linux-foundation.org> <7vsl5tk1r8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1758000.XtXdatS5Ly";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 05 10:19:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISq6h-0005D7-LQ
	for gcvg-git@gmane.org; Wed, 05 Sep 2007 10:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755942AbXIEITX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 04:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755930AbXIEITX
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 04:19:23 -0400
Received: from sam.opera.com ([213.236.208.81]:34345 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755913AbXIEITW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 04:19:22 -0400
X-Greylist: delayed 310 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Sep 2007 04:19:17 EDT
Received: from pc085.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l858De4W007724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 5 Sep 2007 08:13:44 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <7vsl5tk1r8.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: ClamAV 0.91.1/4159/Wed Sep  5 06:09:35 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57685>

--nextPart1758000.XtXdatS5Ly
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 05 September 2007, Junio C Hamano wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>=20
> > I personally repack everything way more often than is necessary, and I =
had=20
> > kind of assumed that people did it that way, but I was apparently wrong=
=2E=20
> > Comments?
>=20
> I am as old timer as you are so I am not qualified to add much
> variety to the discussion, but I agree that excessive cruft is
> something we should warn the user about.
>=20
> I personally was _extremely_ annoyed by git-cvsimport
> occassionary deciding to repack whenever it finds more than
> certain number of loose objects, not because it is a big import,
> but because I happened to start the command to start a very
> small import after doing my own development for a while to
> accumulate loose objects, and I really hate automatic repacking
> for any operation (or tool that thinks it knows better than I do
> in general).
>=20
> Perhaps _exiting_ "git-commit" and "git-fetch" before doing
> anything, when the repository has more than 5000 loose objects
> with a LOUD bang that instructs an immediate repack would be
> good?
>=20
> I really do not like the idea of automatically running a repack
> after first interrupting the original command and then resuming.
> For one thing it would make a horribly difficult situation to
> debug if anything goes wrong.  You cannot reproduce such a
> situation easily.

What about some sort of middle ground:

When git-fetch and git-commit has done its job and is about to exit, it che=
cks=20
the number of loose object, and if too high tells the user something=20
like "There are too many loose objects in the repo, do you want me to repac=
k?=20
(y/N)". If the user answers "n" or simply <Enter>, it exits immediately=20
without doing anything, but if the user answers "y", or if there is no=20
response, say, within a minute (i.e. the user went to lunch), the repack is=
=20
initiated. (Of course, the user should be told that a Ctrl-C will abort the=
=20
repack and not be harmful in any way.)

If the user answers "n" (or aborts the repack), the question will keep popp=
ing=20
up on the next git-{commit,fetch} to remind/annoy the user until a repack i=
s=20
done.


=2E..Johan

=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart1758000.XtXdatS5Ly
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7-ecc0.1.6 (GNU/Linux)

iD8DBQBG3mUrBHj4kl4fT1wRAhQlAJ9ulLwRkaVFGaZGdynJb8ZrvXKxbQCgp3ss
RrKK3LkiWyn234DrioUXJU8=
=zilX
-----END PGP SIGNATURE-----

--nextPart1758000.XtXdatS5Ly--
