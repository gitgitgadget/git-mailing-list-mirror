From: Jeff King <peff@peff.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 30 Jan 2007 22:22:48 -0500
Message-ID: <20070131032248.GA17504@coredump.intra.peff.net>
References: <87odognuhl.wl%cworth@cworth.org> <20070130231015.GB10075@coredump.intra.peff.net> <7vzm80vv1s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: cworth@cworth.org, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Jan 31 04:23:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC63t-0007gf-01
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 04:23:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbXAaDWv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 22:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbXAaDWv
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 22:22:51 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3800 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752140AbXAaDWu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 22:22:50 -0500
Received: (qmail 25715 invoked from network); 30 Jan 2007 22:23:15 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 30 Jan 2007 22:23:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jan 2007 22:22:48 -0500
Content-Disposition: inline
In-Reply-To: <7vzm80vv1s.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38223>

On Tue, Jan 30, 2007 at 05:34:07PM -0800, Junio C Hamano wrote:

> That does not protect anything other than interactive "git
> commit".  People often do "git commit -m" or "git commit -C".

Yes, those should be covered by a message.

> In addition, rebasing a detached HEAD, merging into a detached
> HEAD, cherry-picking onto a detached HEAD or running reset on a

I'm not even sure what it means to rebase a detached HEAD. Merging
and cherry picking should make a similar warning.

> detached HEAD to move to a particular state you want to look at

Running reset on a detached HEAD isn't a problem unless you've done one
of the other things.

> I do not think warning at every step that you are "in a funny
> state" does not help productivity, so I'd prefer warning upfront
> once and be silent afterwards, until you try to come back with
> "git checkout <existing branch>", potentially losing your state,
> which is what we currently do.

I didn't quite parse your first sentence, but I think I get the general
meaning. I just think it is awkward to have to either see such a warning
(or use -f) just to _look_ at detached commits, when you aren't doing
anything even remotely dangerous. The dangerous thing is _creating_
commits on top of a detached head.  I honestly don't think it should be
allowed at all, but since some people have argued that it is useful,
that seems like the place to put warnings. Anything else is just making
things more confusing for the sorts of people Carl is dealing with --
those who merely want to look around.

> For situations like Carl's intstruction where a user, who is
> purely a sightseer, uses the detached HEAD to go-and-look a
> particular state, the fact that "-f" loses the previous local

Yes, though it would be nicer not to have to explain to them why '-f' is
needed.

-Peff
