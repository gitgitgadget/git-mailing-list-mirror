From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 1/3] Add strbuf_rtrim (to remove trailing spaces).
Date: Sun, 09 Sep 2007 00:53:53 +0200
Message-ID: <20070908225353.GB13385@artemis.corp>
References: <20070902224213.GB431@artemis.corp> <11892523992761-git-send-email-madcoder@debian.org> <1189252399433-git-send-email-madcoder@debian.org> <46E2CB4C.8050209@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="A6N2fC+uXW/VQSAv";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 09 10:48:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIPE-0004Ds-Fb
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:44:36 +0200
Received: from mail-mx3.uio.no ([129.240.10.44])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IU9HM-0003rm-8U
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 00:59:52 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx3.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IU9HE-0002AO-I3
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 00:59:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbXIHWx4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 18:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754759AbXIHWx4
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 18:53:56 -0400
Received: from pan.madism.org ([88.191.52.104]:44978 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754056AbXIHWxz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 18:53:55 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 49B721EAEC;
	Sun,  9 Sep 2007 00:53:54 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 85D861A9; Sun,  9 Sep 2007 00:53:53 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <46E2CB4C.8050209@lsrfire.ath.cx>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.5, required=12.0, autolearn=disabled, AWL=1.529,UIO_VGER=-3)
X-UiO-Scanned: 252A45D02B13A0F13E5E97A35B0CC09B90B7A1AF
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -14 maxlevel 200 minaction 2 bait 0 mail/h: 39 total 517757 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58146>


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On sam, sep 08, 2007 at 04:18:20 +0000, Ren=C3=A9 Scharfe wrote:
> Pierre Habouzit schrieb:
> > diff --git a/strbuf.c b/strbuf.c
> > index acc7fc8..565c343 100644
> > --- a/strbuf.c
> > +++ b/strbuf.c
> > @@ -28,6 +28,13 @@ void strbuf_grow(struct strbuf *sb, size_t extra) {
> >  	ALLOC_GROW(sb->buf, sb->len + extra + 1, sb->alloc);
> >  }
> > =20
> > +void strbuf_rtrim(struct strbuf *sb)
> > +{
> > +    while (sb->len > 0 && isspace((unsigned char)sb->buf[sb->len - 1]))
> > +        sb->len--;
> > +    sb->buf[sb->len] =3D '\0';
> > +}
>=20
> Please use tabs instead of spaces to indent, just like you did in your
> other patches. :)

  yeah, good catch.
  I've added some more patches tonight, and have added another function
in strbufs, and thanks to the awsome git rebase -i, this patch
integrates this new function as well, so this patch series is obsolete
already. I wont repost it until I know if I should rebase it on next
rather than master though.

Cheers,
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG4ygBvGr7W6HudhwRAkVeAKCjVy73msHQ91UodiztsbdVEDjLnwCfTXcD
lVWfpT21zrWayds1wyybAMU=
=0FAc
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
