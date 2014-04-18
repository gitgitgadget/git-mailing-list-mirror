From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Refactoring hardcoded SHA-1 constants
Date: Fri, 18 Apr 2014 22:18:42 +0000
Message-ID: <20140418221841.GC57656@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="osDK9TLjxFScVI/L"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 19 00:19:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WbH81-0002uD-QC
	for gcvg-git-2@plane.gmane.org; Sat, 19 Apr 2014 00:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754392AbaDRWSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Apr 2014 18:18:48 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47196 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752798AbaDRWSq (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Apr 2014 18:18:46 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c032:a559:d879:260d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id AC8DB28087
	for <git@vger.kernel.org>; Fri, 18 Apr 2014 22:18:45 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-rc7-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246485>


--osDK9TLjxFScVI/L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

SHA-1 is clearly on its way out.  I know that there has been discussion
in the past about moving to different algorithms.  I'm not interested in
having that discussion now.

I'd like to introduce a set of preprocessor constants that we'd use
instead of hard-coded 20s and 40s everywhere.  That way, if we decide to
support a different algorithm, doing so becomes significantly easier.
These would be used in new code.

After that, I'd like to slowly start moving existing code to use these
constants.

I would also like to consider, as a third step, turning all of the
unsigned char[20] uses into a struct containing unsigned char[20] as its
only member, like libgit2 does.  This disambiguates arbitrary byte data
=66rom byte sequences being used to represent an SHA-1 ID.

I'm hoping the first suggestion will be mostly unobjectionable, as
having hard-coded constants is widely considered bad programming
practice.  I suspect the latter two will be more controversial.  These
changes, if implemented, would be done by hand, not by machine, and they
would be bisectable.

Comments?

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--osDK9TLjxFScVI/L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTUaTBAAoJEL9TXYEfUvaL7YMP/iDysigjaiicSU+ML/cWz0jf
lMBTopGuOfPokr3Mh4MzfSeVaLkWYXb7o2v0DdBrOhH6aDZvsARjEcCmpeg3139n
M9JVPKU2oyziS+FsKp6X2m5DPVY6fAJIq9jC7f+iuG7Z7iNWOjpfkF5U0fAxG6Sx
ObGhO3cbea3I5DW2JFaI/26D1YyQVRPyamSNoac0bbXK04t0EWHLmw/gM7r06mei
Utzf54aHV7/CRfHXqB8jnAIIMSIVKOjMhfWENic77VLBX2AAfkAi7MIK5IEYSUet
uoQ/9RZBH6i4sVFaziAzhHDtODDgrHMEfarOLYRVliiAvFdlGnXho74TJIu4Yd8u
0ut/K7+zYbFH8SXFI02utin3ifkkO8vOlu9r4ZWLzz7vnijxiNgR6neSkKv0Pd/J
Qr8XjgTZgRqZEaAu8vrlPEV6AmuDTXOnN2iUpU03vcB4sJ853M0otCYmK0syvQ51
IsaTLGNGUGT+ZN/gj2bMRs03kraiJg13247dutkZL5F74N1KZheTjTsBlGZ21qDo
KcprRD/bjDjTiXd+XVNvATlcZqytCAm6a7cuhO9CavKgN6m7rEn4alD4FhAbSRlz
dj5IbvqRxBhbtPDCIoJaLMs/hbiXWv7G2ZBHEtqbQH2hjcPQ4IYBfGEWPpugdkcL
fy77k/Ry7iQtvOY3a8hj
=GuTA
-----END PGP SIGNATURE-----

--osDK9TLjxFScVI/L--
