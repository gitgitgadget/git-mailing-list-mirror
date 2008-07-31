From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git blame not respecting --find-copies-harder ?
Date: Thu, 31 Jul 2008 11:06:46 +0200
Message-ID: <20080731090646.GB12867@artemis.madism.org>
References: <20080730093903.GA14330@cuci.nl> <20080730150123.GB9758@atjola.homenet> <bd6139dc0807300843l1d42d6fep95f6c99fe6e0ea0@mail.gmail.com> <20080731064814.GA32431@sigill.intra.peff.net> <7vfxpq3559.fsf@gitster.siamese.dyndns.org> <20080731072149.GA2304@sigill.intra.peff.net> <7v8wvi33ok.fsf@gitster.siamese.dyndns.org> <20080731082553.GA19522@sigill.intra.peff.net> <7v8wvizc16.fsf@gitster.siamese.dyndns.org> <20080731090146.GA12867@artemis.madism.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="2B/JsCI69OhZNC5r";
	protocol="application/pgp-signature"; micalg=SHA1
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	sverre@rabbelier.nl,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Gi
X-From: git-owner@vger.kernel.org Thu Jul 31 11:07:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOU8V-0001El-M3
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 11:07:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752662AbYGaJGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 05:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752632AbYGaJGt
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 05:06:49 -0400
Received: from pan.madism.org ([88.191.52.104]:49097 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752644AbYGaJGs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 05:06:48 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 5427C3C604;
	Thu, 31 Jul 2008 11:06:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 667923B6A; Thu, 31 Jul 2008 11:06:46 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	sverre@rabbelier.nl,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	"Stephen R. van den Berg" <srb@cuci.nl>,
	Git Mailinglist <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080731090146.GA12867@artemis.madism.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90916>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2008 at 09:01:46AM +0000, Pierre Habouzit wrote:
> On Thu, Jul 31, 2008 at 08:35:33AM +0000, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> >=20
> > > On Thu, Jul 31, 2008 at 12:36:59AM -0700, Junio C Hamano wrote:
> > >
> > >> Alas, shortlog does not take --all.  Yes, I know
> > >>=20
> > >> 	git log --since=3D3.day --all | git shortlog | sort | uniq -c
> > >>=20
> > >> is an obvious workaround, but it is mildly irritating.
> > >
> > > Hmm. Could it be as simple as:
> > >
> > > diff --git a/revision.c b/revision.c
> > > index a843c42..eaa5572 100644
> > > --- a/revision.c
> > > +++ b/revision.c
> > > @@ -1002,7 +1002,7 @@ static int handle_revision_opt(struct rev_info =
*revs, int argc, const char **arg
> > >  	    !strcmp(arg, "--no-walk") || !strcmp(arg, "--do-walk"))
> > >  	{
> > >  		unkv[(*unkc)++] =3D arg;
> > > -		return 0;
> > > +		return 1;
> > >  	}
> > > =20
> > >  	if (!prefixcmp(arg, "--max-count=3D")) {
> > >
> > > That is, handle_revision_opt says "yes we parsed this, and it should =
be
> > > gone" even though it still gets stuck in the "unknown" section to be
> > > parsed by setup_revisions later.
>=20
>   Ack this is a correct fix. I wonder how this even works with other
> commands that use --all and stuff like that.

Oh actually I know: the parse_revision_opt machinery (that is buggy
because of this 0 result) is used in git-blame where --all is
meaningless anyways, and ... git-shortlog only. The legacy way to parse
revision options does not treats `0' answers differently from `1'
actually, I wonder why, because this is probably wrong.

This was a regression, I suppose prior to its parse-optification
git-shortlog accepted --all (and I see no valid reason for it not to).

Thanks a lot to Jeff for the good catch.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiRgKYACgkQvGr7W6HudhyQewCeJYpfEJhF2GYUP6lywFmLrVDi
5DAAoJcD5RQsW5PlL5/A0H+qk9nuBjnZ
=l22O
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
