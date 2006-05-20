From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFD] Git glossary: 'branch' and 'head' description
Date: Fri, 19 May 2006 20:28:22 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0605192006400.6713@iabervon.org>
References: <e4f1ta$e07$1@sea.gmane.org> <87y7wyv72m.fsf@morpheus.hq.vtech>
 <20060519092136.GN22257@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David =?iso-8859-1?Q?K=E5gedal?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 20 02:27:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FhFJU-0000Gm-Kv
	for gcvg-git@gmane.org; Sat, 20 May 2006 02:27:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWETA1L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 19 May 2006 20:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbWETA1L
	(ORCPT <rfc822;git-outgoing>); Fri, 19 May 2006 20:27:11 -0400
Received: from iabervon.org ([66.92.72.58]:41994 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751451AbWETA1K (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 May 2006 20:27:10 -0400
Received: (qmail 5524 invoked by uid 1000); 19 May 2006 20:28:22 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 May 2006 20:28:22 -0400
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060519092136.GN22257@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20368>

On Fri, 19 May 2006, Shawn Pearce wrote:

> David K?gedal <davidk@lysator.liu.se> wrote:
> > I noticed that some of this seems to be changing slightly with the
> > introduction of branch logs, but I don't know how those are supposed
> > to be used yet.
> 
> 	$ git commit -a
> 	$ git pull . some/other-tag
> 	# go to lunch
> 	$ git pull . some/bad-stuff
> 	$ git commit -a
> 	# go home
> 	$ test...
> 	# realize this is all bad
> 	$ git reset --hard "master@{yesterday}"
> 
> :-)
> 
> Its really only useful for recording the history of your ref's state,
> so you can 'undo' a bad merge that you might have done a few days
> ago but not realized was bad until now.

I still think it's useful for presenting a local view of how things have 
changed. I.e.:

$ git pull . stuff
# Notice that the diffstat is exciting
# What did I just get?
$ git log master@{5 minutes ago}..master

This is about the only easy way to find out that the fast-forward you just 
did included merging a line which contains a commit from several weeks 
ago. (Because the "before" state isn't easily accessible for a 
fast-forward, and the date of the old commit puts it way back in a 
date-ordered log.)

I still think that a local changelog, which groups the additions due to 
each logged value, would be a useful way of viewing the history in a way 
that's meaningful to the particular user, and I think it would fit user 
expectations of gitweb (i.e., when looking at Linus's tree's summary, 
things would be ordered by when they hit Linus's tree, not when they were 
originally committed, so between the listing of the merge at 23:48:54 
today and the one 7 minutes before would be those things which weren't in 
Linus's tree during those 7 minutes).

	-Daniel
*This .sig left intentionally blank*
