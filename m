From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revision walker: Fix --boundary when limited
Date: Tue, 6 Mar 2007 02:44:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703060242130.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
 <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703051130090.3998@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703051145210.3998@woody.linux-foundation.org>
 <7vejo3xuq9.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703060137210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vd53nupg9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Mar 06 02:44:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOOjG-0006fy-Iu
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 02:44:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933817AbXCFBoc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 20:44:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933820AbXCFBob
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 20:44:31 -0500
Received: from mail.gmx.net ([213.165.64.20]:50740 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933817AbXCFBoa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 20:44:30 -0500
Received: (qmail invoked by alias); 06 Mar 2007 01:44:28 -0000
X-Provags-ID: V01U2FsdGVkX194yQkIi0J4YY1okuiBwDUZrvUSRKQYmt9YmVu0OQ
	b1cS5MoiELHZ9w
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vd53nupg9.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41524>

Hi,

On Mon, 5 Mar 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> +	if (revs->reverse) {
> >> +		l = NULL;
> >> +		while ((c = get_revision_1(revs)))
> >> +			commit_list_insert(c, &l);
> >> +		revs->commits = l;
> >> +		revs->reverse = 0;
> >>  	}
> >
> > Clever!
> 
> It is not clever, but just is stupid and WRONG.  It just shows
> how little I care about --reverse ;-).
> 
> revision_1() is to get the full list without non limit limiters,
> so the above loop would not even deplete the max_count but
> literally grabs everything.

Oops. I missed the _1(), _and_ the missing "revs->reverse = 0"...

> >> +	for (l = c->parents; l; l = l->next) {
> >
> > AFAICT this changes behaviour: c->parents were possibly rewritten.
> 
> Well, the behaviour of max with boundary in 'master' did the same thing, 
> as what was in revs->commits are rewritten parents of commits we already 
> returned, didn't it?

I missed that, too. Maybe I should get more familiar with the revision 
walker first, before continuing to ask for ridicule.

Ciao,
Dscho
