From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH 0/5] ignore SIGINT while editor runs
Date: Sun, 11 Nov 2012 21:43:05 +0100
Message-ID: <20121111204305.GA20599@shrek.podlesie.net>
References: <20121109192336.GA9401@sigill.intra.peff.net>
 <87a9uq5tql.fsf@Niukka.kon.iki.fi>
 <20121110155209.75EFC2E8B68@grass.foxharp.boston.ma.us>
 <871ug15k5c.fsf@Niukka.kon.iki.fi>
 <20121110220811.DC6A42E8B68@grass.foxharp.boston.ma.us>
 <87wqxs4o6f.fsf@Niukka.kon.iki.fi>
 <20121111154846.GA13188@sigill.intra.peff.net>
 <20121111163100.GB13188@sigill.intra.peff.net>
 <20121111191520.GA9474@shrek.podlesie.net>
 <20121111202419.7602E2E8B6A@grass.foxharp.boston.ma.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Kalle Olavi Niemitalo <kon@iki.fi>,
	git@vger.kernel.org
To: Paul Fox <pgf@foxharp.boston.ma.us>
X-From: git-owner@vger.kernel.org Sun Nov 11 21:43:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXeNI-0007ea-3u
	for gcvg-git-2@plane.gmane.org; Sun, 11 Nov 2012 21:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753537Ab2KKUnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2012 15:43:09 -0500
Received: from shrek-modem1.podlesie.net ([83.18.25.171]:40084 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752950Ab2KKUnI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2012 15:43:08 -0500
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 3488F55A; Sun, 11 Nov 2012 21:43:05 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121111202419.7602E2E8B6A@grass.foxharp.boston.ma.us>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209443>

On Sun, Nov 11, 2012 at 03:24:19PM -0500, Paul Fox wrote:
> krzysztof wrote:
>  > Looks ok, but what about SIGQUIT? Some editors like GNU ed (0.4 and 1.6)
>  > ignore SIGQUIT, and after SIGQUIT git dies, but editor is still running.
>  > After pressing any key ed receives -EIO and prints "stdin: Input/output
>  > error". GNU ed 1.6 then exits, but ed 0.4 prints this error forever.
>  > Maybe git should kill the editor in such case?
> 
> there's certainly lots of precedent for treating SIGINT and SIGQUIT
> the same.  but there's also some merit to saying that if the user
> knows to send SIGQUIT instead of SIGINT, they may well have a reason. 
> (after all, if we always treat them the same, there's no point in
> having both.)

That's why I'm proposing in case of SIGQUIT just killing the editor
(SIGTERM is sufficient for ed).

So git will ignore SIGINT, but die on SIGQUIT (and kill editor
that ignores SIGQUIT).

> 
> the em editor (linus' microemacs) behaves as you describe ed 0.4 does,
> except without the error message -- it just spins silently getting EIO
> from reading stdin.  i think em needs to be fixed, and it sounds like
> GNU ed already has been.  (unless i misunderstand the relationship of
> 0.4 and 1.6.)

Yes, the version 1.6 is fixed, it just prints an error once and exits.

Krzysiek
