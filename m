From: Jeff King <peff@peff.net>
Subject: Re: libreoffice merge issue ...
Date: Tue, 15 Feb 2011 21:57:27 -0500
Message-ID: <20110216025726.GC7085@sigill.intra.peff.net>
References: <1297699635.31477.253.camel@lenovo-w500>
 <20110215094546.GA25530@sigill.intra.peff.net>
 <7vaahxp250.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Meeks <michael.meeks@novell.com>, git@vger.kernel.org,
	Norbert Thiebaud <nthiebaud@gmail.com>,
	kendy <kendy@novell.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 03:57:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpXaC-0004Py-4p
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 03:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754946Ab1BPC5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 21:57:31 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:38124 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752054Ab1BPC53 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 21:57:29 -0500
Received: (qmail 2726 invoked by uid 111); 16 Feb 2011 02:57:28 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 16 Feb 2011 02:57:28 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Feb 2011 21:57:27 -0500
Content-Disposition: inline
In-Reply-To: <7vaahxp250.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166917>

On Tue, Feb 15, 2011 at 10:46:03AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Interesting. I looked at both sides of the merge and the merge base, and
> > there definitely should not be a conflict there. The regression bisects
> > to 83c9031 (unpack_trees(): skip trees that are the same in all input,
> > 2010-12-22). Reverting that commit makes the problem go away.
> 
> Thanks; I was wondering about this myself but you bisected it faster.
> 
> Will revert.

One other thing I noticed during the bisect: when using a version of git
containing 83c9031, the merge took a lot longer. As in, 13 seconds with
v1.7.3 versus 69 seconds with master.

That may simply be because the bug being demonstrated causes us to
erroneously do more file-level merging than we would otherwise need to.
But I thought it worth mentioning in case you want to delve into fixing
the code.

-Peff
