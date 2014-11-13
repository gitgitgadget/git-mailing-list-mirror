From: Jeff King <peff@peff.net>
Subject: Re: TTY tests are unnecessarily suppressed under Mac OS
Date: Thu, 13 Nov 2014 15:20:00 -0500
Message-ID: <20141113201959.GD3869@peff.net>
References: <CAO2U3QhB6rSfJn5ODE8-n2XWuBw8BePqDpQbNdx6LyWy=OFbcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 21:21:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp0tf-0003Q2-Fd
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 21:21:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934070AbaKMUUD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 15:20:03 -0500
Received: from cloud.peff.net ([50.56.180.127]:40075 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933296AbaKMUUC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 15:20:02 -0500
Received: (qmail 14181 invoked by uid 102); 13 Nov 2014 20:20:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 14:20:01 -0600
Received: (qmail 30900 invoked by uid 107); 13 Nov 2014 20:20:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 13 Nov 2014 15:20:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2014 15:20:00 -0500
Content-Disposition: inline
In-Reply-To: <CAO2U3QhB6rSfJn5ODE8-n2XWuBw8BePqDpQbNdx6LyWy=OFbcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 12, 2014 at 02:25:52PM -0800, Michael Blume wrote:

> From lib_terminal.sh:
> 
> # Reading from the pty master seems to get stuck _sometimes_
> # on Mac OS X 10.5.0, using Perl 5.10.0 or 5.8.9.
> #
> # Reproduction recipe: run
> #
> # i=0
> # while ./test-terminal.perl echo hi $i
> # do
> # : $((i = $i + 1))
> # done
> #
> # After 2000 iterations or so it hangs.
> # https://rt.cpan.org/Ticket/Display.html?id=65692
> #
> test "$(uname -s)" != Darwin &&
> 
> I tried the reproduction recipe on my mac and couldn't reproduce, so
> it may make sense to take this switch out? In any case, I've set my
> automated mac build to include TTY tests

10.5.0 is pretty ancient at this point; I can well believe that the
upstream problem has been fixed. It would be nice if we knew in which
version it was fixed, though. Just dropping the restriction risks people
getting spurious failures if they are on an old enough version.

Do you want to roll a patch that checks $(uname) to see if we're on a
recent-enough version (where we can just be conservative, and assume
whatever version you have is the first one to fix it)?

-Peff
