From: Pierre HABOUZIT <madcoder@debian.org>
Subject: [PATCH] Re: git-svn: fix commits over svn+ssh://
Date: Sat, 14 Oct 2006 16:57:51 +0200
Message-ID: <20061014145751.GA8840@hades.madism.org>
References: <11608165571212-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qMm9M+Fa2AknHoGS"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 14 16:58:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYkxn-0001J8-Gt
	for gcvg-git@gmane.org; Sat, 14 Oct 2006 16:58:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422661AbWJNO56 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Oct 2006 10:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbWJNO55
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Oct 2006 10:57:57 -0400
Received: from pan.madism.org ([88.191.16.128]:43212 "EHLO hermes.madism.org")
	by vger.kernel.org with ESMTP id S1752170AbWJNO55 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Oct 2006 10:57:57 -0400
Received: from hermes.madism.org (localhost.localdomain [127.0.0.1])
	by hermes.madism.org (Postfix) with ESMTP id 85D5CB005D;
	Sat, 14 Oct 2006 16:57:52 +0200 (CEST)
Received: from hades.madism.org (olympe.madism.org [82.243.245.108])
	by hermes.madism.org (Postfix) with ESMTP id E2A65B005C;
	Sat, 14 Oct 2006 16:57:49 +0200 (CEST)
Received: by hades.madism.org (Postfix, from userid 1000)
	id 00C4462127; Sat, 14 Oct 2006 16:57:51 +0200 (CEST)
To: Eric Wong <normalperson@yhbt.net>, 392702@bugs.debian.org
Content-Disposition: inline
In-Reply-To: <11608165571212-git-send-email-normalperson@yhbt.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-AV-Checked: ClamAV (using ClamSMTP) at pan.madism.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28880>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  I confirm that fixes it indeed.

On Sat, Oct 14, 2006 at 02:02:37AM -0700, Eric Wong wrote:
> Once a get_commit_editor has been called from an SVN session, RA
> layer operations are not allowed (well, unless you're using
> file:// or http(s)://).  So we'll pass an alternate SVN::Ra
> object to our editor object for running 'check-path'.
>=20
> This should fix commits over svnserve (svn:// without ssh, too).
>=20
> Closes Debian bug #392702, thanks to Pierre Habouzit for
> reporting the bug.
>=20
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>  git-svn.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/git-svn.perl b/git-svn.perl
> index a128d90..0f968c8 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -536,7 +536,7 @@ sub commit_lib {
>  			$SVN =3D libsvn_connect($repo);
>  			my $ed =3D SVN::Git::Editor->new(
>  					{	r =3D> $r_last,
> -						ra =3D> $SVN,
> +						ra =3D> $SVN_LOG,
>  						c =3D> $c,
>  						svn_path =3D> $SVN_PATH
>  					},
> @@ -832,7 +832,7 @@ sub commit_diff {
>  	$SVN ||=3D libsvn_connect($repo);
>  	my @lock =3D $SVN::Core::VERSION ge '1.2.0' ? (undef, 0) : ();
>  	my $ed =3D SVN::Git::Editor->new({	r =3D> $SVN->get_latest_revnum,
> -						ra =3D> $SVN, c =3D> $tb,
> +						ra =3D> $SVN_LOG, c =3D> $tb,
>  						svn_path =3D> $SVN_PATH
>  					},
>  				$SVN->get_commit_editor($_message,
--=20
=B7O=B7  Pierre Habouzit
=B7=B7O                                                madcoder@debian.org
OOO                                                http://www.madism.org

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFMPrvvGr7W6HudhwRAhuZAJsHIut3xP0XGUuxgi08TMLOLKtJsgCcD2YM
bFrP1v4upA2Lw5kQUE69e2k=
=jSqF
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
