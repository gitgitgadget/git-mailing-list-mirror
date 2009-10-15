From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Thu, 15 Oct 2009 09:52:28 -0700
Message-ID: <20091015165228.GO10505@spearce.org>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org> <1255065768-10428-2-git-send-email-spearce@spearce.org> <20091009195035.GA15153@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 15 19:01:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MyThM-0004nf-0q
	for gcvg-git-2@lo.gmane.org; Thu, 15 Oct 2009 19:01:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935136AbZJOQxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2009 12:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935096AbZJOQxG
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Oct 2009 12:53:06 -0400
Received: from george.spearce.org ([209.20.77.23]:51812 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935106AbZJOQxF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Oct 2009 12:53:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 7B4F1381FE; Thu, 15 Oct 2009 16:52:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20091009195035.GA15153@coredump.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130402>

Jeff King <peff@peff.net> wrote:
> On Thu, Oct 08, 2009 at 10:22:45PM -0700, Shawn O. Pearce wrote:
> > +Servers MUST NOT require HTTP cookies for the purposes of
> > +authentication or access control.
> > [...]
> > +Servers MUST NOT require HTTP cookies in order to function correctly.
> 
> Why not? I can grant that the current git implementation probably can't
> handle it, but keep in mind this is talking about the protocol and not
> the implementation.

Good point... this document is about trying to explain the common
functionality that everyone can agree on.

> And I can see it being useful for sites like github
> which already have a cookie-based login.

What I'm concerned about is using the cookie jar.  My Mac OS X
laptop has 5 browsers installed, each with their own #@!*! cookie
jar: Safari, Opera, Firefox, Camino, Google Chrome.  How the hell
is the git client going to be able to use those cookies in order
to interact with a website that requires cookie authentication?

> Adapting the client to handle
> this case would not be too difficult (it would just mean keeping cookie
> state in a file between runs,

Saving our own cookie jar is easy, libcurl has some limited cookie
jar support already built in.  We just have to enable it.

> or even just pulling it out of the normal
> browser's cookie store).

See above, I don't think this will be very easy.

> And people whose client didn't do this would
> simply get an "access denied" response code.

And then they will email git ML or ask on #git why their git client
can't speak to some random website... and its because they used
"lynx" or yet-another-browser whose cookie jar format we can't read.

> Is there a technical reason not to allow it?

Not technical, but I want to reduce the amount of complexity that
a conforming client has to deal with to reduce support costs for
everyone involved.

I weakend the sections on cookies:

+ Authentication
+ --------------
....
+ Servers SHOULD NOT require HTTP cookies for the purposes of
+ authentication or access control.

and that's all we say on the matter.  I took out the Servers MUST
NOT line under session state.

-- 
Shawn.
