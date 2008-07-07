From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 14/14] Build in merge
Date: Mon, 7 Jul 2008 19:17:21 +0200
Message-ID: <20080707171721.GT4729@genesis.frugalware.org>
References: <0cde1e7c930589364318b2d0344b345453e23586.1214918017.git.vmiklos@frugalware.org> <7vej67jt1e.fsf@gitster.siamese.dyndns.org> <7v4p73gxf6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SAsyYo4aAOH7Cuht"
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 19:18:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFuM4-0007uT-98
	for gcvg-git-2@gmane.org; Mon, 07 Jul 2008 19:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbYGGRR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jul 2008 13:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753493AbYGGRR0
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Jul 2008 13:17:26 -0400
Received: from virgo.iok.hu ([193.202.89.103]:37195 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753491AbYGGRRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jul 2008 13:17:25 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 362301B2535;
	Mon,  7 Jul 2008 19:17:24 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7AE5844668;
	Mon,  7 Jul 2008 18:45:02 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7CC57177001C; Mon,  7 Jul 2008 19:17:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v4p73gxf6.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87632>


--SAsyYo4aAOH7Cuht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 06, 2008 at 02:43:41AM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > Then, you would keep an array of pointers into all_strategy[] array to
> > represent the list of "-s strategy" given by the user:
> >
> > 	static struct strategy *use_strategy;
> > 	static int use_strategy_alloc, use_strategy_nr;
>=20
> Sorry, I have an obvious typo here.  "use_strategy" will be dynamic array
> of pointers into all_strategy[] so its definition would be:
>=20
> 	static struct strategy **use_strategy;

I think there are two possibilities here:

1) Append custom strategies to all_strategy and have only pointers in
use_strategy.

This is what you suggest in your second mail.

2) Copy the names and attributes from all_strategy to use_strategies and
append custom strategies there.

This is what I do at the moment.

I think it's better not to modify all_strategy, it serves as a
reference, for example later this would allow us to check if the used
merge strategy is a predefined or a custom one.

Or is there any strong reason introducing all_strategy_alloc,
all_strategy_nr and using ALLOC_GROW() with all_strategy instead of with
use_strategy?

Thanks.

--SAsyYo4aAOH7Cuht
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhyT6EACgkQe81tAgORUJZSqQCfffyTaN2Z7PenMg42foSIfazb
qKQAni9m1HIwYsmqPkBmv7uSUNKzEmLD
=iuWa
-----END PGP SIGNATURE-----

--SAsyYo4aAOH7Cuht--
