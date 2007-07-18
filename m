From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] Move bundle specific stuff into bundle.[ch]
Date: Wed, 18 Jul 2007 12:25:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707181140450.14596@iabervon.org>
References: <Pine.LNX.4.64.0707172346450.14781@racer.site>
 <Pine.LNX.4.64.0707172216420.14596@iabervon.org> <Pine.LNX.4.64.0707181053130.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 18 18:25:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBCKv-0005TX-32
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 18:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759464AbXGRQZK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 12:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758778AbXGRQZK
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 12:25:10 -0400
Received: from iabervon.org ([66.92.72.58]:1381 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753710AbXGRQZJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 12:25:09 -0400
Received: (qmail 30587 invoked by uid 1000); 18 Jul 2007 16:25:06 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jul 2007 16:25:06 -0000
In-Reply-To: <Pine.LNX.4.64.0707181053130.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52876>

On Wed, 18 Jul 2007, Johannes Schindelin wrote:

> Hi,
> 
> On Tue, 17 Jul 2007, Daniel Barkalow wrote:
> 
> > You should use -C on this sort of thing, so that the interesting aspects 
> > of the patch are easier to see. (It actually comes out longer in this 
> > case, but it's far easier to tell that the code in the new file is the 
> > same as the old code.)
> 
> Okay, I wanted it to be kept short, since I really get lost easily in 
> hundreds of "-" lines, with possibly one in the midst being a "+".

Actually, putting the functions in the original order made the -C diff 
shorter than without -C. In general, a hundred lines of '-' with maybe a 
'+' is hard to read, but I think whole functions of '-' without anything 
else are easy; scan the left column, and find that the whole thing goes 
away. If a patch is discarding blocks which are exactly whole top-level 
definitions, those changes are probably either correct or totally broken 
(depending on whether those blocks were actually used); you just have to 
get suspicious around preprocessor stuff. Your change ended up being 
trivially what the message described: bunch of blocks not in one or the 
other of the resulting files, some functions make not static, renamed, 
and/or had arguments changed, and the function you have to call after 
unbundle if you want it.

> > Aside from presentation, it looks good to me. Shall I stick the bundle 
> > changes into my series? I'd like to have them come before the patch to 
> > switch to builtin-fetch, so that there aren't any revisions where "git 
> > fetch" doesn't have bundle support.
> 
> Looks fine to me.  Seems like you should add a SOB line, too.

Ah, yes. I'll have to see if I'll be the first person in git development 
to have a SOB line that's neither first nor last. :)

> > And I think it would be best to take part 3 as a review fix to my final 
> > patch.
> 
> Yes, definitely.  This shows again (to me, at least), that just looking at 
> the code is not enough, you have to run it, too, to review patches.

You caught that by running it? I've been running this code, and I've never 
done anything with it which caused fetch_refs to fail and then checked the 
result. I thought you must have found it by looking for missing checks of 
return values. Or did you find it when you'd implemented half of bundle 
support and it didn't complain?
