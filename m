From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH v4 2/3] gitweb: refactor If-Modified-Since handling
Date: Mon, 26 Mar 2012 13:36:46 -0400
Message-ID: <20120326173646.GA6524@odin.tremily.us>
References: <7v8vinqoaj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=LQksG6bCIzRHxTLp
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 19:37:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCDr1-0000cd-Js
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 19:37:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933131Ab2CZRhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 13:37:07 -0400
Received: from vms173005pub.verizon.net ([206.46.173.5]:38234 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933122Ab2CZRhG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 13:37:06 -0400
Received: from odin.tremily.us ([unknown] [72.68.85.198])
 by vms173005.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1I00LI169B5I50@vms173005.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 26 Mar 2012 12:37:04 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 23A9B42E465; Mon,
 26 Mar 2012 13:36:46 -0400 (EDT)
Content-disposition: inline
In-reply-to: <7v8vinqoaj.fsf@alter.siamese.dyndns.org>
 <m37gyf4hc3.fsf@localhost.localdomain>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193938>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 26, 2012 at 10:12:36AM -0700, Junio C Hamano wrote:
> It might make more sense to call the helper *after* stuffing %latest_date
> and pass the $latest_date{'rfc2822'} as parameter to the new helper
> function, so that the helper function do not have to call parse_date().

I did something closer to your suggestion in my v1 patch, but

On Tue, Mar 20, 2012 at 04:55:45AM -0700, Jakub Narebski wrote:
> Shouldn't we pass \%latest_date (or rather \%modification_date to be
> more generic)?  Ah, I see that parse_date() subroutine does not store
> original epoch not original timezone.
>=20
> By the way, for $latest_date{'rfc2822'} we don't need $timezone
> argument, and I think we should not pass it to generic
> modified_since() function (or whatever it will be called).
>=20
> =E2=80=A6
>=20
> I think a better idea would be to make this function/subroutine (named
> e.g. if_modified_since() or something like that) to work more like
> die_error() -- it should simply end request instead of having caller
> to use complcated calling convention, and care about eraly termination
> by itself.

Only passing in the epoch.  We could reduce computation at the expense
of complication by passing in both the epoch and a formatted time
string, but after Jakub's suggestions, I felt like a simpler interface
was the better approach.  I don't feel particularly committed to
either way, so just tell me which you'd like best ;).

> The verb "die" everywhere else in the codebase of Git not just means an
> immediate exit, but means an imediate _error_ exit.  The new helper
> function is not about failure, but merely is an early return.  Perhaps
> rename it to exit_if_unmodified_since() or something?

Will fix in v5.

> Missing " &&" at the end (same in 3/3).

Oops.  I wonder why my tests still passed :p.  Will fix in v5.

> Other than that, the patch looks cleanly done.
>=20
> Thanks.

You're welcome.  Thanks for shepherding me through it ;).

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPcKktAAoJEPe7CdOcrcTZblwH/R7n9FMr+iZ0nhIrh3ZAATfs
0PIeC1BcSxRQP7ln9cPuMCO7RKUxsVAo2KI9fzfQEZbZgN/Bq61JZtvK02yVzQIJ
qqL0I5x/E7V34584n3YlKZGM5B+DhJazQ3SMB4TCnCR2HAJ9vuEjmy6PHN7f5KhT
cTWP3L4obUlBIEyG05483ahBxo1MjOHllxpZRctl85WiEe1HTfGVPdiMCBupLwL0
JpM/UrGBQqTaC3saahv1yIrwyM9ME3uw4K4PB2OVkAH0zA9ZZfmm/Rx8wN4qoi44
mOO+83oeQowrk3ehOP9Cy/pD8rzIJHMktrH13iUSzE7Hf5ezhd+p8c6ITGcQGWU=
=IlNW
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
