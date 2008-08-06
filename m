From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: something fishy with Git commit and log from file
Date: Wed, 6 Aug 2008 11:44:32 +0100
Message-ID: <20080806104432.GG7121@bit.office.eurotux.com>
References: <48997D2E.9030708@obry.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/i8j2F0k9BYX4qLc"
Cc: git list <git@vger.kernel.org>
To: Pascal Obry <pascal@obry.net>
X-From: git-owner@vger.kernel.org Wed Aug 06 12:45:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQgWS-0006GO-9z
	for gcvg-git-2@gmane.org; Wed, 06 Aug 2008 12:45:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754271AbYHFKoj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2008 06:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753953AbYHFKoj
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Aug 2008 06:44:39 -0400
Received: from os.eurotux.com ([216.75.63.6]:39450 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753384AbYHFKoi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2008 06:44:38 -0400
Received: (qmail 24678 invoked from network); 6 Aug 2008 10:44:36 -0000
Received: from unknown (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by 0 with AES256-SHA encrypted SMTP; 6 Aug 2008 10:44:36 -0000
Content-Disposition: inline
In-Reply-To: <48997D2E.9030708@obry.net>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91500>


--/i8j2F0k9BYX4qLc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 06, 2008 at 12:30:06PM +0200, Pascal Obry wrote:
>=20
>  The following command fails on my repository:
>=20
>     $ git commit --file=3Dclog
>     fatal: could not read log file 'clog': No such file or directory
>=20
>     $ cat clog
>     toto
>=20
>  Using the following command the commit pass without problem:
>=20
>     $ cat clog | git commit --file=3D-
>=20
>  With GDB I get:
>=20
>  $ gdb --args git ci --file=3Dclog
>  This GDB was configured as "i686-pc-cygwin"...
>  (gdb) break strbuf_read_file
>  Breakpoint 1 at 0x44e64a: file strbuf.c, line 301.
>  (gdb) run
>  Starting program: /usr/local/bin/git.exe ci --file=3Dclog
>=20
>  Breakpoint 1, strbuf_read_file (sb=3D0x22cac0, path=3D0x22ccfa "clog", h=
int=3D0)=20
>  at strbuf.c:301
>  301             fd =3D open(path, O_RDONLY);
>  (gdb) print path
>  $1 =3D 0x0
>=20
>  ???? outch, this is strange, or a gdb artifact?

gdb artifact. The breakpoint info shows the correct value.

Could you at that point run the following?

(gdb) p get_current_dir_name()
$1 =3D ... "..."

If the returned value doesn't match the directory you were in, then
there's a bug in git.

If the function doesn't exist, try:
(gdb) p getwd(malloc(2048))

Regards,
Luciano Rocha

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--/i8j2F0k9BYX4qLc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiZgJAACgkQinSul6a7oB8mKgCeMfffokqBO6JgExW1Dcn4hapa
VM4An2tgZGL1AptLy+ZMwQSw1VYVxEhw
=I8Eh
-----END PGP SIGNATURE-----

--/i8j2F0k9BYX4qLc--
