From: Ryan Anderson <ryan@michonline.com>
Subject: Re: : Networking
Date: Wed, 27 Apr 2005 23:55:34 -0400
Message-ID: <20050428035534.GB30308@mythryan2.michonline.com>
References: <Pine.LNX.4.58.0504261310120.18901@ppc970.osdl.org> <Pine.LNX.4.44.0504261332540.4678-100000@wax.eds.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	pasky@ucw.cz, davem@davemloft.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 05:50:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DR03A-0002BG-G8
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 05:50:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbVD1D4S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 23:56:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVD1D4S
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 23:56:18 -0400
Received: from mail.autoweb.net ([198.172.237.26]:26754 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S261901AbVD1D4G (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 23:56:06 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DR07j-00069H-4P; Wed, 27 Apr 2005 23:55:35 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DR08v-0001T7-00; Wed, 27 Apr 2005 23:56:49 -0400
Received: from ryan by mythical with local (Exim 4.50)
	id 1DR07i-0002DR-H7; Wed, 27 Apr 2005 23:55:34 -0400
To: Bram Cohen <bram@bitconjurer.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0504261332540.4678-100000@wax.eds.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 26, 2005 at 01:35:55PM -0700, Bram Cohen wrote:
> Linus Torvalds wrote:
> 
> > On Tue, 26 Apr 2005, Andrew Morton wrote:
> > >
> > > With bk I was resolving that by just smashing the patches on top of each
> > > other, ignoring the rejects and refreshing the topmost patch.  That
> > > approach actually resolved this linus-vs-davem dupe as well.
> >
> > Oh, wow. I didn't realize that your scripts were quite _that_ stupid, and
> > didn't actually take advantage of any automatic merges at all.
> >
> > If so, git should trivially do everything that BK ever did for you. Which
> > is not saying a lot ;)
> 
> No version control system will do a particularly good job of merging
> content which got passed around outside of the system. They can be made to
> sort-of handle some simple cases well, but fundamentally too much
> information is getting dropped.

One thing to keep in mind, about the way Linux development works (and
honestly, the way I think "git" development is currently working) is
that one of the things the version control system has to provide an easy
method to do is to abandon history that is messy.

For example, I'm adding a new driver, "foobar".

It uses the fancy quantum-bus, which is fairly new to the kernel.
The bus driver is new, and I go off, work in my private tree for a
month, fixing all kinds of quantum-entanglement related bugs, and
committing as I go.

I get everything working, and submit my driver.

The quantum-bus maintainer replies and says, "Hey, I reworked the API so
that you don't need to worry about all this quantum-entanglement stuff
anymore, just call compensate_for_heisenberg() before doing the DMA."

I swear for a day or two, and rework my driver, and resubmit it.

Now, all that history I had, with the duplicated imlementation, and
useless code is in my tree.

The current (as I understand it) policy is, "We don't want that
history."  This means that the developer will build a new tree (maybe),
export his patch and reimport it into a clean tree, making a much
simpler history graph.

What Andrew is doing isn't too far from this, in concept, it's just a
lot more complicated because he's pulling something insane, like 27
seperate trees, plus several hundred stand alone patches.

So, there's a *deliberate* desire to drop history and move some content
around outside of version control.

Now, the desire to pull a bunch of seperate trees, merge them, produce a
diff that roughly pertains to what came in from each tree, and collect
that as a patch series may be strange, but it seems to be working really
well at the moment, for Linux development.

> The solution is to get everyone using the same version control system,
> which is actually quite a workable solution if (a) the version control
> system in question is quite nice, and (b) there isn't some deep political
> reason why many people will never agree to use it.

Git (well, cogito, really) seems to be getting there awfully fast - I'm
rather impressed with the speed of it, and annoyed that I haven't had
the time to build up a test suite for merging!


-- 

Ryan Anderson
  sometimes Pug Majere
