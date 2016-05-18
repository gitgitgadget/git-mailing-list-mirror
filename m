From: Jeff King <peff@peff.net>
Subject: Re: [Bug] git-log prints wrong unixtime with --date=format:%s
Date: Tue, 17 May 2016 20:58:25 -0400
Message-ID: <20160518005824.GA7120@sigill.intra.peff.net>
References: <87vb2d37ea.fsf@web.de>
 <8760ucoaus.fsf@web.de>
 <20160518004008.GA20007@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Michael Heerdegen <michael_heerdegen@web.de>
X-From: git-owner@vger.kernel.org Wed May 18 02:58:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2pop-0007sG-DA
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 02:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755424AbcERA63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 20:58:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:41054 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751513AbcERA62 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 20:58:28 -0400
Received: (qmail 24574 invoked by uid 102); 18 May 2016 00:58:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 20:58:27 -0400
Received: (qmail 19316 invoked by uid 107); 18 May 2016 00:58:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 17 May 2016 20:58:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 May 2016 20:58:25 -0400
Content-Disposition: inline
In-Reply-To: <20160518004008.GA20007@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294926>

On Tue, May 17, 2016 at 08:40:08PM -0400, Jeff King wrote:

> So we need some way to tell strftime "...and by the way, this is the
> timezone for the value we are currently feeding you." There isn't a slot
> in "struct tm" for that, but I think maybe you can hack around it by
> setting the global "timezone" variable (and then restoring it
> afterwards).

I tried a few obvious things, but couldn't make anything work. Setting
"timezone" manually seems to do nothing. It's supposed to be set by
putting the right thing in $TZ and then calling tzset(). So I tried
munging $TZ to something like "+0200". It did have _some_ effect, but I
couldn't get it to behave correctly in all situations. And using "%z"
and "%Z" always just gives GMT.

So I dunno. Perhaps there is some way to coax sane behavior out of
strftime, but I could not figure it out. Suggestions welcome.

-Peff
