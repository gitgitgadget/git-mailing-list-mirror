From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Detached HEAD (experimental)
Date: Tue, 9 Jan 2007 09:21:31 -0500
Message-ID: <20070109142130.GA10633@coredump.intra.peff.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net> <87ps9xgkjo.wl%cworth@cworth.org> <7virfprquo.fsf@assigned-by-dhcp.cox.net> <87odphgfzz.wl%cworth@cworth.org> <7vbql9ydd7.fsf@assigned-by-dhcp.cox.net> <20070108131735.GA2647@coredump.intra.peff.net> <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Carl Worth <cworth@cworth.org>
X-From: git-owner@vger.kernel.org Tue Jan 09 15:21:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4Hr8-00006e-He
	for gcvg-git@gmane.org; Tue, 09 Jan 2007 15:21:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750846AbXAIOVe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 09:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbXAIOVe
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 09:21:34 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4112 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750788AbXAIOVd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 09:21:33 -0500
Received: (qmail 1722 invoked from network); 9 Jan 2007 09:21:44 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Jan 2007 09:21:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Jan 2007 09:21:31 -0500
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzm8tt5kf.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36363>

On Mon, Jan 08, 2007 at 04:19:28PM -0800, Junio C Hamano wrote:

> > Hrm. So does that mean this doesn't work (without -f):
> >
> >   git checkout v1.4.0
> >   ... look around ...
> >   git checkout v1.2.0
> 
> That should work.
> 
> The first checkout, because there is no branch v1.4.0, makes the
> HEAD detached.  You are no longer on any branch at that point,
> and "git checkout v1.2.0" that follows do not trigger the check
> which is about "coming back from the detached HEAD state".

Oh, that's even worse, since the safety valve doesn't kick in when it
should. For example, with what's in next now, I can do this:

  git checkout v1.4.0
  hack hack hack
  git commit -m -a 'some changes which will never be seen again'
  git checkout v1.2.0

I thought the _point_ of the safety valve was not to lose those changes.

> But I would probably do the second v1.2.0 "checkout" with "git
> reset --hard", if what I am doing is "wandering, looking around
> to see different commits".

As Carl mentioned, I think recommending that workflow is a terrible idea
from a user interface perspective.

-Peff
