From: Hermann Gausterer <git-mailinglist@mrq1.org>
Subject: [BUG] minor: wrong handling of GIT_AUTHOR_DATE
Date: Sat, 16 Aug 2008 22:53:25 +0200
Message-ID: <20080816205325.GD10729@mrq1.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Cc: Hermann Gausterer <git-mailinglist@mrq1.org>
To: Git Mailinglist <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 16 23:01:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KUSte-0001QP-HY
	for gcvg-git-2@gmane.org; Sat, 16 Aug 2008 23:01:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbYHPVAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Aug 2008 17:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750943AbYHPVAK
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Aug 2008 17:00:10 -0400
Received: from nat-warsl417-02.aon.at ([195.3.96.120]:6022 "EHLO email.aon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750913AbYHPVAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Aug 2008 17:00:09 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Aug 2008 17:00:08 EDT
Received: (qmail 16692 invoked from network); 16 Aug 2008 20:53:27 -0000
Received: from smarthub95.highway.telekom.at (HELO email.aon.at) ([172.18.5.234])
          (envelope-sender <git-mailinglist@mrq1.org>)
          by fallback44.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 16 Aug 2008 20:53:27 -0000
Received: (qmail 2089 invoked from network); 16 Aug 2008 20:53:25 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.0 (2007-05-01) on
	WARSBL503.highway.telekom.at
X-Spam-Level: *
Received: from 91-115-105-133.adsl.highway.telekom.at (HELO mrq1.org) ([91.115.105.133])
          (envelope-sender <git-mailinglist@mrq1.org>)
          by smarthub95.highway.telekom.at (qmail-ldap-1.03) with SMTP
          for <git@vger.kernel.org>; 16 Aug 2008 20:53:25 -0000
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92556>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi

i found a minor bug in the handling of the
environment variable GIT_AUTHOR_DATE

i used this variable to import an old project.

i used "stat" to get the timestamp of a file
and set the git history to this date with
this command:

GIT_AUTHOR_DATE=`stat -c '%y' "$FILE"`

old files (created with an older kernel)
produced this output.

2008-05-28 14:21:35.000000000 +0200

but new files return nanosecond resolution
timestamps.

2008-06-04 17:25:54.917476713 +0200

of course this resolution is NOT needed
for git, but git DOES NOT ignore this time-
stamps. it changes the date to something
completly wrong :-/

steps to reproduce:

$ git init
$ touch test
$ stat -c %y test
2008-08-16 22:25:45.491701924 +0200
$ export GIT_AUTHOR_DATE=`stat -c %y test`
$ git add test
$ git commit -a
$ git log
commit 56f92b8f6efc7bdaa5abdf03a8c5dbf79dd1fdff
Author: Hermann Gausterer <git-bugreport@mrq1.org>
Date:   Thu Aug 1 01:52:04 1985 +0200

    test
$

mfg hermann

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIpz5FAdCXZ1Xu7u4RAoePAKCm2gAZBh5uUAL7m+kviwmVp4PSCACfdjS8
43qM5SqcoDqOXnW291z6Ux0=
=jo7s
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
