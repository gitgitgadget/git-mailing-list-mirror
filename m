From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 19:11:31 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0705241908040.4648@racer.site>
References: <Pine.LNX.4.64.0705241039200.4648@racer.site>
 <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241201270.4648@racer.site> <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241230410.4648@racer.site> <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0705241315290.4648@racer.site>
 <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
 <7vabvuywix.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.98.0705241030440.26602@woody.linux-foundation.org>
 <20070524175519.GU942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>,
	Lars Hjemli <hjemli@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Martin Waitz <tali@admingilde.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 20:11:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrHml-0002TH-QO
	for gcvg-git@gmane.org; Thu, 24 May 2007 20:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbXEXSLf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 14:11:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbXEXSLf
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 14:11:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:41294 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750815AbXEXSLe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 14:11:34 -0400
Received: (qmail invoked by alias); 24 May 2007 18:11:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp030) with SMTP; 24 May 2007 20:11:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/fvJRk+GjfFLZUYblzL8Qyw+QOQ/icFq1wlxkgDN
	bY8te57R9aI69Z
X-X-Sender: gene099@racer.site
In-Reply-To: <20070524175519.GU942MdfPADPa@greensroom.kotnet.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48285>

Hi,

On Thu, 24 May 2007, Sven Verdoolaege wrote:

> On Thu, May 24, 2007 at 10:40:52AM -0700, Linus Torvalds wrote:
> > 
> > 
> > On Thu, 24 May 2007, Junio C Hamano wrote:
> > > 
> > > Why does this have to be out-of-tree and unversioned to begin
> > > with?
> > 
> > I _really_ think that the right approach is to
> > 
> >  - have the submodules information under version control (and I'd 
> >    personally call it the ".gitmodules" file, but whatever)
> > 
> >    This gives you the defaults, and the ability to change them. Remember: 
> >    if you get some "config" information at "git clone" time, you're 
> >    *screwed* if the thing ever changes!
> 
> If you allow an override, then I don't see how having the initial
> information in the tree is any better.

Isn't that obvious? _Most_ people will _not_ override the information.

Plus, it is an easy solution to your problem, without having to touch a 
lot of real core parts of Git. Simple is beautiful. And less buggy.

> When new information gets in from the tree, you're going to ignore it 
> anyway.

No. Not if it is _not_ overridden.

> What happens if the URL changes?
> You have to modify .gitmodules in _every_ branch you have?

Oh yes. Exactly the same as when you have an INSTALL file and the URL of 
some project changes which your project depends on. That's life.

> What if someone is working on his own branch of the superproject
> that needs some changes in his own subproject?

Uhm. Then you can either just override that URL, _or_ you can branch from 
the superproject, changing .gitmodules as you wish.

> He needs to modify .gitmodules, but when the changes go upstream,
> this .gitmodules changes get merged as well.

If you change the superproject, that is. And then only if you don't have a 
to-merge branch. Your problem is not specific to superprojects, and it has 
been solved already.

> Now imagine several developers doing this.
> You end up continually having to modify .gitmodules.

No, just your config. Once.

Ciao,
Dscho
