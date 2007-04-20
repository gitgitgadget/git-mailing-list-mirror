From: Jan Harkes <jaharkes@cs.cmu.edu>
Subject: Re: History cleanup/rewriting script for git
Date: Fri, 20 Apr 2007 16:36:22 -0400
Message-ID: <20070420203622.GA31546@delft.aura.cs.cmu.edu>
References: <8b65902a0704170841q64fe0828mdefe78963394a616@mail.gmail.com> <200704171818.28256.andyparkins@gmail.com> <20070417173007.GV2229@spearce.org> <462521C7.2050103@softax.com.pl> <Pine.LNX.4.64.0704181130150.12094@racer.site> <alpine.LFD.0.98.0704180851060.2828@woody.linux-foundation.org> <Pine.LNX.4.64.0704191118050.8822@racer.site> <alpine.LFD.0.98.0704190940330.9964@woody.linux-foundation.org> <20070420155446.GA11506@delft.aura.cs.cmu.edu> <Pine.LNX.4.64.0704202037140.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Apr 20 22:37:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HezrT-0003gY-SR
	for gcvg-git@gmane.org; Fri, 20 Apr 2007 22:37:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767258AbXDTUgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 16:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767255AbXDTUgd
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 16:36:33 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:51637 "EHLO
	delft.aura.cs.cmu.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767246AbXDTUg2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2007 16:36:28 -0400
Received: from jaharkes by delft.aura.cs.cmu.edu with local (Exim 4.63)
	(envelope-from <jaharkes@cs.cmu.edu>)
	id 1HezqA-0000Jv-L4; Fri, 20 Apr 2007 16:36:22 -0400
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0704202037140.8822@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45130>

On Fri, Apr 20, 2007 at 08:39:25PM +0200, Johannes Schindelin wrote:
> On Fri, 20 Apr 2007, Jan Harkes wrote:
> > On Thu, Apr 19, 2007 at 09:43:50AM -0700, Linus Torvalds wrote:
> > > On Thu, 19 Apr 2007, Johannes Schindelin wrote:
> > >
> > > > Hmm. However, I have to say that cogito serves/d another purpose 
> > > > quite well: Look at what came from cogito into git. Loads of useful 
> > > > enhancements. So, I really have to point to "at this stage", because 
> > > > that sure was not true 18 months ago.
> > > 
> > > Absolutely. I think there are still some pieces of cogito that we 
> > > might want to migrate into git too, although they're fairly esoteric 
> > > (ie the whole history rewriting thing). And I think we still have some 
> > > places
> > 
> > I actually have a fairly simple history rewriting script (written in 
> > python) that I used when I converted some CVS archives to git.
> 
> Telling by your description, cg-admin-rewrite-hist is more capable. And I 
> think it should not be too complicated to rewrite the cogito specific 
> parts, what with the parts we added to Git with cogito as a model. And it 
> is in Perl... which makes it more portable than Python in my part of the 
> world.

As I wrote this a while ago, before reflogs and packed refs, and I only
needed it for the initial conversion, it only had to write out new
commit objects and retarget branch heads and simple tags. If
cg-admin-rewrite-hist can do better and can be merged into git-core I
would say that is a win-win situation for everyone.

Something like this should be available to allow people to reconstruct
their merge history or fix up empty 'file was added on branch foo'
commits that are left around after the initial import from another VCS.

Personally, I don't think it should ever be used for any published
repositories or branches. Most fixups before publishing can already be
done by rebasing or amending a commit, so this would only be useful for
that intial import where there are in fact a lot of scattered changes
all over the place, or to reconstruct a merge that went bad. But really
in that case, it is probably better to redo the merge correctly and
rebase any commits that might have gone in after the bad merge.

Jan
