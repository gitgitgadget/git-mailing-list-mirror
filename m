From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Thu, 24 May 2007 21:14:38 +0200
Message-ID: <20070524191438.GZ942MdfPADPa@greensroom.kotnet.org>
References: <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
 <20070519130542.GR942MdfPADPa@greensroom.kotnet.org>
 <7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
 <20070520155407.GC27087@efreet.light.src>
 <7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
 <20070521165938.GA4118@efreet.light.src>
 <20070521211133.GD5412@admingilde.org>
 <7viraixeme.fsf@assigned-by-dhcp.cox.net>
 <20070524184549.GW942MdfPADPa@greensroom.kotnet.org>
 <7vy7jevyjx.fsf@assigned-by-dhcp.cox.net>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Martin Waitz <tali@admingilde.org>, Jan Hudec <bulb@ucw.cz>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 24 21:14:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrIlo-0000N8-Os
	for gcvg-git@gmane.org; Thu, 24 May 2007 21:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbXEXTOn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 15:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbXEXTOn
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 15:14:43 -0400
Received: from psmtp09.wxs.nl ([195.121.247.23]:40011 "EHLO psmtp09.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbXEXTOm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 15:14:42 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp09.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JIK008NW84G36@psmtp09.wxs.nl> for git@vger.kernel.org; Thu,
 24 May 2007 21:14:41 +0200 (MEST)
Received: (qmail 7488 invoked by uid 500); Thu, 24 May 2007 19:14:38 +0000
In-reply-to: <7vy7jevyjx.fsf@assigned-by-dhcp.cox.net>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48294>

On Thu, May 24, 2007 at 11:58:26AM -0700, Junio C Hamano wrote:
> Sven Verdoolaege <skimo@kotnet.org> writes:
> > On Thu, May 24, 2007 at 11:26:01AM -0700, Junio C Hamano wrote:
> >>  (2) In superproject .git/, we would have a bare repository for
> >>      each project used by the superproject.
> >> 
> >> 	.git/subproject/kernel26/{objects,refs,...}
> >> 
> >>      This is created by making a bare clone from the upstream
> >>      URL, decided by the user with the help from suggested URL
> >>      described in the superproject .gitmodules.
> >
> > Do you mean a "pure" clone, i.e., without a working tree,
> > but with separate-remotes?
> 
> I meant a bare clone without separate remotes.

Why without separate remotes?
It has been argued before that changes in the subproject
may come from different remotes, so the user may want
to configure extra remotes from which to fetch.

> The counter-proposal outline essentially says, for the sake of
> simplicity, "nuke existing subproject directory whenever we need
> to replace it with something else, and reclone a new/replacement
> subproject directory every time we need to check it out, after
> making sure nothing is lost".

And she can't do it in the clone in his working tree if that's
going to get nuked from time to time.

> If we were to follow the outline in the counter-proposal, I'd
> imagine that update of (2) can happen at any time.  It could be
> part of "git fetch" in superprojects, of lazily done when we
> need to checkout a new revision for a particular subproject, but
> only if the last time you fetched superproject is more recent
> than the time you updated (2) for the subproject last time.
> 
> Or something like that.  I consider that also a minor detail in
> the implementation.

But you still need figure out _what_ to fetch.
Before you suggested to just use the default set up by
clone with separate remotes, but you no longer have that
in your new proposal.

skimo
