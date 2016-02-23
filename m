From: Jeff King <peff@peff.net>
Subject: Re: Git Daemon Dummy: 301 Redirects for git:// to https://
Date: Tue, 23 Feb 2016 01:15:17 -0500
Message-ID: <20160223061517.GA3252@sigill.intra.peff.net>
References: <CAHmME9rTpGNHMKbXD48oBYm136=u79YiHjX5hm8ZYC4xSThJsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
X-From: git-owner@vger.kernel.org Tue Feb 23 07:15:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aY6Fo-00071K-NA
	for gcvg-git-2@plane.gmane.org; Tue, 23 Feb 2016 07:15:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756941AbcBWGPV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Feb 2016 01:15:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:47324 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756890AbcBWGPU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Feb 2016 01:15:20 -0500
Received: (qmail 9334 invoked by uid 102); 23 Feb 2016 06:15:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 01:15:20 -0500
Received: (qmail 25927 invoked by uid 107); 23 Feb 2016 06:15:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Feb 2016 01:15:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Feb 2016 01:15:17 -0500
Content-Disposition: inline
In-Reply-To: <CAHmME9rTpGNHMKbXD48oBYm136=u79YiHjX5hm8ZYC4xSThJsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287021>

On Tue, Feb 23, 2016 at 03:32:02AM +0100, Jason A. Donenfeld wrote:

> In case anyone else finds this useful, I wrote this:
> 
> https://git.zx2c4.com/git-daemon-dummy/about/
> 
> It's an epoll-based responder for git:// that simply returns an error
> telling users of a new URI.

Neat.

> The purpose is to phase out git-daemon in
> favor of more secure TLS/HTTPS endpoints. With HTTPS certificates now
> being free, seems like this could be useful.

Yeah, the existence of HTTPS (and the fact that the same URL can be both
anonymous and authenticated) is nice. Unfortunately, git-over-https is
not as efficient as the other protocols, because it's not asynchronously
bi-directional. It would probably be relatively simple to make a
"gits://" protocol, but I think it would be more interesting still if we
could do git-over-websockets, to get the ubiquity benefits of HTTP.

I looked into it once, but was unable to find any reasonably sized
explanation of how to implement either the server or client side of
websockets. :)

> My personal motivation is that I'd like to just totally kill the
> git-daemon service, but somebody hard coded a URI of mine into a real
> printed textbook [1], so I don't want it to go stale suddenly. So, I
> need some way of informing users of the new URI.

Darn printed books. I thought the Ministry of Truth was supposed to take
care of keeping our facts up to date.

-Peff
