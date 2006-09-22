From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git user survey and `git pull`
Date: Thu, 21 Sep 2006 21:57:55 -0700
Message-ID: <7vu0305wh8.fsf@assigned-by-dhcp.cox.net>
References: <20060921162401.GD3934@spearce.org>
	<20060921164048.GY8259@pasky.or.cz>
	<Pine.LNX.4.64.0609211027440.4388@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 22 06:58:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQd7E-0003J2-2b
	for gcvg-git@gmane.org; Fri, 22 Sep 2006 06:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWIVE57 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Sep 2006 00:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWIVE57
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Sep 2006 00:57:59 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:41934 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932271AbWIVE54 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Sep 2006 00:57:56 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060922045755.ZMTA6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Fri, 22 Sep 2006 00:57:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id RGxx1V00S1kojtg0000000
	Fri, 22 Sep 2006 00:57:58 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27521>

Linus Torvalds <torvalds@osdl.org> writes:

> I agree that the clarifications from Shawn are probably improvements, but 
> I'd actually like to solve the problem a bit differently. Namely, I was 
> hoping that the per-branch configuration would solve the confusion.
>
> Right now, a plain "git pull" means "fetch all branches and merge the 
> first one", and the thing is, that's generally the right thing _only_ if 
> you pull into "master".
>
> It's usually exactly the _wrong_ thing to do for any other branch. In 
> particular, if you work with a project that has lots of branches, and 
> you're working in another branch (that is directly tracking a remote, for 
> example), doing a "git pull" definitely should _not_ merge the first head. 
> It should fetch everything, and possibly merge the _matching_ head.
>
> Which it doesn't do right now.

I am actually in favor of adding config mechanism that lets you
say things like:

  When on branch 'foo':

  - pull without any argument shall use .git/remotes/$that,
    instead of the usual .git/remotes/origin;

  - pull without pathspec arguments shall use the named
    .git/remotes/ file to learn from which URL to fetch from,
    which remote branches to fetch and which local branches to
    store them, but merge $this_and_that remote heads regardless
    of what .git/remotes/ file says;

  - you shall not use "reset" other than resetting to the HEAD;

  - you shall not use "rebase";

  - you shall not merge from $this_and_that branches;

  - your commit identity shall be $whoami, not the usual
    core.user;

I am not motivated enough to do that myself, though.
