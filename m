From: Kirill Likhodedov <Kirill.Likhodedov@jetbrains.com>
Subject: Re: Git commit error: fatal: Repository has been updated, but unable to write new_index file.
Date: Tue, 27 Mar 2012 18:28:14 +0400
Message-ID: <8646D039-536E-4E6B-9D9B-01E0FB8D1C69@jetbrains.com>
References: <34E530A4-A792-42AC-8C19-5F7CB71FA46C@jetbrains.com> <20120327083625.GA4159@ikke-laptop.buyways.nl>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kevin <compufreak@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 27 16:28:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCXNn-0005WQ-Dq
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 16:28:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001Ab2C0O2S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Mar 2012 10:28:18 -0400
Received: from mail1.intellij.net ([46.137.178.215]:34724 "EHLO
	mail1.intellij.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750977Ab2C0O2S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Mar 2012 10:28:18 -0400
Received: (qmail 9244 invoked by uid 89); 27 Mar 2012 14:28:15 -0000
Received: by simscan 1.1.0 ppid: 9195, pid: 9234, t: 0.1103s
         scanners: regex: 1.1.0 clamav: 0.97/m:53/d:13443
Received: from unknown (HELO loki.labs.intellij.net) (Kirill.Likhodedov@jetbrains.com@195.5.138.42)
  by ip-10-48-137-145.eu-west-1.compute.internal with ESMTPA; 27 Mar 2012 14:28:15 -0000
In-Reply-To: <20120327083625.GA4159@ikke-laptop.buyways.nl>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194045>


27.03.2012, =D7 12:36, Kevin:

> This might look like some kind of race condition where multiple comma=
nds
> are executed at the same time, causing the lock file to be hold.
>=20
> Could you check if something like that is happening somewhere?

I thought about it, but we've got a software lock that prevents such a =
collision, and it seems to work pretty good: we've never had lock probl=
ems in any other cases, and in this case the problem also seems to be q=
uite rare - it is experienced only by a few of users, although rather f=
requently.
Moreover, there are no parallel Git activities in this case anyway, onl=
y git add followed by git commit.

Btw, lock-conflicting errors are usually reported by Git as=20
fatal: Unable to create 'project_path/.git/index.lock': File exists.


>=20
> On Tue, Mar 27, 2012 at 11:35:08AM +0400, Kirill Likhodedov wrote:
>>=20
>> Reposting, since there were no replies - probably, the message was m=
issed.
>> I would appreciate help in understanding what the Git error could be=
 cause by.
>> Thanks!
>>=20
>> -------
>>=20
>> Hello,
>>=20
>> I'm developing a Git integration with an IDE. Several users of the p=
rogram report the following error which was returned by Git during comm=
it:
>>=20
>> fatal: Repository has been updated, but unable to write
>> new_index file. Check that disk is not full or quota is
>> not exceeded, and then "git reset HEAD" to recover.
>>=20
>> Here is the command which IDE executes to make a commit:=20
>>=20
>> # git commit --only -F <message file> -- <several files chosen to co=
mmit>
>>=20
>> The interesting thing is that commit was actually successful, i.e. a=
ll files are committed, git status reports correctly, no other mistakes=
 were noticed by users.
>> Here is the bugreport with some more details: http://youtrack.jetbra=
ins.com/issue/IDEA-82108
>> One of the users says, that the situation happens quite often.
>>=20
>> Users say that the thing has never happened with them while they wer=
e using Tortoise Git, so I'm pretty sure, that it is my bug caused my s=
ome misusage of Git (although I asked users to perform more experiments=
).
>>=20
>> Unfortunately, I didn't find any information about the possible caus=
e of this error.
>>=20
>> Could you please help me to figure out why it can happen? What situa=
tion can lead to this error?
>>=20
>> Thanks a lot.
>>=20
>> ----------------------------------
>> Kirill Likhodedov
>> JetBrains, Inc
>> http://www.jetbrains.com
>> "Develop with pleasure!"
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
