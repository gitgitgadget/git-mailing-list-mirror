From: Jeff King <peff@peff.net>
Subject: Re: git fetch origin $SHA1 doesn't work as often as it could
Date: Wed, 18 May 2016 21:53:23 -0400
Message-ID: <20160519015323.GA24225@sigill.intra.peff.net>
References: <CAD0oC4yQzvAH=6a6Xgy6xOPoYCaO2zsDg5mDySkb6VJ6FdeeEQ@mail.gmail.com>
 <xmqq8tz7qb7d.fsf@gitster.mtv.corp.google.com>
 <CAD0oC4wezb8svOW5KHONLi5wQN+H_3xqPLoU_EZbtL5zAkdv_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: JP Sugarbroad <jpsugar@google.com>
X-From: git-owner@vger.kernel.org Thu May 19 03:53:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3D9X-0004Bj-T8
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 03:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753695AbcESBx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 21:53:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:41633 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753680AbcESBx0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 21:53:26 -0400
Received: (qmail 10467 invoked by uid 102); 19 May 2016 01:53:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 21:53:26 -0400
Received: (qmail 28603 invoked by uid 107); 19 May 2016 01:53:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 21:53:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 21:53:23 -0400
Content-Disposition: inline
In-Reply-To: <CAD0oC4wezb8svOW5KHONLi5wQN+H_3xqPLoU_EZbtL5zAkdv_Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295038>

On Wed, May 18, 2016 at 06:40:37PM -0400, JP Sugarbroad wrote:

> > I just fear that it is a wrong approach to solve the real issue and
> > instead make it worse by relieving the pressure from the project and
> > hosting site to configure their repository to support their users
> > properly.
> 
> Unfortunately I don't see the likes of github or bitbucket adding
> allow-reachable-sha1-in-want any time soon, as it is an expensive
> operation server-side.

I don't think it's _too_ bad, at least compared to some of the nastier
things one can convince the server side of a git fetch to do. It at
least looks at just the commits; the bad cases usually involve
traversing the whole object graph.

It's also something that's easily sped up with reachability bitmaps.

But I haven't done any real analysis on the kind of load it would cause.
So no promises, but I don't think it's outside the realm of possibility
for GitHub to enable, if it's something that would be useful to a lot of
people. I can't speak for Bitbucket. :)

-Peff
