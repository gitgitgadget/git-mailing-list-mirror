From: Junio C Hamano <junkio@cox.net>
Subject: Re: Should git-prune-script warn about dircache?
Date: Sun, 01 May 2005 10:20:22 -0700
Message-ID: <7vll6yyiax.fsf@assigned-by-dhcp.cox.net>
References: <7vwtqjxlrv.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505010916510.2296@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 19:15:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSI23-000738-5J
	for gcvg-git@gmane.org; Sun, 01 May 2005 19:15:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262623AbVEARUs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 13:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVEARUs
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 13:20:48 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:28132 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S262623AbVEARU0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 13:20:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501172022.PLMV7629.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 13:20:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505010916510.2296@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 1 May 2005 09:18:07 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> How about making git-prune-script first run "git-update-cache --refresh",
LT> and checking the return value of it (this, of course, assumes that
LT> git-update-cache --refresh would return non-zero if it can't refresh a
LT> file, which is currently not true, but should be easily fixable).

Or just check if it sees anything in the output, especially
"needs update" line.

I do not think it is such a big deal [*1*] but I should point
out that, "git-update-cache --refresh" needs to be run on all of
them if the user (or the porcelain layer) is using more than one
GIT_INDEX_FILEs [*2*].


[Footnotes]

*1* Because git-prune-script is just an example and it already
assumes it knows where the valid heads are; right now it looks
only at .git/HEAD and not .git/refs/*/*.  Each Porcelain layer
implementation should provide its own prune script anyway.

*2* I do not do this anymore but an earlier incarnation of my
little SCM on GIT [*3*] allowed a user to keep snapshots of work
tree state and switch between them by juggling multiple
GIT_INDEX_FILE.  I just create commits off of the current state
when making a snapshot in the latest version so it is not a
problem anymore for me.

*3* (PLUG) found in http://members.cox.net/junkio/.


