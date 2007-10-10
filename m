From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git branch performance problem?
Date: Wed, 10 Oct 2007 22:53:29 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710102251230.4174@racer.site>
References: <f329bf540710101322xdea6210x5576779f2efd89b7@mail.gmail.com> 
 <8c5c35580710101344t3aed4214h4f999072483c4cb5@mail.gmail.com> 
 <f329bf540710101417w640b2421v73279cc8e34449b8@mail.gmail.com> 
 <f329bf540710101424q22309489sada99907e94b2cd0@mail.gmail.com> 
 <f329bf540710101430i63926b25q7d55976af96b891d@mail.gmail.com> 
 <20071010213925.GB2963@fieldses.org>  <8c5c35580710101445h232f9a67jd0c326b3b97ae3dd@mail.gmail.com>
 <f329bf540710101449oad9c9dg85f3821f55fb85ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Lars Hjemli <hjemli@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Wed Oct 10 23:54:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfjVE-0005Hk-Nn
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 23:54:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbXJJVxw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 17:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759049AbXJJVxv
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 17:53:51 -0400
Received: from mail.gmx.net ([213.165.64.20]:56318 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759044AbXJJVxu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 17:53:50 -0400
Received: (qmail invoked by alias); 10 Oct 2007 21:53:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 10 Oct 2007 23:53:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ufWhbu7vuvRKNgmC/w9r4soj7pcPxAaXi8VbVDK
	idQl4bjN63aAu5
X-X-Sender: gene099@racer.site
In-Reply-To: <f329bf540710101449oad9c9dg85f3821f55fb85ea@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60556>

Hi,

On Wed, 10 Oct 2007, Han-Wen Nienhuys wrote:

> 2007/10/10, Lars Hjemli <hjemli@gmail.com>:
> > On 10/10/07, J. Bruce Fields <bfields@fieldses.org> wrote:
> > > On Wed, Oct 10, 2007 at 06:30:02PM -0300, Han-Wen Nienhuys wrote:
> > > > could it be that GC does not handle cyclic alternates correctly?
> > >
> > > Does it handle alternates at all?  If you run git-gc on a repository 
> > > which other repositories get objects from, then my impression was 
> > > that bad things happen.
> > >
> >
> > AFAIK 'git gc' is safe, while 'git gc --prune' will remove loose
> > (unreferenced) objects.
> 
> Yes, I think that in this case, gc --prune was run accidentally, but
> given that the history of the program invoking git just died, I'm not
> sure how to figure that out.
> 
> Maybe gc --prune could follow the alternates and abort if a cycle was 
> detected?

I think we talked about this quite some time ago, and the resolution was 
that it is too hard.

Now that it bit somebody in real life, I think we have to try harder.

And probably the best place to check would be git-prune, not git-gc, since 
that is the program (called by gc) that most probably killed your repo.

Come to think of it, it should probably be part of git-repack, too.

Will try to cobble up a patch,
Dscho
