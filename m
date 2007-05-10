From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Merging commits together into a super-commit
Date: Thu, 10 May 2007 15:22:12 -0400
Message-ID: <20070510192212.GP13719@fieldses.org>
References: <1178794261.5806.98.camel@murta.transitives.com> <4643049C.3D5F30D8@eudaptics.com> <alpine.LFD.0.98.0705100857450.3986@woody.linux-foundation.org> <87wszg39cp.wl%cworth@cworth.org> <20070510171457.GK13719@fieldses.org> <87vef0350y.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org
To: Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Thu May 10 21:22:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmEDW-0003Eq-2Y
	for gcvg-git@gmane.org; Thu, 10 May 2007 21:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757788AbXEJTWS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 15:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758086AbXEJTWS
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 15:22:18 -0400
Received: from mail.fieldses.org ([66.93.2.214]:57795 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757827AbXEJTWR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 15:22:17 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HmEDM-0000PV-Pd; Thu, 10 May 2007 15:22:12 -0400
Content-Disposition: inline
In-Reply-To: <87vef0350y.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46887>

On Thu, May 10, 2007 at 11:30:37AM -0700, Carl Worth wrote:
> So, compared to the rebase usage, this does add two commands for
> bookkeeping the original state and cleaning it up. But the syntax for
> the cherry-pick part is quite a bit simpler than the original rebase
> at least.

Yeah, something like that would be great.  I think I've seen others
suggest similar syntax before, so it's probably just a question of one
of us who want this finding time to write the patches.

> Also, "reset --hard" isn't actually what I want in this case. I'd like
> this recipe to use something that would move the current branch to
> some other point, but in a safe way, (that is, not destroy any
> uncommitted changes that might exist at the beginning). I don't have
> any proposal for what that would be.

The tag creation and cleanup could get to be annoying too.  You could
scrounge through the reflog instead of using a temporary tag, but
depending on the amount of --amend'ing and cherry-picking you do the
reflog entry may end up in a different place each time, so it's probably
hard to make this automatic.

> stg - This probably works great if you're using it as a primary
>       interface. But trying to use it as a quick one-off when
>       generally using core git does not work well at all. Instead of
>       the two "git tag" commands in my recipe above, an stg recipe
>       would involve a lot of additional bookkeeping with stg init, stg
>       uncommit [N times for fixing a commit N steps back in the
>       history], stg goto, stg push, etc.

I also didn't like having to come up with another name for each
patch--I'd rather just run git-log or gitk and cut-n-paste the sha1.

For kernel work I started out working with multiple (sym- or
hard-linked) trees, then used akpm's patch scripts, then stgit.  I think
I'm happiest just using plain git.

The one thing I've never been good at is keeping the history of the
patch series itself.

--b.
