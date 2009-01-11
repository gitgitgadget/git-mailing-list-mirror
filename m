From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: current git kernel has strange problems during bisect
Date: Sun, 11 Jan 2009 23:32:15 +0100
Message-ID: <20090111223215.GA6296@uranus.ravnborg.org>
References: <200901111602.53082.borntraeger@de.ibm.com> <200901111607.59054.borntraeger@de.ibm.com> <alpine.DEB.1.00.0901111613250.3586@pacific.mpi-cbg.de> <200901111620.03345.borntraeger@de.ibm.com> <alpine.LFD.2.00.0901111113150.6528@localhost.localdomain> <20090111194258.GA4840@uranus.ravnborg.org> <alpine.LFD.2.00.0901111200330.6528@localhost.localdomain> <f19298770901111417t6762e1e3x79b2f488ee6f1243@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Alexey Zaytsev <alexey.zaytsev@gmail.com>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755094AbZAKWas@vger.kernel.org Sun Jan 11 23:32:16 2009
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755094AbZAKWas@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LM8qt-0007Ma-4X
	for glk-linux-kernel-3@gmane.org; Sun, 11 Jan 2009 23:32:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755094AbZAKWas (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Sun, 11 Jan 2009 17:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751763AbZAKWaf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2009 17:30:35 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:53348 "EHLO
	pfepa.post.tele.dk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751323AbZAKWae (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2009 17:30:34 -0500
Received: from ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
	by pfepa.post.tele.dk (Postfix) with ESMTP id EE20CA50002;
	Sun, 11 Jan 2009 23:30:30 +0100 (CET)
Received: by ravnborg.org (Postfix, from userid 500)
	id D92DE580D0; Sun, 11 Jan 2009 23:32:15 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <f19298770901111417t6762e1e3x79b2f488ee6f1243@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105242>

On Mon, Jan 12, 2009 at 01:17:31AM +0300, Alexey Zaytsev wrote:
> On Sun, Jan 11, 2009 at 23:04, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> >
> > On Sun, 11 Jan 2009, Sam Ravnborg wrote:
> >>
> >> The cost of moving this piece of history from one git tree to another
> >> git tree is that we make it harder to debug the kernel for the advanced user
> >> that knows how to do bisect.
> >>
> >> It is not like this history would be lost - one just had to look
> >> somewhere else to find it.
> >>
> >> That may be a bad pain/benefit ratio - time will tell.
> >
> > Umm. No.
> >
> > Time is exactly what makes it useful. It will make all the downsides
> > shrink, and the advantages stay.
> >
> >> There should be a way to avoid such pain when bisecting without
> >> having to mark a semi-random (for the average person) commit as good.
> >
> > Well, you don't actually have to mark that semi-random one as good either.
> > What you can do is to just mark anything that _only_ contains fs/btrfs as
> > good. IOW, you don't have to know the magic number - you just have to be
> > told that "oh, if you only have btrfs files, and you're not actively
> > bisecting a btrfs bug, just do 'git bisect good' and continue".
> >
> > Yeah, you'll hit it a few times, but you don't even have to compile things
> > or boot anything, so it's not actually going to be all that much slower
> > than just knowing about the magic point either.
> 
> But would not such bug avoid being bisected if you blindly
> mark btrfs commits as good?
> 
> v2.6.29 <-- bad
> ...
> ...
> ...
> btrfs stuff <-- mark as good
> ...
> the-real-bug
> ...
> v2.6.28 <-- good
> 
> So you hit the btrfs commit, mark it as good, leaving the real bug below,
> and the bisection continues, with both sides being actually bad.
> 
> Am I missing something?

Yep - you miss that people get confused when suddenly they have no kernel source.

	Sam
