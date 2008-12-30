From: "Zorba" <cr@altmore.co.uk>
Subject: Re: for newbs = little exercise / tutorial / warmup for windows and other non-sophisticated new Git users :-)
Date: Tue, 30 Dec 2008 12:19:54 -0000
Message-ID: <gjd3lp$f1d$4@ger.gmane.org>
References: <gj68a0$u56$3@ger.gmane.org> <gj6kqq$nvh$4@ger.gmane.org> <3ab397d0812291505v77824e6fvdecebc80f38a5f89@mail.gmail.com> <gjc7qa$jdj$4@ger.gmane.org> <3ab397d0812292133r7955e892g6c19ca46629e7103@mail.gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 30 13:21:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHdbV-0008SK-EK
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 13:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810AbYL3MUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 07:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751780AbYL3MUY
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 07:20:24 -0500
Received: from main.gmane.org ([80.91.229.2]:52423 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755AbYL3MUY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 07:20:24 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LHda7-0000Ue-6p
	for git@vger.kernel.org; Tue, 30 Dec 2008 12:20:19 +0000
Received: from 81.135.227.136 ([81.135.227.136])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 12:20:19 +0000
Received: from cr by 81.135.227.136 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 30 Dec 2008 12:20:19 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 81.135.227.136
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2900.5512
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5512
X-RFC2646: Format=Flowed; Original
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104178>

> I have been using $ git reset --hard <version> as an escalator to ascend /
> descend the versions up and down

you should probably be using git checkout for this

> Surely it doesn't alter the history, as I can commit versionA, versionB,
> versionC, and then reset to A, then reset to C, then reset to B.

i does alter the history.  i think this works because git isnt'
deleting the actual blob objects in the git dir until you use the git
prune, or gc or whatever (i never use it anyway).  but, you are
altering history, and just happen to be recovering.

** Ok!, so after commit B1, versionA doesn't store a link to versionB 
natively on and of its own accord. In other words BA and C are now written 
OUT of the history, as you say. I'm relying on some cached meta data that 
allows me to go back up the version tree again (ie downstream) and write B 
and/or C back into the history, which I should not rely on having access to 
all the time. Now I'm understanding more about differences between git-reset 
and git-checkout

> so when I reset to A, I've still got the ability to get to B or C again

with an uneasy conscience ;)

** yes, if the metadata cache failed or got wiped, I'd be screwed for 
getting back to later commits
I see !
I'm relying on something that isn't part of the intrinsic design... hmmm

> Now I appreciate that if I commit a new change from versionA (lets call it
> B1), then HEAD is now at B1, and B, C etc are lost, correct ?

yes! but this is not true if you had done a git checkout (there are
measures to recover B and C, provided you haven't done a prune.  i
think git reflog has some answers here, but i'm still a newbie).

> Its pertinent to where I am right now, as I've goofed a commit, and want 
> to
> reset, and commit again but I'm worried about leaveing garbage lying 
> around
> (the commits for version B and C in the example above).

you've goofed what commit (a1?, c?, d3?)?  where are you now and what
do you want to do now? reset to what version?  if you're just worried
about space used by B and C, i think git prune will purge these (look
at man page, don't guess at the syntax).

** I goofed B, so I reset to A, and redid the edits correctly this time 
(using your tip from other post $ git add -A = thanks again!), so now am on 
B1.
Having read your notes, I am now comfortable about letting B and C hang 
around, as I realise now they are out of the official picture. Sitaram's 
comparison of a linked list helps since there is no branch/merge: B1 can 
only have one parent, which is A, so A can only have one child which is B1 
(and B and C are relying on the cached stuff to survive, so let 'em freeze 
!)

i half suspect that you want to git branch at some point, but if
yo'ure just recretaing the other code bases' history form other files,
you shouldn't be able to break too much by git reset --hard, or git
prune.

** yes I might well want to at some point, but don't want to run before 
walking. I'm the only one on this project currently, and still archiving old 
versions into git. When I get the latest one in, I may branch so I can work 
away without affecting a stable master branch.
