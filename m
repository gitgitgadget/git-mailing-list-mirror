From: Ismail =?utf-8?q?D=C3=B6nmez?= <ismail@pardus.org.tr>
Subject: Re: [PATCH] gitweb: use decode_utf8 directly
Date: Thu, 3 May 2007 22:22:32 +0300
Organization: TUBITAK/UEKAE
Message-ID: <200705032222.37387.ismail@pardus.org.tr>
References: <200704241705.19661.ismail@pardus.org.tr> <200705020012.13302.ismail@pardus.org.tr> <7v8xc85ill.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1816079.duJVLatUeJ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 03 21:21:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjgrt-00052t-TE
	for gcvg-git@gmane.org; Thu, 03 May 2007 21:21:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767751AbXECTV3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 15:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767746AbXECTV3
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 15:21:29 -0400
Received: from ns2.uludag.org.tr ([193.140.100.220]:47529 "EHLO uludag.org.tr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1767713AbXECTV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 15:21:28 -0400
Received: from southpark.local (unknown [88.254.104.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by uludag.org.tr (Postfix) with ESMTP id 6FF575F4BE05;
	Thu,  3 May 2007 22:21:17 +0300 (EEST)
User-Agent: KMail/1.9.6
In-Reply-To: <7v8xc85ill.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46098>

--nextPart1816079.duJVLatUeJ
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
On Wednesday 02 May 2007 00:39:34 Junio C Hamano wrote:
> Ismail D=C3=B6nmez <ismail@pardus.org.tr> writes:
> > Ok found out the reason. decode() tries to decode data that is already
> > UTF-8 and borks.
> >
> > This is from Encode.pm :
> >
> > sub decode_utf8($;$) {
> >     my ( $str, $check ) =3D @_;
> >     return $str if is_utf8($str); <--- Checks if the $str is already
> > UTF-8 if ($check) {
> >         return decode( "utf8", $str, $check ); <--- Else do what gitweb
> > does [...]
> >
> > So my patch is indeed correct.
>
> Ok, I think that makes it an improvement from the current code,
> so I'd apply.
>
> But at the same time I wonder why should the callers be feeding
> an already decoded string to to_utf8().  It might be that some
> callers needs fixing.

Is the patch OK do you want more investigation? Asking because its still no=
t=20
in git.git.

Regards,
ismail

--nextPart1816079.duJVLatUeJ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQBGOjZ9Gp0leluI9UwRAlMgAJ9M9Drmlcxi/P8x6ia5WvOl74B2NgCfVs67
xrPVuGEmfVOSg7o0t8UXrG8=
=/Qek
-----END PGP SIGNATURE-----

--nextPart1816079.duJVLatUeJ--
