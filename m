From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] do not mangle short options which take arguments
Date: Fri, 2 Oct 2009 03:57:24 -0400
Message-ID: <20091002075724.GC27664@coredump.intra.peff.net>
References: <20090925233226.GC14660@spearce.org>
 <20091001201648.GA12175@localhost>
 <20091002061159.GA24892@coredump.intra.peff.net>
 <20091002073628.GA9444@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Fri Oct 02 09:57:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mtd1G-00006C-AA
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 09:57:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911AbZJBH51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Oct 2009 03:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756897AbZJBH51
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 03:57:27 -0400
Received: from peff.net ([208.65.91.99]:59238 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756832AbZJBH50 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Oct 2009 03:57:26 -0400
Received: (qmail 26404 invoked by uid 107); 2 Oct 2009 08:00:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 02 Oct 2009 04:00:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Oct 2009 03:57:24 -0400
Content-Disposition: inline
In-Reply-To: <20091002073628.GA9444@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129427>

On Fri, Oct 02, 2009 at 09:36:28AM +0200, Clemens Buchacher wrote:

> Yes, that syntax looks reasonable. I expect this to be more involved, so I
> will rework the patch once we agree on whether or not we want it at all.

Thanks.

> Yes, that can happen. On the other hand, the "-ammend" typo actually did
> happen.

It did, but we are only guessing at how many people will be disrupted by
the new rule. That being said...

> And what I'm even more worried about are ambiguities like
> 
>   $ git commit -uno <path>
>   $ git commit -nou <path>
> 
> which are interpreted as one of
> 
>   $ git commit --untracked-files=no <path>
>   $ git commit --untracked-files --no-verify --only <path>

Making this clearer is a much more compelling argument to me. Though I
thought it was customary (not just for git, but for other programs) that
a short option that takes a parameter (even an optional one) would
consume the rest of a short options string. Still, it is a potential
source of confusion.

> > On the other hand, the cuddled value already has some DWYM magic (it
> > recognizes -amend), so it is already a little bit unsafe to use
> 
> Well, an error message is a lot safer than executing something you did not
> intend.

It's also an error exit code, which can affect how a script performs
(e.g., "git diff --exit-code"). But I don't have any real examples off
the top of my head of how this could be particularly disastrous, so feel
free to dismiss that as pushing too far into the hypothetical.

-Peff
