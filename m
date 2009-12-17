From: Jeff King <peff@peff.net>
Subject: Re: diff attribute ignored by show and log -p
Date: Thu, 17 Dec 2009 15:24:59 -0500
Message-ID: <20091217202459.GC11367@sigill.intra.peff.net>
References: <76718490912162046k36e2a275gaf7672b38c7a63e4@mail.gmail.com>
 <76718490912162123r49f9bd90n8e032c144d0cdbac@mail.gmail.com>
 <20091217221740.6117@nanako3.lavabit.com>
 <76718490912170844i7d5f25d1hc32590b877dbf295@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 17 21:25:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLMuf-0007Dg-Ho
	for gcvg-git-2@lo.gmane.org; Thu, 17 Dec 2009 21:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759028AbZLQUZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 15:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762600AbZLQUZI
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 15:25:08 -0500
Received: from peff.net ([208.65.91.99]:47900 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759028AbZLQUZF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 15:25:05 -0500
Received: (qmail 25485 invoked by uid 107); 17 Dec 2009 20:29:37 -0000
Received: from c-71-206-170-120.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.170.120)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 17 Dec 2009 15:29:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Dec 2009 15:24:59 -0500
Content-Disposition: inline
In-Reply-To: <76718490912170844i7d5f25d1hc32590b877dbf295@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135381>

On Thu, Dec 17, 2009 at 11:44:16AM -0500, Jay Soffian wrote:

> > The need to give --ext-diff is mentioned in 72909be (Add diff-option
> > --ext-diff, 2007-06-30) but its log message doesn't 'explain' why external
> > diff isn't used by default and you need to pass that extra option.
> 
> "To prevent funky games with external diff engines, git-log and
> friends prevent external diff engines from being called."
> 
> Seemed reason enough to me.

I don't remember discussing it at that time, but much later when
touching the external diff code and adding textconv, Junio and I came to
the conclusion that textconv was reasonable to do as part of "git log
-p", as the result is just an internal conversion that still results in
a text diff. Whereas an external diff might be terribly confusing, as it
could be spawning graphical viewers or producing output which does not
match well with the log output.

> > Probably --ext-diff should be the default?
> 
> Or available via a config option anyway.

If you were going to do such a config option, it might make sense to
make it an attribute of the diff driver rather than a global "use
external diff". Then each diff driver could say "Yes, I am reasonable to
be run as part of log -p".

-Peff
