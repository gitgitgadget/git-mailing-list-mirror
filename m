From: Jeff King <peff@peff.net>
Subject: Re: checkout to a reflog entry
Date: Tue, 25 Aug 2009 01:22:01 -0400
Message-ID: <20090825052200.GA15880@coredump.intra.peff.net>
References: <20090825045235.GB391@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 25 07:22:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfoU2-0002s0-7M
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 07:22:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754446AbZHYFWE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 01:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754171AbZHYFWC
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 01:22:02 -0400
Received: from peff.net ([208.65.91.99]:36286 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754024AbZHYFWB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 01:22:01 -0400
Received: (qmail 14228 invoked by uid 107); 25 Aug 2009 05:22:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 25 Aug 2009 01:22:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Aug 2009 01:22:01 -0400
Content-Disposition: inline
In-Reply-To: <20090825045235.GB391@debian.b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127004>

On Tue, Aug 25, 2009 at 12:52:35PM +0800, bill lam wrote:

> project(master)$ git checkout master@{1}
> Note: moving to 'master@{1}' which isn't a local branch
> [...]
> It becomes (no branch) although the SHA1 is correct. If I then
> checkout master, then it revert and jump back up the previous master
> HEAD.  I tried HEAD@{xx} also failed.  What is the correct way of to
> checkout that master@{..} and stay in that master branch?  (Sometimes
> it worked I forgot how and why)

A reflog entry is not a branch; it is just a pointer to the commit where
a branch was at some point. Using "git checkout" on it will let you
explore the contents, just as you might with a tag. If you want to build
on it, you need to either:

  1. Make a new branch to work on, starting at that point:

       git checkout -b my-topic master@{1}

  2. Reset your current branch (and worktree) to point at that commit:

       git reset --hard master@{1}

-Peff
