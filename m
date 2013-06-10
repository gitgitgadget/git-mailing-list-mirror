From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/6] templates: Fewer subprocesses in pre-commit hook
Date: Mon, 10 Jun 2013 17:25:02 -0400
Message-ID: <20130610212502.GE13333@sigill.intra.peff.net>
References: <1370889365-6239-1-git-send-email-richih.mailinglist@gmail.com>
 <1370889365-6239-2-git-send-email-richih.mailinglist@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 23:25:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Um9aT-0001ty-75
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 23:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530Ab3FJVZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 17:25:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:48346 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814Ab3FJVZG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 17:25:06 -0400
Received: (qmail 920 invoked by uid 102); 10 Jun 2013 21:25:57 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 16:25:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 17:25:02 -0400
Content-Disposition: inline
In-Reply-To: <1370889365-6239-2-git-send-email-richih.mailinglist@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227384>

On Mon, Jun 10, 2013 at 08:36:00PM +0200, Richard Hartmann wrote:

> Spawning a new subprocess for every line printed is inefficient.
> Thus spawn only one instance of `echo`.

Most modern shells have "echo" as a built-in these days, and do not fork
at all to run it. E.g., try "strace sh -c 'echo foo'" with your shell of
choice; neither dash nor bash will fork at all.

IMHO the indentation issues make the end result of your patch less
readable (and here-doc with cat is more readable, but actually
_increases_ the number of processes, since cat is not usually a
built-in). So I'd be in favor of keeping it as-is.

-Peff
