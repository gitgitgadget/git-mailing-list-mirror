From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: git fetch vs push, git am questions
Date: Thu, 9 Dec 2010 16:57:11 +0300
Message-ID: <20101209165711.9cca1f28.kostix@domain007.com>
References: <99351291667275@web152.yandex.ru>
	<20101207002104.GG3264@localhost.localdomain>
	<60371291725083@web106.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Konstantin Kivi <kkivi@yandex.ru>
X-From: git-owner@vger.kernel.org Thu Dec 09 14:57:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQgzo-0005hy-MH
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 14:57:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756878Ab0LIN5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Dec 2010 08:57:15 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:38735 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755341Ab0LIN5P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 08:57:15 -0500
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id oB9DvB9A016716;
	Thu, 9 Dec 2010 16:57:12 +0300
In-Reply-To: <60371291725083@web106.yandex.ru>
X-Mailer: Sylpheed 3.0.0 (GTK+ 2.10.14; i686-pc-mingw32)
X-Scanned-By: MIMEDefang 2.51 (www.roaringpenguin.com/mimedefang) on 192.168.2.20
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163284>

On Tue, 07 Dec 2010 15:31:23 +0300
Konstantin Kivi <kkivi@yandex.ru> wrote:

>>  `git pull` does exactly that: fetch + merge (which should result in
>>  fast-forward in your case).
> pull does not work on bare repos.
Then the only way to update any branch after fetching I can think of
is using `git update-ref` and the information from FETCH_HEAD.

>>> I also found that there is a notions of current branch in bare
>>> repository
>>> =9AHow can I change current branch in bare repositry?
> I think I will understand things better if I get what is 'current
> branch' for bare repository and how to change it
>>  By re-writing the HEAD ref (this behaviour is documented in the
>> man page of the `git clone` command, see the "--branch" option for
>> instance).
> The repository already exists, so git-clone  will not help
I did not propose to use git-clone, I just stated which section of
which manual page hints at what is considered to be the current branch
in a bare repository when Git clones it.

>>  You can use the `git symbolic-ref` to update the HEAD ref.
> Do you mean something like=20
> git symbolic-ref  master origin/master ?
Something like
git symbolic-ref HEAD refs/heads/master

P.S.
I also wonder how did you manage to get origin/master in a bare
repository. When I `git clone --bare` an existing Git repository,
I get one branch named "master" (or whatever branch was current in the
source repository), and in the `git clone` manual page we see:

 --bare
   Make a bare GIT repository. That is, instead of creating
 <directory> and placing the administrative files in <directory>/.git,
 make the <directory> itself the $GIT_DIR. This obviously implies the -=
n
 because there is nowhere to check out the working tree. Also the branc=
h
 heads at the remote are copied directly to corresponding local branch
 heads, without mapping them to refs/remotes/origin/. When this option
 is used, neither remote-tracking branches nor the related configuratio=
n
 variables are created.

Which describes the behaviour I see. So it seems you have somehow
botched setup. Like you took a non-bare repository and just copied its
".git" subdirectory somewhere pretending it's now a bare repo.
