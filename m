From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-clone: use cpio's --quiet flag
Date: Sat, 4 Aug 2007 12:04:09 -0400
Message-ID: <20070804160409.GA16326@sigill.intra.peff.net>
References: <20070804070308.GA6493@coredump.intra.peff.net> <Pine.LNX.4.64.0708041636290.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Aug 04 18:04:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHM6y-00032T-Ha
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 18:04:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757901AbXHDQEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 12:04:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756988AbXHDQEN
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 12:04:13 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4362 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756203AbXHDQEM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 12:04:12 -0400
Received: (qmail 32336 invoked from network); 4 Aug 2007 16:04:16 -0000
Received: from unknown (HELO sigill.intra.peff.net) (10.0.0.7)
  by peff.net with (DHE-RSA-AES256-SHA encrypted) SMTP; 4 Aug 2007 16:04:16 -0000
Received: (qmail 16374 invoked by uid 1000); 4 Aug 2007 16:04:09 -0000
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0708041636290.14781@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54873>

On Sat, Aug 04, 2007 at 04:36:59PM +0100, Johannes Schindelin wrote:

> > $ git-clone foo bar
> > Initialized empty Git repository in ...
> > 0 blocks
> 
> According to http://www.opengroup.org/onlinepubs/7990989775/xcu/cpio.html, 
> cpio does not know about --quiet.  I think this is another GNUism...

Ugh, I didn't even think to check the spec, thanks for looking (I should
have been tipped off by the presence only of a long option).

I'm not sure what the best solution is...adding --quiet makes it totally
unportable, but that message almost looks like an error. We can redirect
stderr, but then we potentially miss real errors. I guess we could grep
it out.

-Peff
