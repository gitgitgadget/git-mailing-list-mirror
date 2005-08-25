From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Looking at multiple ancestors in merge
Date: Thu, 25 Aug 2005 01:20:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508250108100.23242@iabervon.org>
References: <Pine.LNX.4.63.0508242249030.23242@iabervon.org> <430D4B75.6060102@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 07:17:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8A6s-0002Ua-E1
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 07:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbVHYFQ5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 01:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbVHYFQ5
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 01:16:57 -0400
Received: from iabervon.org ([66.92.72.58]:27665 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751228AbVHYFQ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2005 01:16:56 -0400
Received: (qmail 32542 invoked by uid 1000); 25 Aug 2005 01:20:31 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Aug 2005 01:20:31 -0400
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <430D4B75.6060102@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7745>

On Wed, 24 Aug 2005, A Large Angry SCM wrote:

> Daniel Barkalow wrote:
> > I'm starting to work on letting the merging process see multiple
> > ancestors, and I think it's messy enough that I should actually discuss
> > it.
> >
> > Review of the issue:
> >
> > It is possible to lost reverts in cases when merging two commits with
> > multiple ancestors, in the following pattern: (letters representing blobs
> > at some filename, children to the right)
> >
> > a-b-b-a-?
> >  \ X   /
> >   a-b-b
> >
> [Lots of stuff deleted]
>
> There seems to be a lot of effort being put into auto-magically choosing
> the "right" merge in the presence of multiple possible merge bases.
> Unfortunately, most (all?) of the proposals are attempting to divine
> intent, and so, are guaranteed to be 100% wrong at least some of the time.
>
> Wouldn't it be better, instead, to detect that current merge being
> attempted is ambiguous and require the user to specify the correct merge
> base? The alternative is a tool that appears to work all of the time but
> does the wrong thing some of the time.

My proposal is actually to detect when a merge is ambiguous. In order to
determine that, however, you have to evaluate multiple potential outcomes
and see if they are actually different. I'm working on an efficient way to
do that.

Then further work could look into eliminating possibilities when
information about the history excludes them. There were two issues in the
case that Tony hit: it ignored a potential correct outcome for the merge,
and it didn't ignore an outcome which could be demonstrated to be
incorrect. The priority is to resolve the first, but things which improve
the second or help with solutions to the second are worth understanding.

	-Daniel
*This .sig left intentionally blank*
