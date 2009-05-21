From: Jeff King <peff@peff.net>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 23:47:40 -0400
Message-ID: <20090521034739.GA8091@sigill.intra.peff.net>
References: <alpine.LFD.2.00.0905192300070.3906@xanadu.home> <20090520032139.GB10212@coredump.intra.peff.net> <alpine.LFD.2.00.0905192328310.3906@xanadu.home> <025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com> <alpine.LFD.2.00.0905200853010.3906@xanadu.home> <96BC1064-EEEF-48BC-B79A-9D15C517CF47@wincent.com> <alpine.LFD.2.00.0905201144040.3906@xanadu.home> <fabb9a1e0905200913u5252973aia9a20983b20243d3@mail.gmail.com> <20090520165854.GA23031@coredump.intra.peff.net> <alpine.LFD.2.00.0905201358000.3906@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git List <git@vger.kernel.org>,
	Wincent Colaiuta <win@wincent.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu May 21 05:47:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6zG9-0001Hx-TS
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 05:47:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754859AbZEUDrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2009 23:47:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754534AbZEUDrk
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 23:47:40 -0400
Received: from peff.net ([208.65.91.99]:57286 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754480AbZEUDrk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2009 23:47:40 -0400
Received: (qmail 12098 invoked by uid 107); 21 May 2009 03:47:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 20 May 2009 23:47:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 May 2009 23:47:40 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905201358000.3906@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119650>

On Wed, May 20, 2009 at 02:04:58PM -0400, Nicolas Pitre wrote:

> > I was envisioning a reflog of tree objects, so you could do:
> [...]
> Even simpler (for the user) would be to create a full commit with a 
> synthetic message.  The advantage is that the commit would have for 
> parent the HEAD commit at the moment the operation leading to the reflog 
> entry was made, with the date tag, etc.  The message could even contain 

I think you are right that this is better. I was trying to save the
creation of an extra commit object, but it probably is not that big a
deal (as Junio mentioned, we may already be creating multiple tree
objects). And having parent information is much richer for doing actual
merges of the changes introduced by that reflog commit, not just pulling
out individual pieces of its state.

So forget my idea of storing trees; it should definitely be commits.

-Peff
