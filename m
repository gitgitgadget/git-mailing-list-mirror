From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] find_containing_dir(): allocate strbuf less extravagantly
Date: Tue, 22 May 2012 13:34:48 -0400
Message-ID: <20120522173448.GD11600@sigill.intra.peff.net>
References: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Tue May 22 19:34:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWsz1-0006WZ-V3
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 19:34:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759943Ab2EVRev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 May 2012 13:34:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51844
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751638Ab2EVRev (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2012 13:34:51 -0400
Received: (qmail 20348 invoked by uid 107); 22 May 2012 17:35:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 22 May 2012 13:35:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 May 2012 13:34:48 -0400
Content-Disposition: inline
In-Reply-To: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198211>

On Tue, May 22, 2012 at 03:16:06PM +0200, mhagger@alum.mit.edu wrote:

> From: Michael Haggerty <mhagger@alum.mit.edu>
> 
> It might seem like allocating a fixed-length buffer of uninitialized
> memory should be pretty cheap even if the buffer is of size PATH_MAX.
> But empirically, it is measurably faster to allocated only the strlen
> of the input string.
> 
> Thanks to Peff for pointing out a performance regression in this area
> that might be fixed by this patch.
> 
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> I am not able to reproduce performance regressions as bad as those
> observed by Peff.  It seems to depend on the amount of memory
> pressure.  The smaller regression that I *did* see is fixed by this
> patch, reducing the time for "git fetch . refs/*:refs/*" from 10.1 s
> to 9.3 s.  The change is sensible in any case, but we will have to
> wait for Peff's verdict about whether it fixes the whole problem for
> him, too.

I see a similar small improvement. So I think it is worth doing, but it
does not fix the main regression I found.

-Peff
