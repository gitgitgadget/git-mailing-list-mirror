From: Jeff King <peff@peff.net>
Subject: Re: Git Questions
Date: Mon, 20 Aug 2007 06:06:00 -0400
Message-ID: <20070820100600.GA26843@coredump.intra.peff.net>
References: <1187603749.11595.10.camel@tom-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tom Schinckel <gunny01@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 12:06:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN49C-0002FH-85
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 12:06:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533AbXHTKGH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 06:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752117AbXHTKGG
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 06:06:06 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1410 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751484AbXHTKGF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 06:06:05 -0400
Received: (qmail 19940 invoked by uid 111); 20 Aug 2007 10:06:13 -0000
X-Spam-Status: No, hits=-1.4 required=15.0
	tests=ALL_TRUSTED,AWL
X-Spam-Check-By: peff.net
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Aug 2007 06:06:13 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Aug 2007 06:06:00 -0400
Content-Disposition: inline
In-Reply-To: <1187603749.11595.10.camel@tom-desktop>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56206>

On Mon, Aug 20, 2007 at 07:25:48PM +0930, Tom Schinckel wrote:

> Is it possible to change the revision numbers from long hashes to normal
> numbers (i.e, 0001 for first, 0002 for the second)

No, they are a fundamental part of the way git works. However, there are
a few ways you can avoid using the hashes:

 - tag your commits with readable names
 - use git's syntax for relative commits (e.g., "git-show HEAD~20") will
   show you 20 commits back from the current commit (where back is
   defined by following the first parent of each commit)

> a) Automatically commit a file to the repository every time it's saved

If you want git to notice when files are changed and commit them, then
no. You can probably configure your editor (or whatever is saving the
file) to trigger a 'git-add && git-commit'. But keep in mind this will
produce a lot of commits with lousy commit messages.

> b) Automatically use the default hashed-out bit:

There isn't an argument to git-commit to do this, but you can get the
same message from git-status. So you could do something like:

git-status | sed 's/^# //' | git-commit -F -

-Peff
