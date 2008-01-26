From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] autoconf: Add test for sys/select.h header file
Date: Sat, 26 Jan 2008 10:42:53 +0100
Message-ID: <20080126094253.GP30676@schiele.dyndns.org>
References: <20080124183446.GJ30676@schiele.dyndns.org> <1201259981-7115-1-git-send-email-jnareb@gmail.com> <7v8x2d3xya.fsf@gitster.siamese.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsSkVHHhotaZRe1D"
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 10:44:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIhaH-0002AE-PT
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 10:44:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbYAZJnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 04:43:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754610AbYAZJnG
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 04:43:06 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:45019 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752769AbYAZJm6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 04:42:58 -0500
Received: by fg-out-1718.google.com with SMTP id e21so951863fga.17
        for <git@vger.kernel.org>; Sat, 26 Jan 2008 01:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        bh=U1oXVR/KC3yZM0L/DQ0BzsclAKgEz/5mkn+yarpIoHo=;
        b=bcBuiPpNQVkXRbS/jQek0L6CFdEsGEFy115Sa0oXBMi+ZkS05+AZdzxz8cXcvOF+Bl0gmRXMUraITUTOEda9NHfIGMaX6tjbUySFXdjkKKDREV7Km8JqHtj9tk5f9wQReyHOKtH5AnVATzyya/zQwLZ4wFT/JdifZLp83RcYrNU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=x4ruwYdLoJ0UAVrBjovKmxAlfyHIPsdxdJXttn9nPMWjQC2l8dB8sbj/xE0V+60gfPcu+YMgTyXIFhd5qq5KDx1zlf0Pl4dug3g4dX+YH5JxQTYKjMO8L5Dp306ZGHiGZdCOgL5Kr96Ny/et6T/kTzb8GeyN2wfUJRp4soxLeKE=
Received: by 10.86.100.7 with SMTP id x7mr2839948fgb.10.1201340576363;
        Sat, 26 Jan 2008 01:42:56 -0800 (PST)
Received: from sigkill.schiele.dyndns.org ( [91.18.125.111])
        by mx.google.com with ESMTPS id 3sm4712338fge.7.2008.01.26.01.42.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 26 Jan 2008 01:42:55 -0800 (PST)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id 4A1F948A17; Sat, 26 Jan 2008 10:42:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v8x2d3xya.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71768>


--KsSkVHHhotaZRe1D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 25, 2008 at 10:25:33PM -0800, Junio C Hamano wrote:
> The issue is not really about "do we have <sys/select.h>?" but
> is about "do we need to include <sys/select.h> in order to
> obtain declaration of select(2)?" so this is covering only a

This is true.  Actually HP-UX 11.23 for instance has sys/select.h but this =
is
not intended to be included to get the select call but this is intended to =
be
included by kernel drivers that implement the interface the kernel needs to
_provide_ the select call.  In that case the test determines that sys/selec=
t.h
exists but it does not notice that it is not the header to include.  It does
not hurt though since including sys/select.h outside of a kernel driver is a
no-op and we include sys/time.h which is really needed anyway.

> half of the issue.  But I guess we will find out if the system
> does not offer select(2) whether <sys/select.h> is included or
> not, so this is not too bad.
>=20
> Will apply.  I do not think it would have problems but even if
> it does it is small and easy to revert before the final.

At least on the systems I know it does not hurt even when it does not always
exactly what it is intended to do.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--KsSkVHHhotaZRe1D
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFHmwCdxcDFxyGNGNcRAhZOAKD91tTty2NRLYvEL+0yFlyEqKX4xgCcDbsP
GdZTN0rSr5iRI6PXYk6qYi4=
=I+WO
-----END PGP SIGNATURE-----

--KsSkVHHhotaZRe1D--
