From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v4 4/4] Hack fix for 'submodule update does not fetch
 already present commits'
Date: Tue, 27 Nov 2012 16:18:51 -0500
Message-ID: <20121127211851.GE15213@odin.tremily.us>
References: <30459164cc221165a20cd4a54daac76ddb101269.1353962698.git.wking@tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=cPi+lWm09sJ+d57q
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>, Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 27 22:19:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdSYx-0008Mw-KY
	for gcvg-git-2@plane.gmane.org; Tue, 27 Nov 2012 22:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756642Ab2K0VTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2012 16:19:07 -0500
Received: from vms173011pub.verizon.net ([206.46.173.11]:46833 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153Ab2K0VTD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2012 16:19:03 -0500
Received: from odin.tremily.us ([unknown] [72.76.144.216])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0ME600LH40JFVC60@vms173011.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 27 Nov 2012 15:18:53 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 5160E6E0DC2; Tue,
 27 Nov 2012 16:18:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1354051131; bh=p2WiObIW2jAmD8DtgPohzUhCYsNpf3YlPMTatBLKAQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=FYLEQuY3Ps3XqHpN3UH+mP8Sr8WW+BFE/VDqEiMAusykpAaBgWQyqXSdmGqL0dzXj
 WteKthViqbAcECmdHYEfEfLopRVf4Vu2uv+houV5LBDaoPCTmfhV5zklQcSmniykNb
 wNKyihJ2uQFrmpBRB3ak043FDR5Rrer+yzazkfLc=
Content-disposition: inline
In-reply-to: <30459164cc221165a20cd4a54daac76ddb101269.1353962698.git.wking@tremily.us>
 <20121127190105.GQ10656@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210598>


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 27, 2012 at 02:01:05PM -0500, W. Trevor King wrote:
> On Tue, Nov 27, 2012 at 07:31:25PM +0100, Heiko Voigt wrote:
> > On Mon, Nov 26, 2012 at 04:00:15PM -0500, W. Trevor King wrote:
> > > Because you need to recurse through submodules for `update --branch`
> > > even if "$subsha1" =3D=3D "$sha1", I had to amend the conditional
> > > controlling that block.  This broke one of the existing tests, which I
> > > "fixed" in patch 4.  I think a proper fix would involve rewriting
> > >=20
> > >   (clear_local_git_env; cd "$sm_path" &&
> > >    ( (rev=3D$(git rev-list -n 1 $sha1 --not --all 2>/dev/null) &&
> > >     test -z "$rev") || git-fetch)) ||
> > >   die "$(eval_gettext "Unable to fetch in submodule path '\$sm_path'"=
)"
> > >=20
> > > but I'm not familiar enough with rev-list to want to dig into that
> > > yet.  If feedback for the earlier three patches is positive, I'll work
> > > up a clean fix and resubmit.
> >=20
> > You probably need to separate your handling here. The comparison of the
> > currently checked out sha1 and the recorded sha1 is an optimization
> > which skips unnecessary fetching in case the submodules commits are
> > already correct. This code snippet checks whether the to be checked out
> > sha1 is already local and also skips the fetch if it is. We should not
> > break that.
>=20
> Agreed.  However, determining if the target $sha1 is local should have
> nothing to do with the current checked out $subsha1.

Erm, I clearly wasn't getting enough sleep heading into yesterday,
because when I drop the hack patch #4, reinstall, and retest, I no
longer get the bad-fetch error.  I'm not quite sure what was going on,
but please pretend I never mentioned it ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQtS44AAoJEEUbTsx0l5OMEm0P+gPBW85ES3/9XI9ll0icsLxm
lLVRU3keoeWKnG19uKg0ufWxAqSg05jYCPxbbPfGC1GkEra4ZHCqrlwQWJd8g9sE
HUTMhr+qfld7fGr/QIbgsTcMCU9hVJn8sbZu1f6mVEg1xoCEc1CSwQ7tFwJ3l4UA
7MJU61rSBH5mSTsTQehttJ0mwRqj1SMK6OycFcTUf6j8DeNbQFbTfOHvvvKZSjaz
+6nYbEQcSUq/JkrwzmrX1ls21b2oVDppS0nIMQ0d1hpORwTj8A3ZRYxxIoy4ACKX
C0GGQWN0ZOtgfqpCv38CGkGMOB9c7FByUJrAXZhlICULahhAWP+KmBDDHceRSaBd
/h7a8X6CK1vDB2PD+UtLSZ8dlGk3FxnExpafuB9/JcH30dzGS3hNEKD8bn2VZT58
iDz/4iLQHyHB+4RZMKV8EM1Ojf6lpBAti8s98X8PuIsRWSkbbJAF9/xCjwzCfCyL
4vyZH4B4fmjLceP+5aZoWc0UUxVYAZanrVd7wz636JogeyM+2Zs8QUYGr1NDd+/u
CSb1wWBwOEtTYT0vKUsRfOx2TZXlNJYhfH2dgd1+7svKNpzoT2fns4+6R7LitLNd
DwgyCpE4vdPaVkqrhsjzbECu1gItS1+FRgRzSLHJRYcO16+ZTjAIbUb0yNTN+AXN
ruwCPgwMThLreCqH/DL8
=7iNp
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
