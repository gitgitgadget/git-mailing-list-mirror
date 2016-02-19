From: Jeff King <peff@peff.net>
Subject: Re: Test failures with GNU grep 2.23
Date: Fri, 19 Feb 2016 14:33:10 -0500
Message-ID: <20160219193310.GA1299@sigill.intra.peff.net>
References: <20160207162540.GK29880@serenity.lan>
 <20160219115928.GA10204@sigill.intra.peff.net>
 <xmqqmvqwd2ie.fsf@gitster.mtv.corp.google.com>
 <20160219192311.GB1766@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Feb 19 20:33:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWqnl-0002ep-Qg
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 20:33:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993301AbcBSTdO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 14:33:14 -0500
Received: from cloud.peff.net ([50.56.180.127]:45708 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1948962AbcBSTdN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 14:33:13 -0500
Received: (qmail 9954 invoked by uid 102); 19 Feb 2016 19:33:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 14:33:12 -0500
Received: (qmail 31801 invoked by uid 107); 19 Feb 2016 19:33:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Feb 2016 14:33:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Feb 2016 14:33:10 -0500
Content-Disposition: inline
In-Reply-To: <20160219192311.GB1766@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286746>

On Fri, Feb 19, 2016 at 07:23:11PM +0000, John Keeping wrote:

> I suspect that any grep that lacks "-a" also lacks binary file handling
> that will break these tests.  I found a Solaris grep that doesn't
> support "-a" and it treats these files as text.
> 
> From that perspective, it would be better to have a central place that
> deals with figuring out how to get grep to work for us.  Perhaps we need
> test_grep to get this right.  We already have test_cmp_bin() as a thin
> wrapper around cmp so I don't think this is completely unprecedented.

I think 99% of the time we are using grep for ascii text. As evidenced
by the number of test failures we see with the new grep, it is a small
minority that feed binary gibberish. I'd prefer if "-a" handling didn't
need to pollute anything outside of this narrow range of tests (and as
with my prereq suggestion, I am even find just skipping this narrow
range of tests on platforms with no "-a", though falling back to running
without "-a" is fine if it works).

-Peff
