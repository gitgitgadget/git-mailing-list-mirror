From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make the installation targets a little less chatty
Date: Thu, 31 May 2007 17:12:04 -0700
Message-ID: <7v4pls1qjv.fsf@assigned-by-dhcp.cox.net>
References: <20070531222313.GA12204@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 02:12:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Htukv-0005Yo-Ml
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 02:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760457AbXFAAMH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 20:12:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760835AbXFAAMG
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 20:12:06 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:47867 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760457AbXFAAMF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 20:12:05 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070601001204.CPEQ7952.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Thu, 31 May 2007 20:12:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 60C31X00U1kojtg0000000; Thu, 31 May 2007 20:12:04 -0400
In-Reply-To: <20070531222313.GA12204@steel.home> (Alex Riesen's message of
	"Fri, 1 Jun 2007 00:23:13 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48834>

Alex Riesen <raa.lkml@gmail.com> writes:

> by default. V=1 works as usual.
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> Now it quite quiet. I tried top show every installed file, but it
> wasn't an improvement at all so I decided to just show what's being
> done.

I agree that the long single line that installs the commands to $(bindir)
may be somewhat annoying.

Cleaning up compilation step is one thing; by tidying up the
output it makes compiler warnings stand out.

But I do not like playing games like this in general in
installation rule.  An excerpt from your patch:

> +	@echo installing programs
> +	$(QUIET)$(foreach p,$(BUILT_INS), rm -f ...

This would not even let you see what got installed.  At least,
less verbose compilation step we have these days lets you see
what is being built.  I certainly would not object if the output
would look like this, though:

	CC builtin-cat-file.o
        ...
        GEN git-add--interactive
        ...
        LINK git-http-push
        ...
        BUILTIN git-add
        ...
	MKDIR -p /usr/local/bin
        INSTALL git-foo
        INSTALL git-bar
	...
        INSTALL templates/description
        INSTALL templates/hooks/post-update
        ...
