From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-protocol: clarify LF-handling in PKT-LINE()
Date: Thu, 3 Sep 2015 04:26:57 -0400
Message-ID: <20150903082657.GB20786@sigill.intra.peff.net>
References: <20150903080205.GA20182@sigill.intra.peff.net>
 <20150903082409.GA20786@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Dave Borowitz <dborowitz@google.com>,
	Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 03 10:27:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXPrO-0001ir-BA
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 10:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752369AbbICI1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Sep 2015 04:27:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:54275 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751408AbbICI07 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Sep 2015 04:26:59 -0400
Received: (qmail 12424 invoked by uid 102); 3 Sep 2015 08:26:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Sep 2015 03:26:59 -0500
Received: (qmail 8776 invoked by uid 107); 3 Sep 2015 08:27:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Sep 2015 04:27:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Sep 2015 04:26:57 -0400
Content-Disposition: inline
In-Reply-To: <20150903082409.GA20786@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277187>

On Thu, Sep 03, 2015 at 04:24:09AM -0400, Jeff King wrote:

> diff --git a/Documentation/technical/protocol-common.txt b/Documentation/technical/protocol-common.txt
> index 889985f..bf30167 100644
> --- a/Documentation/technical/protocol-common.txt
> +++ b/Documentation/technical/protocol-common.txt
> @@ -62,7 +62,10 @@ A pkt-line MAY contain binary data, so implementors MUST ensure
>  pkt-line parsing/formatting routines are 8-bit clean.
>  
>  A non-binary line SHOULD BE terminated by an LF, which if present
> -MUST be included in the total length.
> +MUST be included in the total length. Receivers MUST treat pkt-lines
> +with non-binary data the same whether or not they contain the trailing
> +LF (stripping the LF if present, and not complaining when it is
> +missing).

I noticed that this section leaves vague the question of "what is a
binary pkt-line". All of the PKT-LINE calls I tweaked in the grammar are
for non-binary instances. The only binary ones are described in the
sideband discussion of the "Packfile data" section, and there we do not
have a grammar.

So I think the result is reasonably clear, but I have far too much
intimate knowledge of git's protocol to be a good judge.

-Peff
