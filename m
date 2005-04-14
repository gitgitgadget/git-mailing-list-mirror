From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [patch] git: fix memory leak #2 in read-cache.c
Date: Thu, 14 Apr 2005 16:25:24 +0200
Message-ID: <1113488724.23299.106.camel@nosferatu.lan>
References: <20050414112638.GA12593@elte.hu>
	 <20050414120834.GA14290@elte.hu> <20050414123258.GA15148@elte.hu>
	 <20050414123934.GA15420@elte.hu>  <20050414132550.GA25496@elte.hu>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-P7IrtwqqpETXeD2Us7su"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 16:20:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM5Au-0003fy-Ox
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 16:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVDNOVw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 10:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVDNOVw
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 10:21:52 -0400
Received: from ctb-mesg1.saix.net ([196.25.240.73]:58076 "EHLO
	ctb-mesg1.saix.net") by vger.kernel.org with ESMTP id S261508AbVDNOVt
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2005 10:21:49 -0400
Received: from gateway.lan (wblv-146-222-135.telkomadsl.co.za [165.146.222.135])
	by ctb-mesg1.saix.net (Postfix) with ESMTP id 2D3D558A8;
	Thu, 14 Apr 2005 16:21:40 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id A2AAF3A26DB;
	Thu, 14 Apr 2005 16:27:44 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 00736-17; Thu, 14 Apr 2005 16:27:38 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id 0106E3A26DA;
	Thu, 14 Apr 2005 16:27:37 +0200 (SAST)
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050414132550.GA25496@elte.hu>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-P7IrtwqqpETXeD2Us7su
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-04-14 at 15:25 +0200, Ingo Molnar wrote:
> * Ingo Molnar <mingo@elte.hu> wrote:
>=20
> > this patch fixes a memory leak in read-cache.c: when there's cache=20
> > entry collision we should free the previous one.
>=20
> > +		free(active_cache[pos]);
> >  		active_cache[pos] =3D ce;
>=20
> i'm having second thoughs about this one: active_cache entries are not=20
> always malloc()-ed - e.g. read_cache() will construct them from the=20
> mmap() of the index file. Which must not be free()d!
>=20
> one safe solution would be to malloc() all these entries and copy them=20
> over from the index file? Slightly slower but safer and free()-able when=20
> update-cache.c notices a collision. The (tested) patch below does this.
>=20
> this would also make Martin Schlemmer's update-cache.c fix safe.
>=20

Ok, bad me it seems - assumed it was malloc'd.


--=20
Martin Schlemmer


--=-P7IrtwqqpETXeD2Us7su
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCXn1UqburzKaJYLYRAuxZAJ9w3FeoEei0K9s41RDfRw3Q7+yPXgCfXY/r
gqaQsgVWoE4onlyQ1p24JT8=
=e1G7
-----END PGP SIGNATURE-----

--=-P7IrtwqqpETXeD2Us7su--

