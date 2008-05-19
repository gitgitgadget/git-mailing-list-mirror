From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Git GUI vs interactive post-commit hooks
Date: Mon, 19 May 2008 16:11:12 +0200
Message-ID: <20080519141112.GA12304@atjola.homenet>
References: <c6c947f60805190348g3395f8degae81963b402856b6@mail.gmail.com> <20080519131942.GA5526@atjola.homenet> <c6c947f60805190642x7d44ef04h4090cbb687de69e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Alexander Gladysh <agladysh@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 19 16:12:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jy65x-0006ek-9E
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 16:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757133AbYESOLQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 May 2008 10:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755593AbYESOLQ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 May 2008 10:11:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:41252 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754674AbYESOLP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2008 10:11:15 -0400
Received: (qmail invoked by alias); 19 May 2008 14:11:13 -0000
Received: from i577B8E25.versanet.de (EHLO atjola.local) [87.123.142.37]
  by mail.gmx.net (mp050) with SMTP; 19 May 2008 16:11:13 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1++hBRhFNG+NErImOyTdWWwdSdhMO6p0SNKm0KJsL
	QIXkdJ7kFw6i5Z
Content-Disposition: inline
In-Reply-To: <c6c947f60805190642x7d44ef04h4090cbb687de69e@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82429>

On 2008.05.19 17:42:05 +0400, Alexander Gladysh wrote:
> On Mon, May 19, 2008 at 5:19 PM, Bj=F6rn Steinbrink <B.Steinbrink@gmx=
=2Ede> wrote:
> > On 2008.05.19 14:48:14 +0400, Alexander Gladysh wrote:
> >> Hi, list!
> >>
> >> $ git --version
> >> git version 1.5.5.1
> >>
> >> I have a post-commit hook which does backups for me:
> >>
> >>   username=3Dagladysh
> >>   for name in `git branch | cut -b3-`
> >>   do
> >>     remote=3D$username-$name
> >>     echo pushing $name as $remote
> >>     git push backup +$name:refs/heads/$remote
> >>   done
> >
> > Isn't that what "git push --all" does? And that will only ask for a
> > password once, not for every branch.
>=20
> git push --all would not rename my branches... But, I guess, this can
> be done as preparation step somehow.

Oh, oops, didn't notice the $remote stuff, sorry.

> >> The backup repo is behind ssh. Recently I have put password on my =
ssh
> >> key and post-commit hook ask me for password once for each branch.
> >> This makes unhappy commit process from Git GUI -- after I shut it
> >> down, there are multiple ssh key password prompts in the shell fro=
m
> >> where I launched it, and it does not display any input I enter.
> >>
> >> Any advice? I do want to input password for my key each time I use=
 it.
> >
> > For a graphical tool, you might want to use something like
> > gtk-led-askpass, which shows a window with a password prompt. SSH w=
ill
> > make use of it if SSH_ASKPASS contains its path _and_ ssh is not st=
arted
> > from a terminal. Unfortunately, the latter is probably not true for=
 git
> > gui most of the time.
>=20
> <Useful advice regarding how to solve SSH_ASKPASS issue skipped.>
>=20
> Thanks, I would try that. I'm mostly working from X, so lack of X
> should be not an issue... However I'd like to avoid patching my local
> copy of git as much as possible. :-)

Well, the "lack of X" issue only arises if you patch your post-commit
hook. Adding setsid to the git push command was supposed to happen ther=
e
;-) You could probably even make that conditional, so that setsid is
only used then DISPLAY is set, then it should even work when there's no
X, but still be annoying when you commit from a terminal... (At least I
would prefer to enter the password in the terminal then).

Bj=F6rn
