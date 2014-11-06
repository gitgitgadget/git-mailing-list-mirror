From: Jeff King <peff@peff.net>
Subject: Re: smart http push setup/egit win7
Date: Thu, 6 Nov 2014 00:40:35 -0500
Message-ID: <20141106054035.GB22835@peff.net>
References: <1743053007.847058.1415214689002.JavaMail.yahoo@jws106105.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan <Xvakon@rocketmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 06 06:40:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XmFoH-0000mz-0M
	for gcvg-git-2@plane.gmane.org; Thu, 06 Nov 2014 06:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbaKFFkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Nov 2014 00:40:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:37176 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750768AbaKFFkg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Nov 2014 00:40:36 -0500
Received: (qmail 20369 invoked by uid 102); 6 Nov 2014 05:40:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Nov 2014 23:40:36 -0600
Received: (qmail 31760 invoked by uid 107); 6 Nov 2014 05:40:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 06 Nov 2014 00:40:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Nov 2014 00:40:35 -0500
Content-Disposition: inline
In-Reply-To: <1743053007.847058.1415214689002.JavaMail.yahoo@jws106105.mail.bf1.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 05, 2014 at 07:11:29PM +0000, Jonathan wrote:

> The client can connect to and successfully fetch the repo from the
> server over https. However, when trying to push egit gives the error
> "remote does not support http push." When attempting a push via bash,
> I get "return code 22 - fatal: git-http-push failed."

Git will not allow a push unless the client is authenticated (and the
git client may fallback to trying dumb-http push-over-DAV, which you
likely haven't configured; that would explain the second error message).

The authentication check in http-backend checks whether $REMOTE_USER is
set. I see in your config that you set it from $REDIRECT_REMOTE_USER,
but I don't see any actual Auth directives. Do you need to add that
somewhere?

There are some Apache recipes in the git-http-backend manpage that might
help.

-Peff
