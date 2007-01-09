From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 16:53:43 -0500
Message-ID: <20070109215343.GC25012@fieldses.org>
References: <87ps9xgkjo.wl%cworth@cworth.org> <7virfprquo.fsf@assigned-by-dhcp.cox.net> <87odphgfzz.wl%cworth@cworth.org> <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net> <20070109142130.GA10633@coredump.intra.peff.net> <7virffkick.fsf@assigned-by-dhcp.cox.net> <20070109213117.GB25012@fieldses.org> <87zm8ryiyz.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 09 22:53:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Oui-0001rQ-US
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 22:53:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbXAIVxq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 16:53:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbXAIVxq
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 16:53:46 -0500
Received: from mail.fieldses.org ([66.93.2.214]:58065 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932271AbXAIVxp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 16:53:45 -0500
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1H4Oud-0002x0-En; Tue, 09 Jan 2007 16:53:43 -0500
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87zm8ryiyz.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36411>

On Tue, Jan 09, 2007 at 01:43:16PM -0800, Carl Worth wrote:
> On Tue, 9 Jan 2007 16:31:17 -0500, "J. Bruce Fields" wrote:
> > > >   git checkout v1.4.0
> > > >   hack hack hack
> > > >   git commit -m -a 'some changes which will never be seen again'
> > > >   git checkout v1.2.0
> > > >
> > > > I thought the _point_ of the safety valve was not to lose those changes.
> ...
> > Stupid question: why can't checkout do something like this?
> >
> > 	if we're currently not on a branch, fail if .git/PREV
> > 		doesn't point to the same commit as .git/HEAD.
> >
> > 	if we're checking out a non-branch, store its SHA1 into
> > 		.git/PREV.
> 
> I would guess the problem is that this would still cause warnings even
> if the user had since given a name (created a branch) for the commits
> originally made to the dangling head.

I think as long as we provided a special exception for a case like "git
checkout -b":

	git checkout v1.4.0
	hack hack hack
	git commit -m -a 'some changes'
	git checkout -b new-changes

and also provide a way out (--force-checkout-losing-current-head) for
people that really know what they're doing, that should be more than
enough to handle that sort of case.

Because, I agree, the point is to make easy what 90% of users will
probably do, at least on the first encounter with git--download project
X, checkout version Y, build--and making checkouts on detached commits
convenient seems a lower priority.

--b.
