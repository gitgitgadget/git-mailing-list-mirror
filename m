From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Removing deleted files after checkout
Date: Tue, 23 Aug 2005 18:12:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508231753340.23242@iabervon.org>
References: <20050823162156.GA32240@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0508231533570.23242@iabervon.org> <20050823205052.GA13311@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.63.0508231713450.23242@iabervon.org> <20050823214020.GA3763@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 00:10:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7gwj-0006aQ-Aa
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 00:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVHWWIi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 18:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932459AbVHWWIi
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 18:08:38 -0400
Received: from iabervon.org ([66.92.72.58]:39949 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932419AbVHWWIh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Aug 2005 18:08:37 -0400
Received: (qmail 15864 invoked by uid 1000); 23 Aug 2005 18:12:09 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Aug 2005 18:12:09 -0400
To: Carl Baldwin <cnb@fc.hp.com>
In-Reply-To: <20050823214020.GA3763@hpsvcnb.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7678>

On Tue, 23 Aug 2005, Carl Baldwin wrote:

> The point is to push and use a post-update hook to do the checkout.  So,
> this won't be possible.

You could have the remote repository be something like
"~/git/website.git", and have a hook which does: "cd ~/www; git pull
~/git/website.git/". That is, have three things: the directory where you
work on stuff, the central storage location, and the area that the web
server serves, and have the storage location automatically update the web
server area. That's what I do with my website section that's still in CVS,
and the general concept is good (and means that the "real" repository
isn't somewhere the web server is poking around).

> > which will correctly identify before and after, and remove any files that
> > were removed.
> >
> > Alternatively, you could do, at point 1:
> >
> > cp .git/refs/master .git/refs/deployed
> > git checkout deployed
>
> How to get a post-update hook to do this?  I suppose an update script
> could set this up for the post-update to later use.

If you have "deployed" checked out, and you push to "master" in the same
repository, having the hook do "git resolve deployed master auto-update"
should work.

	-Daniel
*This .sig left intentionally blank*
