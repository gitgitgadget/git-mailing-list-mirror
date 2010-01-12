From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] strbuf: add strbuf_percentquote_buf
Date: Tue, 12 Jan 2010 11:18:59 -0500
Message-ID: <20100112161859.GA5649@coredump.intra.peff.net>
References: <20100112153656.GA24840@coredump.intra.peff.net>
 <20100112154153.GB24957@coredump.intra.peff.net>
 <alpine.DEB.1.00.1001121718210.4985@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Adam Megacz <adam@megacz.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 12 17:19:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUjSc-00017r-RF
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jan 2010 17:19:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036Ab0ALQTJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2010 11:19:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024Ab0ALQTJ
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jan 2010 11:19:09 -0500
Received: from peff.net ([208.65.91.99]:33218 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753719Ab0ALQTI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2010 11:19:08 -0500
Received: (qmail 8269 invoked by uid 107); 12 Jan 2010 16:23:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 12 Jan 2010 11:23:57 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jan 2010 11:18:59 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.1001121718210.4985@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136733>

On Tue, Jan 12, 2010 at 05:19:21PM +0100, Johannes Schindelin wrote:

> > This is handy for creating strings which will be fed to
> > strbuf_expand or printf.
> 
> For printf(), there is always %s%s, so I would not say your patch is 
> useful there, but rather adds churn: first you add a percent, then you 
> strip it away again.

True. It is only useful in either case if you are going to pass the
format specifier through an API that does all of its work at once (e.g.,
in this instance, I would be happy to simply output my strings at the
right moment, but I need to get them _between_ the log format and the
diff summary, which means I need to hide them in the log format
specifier). That tends not to happen with printf-style strings, since we
don't build complex APIs around them.

-Peff
