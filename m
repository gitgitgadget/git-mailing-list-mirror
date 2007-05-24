From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Thu, 24 May 2007 10:38:46 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241038030.4648@racer.site>
References: <46528A48.9050903@gmail.com> <7v7iqz19d2.fsf@assigned-by-dhcp.cox.net>
 <56b7f5510705231655o589de801w88adc1aa6c18162b@mail.gmail.com>
 <7vps4ryp02.fsf@assigned-by-dhcp.cox.net> <20070524071235.GL28023@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu May 24 11:38:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr9mV-0003Kg-QS
	for gcvg-git@gmane.org; Thu, 24 May 2007 11:38:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755254AbXEXJiu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 05:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755459AbXEXJiu
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 05:38:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:45682 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755254AbXEXJit (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 05:38:49 -0400
Received: (qmail invoked by alias); 24 May 2007 09:38:47 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp027) with SMTP; 24 May 2007 11:38:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SWU5+cqjSDStepxBgnshQUHM+1bNdb+FhhFvOME
	a89ffyL3NK6VmR
X-X-Sender: gene099@racer.site
In-Reply-To: <20070524071235.GL28023@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48239>

Hi,

On Thu, 24 May 2007, Shawn O. Pearce wrote:

> Junio C Hamano <junkio@cox.net> wrote:
> > "Dana How" <danahow@gmail.com> writes:
> > 
> > > The packed X too big combination is the problem.  As the
> > > commit message says,  this could happen if the packs
> > > came from fast-import,...
> > > We have three options in this case:
> > > (1) Drop the object (do not put it in the new pack(s)).
> > > (2) Pass the object into the new pack(s).
> > > (3) Write out the object as a new loose object.
> > >
> > > Option (1) is unacceptable.  When you call git-repack -a,
> > > it blindly deletes all the non-kept packs at the end.  So
> > > the megablobs would be lost.
> > 
> > Ok, I can buy that -- (1) nor (2) are unacceptable and (3) is
> > the only sane thing to do for a previously packed objects that
> > exceed the size limit.
> 
> I still don't buy the idea that these megablobs shouldn't be packed.
> I understand Dana's pain here (at least a little bit, my problems
> aren't as bad as his are), but I also hate to see us run away from
> packfiles for these really sick cases just because we have some
> issues in our current packfile handling.

Isn't this issue helpable by the "-delta" attribute?

Ciao,
Dscho
