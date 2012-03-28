From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git: continue alias lookup on EACCES errors
Date: Wed, 28 Mar 2012 00:30:58 -0400
Message-ID: <20120328043058.GD30251@sigill.intra.peff.net>
References: <20120327175933.GA1716@sigill.intra.peff.net>
 <20120327180503.GB4659@sigill.intra.peff.net>
 <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: James Pickens <jepicken@gmail.com>, Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 28 06:31:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCkXL-00066w-FY
	for gcvg-git-2@plane.gmane.org; Wed, 28 Mar 2012 06:31:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751079Ab2C1EbC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Mar 2012 00:31:02 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34886
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750804Ab2C1EbB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Mar 2012 00:31:01 -0400
Received: (qmail 11009 invoked by uid 107); 28 Mar 2012 04:31:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 28 Mar 2012 00:31:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Mar 2012 00:30:58 -0400
Content-Disposition: inline
In-Reply-To: <7v4nt9j1m3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194105>

On Tue, Mar 27, 2012 at 12:16:36PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If git receives an EACCES error while trying to execute an
> > external command, we currently give up and report the error.
> > However, the EACCES may be caused by an inaccessible
> > directory in the user's PATH.
> 
> Regardless of EACCES/ENOENT change we discussed, the observable behaviour
> should be testable.  Something like this?

Yes, though I held back on writing tests, because I don't think we've
quite decided what the behavior _should_ be. Should we be
differentiating "chmod -x /bin/ls" from "chmod -x /bin"? Should we be
continuing alias lookup on EACCES? Should we print edit-distance
suggestions on EACCES?

I think the four cases from my previous email would be reasonable things
to test, but I wasn't sure what the expected outcomes should look like.

-Peff
