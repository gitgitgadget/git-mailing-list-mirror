From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] send-pack: tighten remote error reporting
Date: Sun, 18 Nov 2007 02:59:09 -0500
Message-ID: <20071118075908.GA24972@sigill.intra.peff.net>
References: <20071118055804.GA19313@sigill.intra.peff.net> <20071118071651.GB18467@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 08:59:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Itf43-0007C2-Ku
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 08:59:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbXKRH7O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 02:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbXKRH7O
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 02:59:14 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3722 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750991AbXKRH7N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 02:59:13 -0500
Received: (qmail 8759 invoked by uid 111); 18 Nov 2007 07:59:11 -0000
Received: from ppp-216-106-96-70.storm.ca (HELO sigill.intra.peff.net) (216.106.96.70)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 18 Nov 2007 02:59:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 18 Nov 2007 02:59:09 -0500
Content-Disposition: inline
In-Reply-To: <20071118071651.GB18467@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65346>

On Sun, Nov 18, 2007 at 02:16:52AM -0500, Jeff King wrote:

> +			print_ref_status('!', "[remote rejected]", ref,
> +					ref->deletion ? ref->peer_ref : NULL,
> +					ref->remote_status);

Gah, that should of course be:

  ref->deletion ? NULL : ref->peer_ref

> +		case REF_STATUS_EXPECTING_REPORT:
> +			print_ref_status('!', "[remote failure]", ref,
> +					ref->deletion ? ref->peer_ref : NULL,
> +					"remote failed to report status");

And the same here.

I had resisted making a test that checked the exact output format,
because such things are often a pain to keep up to date. But that's two
regressions in patches I've submitted that would have been caught. Maybe
I should just pay more attention.

-Peff
