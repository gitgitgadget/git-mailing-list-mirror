From: Jeff King <peff@peff.net>
Subject: Re: Multiple user.name and user.email (possible feature request)
Date: Sun, 18 Apr 2010 14:37:59 -0400
Message-ID: <20100418183759.GA11366@coredump.intra.peff.net>
References: <19402.52486.274010.66636@winooski.ccs.neu.edu>
 <F5BFE3BD-7416-4F13-AF7F-0775E3234C92@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eli Barzilay <eli@barzilay.org>, git@vger.kernel.org
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 20:38:39 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3ZO9-0003fL-TF
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 20:38:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757373Ab0DRSic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 14:38:32 -0400
Received: from peff.net ([208.65.91.99]:40687 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753862Ab0DRSic (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 14:38:32 -0400
Received: (qmail 5530 invoked by uid 107); 18 Apr 2010 18:38:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 18 Apr 2010 14:38:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Apr 2010 14:38:00 -0400
Content-Disposition: inline
In-Reply-To: <F5BFE3BD-7416-4F13-AF7F-0775E3234C92@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145231>

On Sun, Apr 18, 2010 at 11:16:34AM -0700, Steven Michalske wrote:

> >For example, I'd be happy if I could put this in my global config:
> >
> > [user]
> >   name = "Eli Barzilay"
> >   email = "-"
> >
> >and then have git barf at me when I try to commit with these settings,
> >since I prefer being forced to set the appropriate address for each
> >repository rather than deal with the alternative confusion (or just
> >accepting the limitations and always using the same name/email).
> 
> Just set the variable in the repository, not the global config.

I think the key is that he wants git to barf if he forgets to set the
repo-only config, instead of quietly using the global config.

Sine 1.7.0, git will complain loudly if you simply don't have your
identity set at all. There is no way to make it actually refuse the
commit, but the warning is quite gigantic and hard to miss:

  $ git config --global --unset user.name
  $ git config --global --unset user.email
  $ git commit -m foo
  [master 7c2a927] foo
   Committer: Jeff King <peff@c-71-185-130-222.hsd1.va.comcast.net>
  Your name and email address were configured automatically based
  on your username and hostname. Please check that they are accurate.
  You can suppress this message by setting them explicitly:

      git config --global user.name Your Name
      git config --global user.email you@example.com

  If the identity used for this commit is wrong, you can fix it with:

      git commit --amend --author='Your Name <you@example.com>'

   1 files changed, 1 insertions(+), 0 deletions(-)

So I expect that will serve Eli's purpose.

-Peff
