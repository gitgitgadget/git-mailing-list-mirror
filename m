From: Luciano Rocha <luciano@eurotux.com>
Subject: Re: [PATCH] Make git send-email accept $EDITOR with arguments
Date: Thu, 20 Dec 2007 20:32:11 +0000
Message-ID: <20071220203211.GA12296@bit.office.eurotux.com>
References: <1198181646-28632-1-git-send-email-hendeby@isy.liu.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Thu Dec 20 21:32:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J5S4P-0004F3-Uk
	for gcvg-git-2@gmane.org; Thu, 20 Dec 2007 21:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754414AbXLTUcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Dec 2007 15:32:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbXLTUcS
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Dec 2007 15:32:18 -0500
Received: from os.eurotux.com ([216.75.63.6]:46873 "EHLO os.eurotux.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752845AbXLTUcR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Dec 2007 15:32:17 -0500
Received: (qmail 12657 invoked from network); 20 Dec 2007 20:32:16 -0000
Received: from nc.eurotux.com (HELO bit.office.eurotux.com) (luciano@81.84.255.161)
  by os.eurotux.com with AES256-SHA encrypted SMTP; 20 Dec 2007 20:32:16 -0000
Content-Disposition: inline
In-Reply-To: <1198181646-28632-1-git-send-email-hendeby@isy.liu.se>
User-Agent: Mutt/1.5.14 (2007-03-31)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69014>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 20, 2007 at 09:14:06PM +0100, Gustaf Hendeby wrote:
<snip>
> I'm not completely satisfied with the problem with embedded spaces,
> but my Perl skills aren't good enough to do anything about it.  If
> anyone have any suggestions on how to do it, it would be greatly
> appreciated.  None-the-less, even with this shortcoming, I think this
> is a step in the right direction.
>=20
>  git-send-email.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>=20
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 248d035..47ae77c 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -400,7 +400,7 @@ EOT
>  	close(C);
> =20
>  	my $editor =3D $ENV{GIT_EDITOR} || $repo->config("core.editor") || $ENV=
{VISUAL} || $ENV{EDITOR} || "vi";
> -	system($editor, $compose_filename);
> +	system((split ' ', $editor), $compose_filename);

That should be enough. Use system("$editor $compose_filename") to use
perl's implicit split or, in case of meta-characters in the string,
external sh -c.

Or always use the shell:
$shell =3D $ENV{SHELL} || "/bin/sh";
system($shell, "-c", "$editor $compose_filename");

BTW, maybe add a check for the return code?
system(...) =3D=3D 0 or die "editor failed\n";

--=20
Luciano Rocha <luciano@eurotux.com>
Eurotux Inform=E1tica, S.A. <http://www.eurotux.com/>

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQFHatFLinSul6a7oB8RAuSGAKCV17GTW/1nRiuoFPyB3DIkI67wlACdFKRf
v2CYvUF6XRb6NpePWZ0nLRg=
=64f3
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
