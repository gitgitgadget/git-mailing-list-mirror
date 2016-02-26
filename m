From: Seb <spluque@gmail.com>
Subject: Re: interactive rebase results across shared histories
Date: Fri, 26 Feb 2016 15:12:46 -0600
Organization: Church of Emacs
Message-ID: <87povj41m9.fsf@gmail.com>
References: <87io1j6laz.fsf@gmail.com> <56C91D21.90306@moritzneeb.de>
	<87io1f5nsi.fsf@gmail.com> <56CCE3C2.1050608@moritzneeb.de>
	<87egc358ou.fsf@gmail.com>
	<CAMPXz=on8ONkzDYWEEGFqqKhRoBb9zYBqmYDBsKWagdwFRPRdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 22:13:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZPhS-0000eq-5f
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 22:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754061AbcBZVNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 16:13:18 -0500
Received: from plane.gmane.org ([80.91.229.3]:54863 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbcBZVNR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 16:13:17 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1aZPhL-0000b7-Ll
	for git@vger.kernel.org; Fri, 26 Feb 2016 22:13:15 +0100
Received: from s0106503955564c1f.wp.shawcable.net ([24.77.8.70])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:13:15 +0100
Received: from spluque by s0106503955564c1f.wp.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 22:13:15 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: s0106503955564c1f.wp.shawcable.net
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
Cancel-Lock: sha1:QcaX8eqqmt5/rxghlNySAPXvf4U=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287623>

On Fri, 26 Feb 2016 23:38:38 +1100,
David <bouncingcats@gmail.com> wrote:

> On 24 February 2016 at 10:05, Seb <spluque@gmail.com> wrote:
>> On Tue, 23 Feb 2016 23:57:06 +0100,
>> Moritz Neeb <lists@moritzneeb.de> wrote:

>> [...]

>>>> OK, I've followed this advice and looked at the dependency graphs
>>>> in gitk before and after rebasing, I've managed to obtain what I
>>>> was after.  The repository now has two branches: master and topic.
>>>> However, Gitk reveals a problem with a string of commits that are
>>>> not part of any branch:

>>>> A---B---H---I (master) \ C---D---E (loose string of commits) \
>>>> D'---E'---F---G (topic)

>>>> How do I remove these loose commits (C, D, E)?


>>> what you might be after is "git gc". But I never used it, it was not
>>> neccesary for me. I would let the automatic garbage collection drop
>>> my dangling commits. It's safer - who knows when you will still want
>>> to restore your recent "loose string of commits".

>>> How exactly are the loose commits causing trouble?

>> Sure enough, these dangling commits were removed automatically
>> without any intervention.  All is good.

> This discussion could end there without problem. But if you want to
> understand a little more thoroughly, read on ...

Thanks David, I appreciate the insight.  Indeed, I've learnt a lot over
the last few days with help in this thread as I confronted a lurking
problem after many years neglecting it.  Briefly, long ago I was
developing a project in RCS, then on CVS and SVN, until some years ago I
imported it into git via cvs2svn.  I had turned a blind eye to a bit of
mess up to the very early releases, likely due to my inexperience but
also differences between VCS.

After cleaning up all the mess, I've ended up with a long master branch,
and a series of earlier commits that are not reachable from master.
Fortunately, the tags have kept them alive. This is the scenario
simplified:

A---C---D(tag2)                 loose commits (not on any branch)
 \
  B(tag1)

E---F---G---H---*               (master)

I could put the "loose" (but tagged) commits on a branch at "tag2", but
I hate that "tag1" shows as a twig there...  It would be nice to have
all the history reachable from master.  So two questions I'm working on
right now: 1) how to bring "tag1" into the "tag2" chain of commits, and
then 2) how to tie it all together into master so that it reads
linearly.

-- 
Seb
