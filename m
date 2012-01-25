From: Christine Bauers <c.bauers@gmx.de>
Subject: Git svn migration does not work because fatal git checkout updating
 paths is incompatible with switching branches
Date: Wed, 25 Jan 2012 19:04:26 +0100
Message-ID: <4F20442A.1080005@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 25 19:04:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq7D0-0000Us-Fi
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 19:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353Ab2AYSE3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jan 2012 13:04:29 -0500
Received: from mailout-de.gmx.net ([213.165.64.22]:55894 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750833Ab2AYSE3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 13:04:29 -0500
Received: (qmail invoked by alias); 25 Jan 2012 18:04:27 -0000
Received: from p4FFE0686.dip.t-dialin.net (EHLO [192.168.1.39]) [79.254.6.134]
  by mail.gmx.net (mp032) with SMTP; 25 Jan 2012 19:04:27 +0100
X-Authenticated: #35902447
X-Provags-ID: V01U2FsdGVkX1/iP0kcRu7iE5FcIRruTzbqBzALHqbA/iMISfsOMC
	b4Vf4LzUmxpt2P
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189116>

Hi there,

I=C2=B4m trying to migrate a repository from svn to git which branches =
and=20
tags with the following migration script:

git svn clone --no-metadata --stdlayout --A ../users.txt=20
svn://host/svn/project/subproject subproject

cd subproject
git config svn.authorsfile ../../users.txt
git svn fetch

git checkout -b branch1 remotes/branch1
git checkout -b branch2 remotes/branch2
git checkout -b branch3 remotes/branch3

git checkout -b src_v1 remotes/tags/src
git checkout master
git tag src src_v1
git branch -D src_v1

git checkout -b WebContent_v1 remotes/tags/WebContent
git checkout master
git tag WebContent WebContent_v1
git branch -D WebContent_v1

and get the follwoing errors:

W: Ignoring error from SVN, path probably does not exist: (160013):=20
=46ilesystem has no item: Datei nicht gefunden: Revision 8966, Pfad=20
=C3=82=C2=BBsubproject=C2=AB
W: Do not be alarmed at the above message git-svn is just searching=20
aggressively for old history.
This may take a while on large repositories
fatal: git checkout: updating paths is incompatible with switching bran=
ches.
Did you intend to checkout 'remotes/branch1' which can not be resolved=20
as commit?
fatal: git checkout: updating paths is incompatible with switching bran=
ches.
Did you intend to checkout 'remotes/branch2 which can not be resolved a=
s=20
commit?
fatal: git checkout: updating paths is incompatible with switching bran=
ches.
Did you intend to checkout 'remotes/branch3' which can not be resolved=20
as commit?
fatal: git checkout: updating paths is incompatible with switching bran=
ches.
Did you intend to checkout 'remotes/tags/src' which can not be resolved=
=20
as commit?
error: pathspec 'master' did not match any file(s) known to git.
fatal: Failed to resolve 'src_v1' as a valid ref.
error: branch 'src_v1' not found.
fatal: git checkout: updating paths is incompatible with switching bran=
ches.
Did you intend to checkout 'remotes/tags/WebContent' which can not be=20
resolved as commit?
error: pathspec 'master' did not match any file(s) known to git.
fatal: Failed to resolve 'WebContent_v1' as a valid ref.
error: branch 'WebContent_v1' not found.

How do I solve this problem?

Greetings
Christine
