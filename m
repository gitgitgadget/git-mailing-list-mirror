From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] Port builtin-add.c to use the new option parser.
Date: Sat, 13 Oct 2007 17:03:06 +0200
Message-ID: <20071013150306.GH7110@artemis.corp>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <1192282153-26684-2-git-send-email-madcoder@debian.org> <1192282153-26684-3-git-send-email-madcoder@debian.org> <Pine.LNX.4.64.0710131544030.25221@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Uu2n37VG4rOBDVuR";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Oct 13 17:03:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgiWS-0004ci-KI
	for gcvg-git-2@gmane.org; Sat, 13 Oct 2007 17:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbXJMPDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Oct 2007 11:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754874AbXJMPDJ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Oct 2007 11:03:09 -0400
Received: from pan.madism.org ([88.191.52.104]:57287 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754671AbXJMPDI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Oct 2007 11:03:08 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 1DBB1951;
	Sat, 13 Oct 2007 17:03:07 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id B046939E081; Sat, 13 Oct 2007 17:03:06 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710131544030.25221@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--Uu2n37VG4rOBDVuR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2007 at 02:47:20PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Sat, 13 Oct 2007, Pierre Habouzit wrote:
>=20
> > +static struct option builtin_add_options[] =3D {
> > +	OPT_BOOLEAN('i', "interactive", &add_interactive, "interactive pickin=
g"),
> > +	OPT_BOOLEAN('n', NULL, &show_only, "dry-run"),
> > +	OPT_BOOLEAN('f', NULL, &ignored_too, "allow adding otherwise ignored =
files"),
> > +	OPT_BOOLEAN('v', NULL, &verbose, "be verbose"),
> > +	OPT_BOOLEAN('u', NULL, &take_worktree_changes, "update only files tha=
t git already knows about"),
> > +	OPT_BOOLEAN( 0 , "refresh", &refresh_only, "don't add, only refresh s=
tat() informations in the index"),
> > +};
>=20
> I see you terminate the list by a ",".  How does this play with the optio=
n=20
> parser?
>=20
> Thinking about this more, I am reverting my stance on the ARRAY_SIZE()=20
> issue.  I think if you introduce a "OPTION_NONE =3D 0" in the enum, then=
=20
> this single last comma should be enough.

  adding a trailing comma does not add a NULL after that, it's ignored,
you're confused.

    =E2=94=8C=E2=94=80(17:00)=E2=94=80=E2=94=80=E2=94=80=E2=94=80
    =E2=94=94[artemis] cat a.c
    #include <stdio.h>

      int main(void) {
	const char * const arr[] =3D { "1", "2", };
	printf("%d\n", sizeof(arr) / sizeof(arr[0]));
	return 0;
    };
    =E2=94=8C=E2=94=80(17:00)=E2=94=80=E2=94=80=E2=94=80=E2=94=80
    =E2=94=94[artemis] ./a
    2

  Very few compilers do not grok trailing commas, I always put them
because it avoids spurious diffs for nothing, and that you can reorder
lines easily too.

  Note that I don't really like using ARRAY_SIZE either, I kept it that
way, but my taste would rather be to have an "empty" option, and
explicitely mark the end of the array.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Uu2n37VG4rOBDVuR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHEN4qvGr7W6HudhwRAsVHAJ0cZ+OVErJ7Zk7GMnGj8qN1UtzDjgCfZ0NJ
xT8OaO6Xp5A7E8iEsb0oUXQ=
=pbSD
-----END PGP SIGNATURE-----

--Uu2n37VG4rOBDVuR--
