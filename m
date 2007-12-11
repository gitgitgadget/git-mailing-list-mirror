From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: backups with git and inotify
Date: Tue, 11 Dec 2007 10:25:46 +0000
Message-ID: <20071211102546.GA5811@bit.office.eurotux.com>
References: <20071210202911.GA14738@bit.office.eurotux.com> <20071210215746.GA3022@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 11 11:26:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J22Jt-0004F5-Eq
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 11:26:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751902AbXLKK0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 05:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751881AbXLKK0L
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 05:26:11 -0500
Received: from os.eurotux.com ([216.75.63.6]:57212 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbXLKK0K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 05:26:10 -0500
Received: (qmail 11016 invoked from network); 11 Dec 2007 10:26:06 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 11 Dec 2007 10:26:06 -0000
Content-Disposition: inline
In-Reply-To: <20071210215746.GA3022@atjola.homenet>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67835>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 10, 2007 at 10:57:46PM +0100, Bj=F6rn Steinbrink wrote:
> On 2007.12.10 20:29:11 +0000, Luciano Rocha wrote:
<snip>
> > So, please, suggest.
>=20
> I posted an extremely simple bash script here:
> http://lkml.org/lkml/2007/12/7/279

That thread was what motivated me to write the program, but I must've
missed your post.

>=20
> It just employs inotifywait to do all watching and just needs to
> translate the events to the different git command. Did just glance over
> your code, but it seems to do basically the same thing, just that it's a
> lot shorter. The overhead of being a shell script is probably neglible,
> as the amount of git calls are likely dominating anyway.

Yes, being a shell script isn't a problem. I wasn't aware of
inotify-tools, so I wrote my own. Still, the inotify-tools programs miss
a check for ignoring directories with predetermined contents (I want to
ignore sub-directories with their own git repository).

I think I'll contribute to inotify-tools a switch for that, and switch
to perl. That will simplify the development and allow for coalescing
events, so that updates with temporary files would be a simple update.

> Feel free to ignore my comments on why I think that that is crap anyway
> and do whatever you want with the script.

FWIW, I also think that trying to keep a coherent stat with automatic
commits isn't possible. As for the temporary, unneeded files, a
exclusion pattern will suffice, and using .git directly, instead of a
(FUSE) filesystem, will allow permanent storage of those temporary
files, until explicitly removed.

Thanks,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHXmWqinSul6a7oB8RAnBPAJ4jyyWDlBo6XFCJIQ/jzGl1Fcu65wCghIJ0
tlc8PmjZ0xHLGy+v/4KITTs=
=RLq9
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
