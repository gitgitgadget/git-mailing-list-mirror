From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: Re: [PATCH] Avoid crippled getpass function on Solaris
Date: Sun, 05 Aug 2012 22:41:39 -0400
Message-ID: <1344220896-sup-7172@pinkfloyd.chass.utoronto.ca>
References: <1344208672-20028-1-git-send-email-bwalton@artsci.utoronto.ca> <CALUzUxrfSEtkXfFbotb3XARt9e=oWF0xQRVU0hwnsCJn-Cn0Lw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: gitster <gitster@pobox.com>, peff <peff@peff.net>,
	git <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 04:41:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyDGM-0008NQ-Cz
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 04:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755506Ab2HFCll (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Aug 2012 22:41:41 -0400
Received: from garcia.cquest.utoronto.ca ([192.82.128.9]:51800 "EHLO
	garcia.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755499Ab2HFCll (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Aug 2012 22:41:41 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:54204 ident=93)
	by garcia.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyDGF-0008PM-DG; Sun, 05 Aug 2012 22:41:39 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1SyDGF-0006Q7-CH; Sun, 05 Aug 2012 22:41:39 -0400
In-reply-to: <CALUzUxrfSEtkXfFbotb3XARt9e=oWF0xQRVU0hwnsCJn-Cn0Lw@mail.gmail.com>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202954>

Excerpts from Tay Ray Chuan's message of Sun Aug 05 21:56:55 -0400 2012:

> > I've also briefly dabbled with getting Solaris to simply use the
> > HAVE_DEV_TTY code path but the terminal echo stuff hasn't worked
> > nicely for me just yet.  (It reads the password with nothing
> > echoed but then displays the string after reading the newline.)
> > This might still be a better approach in the future, but for now,
> > having long password reading capability will still be a benefit to
> > users on this platform.
> 
> Replacing
> 
>     if (!echo) {
>         putc('\n', fh);
>         fflush(fh);
>     }
> 
> with
> 
>     if (!echo)
>         write(term_fd, "\n", 1);
> 
> fixed that. Using fd's instead of FILE* was mentioned at [1]. Perhaps
> that is the direction to go in.

Oh, interesting.  I'd missed your update of this thread earlier
today.  It may make sense to do everything via file descriptors
directly as you suggested in your comments on that patch.

Thanks
-Ben
--
Ben Walton
Systems Programmer - CHASS
University of Toronto
C:416.407.5610 | W:416.978.4302
