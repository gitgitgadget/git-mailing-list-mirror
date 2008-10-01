From: Jeff King <peff@peff.net>
Subject: Re: [PATCH, resent] fix openssl headers conflicting with custom
	SHA1 implementations
Date: Wed, 1 Oct 2008 12:04:18 -0400
Message-ID: <20081001160418.GA13917@coredump.intra.peff.net>
References: <alpine.LFD.2.00.0809301621091.3635@xanadu.home> <20080930203928.GN21310@spearce.org> <alpine.LFD.2.00.0809301645340.3635@xanadu.home> <20080930205122.GO21310@spearce.org> <20081001034712.GE24513@coredump.intra.peff.net> <20081001155458.GF21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 18:06:22 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl4D1-0000GP-Q7
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 18:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753849AbYJAQEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 12:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753850AbYJAQEW
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 12:04:22 -0400
Received: from peff.net ([208.65.91.99]:1090 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753849AbYJAQEV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 12:04:21 -0400
Received: (qmail 19780 invoked by uid 111); 1 Oct 2008 16:04:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 01 Oct 2008 12:04:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Oct 2008 12:04:18 -0400
Content-Disposition: inline
In-Reply-To: <20081001155458.GF21310@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97243>

On Wed, Oct 01, 2008 at 08:54:58AM -0700, Shawn O. Pearce wrote:

> >   void ARM_SHA1_Init()
> > 
> > and
> > 
> >   #define SHA1_Init ARM_SHA1_Init
> 
> Ick.  I agree that renaming our SHA1 implementation to a different
> set of symbols is the right solution.  But this could cause trouble
> in any code that needs both SHA1 implementation and OpenSSL,
> especially if a SHA_CTX was passed to a function in another module.

Yes. You're never going to be able to get access to _both_
implementations if they have the same name. ;)

> I think its easy enough to just rename our SHA_CTX and SHA_*
> functions to something more git specific.  Since its mostly a global

I think that is the cleanest and simplest solution. As for merging pain,
I think Junio would generally do a mechanical change like this as the
first thing after a release. However, in this case, I think we might
want it sooner if the conflict is causing breakage.

-Peff
