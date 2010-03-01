From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: Gitweb: Scan dir for repos & show these other specified repos
Date: Mon, 01 Mar 2010 22:20:19 +0100
Message-ID: <1267478419.4400.2.camel@kheops>
References: <4B8C1267.2050301@gmail.com>
	 <m33a0jn7ft.fsf@localhost.localdomain>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-LfGPpqGxk13a+X0Zeixe"
Cc: "Mike.lifeguard" <mike.lifeguard@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 01 22:20:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmD2T-0008R0-NB
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 22:20:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377Ab0CAVUY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 16:20:24 -0500
Received: from mail-bw0-f212.google.com ([209.85.218.212]:43117 "EHLO
	mail-bw0-f212.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315Ab0CAVUX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 16:20:23 -0500
Received: by bwz4 with SMTP id 4so2203493bwz.28
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 13:20:22 -0800 (PST)
Received: by 10.204.33.215 with SMTP id i23mr3547412bkd.86.1267478422305;
        Mon, 01 Mar 2010 13:20:22 -0800 (PST)
Received: from ?192.168.0.77? (smj33-1-82-233-66-33.fbx.proxad.net [82.233.66.33])
        by mx.google.com with ESMTPS id 16sm2368421bwz.13.2010.03.01.13.20.20
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 01 Mar 2010 13:20:21 -0800 (PST)
In-Reply-To: <m33a0jn7ft.fsf@localhost.localdomain>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141349>


--=-LfGPpqGxk13a+X0Zeixe
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-03-01 at 11:55 -0800, Jakub Narebski wrote:
> "Mike.lifeguard" <mike.lifeguard@gmail.com> writes:
>=20
> > Is it possible to have gitweb show all repositories in /path/to/whereve=
r
> > and also show some other repositories at particular locations like
> > /home/user/git/repo1 and /home/user2/git/repo2 ? Or better yet, scan
> > multiple dirs? Currently I can only see how to do one or the other
> > within a single gitweb installation. I suppose I could run two of them.=
..
>=20
> It is not possible with $projects_list being directory (or undefined,
> which means to take $projectroot), but I think it is possible with
> $projects_list being a file.
>=20
> You would have to set $projectroot to common prefix (it might be
> empty, i.e. '' if there is no common prefix), then list there all
> repositories, relative to $projectroot.  See gitweb/README and
> gitweb/INSTALL, and comments in gitweb.perl for details on file
> format.
>=20
>=20
> P.S. It probably be a good idea to have something like mod_userdir,
> but gitweb currently doesn't support something like that.

I had the same problematic some times ago. I wanted to have several
project's roots folder for gitweb (one for each unix user of the
server).

You can find the discussion here :

http://thread.gmane.org/gmane.comp.version-control.git/132926/
http://marc.info/?t=3D125827961600002&r=3D1&w=3D2

Here the configuration I used :

/etc/gitweb.conf :

$projectroot =3D $ENV{'GITWEB_PROJECTROOT'} || "/var/gitweb";

/etc/apache2/sites-available/yourvirtualhost :

RewriteEngine on
RewriteRule ^/$ /cgi-bin/gitweb.cgi [QSA,L,PT]
RewriteRule ^/\~([^\/]+)/?$ /cgi-bin/gitweb.cgi
[QSA,E=3DGITWEB_PROJECTROOT:/home/$1/gitweb/,L,PT]

I.E. :

http://yourvirtualhost/ will have /var/gitweb as proeject root
http://yourvirtualhost/~<user>/ will have /home/<users>/gitweb as
proeject root

You can modify the rewrite rule to match what you want to do.

>=20
> P.P.S. Alternate solution would be to try to work around it with
> automount / autofs or something like that.


--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-LfGPpqGxk13a+X0Zeixe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkuML4wACgkQ+TklUoyVcyfWbwCeK4NEEIlCWndFKXqtuEXSPEoS
vIMAoJwU9pv5YEEafYXtbUYntJU2dbrT
=MLrS
-----END PGP SIGNATURE-----

--=-LfGPpqGxk13a+X0Zeixe--
