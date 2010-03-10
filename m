From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2010, #02; Sun, 07)
Date: Wed, 10 Mar 2010 14:59:42 -0500
Message-ID: <20100310195941.GA32387@sigill.intra.peff.net>
References: <7vk4tnd9wu.fsf@alter.siamese.dyndns.org>
 <7vk4tnw4nz.fsf@alter.siamese.dyndns.org>
 <20100309231306.GD25265@sigill.intra.peff.net>
 <7vvdd5t2lf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Steven Drake <sdrake@xnet.co.nz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 10 20:59:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpS4N-0000ja-Mx
	for gcvg-git-2@lo.gmane.org; Wed, 10 Mar 2010 20:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100Ab0CJT7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Mar 2010 14:59:46 -0500
Received: from peff.net ([208.65.91.99]:36157 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755618Ab0CJT7p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Mar 2010 14:59:45 -0500
Received: (qmail 17918 invoked by uid 107); 10 Mar 2010 20:00:08 -0000
Received: from c-71-206-173-191.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.191)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 10 Mar 2010 15:00:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Mar 2010 14:59:42 -0500
Content-Disposition: inline
In-Reply-To: <7vvdd5t2lf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141915>

On Tue, Mar 09, 2010 at 04:58:04PM -0800, Junio C Hamano wrote:

> > With the current code, gitk (which calls "log --pretty=raw") barfs on a
> > repository with log.decorate turned on.
> 
> Yuck.  Do you mean we would need _at least_ something like this?  I am

Yeah, your patch fixes the problem.

> undecided if we should limit to FMT_RAW if that is the case, though.
> Reading from "git log --pretty=raw" is just as unkosher as reading from
> "git log --pretty=oneline", but a bigger question is do we still have
> enough plumbing support to replace them, or Porcelain "log" has advanced
> too much too quickly, leaving plumbing "rev-list" behind.

It looks like the switch to "git log" in gitk came from c961b22 (gitk:
Use git log and add support for --left-right, 2007-07-09), which in
turn comes from:

  http://article.gmane.org/gmane.comp.version-control.git/51977

It looks like rev-list supports --left-right properly now (not sure if
it did back then or not), so if that was the only reason, it could
probably switch back.

I seem to recall there are other reasons to use "log" in a script, but I
can't remember any off the top of my head.

-Peff
