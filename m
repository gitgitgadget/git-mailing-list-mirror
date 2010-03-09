From: Jeff King <peff@peff.net>
Subject: Re: Portability patches vs 1.7.0.2 [5/6]
Date: Tue, 9 Mar 2010 18:26:24 -0500
Message-ID: <20100309232624.GE25265@sigill.intra.peff.net>
References: <20100309161906.GF99172@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 00:26:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Np8oz-0007BK-86
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 00:26:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755213Ab0CIX02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Mar 2010 18:26:28 -0500
Received: from peff.net ([208.65.91.99]:34365 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755069Ab0CIX01 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Mar 2010 18:26:27 -0500
Received: (qmail 4778 invoked by uid 107); 9 Mar 2010 23:26:49 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 09 Mar 2010 18:26:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 09 Mar 2010 18:26:24 -0500
Content-Disposition: inline
In-Reply-To: <20100309161906.GF99172@thor.il.thewrittenword.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141855>

On Tue, Mar 09, 2010 at 04:19:06PM +0000, Gary V. Vaughan wrote:

> ## sockaddr_t->ss_family is not portable

I assume you mean sockaddr_storage here?

> Many of our supported platforms do not have this declaration, for
> example solaris2.6 thru 2.8 (I can find a complete list of which of
> our supported platforms have this problem).

Did you mean that list to be inclusive? My Solaris 2.8 definitely has
sockaddr_storage, as it is necessary for IPv6 handling. I don't remember
when IPv6 support was added, though...if it was in a minor release, then
presumably earlier versions of 2.8 did not.

At any rate, we should only need it for IPv6 support, so I think the
right solution would be to include all uses inside an "#ifndef NO_IPV6",
and for the NO_IPV6 case assume it's a sockaddr_in.

-Peff
