From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] trace: give repo_setup trace its own key
Date: Thu, 24 Feb 2011 11:05:55 -0500
Message-ID: <20110224160555.GB30275@sigill.intra.peff.net>
References: <20110224142308.GA15356@sigill.intra.peff.net>
 <20110224143030.GH15477@sigill.intra.peff.net>
 <4D668076.7020000@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Feb 24 17:06:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Psdhc-0001Eu-D0
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 17:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756162Ab1BXQF6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 11:05:58 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58940 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756154Ab1BXQF4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 11:05:56 -0500
Received: (qmail 25432 invoked by uid 111); 24 Feb 2011 16:05:55 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 16:05:55 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 11:05:55 -0500
Content-Disposition: inline
In-Reply-To: <4D668076.7020000@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167830>

On Thu, Feb 24, 2011 at 04:59:50PM +0100, Andreas Ericsson wrote:

> On 02/24/2011 03:30 PM, Jeff King wrote:
> > You no longer get this output with GIT_TRACE=1; instead, you
> > can do GIT_TRACE_SETUP=1.
> > 
> 
> It would be beneficial if GIT_TRACE still turned on tracing globally
> so one doesn't have to know all flags to start tracing for errors.
> 
> I also imagine running GIT_TRACE=1 <command> as the first step would
> be quite useful for when one's not entirely certain where the problem
> lies and then use the specific tracing flag when trying to fix it.

Yeah, I considered that GIT_TRACE should become "trace everything" and
the existing traces split up into specific keys. I had a few concerns:

  - Having this splitting mechanism gives us room to add debugging code
    that is probably not interesting, but may be if you are working on a
    specific problem, without having to worry about spamming people.
    Which means GIT_TRACE may eventually become unreadably verbose.

    Maybe GIT_TRACE should include some traces, but not others (like
    packet debugging, or giant diff state dumps).

  - I didn't want to change the meaning of GIT_TRACE too much, because
    it is advice that everybody knows (in docs, mailing list archives,
    etc).

But those are not strong objections. Just giving the rationale I used
while writing the patches. I'd be curious what others think.

-Peff
