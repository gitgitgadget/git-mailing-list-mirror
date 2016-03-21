From: Jeff King <peff@peff.net>
Subject: Re: When does git check for branch-X being uptodate with
 origin/branch-X?
Date: Mon, 21 Mar 2016 16:50:44 -0400
Message-ID: <20160321205043.GA436@sigill.intra.peff.net>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
 <20160321202810.GD32071@sigill.intra.peff.net>
 <CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Thomas Adam <thomas.adam22@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 21:50:52 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai6mp-0008Ru-3K
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 21:50:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757929AbcCUUur (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 16:50:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:35548 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757622AbcCUUuq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 16:50:46 -0400
Received: (qmail 7664 invoked by uid 102); 21 Mar 2016 20:50:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 16:50:46 -0400
Received: (qmail 9448 invoked by uid 107); 21 Mar 2016 20:51:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 21 Mar 2016 16:51:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Mar 2016 16:50:44 -0400
Content-Disposition: inline
In-Reply-To: <CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289460>

On Mon, Mar 21, 2016 at 08:43:17PM +0000, Thomas Adam wrote:

> On 21 March 2016 at 20:28, Jeff King <peff@peff.net> wrote:
> > We never contact other repositories unless explicitly asked to by
> > fetch, pull, push, etc. If you want to have the most up-to-date value
> > without merging, you can just "git fetch" to update the tracking
> > branches.
> 
> Thanks.  I understand how to use git-fetch, it's more a case of
> whether even printing that message is useful?  I appreciate it can
> only go on the cached value, but it is still misleading to print that
> in the case where the cache might not be up to date.  Of course,
> determining that is a different problem.

I don't think it is limited to this particular message. _Any_ operation
that uses the tracking branches is going to potentially be out of date
with respect to what has happened on a remote server (so any time you
look at @{upstream}, or do a "rebase" without an arguments, etc).

Those things are useful, even if your local tracking branch may not
reflect the latest value on the server. If there is anything to fix,
IMHO, it is for the documentation to make more clear the mental model
of the workflow of "fetch separately, then all other operations are
disconnected".

But that's just my opinion. Did you have some specific change you're
interested in? I don't think removing that message is productive; it
_is_ useful information. Perhaps it could be more clear that we are
talking about the tracking branch?

-Peff
