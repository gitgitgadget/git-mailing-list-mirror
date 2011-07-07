From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 3/3] upload-archive: use start_command instead of fork
Date: Thu, 7 Jul 2011 18:27:26 -0400
Message-ID: <20110707222726.GA23424@sigill.intra.peff.net>
References: <1310038989-5724-1-git-send-email-kusmabite@gmail.com>
 <1310038989-5724-4-git-send-email-kusmabite@gmail.com>
 <20110707191528.GD12044@sigill.intra.peff.net>
 <CABPQNSYZqpfGwgQXqk4YFBXhSHTen1w7m2hwaF7YDsZmsaYY5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 08 00:27:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qex2j-000230-Vq
	for gcvg-git-2@lo.gmane.org; Fri, 08 Jul 2011 00:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752149Ab1GGW13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jul 2011 18:27:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51366
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab1GGW12 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2011 18:27:28 -0400
Received: (qmail 3193 invoked by uid 107); 7 Jul 2011 22:27:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Jul 2011 18:27:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Jul 2011 18:27:26 -0400
Content-Disposition: inline
In-Reply-To: <CABPQNSYZqpfGwgQXqk4YFBXhSHTen1w7m2hwaF7YDsZmsaYY5Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176784>

On Fri, Jul 08, 2011 at 12:25:00AM +0200, Erik Faye-Lund wrote:

> On Thu, Jul 7, 2011 at 9:15 PM, Jeff King <peff@peff.net> wrote:
> > On Thu, Jul 07, 2011 at 01:43:09PM +0200, Erik Faye-Lund wrote:
> >
> >> The POSIX-function fork is not supported on Windows. Use our
> >> start_command API instead.
> >
> > Is start_command the right solution? From my reading, the fork is
> > actually because we want to set up a sideband multiplexer. Should we not
> > just be using start_async() to start a thread, as we do in receive-pack?
> 
> I considered that, but discarded it because I figured it required me
> to plug through a file descriptor all the way through the code. But
> perhaps I was wrong, and dup2 will make that job a lot easier?

Yeah, exactly. The current code is already using dup2 in the same way.

-Peff
