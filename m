From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: bug in git-p4?
Date: Fri, 8 May 2009 17:46:24 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905081731510.2147@iabervon.org>
References: <F98DA2FE6F6C464C860149518BD861CC3B3C13440A@SSDEXCH2.websense.com> <1a6be5fa0905080443h5c696f8es55ea5acf3b3025cb@mail.gmail.com> <B82F1DD2-282A-4E3A-ABAE-53F1D0386B25@websense.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tor Arvid Lund <torarvid@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Carl Mercier <cmercier@websense.com>
X-From: git-owner@vger.kernel.org Fri May 08 23:46:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Xtu-0006zS-C2
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 23:46:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754807AbZEHVq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 17:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754790AbZEHVq0
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 17:46:26 -0400
Received: from iabervon.org ([66.92.72.58]:46442 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753940AbZEHVqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 17:46:25 -0400
Received: (qmail 30792 invoked by uid 1000); 8 May 2009 21:46:24 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 8 May 2009 21:46:24 -0000
In-Reply-To: <B82F1DD2-282A-4E3A-ABAE-53F1D0386B25@websense.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118632>

On Fri, 8 May 2009, Carl Mercier wrote:

> Thank you.
> 
> What I'm trying to accomplish is a little bit different. We've been using Git
> with a remote server for so long, we don't want to give that up. (and we also
> can't for some reasons).  So what I was hoping to do was simply keep working
> with out remote Git server as normal, and then have another server pull from
> Git and submit to P4.
> 
> We have many Git repos we'd like to store into P4 subdirectories.  For
> example:
> 
> website.git -> //SecTech/website
> api.git -> //SecTech/api
> 
> I just can't seem to get this to work because git-p4 seems to expect a brand
> new Git repo to work properly.

You're going to have a whole bunch of problems, most likely, including 
that Perforce doesn't suppose the history structure that git uses (where a 
revision can have multiple parents without these revisions having 
different codelines).

Most likely, what you actually want to do is essentially send Perforce 
git's reflog. You should be able to write a short post-update hook that 
takes the diff between the before and after, add/edit/delete the files 
that changed, change a client workspace, and submit it.

	-Daniel
*This .sig left intentionally blank*
