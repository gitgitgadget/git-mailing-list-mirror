From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Subject: t5000-tar-tree.sh failing
Date: Thu, 21 Dec 2006 14:37:46 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20061221133746.GA13751@cepheus>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Thu Dec 21 14:38:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxO7O-0006fK-Ro
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 14:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422889AbWLUNhv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 21 Dec 2006 08:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422892AbWLUNhv
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 08:37:51 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:57116 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1422889AbWLUNhu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Dec 2006 08:37:50 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.60)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1GxO7J-0003p3-Rt
	for git@vger.kernel.org; Thu, 21 Dec 2006 14:37:49 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id kBLDblB4015720
	for <git@vger.kernel.org>; Thu, 21 Dec 2006 14:37:47 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id kBLDbkHr015719
	for git@vger.kernel.org; Thu, 21 Dec 2006 14:37:46 +0100 (MET)
To: git@vger.kernel.org
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <zeisberg@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35065>

Hello,

when I run make test, I get:

	*** t5000-tar-tree.sh ***
	Initialized empty Git repository in .git/
	*   ok 1: populate workdir
	*   ok 2: add files to repository
	*   ok 3: git-tar-tree
	*   ok 4: validate file modification time
	*   ok 5: git-get-tar-commit-id
	*   ok 6: extract tar archive
	*   ok 7: validate filenames
	*   ok 8: validate file contents
	*   ok 9: git-tar-tree with prefix
	*   ok 10: extract tar archive with prefix
	*   ok 11: validate filenames with prefix
	*   ok 12: validate file contents with prefix
	*   ok 13: git-archive --format=3Dzip
	* FAIL 14: extract ZIP archive
		(mkdir d && cd d && $UNZIP ../d.zip)
	* FAIL 15: validate filenames
		(cd d/a && find .) | sort >d.lst &&
		     diff a.lst d.lst
	* FAIL 16: validate file contents
		diff -r a d/a
	*   ok 17: git-archive --format=3Dzip with prefix
	* FAIL 18: extract ZIP archive with prefix
		(mkdir e && cd e && $UNZIP ../e.zip)
	* FAIL 19: validate filenames with prefix
		(cd e/prefix/a && find .) | sort >e.lst &&
		     diff a.lst e.lst
	* FAIL 20: validate file contents with prefix
		diff -r a e/prefix/a
	* failed 6 among 20 test(s)

I think the problem is:

	zeisberg@cepheus:~/gsrc/git$ unzip
	bash: unzip: command not found

Probably the subversion tests suffer the same (for svn instead of
unzip).

Do we want the tests to depend on all that or would it be sensible to
output a warning that a program is missing?  Or maybe introduce test
"13.5:  check is unzip is available".  Then it would be more obvious fo=
r
the tester what went wrong?

Best regards
Uwe

--=20
Uwe Kleine-K=F6nig

primes where sieve (p:xs) =3D [ x | x<-xs, x `rem` p /=3D 0 ]; \
primes =3D map head (iterate sieve [2..])
