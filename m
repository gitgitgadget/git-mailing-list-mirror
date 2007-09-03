From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: strbuf API
Date: Mon, 03 Sep 2007 10:49:27 +0200
Message-ID: <20070903084927.GB21759@artemis.corp>
References: <20070902224213.GB431@artemis.corp> <vpqk5r8m9nz.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="eJnRUKwClWJh1Khz";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Mon Sep 03 10:49:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IS7cj-0006bZ-Is
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 10:49:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051AbXICIt3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 04:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbXICIt3
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 04:49:29 -0400
Received: from pan.madism.org ([88.191.52.104]:38478 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751363AbXICIt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 04:49:28 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id D342A1DA28;
	Mon,  3 Sep 2007 10:49:27 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 6DDEB2EB2; Mon,  3 Sep 2007 10:49:27 +0200 (CEST)
Mail-Followup-To: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <vpqk5r8m9nz.fsf@bauges.imag.fr>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57453>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 03, 2007 at 08:32:16AM +0000, Matthieu Moy wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> >   First, and that's the most important one: the buffer is always NUL
> > terminated, after its official "len". That means, in terms of strbuf
> > API, that "alloc" is always greater or equal to len+1 to be able to
> > store the ending NUL[1]. The advantages are obvious: you can pass the
> > buffer to any legacy C string function without any fear of read
> > overflow.
>=20
> No overflow, but it's still potentially dangerous: if your strbuf
> contains a '\0', you can't use any standard C string function.
>=20
> For example, it would be very tempting to compare files with
> "strcmp(buf1, buf2)", but that would just fail silently when the file
> contains a '\0' byte.

  Indeed, OTHO doing that would be pretty silly, as embending NULs in a
strbuf is wrong, it's a _str_buf, not a random-binary-buffer. It's meant
to make the use of strings easier, not to use as generic purpose byte
buffers. Of course they can, but well, it's not what they are designed
for in the first place.

  Also note that it generates bugs, but never crashes if you still do
that, bugs suck, but security bugs, buffer overflows, ... suck more.

  So I'm tempted to say, it's not really a problem.

> >   The other shortcoming is that you cannot tell the buffer "Hey, it's
> > very likely that you'll end up being _that_ long.
>
> 100% ACK on this point.

  Also note that it seems that bstring lack this, but maybe I'm wrong.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG28qXvGr7W6HudhwRAtxGAJ9mK7thCuaqNe9stgUcaOTNLu36GwCghKSn
3xdr7AQEvxC7+qb6stPeHJM=
=RF2s
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
