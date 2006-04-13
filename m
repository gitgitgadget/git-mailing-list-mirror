From: Junio C Hamano <junkio@cox.net>
Subject: Re: Common option parsing..
Date: Wed, 12 Apr 2006 22:03:34 -0700
Message-ID: <7vmzeq12zd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0604121828370.14565@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 13 07:03:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FTtzY-0006iT-KG
	for gcvg-git@gmane.org; Thu, 13 Apr 2006 07:03:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbWDMFDh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Apr 2006 01:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964786AbWDMFDh
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Apr 2006 01:03:37 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:29312 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S964785AbWDMFDh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Apr 2006 01:03:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060413050336.YHTU18351.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Apr 2006 01:03:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604121828370.14565@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 12 Apr 2006 18:48:54 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18648>

Linus Torvalds <torvalds@osdl.org> writes:

> The easiest way to just solve all this mess would be to 
>  - add the diff-options into "struct rev_list" and make the 
>    "setup_revisions()" parser parse the diff flags too.
>  - get rid of "log_info" and "diff_options"
>  - possibly rename the resulting super-options structure as "struct 
>    git_options" or something if we want to.
>...
> What do you think?

I think it all makes sense.  And once this kind of clean-up is
done, I suspect the implementations of "git diff", "git log" and
"git show" would become quite similar -- one notable difference
being "git diff" with a single rev and "git show" with a single
rev would be quite different, but that is just how the arguments
are interpreted, not parsed.

However, I am not sure about the two-revs case.  I suspect the
incoming items are sorted in the revs->commits list, and we
wouldn't be able to tell which is src and which is dst when
setup_revisions() returns.
