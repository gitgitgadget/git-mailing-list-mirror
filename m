From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 3/6] Add 'resolve_gitlink_ref()' helper function
Date: Tue, 10 Apr 2007 17:54:17 +0200
Message-ID: <200704101754.17480.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <81b0412b0704100238l38ad3765w6c06878e2db654a7@mail.gmail.com> <Pine.LNX.4.64.0704100756060.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Apr 10 23:51:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbIg5-0001wF-9r
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 17:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030923AbXDJPyZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 11:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030933AbXDJPyY
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 11:54:24 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:47468 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030923AbXDJPyX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2007 11:54:23 -0400
Received: from dhcp-3s-51.lrr.in.tum.de (dhcp-3s-51.lrr.in.tum.de [131.159.35.51])
	by mail.in.tum.de (Postfix) with ESMTP id AFE3B28DB;
	Tue, 10 Apr 2007 17:54:21 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <Pine.LNX.4.64.0704100756060.6730@woody.linux-foundation.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44143>

On Tuesday 10 April 2007, Linus Torvalds wrote:
> 
> On Tue, 10 Apr 2007, Alex Riesen wrote:
> >
> > On 4/10/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > +int resolve_gitlink_ref(const char *path, const char *refname, unsigned
> > > char *result)
> > > +{
> > > +       int len = strlen(path), retval;
> > > +       char *gitdir;
> > > +
> > > +       while (len && path[len-1] == '/')
> > > +               len--;
> > > +       if (!len)
> > > +               return -1;
> > > +       gitdir = xmalloc(len + MAXREFLEN + 8);
> > > +       memcpy(gitdir, path, len);
> > > +       memcpy(gitdir + len, "/.git/", 7);
> > 
> > Can't a subproject be bare?
> 
> Not when it is checked out, no. That's what "checked out" means ;)
> 
> If a subproject is bare, it never gets resolved, because it's never 
> checked out in a superproject.
> 
> So a subproject *can* be bare, but when it's bare it is just a totally 
> regular independent git project, simply by *definition* of not being 
> checked out inside a superproject.
> 
> But hey, that was just a design decision of mine, and if people can argue 
> for it being wrong, I don't think I'm married to it ;)

It would be nice if a redirection via a "gitdir = ..." line
in .git/link of the subproject (when existing) would be possible.
This was part of the light-weight checkout proposal.

In contrast to contrib/workdir/git-new-workdir, this would allow
for (to be implemented) magic symlinks to stay intact when
moving the submodule directory around.

However, this can be added later.

Josef

PS: I wonder how long it takes to move the official KDE repository over to git ;-)
