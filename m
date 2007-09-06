From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/7] Simplify strbuf uses in archive-tar.c using the   proper functions.
Date: Thu, 06 Sep 2007 20:27:46 +0200
Message-ID: <20070906182746.GK8451@artemis.corp>
References: <20070902224213.GB431@artemis.corp> <11890776114037-git-send-email-madcoder@debian.org> <118907761140-git-send-email-madcoder@debian.org> <11890776111843-git-send-email-madcoder@debian.org> <1189101569.3423.17.camel@hinata.boston.redhat.com> <20070906180858.GJ8451@artemis.corp> <1189102714.3423.22.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="sdEQJo40s7ofW8iR";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 20:28:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITM55-000893-G7
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 20:27:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756253AbXIFS1u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 14:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756246AbXIFS1u
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 14:27:50 -0400
Received: from pan.madism.org ([88.191.52.104]:49323 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756051AbXIFS1t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Sep 2007 14:27:49 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id BE2E91DE35;
	Thu,  6 Sep 2007 20:27:47 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E04EF1A3D2; Thu,  6 Sep 2007 20:27:46 +0200 (CEST)
Mail-Followup-To: Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1189102714.3423.22.camel@hinata.boston.redhat.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57924>


--sdEQJo40s7ofW8iR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 06, 2007 at 06:18:34PM +0000, Kristian H=C3=B8gsberg wrote:
> On Thu, 2007-09-06 at 20:08 +0200, Pierre Habouzit wrote:
> > On Thu, Sep 06, 2007 at 05:59:29PM +0000, Kristian H=C3=B8gsberg wrote:
> > > On Thu, 2007-09-06 at 13:20 +0200, Pierre Habouzit wrote:
> > > > -	memcpy(path.buf, base, baselen);
> > > > -	memcpy(path.buf + baselen, filename, filenamelen);
> > > > -	path.len =3D baselen + filenamelen;
> > > > -	path.buf[path.len] =3D '\0';
> > > > +	strbuf_grow(&path, MAX(PATH_MAX, baselen + filenamelen + 1));
> > > > +	strbuf_reset(&path);
> > >=20
> > > Does strbuf_reset() do anything here?
> > >=20
> > > > +	strbuf_add(&path, base, baselen);
> >=20
> >   Yes _reset() sets length to 0. so the add here will write at the start
> > of the buffer again. It definitely is important !
>=20
> But where was length set to non-zero?  path is initialized on entry to
> the function, and strbuf_grow() just increases the allocation, not
> length, right?

  The path is static, hence when you reenter the function you have the
last value in it. The fact that it's static may be questionable, but it
was like it before, I kept it, I've supposed it was for performance
reasons.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--sdEQJo40s7ofW8iR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4EaivGr7W6HudhwRAjgnAJ93gIbVOKKbk2zTpA7T5RfJRKzANQCfaFsU
Z7eLqx04ud0vu5H5N4dtW44=
=oGhU
-----END PGP SIGNATURE-----

--sdEQJo40s7ofW8iR--
