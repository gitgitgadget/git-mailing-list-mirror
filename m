From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH] git-svn: Allow using arguments to the editor.
Date: Wed, 18 Feb 2009 16:43:55 +0100
Message-ID: <200902181643.59516.trast@student.ethz.ch>
References: <1234964869-11159-1-git-send-email-rhonda@deb.at> <200902181515.59625.trast@student.ethz.ch> <20090218144814.GA23938@anguilla.debian.or.at>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2108819.bFFLqWWZo7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Gerfried Fuchs <rhonda@deb.at>
X-From: git-owner@vger.kernel.org Wed Feb 18 16:45:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZocE-0002VH-Oh
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 16:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752740AbZBRPoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 10:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbZBRPoL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 10:44:11 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:25947 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752635AbZBRPoK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 10:44:10 -0500
Received: from xfe1.d.ethz.ch ([82.130.124.41]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 18 Feb 2009 16:44:08 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe1.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 18 Feb 2009 16:44:08 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.27.7-9-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <20090218144814.GA23938@anguilla.debian.or.at>
X-OriginalArrivalTime: 18 Feb 2009 15:44:08.0098 (UTC) FILETIME=[BC610820:01C991DF]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110553>

--nextPart2108819.bFFLqWWZo7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Gerfried Fuchs wrote:
>  I'm not sure where quoted spaces and such are handled very much
> differently. How would you quote it that wouldn't make tons of programs
> fail? EDITOR=3D'"/my space path/prog"' doesn't work in most applications
> because they wouldn't strip the embedded quotes, neither does
> EDITOR=3D'/my\ space\ path/prog' work. EDITOR=3D'/my space path/prog' mig=
ht
> work in some (current git-svn) but not in all.

I have EDITOR=3D'emacs -nw' and it works for git, svn and hg.  (Which
are roughly the ones I care about.)

>  I haven't looked into how git does it directly, but it offers that
> posibility:
> EDITOR=3D"vim -c 'syn off'" git commit -a
>=20
>  I wasn't able to figure out any way to use a space-embedded filename in
> EDITOR for git - so why should git-svn behave differently here? But you
> are right, this very example shows clearly that my approach is
> incomplete because it can't handle the 'syn off' part.

launch_editor (in editor.c) does roughly the following in Perl:

  # set $editor according to config/variables
  my @editor =3D ($editor);
  if ($editor =3D~ /["$\t ]/) {
      @editor =3D ('sh', '-c', $editor . ' "$@"', $editor);
  }
  system(@editor, @rest_of_args);

I'm not a Perl expert but that's my current educated guess of what it
translates to ;-)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart2108819.bFFLqWWZo7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmcLL8ACgkQqUud07tmzP1EQgCeMvL1hdPdztHLbYJicKdiwufY
GpQAoIBlDnTGkh19Dscqk6m5J2Vvv0Ua
=Q3fN
-----END PGP SIGNATURE-----

--nextPart2108819.bFFLqWWZo7--
