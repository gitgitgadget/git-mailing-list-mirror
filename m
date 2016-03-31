From: Jeff King <peff@peff.net>
Subject: Re: BUG in git diff-index
Date: Thu, 31 Mar 2016 10:27:04 -0400
Message-ID: <20160331142704.GC31116@sigill.intra.peff.net>
References: <loom.20160331T143733-916@post.gmane.org>
 <20160331140515.GA31116@sigill.intra.peff.net>
 <CAJxkE8SVF_ikHqDCh6eHExq=seitHPVpxW2GmPo40jtqWvz1JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Andy Lowry <andy.work@nglowry.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 16:27:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aldZ2-0004o7-Vb
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 16:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756911AbcCaO1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 10:27:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:41504 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754321AbcCaO1H (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 10:27:07 -0400
Received: (qmail 20268 invoked by uid 102); 31 Mar 2016 14:27:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 10:27:07 -0400
Received: (qmail 13064 invoked by uid 107); 31 Mar 2016 14:27:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 31 Mar 2016 10:27:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2016 10:27:04 -0400
Content-Disposition: inline
In-Reply-To: <CAJxkE8SVF_ikHqDCh6eHExq=seitHPVpxW2GmPo40jtqWvz1JQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290388>

On Thu, Mar 31, 2016 at 10:12:07AM -0400, Andy Lowry wrote:

> What I'm actually after is a tree-to-filesystem comparison, regardless
> of index. I've currently got a "diff" thrown in as a "work-around"
> before "diff-index", but  now I understand it's not a workaround at
> all. If there's a better way to achieve what I'm after, I'd appreciate
> a tip. Otherwise I'll just change the comments explaining why there's
> a "diff" in my script.

If your workaround is just to refresh the index, then you can do "git
update-index --refresh", rather than diff.

I don't think there is a plumbing command to do a direct
filesystem-to-tree comparison without having an index at all. "git diff
<treeish>" claims in the documentation to do so, but besides not being
plumbing, I think it is really just doing the same thing as diff-index,
under the hood. The index is a pretty fundamental part of git's view of
the working tree.

-Peff
