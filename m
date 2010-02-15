From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] for-each-ref --format='%(symref) %(symref:short)'
Date: Mon, 15 Feb 2010 03:39:24 -0500
Message-ID: <20100215083924.GA13636@coredump.intra.peff.net>
References: <1266093033-9526-1-git-send-email-gitster@pobox.com>
 <1266093033-9526-4-git-send-email-gitster@pobox.com>
 <20100214063243.GA20630@coredump.intra.peff.net>
 <7vy6iwp0oy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 09:39:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgwUI-0006P4-4H
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 09:39:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751938Ab0BOIjV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 03:39:21 -0500
Received: from peff.net ([208.65.91.99]:41708 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091Ab0BOIjU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 03:39:20 -0500
Received: (qmail 16810 invoked by uid 107); 15 Feb 2010 08:39:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Feb 2010 03:39:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2010 03:39:24 -0500
Content-Disposition: inline
In-Reply-To: <7vy6iwp0oy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139999>

On Sun, Feb 14, 2010 at 02:32:29AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It feels ugly that we need to re-resolve the ref when we simply threw
> > that information away earlier from when we called resolve_ref in
> > get_ref_dir...
> 
> It is true and I indeed thought about it while doing the patch, but "how
> often would we see symref in the entire refs list, and what percentage of
> callers would benefit from seeing this information?" stopped me from going
> further in that direction.

It is really only two code-paths (the one I mentioned, and the new one
you are adding). I was thinking that we had to pay the resolve_ref cost
for _every_ ref, symref or not, but that is not the case. Because we
pass along the flag, we can re-resolve only the few that need it.

So there is even less efficiency to be gained than I at first thought.
Let's just drop it, as it is such an invasive change for no good reason.

-Peff
