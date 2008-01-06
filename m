From: Jeff King <peff@peff.net>
Subject: Re: rm and mv commands: should I use them?
Date: Sun, 6 Jan 2008 03:08:25 -0500
Message-ID: <20080106080825.GA9718@coredump.intra.peff.net>
References: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Hancock <redstarling@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 09:08:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JBQYu-00007v-5u
	for gcvg-git-2@gmane.org; Sun, 06 Jan 2008 09:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752539AbYAFII2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2008 03:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752265AbYAFII2
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Jan 2008 03:08:28 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1990 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751811AbYAFII1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2008 03:08:27 -0500
Received: (qmail 27333 invoked by uid 111); 6 Jan 2008 08:08:26 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 06 Jan 2008 03:08:26 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jan 2008 03:08:25 -0500
Content-Disposition: inline
In-Reply-To: <379EDA94-A67B-483A-BC5F-E961DD52AD0C@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69716>

On Sun, Jan 06, 2008 at 03:55:22PM +0800, Jon Hancock wrote:

> So, do I need to use git's mv and rm commands?  Can't I just rename, add, 
> and remove files using any means I like and then just ensure my "index" is 
> staged properly when I do a commit?

No, you don't need to use those commands. They really are just wrappers
that manipulate the working tree files and the index at the same time.
So instead of "git-mv a b" you can do "mv a b; git rm a; git add b".

> Additionally, is there a simple procedure with git to say: "I want to
> version exactly what is in my working tree.  If I removed something or
> added something, just handle it".  This is sort of what "git add ."
> does, but "git add" doesn't handling things I removed or moved,
> correct?

"git add ." will add the contents of any modified files to the index, as
well as add any untracked files (which may or may not be what you want).
It will not add removals. Try "git add -u" which updates all files that
git knows about (i.e., modifications and removals). You can also simply
use "git commit -a" which is the moral equivalent of "git add -u ; git
commit".

-Peff
