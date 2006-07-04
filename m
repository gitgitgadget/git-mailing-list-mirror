From: Jeff King <peff@peff.net>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 3 Jul 2006 20:21:38 -0400
Message-ID: <20060704002138.GB5716@coredump.intra.peff.net>
References: <1151949764.4723.51.camel@neko.keithp.com> <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 04 02:21:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxYff-0001MG-JY
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 02:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750917AbWGDAVl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 20:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbWGDAVk
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 20:21:40 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:11181 "HELO
	peff.net") by vger.kernel.org with SMTP id S1750917AbWGDAVk (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 20:21:40 -0400
Received: (qmail 6452 invoked from network); 3 Jul 2006 20:21:18 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 3 Jul 2006 20:21:18 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon,  3 Jul 2006 20:21:38 -0400
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23226>

On Mon, Jul 03, 2006 at 04:14:10PM -0700, Linus Torvalds wrote:

> Well, you could use multiple branches in the same repository, even if they 
> are totally unrealated. That would allow you to fetch them all in one go.

One annoying thing about this is that you may want to have several of
the branches checked out at a time (i.e., you want the actual directory
structure of libXrandr/, Xorg/, etc). You could pull everything down
into one repo and point small pseudo-repos at it with alternates, but I
would think that would become a mess with pushes. You can do some magic
with read-tree --prefix, but again, I'm not sure how you'd make commits
on the correct branch.  Is there an easier way to do this?

> Basically, a repo that is up-to-date should do a "git fetch" about as 
> quickly as it does a "git ls-remote". Which in turn really shouldn't be 
> doing much anything at all, apart from the connect itself:

Fetching by ssh actually makes two ssh connections (the second is to
grab tags).

-Peff
