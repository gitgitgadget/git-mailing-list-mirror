From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch-pack: start multi-head pulling.
Date: Fri, 12 Aug 2005 09:43:44 -0700
Message-ID: <7vk6irumv3.fsf@assigned-by-dhcp.cox.net>
References: <7vwtmr4hm5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508120858420.3295@g5.osdl.org>
	<Pine.LNX.4.63.0508121818230.26488@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 12 18:46:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3cdJ-0000Ly-7Q
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 18:43:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVHLQnq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 12:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751227AbVHLQnq
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 12:43:46 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:34766 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751226AbVHLQnp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 12:43:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812164345.UWAL550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 12:43:45 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508121818230.26488@wgmdd8.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 12 Aug 2005 18:19:30 +0200
	(CEST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> I seem to remember Junio does not like bash arrays... And in a recent 
> commit message, he even admits to using something different than bash!

Correct and somewhat misleading.  My usual shell is bash but
from time to time I try to run things with (d)ash to see how far
I strayed from the common denominator.

Yes, I am old fashioned.

I have been trying, admittably perhaps not very successfully, to
stay away from bashism in the core GIT scripts.  I knew we
started using shell array when Linus did the git-diff-script,
but I have been hoping somebody coming from other platforms
(hello, Solaris and Darwin guys) would send in patches if they
cared enough.  So I try to avoid making their life harder than
already is.

Here is a semi off-topic joke, hopefully to give you a better
sense of where I am coming from.

    Anybody can start pretending to be an old fashioned shell
    programmer by adhering to the following simple rules:

     1. Never, ever say [ ... ]; we old-timers always spell that
        "test".

     2. Never use "test" when "case" would do; this comes from
        the days when test was not built-in and machines were
        small.  We tried to reduce number of forks in our
        scripts.  We also never use echo piped to grep when
        "case" would do.

     3. We tend to write && || more often than we use if
        ... then ... fi, especially for simple things.  We do
        not use parantheses () to introduce command grouping
        lightly.  We usually say braces {} and use parentheses
        only when we do want a subshell.

     4. Say ${var-default} more often than ${var:-default};
        colon form is more recent invention, and we old-timers
        tend to be more careful to consider the possibility
        that, when a user says this variable is empty, the user
        really means it.

     5. We are still allowed to use $() form in preference to
        ``, because it is clearly superior (it can nest) and
        should have been the way to spell it from the beginning.

-jc
