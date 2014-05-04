From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [RFC PATCH 0/9] Use a structure for object IDs.
Date: Sun, 4 May 2014 17:54:59 +0000
Message-ID: <20140504175459.GO75770@vauxhall.crustytoothpaste.net>
References: <1399147942-165308-1-git-send-email-sandals@crustytoothpaste.net>
 <5365DF94.9060707@alum.mit.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eHmdSDY+kY2au76U"
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sun May 04 19:55:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh0d8-0000TC-MV
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 19:55:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753761AbaEDRzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 13:55:07 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47545 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753450AbaEDRzG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2014 13:55:06 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:285a:6bfa:4cc0:fb21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AB6EB28087;
	Sun,  4 May 2014 17:55:05 +0000 (UTC)
Mail-Followup-To: Michael Haggerty <mhagger@alum.mit.edu>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <5365DF94.9060707@alum.mit.edu>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248103>


--eHmdSDY+kY2au76U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 04, 2014 at 08:35:00AM +0200, Michael Haggerty wrote:
> On 05/03/2014 10:12 PM, brian m. carlson wrote:
> > I called the structure member "oid" because it was easily grepable and
> > distinct from the rest of the codebase.  It, too, can be changed if we
> > decide on a better name.  I specifically did not choose "sha1" since it
> > looks weird to have "sha1->sha1" and I didn't want to rename lots of
> > variables.
>=20
> That means that we will have sha1->oid all over the place, right?
> That's unfortunate, because it is exactly backwards from what we would
> want in a hypothetical future where OIDs are not necessarily SHA-1s.  In
> that future we would certainly have to support SHA-1s in parallel with
> the new hash.  So (in that hypothetical future) we will probably want
> these expressions to look like oid->sha1, to allow, say, a second struct
> or union field oid->sha256 [1].

As Johannes pointed out, only during the transition period.

> If that future would come to pass, then we would also want to have
> distinct constants like GIT_SHA1_RAWSZ and GIT_SHA256_RAWSZ rather than
> the generically-named GIT_OID_RAWSZ.

You have a point.  I'll make the change.

> I think that this patch series will improve the code clarity and type
> safety independent of thoughts about supporting different hash
> algorithms, so I'm not objecting to your naming decision.  But *if* such
> support is part of your long-term hope, then you might ease the future
> transition by choosing different names now.

It is an eventual goal, but without this series, it's not even worth
discussing since it's too hard to implement.  Even if that doesn't
happen, my hope is that we'll at least improve the safety of the code
and hopefully avoid a bug or two out of it.

> (Maybe renaming local variables "sha1 -> oid" might be a handy way of
> making clear which code has been converted to the new style.)

This is a good idea as well.  I'll walk through the patches and fix
that.

> Just to be clear, the above are just some random thoughts for your
> consideration, but feel free to disregard them.

I appreciate the well-thought-out response.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--eHmdSDY+kY2au76U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTZn7yAAoJEL9TXYEfUvaLudsQAJjsg0NuC0onfWp4yXzlpx0N
ijOsASb7vghbYEpTQnD7m4941XNphAyrLaWSSQZS7EaZ8+Fu8HJjSJY9XkIxjEvU
7iMWmonVRvONC3fXG2j7PqfXYu6ntcYP8udIrZqvFTn7SszFCMiL9Bk5XbIzKOyj
A9ZZDYRCobG2GIHF70U3qkmgh4WLZyJfyGf7IUL/iTh80WQ7/U70S6qaML6yyORH
JwDrlhNHUZvdeK0aF6FdurXfjvaHxS5/Ma0EF8Wqwt0F0gZICcBseMxmY9PMFKOc
9MtrLrBQjz+XFWweZ00meXtuJrStMZ4bJZg5liaBngOBwejIHi9JK8xGWZITxpdr
qnp6a+DZK+GHhlz5ZPWhpniCAE3agg6qGiG72xtZdYTWmsgDz5HA5R2BfRpPzRR+
IWchchJ4UJSsJUdhzl/WqCmB+b3NGieMVpkEv1EsbkPXDU2fnaNenrPvwTUdI+1S
vkhdGQwppzj+UfX8Nr1cLKLAr7onDbkzJc+Ul5DKC/OYX6FY7PVi+J0coe6LqLgn
a2hWA1rx6IGhYn2FmIEwZnVS9nOMTwjQ79oqXPl/BOMxsiXc1srsMSZZegjQiBUp
jpAJQKm/UwQPafAZxMBpAs2P74wWYNKgDg+eMEltawEeLExChWvTBfHCa/1aVlHT
5ML706zDpLLIFH3qYgF7
=5B/+
-----END PGP SIGNATURE-----

--eHmdSDY+kY2au76U--
