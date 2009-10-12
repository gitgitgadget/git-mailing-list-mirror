From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/5] Pretty formats for reflog data
Date: Mon, 12 Oct 2009 17:37:56 -0400
Message-ID: <20091012213756.GA12166@coredump.intra.peff.net>
References: <20091012175201.GA10263@coredump.intra.peff.net>
 <cover.1255380039.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Oct 13 00:07:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MxT3J-0004FJ-If
	for gcvg-git-2@lo.gmane.org; Tue, 13 Oct 2009 00:07:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932761AbZJLVid (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2009 17:38:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758367AbZJLVic
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Oct 2009 17:38:32 -0400
Received: from peff.net ([208.65.91.99]:33459 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758361AbZJLVic (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2009 17:38:32 -0400
Received: (qmail 8176 invoked by uid 107); 12 Oct 2009 21:41:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 12 Oct 2009 17:41:26 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Oct 2009 17:37:56 -0400
Content-Disposition: inline
In-Reply-To: <cover.1255380039.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130081>

On Mon, Oct 12, 2009 at 11:02:29PM +0200, Thomas Rast wrote:

> > Stash listing is internally just "git log -g refs/stash", so you can
> > pass any formatting or limiting arguments you want there (see the git
> > log documentation for ideas). If no arguments are given, we pass "-10".
> 
> This seems fairly arbitrary, doesn't it?  My own working theory is
> that Nanako put it in because the git-log|sed construct inherently
> bars any way to a pager, so it needs to be cut short.

Yes, it's arbitrary, though it is probably a reasonable estimate for the
intended use of stash. It's a stack, so you generally are only
interested in the last couple of entries.

What's much worse though is that the logic is not "if you told me how
many to show, show that; otherwise, show 10".  Instead it is "if you
gave me no options, default the size of the list.  But if you gave me
any options, even if they have nothing whatsoever to do with limiting
the size of the list, then show all".

So something like "git stash list --date=relative" suddenly shows many more
stashes than just "git stash list". It would be nice to fix that.

> So suppose we could somehow get rid of the |sed... like if we had
> --pretty specifiers for the reflog information.

I'm not sure if people will like having a longer list in a pager than a
shorter list without one (I personally can't remember ever using "git
stash list", so I have no strong opinion).

But certainly the idea of adding pretty format specifiers to access
reflog data seems like a good idea on its own.

-Peff
