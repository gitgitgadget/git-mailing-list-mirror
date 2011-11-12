From: Joey Hess <joey@kitenet.net>
Subject: RFC: post-fetch hook
Date: Sat, 12 Nov 2011 15:44:14 -0400
Message-ID: <20111112194414.GA3439@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 20:54:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPJei-0001K5-3O
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 20:54:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105Ab1KLTyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Nov 2011 14:54:14 -0500
Received: from wren.kitenet.net ([80.68.85.49]:41906 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753133Ab1KLTyO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2011 14:54:14 -0500
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Sat, 12 Nov 2011 14:54:13 EST
Received: from gnu.kitenet.net (dialup-4.252.13.11.Dial1.Atlanta1.Level3.net [4.252.13.11])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 221FB1183FA
	for <git@vger.kernel.org>; Sat, 12 Nov 2011 14:44:19 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 2AA6E402DC; Sat, 12 Nov 2011 14:44:14 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185314>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

A post-fetch hook would run on the local repository after a git-fetch or
git-pull. It would probably make sense for the hook to be sent the same
format input as the post-receive hook (although I don't need that informati=
on
myself). Like post-receive, it would not affect the outcome of the fetch. It
should be called late enough that it can manipulate the git repository
using the fetched refs.

My use case is in git-annex. It maintains its own, rather notes-like
branch. When remote versions of the branch have changed, they are
automatically merged into the local branch, using a union merge,
the next time git-annex is run. So normally it does not need this hook.

But, consider the case where git-annex has locally modified its branch,
and the remote tracking branch has also been modified. Now the user does
"git pull; git push". With the two git-annex branches diverged the
push fails. The user has to manually run "git annex merge" before
pushing to handle this.

If there was a post-fetch hook, git-annex could make it always run
git annex merge, and users would not need to deal with this situation.

--=20
see shy jo

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTr7MiskQ2SIlEuPHAQgu2Q//QYh/VcqH7EVa+q2cDKtD7fdn+sqOuvVK
07g5bTuS4wAdk7UWyrmWyxfWY7iOp/Fe7pq8uQckXnbWvSZq9k6O6Mj8rZYSD/St
M08HhsobXoXZOAuOvcHIY9GixLVc8gPyQ5ZShbB/UX/18V7eg6XmXm2MZsYEpOpq
GImvqwTBYgtW/CkU2rcgs60OCcxYJFJW/q7qOzH0/1BtECcomTA6QUtuBvbM7Day
+oM8P2VF+c0yKnLBzXVEHLXN6FwKEV0rfDzt1nq0j7OalQA/H+Yse5VazQRQOCO1
P9LkUbWLl6DulGKxTssxMMLa5Lt2Co/FRtB/ig3vIkYEplwkLN/uuy7na2Y0o/3Y
Y4pDHcM2H8FUr7BAF1XiAkYRJ+DZnDI0SDmZ6zaWM3ysAKmONPaqrFj8vEVIDjTR
9OM3wFrtGXyaMdPzt00tBm5ACUAjodvSZCmLiws9OQkj8+VF4C+n2NfnwCMOHCOx
34nb2284UcM97IZmETQPnoo6RN9mpqy8DGN7TW8oKFtC3cDpt3In2nyxwuQ9tb/O
VFAcpI2uBdQRBO/1CEGEtKozff5pTYFzOCZHc4dbXLxwG28CzKWd6dOZYxVoGIJa
MG4ndprzi4vW9iDRAdTgpZOhcRQ5+JTR8dR5i0y5EIFhs6G5RJyKpLvO2IbRpDFk
R3MfB/zIwwE=
=jK08
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
