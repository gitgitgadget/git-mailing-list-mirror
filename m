From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 07/25] parse-options: make some arguments optional, add  callbacks.
Date: Tue, 16 Oct 2007 18:53:19 +0200
Message-ID: <20071016165319.GC13946@artemis.corp>
References: <1192523998-19474-1-git-send-email-madcoder@debian.org> <1192523998-19474-2-git-send-email-madcoder@debian.org> <1192523998-19474-3-git-send-email-madcoder@debian.org> <1192523998-19474-4-git-send-email-madcoder@debian.org> <1192523998-19474-5-git-send-email-madcoder@debian.org> <1192523998-19474-6-git-send-email-madcoder@debian.org> <1192523998-19474-7-git-send-email-madcoder@debian.org> <20071016084510.GI6919@artemis.corp> <4714E90C.80305@lsrfire.ath.cx> <Pine.LNX.4.64.0710161742040.25221@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/Uq4LBwYP4y1W6pO";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 16 18:54:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihpg7-00066p-2V
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 18:53:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933984AbXJPQxX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 12:53:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761029AbXJPQxW
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 12:53:22 -0400
Received: from pan.madism.org ([88.191.52.104]:43339 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760949AbXJPQxV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 12:53:21 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id C10952553D;
	Tue, 16 Oct 2007 18:53:19 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 673D032BAD0; Tue, 16 Oct 2007 18:53:19 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710161742040.25221@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61210>


--/Uq4LBwYP4y1W6pO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 16, 2007 at 04:44:44PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Tue, 16 Oct 2007, Ren? Scharfe wrote:
>=20
> > Pierre Habouzit schrieb:
> > > This bit is to allow to aggregate options with arguments together when
> > > the argument is numeric.
> > >=20
> > >     +#if 0
> > >     +		/* can be used to understand -A1B1 like -A1 -B1 */
> > >     +		if (flag & OPT_SHORT && opt->opt && isdigit(*opt->opt)) {
> > >     +			*(int *)opt->value =3D strtol(opt->opt, (char **)&opt->opt, 1=
0);
> > >     +			return 0;
> > >     +		}
> > >     +#endif
> >=20
> > I don't like it, it complicates number options with unit suffixes (e.g.
> > --windows-memory of git-pack-objects).
>=20
> Why?  It only means that you cannot say -W10mxabc instead of -W10m xabc. =
=20
>=20
> Remember: this is a special case for OPT_INTEGER.  Nothing to do with=20
> OPT_SIZE, which you'd probably implement as a callback.

  Yeah but the point is that you can't migrate an option currently being
an integer to an OPT_SIZE because of that (see my other mail). Meaning
that once an argument is of type OPT_INTEGER you can't change it's type
in the future _AT ALL_ without breaking backward compatibility badly.
I'd say it's a rather sucky design.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--/Uq4LBwYP4y1W6pO
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHFOx/vGr7W6HudhwRAufgAJ42LygbT0I7WG8bSB6nuI4tScpD6QCggseu
f4T4kFmV2ULoHIxYxgxui9c=
=5gmu
-----END PGP SIGNATURE-----

--/Uq4LBwYP4y1W6pO--
