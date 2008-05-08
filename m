From: Jeff King <peff@peff.net>
Subject: Re: git gc & deleted branches
Date: Thu, 8 May 2008 14:39:26 -0400
Message-ID: <20080508183926.GA30613@sigill.intra.peff.net>
References: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Guido Ostkamp <git@ostkamp.fastmail.fm>
X-From: git-owner@vger.kernel.org Thu May 08 20:40:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuB2M-0003N2-EB
	for gcvg-git-2@gmane.org; Thu, 08 May 2008 20:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753765AbYEHSjZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2008 14:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbYEHSjZ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 14:39:25 -0400
Received: from peff.net ([208.65.91.99]:3451 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223AbYEHSjY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 14:39:24 -0400
Received: (qmail 13780 invoked by uid 111); 8 May 2008 18:39:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 08 May 2008 14:39:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 May 2008 14:39:26 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.10.0805081920160.8678@bianca.dialin.t-online.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81551>

On Thu, May 08, 2008 at 07:45:31PM +0200, Guido Ostkamp wrote:

> [gc]
>         reflogExpire = 0
>         reflogExpireUnreachable = 0
>         rerereresolved = 0
>         rerereunresolved = 0
>         packrefs = 1

git-gc uses a "safe" pruning mode, where it only prunes unreferenced
objects that are older than a certain period (this makes it safe to run
git-gc, even if other processes are creating objects at the same time).

So try

[gc]
        pruneExpire = now

Alternatively, you can just run 'git prune' manually instead of 'git
gc'.

> I also tried 'git-pack-refs --all' or 'git-pack-refs --prune' but to no  
> avail.

Those won't help at all; they are purely about moving refs from
individual files into the 'packed-refs' file.

-Peff
