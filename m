From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Jan 2016, #02; Mon, 11)
Date: Thu, 14 Jan 2016 05:21:35 -0500
Message-ID: <20160114102134.GD30772@sigill.intra.peff.net>
References: <xmqqlh7vvfxc.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1601120939270.2964@virtualbox>
 <xmqqtwmitz2a.fsf@gitster.mtv.corp.google.com>
 <20160112214909.GD2841@sigill.intra.peff.net>
 <xmqqtwmhkrj2.fsf@gitster.mtv.corp.google.com>
 <20160113232255.GA17937@sigill.intra.peff.net>
 <xmqqpox5kpsy.fsf@gitster.mtv.corp.google.com>
 <xmqqlh7tkpcy.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 11:21:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJf2L-0008Qq-Kv
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 11:21:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbcANKVj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 05:21:39 -0500
Received: from cloud.peff.net ([50.56.180.127]:53565 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753582AbcANKVh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 05:21:37 -0500
Received: (qmail 14845 invoked by uid 102); 14 Jan 2016 10:21:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 05:21:37 -0500
Received: (qmail 5538 invoked by uid 107); 14 Jan 2016 10:21:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 05:21:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2016 05:21:35 -0500
Content-Disposition: inline
In-Reply-To: <xmqqlh7tkpcy.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284029>

On Wed, Jan 13, 2016 at 03:54:05PM -0800, Junio C Hamano wrote:

> And after doing the obvious wholesale replacement on callers that
> hardcode either '\n' or '\0' with this:
> 
> #!/bin/sh
> perl -i -p -e '
> 	s/strbuf_getline\((.*?), '\''\\n'\''\)/strbuf_getline_lf($1)/g;
> 	s/strbuf_getline\((.*?), '\''\\0'\''\)/strbuf_getline_nul($1)/g;
> ' "$@"
> 
> the only direct callers of strbuf_getline() that remain in the tree
> are check-attr, check-ignore, checkout-index and mktree.
> 
> And the conversion of mktree would look like this.  I might further
> tweak it to rename and flip the polarity of lf_lines to nul_lines,
> but I do not think that matters very much.

Heh. I read your series first, and independently came up with the same
polarity-flipping thought. I agree it doesn't matter much, but maybe we
can count that as two votes. :)

-Peff
