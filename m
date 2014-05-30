From: Jeff King <peff@peff.net>
Subject: Re: [puzzled and solved] "shortlog" not quite understanding all
 "log" options
Date: Fri, 30 May 2014 16:16:53 -0400
Message-ID: <20140530201652.GC5513@sigill.intra.peff.net>
References: <xmqqzjhz83rk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 30 22:17:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WqTEh-0007ZX-50
	for gcvg-git-2@plane.gmane.org; Fri, 30 May 2014 22:17:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbaE3UQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2014 16:16:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:34410 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934702AbaE3UQz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2014 16:16:55 -0400
Received: (qmail 29696 invoked by uid 102); 30 May 2014 20:16:54 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 30 May 2014 15:16:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 May 2014 16:16:53 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzjhz83rk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250475>

On Fri, May 30, 2014 at 12:28:47PM -0700, Junio C Hamano wrote:

> .... Aaaand, it turns out that the answer is in the big comment at
> the beginning of handle_revision_pseudo_opt().
> 
> -- >8 --
> Subject: shortlog: allow --exclude=<glob> to be passed
> 
> e7b432c5 (revision: introduce --exclude=<glob> to tame wildcards,
> 2013-08-30) taught a new option to the command-line parser of "log"
> and friends, but did not wire it fully so that it can also be used
> by "shortlog".

FWIW, I think the discussion above the scissors adds a lot to the
context. It might be nice to add it to the commit message.

I am slightly puzzled why parse_revision_opt does not just call
handle_revision_pseudo_opt. According to f6aca0dc4, it is because
pseudo-options need to be acted on in-order, as they affect things like
subsequent "--not" options, etc. But if we are using parse_options_step,
shouldn't we be handling the options in order?

I am sure I am just missing something obvious, so do not trouble
yourself if you do not know the answer offhand.

-Peff
