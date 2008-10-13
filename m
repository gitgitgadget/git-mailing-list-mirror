From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] diff text conversion filter
Date: Sun, 12 Oct 2008 21:29:35 -0400
Message-ID: <20081013012935.GF3768@coredump.intra.peff.net>
References: <20080930164545.GA20305@sigill.intra.peff.net> <20081005214114.GA21875@coredump.intra.peff.net> <48E9B036.6090805@viscovery.net> <vpqtzbpwy9h.fsf@bauges.imag.fr> <20081007012044.GA4217@coredump.intra.peff.net> <48EAF902.3040402@viscovery.net> <20081007060014.GA7965@coredump.intra.peff.net> <vpqprmdlylq.fsf@bauges.imag.fr> <20081007154646.GB26531@coredump.intra.peff.net> <48EB8B1C.9060201@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Oct 13 03:30:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpCGn-0006uF-Mc
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 03:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916AbYJMB3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 21:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754223AbYJMB3i
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 21:29:38 -0400
Received: from peff.net ([208.65.91.99]:1930 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751749AbYJMB3i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 21:29:38 -0400
Received: (qmail 5396 invoked by uid 111); 13 Oct 2008 01:29:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 12 Oct 2008 21:29:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 12 Oct 2008 21:29:35 -0400
Content-Disposition: inline
In-Reply-To: <48EB8B1C.9060201@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98071>

On Tue, Oct 07, 2008 at 06:15:24PM +0200, Johannes Sixt wrote:

> and that should be sufficient. I'm proposing this heuristics:
> 
>  * If only textconv is given, all porcelains pick it.
>  * If only command is given, all porcelains pick it.
>  * If both are given, then
>    - git log picks textconv.
>    - git show and git diff:
>      . if exactly one pathspec was given, pick command;
>      . otherwise pick textconv

I am not 100% convinced that is sufficient, given Matthieu's other post.
But I will not personally be using external diff at all, so I am hard
pressed to come up with a counter example.

> Plumbing never picks any of them, just like today, nor should git
> format-patch. The are other porcelains that could be sorted into this
> list, like git blame and (the summary line of) git commit.

Actually, I think blaming a text-conv'd version would be useful (at
least for my case). But cleary it should be optional, and probably
defaulting to off.

Once again, I think this is a good reason to move to an explicit diff
option for "respect textconv" rather than relying on maybe or maybe not
loading the config.

> BTW, please don't take git-gui as an example that would lauch MS-Word on
> each diff. (Neither would gitk.) Both rely on plumbing, and that's good.
> gitk has a menu entry "External diff", where the diff.doc.command could be
> hooked into.

But they are both porcelain. So in theory, they could behave differently
depending on what config is available (or if not them, some other
third-party porcelain). But I was just responding to Matthieu's
use-case, so I am not sure what exactly people prefer; I am lucky enough
not to version any MS-Word documents at all. :)

-Peff
