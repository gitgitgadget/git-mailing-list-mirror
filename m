From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] Introduce get_octopus_merge_bases() in commit.c
Date: Tue, 10 Jun 2008 01:35:09 +0200
Message-ID: <20080609233509.GW29404@genesis.frugalware.org>
References: <alpine.DEB.1.00.0806091458190.1783@racer> <1213051426-11530-1-git-send-email-vmiklos@frugalware.org> <7vd4mqfcb0.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806100006140.1783@racer> <7vy75edwlx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZkFfH+RuFRkNoGBj"
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:36:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5quE-0005ww-Ou
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 01:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760095AbYFIXfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 19:35:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759948AbYFIXfM
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 19:35:12 -0400
Received: from virgo.iok.hu ([193.202.89.103]:57556 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758289AbYFIXfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 19:35:10 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5F6411B2591;
	Tue, 10 Jun 2008 01:35:09 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 5C6D744668;
	Tue, 10 Jun 2008 01:16:49 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 49ECE1770022; Tue, 10 Jun 2008 01:35:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vy75edwlx.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84454>


--ZkFfH+RuFRkNoGBj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 09, 2008 at 04:20:10PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > 	struct commit_list list =3D { two, NULL };
> >
> > 	merge_bases_many(one, &list);
>=20
> But (1) that is not what f755fb6 does; it does commit_list_insert() that
> has an allocation, and (2) how much work is to count, allocate and pass
> array for slow and less frequent codepath which octopus-merge-base is?

If (1) is the only problem, I can do it the way Dscho suggested, but I
don't exactly see why using a commit_list* can slow merge_bases() down:

for (i =3D 0; i < n; i++) {
        ...
}

is probably as fast as

for (i =3D list; i; i =3D i->next) {
        ...
}

in case n =3D 0 / list->next is NULL.

--ZkFfH+RuFRkNoGBj
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhNvi0ACgkQe81tAgORUJaY/gCfSKlCn0JhRqVy/7jnayolsKYx
CTsAoKILENqF7yvpHIh5KrZ2P7o8Q1PQ
=lSr/
-----END PGP SIGNATURE-----

--ZkFfH+RuFRkNoGBj--
