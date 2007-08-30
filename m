From: Jeff King <peff@peff.net>
Subject: Re: Visualising stashed commits in gitk/qgit/giggle
Date: Thu, 30 Aug 2007 04:29:12 -0400
Message-ID: <20070830082912.GB6097@coredump.intra.peff.net>
References: <46a038f90708291738h6a399d7bs4dd6778c8815390a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 10:29:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQfOy-0001hs-B6
	for gcvg-git@gmane.org; Thu, 30 Aug 2007 10:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755937AbXH3I3Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 04:29:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755815AbXH3I3Q
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 04:29:16 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4934 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754817AbXH3I3P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 04:29:15 -0400
Received: (qmail 4745 invoked by uid 111); 30 Aug 2007 08:29:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 30 Aug 2007 04:29:14 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2007 04:29:12 -0400
Content-Disposition: inline
In-Reply-To: <46a038f90708291738h6a399d7bs4dd6778c8815390a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57012>

On Thu, Aug 30, 2007 at 12:38:35PM +1200, Martin Langhoff wrote:

> Now that we have had git stash in master for a while, I've gotten
> completely addicted to it. :-) Before I used to create mini branches
> all the time, and my working repos were littered with 'WIP-nn'
> branches everywhere.
> 
> Which was mucky... but appeared in gitk/qgit transparently.
> 
> Is there any way to get them to appear in gitk or any other gui
> history browser?

The stash list is stored as a reflog, so any browser that understands
reflogs will visualize them fine. gitk's visualization of reflogs (gitk
-g) tends to be a bit cluttered, because it finds and displays the real
parents, which doesn't quite mesh with the reflog-ordered view of
history. You can try "gitk stash" to see the structure of the latest
stash, and you can try "gitk -g stash", but it's pretty unreadable.

You really need another way to get the refs into gitk's view without
using '-g'. You can do this: "gitk stash@{0} stash@{1} stash@{2}" which
looks OK, but doesn't scale for obvious reasons.

Tig actually displays reflogs nicely, because it has a much simpler
concept of viewing history. 'tig -g stash' will give you the stashes, in
order, for inspection.

Perhaps not the answer you were looking for, but it might give you a
start on implementing something. What kind of display were you looking
for? A view of the stashes as if they were a chain of commits (like tig
gives), or the stashes inserted into the full history graph (like gitk
stash@{0} stash@{1})?

-Peff
