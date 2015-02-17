From: Jeff King <peff@peff.net>
Subject: Re: 'make test' fails in pu
Date: Tue, 17 Feb 2015 03:55:10 -0500
Message-ID: <20150217085509.GC17174@peff.net>
References: <1424162357.30155.14.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Tue Feb 17 09:55:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNdw7-0000fb-SC
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 09:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933281AbbBQIzN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 03:55:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:49790 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933260AbbBQIzM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2015 03:55:12 -0500
Received: (qmail 13241 invoked by uid 102); 17 Feb 2015 08:55:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 02:55:12 -0600
Received: (qmail 5381 invoked by uid 107); 17 Feb 2015 08:55:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 Feb 2015 03:55:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Feb 2015 03:55:10 -0500
Content-Disposition: inline
In-Reply-To: <1424162357.30155.14.camel@kaarsemaker.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263938>

On Tue, Feb 17, 2015 at 09:39:17AM +0100, Dennis Kaarsemaker wrote:

> Make test has been failing for 'pu' yesterday for and today at
> t4016-diff-quote.sh. Full log:
> http://ci.kaarsemaker.net/git/refs/heads/pu/1df29c71a731c679de9055ae5e407f3a4e18740a/artefact/test/log
> 
> I noticed this a few times before and it tends to get fixed again
> relatively quickly. So I'm wondering:
> 
> - Should I even mention that it's failing, or is that just useless
>   noise?
> - If I should report this, I could also make my testing thing send 
>   mails. Would that be useful?

If you bisect this, it turns up commit 30cd8f94f, which says:

    WIP: diff-b-m

    [...]

    This update is still broken and breaks a handful of tests:
    
         4016 4023 4047 4130 6022 6031 6032 9300 9200 9300 9350

Sometimes a breakage in pu is surprising (e.g., it breaks only on a
platform that the maintainer does not run "make test" on) and we would
want to know about it. But sometimes it is merely that there is a
work-in-progress. And it probably requires a human to tell the
difference.

So no, I do not think automatically mailing on test failures in pu is a
good idea. Manually peeking at them and sending fixes before the series
is merged to next _is_ very much encouraged, though. :)

Unlike "pu", "next" and "master" should never fail tests (I think that
Junio will not push them out if the tests have failed on his system). So
failures there are much more likely to be interesting platform bugs (but
of course, testing "pu" is still encouraged, as we may catch problems).

But even for "next", I would say blind automated emails are not nearly
as useful as a human who has looked at the problem (and especially
bisected).

-Peff
