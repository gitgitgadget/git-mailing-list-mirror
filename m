From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: t3701 fails if core.filemode disabled
Date: Sun, 18 May 2008 22:01:21 +0200
Message-ID: <20080518200121.GA5789@steel.home>
References: <20080518152337.GB3058@steel.home> <20080518190839.GC15506@sigill.intra.peff.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 18 22:02:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jxp5G-0006jy-Lr
	for gcvg-git-2@gmane.org; Sun, 18 May 2008 22:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754636AbYERUBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 16:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754449AbYERUBY
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 16:01:24 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:11377 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826AbYERUBX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 16:01:23 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gYkBuibEUndJ36PWMnarAeHyXUdQ==
Received: from tigra.home (Fac65.f.strato-dslnet.de [195.4.172.101])
	by post.webmailer.de (klopstock mo63) (RZmta 16.34)
	with ESMTP id 20463dk4IF46fZ ; Sun, 18 May 2008 22:01:22 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A24AF277BD;
	Sun, 18 May 2008 22:01:21 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 3EBC256D28; Sun, 18 May 2008 22:01:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080518190839.GC15506@sigill.intra.peff.net>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82396>

Jeff King, Sun, May 18, 2008 21:08:39 +0200:
> On Sun, May 18, 2008 at 05:23:37PM +0200, Alex Riesen wrote:
> 
> > This is on Cygwin, yes. I have the core.filemode disabled in
> > ~/.gitconfig. How about stopping the test before the failing portion
> > (only the last two fail, below)?
> 
> What's in your ~/.gitconfig shouldn't have any effect (the test scripts
> take care to avoid looking at anything outside of your git directory).
> But presumably this test is broken on Cygwin, anyway?

Correct.

> I don't mind disabling these tests if they don't make sense on certain
> platforms, but regarding your specific proposal:
> 
>   - can you confirm that the test doesn't make sense, and not that it is
>     simply broken on cygwin? Does changing your ~/.gitconfig's
>     core.filemode make a difference? It shouldn't, but that could be
>     a bug in test-lib. What happens if you run the test manually? Does
>     git-add just not prompt for the mode change?

I setting core.filemode _inside_ the test breaks it in exactly the
same way (on Linux, I'm at home). I'll retest tomorrow

>   - if the tests are to be disabled, I think it is better to
>        if tests_make_sense; do
>          tests
>        fi
>     rather than exiting the script. It is less error prone if tests get
>     added later.

I agree

>   - What is the right tests_make_sense? You are checking core.filemode,
>     but that should not be leaking in from your .gitconfig. Does cygwin
>     have a different defaults for that value?

Could be.

>     Is it actually a matter of being on a filesystem which doesn't
>     properly handle the executable bit?

That - too. I shall see tomorrow
