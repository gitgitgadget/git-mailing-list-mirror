From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Do not call git-rev-list from git-fetch-pack
Date: Fri, 21 Oct 2005 16:25:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0510211618420.25300@iabervon.org>
References: <Pine.LNX.4.63.0510210413210.26388@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virvrw8w1.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0510211111440.4950@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 22:28:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET3Sq-000763-2i
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 22:26:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965145AbVJUU0A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 16:26:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965149AbVJUU0A
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 16:26:00 -0400
Received: from iabervon.org ([66.92.72.58]:55058 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965145AbVJUUZ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 Oct 2005 16:25:59 -0400
Received: (qmail 20465 invoked by uid 1000); 21 Oct 2005 16:25:20 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Oct 2005 16:25:20 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0510211111440.4950@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10445>

On Fri, 21 Oct 2005, Johannes Schindelin wrote:

> Hi,
> 
> On Fri, 21 Oct 2005, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > +	   Branch1 has 40 commits since it last merged with branch2,
> > > +	   and branch2 has 2 more commits since then.
> > > +
> > > +	   On the other end, branch1 is up-to-date, but branch2 is not.
> > > +	   When fetching branch1, the 40 commits get sent, the first
> > > +	   is acknowledged as common, and the local head of branch2
> > > +	   never gets sent.
> > > +
> > > +	   As a consequence, the whole history of branch2
> > > +	   (git-rev-list branch2 ^branch1) gets packed and transmitted.
> > 
> > Arrrgggggggh.  The description above captures the essense of the
> > problem very well, but faking dates and still popping by recency
> > looks like a really ugly hack to me.
> 
> It is ugly. But it is a good heuristic. And the code is simple, because I 
> could use the existing functions for inserting into a commit_list.

The existing functions aren't really very complicated. You could easily 
separate out the pop and the adding of parents, and go first through a 
list of tips and then through the date-sorted list of ancestors. And I 
think that separation would be useful for some changes Linus was making to 
rev-list recently.

	-Daniel
*This .sig left intentionally blank*
