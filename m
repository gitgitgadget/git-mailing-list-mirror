From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <carlos@cmartin.tk>
Subject: [GSoC 2011] libgit2: final report
Date: Wed, 31 Aug 2011 23:00:00 +0200
Message-ID: <1314824402.3680.95.camel@bee.lab.cmartin.tk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-IgP3xGd956QQg4/Qph1V"
To: libgit2@librelist.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 31 23:00:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyrtK-000099-08
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 23:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755400Ab1HaVAE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 17:00:04 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:51162 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755085Ab1HaVAD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 17:00:03 -0400
Received: from [192.168.1.15] (brln-4db9f348.pool.mediaWays.net [77.185.243.72])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 194D746156;
	Wed, 31 Aug 2011 22:59:48 +0200 (CEST)
X-Mailer: Evolution 3.0.2- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180505>


--=-IgP3xGd956QQg4/Qph1V
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello all,

GSoC is finished and I'll send the proof of work to Google shortly. Many
thanks to everyone who helped me along the way.

So? How did it go? Unfortunately I wasn't able to do everything that was
in the (quite optimistic) original plan as there were some changes and
additions that had to be done to the library in order to support the new
features (the code movement in preparation for the indexer
(git-index-pack) being the clearest example of this. The code has been
merged upstream and you want to look at examples of use, you can take a
look at my libgit2-utils repo[0] where you can find a functional
implementation of git-fetch (git-clone would be about 20 lines more, I
just never got around to writing it).

[0] https://github.com/carlosmn/libgit2-utils

Let me give you a few highlights of what new features were added to the
library:

 _Remotes_

  A remote (struct git_remote) is the (library) user's interface to the
communications with external repositories. When read from the
configuration file, it will parse the refspecs and take them into
consideration when fetching. With the most recent changes, you can also
create one on the fly with an URL. The remote will create an instance of
a transport and will take care of the lower-levels.

_Transports_

 The logic exists inside the transports. Currently only the fetch part
of the plain git protocol is supported, but the architecture is
extensible. The code would have to live in the library, but adding
support for plug-ins, as it were, would be an easy task.

_pkt-line_

 The code for parsing and creating these lines is its own namespace, so
that it can be used for other transports. It supports a kind of
streaming parsing, as it will return the appropriate error code if the
buffer isn't large enough for the line.

_Indexer_

 This is what libgit2 has instead of git-index-pack. It's much slower
than the git implementation because it hasn't been optimised yet as it
uses the normal pack access methods. Currently the only user would be a
git-fetch implementation and that is still fast enough so it's not that
high a priority.
 As a result of this work, the memory window and pack access code has
been made much more generic.


 I plan to continue working on this project. The next steps are push
(which has quite a few prerequisites, not least pack generation) and
smart HTTP support. The addition of the new backend should help make
code more generic. After that, SSH support should be a matter of
wrapping the existing code up.

--=-IgP3xGd956QQg4/Qph1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOXqDQAAoJEHKRP1jG7ZzTwkUH/RHWgNPEIxgYkPeBojS+2igQ
xLDDXrUXdSfkHsuAyGbMNKi2hbrjYvA27hJxaGvTBVqnt7QBF9WCV8nhjvrUw99D
rfF1VZRF0pQ5x4xjGyx97i2GrL0r1Hw2xeh/UgoZLX0A/R2RPNNdHYG4RJI5nUpV
DuO5BNa6nfEMY4RCgmbKfdoKWJ8y1rE/p5svbJ1N09NUMF5Rv3P0DRbDFEruPb/z
NE0M1Rj1IvxeN6r41eVBio7F2Dq0IP6MWX32isWPCvrnsmXp3ZKJ91L+hTJ1G3YW
phOMQzljBSw9UgBVHTevCJwGVazfH+cBhn0UgEyZNZRdu04YE8y3kriCDtAXSV0=
=QNrW
-----END PGP SIGNATURE-----

--=-IgP3xGd956QQg4/Qph1V--
