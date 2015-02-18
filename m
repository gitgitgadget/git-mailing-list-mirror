From: Daniel Hahler <genml+git-2014@thequod.de>
Subject: Please use distinct messages for "unable to read" errors (with corrupt
 repo after "git stash -k")
Date: Wed, 18 Feb 2015 20:56:06 +0100
Message-ID: <54E4EE56.3080703@thequod.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="slqewKnDlSsII36wwV6cIQlUWx21g1qWp"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 20:56:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOAjH-0003O5-2G
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:56:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbbBRT4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:56:10 -0500
Received: from hahler.de ([188.40.33.212]:58311 "EHLO elfe.thequod.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752584AbbBRT4J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 14:56:09 -0500
Received: from localhost (amavis [10.122.1.24])
	by elfe.thequod.de (Postfix) with ESMTP id A401B620DA
	for <git@vger.kernel.org>; Wed, 18 Feb 2015 20:56:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
	content-type:content-type:subject:subject:mime-version
	:user-agent:from:from:date:date:message-id:received:received; s=
	postfix2; t=1424289367; bh=UzAQOILKsfWrLvuWNcL/vxZ2UhO/ZGzn/4GGV
	MNkvJA=; b=aa063ViQJfUeB8tp6mtAbsKTbInh5WboP/KpKwIP80tMyCs4GZoWm
	UsMB7SwejMtRTStnZlJ9F53zne4CT9tC91Ln01Q1Hc16cgV0FnvQKkQeorn/GoFu
	vxyIrtbHrAEEVnW63eYgdkJ4KRRyZ9a/d8nTyblTCXywruO4SRrFPI=
Received: from elfe.thequod.de ([10.122.1.25])
	by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
	with ESMTP id Wu0t9ALhlMJK for <git@vger.kernel.org>;
	Wed, 18 Feb 2015 20:56:07 +0100 (CET)
Received: from lenny.thequod.de (ip5b403898.dynamic.kabel-deutschland.de [91.64.56.152])
	(Authenticated sender: daniel@hahler.de)
	by elfe.thequod.de (Postfix) with ESMTPSA
	for <git@vger.kernel.org>; Wed, 18 Feb 2015 20:56:07 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264061>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--slqewKnDlSsII36wwV6cIQlUWx21g1qWp
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I've just experienced an issue, where the system hung after "git stash -k=
",
and I've had to use Alt-SysRq-REISUB to reboot.

Afterwards "git diff" and "git status" failed with:

"fatal: unable to read 7eaa1fb32551b16198924bfb8b9d3674fed2a59a"

When looking at Git's source I've found several places that use the same =
call
to `die`:

    die(_("unable to read %s")

I think it would be more helpful to have distinct messages for each of th=
em,
which would at least make it easier to find out where it is failing.


As for the issue at hand, I could not find the reference `7eaa1fb3` anywh=
ere,
except for it being an empty object in .git/objects, which I've deleted t=
hen.

It looked like 7eaa1fb should have become the new stash reference, but th=
en
the system crash happened before it has been finished/done.

But where did Git pick it from after reboot / with the corrupt repo?


I could fix it by cloning the repository locally again, and then
copying/merging the configuration, stash references etc.

I was using Git v2.3.0 when this happened.


Regards,
Daniel.

--=20
http://daniel.hahler.de/


--slqewKnDlSsII36wwV6cIQlUWx21g1qWp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iD8DBQFU5O5XfAK/hT/mPgARAm6lAJ9IXDAv8CIG5TpfTqK9H5Qlmp5qKQCg1rgS
QUVqDh4WJLYuEGHBTyvWdGU=
=+h4Q
-----END PGP SIGNATURE-----

--slqewKnDlSsII36wwV6cIQlUWx21g1qWp--
