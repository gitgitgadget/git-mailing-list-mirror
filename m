From: Jeff King <peff@peff.net>
Subject: Re: multiple files for the same hook
Date: Tue, 13 May 2008 00:21:18 -0400
Message-ID: <20080513042118.GB4079@sigill.intra.peff.net>
References: <200805122039.49779.hto@arcor.de> <20080512204445.GT27724@genesis.frugalware.org> <200805122156.30896.hto@arcor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Hunger <hto@arcor.de>
X-From: git-owner@vger.kernel.org Tue May 13 06:22:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jvm1w-0002NA-Cg
	for gcvg-git-2@gmane.org; Tue, 13 May 2008 06:22:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbYEMEVW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2008 00:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753332AbYEMEVW
	(ORCPT <rfc822;git-outgoing>); Tue, 13 May 2008 00:21:22 -0400
Received: from peff.net ([208.65.91.99]:3685 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753312AbYEMEVW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2008 00:21:22 -0400
Received: (qmail 2053 invoked by uid 111); 13 May 2008 04:21:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 May 2008 00:21:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 May 2008 00:21:18 -0400
Content-Disposition: inline
In-Reply-To: <200805122156.30896.hto@arcor.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81985>

On Mon, May 12, 2008 at 09:56:30PM +0000, Thomas Hunger wrote:

> > why would you want so? just create a script named
> > hooks/post-commit, like:
> 
> you are right, it's what we actually do, using --template to set up 
> our own scripts. If nobody but us needs this it's certainly not worth 
> bothering.

The problem is that the semantics of calling some of the hooks is not as
simple as just calling them all in a row. How do you split up the input
going to the hooks? How do you combine the output coming from the hooks?
What is the resulting exit code? If one hook fails, do we indicate
failure? Or if one hook succeeds, do we indicate success?

So before any such code could go into git proper, there would have to be
agreement on how those issues are resolved. In the meantime, it probably
makes more sense to implement a "master" post-commit hook that uses the
semantics that you find useful.

-Peff
