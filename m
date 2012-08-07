From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Mon, 06 Aug 2012 23:01:55 -0400
Message-ID: <1344308342-sup-4817@pinkfloyd.chass.utoronto.ca>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca> <7vboio231n.fsf@alter.siamese.dyndns.org> <1344220427-sup-3468@pinkfloyd.chass.utoronto.ca> <20120806193958.GA10039@sigill.intra.peff.net> <1344287843-sup-6200@pinkfloyd.chass.utoronto.ca> <20120806213404.GA14320@sigill.intra.peff.net> <1344290892-sup-1108@pinkfloyd.chass.utoronto.ca> <20120806223113.GA16298@sigill.intra.peff.net> <m2pq73zkmu.fsf@igel.home> <20120807002318.GA17498@sigill.intra.peff.net> <20120807003541.GA18219@sigill.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Tay Ray Chuan <rctay89@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 07 05:02:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sya3d-000180-6B
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 05:02:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608Ab2HGDCD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 23:02:03 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:54038 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932599Ab2HGDCC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 23:02:02 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:54870 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Sya3P-0001O5-9B; Mon, 06 Aug 2012 23:01:55 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Sya3P-0006NO-80; Mon, 06 Aug 2012 23:01:55 -0400
In-reply-to: <20120807003541.GA18219@sigill.intra.peff.net>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203006>

Excerpts from Jeff King's message of Mon Aug 06 20:35:41 -0400 2012:

> ---
>  compat/terminal.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/compat/terminal.c b/compat/terminal.c
> index 6d16c8f..bbb038d 100644
> --- a/compat/terminal.c
> +++ b/compat/terminal.c
> @@ -59,6 +59,7 @@ char *git_terminal_prompt(const char *prompt, int echo)
>  
>      r = strbuf_getline(&buf, fh, '\n');
>      if (!echo) {
> +        fseek(fh, SEEK_CUR, 0);
>          putc('\n', fh);
>          fflush(fh);
>      }

Acked-by: Ben Walton <bwalton@artsci.utoronto.ca>

That looks good to me.  I'm able to clone a password protected https
repository and the prompting works as I'd expect.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
