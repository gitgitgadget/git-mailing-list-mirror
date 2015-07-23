From: Jan Vales <jan@jvales.net>
Subject: unexplained behavior/issue with git archive?
Date: Thu, 23 Jul 2015 17:23:49 +0200
Message-ID: <55B10705.6090303@jvales.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MwpGunBtCnxMgF9nqvUstl8klQ8Xi7jlH"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 23 17:38:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIIZS-0003JL-IB
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 17:38:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753701AbbGWPh6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 11:37:58 -0400
Received: from mail.somenet.org ([213.143.98.34]:56954 "EHLO mail.somenet.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752923AbbGWPhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 11:37:54 -0400
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Thu, 23 Jul 2015 11:37:54 EDT
Received: from [128.130.254.137] (e254-137.eduroam.tuwien.ac.at [128.130.254.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.somenet.org (Postfix) with ESMTPSA id E75C41006A1C2
	for <git@vger.kernel.org>; Thu, 23 Jul 2015 17:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jvales.net;
	s=default; t=1437665032; r=y;
	bh=0Cywwqsw8pOBmxFq63mMLZ2xpt3iHcwgdYU/sJlxr6M=; h=To:From;
	b=uUO0a+ubQmVna67EYZuvgyolJMUAnMfaCvIRH8AE0+ZEooD9Kt0YZeB8LnfB5IaA0
	 vQW0swMR8vnoWZjMV/0xF+GAptAxRnPLL1ycH7pC+iHbOaSvf9dEsmQ+frmxl6VSBp
	 jpgSdLaanHVjt2sB/O7rHBI7iVgJJxRcAqzZld10=
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274501>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MwpGunBtCnxMgF9nqvUstl8klQ8Xi7jlH
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi,
i seem to trigger behavior i do not understand with git archive.

I have this little 3 liner (vmdiff.sh):
#!/bin/bash
git diff --name-status "$2" "$3" > "$1.files"
git diff --name-only "$2" "$3" |xargs -d'\n' git archive -o "$1" "$3" --


For testing purpose, lets assume this call:
# ./vmdiff.sh latest.zip HEAD^1 HEAD

# cat latest.zip.files | wc -l
149021

# cat latest.zip.files | egrep "^D" | wc -l
159

# mkdir empty; cd empty; unzip latest.zip ; find * | wc -l
1090

My goal is to basically diff (parts of) filesystems against each other
and create an archive with all changed files + a file list to know what
files were deleted. (I currently do not care about the files
permissions+ownership, and it doesnt really matter in the current
problem. Also dont ask, why one would store a root-filesystem in git :)

What I do not understand: why does the zip file only contains 1090
files+dirs if the wc -l shows like 150k files and only like 159 were
deleted?
There should be like 149k files in that archive.

Also only the few files are all from "var" and none from etc or srv
where definitely files changed in too! (and show up in latest.zip.files)

Is there a limit of files git archive can process?

lg
Jan Vales
--
I only read plaintext emails.

Someone @ irc://irc.fsinf.at:6667/tuwien
webIRC: https://frost.fsinf.at/iris/


--MwpGunBtCnxMgF9nqvUstl8klQ8Xi7jlH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVsQcIAAoJEERD22thjA7qIXcP/0csvtbxJa/6/ONfmcu0rfy4
2tCsjILi+yqF/F6AulTLe+fA4bjuS7WqA0c2Vz7L1JRBS9hjSto9c15kp2jX7Epo
WA47UlmsqctySNEtpkbYLGZtDb4Qm9msLB/fYdGNuOHUmDDrs/Rr3SlCDkyNPFCh
AOx2Tc8CFyOtV+MfR/STwyhL6/SYO1aGvYFXheEfmWV8onHIcXyRkVrs7ClmsASk
9wpxrUXfxRkWI++yIw8QzzaPQVBmola7sO2a26Pys65VPlU3GI71Ouoxm5kr/wNu
ioWCMlMJmjQpxXVzaxONS9JWNbh/DTr/2WVNW04ngTU0UWCLRTx+bOcrhZmeGyp7
gnilp9pHxJ2tH5V5IuB8iSDLpxnMCQmrsMFzqiLBu5426Yx2tnthVGD2Nv80qbY6
eAK3DnA0B9hOSTEQl8VJTQmizQs/L8mzrJmzeqO6K3roWdm0vj4Leahj4U2KQ4E/
H8dksaKe417293IgDzp9StzOnpudSAH8n8NAc7+lxhTuXHkzir+og4nTf3hOTcew
KfiewaAIh2rM5FGLmOMhlY+MgU8ZmDeu6QnFBuclm/Zids52R7HYw+/HZSndI/sU
XQEH17cfbFSc1vqGqe9x6wTjKwx4ukosCLFRf7ItznCiqAl+tZuK/Zb6TLILe54A
C54jZ9arv0ssq8n0iMLx
=G7L7
-----END PGP SIGNATURE-----

--MwpGunBtCnxMgF9nqvUstl8klQ8Xi7jlH--
