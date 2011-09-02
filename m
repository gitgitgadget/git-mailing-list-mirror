From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] for-each-ref: add split message parts to %(contents:*).
Date: Fri, 2 Sep 2011 13:53:23 -0400
Message-ID: <20110902175323.GA29761@sigill.intra.peff.net>
References: <20110901184815.2cd8b472@pomiocik.lan>
 <1314895801-21147-1-git-send-email-mgorny@gentoo.org>
 <20110902163903.GA21768@sigill.intra.peff.net>
 <20110902193931.42593338@pomiocik.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>
X-From: git-owner@vger.kernel.org Fri Sep 02 19:53:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzXvq-0003kz-E7
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 19:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753975Ab1IBRx0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Sep 2011 13:53:26 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49631
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753588Ab1IBRx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Sep 2011 13:53:26 -0400
Received: (qmail 1269 invoked by uid 107); 2 Sep 2011 17:54:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 02 Sep 2011 13:54:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Sep 2011 13:53:23 -0400
Content-Disposition: inline
In-Reply-To: <20110902193931.42593338@pomiocik.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180625>

On Fri, Sep 02, 2011 at 07:39:26PM +0200, Micha=C5=82 G=C3=B3rny wrote:

> > > +	/* When having a signed tag without body, format_subject()
> > > +	 * will start to eat the signature. */
> > > +	if (buf > *signature)
> > > +		*body =3D *signature;
> > > +	else /* - 1 to get a trailing newline to strip */
> > > +		*body =3D buf - 1;
> >=20
> > This last line is wrong if there is no trailing newline, no? Runnin=
g
> > even the existing tests in t6300 against your new patch, I get:
> [...]
>=20
> Any suggestion how to strip trailing newlines?

Just looking at your patch, it might work to do:

  else if (*buf =3D=3D '\n')
          *body =3D buf - 1;
  else
          *body =3D buf;

But there may be other corner cases.  I need to read through the code
more carefully, which I should have time to do later today.

-Peff
