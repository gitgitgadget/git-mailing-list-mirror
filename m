From: Jeff King <peff@peff.net>
Subject: Re: [REGRESSION] git-wrapper to run-commands codepath regression
Date: Mon, 18 Apr 2011 17:43:37 -0400
Message-ID: <20110418214337.GB25104@sigill.intra.peff.net>
References: <7v8vv78eld.fsf@alter.siamese.dyndns.org>
 <20110418211102.GA13566@sigill.intra.peff.net>
 <20110418211849.GB13566@sigill.intra.peff.net>
 <7vvcyb6xww.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 18 23:44:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QBwEh-0000Vd-TT
	for gcvg-git-2@lo.gmane.org; Mon, 18 Apr 2011 23:44:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752833Ab1DRVnm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Apr 2011 17:43:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55754
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752505Ab1DRVnj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2011 17:43:39 -0400
Received: (qmail 4217 invoked by uid 107); 18 Apr 2011 21:44:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 18 Apr 2011 17:44:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Apr 2011 17:43:37 -0400
Content-Disposition: inline
In-Reply-To: <7vvcyb6xww.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171762>

On Mon, Apr 18, 2011 at 02:40:31PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > And here's the fix.
> 
> I was tempted to suggest the change in your patch.
> 
> With ebec842 (run-command: prettify -D_FORTIFY_SOURCE workaround,
> 2011-03-16) reverted, I still don't get complaints from -D_FORTIFY_SOURCE
> for run-command.c (but I do get "ignoring return value of 'fwrite' from
> many places).  Perhaps the kinds of checks done by versions of gcc you,
> Jonathan and I use are different.

I don't use _FORTIFY_SOURCE at all, so I have no clue. I just saw that
the code in ebec842 is obviously wrong, and the fix looked equally
obvious.

> I'd rather revert it for now; I don't want to see patch ping-pong at this
> late in the pre-release cycle.

That's your call, but the fix seems dead simple to me. _FORTIFY_SOURCE
likes the conditional, according to Jonathan's patch. We don't remove
the conditional, just the wrong "non-zero is an error" assumption. So I
wouldn't expect any ping-pong on it, but then again, it looked like a
pretty innocuous patch in the first place, and held a pretty nasty and
surprising bug. :)

-Peff
