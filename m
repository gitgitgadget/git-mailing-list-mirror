From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 2/2] change all unchecked calls to setenv to xsetenv
Date: Tue, 13 Dec 2011 13:19:46 -0500
Message-ID: <20111213181946.GC1663@sigill.intra.peff.net>
References: <1323778227-1664-1-git-send-email-kusmabite@gmail.com>
 <1323778227-1664-2-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 13 19:19:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaWxF-0004lG-El
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 19:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754534Ab1LMSTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 13:19:48 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49698
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754080Ab1LMSTs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 13:19:48 -0500
Received: (qmail 22099 invoked by uid 107); 13 Dec 2011 18:26:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 13 Dec 2011 13:26:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2011 13:19:46 -0500
Content-Disposition: inline
In-Reply-To: <1323778227-1664-2-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187036>

On Tue, Dec 13, 2011 at 01:10:27PM +0100, Erik Faye-Lund wrote:

> While reviewing some patches for Git for Windows, I realized that
> we almost never check the return-value from setenv. This can lead
> to quite surprising errors in unusual sitations. Mostly, an error
> would probably be preferred. So here we go.
> 
> However, I'm not at all convinced myself that all of these make
> sense; in particular settings like GIT_EDITOR and GIT_PAGER could
> perhaps benefit from having a warning printed rather than a hard
> error.
> 
> Thoughts?

I wrote almost the same patch once[1], but failed to actually push it
through to acceptance. There weren't any objections, just that nobody
really cared.  I think it's a reasonable thing to do. The chances of
setenv failing are very low, but the consequences could be quite bad.

There is also a call to putenv in git.c which should be checked (or
could arguably just be converted to setenv).

-Peff

[1] http://thread.gmane.org/gmane.comp.version-control.git/134466
