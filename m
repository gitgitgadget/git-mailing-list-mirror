From: Eric Blake <eblake@redhat.com>
Subject: Re: [PATCHv3 1/2] Documentation: clarify fnmatch behavior in gitignore
Date: Tue, 05 Apr 2011 16:43:33 -0600
Organization: Red Hat
Message-ID: <4D9B9B15.8040600@redhat.com>
References: <1302041878-24426-1-git-send-email-eblake@redhat.com> <7vfwpwl43h.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig83492BF1F4A2D5FDA3C4B1CA"
Cc: git@vger.kernel.org, j6t@kdbg.org, jrnieder@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 01:00:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q7FEV-0001B1-CQ
	for gcvg-git-2@lo.gmane.org; Wed, 06 Apr 2011 01:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755395Ab1DEXAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2011 19:00:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13900 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755241Ab1DEXAR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2011 19:00:17 -0400
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p35MhYoF017874
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Tue, 5 Apr 2011 18:43:34 -0400
Received: from [10.3.113.117] (ovpn-113-117.phx2.redhat.com [10.3.113.117])
	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p35MhXOr019501;
	Tue, 5 Apr 2011 18:43:33 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.9
In-Reply-To: <7vfwpwl43h.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.1.2
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170934>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig83492BF1F4A2D5FDA3C4B1CA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 04/05/2011 04:34 PM, Junio C Hamano wrote:
>>   - Otherwise, git treats the pattern as a shell glob suitable
>> -   for consumption by fnmatch(3) with the FNM_PATHNAME flag:
>> -   wildcards in the pattern will not match a / in the pathname.
>> -   For example, "Documentation/{asterisk}.html" matches
>> +   for consumption by fnmatch(3) with the FNM_PATHNAME but not
>> +   FNM_PERIOD flags: wildcards in the pattern will match leading
>> +   . but not / in pathnames.  For example,
>=20
> Does this format correctly with asciidoc?

No idea - I'm not an asciidoc whiz.  How would I tell (or can someone
else offer some advice)?

>=20
> Even if it does not get confused as a bullet or something, I think you
> would want to quote it (and the slash), perhaps like
>=20
> 	`.` (dot) and `/` (slash)
>=20
> In any case, I tend to think that we would want to add FNM_PERIOD to
> tighten the match in the longer term, perhaps at the 1.8.0 boundary.

POSIX requires that "find . -name '*'" not use FNM_PERIOD, and I
actually like the consistency with find(1).  In other words, I would
complain (then go with group consensus, if my complaint is in the
minority) that it is a step backwards to tighten the match, where the sho=
rt:

  dir/*

would have to become the much longer

  dir/*
  dir/.[!.]
  dir/.??*

to properly exclude all except '.' and '..', or

  dir/*
  dir/.*

if '.' and '..' are already special to the pattern matching.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig83492BF1F4A2D5FDA3C4B1CA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNm5sVAAoJEKeha0olJ0NqlL4H/1bmY/eDt2t27dfc2s788Y2Z
lyST3M8cGo//CTSjsVXD7rbkVWuarNl/Db/qlMMzWEyBw24GjioRBPy0l5WIRfyi
VwWRjMF8rED4cA71rOMVhrAyvlQyLncJcRAVKJS4FS9YDfPgyqY1FHiKLXuZnvYq
5h5886tnzrseo5PGEGBR2xSn4vqAUHGypXsOgBjuVnEbZvx8Vy6PdL+esyFmvIwq
qLT+qT0z2ouf99r6hxdPxJ+bKxm1BHYwwcVf1Xbudf/XhIrLzxJJpYEwVe8GsCYJ
U/xWXol6pbdRpXFKPh+TaQuZpJ3U3WryPjMzDTlN89rX/3VnaUvJbsdJoc+FhT4=
=y9vC
-----END PGP SIGNATURE-----

--------------enig83492BF1F4A2D5FDA3C4B1CA--
