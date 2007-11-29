From: Jeff King <peff@peff.net>
Subject: Re: Fix a pathological case in git detecting proper renames
Date: Thu, 29 Nov 2007 18:52:53 -0500
Message-ID: <20071129235253.GA10261@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net> <alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org> <28BD703B-24D3-41D6-8360-240A884B1305@kernel.crashing.org> <alpine.LFD.0.9999.0711291122050.8458@woody.linux-foundation.org> <41CB0B7D-5AC1-4703-BA99-21622A410F93@kernel.crashing.org> <alpine.LFD.0.9999.0711291303000.8458@woody.linux-foundation.org> <alpine.LFD.0.9999.0711291442300.8458@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kumar Gala <galak@kernel.crashing.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 00:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxtC0-00072S-L2
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 00:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763541AbXK2Xw5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 18:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763539AbXK2Xw5
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 18:52:57 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3590 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763429AbXK2Xw4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 18:52:56 -0500
Received: (qmail 30032 invoked by uid 111); 29 Nov 2007 23:52:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 29 Nov 2007 18:52:54 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Nov 2007 18:52:53 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.9999.0711291442300.8458@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66572>

On Thu, Nov 29, 2007 at 03:03:06PM -0800, Linus Torvalds wrote:

> This would probably become easier to do with the linear-time hash-based 
> similarity engine (the stuff Jeff King was working on), but the way the 
> code is currently structured - with no incremental rename detection at 
> all, and with all the scoring in one global table - it's pretty painful.

I think it will get worse, because you are simultaneously calculating
all of the similarity scores bit by bit rather than doing a loop. Though
perhaps you mean at the end you will end up with a list of src/dst pairs
sorted by score, and you can loop over that.

-Peff
