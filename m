From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 4/4] Implement git commit and status as a builtin commands.
Date: Tue, 06 Nov 2007 10:26:48 +0100
Message-ID: <20071106092648.GG4435@artemis.corp>
References: <1194017589-4669-1-git-send-email-krh@redhat.com> <1194017589-4669-2-git-send-email-krh@redhat.com> <1194017589-4669-3-git-send-email-krh@redhat.com> <1194017589-4669-4-git-send-email-krh@redhat.com> <20071103150637.GA11172@atjola.homenet> <1194289073.13968.16.camel@hinata.boston.redhat.com> <20071105192347.GA29997@atjola.homenet> <Pine.LNX.4.64.0711052317170.4362@racer.site> <20071106091222.GE4435@artemis.corp> <4730314A.9010403@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="f5QefDQHtn8hx44O";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 06 10:27:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpKiA-0000d8-N1
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 10:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbXKFJ0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 04:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752201AbXKFJ0v
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 04:26:51 -0500
Received: from pan.madism.org ([88.191.52.104]:50960 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751991AbXKFJ0u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 04:26:50 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 5857928B17;
	Tue,  6 Nov 2007 10:26:49 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id BB3DB383A; Tue,  6 Nov 2007 10:26:48 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4730314A.9010403@viscovery.net>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63650>


--f5QefDQHtn8hx44O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 06, 2007 at 09:18:02AM +0000, Johannes Sixt wrote:
> Pierre Habouzit schrieb:
> >Btw, I'm starting to work slowly on the diff_opt_parse conversion to the
> >macro we discussed, and the need for new option parsing callbacks
> >arised, and I've created a:
> >  parse_opt_mask_{or,and,xor} commands that you declare this way:
> >    OPT_MASK_OR('a', "all",         &mode, "...", MASK_ALL),
> >    OPT_MASK_OR('i', "interactive", &mode, "...", MASK_INTERACTIVE),
> >    ...
> >And if you chose MASK_ALL/INTERACTIVE/.. to be single bits,
> >    if (!!all + !!interactive ... > 1)
> >becomes[0]:
> >    if (mode & (mode - 1)) {
> >    }
>=20
> This goes too far, IMHO. That's unnecessary cleverness/microoptimization=
=20
> at the expense of readability.

The reason why I did that is not to be able to do mode & (mode - 1).
Have a look at diff.c, imagine the insane amount of intermediate
variables we would need, and now understand why I introduced that :)

I'm not sure it's useful for git-commit, I was mentioning it just in case.

Note: the fact that an OPT_BOOLEAN when you repeat it increments the
      value isn't always a good thing, and is the reason why you need
      the (quite ugly) double bangs.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--f5QefDQHtn8hx44O
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHMDNYvGr7W6HudhwRApEHAJ4uM2jzd21mKo+1pJLIH+qkdToHxwCfUrwc
huvF1l6y1RFV6gzhL6vLXiI=
=ZKYu
-----END PGP SIGNATURE-----

--f5QefDQHtn8hx44O--
