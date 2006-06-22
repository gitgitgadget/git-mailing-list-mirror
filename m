From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] rebase --merge: fix for rebasing more than 7 commits.
Date: Thu, 22 Jun 2006 04:09:41 -0700
Message-ID: <20060622110941.GA32261@hand.yhbt.net>
References: <7vy7vptw8p.fsf@assigned-by-dhcp.cox.net> <7vpsh1tvt1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 22 13:09:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtN4D-0001pp-Oe
	for gcvg-git@gmane.org; Thu, 22 Jun 2006 13:09:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030626AbWFVLJn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 22 Jun 2006 07:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030627AbWFVLJn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jun 2006 07:09:43 -0400
Received: from hand.yhbt.net ([66.150.188.102]:5798 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1030626AbWFVLJm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jun 2006 07:09:42 -0400
Received: by hand.yhbt.net (Postfix, from userid 500)
	id 9609B7DC021; Thu, 22 Jun 2006 04:09:41 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsh1tvt1.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22323>

Junio C Hamano <junkio@cox.net> wrote:
> Junio C Hamano <junkio@cox.net> writes:
> 
> >  * I wanted to raise my confidence level in the new rebase --merge
> >    code, so I did a little exercise which resulted in finding this
> >    buglet.
> >...
> >    So the exercise went like this:
> >...
> >   With this fix, the above works beautifully.  I am reasonably
> >   happy with this shiny new toy.  Good job, Eric! and thanks.

:)  Thanks for the extra QA and fix.

> By the way, I do not quite understand the reasoning behind not
> moving the head being rebased until the finalization phase.

That's because my original patch that only used git-merge, which didn't
let me manually commit with all the information from a previous commit.

> Also I think --skip would be straightforward.  What you look at
> in call_merge() is the current HEAD, the commit being rebased
> and its direct parent (actually what you are interested in are
> trees of these commits and not ancestry chains among them -- if
> we can tell git-merge-recursive not to try its own "recursive"
> merge base finding but just use what we give it as the base, I
> could sleep better.  I think the current code could misbehave in
> funnier ancestry graph if we allow it to pick merge base on its
> own), so skipping is just a matter of, eh, skipping the commit.

Another consequence of relying on plain git-merge in my original
patch.  --skip should be very doable now that we can specify
the correct base.  I'll look into it more when I'm more awake.

-- 
Eric Wong
