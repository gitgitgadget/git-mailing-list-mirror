From: Jeff King <peff@peff.net>
Subject: Re: Confused about push/pull of a branch
Date: Tue, 25 Aug 2009 14:27:01 -0400
Message-ID: <20090825182701.GA23731@coredump.intra.peff.net>
References: <BA2E0DDB-3DE0-4D49-BFA6-72CFEDEBA5AE@uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Fritz Anderson <fritza@uchicago.edu>
X-From: git-owner@vger.kernel.org Tue Aug 25 20:27:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg0jj-0007za-Ba
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 20:27:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbZHYS1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 14:27:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755619AbZHYS1D
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 14:27:03 -0400
Received: from peff.net ([208.65.91.99]:40898 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755547AbZHYS1C (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 14:27:02 -0400
Received: (qmail 18182 invoked by uid 107); 25 Aug 2009 18:27:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 Aug 2009 14:27:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2009 14:27:01 -0400
Content-Disposition: inline
In-Reply-To: <BA2E0DDB-3DE0-4D49-BFA6-72CFEDEBA5AE@uchicago.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127037>

On Tue, Aug 25, 2009 at 12:40:47PM -0500, Fritz Anderson wrote:

> Branch webservices was created after the working copy on machine_2
> was cloned.
> 
> In my working copy on machine_2:
> 
> machine_2$ git pull
> Password:
> # Progress messages, no protests.
> machine_2$ git checkout webservices
> error: pathspec 'webservices' did not match any file(s) known to git.
> machine_2$ git branch
> * master
> machine_2$

Try "git branch -a", which will list remote branches. You likely have a
remote tracking branch "origin/webservices". You can check that out to
examine it, or if you want to start working on it locally, try "git
checkout -b webservices origin/webservices".

> git-config shows the two repository URLs are identical, net of
> machine_2 having to specify a user name and host. The machine_2 .git/
> config shows a section for [branch "master"], but not for
> webservices. Is that the problem? What's the approved way of adding

> [branch "webservices"], and what do I put into it?

The branch.webservices config is not necessary for a branch; it just
says "by the way, when you do a pull without arguments and we are on
this branch, here is where to pull from". Doing the "checkout -b" above
will create such a config section on recent versions of git.

> I've obviously forgotten something. Or never understood something
> (there's a lot in Git not to understand). How do I get the
> webservices branch onto machine_2, so I can check it out?

The branching model in git is a little different than other systems.
Just because the remote has a branch does not mean _you_ have a branch.
When you fetch from them (or pull, which does a fetch behind the
scenes), you will have a "remote tracking branch" which is your local
copy of where their remote branches are. You still need to create your
own local branch if you want to do work on it (and bear in mind your
branch doesn't need the same name or to be related in any long term way;
you are merely using their remote branch as a starting point for your
branch).

-Peff
