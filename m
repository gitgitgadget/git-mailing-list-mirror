From: "W. Trevor King" <wking@drexel.edu>
Subject: Re: [PATCH v7 3/3] gitweb: add If-Modified-Since handling to
 git_snapshot().
Date: Wed, 28 Mar 2012 14:37:12 -0400
Message-ID: <20120328183712.GA5992@odin.tremily.us>
References: <20120328164513.GA4389@odin.tremily.us>
 <81004880a876bb9b9f607129956363d3167bff72.1332956550.git.wking@drexel.edu>
 <201203282011.32148.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=IJpNTDwzlM2Ie8A6
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 20:37:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCxkZ-0007Pi-TU
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 20:37:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758415Ab2C1Shf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 14:37:35 -0400
Received: from vms173013pub.verizon.net ([206.46.173.13]:60647 "EHLO
	vms173013pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758273Ab2C1Shf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 14:37:35 -0400
Received: from odin.tremily.us ([unknown] [72.68.98.116])
 by vms173013.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0M1L00HW4YE2H040@vms173013.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 28 Mar 2012 13:37:15 -0500 (CDT)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 97D1D43B5BB; Wed,
 28 Mar 2012 14:37:13 -0400 (EDT)
Content-disposition: inline
In-reply-to: <201203282011.32148.jnareb@gmail.com>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194159>


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 28, 2012 at 07:11:31PM +0100, Jakub Narebski wrote:
> W. Trevor King wrote:
> >  	print $cgi->header(
> >  		-type =3D> $known_snapshot_formats{$format}{'type'},
> >  		-content_disposition =3D> 'inline; filename=3D"' . $filename . '"',
> > +		-last_modified =3D> (%co ? $latest_date{'rfc2822'} : ()),
> >  		-status =3D> '200 OK');
>=20
> I'm sorry to be bearer of bad news, but this is still incorrect.
> It should be:
>=20
>    	print $cgi->header(
>    		-type =3D> $known_snapshot_formats{$format}{'type'},
>    		-content_disposition =3D> 'inline; filename=3D"' . $filename . '"',
>   +		%co ? (-last_modified =3D> $latest_date{'rfc2822'}) : (),
>    		-status =3D> '200 OK');

Grr.  Thanks.  I'm getting lots of rebase practice on this patch set,
but I'm still missing things=E2=80=A6

> And it was not caught by test because CGI.pm can output the last modified
> header as "Last-modified" (RFC 2616, sec 4.2 states "Field names are
> case-insensitive"), so the last check should be
>=20
>   +	! grep -i "Last-Modified" gitweb.output
>=20
> Hmmm... why we use gitweb.output and not gitweb.headers?  Is it consisten=
cy
> with earlier tests?

Yes, but I can switch to `gitweb.headers` if you'd like.  Should I
adjust all the header tests in t9501 to use `gitweb.headers` and `grep
-i`?  It should probably be a separate patch for the tests that
existed before my i-m-s additions.

--=20
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy

--IJpNTDwzlM2Ie8A6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQEcBAEBAgAGBQJPc1pWAAoJEPe7CdOcrcTZEf8H/3eIRN4YadtgAPfCdVN//woK
0qHYn3tAdzHZwT/YTzty4GWiVI713489SrlYa3j73kVq9jeymWbjIq6ptdbACbxi
tzMhVOZk+tsc9z0h1HfyGhJB5Qr/mCJoijsqBYRgAhgVmeAQom0S3QvIx1M0N6eF
H0jAl9Gbk4uRoiop6d6REQfEvjmgf0PXdLqm7pRqSekqFqm7A1FDbJMrRRGUhitR
1hOfL0/lA0sIyBoP1tjAcUh9xHB/pvrIYZgDfP5o9K9CL8OGq9b4/GEOMGVwgFw1
nULhhi74LzazNWwlxO32MLdzWMbl3kWY56OwgY/pXxEWF6N4jdmFRZ9EI9l95Pk=
=/4mR
-----END PGP SIGNATURE-----

--IJpNTDwzlM2Ie8A6--
