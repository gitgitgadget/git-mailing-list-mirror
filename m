From: Jeff King <peff@peff.net>
Subject: Re: git reset for index restoration?
Date: Thu, 22 May 2014 15:09:59 -0400
Message-ID: <20140522190959.GA18785@sigill.intra.peff.net>
References: <1400775763.1933.5.camel@stross>
 <CABPp-BHtYnput7SiAbnqUjpDibTi5o_2MAXfSj17fCdKSC7Hjg@mail.gmail.com>
 <1400782642.18134.8.camel@stross>
 <20140522183930.GB1167@sigill.intra.peff.net>
 <1400785669.18134.21.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elijah Newren <newren@gmail.com>,
	git mailing list <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu May 22 21:10:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnYNW-0001Aa-7T
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 21:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751131AbaEVTKD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2014 15:10:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:57592 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750870AbaEVTKB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2014 15:10:01 -0400
Received: (qmail 17769 invoked by uid 102); 22 May 2014 19:10:01 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 22 May 2014 14:10:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 May 2014 15:09:59 -0400
Content-Disposition: inline
In-Reply-To: <1400785669.18134.21.camel@stross>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249935>

On Thu, May 22, 2014 at 03:07:49PM -0400, David Turner wrote:

> On Thu, 2014-05-22 at 14:39 -0400, Jeff King wrote:
> > does show some improvement. Perhaps "git reset" is not writing out the
> > cache-tree extension?
>  
> Yes, that seems to be exactly what is going on; the two indexes are
> identical up to the point where the TREE extension appears.
> 
> Thanks for clearing that up!  
> 
> Do you think that this is a bug in git reset?

Possibly. There is a call to prime_cache_tree in builtin/reset.c, which
looks like it should trigger during a "mixed" or "hard" reset (and
without arguments, you should have a mixed reset). But it doesn't seem
to get called. I haven't traced it further.

-Peff
