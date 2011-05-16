From: Jeff King <peff@peff.net>
Subject: Re: git cherry-pick --strategy=resolve segfaults if picking a root
 commit
Date: Mon, 16 May 2011 06:27:44 -0400
Message-ID: <20110516102744.GA23286@sigill.intra.peff.net>
References: <iqgbvs$pm5$1@dough.gmane.org>
 <20110512104558.GA22108@sigill.intra.peff.net>
 <20110512110855.GA5240@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 16 12:27:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLv1n-00019Q-Px
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 12:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754566Ab1EPK1t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 06:27:49 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46627
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754382Ab1EPK1t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 06:27:49 -0400
Received: (qmail 12884 invoked by uid 107); 16 May 2011 10:29:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 May 2011 06:29:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2011 06:27:44 -0400
Content-Disposition: inline
In-Reply-To: <20110512110855.GA5240@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173721>

On Thu, May 12, 2011 at 07:08:55AM -0400, Jeff King wrote:

> On Thu, May 12, 2011 at 06:45:58AM -0400, Jeff King wrote:
> 
> > So probably we should:
> > 
> >   1. Pass the empty tree along to merge-resolve. This will take a little
> >      bit of refactoring, but more importantly, it means we will be
> >      passing a tree-ish and not a commit-ish to a merge strategy. Is
> >      that OK?
> > 
> >   2. Consider lifting the restriction on reverting root commits. If we
> >      can cherry-pick it, we can revert it, so I suspect this would
> >      already work with merge-recursive, but I didn't try. I don't care
> >      too much either way, though; I doubt it's something people would do
> >      a lot. It just seems like an unnecessary restriction.
> 
> This turned out to be quite easy. git-merge-resolve handles the tree-ish
> argument just fine. But it's possible other merge helpers might not be
> so happy. I dunno.
> 
> The series is:
> 
>   [1/3]: cherry-pick: handle root commits with external strategies
>   [2/3]: revert: allow reverting a root commit
>   [3/3]: t3503: test cherry picking and reverting root commits

Junio,

I seem to recall seeing an email from you saying that merge-helpers need
to handle tree-ish arguments, so this is an OK direction to go. But now
I can't seem to find it. Did I dream it?

If that is the case, then I think this series is worth picking up. So I
thought I'd prod you on it (I'm happy to repost, too, if that's easier).

-Peff
