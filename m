From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-send-email.perl: check for lines longer than 998
	characters
Date: Fri, 18 Jan 2008 09:16:39 -0500
Message-ID: <20080118141638.GA14928@coredump.intra.peff.net>
References: <20080117153252.GD2816@coredump.intra.peff.net> <1200642458-3280-1-git-send-email-ediap@users.sourceforge.net> <47905F70.5090003@viscovery.net> <4790746D.1000502@users.sourceforge.net> <47907914.6000105@viscovery.net> <7v1w8fh2ef.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Adam Piatyszek <ediap@users.sourceforge.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 15:17:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFs1y-0000Mj-Ay
	for gcvg-git-2@gmane.org; Fri, 18 Jan 2008 15:17:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759123AbYAROQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2008 09:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758100AbYAROQn
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jan 2008 09:16:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1436 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757972AbYAROQm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2008 09:16:42 -0500
Received: (qmail 18424 invoked by uid 111); 18 Jan 2008 14:16:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 18 Jan 2008 09:16:40 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jan 2008 09:16:39 -0500
Content-Disposition: inline
In-Reply-To: <7v1w8fh2ef.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71018>

On Fri, Jan 18, 2008 at 02:08:24AM -0800, Junio C Hamano wrote:

> On the other hand, git-send-email _is_ all about SMTP transfer.
> Perhaps a loop over input files upfront to check the line length
> limit, and warn if there are suspiciously long lines even before
> sending the first piece of e-mail out, would be a reasonable
> approach.

I think that is sensible. Patch series will follow:

  1/3: send-email: detect invocation errors earlier

       This is a code cleanup in preparation for 2/3, but has
       user-friendly side effects.

  2/3: send-email: validate patches before sending anything

       The actual up front long-lines check.

  3/3: send-email: add no-validate option

       A knob for users who know something send-email doesn't.

That at least detects the situation and lets the user deal with it (by
fixing the patch, or by sending it as an attachment with another MUA).
Probably there should be a

  4/3: send-email: add --encoding parameter

but I am not inclined to code it, especially this late in the release
freeze (though I think the first three are reasonable for v1.5.4, I am
also fine if you want to put them off -- I don't see this as a common
problem).

-Peff
