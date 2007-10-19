From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] git-fetch: mega-terse fetch output
Date: Fri, 19 Oct 2007 02:46:20 -0400
Message-ID: <20071019064620.GA28932@coredump.intra.peff.net>
References: <20071019062219.GA28499@coredump.intra.peff.net> <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: David Symonds <dsymonds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 19 08:46:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iilcx-00011N-SI
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 08:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbXJSGqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 02:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754381AbXJSGqY
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 02:46:24 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3662 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751750AbXJSGqX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 02:46:23 -0400
Received: (qmail 9820 invoked by uid 111); 19 Oct 2007 06:46:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 19 Oct 2007 02:46:21 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Oct 2007 02:46:20 -0400
Content-Disposition: inline
In-Reply-To: <ee77f5c20710182339g30d025f0tfe74479d672ae36e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61659>

On Fri, Oct 19, 2007 at 04:39:56PM +1000, David Symonds wrote:

> What about making it even more terse so it's even easier to visually
> scan: (mainly thinking that fast-forwarding is so common it could be
> considered the "default")

Reasonable. I think it would be easier to scan if the fields were
column-aligned, but that requires making a few passes, which would
change the current code quite a bit. Or we could just fake it and give
it 20 characters for a branch name, padded with spaces.

> > ==> git://repo.or.cz/git/spearce.git
>  * gitk -> origin/gitk (new)

I miss the "branch" designator, personally. I do like the "new" to
differentiate from fast-forward.

>  * maint -> origin/maint
>  * master -> origin/master
>  * next -> origin/next
>  - pu -> origin/pu (refused)

I think this needs to explain why it was refused (non-fast forward,
refused). And you may still have:

 * pu -> origin/pu (non-fast forward)

for forced updates.

> ==> git://repo.or.cz/git/spearce.git
>  * tag v1.5.3.2

I am fine with that, as long as there aren't cases where we lose
information (i.e., where the local and remote tag names differ).

> Also, perhaps the trailing notes (fast forward, refused, etc.) should
> be significantly indented to the right to stand out even further from
> branch names that might be quite long.

Again, we could probably fake that by fixing the minimum column width of
the other fields.

-Peff
