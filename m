From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 2 Aug 2007 16:23:38 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708021614420.14781@racer.site>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
 <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site>
 <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site>
 <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site>
 <46B1F3F4.5030504@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-1?Q?Jean-Fran=E7ois_Veillette?= 
	<jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 17:24:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGcXA-0003IZ-U7
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 17:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbXHBPYL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 11:24:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbXHBPYK
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 11:24:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:59764 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751124AbXHBPYH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 11:24:07 -0400
Received: (qmail invoked by alias); 02 Aug 2007 15:24:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp056) with SMTP; 02 Aug 2007 17:24:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+MHcskuEWMecApxkFdjOO3oNzSFf/aKdOGsgEiIz
	EaKxkqatttSSZu
X-X-Sender: gene099@racer.site
In-Reply-To: <46B1F3F4.5030504@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54561>

Hi,

On Thu, 2 Aug 2007, Steven Grimm wrote:

> Johannes Schindelin wrote:
> > This use case has not much to do with new users.  A new user _has_ to know
> > that updating all files, even if their content does not change, is not
> > right.
> >   
> 
> Someone who has used, say, Subversion might have a perfectly reasonable
> expectation that "git diff" will show differences in content, and when there
> are no differences in content, will not mention a file at all. Other version
> control systems have "diff" commands that ignore touched files.
> 
> I admit I also thought the empty diffs were a bug (albeit a minor one not
> worth making noise about) until this thread. Now I understand why it happens,
> though I still think we'd be better off just not displaying the filename in
> git-diff until we know there's an actual diff to display.
> 
> I certainly don't think the "it's a feature: it reminds you when you've edited
> a file without changing it" argument holds any water at all. If that were
> truly the intent, if we truly considered that to be useful information a
> developer would want to get at after the fact, then why would git-status throw
> away that information?

Okay, I'll answer just this one, instead of pointing you to the thread 
that I've been pointing to twice now (because your ideas about how 
git should work are usually similar to mine, and by way of saying thanks 
for your contributions):

When is the time to say "git status"?

It is just before committing.  I.e when you really think that you're done 
editing, and want to have the end picture.  "git status" only gives you 
names, and therefore it _has_ to update the index if it got out of sync, 
to show meaningful results.

When is the time to say "git diff"?

Much more often.  In the middle of your work.  And there it would be 
_disruptive_ if it updated the index all the time, especially if you have 
a quite large working tree.

But then, normal users do not touch all the files.  They don't.

So I doubt that in the common case the subject we are discussing matters 
at all.

Yes, "perl -pi" is something I used myself.  Yes, I think it is a bug that 
it writes new files when it does not really change anything.  And yes, I 
had a script lying somewhere on my backup hard disk which uses some evil 
"git diff --name-only | xargs bla" mantra (it does not even use the 
--quiet option, since that was not invented back then) to actually _undo_ 
the effects by setting the timestamps back, since the full compilation 
time in that project _hurt_.

But it is hardly an operation that I use daily.  Hardly even twice a 
year.

Ciao,
Dscho
