From: "Brian J. Murrell" <brian@interlinx.bc.ca>
Subject: Re: checkout-index: unable to create file foo (File exists)
Date: Mon, 05 Nov 2012 10:25:16 -0500
Message-ID: <5097DA5C.9020603@interlinx.bc.ca>
References: <k6ulre$bko$1@ger.gmane.org> <20121104221018.GB9160@padd.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3ABE276292C81972C2751553"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 05 16:26:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVOYu-0003GO-Sh
	for gcvg-git-2@plane.gmane.org; Mon, 05 Nov 2012 16:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933194Ab2KEPZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 10:25:40 -0500
Received: from plane.gmane.org ([80.91.229.3]:46263 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932934Ab2KEPZg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 10:25:36 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1TVOYY-00031X-H2
	for git@vger.kernel.org; Mon, 05 Nov 2012 16:25:42 +0100
Received: from d67-193-214-242.home3.cgocable.net ([67.193.214.242])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 16:25:42 +0100
Received: from brian by d67-193-214-242.home3.cgocable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 16:25:42 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: d67-193-214-242.home3.cgocable.net
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121028 Thunderbird/16.0.2
In-Reply-To: <20121104221018.GB9160@padd.com>
X-Enigmail-Version: 1.4.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209063>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3ABE276292C81972C2751553
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12-11-04 05:10 PM, Pete Wyckoff wrote:
>=20
> Fascinating problem and observations.

I thought so as well.

> We've been using NFS with git for quite a while and have never
> seen such an error.

Could be because NFS manages to operate more atomically given that it's
just the network exporting of local filesystem.

> man 7 signal (linux man-pages 3.42) describes open() as restartable.

Indeed.  The question is just what is to be assumed by the code that has
asked for the restartability.

> Which network filesystem and OS are you using?

The filesystem is Lustre.  So not only is it networked, it is
distributed where the namespace and data store are handled by different
nodes, to it's not at all as atomic as NFS-on-(say-)ext4.  Given that,
it's entirely possible to imagine a scenario where a namespace (MDT in
the Lustre nomenclature) operation could get interrupted after the
namespace entry has been created but before the open(2) completes.  So
the question here is who's responsibility is it to handle that situation?=


> The third option is
> that there is a bug in the filesystem client.

Yep.  But before we can go on to determining a bug, the proper/expected
behavior needs to be determined.  I guess that's taking this a bit OT
for this list though.  I'm not really sure where else to go to determine
this though.  :-(

b.




--------------enig3ABE276292C81972C2751553
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlCX2mIACgkQl3EQlGLyuXDsSQCfc72FmB/9akuA+am/ejDxrHEN
Ug0AnRDLWzZ0pe4Hf8t0Dx1b1urTm/e6
=966l
-----END PGP SIGNATURE-----

--------------enig3ABE276292C81972C2751553--
