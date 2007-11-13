From: Jeff King <peff@peff.net>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 23:14:22 -0500
Message-ID: <20071113041422.GA9745@sigill.intra.peff.net>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com> <Pine.LNX.4.64.0711121412410.4362@racer.site> <9e4733910711120736g31e3e84cx5a213afc4b889de7@mail.gmail.com> <Pine.LNX.4.64.0711121613570.4362@racer.site> <9e4733910711120822x18019fe6v40eb8ee0e48282dd@mail.gmail.com> <Pine.LNX.4.64.0711121635130.4362@racer.site> <9e4733910711120921q651208cby1276426ccd4b5fa4@mail.gmail.com> <9e4733910711120928r6d9d08f0l22f3c6f0b2d80313@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 05:14:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrnAh-0003Fg-OZ
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 05:14:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012AbXKMEO1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 23:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753543AbXKMEO1
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 23:14:27 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4608 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753012AbXKMEO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 23:14:26 -0500
Received: (qmail 17208 invoked by uid 111); 13 Nov 2007 04:14:24 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 12 Nov 2007 23:14:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2007 23:14:22 -0500
Content-Disposition: inline
In-Reply-To: <9e4733910711120928r6d9d08f0l22f3c6f0b2d80313@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64746>

On Mon, Nov 12, 2007 at 12:28:28PM -0500, Jon Smirl wrote:

> Actually, fetching from kernel.org first and then switching the origin
> isn't helping. The host is http only since I can't get access to the
> git network port. When I pushed up my local repo it ends up in one big
> pack.
> 
> I do this:
> git clone kernel.org
> move the origin
> git pull
> -- it still pulls down the entire pack and takes an hour

Yep, the http fetch code doesn't understand about fetching parts of
packs (there was some discussion about using partial HTTP transfers, but
nobody seems to have cared enough to implement it).

> Will this fix it?
> at my remote host, first clone from kernel.org
> then push my local changes?

Yes, it should. The goal is to not put your changes and the upstream
commits in the same pack. You could also push _just_ the upstream
commits first, then in a different push, send your local changes. But
when they get pushed together, they all end up in the same pack.

-Peff
