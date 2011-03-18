From: Jeff King <peff@peff.net>
Subject: Re: Sharing a massive distributed merge
Date: Fri, 18 Mar 2011 01:49:34 -0400
Message-ID: <20110318054934.GA7547@sigill.intra.peff.net>
References: <4D8119BE.2090208@workspacewhiz.com>
 <AANLkTim0TL5X8rKoBceK3nLA4JrtuftqkJDkRi0Lok0A@mail.gmail.com>
 <20110317063816.GD11931@sigill.intra.peff.net>
 <AANLkTikdXCo_3hGZSaW3+9x6gQ2_B3A=scWN-f3gMSY4@mail.gmail.com>
 <20110317073053.GI11931@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joshua Jensen <jjensen@workspacewhiz.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 06:49:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0SZF-0007gE-LG
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 06:49:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754205Ab1CRFtk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 01:49:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33369
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742Ab1CRFtj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 01:49:39 -0400
Received: (qmail 30611 invoked by uid 107); 18 Mar 2011 05:50:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 Mar 2011 01:50:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Mar 2011 01:49:34 -0400
Content-Disposition: inline
In-Reply-To: <20110317073053.GI11931@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169290>

On Thu, Mar 17, 2011 at 03:30:53AM -0400, Jeff King wrote:

> On Thu, Mar 17, 2011 at 03:04:14AM -0400, Jay Soffian wrote:
> 
> > On Thu, Mar 17, 2011 at 2:38 AM, Jeff King <peff@peff.net> wrote:
> > > [2] It really seems like the right command to get the list of resolved
> > > files would be "git diff-index" with either a diff-filter, or grepping
> > > the output of --name-status. But I couldn't convince it to show me
> > > unmerged files; the unmerged entries always just appeared as
> > > modifications (actually, deletions in --raw), which made them
> > > indistinguishable from modified resolutions.
> > 
> > I use this alias for getting unmerged files:
> > 
> > $ git help unmerged
> > `git unmerged' is aliased to `!git ls-files --unmerged | cut -f2 | uniq'
> 
> Yeah, that would work. Though we really want the list of _resolved_
> files. So you'd have to do something like:
> 
>   git ls-files --unmerged | cut -f2 | uniq >unmerged
>   git diff-index HEAD >all
>   comm -23 all unmerged
> 
> which is why I was hoping to do it with diff-index in the first place.

Hmph. An unrelated thread just contained the answer I wanted. It's:

  git diff-index --cached --name-status

which properly produces "U" entries. How's that for user-friendly?

-Peff
