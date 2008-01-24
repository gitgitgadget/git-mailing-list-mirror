From: Robert Schiele <rschiele@gmail.com>
Subject: Re: [PATCH] some systems don't have (and need) sys/select.h
Date: Thu, 24 Jan 2008 22:58:03 +0100
Message-ID: <20080124215803.GN30676@schiele.dyndns.org>
References: <20080124183446.GJ30676@schiele.dyndns.org> <7vk5ly9b51.fsf@gitster.siamese.dyndns.org>
Reply-To: Robert Schiele <rschiele@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Epi5nlKhkk4Kf+ga"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 22:58:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIA5o-0001Dx-7S
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 22:58:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbYAXV6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 16:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754375AbYAXV6J
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 16:58:09 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:61208 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbYAXV6H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 16:58:07 -0500
Received: by fg-out-1718.google.com with SMTP id e21so375147fga.17
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 13:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        bh=mbd4tXeI1ccbb/5YnNb3fTbH2jNNZ85ZbbSS/YkFTIU=;
        b=hUs3NAxb8EWpr16C9KukVA0QcoTFINtgiYwD1v4EvJgdh7P5nN2DsSqsZ8nGrAySI2x4gM5WsCeI/aUZVsw11CQX5ozYfidEibeZpJ8ic/Ert95/NridDlQjMS7fClqxo+n3F40SSgIWsoLaYJs6QHVCYLfAiiw/aBYUtVgJ418=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from:reply-to;
        b=aiUmqZ6mRG+ctbwdLbxHWLDxEIlTb9n9UqweS53CG02nP3QRTC+8Pmt7kqgtYpbW5Q3YdHYiLkrsOnmOgsY3NcoJa3MrAOguQx2T7CEb+0GlKPYj4pap1st9D7T/XgKFnhCwGzNii/9g1d68j/jRL2Ug0NoU7qmKPY3WVBEPg5s=
Received: by 10.86.25.17 with SMTP id 17mr1104933fgy.15.1201211885520;
        Thu, 24 Jan 2008 13:58:05 -0800 (PST)
Received: from sigkill.schiele.dyndns.org ( [91.18.121.55])
        by mx.google.com with ESMTPS id e20sm2003181fga.1.2008.01.24.13.58.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 24 Jan 2008 13:58:04 -0800 (PST)
Received: by sigkill.schiele.dyndns.org (Postfix, from userid 1000)
	id B092C5FE6; Thu, 24 Jan 2008 22:58:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vk5ly9b51.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71666>


--Epi5nlKhkk4Kf+ga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 24, 2008 at 01:17:14PM -0800, Junio C Hamano wrote:
> Robert Schiele <rschiele@gmail.com> writes:
>=20
> > The select stuff is already in sys/time.h on on some systems like HP-UX
> > thus we should not include sys/select.h in that case.
> >
> > Signed-off-by: Robert Schiele <rschiele@gmail.com>
>=20
> The patch looks good.  I'd rather try to be a bit more helpful
> to people who want to port git to their system that is not
> HP-UX, though.
>=20
> How about wording it like this?
>=20
> Subject: pre-POSIX.1-2001 systems do not have <sys/select.h>
>=20
> POSIX.1-2001 has declaration of select(2) in <sys/select.h>, but
> in previous version of SUS, it is declared in <sys/time.h>,
> which is already included in git-compat-util.h.
>=20
> This introduces NO_SYS_SELECT_H macro in the Makefile to be set
> on older systems, to skip inclusion of <sys/select.h> that does
> not exist on them.
>=20
> We could check _POSIX_VERSION with 200112L and do this
> automatically, but earlier it was reported that the approach
> does not work well on some vintage of HP-UX.  Other systems may
> get _POSIX_VERSION itself wrong.  At least for now, this manual
> configuration is safer.

I have no strong opinion on the wording.  Sounds reasonable to me.

Robert

--=20
Robert Schiele
Dipl.-Wirtsch.informatiker	mailto:rschiele@gmail.com

"Quidquid latine dictum sit, altum sonatur."

--Epi5nlKhkk4Kf+ga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQFHmQnrxcDFxyGNGNcRAtORAKDzAd6mi7L5DX75H33/3GC5q6nN6wCfS05c
kcIR4tawD803urAdfPaFVQg=
=aK/b
-----END PGP SIGNATURE-----

--Epi5nlKhkk4Kf+ga--
