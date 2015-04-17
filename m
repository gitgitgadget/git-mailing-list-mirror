From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] reachable: only mark local objects as recent
Date: Fri, 17 Apr 2015 09:28:25 -0400
Message-ID: <20150417132824.GA13192@peff.net>
References: <20150327113240.GA7781@peff.net>
 <xmqqa8yyw9je.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 17 15:28:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yj6Jt-0005B5-E9
	for gcvg-git-2@plane.gmane.org; Fri, 17 Apr 2015 15:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790AbbDQN23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2015 09:28:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:46682 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752740AbbDQN21 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Apr 2015 09:28:27 -0400
Received: (qmail 32632 invoked by uid 102); 17 Apr 2015 13:28:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 08:28:27 -0500
Received: (qmail 1751 invoked by uid 107); 17 Apr 2015 13:28:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Apr 2015 09:28:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Apr 2015 09:28:25 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa8yyw9je.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267354>

On Fri, Mar 27, 2015 at 12:00:05PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It is possible that we may drop an object that is depended
> > upon by another object in the alternate. For example,
> > imagine two repositories, A and B, with A pointing to B as
> > an alternate. Now imagine a commit that is in B which
> > references a tree that is only in A. Traversing from recent
> > objects in B might prevent A from dropping that tree. But
> > this case isn't worth covering. Repo B should take
> > responsibility for its own objects. It would never have had
> > the commit in the first place if it did not also have the
> > tree, and assuming it is using the same "keep recent chunks
> > of history" scheme, then it would itself keep the tree, as
> > well.
> 
> In other words, if you have a loop in dependency chain among
> alternate repositories, your set-up is broken by definition.
> 
> Which makes sense to me.
> 
> Thanks.

I don't see this patch in "pu" or "What's Cooking" at all. Did it get
dropped?

It does fix a performance regression, but the problem is in v2.2, so I
don't think it's urgent for v2.4-rc.

-Peff
