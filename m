From: Antoine Bonavita <antoine@stickyadstv.com>
Subject: Problem with git-svn with limited SVN access
Date: Wed, 09 Nov 2011 12:28:10 +0100
Message-ID: <4EBA63CA.7000201@stickyadstv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 12:35:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RO6RV-0001hk-LX
	for gcvg-git-2@lo.gmane.org; Wed, 09 Nov 2011 12:35:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751352Ab1KILfk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Nov 2011 06:35:40 -0500
Received: from mail.stickyadstv.com ([82.66.240.3]:38450 "EHLO stickyadstv.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751132Ab1KILfk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Nov 2011 06:35:40 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Nov 2011 06:35:39 EST
Received: by stickyadstv.com (Postfix, from userid 783)
	id 6BDAD21512; Wed,  9 Nov 2011 12:27:06 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on stickyadsserver
X-Spam-Level: 
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,AWL,
	TVD_PH_SUBJ_META autolearn=no version=3.2.5
Received: from [192.168.0.11] (juv34-7-78-249-50-77.fbx.proxad.net [78.249.50.77])
	(Authenticated sender: antoine)
	by stickyadstv.com (Postfix) with ESMTPSA id B8FAA214F0
	for <git@vger.kernel.org>; Wed,  9 Nov 2011 12:27:04 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110831 Fedora/3.1.12-2.fc14 Lightning/1.0b3pre Thunderbird/3.1.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185153>

Hello,

I have a problem with a git-svn setup and although I spent most of=20
yesterday googling for a solution but did not find any (see below for m=
y=20
failed attempts). I hope you guys here will be able to help me.

I have limited access to a SVN repository with a "standard" layout. By=20
limited, I mean that I am allowed only to access the folders "trunk",=20
"branches/XXX" and "branches/YYY".

*Attempt 1:*
 > git svn init svn://server/aaa/AAA -T trunk -b branches --username=3D=
UUU
Initialized empty Git repository in /home/.../.git/
Using higher level of URL: svn://server/aaa/AAA =3D> svn://server/aaa
 > git svn fetch
Error from SVN, (220001): Item is not readable: Item is not readable

*Attempt 2:*
 > git svn init svn://server/aaa/AAA -T trunk -b branches --username=3D=
UUU=20
--no-minimize-url
Initialized empty Git repository in /home/.../.git/
 > git svn fetch
W: Item is not readable: Item is not readable at=20
/usr/libexec/git-core/git-svn line 1782

Error from SVN, (220001): Item is not readable: Item is not readable

*Attempt 3:*
 > git svn init svn://server/aaa/AAA -T trunk --username=3DUUU=20
--no-minimize-url
Initialized empty Git repository in /home/.../.git/
 > git svn fetch
W: Item is not readable: Item is not readable at=20
/usr/libexec/git-core/git-svn line 1782

W: Ignoring error from SVN, path probably does not exist: (160013):=20
=46ilesystem has no item: File not found: revision 100, path '/AAA/trun=
k'
W: Do not be alarmed at the above message git-svn is just searching=20
aggressively for old history.
This may take a while on large repositories
Read access denied for root of edit: Not authorized to open root of edi=
t=20
operation at /usr/libexec/git-core/git-svn line 5131

*Attempt 4:*
 > git svn init -T svn://server/aaa/AAA/trunk -b=20
svn://server/aaa/AAA/branches --username=3DUUU --no-minimize-url

Initialized empty Git repository in /home/.../.git/
svn-remote.svn.url already set: svn://server/aaa/AAA/trunk
wanted to set to: svn://server/aaa/AAA/branches
 > git svn fetch
W: Ignoring error from SVN, path probably does not exist: (160013):=20
=46ilesystem has no item: File not found: revision 100, path '/AAA/trun=
k'
W: Do not be alarmed at the above message git-svn is just searching=20
aggressively for old history.
This may take a while on large repositories
          ### stuff actually retrieved from SVN
          .....
r6035 =3D 6163cb28acff14d68f1b96869274b668405897a2 (refs/remotes/trunk)
          .....
Compressing objects: 100% (10751/10751), done.
Writing objects: 100% (10886/10886), done.
Total 10886 (delta 9331), reused 0 (delta 0)
Checking out files: 100% (6002/6002), done.
Checked out HEAD:
   svn://server/aaa/AAA/trunk r27316
creating empty directory: lib/AAA/mp3gain/otherlang/help
=2E..
### No line with any branch. So it looks like I managed to get the trun=
k=20
but not the branches.


*Attempt 5:*
 > git svn init -T svn://server/aaa/AAA/trunk -b=20
svn://server/aaa/AAA/branches --username=3DUUU --no-minimize-url

Initialized empty Git repository in /home/.../.git/
svn-remote.svn.url already set: svn://server/aaa/AAA/trunk
wanted to set to: svn://server/aaa/AAA/branches
### My .git/config looks like:
[svn-remote "svn"]
         url =3D svn://server/aaa/AAA/trunk
         fetch =3D :refs/remotes/trunk
### If I try to add one of the branches manually:
branches =3D branches/XXX:refs/remotes/branches/XXX
 > git svn fetch
One '*' is needed in glob: 'branches/XXX'

*Attempt 6:*
 > git svn init -T svn://server/aaa/AAA/trunk -b=20
svn://server/aaa/AAA/branches --username=3DUUU --no-minimize-url

Initialized empty Git repository in /home/.../.git/
svn-remote.svn.url already set: svn://server/aaa/AAA/trunk
wanted to set to: svn://server/aaa/AAA/branches
### I put a glob instead of the branch name in git/.config:
branches =3D branches/{XXX,YYY}:refs/remotes/branches/*
 > git svn fetch
=2E..
Counting objects: 10886, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (10751/10751), done.
Writing objects: 100% (10886/10886), done.
Total 10886 (delta 9330), reused 0 (delta 0)
error: Untracked working tree file 'COPYRIGHT.txt' would be overwritten=
=20
by merge.
read-tree -m -u -v HEAD HEAD: command returned error: 128
### Only refs/remotes/trunk checked out. No branch.

At this point, I'm really lost and running out of ideas. If someone=20
could help me with this, I would be very grateful.

Please forgive me if I posted to the wrong mailing-list but I could not=
=20
find a specific git-svn list. If there is such thing, please point me i=
n=20
the right direction.

Thanks,

Antoine.

--=20
Antoine Bonavita (antoine@stickyadstv.com)
Envoy=E9 de mon PC. Moi je suis Fedora.
