From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Round-down years in "years+months" relative date view
Date: Fri, 28 Aug 2009 11:02:12 -0400
Message-ID: <20090828150212.GA6013@coredump.intra.peff.net>
References: <4A97193A.8090502@facebook.com>
 <20090828060538.GA22416@coredump.intra.peff.net>
 <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 17:02:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh2y8-0002i9-4Y
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 17:02:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751267AbZH1PCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 11:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751206AbZH1PCO
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 11:02:14 -0400
Received: from peff.net ([208.65.91.99]:42932 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035AbZH1PCN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 11:02:13 -0400
Received: (qmail 5735 invoked by uid 107); 28 Aug 2009 15:02:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 28 Aug 2009 11:02:23 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Aug 2009 11:02:12 -0400
Content-Disposition: inline
In-Reply-To: <81b0412b0908280058i364bfb83nb04354d982abc053@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127300>

On Fri, Aug 28, 2009 at 09:58:27AM +0200, Alex Riesen wrote:

> > I couldn't find any tests related to relative date processing, so it
> > would be really nice to have some. But I'm not sure of the best way to
> > do it without dealing with race conditions. Annoyingly, show_date calls
> > gettimeofday at a pretty low level, so there isn't a way of
> > instrumenting it short of LD_PRELOAD trickery (which is probably not
> > very portable).
> 
> Maybe better prepare the _test_ so that it uses current time and time
> arithmetics then put yet another cludge in operational code? Especially
> when we already have a greate number of GIT_ environment variables,
> documented nowhere, with effects not immediately obvious:

But that's the point: you can't do that without a race condition. Your
test gets a sense of the current time, then runs git, which checks the
current time again. How many seconds elapsed between the two checks?

I guess it is good enough for testing large time spans, but I was hoping
for a comprehensive time test.

-Peff
