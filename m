From: Jeff King <peff@peff.net>
Subject: Re: renaming remote branches
Date: Thu, 16 Apr 2009 04:18:35 -0400
Message-ID: <20090416081835.GA26972@coredump.intra.peff.net>
References: <buo3ac9jn18.fsf@dhlpc061.dev.necel.com> <20090416065934.GA20071@coredump.intra.peff.net> <buoab6h2fko.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Thu Apr 16 10:20:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuMpW-0001yG-0i
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 10:20:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbZDPISo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 04:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbZDPISn
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 04:18:43 -0400
Received: from peff.net ([208.65.91.99]:38276 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbZDPISm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 04:18:42 -0400
Received: (qmail 1073 invoked by uid 107); 16 Apr 2009 08:18:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 16 Apr 2009 04:18:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Apr 2009 04:18:35 -0400
Content-Disposition: inline
In-Reply-To: <buoab6h2fko.fsf@dhlpc061.dev.necel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116683>

On Thu, Apr 16, 2009 at 05:00:39PM +0900, Miles Bader wrote:

> > If you are not sharing your repo over a dumb transport (like http), then
> > the contents of .git/info/refs shouldn't matter. If you are, then you
> > should enable the post-update hook to run update-server-info after every
> > push (i.e., it is not just the deletion that is a problem, but none of
> > your pushes is being marked in .git/info/refs).
> 
> Hmmm, there's no way to update the hooks without shell access, right...?

No, not through any means shipped with git itself.  There are obvious
security implications to arbitrarily modifying hooks, since they are
runnable code. In other words, updating hooks is a great way to _get_
shell access. :)

There is no reason to forbid enabling hooks which have been pre-approved
by the site admin, but such a policy decision is outside the scope of
git itself.  The only mechanism git provides is the "templates" feature
of init (so that a site admin can apply the same hook setup to all
repos as they are created).

> [lots of stuff seems undoable without shell access, i.e., changing
> .git/descriptions; it'd be nice if there was at least some way to frob
> all this stuff ...]

In general, git takes the approach that users can edit files in .git/
directly, and for setups where they can't, it is up to the site admin to
make wrappers implementing whatever policy they want. Third party tools
can provide the mechanism for accomplishing that (I don't know what
support something like gitosis has for enabling hooks, updating
descriptions, or moving branches, though).

-Peff
