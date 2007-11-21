From: Jarek Poplawski <jarkao2@o2.pl>
Subject: Re: gitweb: kernel versions in the history (feature request, probably)
Date: Wed, 21 Nov 2007 08:52:17 +0100
Message-ID: <20071121075217.GA1642@ff.dom.local>
References: <20071120142042.GA4157@ff.dom.local> <20071120215904.GF1001@machine.or.cz> <47436E0F.6080003@o2.pl> <20071121032009.GB4175@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, linux-kernel@vger.kernel.org,
	git@vger.kernel.org
To: "J\. Bruce Fields" <bfields@fieldses.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 08:48:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IukJk-0001qp-5Z
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 08:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756284AbXKUHr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 02:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755959AbXKUHr6
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 02:47:58 -0500
Received: from mx12.go2.pl ([193.17.41.142]:49178 "EHLO poczta.o2.pl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755307AbXKUHr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 02:47:57 -0500
X-Greylist: delayed 29932 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2007 02:47:57 EST
Received: from poczta.o2.pl (mx12 [127.0.0.1])
	by poczta.o2.pl (Postfix) with ESMTP id 712993E804F;
	Wed, 21 Nov 2007 08:47:55 +0100 (CET)
Received: from ff.dom.local (bv170.internetdsl.tpnet.pl [80.53.205.170])
	by poczta.o2.pl (Postfix) with ESMTP;
	Wed, 21 Nov 2007 08:47:55 +0100 (CET)
Received: (nullmailer pid 2177 invoked by uid 1000);
	Wed, 21 Nov 2007 07:52:18 -0000
Content-Disposition: inline
In-Reply-To: <20071121032009.GB4175@fieldses.org>
User-Agent: Mutt/1.4.2.2i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65616>

On Tue, Nov 20, 2007 at 10:20:09PM -0500, J. Bruce Fields wrote:
> On Wed, Nov 21, 2007 at 12:30:23AM +0100, Jarek Poplawski wrote:
> > I don't know git, but it seems, at least if done for web only, this
> > shouldn't be so 'heavy'. It could be a 'simple' translation of commit
> > date by querying a small database with kernel versions & dates.
> 
> If I create a commit in my linux working repo today, but Linus doesn't
> merge it into his repository until after he releases 2.6.24, then my
> commit will be created with an earlier date than 2.6.24, even though it
> isn't included until 2.6.25.
> 
> So you have to actually examine the history graph to figure this out
> this sort of thing.

Of course, you are right, and I probably miss something, but to be
sure we think about the same thing let's look at some example: so, I
open a page with current Linus' tree, go to something titled:
/pub/scm / linux/kernel/git/torvalds/linux-2.6.git / history

and see:
2007-10-10 Stephen Hemminger [NET]: Make NAPI polling independent ...
and just below something with 2007-08-14 date.

Accidentally, I can remember this patch introduced many changes, and
this big interval in dates suggests some waiting. Then I look at the
commit, and there are 2 dates visible, so the patch really was created
earlier. Then I go back to:
/pub/scm / linux/kernel/git/torvalds/linux-2.6.git / summary

and at the bottom I can see this:

...
tags
4 days ago 	v2.6.24-rc3 	Linux 2.6.24-rc3
2 weeks ago 	v2.6.24-rc2 	Linux 2.6.24-rc2
4 weeks ago 	v2.6.24-rc1 	Linux 2.6.24-rc1
6 weeks ago 	v2.6.23 	Linux 2.6.23

which drives me crazy, because, without looking at the calendar, and
calculator, I don't really know which month was 6 weeks ago, and 4
days ago, either!

So, I go to the: http://www.eu.kernel.org/pub/linux/kernel/v2.6/, 
do some scrolling, look at this:
ChangeLog-2.6.23             09-Oct-2007 20:38  3.8M  

and only now I can guess, this napi patch didn't manage to 2.6.23.
Of course, usually I've to do a few more clicks and reading to make
sure where it really started.

So, this could suggest this 2007-10-10 (probably stored with time
too), could be useful here... but it seems, I'm wrong.

Of course, this problem doesn't look so hard if we forget about
git internals: I can imagine keeping a simple database, which
could simply retrieve commit numbers from these ChangeLogs, and
connecting this with gitweb's commit page as well... For
performance reasons, doing it only for stable and testing, so with
-rc 'precision' would be very helpful too.

Regards,
Jarek P.
