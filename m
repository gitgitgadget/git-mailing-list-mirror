From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] gc: use parse_options
Date: Fri, 02 Nov 2007 09:32:47 +0100
Message-ID: <20071102083247.GB20200@artemis.corp>
References: <20071102002856.GB3282@crux.yyz.redhat.com> <7vhck579pm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="yLVHuoLXiP9kZBkt";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 02 09:33:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Inrxh-0007lL-U9
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 09:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752204AbXKBIcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 04:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbXKBIcv
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 04:32:51 -0400
Received: from pan.madism.org ([88.191.52.104]:45423 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751276AbXKBIcu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 04:32:50 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 3A09627656;
	Fri,  2 Nov 2007 09:32:48 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3F3A9346037; Fri,  2 Nov 2007 09:32:47 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vhck579pm.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63073>


--yLVHuoLXiP9kZBkt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 02, 2007 at 12:49:25AM +0000, Junio C Hamano wrote:
> James Bowes <jbowes@dangerouslyinc.com> writes:
>=20
> > +	struct option builtin_gc_options[] =3D {
> > +		OPT_BOOLEAN(0, "prune", &prune, "prune unused objects"),
>=20
> I would write "unreferenced loose" instead of "unused" here...
>=20
> > +		OPT_BOOLEAN(0, "aggressive", &aggressive, "be more thorough (increas=
ed runtime)"),
> > +		OPT_BOOLEAN(0, "auto", &auto_gc, "enable auto-gc mode"),
> > +		OPT_END()
> > +	};
> > +
> >  	git_config(gc_config);
> > =20
> >  	if (pack_refs < 0)
> >  		pack_refs =3D !is_bare_repository();
> > =20
> > +	parse_options(argc, argv, builtin_gc_options, builtin_gc_usage, 0);
> > +
> > +	if (aggressive) {
> > +		append_option(argv_repack, "-f", MAX_ADD);
> > +		if (aggressive_window > 0) {
> > +			sprintf(buf, "--window=3D%d", aggressive_window);
> > +			append_option(argv_repack, buf, MAX_ADD);
> >  		}
> >  	}
> > -	if (i !=3D argc)
> > -		usage(builtin_gc_usage);
>=20
> Now, what makes the command report error when the user says:
>=20
> 	$ git gc unwanted parameter

the commands works fine, because no additionnal checks were made. To
"fix" this, that should be done:

argc =3D parse_options(argc, argv, builtin_gc_options, builtin_gc_usage, 0);
if (argc)
    usage_with_options(......);

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--yLVHuoLXiP9kZBkt
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHKuCvvGr7W6HudhwRAvjkAJ0VCm735lDOerW4xsXCiZrMuEpQnwCglKyz
HstmB+kpBIBpvvha1uQofrA=
=tNJ9
-----END PGP SIGNATURE-----

--yLVHuoLXiP9kZBkt--
