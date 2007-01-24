From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Deleting remote branches with git-branch and reflog questions
Date: Wed, 24 Jan 2007 10:58:19 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241054330.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701231259.27719.andyparkins@gmail.com> <45B6076F.5060503@op5.se>
 <200701231314.53361.andyparkins@gmail.com> <7v1wllo2p6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701231649520.3011@xanadu.home> <7vbqkpkxhk.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0701232103290.3011@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 10:58:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9etd-0006j9-4c
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 10:58:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbXAXJ6V (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 04:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750922AbXAXJ6V
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 04:58:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:33754 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750910AbXAXJ6V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 04:58:21 -0500
Received: (qmail invoked by alias); 24 Jan 2007 09:58:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp014) with SMTP; 24 Jan 2007 10:58:19 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0701232103290.3011@xanadu.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37617>

Hi,

On Tue, 23 Jan 2007, Nicolas Pitre wrote:

> On Tue, 23 Jan 2007, Junio C Hamano wrote:
> 
> > Nicolas Pitre <nico@cam.org> writes:
> > 
> > > On Tue, 23 Jan 2007, Junio C Hamano wrote:
> > >
> > >> And we might want to allow reflogs on detached HEAD someday,
> > >> although I personally think it goes against what detached HEAD
> > >> is -- it is of a very temporary nature.
> > >
> > > Didn't we agree already that reflog with detached head was simply 
> > > insane?
> > 
> > Perhaps, perhaps not.
> > 
> > 	$ git checkout v2.6.14
> >         $ git checkout v2.6.15
> >         $ git checkout v2.6.16
> > 
> > Ah, which one did I check-out the last time?
> > 
> > 	$ git describe HEAD@{1}
> 
> And what does HEAD@{1} means if not detached?
> 
> If there is a reflog for HEAD independently of what branch HEAD is 
> attached to then it could make sense.  Meaning that if you're on branch 
> "master" and perform a commit, then both reflogs for "master" and "HEAD" 
> are updated at the same time.  If you then checkout branch "next" then 
> only the "HEAD" reflog is updated since no changes to any branch did 
> occur but just HEAD changed.
> 
> Then moving around and/or committing with a detached head would just 
> update the "HEAD reflog.

This would also be my idea. I agree with you that mixing approaches like 
Jakub proposed is insane.

But given the idea of reflogs ("Where was this yesterday"), I think it 
would make sense to reflog HEAD -- independent on which branch it happens 
to refer to.

Warning! It _changes_ the behaviour. As of now, "git log --walk-reflogs 
HEAD" shows the local view of the _branch_ that HEAD points to 
_currently_. But I think that the current is difficult to explain to new 
users, whereas the "jumping HEAD" is not.

Ciao,
Dscho
