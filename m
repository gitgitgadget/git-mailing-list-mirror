From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH 2/2] repack: Remove stale .keep files before repacking
Date: Thu, 31 Mar 2011 21:41:50 -0400
Message-ID: <20110401014150.GC21036@sigill.intra.peff.net>
References: <201103311246.25645.johan@herland.net>
 <20110331190429.GC16981@sigill.intra.peff.net>
 <201104010334.28048.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Fri Apr 01 03:42:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5TNM-00046B-59
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 03:42:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753136Ab1DABly (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 21:41:54 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:39504
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751701Ab1DABlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 21:41:53 -0400
Received: (qmail 4973 invoked by uid 107); 1 Apr 2011 01:42:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 Mar 2011 21:42:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 Mar 2011 21:41:50 -0400
Content-Disposition: inline
In-Reply-To: <201104010334.28048.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170548>

On Fri, Apr 01, 2011 at 03:34:27AM +0200, Johan Herland wrote:

> On Thursday 31 March 2011, Jeff King wrote:
> > On Thu, Mar 31, 2011 at 12:46:25PM +0200, Johan Herland wrote:
> > > 3. Do I need to scan for and remove stale .keep files in a cron job
> > > 
> > >    in order to keep repos healthy and clonable?
> > 
> > If we fix (1), then hopefully it is not as much of an issue. But
> > probably "git gc" should clean up stale ones after a while.
> 
> This patch tries to automatically remove stale .keep files. However,
> it's still work-in-progress, as I don't know how to portably (a) ask
> for the current hostname (so that I can compare it to the one in the
> .keep file), or (b) test for whether a given PID is running on the
> system (to determine whether the receive-pack process that wrote the
> .keep file is still alive).
> 
> Feedback appreciated.

Since your 1/2 turns them from an actual problem into just harmless
cruft, there's no real rush to get rid of them. Could we just do
something like "there is no matching pack file, and the mtime is 2 weeks
old"?

If there is a matching pack file, I don't think we want to get rid of
them. People can have .keep files if they want to indicate the pack
should be kept. I do admit it would be weird to write the "receive-pack"
message into them, though.

-Peff
