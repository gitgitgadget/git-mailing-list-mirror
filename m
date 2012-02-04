From: Joey Hess <joey@kitenet.net>
Subject: Re: Git performance results on a large repository
Date: Sat, 4 Feb 2012 01:07:12 -0400
Message-ID: <20120204050712.GA2460@gnu.kitenet.net>
References: <CB5074CF.3AD7A%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Sat Feb 04 06:08:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtXrE-0002z5-VI
	for gcvg-git-2@plane.gmane.org; Sat, 04 Feb 2012 06:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750777Ab2BDFHr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Feb 2012 00:07:47 -0500
Received: from wren.kitenet.net ([80.68.85.49]:55442 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750714Ab2BDFHr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2012 00:07:47 -0500
Received: from gnu.kitenet.net (dialup-4.153.81.96.Dial1.Atlanta1.Level3.net [4.153.81.96])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 4B65411805F;
	Sat,  4 Feb 2012 00:07:43 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 18EDA49C66; Sat,  4 Feb 2012 00:07:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CB5074CF.3AD7A%joshua.redstone@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189841>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Joshua Redstone wrote:
> The test repo has 4 million commits, linear history and about 1.3 million
> files.

Have you tried separating these two factors, to see how badly each is
affecting performance?

If the number of commits is the problem (seems likely for git blame at
least), a shallow clone would avoid that overhead.

I think that git often writes .git/index inneficiently when staging
files (though your `git add` is pretty fast) and committing. It rewrites
the whole file to .git/index.lck and the renames it over .git/index at
the end. I have code that keeps a journal of changes to avoid rewriting
the index repeatedly, but it's application specific. Fixing git to write
the index more intelligently is something I'd like to see.

Hint for git status: `git status .` in a smaller subdirectory will be much
faster than the default that stats everything.

--=20
see shy jo

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTyy8/8kQ2SIlEuPHAQi4NBAAn2gVGzMXymR4UaUbm9tPvCLciY7Ujhca
aYGtukz4TTdQTg/b1U36EXGJK1SU13gonyPDYNxmHPZOvsHy15Zhy9bEheu6/xAu
E1xMufdAdXyLPitCE+X98YjbcPTB8ZIIXG6Fw2+mFgHy+Vq9A0RzuaM0Sh5ZpgEs
ZHbrAKEWOrF2anjmpBJGyVFGfISuxrhJBhSyFbJxVtC4xgL0HBp5ZbNhhR1JXjeI
k0qHh4b3UQbh2tU7EqGPcrgum0ceUvNeJsTsrtM1grqdBv4qQLXl4yiFXEf98NyF
JvzPes2ko+8+4H28k17HL01ApVJ7yLoj3g+RufPCb6ytc2qngZ1nIoMVY4uJjW0p
qpSQQSwh6j9OSwyl12E5VcnIRsF1hWLvRPcwSFGiEDVnrPk7qAbBld9V7CI4Rj9Y
K2EhhXg/v8Z8mc29NuIZBcX9+wS7Q6m+B8MXodoCk23vCDoDLS1vz05HGU8Ljm/Q
s0GZtV1g5C94Cg8Lwt5x4QenfeT9/fZT65QDhOhvfOk8WsRnw1UJSbNdgCbFzrRc
l/M12088mYLDQMBw+vh2ZWzhkK8JDpxSyH46e8zPjBkp0ggeTCrzkAkmei6zt0T8
YPD0Q87SkHU0P/Cjij2XitsVx9axWhwcm1knhYhuw4KwL32e2BXKVTG4XQwJ884V
Y0gKIy/SCk8=
=1imm
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
