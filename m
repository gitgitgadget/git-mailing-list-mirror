From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] diff: make "too many files" rename warning optional
Date: Sun, 4 May 2008 15:23:32 -0400
Message-ID: <20080504192332.GB13029@sigill.intra.peff.net>
References: <20080430172136.GA22601@sigill.intra.peff.net> <20080430172553.GC23747@sigill.intra.peff.net> <481CA227.1000801@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun May 04 21:24:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jsjor-0008V5-L9
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 21:24:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755197AbYEDTXd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2008 15:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754213AbYEDTXd
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 15:23:33 -0400
Received: from peff.net ([208.65.91.99]:4581 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754071AbYEDTXc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 May 2008 15:23:32 -0400
Received: (qmail 26855 invoked by uid 111); 4 May 2008 19:23:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 04 May 2008 15:23:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 04 May 2008 15:23:32 -0400
Content-Disposition: inline
In-Reply-To: <481CA227.1000801@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81193>

On Sat, May 03, 2008 at 06:34:31PM +0100, Ramsay Jones wrote:

> This will also fix the problem I had with gitk on cygwin; namely "gitk
> --all &" on my "git" repo pops up an error dialog (see below), after
> which the diff display disappears.
> 
> The error dialog shows:
> --- >8 ---
> warning: too many files, skipping inexact rename detection
> warning: too many files, skipping inexact rename detection
>     while executing
> "close $bdf"
>     (procedure "getblobdiffline" line 89)
>     invoked from within
> "getblobdiffline file102daa00 1d6aeb410dc19893adbc0209bcf859f35ff1c7d6"
>     ("eval" body line 1)
>     invoked from within
> "eval $script"
>     (procedure "dorunq" line 9)
>     invoked from within
> "dorunq"
>     ("after" script)
> --- 8< ---
> 
> The git command issued by gitk appears to be:
>    git diff-tree -r -p -C --no-commit-id -U3 1d6aeb410dc19893adbc0209bcf859f35ff1c7d6

Hrm. Is gitk on cygwin somehow squishing stderr and stdout together? Or
does gitk in general look at what happens on stderr?

Because while I am happy that removing this message fixes your problem,
it is a little disconcerting to think that we can break gitk just by
issuing a warning diagnostic on stderr.

-Peff
