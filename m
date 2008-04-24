From: Jeff King <peff@peff.net>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 21:37:22 -0400
Message-ID: <20080424013722.GB31146@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness> <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com> <20080422023918.GA5402@sigill.intra.peff.net> <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com> <20080423080826.GA11935@sigill.intra.peff.net> <480F1671.2060602@viscovery.net> <20080423110402.GA27437@sigill.intra.peff.net> <480F218C.3060703@viscovery.net> <20080423214745.GA30057@sigill.intra.peff.net> <7vprsgqiq1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 03:38:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoqPX-0002Mf-A7
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 03:38:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753454AbYDXBhU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 21:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753412AbYDXBhU
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 21:37:20 -0400
Received: from peff.net ([208.65.91.99]:2674 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752605AbYDXBhT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 21:37:19 -0400
Received: (qmail 12333 invoked by uid 111); 24 Apr 2008 01:37:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 23 Apr 2008 21:37:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2008 21:37:22 -0400
Content-Disposition: inline
In-Reply-To: <7vprsgqiq1.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80283>

On Wed, Apr 23, 2008 at 04:01:10PM -0700, Junio C Hamano wrote:

> But once you start saying "even originally the same blob (i.e. identified
> by one object name) can be rewritten into different result, depending on
> where in the tree it appears", would it make sense to have blob filters to
> begin with?
> 
> Shouldn't that kind of of context sensitive (in the space dimension -- you
> can introduce the context sensitivity in the time dimension by saying
> there may even be cases where you would want to filter differently
> depending on the path and which commit the blob appears, which is even
> worse) filtering be best left to the tree or index filter?

Yes, that was my original reasoning. But I think the problem then is
that the blob filter isn't terribly useful. IOW, it is not really a
separate filter, but rather an optimizing pattern for an index filter,
so maybe calling it a blob filter is the wrong approach, and it would be
better as a short perl script in contrib/filter-branch. Then you could
call:

  git filter-branch --index-filter '
    /path/to/git/contrib/filter-branch/dos2unix \
      "*.txt" "*.c"
  '

-Peff
