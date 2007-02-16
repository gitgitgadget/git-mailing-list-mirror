From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git -p status does not use colors
Date: Fri, 16 Feb 2007 10:56:58 -0500
Message-ID: <20070216155658.GB7183@coredump.intra.peff.net>
References: <20070216151925.GA28974@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 16 16:57:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HI5SM-0006OM-8E
	for gcvg-git@gmane.org; Fri, 16 Feb 2007 16:57:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945949AbXBPP5D (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Feb 2007 10:57:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945952AbXBPP5B
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Feb 2007 10:57:01 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4311 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1945949AbXBPP5A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Feb 2007 10:57:00 -0500
Received: (qmail 32163 invoked from network); 16 Feb 2007 10:57:07 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 16 Feb 2007 10:57:07 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Feb 2007 10:56:58 -0500
Content-Disposition: inline
In-Reply-To: <20070216151925.GA28974@moooo.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39923>

On Fri, Feb 16, 2007 at 04:19:25PM +0100, Matthias Lederhofer wrote:

> git -p status starts the pager, then runs git-commit.sh (named
> git-status) which in turn runs git-runstatus.  I guess the problem is
> that git-runstatus cannot check that the pager was started and just
> knows that stdout is no terminal.  Has anyone an idea how to fix
> this?

Your analysis looks right to me.  I think you would need to set
GIT_PAGER_IN_USE in the environment whenever you turn on the pager in
the git wrapper, and then set git's internal pager_in_use variable based
on that.

-Peff
