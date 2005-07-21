From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/9] applymbox updates and assorted trivial patches.
Date: Wed, 20 Jul 2005 23:58:42 -0700
Message-ID: <7vsly8bq71.fsf@assigned-by-dhcp.cox.net>
References: <7vy881dpii.fsf@assigned-by-dhcp.cox.net>
	<20050721061906.GN20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 21 08:58:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvV1B-0003iV-Pz
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 08:58:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261664AbVGUG6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jul 2005 02:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261666AbVGUG6p
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jul 2005 02:58:45 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:58772 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261664AbVGUG6p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2005 02:58:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050721065842.NWBY19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 21 Jul 2005 02:58:42 -0400
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <20050721061906.GN20369@mythryan2.michonline.com> (Ryan Anderson's message of "Thu, 21 Jul 2005 02:19:06 -0400")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> writes:

> Is it just me, or does format-patch lose the commit comments during
> export?  I haven't experimented with your new patches yet - and since
> I'm at OLS and playing with Git during my free time, my brain is pretty
> much shut down now - so if you have happen to have fixed that, thanks!

Oh, I envy you guys!  Have fun at OLS.

As far as I know, the commit comments are not lost since the
original version of format-patch.  What I added as extras with
today's patch are the original author name, email and author
timestamp.  There wasn't a provision to record these in the
output from format-patch.

The applymbox/applypatch pair Linus did allowed you to have an
extra "From:" line as the first line of the e-mail patch
submission when you are forwarding a patch somebody else has
written.  When such e-mail is applied to his repository using
applymbox (back then it was called "dotest"), however, the
original author timestamp is lost, and instead the commit gets
timestamp from the message forwarding the patch.  That is what I
meant by the loss of information.

Once I acked a patch to Linus with "Author-Date:" line as the
second line of the e-mail message (the first being the "From:"),
and he told me to refrain from doing it "for now", but that "for
now" has never been lifted, so I decided to lift it myself ;-).

The changed format-patch can be told to produce "Date:" (instead
of "Author-Date:"), and "From:".  There is a corresponding
change to the receiving end (the mailinfo program that is used
by applymbox/applypatch pair) to read this extra "Date:" line
and use that instead of the timestamp obtained from the e-mail
submission.
