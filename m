From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] branch: don't assume the merge filter ref exists
Date: Tue, 28 Feb 2012 16:14:50 +0100
Message-ID: <1330442090.691.9.camel@centaur.lab.cmartin.tk>
References: <20120227122609.GA26981@mx.loc>
	 <1330355513-22351-1-git-send-email-cmn@elego.de>
	 <20120227193044.GD1600@sigill.intra.peff.net>
	 <7vk4386pgi.fsf@alter.siamese.dyndns.org>
	 <20120227194305.GE1600@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-wda1ewJkW54UyzoV01/A"
Cc: Junio C Hamano <gitster@pobox.com>,
	Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 28 16:14:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2Ol3-0000Xo-VJ
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 16:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964954Ab2B1POX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 10:14:23 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:38338 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755888Ab2B1POX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 10:14:23 -0500
Received: from [192.168.1.17] (brln-4db9f055.pool.mediaWays.net [77.185.240.85])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 845CD46057;
	Tue, 28 Feb 2012 16:14:16 +0100 (CET)
In-Reply-To: <20120227194305.GE1600@sigill.intra.peff.net>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191737>


--=-wda1ewJkW54UyzoV01/A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2012-02-27 at 14:43 -0500, Jeff King wrote:
> On Mon, Feb 27, 2012 at 11:33:49AM -0800, Junio C Hamano wrote:
>=20
> > Jeff King <peff@peff.net> writes:
> >=20
> > > You would also get NULL if the object exists but is not a commit. May=
be:
> > >
> > >   die("object '%s' does not point to a commit", ...)
> > >
> > > would be better? It covers the wrong-type case, and is still technica=
lly
> > > true when the object does not exist.
> >=20
> > For this particular message I like the above a lot better.  The output
> > from "git grep -e 'invalid object' -e 'bad object'" seems to show that
> > the use of both are fairly evenly distributed.
>=20
> It looks like "bad object" generally comes from parse_object failing,
> which makes sense. It either means object corruption or you fed a full
> 40-char sha1 that didn't exist (which, if you are being that specific,
> probably is an indication of broken-ness in your repository).

Right. Another version of the fix I was playing with used parse_object
after get_sha1 in opt_parse_merge_filter to make sure there that the
objects did exist, so I copied that error message for this patch.

I see Junio's already squashed this in, and it's certainly a better
message.

   cmn


--=-wda1ewJkW54UyzoV01/A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPTO9rAAoJEHKRP1jG7ZzTLTYH/18tN2X6b+QuavEGVfNXxJvz
5POre/opmgpaMkCKEnfROHU6Dpj69yD3jzy8Rv/n60bIEvSuLTckLJsFC6/7rgMh
UvN63iqrADjPP/xH1MiG/3TOagZADrdscZD9e4c5E3+f5ge8rrsvmt4xEcdVn5yl
Tvi3YmSEa4mXCPuk1oWxyq/FNQHVZtRt6YZFTSYY2+VHscUBxHOSX5U8iKrFy+5a
nMwsye1oL0aifPK0R3JNociOwYdXk6nM58dDg/DHubdBlK7opMH8UAP1I6mwh9as
CwubE+xTLbz+GX3XLaxES33VgFotjtsxDz+2mO1J+DxMuFoD1z+Pjz3KKc7p+bw=
=ev0/
-----END PGP SIGNATURE-----

--=-wda1ewJkW54UyzoV01/A--
