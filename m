From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] drop some "int x = x" hacks to silence gcc warnings
Date: Fri, 22 Mar 2013 12:18:37 -0400
Message-ID: <20130322161837.GG3083@sigill.intra.peff.net>
References: <20130321110338.GA18552@sigill.intra.peff.net>
 <514AF2E1.7020409@viscovery.net>
 <20130321115545.GB21319@sigill.intra.peff.net>
 <7vppysbxzo.fsf@alter.siamese.dyndns.org>
 <7vhak4bx0w.fsf@alter.siamese.dyndns.org>
 <20130321154402.GA25907@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 17:19:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ4gT-0002KC-R4
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 17:19:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933715Ab3CVQSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 12:18:46 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35843 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933480Ab3CVQSp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 12:18:45 -0400
Received: (qmail 2062 invoked by uid 107); 22 Mar 2013 16:20:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 12:20:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 12:18:37 -0400
Content-Disposition: inline
In-Reply-To: <20130321154402.GA25907@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218816>

On Thu, Mar 21, 2013 at 11:44:02AM -0400, Jeff King wrote:

> >     I am for dropping "= x" and leaving it uninitialized at the
> >     declaration site, or explicitly initializing it to some
> >     reasonable starting value (e.g. NULL if it is a pointer) and
> >     adding a comment to say that the initialization is to squelch
> >     compiler warnings.
> 
> I'd be in favor of that, too. In many cases, I think the fact that gcc
> cannot trace the control flow is a good indication that it is hard for a
> human to trace it, too. And in those cases we would be better off
> restructuring the code slightly to make it more obvious to both types of
> readers.
> 
> Two patches to follow.
> 
>   [5/4]: fast-import: clarify "inline" logic in file_change_m
>   [6/4]: run-command: always set failed_errno in start_command

And here are two more; with these, our code base should be free of "x =
x" initializations (at least according to clang).

  [7/4]: submodule: clarify logic in show_submodule_summary
  [8/4]: match-trees: drop "x = x" initializations

Not pressing, obviously, but since I had just analyzed the code
yesterday, I wanted to do it while they were still fresh in my mind.

-Peff
