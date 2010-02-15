From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] require_work_tree broken with NONGIT_OK
Date: Mon, 15 Feb 2010 00:34:05 -0500
Message-ID: <20100215053404.GK3336@coredump.intra.peff.net>
References: <4B78C4D3.90407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gabriel Filion <lelutin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:34:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngtaz-00034z-Ca
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 06:34:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850Ab0BOFeB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2010 00:34:01 -0500
Received: from peff.net ([208.65.91.99]:45842 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752752Ab0BOFeA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2010 00:34:00 -0500
Received: (qmail 14711 invoked by uid 107); 15 Feb 2010 05:34:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 15 Feb 2010 00:34:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Feb 2010 00:34:05 -0500
Content-Disposition: inline
In-Reply-To: <4B78C4D3.90407@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139981>

On Sun, Feb 14, 2010 at 10:51:47PM -0500, Gabriel Filion wrote:

> When sourcing git-sh-setup after having set NONGIT_OK, calling the
> function require_work_tree while outside of a git repository shows a
> syntax error.
> 
> This is caused by the call to "git rev-parse --is-inside-work-tree"
> printing a sentence when it is called outside of a git repository.
> Relying on the return code is better.

I think your fix is fine, but your analysis is slightly wrong. If we are
not in a work tree, the sentence goes to stderr, and nothing goes to
stdout (which is what makes "test" unhappy).

This is not just a nitpick of your commit message, but I was worried
given some other recent discussion that we were accidentally sending
that message to stdout, which would be a bug. But we're not.

-Peff
