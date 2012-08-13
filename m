From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: git svn clone, a non-standard layout question
Date: Mon, 13 Aug 2012 15:38:47 +0200
Message-ID: <20120813133847.GE10899@m62s10.vlinux.de>
References: <CANW+GuQ=egge=NcdSakChYXXZkW=MsG9f3i9yNvoutXXVFcPzQ@mail.gmail.com>
 <20120813063132.GD10899@m62s10.vlinux.de>
 <CANW+GuRoQJtZW6ZCwDQEj9OQD4C3BqxqX--2JV+=jkddagQgig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christopher Marshall <christopherlmarshall@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 15:39:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0urE-0004eA-ES
	for gcvg-git-2@plane.gmane.org; Mon, 13 Aug 2012 15:39:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512Ab2HMNiv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Aug 2012 09:38:51 -0400
Received: from mailout-de.gmx.net ([213.165.64.22]:37964 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751227Ab2HMNiu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2012 09:38:50 -0400
Received: (qmail invoked by alias); 13 Aug 2012 13:38:49 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp034) with SMTP; 13 Aug 2012 15:38:49 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/JtGxLHK3JnBasqvdH8gxW29hXdfWml7xjRqwJXz
	7cDrrqsDJYMv/h
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 05F9EDC00C; Mon, 13 Aug 2012 15:38:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CANW+GuRoQJtZW6ZCwDQEj9OQD4C3BqxqX--2JV+=jkddagQgig@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203336>

On Mon, Aug 13, 2012 at 09:29:53AM -0400, Christopher Marshall wrote:
> >
> > I had a similar problem, but I solved it using "ignore-paths" and "ignore-refs".
> > If I remember correctly, you need to set both to ignore bdir directly without
> > ignoring b3, b4,...
> >
> > For ignore-refs, pls see cdb51a13c3cf4830d499d1138160eacdd2b8aa46, as it is currently
> > undocumented.
> >
> > So I would try experimenting with the following settings:
> >
> > [svn-remote "svn"]
> >         url = file:///home/chris/programs/svn/repo
> >         fetch = trunk:refs/remotes/svn/trunk
> >         tags = tags/*:refs/remotes/svn/tags/*
> >         branches = branches/{b1,b2}:refs/remotes/svn/*
> >         branches = branches/bdir/{b3,b4}:refs/remotes/svn/*
> >
> >         # Operates on the imported git branches
> >         ignore-refs  = ^refs/remotes/bdir$
> >
> >         # Operates on the SVN branches; you might try it first without this statement
> >         ignore-paths = ^branches/bdir$
> > --
> 
> Peter:
> 
> Thanks for the advice.  I tried this:
> 
> [svn-remote "svn"]
>         url = file:///home/chris/programs/svn/repo
>         fetch = trunk:refs/remotes/svn/trunk
>         branches = branches/*:refs/remotes/svn/*
>         tags = tags/*:refs/remotes/svn/tags/*
>         branches = branches/bdir/*:refs/remotes/svn/bdir2/*
>         ignore-paths  = ^branches/bdir$
>         ignore-refs  = ^refs/remotes/bdir$
> 
> It doesn't seem to change anything.
> 

You need a git version new enough to include cdb51a13c3cf4830d499d1138160eacdd2b8aa46, otherwise
it won't have any effect and will be silently ignored.

> Chris
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
