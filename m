From: Jeff King <peff@peff.net>
Subject: Re: Deleting remote branch pointed by remote HEAD
Date: Wed, 21 Jan 2009 14:14:08 -0500
Message-ID: <20090121191408.GA22958@coredump.intra.peff.net>
References: <e29894ca0901210502n1ed1187bm46669a402ab4fe48@mail.gmail.com> <49773240.7090605@drmicha.warpmail.net> <e29894ca0901210638t636de791sf27d28893a7a0b65@mail.gmail.com> <49773E48.90302@drmicha.warpmail.net> <20090121161940.GA20702@coredump.intra.peff.net> <alpine.LNX.1.00.0901211237530.19665@iabervon.org> <20090121191219.GD21686@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	=?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 21 20:15:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPiY1-0004bx-SJ
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 20:15:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbZAUTOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2009 14:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbZAUTOL
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Jan 2009 14:14:11 -0500
Received: from peff.net ([208.65.91.99]:53667 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750750AbZAUTOK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2009 14:14:10 -0500
Received: (qmail 16979 invoked by uid 107); 21 Jan 2009 19:14:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 21 Jan 2009 14:14:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jan 2009 14:14:08 -0500
Content-Disposition: inline
In-Reply-To: <20090121191219.GD21686@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106648>

On Wed, Jan 21, 2009 at 02:12:19PM -0500, Jeff King wrote:

> > I think it might be more appropriate to just care less about a broken 
> > symref, explain what's wrong if the user actually tries to use it, and 
> > otherwise mostly ignore it.
> 
> I thought about that, but I still wonder if deleting it when the
> pointed-to ref is deleted might be more convenient. Remember that
> "refs/remotes/$foo/HEAD" can be accessed by a shorthand "$foo". So that
> means it can impact ref ambiguity lookup. I guess the chance of that
> happening is fairly unlikely, though.

Not to mention that even without others refs with matching names, it is
probably nicer to the user who does try to access it via "$foo" to
simply say "there is no $foo" rather than a confusing error message
about a deleted branch that they have to manually fix. And that is
easily accomplished by deleting such a bogus symref.

-Peff
