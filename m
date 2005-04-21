From: Olivier Andrieu <oandrieu@nerim.net>
Subject: Re: git-viz tool for visualising commit trees
Date: Thu, 21 Apr 2005 22:14:41 +0200 (CEST)
Message-ID: <20050421.221441.85407120.oandrieu@nerim.net>
References: <20050421130242.GA5817@elte.hu>
	<20050421.155519.112619323.oandrieu@nerim.net>
	<20050421143840.GA14059@elte.hu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 22:11:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOi0K-0005I4-KH
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 22:10:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbVDUUOz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 16:14:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVDUUOz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 16:14:55 -0400
Received: from smtp-104-thursday.nerim.net ([62.4.16.104]:57360 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261853AbVDUUOr
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 16:14:47 -0400
Received: from localhost (karryall.dnsalias.org [62.4.18.180])
	by kraid.nerim.net (Postfix) with ESMTP
	id 154EE41B95; Thu, 21 Apr 2005 22:14:41 +0200 (CEST)
To: mingo@elte.hu
In-Reply-To: <20050421143840.GA14059@elte.hu>
	<20050421144554.GA15032@elte.hu>
	<20050421144716.GA15136@elte.hu>
X-Mailer: Mew version 4.1 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 > Ingo Molnar [Thu, 21 Apr 2005]:
 > I just checked how the kernel repository looks like with it, and
 > i'm impressed! The GUI is top-notch, and the whole graph output and
 > navigation is very mature visually. Kudos!

Thanks !

 > - there doesnt seem to be any performance difference between non-colored 
 >   and colored rendering - so you might as well want to make 'color by 
 >   author' (or color by branch) the default coloring, instead of 
 >   uncolored?

It has to call `cat-file commit' for each commit id to get the author
... it's just that's a lot of forks.

 > - naming the boxes by key is quite meaningless. It would be more 
 >   informative to see the author's email shortcuts in the boxes. Also, it 
 >   would be nice to see some simple graphical feedback about the size and 
 >   scope of a changeset, without having to zoom on it.

That's interesting. What do you mean exactly by scope ?

 > i guess you know it, and i'm definitely not complaining about prototype 
 > code, but rendering is quite slow: drawing the 340 changesets in the 
 > current kernel repository takes 15 seconds on a 2 GHz P4. Drawing the 
 > full kernel history (63,000 changesets) would take more than 45 minutes 
 > on this box.
 > 
 > the current rate of kernel development is ~2000 changesets per month, so 
 > drawing the kernel history will get 3 seconds slower every day - it will 
 > exceed 1 minute in 20 days, so this will become a pressing issue quite 
 > soon i suspect.

Right, it is slow. From what I could understand with a bit of
profiling, the problem is with the "text" canvas item for the boxes'
labels. I guess libgnomecanvas isn't using Pango properly or
something: it lookups the font with fontconfig each time I create such
an item. I'm not sure what I can do about this.

Also, there's a -noaa option that draws an non-antialiased canvas :
it's noticeably faster (and uglier too).


 > Ingo Molnar [Thu, 21 Apr 2005]:
 > another thing, when i 'zoom out' of the graph far away (so that the 
 > whole graph becomes visible on the screen), i'm getting lots of such 
 > error messages:
 > 
 >  *** attempt to put segment in horiz list twice

Yes, this message must come from one of the libraries (libart most
probably)


 > Ingo Molnar [Thu, 21 Apr 2005]:
 > is the 'diff with ancestor' feature supposed to work at this early
 > stage? (it just does nothing when i click on it. It correctly
 > offers two ancestors for merge points, but does nothing there
 > either.)

It works with Petr Baudis' git-pasky (it calls `git diff'). I don't
know how to do that with the canonical git.

Thanks for the suggestions,
-- 
   Olivier
