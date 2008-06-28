From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: git-svn messed up import, badly
Date: Sat, 28 Jun 2008 21:48:08 +0200
Message-ID: <20080628194808.GA29908@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, Adam Roben <aroben@apple.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Samuel Bronson <naesten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 28 21:49:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCgQ2-0002KM-Sk
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 21:49:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751071AbYF1TsO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jun 2008 15:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751042AbYF1TsO
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 15:48:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:50843 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750930AbYF1TsN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 15:48:13 -0400
Received: (qmail invoked by alias); 28 Jun 2008 19:48:10 -0000
Received: from i577BBCD7.versanet.de (EHLO atjola.local) [87.123.188.215]
  by mail.gmx.net (mp056) with SMTP; 28 Jun 2008 21:48:10 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/jOVw5IW/jKb1vofaCwfgb2sPZNKt7FrJM2uN6po
	flut05cbPg5z8t
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86739>

Hi,

Samuel reported on #git that a git-svn import was failing for him.  I
tried to reproduce that, and while it failed on a different svn revisio=
n
for me, it still failed pretty badly.

The repo is at:
	svn://scm.gforge.inria.fr/svn/coq/

I cloned with:
	git svn clone -s svn://scm.gforge.inria.fr/svn/coq/

And with my current git-svn import, I'm getting this error message:

Checksum mismatch: trunk/.depend 16e748c219f9f95bf3d05c6b2af5444290bc84=
71
expected: 05fb5edb8c8057be006c7e913ae0c764
     got: 763b9a426c5bd61e0a85252459d37cfa

I got that when it bailed out from "git svn clone" and I get it on each
"git svn fetch" run, trying to resume the import.

Looking at the history of trunk/.depend and comparing the diffs that gi=
t
gives me to those that "svn diff" gives me, I noticed that the diffs fo=
r
changes to .depend introduced in svn revision 2314 differ heavily
between svn and my git-svn import.

Tarball of the repo and the two diffs is at:
http://people.linux-vserver.org/~doener/broken-git-svn-import.tbz
[4.8MB]

$ git --version
git version 1.5.6.1.78.gde8d9

git svn --version
git-svn version 1.5.6.1.78.gde8d9 (svn 1.4.6)

Avery and Adam on Cc:, because Avery reported a somewhat similar issue
that he bisected down to the git-svn speed-up patch by Adam.

Unfortunately, I currently don't have enough time on my hands to perfor=
m
a bisection.

If you need anything else, let me know.

Thanks,
Bj=F6rn
