From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add an optional argument for --color options
Date: Sun, 14 Feb 2010 01:44:08 -0500
Message-ID: <20100214064408.GB20630@coredump.intra.peff.net>
References: <1266098475-21929-1-git-send-email-lodatom@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Mark Lodato <lodatom@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 14 07:44:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgYDH-0004kB-IA
	for gcvg-git-2@lo.gmane.org; Sun, 14 Feb 2010 07:44:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384Ab0BNGoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Feb 2010 01:44:10 -0500
Received: from peff.net ([208.65.91.99]:48293 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753589Ab0BNGoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Feb 2010 01:44:09 -0500
Received: (qmail 31175 invoked by uid 107); 14 Feb 2010 06:44:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 14 Feb 2010 01:44:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Feb 2010 01:44:08 -0500
Content-Disposition: inline
In-Reply-To: <1266098475-21929-1-git-send-email-lodatom@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139888>

On Sat, Feb 13, 2010 at 05:01:15PM -0500, Mark Lodato wrote:

> Make git-branch, git-show-branch, git-grep, and all the diff-based
> programs accept an optional argument <when> for --color.  The argument
> is a colorbool: "always", "never", or "auto".  If no argument is given,
> "always" is used;  --no-color is an alias for --color=never.  This makes
> the command-line interface consistent with other GNU tools, such as `ls'
> and `grep', and with the git-config color options.  Note that, without
> an argument, --color and --no-color work exactly as before.

I think this is a sensible change, and reading over the patch it looks
fine to me.

> If the argument is not valid for a diff-family program, a completely
> unhelpful usage message is shown.  It seems that all the other diff
> options silently ignore invalid inputs, so this is consistent.  Perhaps
> this aspect should be tweaked.

Hmm...the only one I see that silently ignores is "--submodule=bogus".
But it seems that "git log -Bfoobar" fails but does not print a useful
message.  Probably both should be fixed, and your option should follow
the same convention as those.

>  Documentation/technical/api-parse-options.txt |   12 ++++++++++++

Ooh, api documentation. It is nice to review a patch that is thorough.
:)

My only complaint in that respect is that there are no tests.  However,
I'm not sure we can get a very satisfying test, since the test scripts
may or may not have stdout going to a tty.

-Peff
