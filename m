From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: Big syntax change; support rewriting
 multiple refs
Date: Tue, 24 Jul 2007 10:10:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241010060.14781@racer.site>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site>
 <7vfy3ejre3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 11:10:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDGPa-0005sA-J2
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 11:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934845AbXGXJKb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 05:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934640AbXGXJKa
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 05:10:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:36756 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934043AbXGXJK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 05:10:29 -0400
Received: (qmail invoked by alias); 24 Jul 2007 09:10:27 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp004) with SMTP; 24 Jul 2007 11:10:27 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18n0CFw/ocnkFdC0tA5XxdqYILOSIQo7lNPscvvWR
	QzBow9IPgGRva4
X-X-Sender: gene099@racer.site
In-Reply-To: <7vfy3ejre3.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53539>

Hi,

On Mon, 23 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > 	Junio, I know that this comes quite late in the game, but I really
> > 	think that the "first arg is new branch name" was a bad syntax.
> >
> > 	Could you please consider taking this patch (or whatever version
> > 	comes out after review ;-) or keeping filter-branch of 1.5.3?  I 
> > 	do not want people to get used to the borked syntax...
> 
> Yeah, "No new features after -rc" should not apply to this one.
> 
> I was actually going to ask you about it, since this is a feature we 
> have already advertised to the public, but still is a new feature, and 
> we'd be better off getting it right in the first public version.

Thanks.

> > 	BTW I considered "git log -g --all" as an alternative to
> > 	inspecting refs/original/, but ATM this die()s if just _one_ of 
> > 	the refs has no logs.  Probably should fix that, too.
> 
> I do not think refs/original/ is such a hot feature.  What's wrong with 
> "gitk mine@{1}...mine"?

If you are saying

	$ git filter-branch <some-filters> --all <rev-list-options>

potentially all refs are rewritten.

To find out which ones actually changed, you can use "git show-ref | grep 
^refs/original/" ATM.

It is not really easy to do it otherwise.  With the patches I sent out 
yesterday,

	$ git log -g --no-walk --all --decorate --abbrev-commit 
	  --pretty=oneline --since=<before-the-last-filter-branch-call>

would be similar, but not as comfortable, would it?

Of course, we could teach filter-branch an option, say --show-changed, 
which will not actually filter branches, but instead look at the reflogs 
itself and show the refs which were recently changed by filter-branch.

But note that you can switch off reflogs.

Ciao,
Dscho
