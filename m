From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Thu, 6 Dec 2007 00:57:23 -0500
Message-ID: <20071206055723.GB23309@coredump.intra.peff.net>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org> <20071202212224.GA22117@midwinter.com> <20071203021333.GC8322@coredump.intra.peff.net> <7vlk8csetl.fsf@gitster.siamese.dyndns.org> <5920F34B-A94B-4C24-A95B-D35F35A4F0C0@midwinter.com> <7vhciwn5rl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 06 06:57:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J09k3-0007xN-30
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 06:57:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbXLFF51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 00:57:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbXLFF50
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 00:57:26 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2097 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751377AbXLFF50 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 00:57:26 -0500
Received: (qmail 28132 invoked by uid 111); 6 Dec 2007 05:57:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 06 Dec 2007 00:57:24 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Dec 2007 00:57:23 -0500
Content-Disposition: inline
In-Reply-To: <7vhciwn5rl.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67248>

On Wed, Dec 05, 2007 at 02:19:58PM -0800, Junio C Hamano wrote:

> > what rewriting was done by the server, and if another push happened in
> > the meantime, the client will have to basically guess about which
> > commits correspond to the ones it pushed.
> 
> Ok, but the output from fetch is meant to be human readable and we do
> not promise parsability, so if we go this route (which I think you made
> a sensible argument for) we would need a hook on the pushing end to act
> on this (perhaps record the correspondence of pushed and rewritten sha1
> somewhere for the hook's own use).

I am not clear on what you mean. Are you saying that the send-pack code
should _not_ recognize the "ok, but I rewrote your commit" status?
Because that is how we will avoid updating the tracking ref, which I
think is a good goal.

Or are you saying "it's ok to understand the 'ok, but...' response and
not update the tracking ref, but pulling the new hash from the message
is up to a hook on the pushing side"? Which I think it reasonable.

Or alternatively, "there should be a hook on the pushing side which is
allowed to set the ref status to 'ok, but don't bother updating the
tracking ref' or 'ok, but here is the actual thing to put in the
tracking ref'"? Which is also fine by me.

-Peff
