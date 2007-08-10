From: Jan Hudec <bulb@ucw.cz>
Subject: Relative alternates question
Date: Fri, 10 Aug 2007 18:45:56 +0200
Message-ID: <20070810164556.GB3442@efreet.light.src>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="p4qYPpj5QlsIQJ0K"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 10 18:46:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJXdL-0003b4-H8
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 18:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936390AbXHJQqG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 12:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939707AbXHJQqF
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 12:46:05 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:32998 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765174AbXHJQqD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2007 12:46:03 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 0395C5746E
	for <git@vger.kernel.org>; Fri, 10 Aug 2007 18:46:01 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id mKvA88kHlddE for <git@vger.kernel.org>;
	Fri, 10 Aug 2007 18:45:58 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 508805725C
	for <git@vger.kernel.org>; Fri, 10 Aug 2007 18:45:58 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IJXca-0001Mz-UL
	for git@vger.kernel.org; Fri, 10 Aug 2007 18:45:56 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55553>


--p4qYPpj5QlsIQJ0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Trying to solve a problem with object/info/alternates and http (a rather
problematic combination) I noticed the following code in sha1_file.c:336 in
function link_alt_odb_entries.
(current master -- v1.5.3-rc4-41-g7efeb8f):

                        if ((*last !=3D '/') && depth) {
                                error("%s: ignoring relative alternate obje=
ct store %s",
                                                relative_base, last);
                        } else {
                                link_alt_odb_entry(last, cp - last,
                                                relative_base, depth);
                        }

The last is (if I understood the code correctly) begining of line, cp is end
of that line and depth is depth of recursion in resolving the alternates. N=
ow
unless I read the code completely wrong, it means, that when git reads
a repository, it resolves relative paths in it's objects/info/alternates, b=
ut
if that contains further alternates, it would ignore relative alternate pat=
hs
there -- and therefore not find objects needed from there.

And my question is, is there any good reason to reject relative paths in
alternates of an alternate? From what I see the recursive call to
link_alt_odb_entries (via link_alt_odb_entry and read_info_alternates) has
all the information it needs to resolve such paths.

Thanks,

Jan

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--p4qYPpj5QlsIQJ0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGvJZERel1vVwhjGURAt3bAJ932lFpa3L3HF5v1eYm0MeAUI3acQCghF6o
YPD2anhkRLlnks4U/1XJDSc=
=AoNM
-----END PGP SIGNATURE-----

--p4qYPpj5QlsIQJ0K--
