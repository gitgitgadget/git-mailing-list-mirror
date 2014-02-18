From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] notes-utils: handle boolean notes.rewritemode
 correctly
Date: Tue, 18 Feb 2014 04:01:56 -0500
Message-ID: <20140218090156.GC2692@sigill.intra.peff.net>
References: <cover.1392565571.git.john@keeping.me.uk>
 <be9b384ec77fc39b939b8c5505862a6e1c641faa.1392565571.git.john@keeping.me.uk>
 <87txbzvxgq.fsf@fencepost.gnu.org>
 <20140218074632.GA29804@sigill.intra.peff.net>
 <87vbwcstgw.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Keeping <john@keeping.me.uk>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 18 10:02:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFgZ4-00034v-Ak
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 10:02:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754657AbaBRJB7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 04:01:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:52525 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754625AbaBRJB6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 04:01:58 -0500
Received: (qmail 21433 invoked by uid 102); 18 Feb 2014 09:01:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Feb 2014 03:01:58 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Feb 2014 04:01:56 -0500
Content-Disposition: inline
In-Reply-To: <87vbwcstgw.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242284>

On Tue, Feb 18, 2014 at 09:41:51AM +0100, David Kastrup wrote:

> gcc's flow analysis works with the same data as humans reading the
> code.  If there is no information content in the function call, it makes
> more sense to either making it void.

The point of error() returning a constant -1 is to use this idiom:

  if (something_failed)
          return error("this will get printed, and we get a -1 return");

>From a code perspective it's pointless. You could "just" write:

  if (something_failed) {
          error(...);
          return -1;
  }

which is equivalent. But the point is that the former is shorter and a
little more readable, assuming you are familiar with the idiom.

> One can always explicitly write
> 
>   (config_error_nonbool("panic-when-assailed"), -1)

Yes, but again, the point is readability. Doing that at each callsite is
ugly and annoying.

> Shrug.  This one has likely been discussed to death already.  Sometimes
> it's more convenient to avoid getting a question asked in the first
> place rather than having a stock answer for it.

You are the first person to ask about it, so there is no stock answer.
However, everything I told you was in the commit messages and the list
archive already. We can also avoid questions being asked by using those
tools.

-Peff
