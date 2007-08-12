From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: --exit-code (and --quiet) broken in git-diff?
Date: Sun, 12 Aug 2007 11:40:58 +0200
Message-ID: <46BED5AA.7050900@lsrfire.ath.cx>
References: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Sun Aug 12 11:41:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK9wh-000421-IP
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 11:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756436AbXHLJlM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 12 Aug 2007 05:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755223AbXHLJlM
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 05:41:12 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:52808
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756436AbXHLJlL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Aug 2007 05:41:11 -0400
Received: from [10.0.1.201] (p508ED523.dip.t-dialin.net [80.142.213.35])
	by neapel230.server4you.de (Postfix) with ESMTP id 0B6748B008;
	Sun, 12 Aug 2007 11:41:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <17875.88.10.191.55.1186873960.squirrel@secure.wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55669>

Wincent Colaiuta schrieb:
> The git-diff man page documents an "--exit-code" option, as well as a
> "--quiet" option which automatically implies the former.
>=20
> In my tests on Mac OS X and Bash 3, however, "git diff" always return=
 an
> exit code of 0, never of 1, regardless of how I use the "--quiet" and
> "--exit-code" options. I see that there are tests in t/t4017-quiet.sh=
 for
> the lower-level git-diff-files, git-diff-index, git-diff-tree command=
s,
> but none for the porcelain git-diff.
>=20
> Is this a bug with a missing test case? Or am I using this incorrectl=
y? In
> the example below I'm looking for differences between the working tre=
e and
> the last commit, so I'm using "git diff HEAD", but as you can see, th=
e
> exit code is always 0 for "git diff" and "git diff --cached" as well:
>=20
> $ git --version
> git version 1.5.2.4
> $ mkdir example
> $ cd example
> $ git init
> Initialized empty Git repository in .git/
> $ echo "start" > foo
> $ git add foo
> $ git commit -m "Add foo"
> Created initial commit 85954f6: Add foo
>  1 files changed, 1 insertions(+), 0 deletions(-)
>  create mode 100644 foo
> $ git diff --quiet HEAD; echo $?
> 0
> $ echo "more" >> foo
> $ git diff --quiet HEAD; echo $?
> 0
> $ git add foo
> $ git diff --quiet HEAD; echo $?
> 0
> $ git diff --quiet; echo $?
> 0
> $ git diff --exit-code; echo $?
> 0
> $ git diff --cached --quiet; echo $?
> 0

git diff passes the output through your pager by default, so you see th=
e
exit code of that instead of diff's.  Set PAGER=3Dcat or redirect the
output to /dev/null to get rid of it.

A test case for diff would be nice regardless, though. :)

Ren=E9
