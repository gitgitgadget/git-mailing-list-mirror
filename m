From: Junio C Hamano <junkio@cox.net>
Subject: Re: 2 questions/nits about commit and config
Date: Sat, 04 Feb 2006 14:13:03 -0800
Message-ID: <7voe1mvkls.fsf@assigned-by-dhcp.cox.net>
References: <20060204212337.GA8612@blinkenlights.visv.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 04 23:13:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F5VeY-0003gr-HS
	for gcvg-git@gmane.org; Sat, 04 Feb 2006 23:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbWBDWNG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Feb 2006 17:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWBDWNG
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Feb 2006 17:13:06 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:3260 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932386AbWBDWNF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Feb 2006 17:13:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060204221141.QJZJ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 4 Feb 2006 17:11:41 -0500
To: Michael Fischer <michael@visv.net>
In-Reply-To: <20060204212337.GA8612@blinkenlights.visv.net> (Michael Fischer's
	message of "Sat, 4 Feb 2006 16:23:37 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15604>

Michael Fischer <michael@visv.net> writes:

> 1) git commit -m"this is a commit message"  doesn't work. 
>    It has to have a space between -m and the first '"'. 

Well that is a minor inconvenience and would be trivial to
accomodate, but please do not send patches in yet.  I do not
know if you have been following the list discussion, but it
seems very likely that we will update the way git-commit command
works slightly in other semantic aspects and I do not want to
worry about trivialities.  Duly noted and I'll try to remember
that command line parsing issue when we do a rewrite.

> 2) I can descend into subdirectories in my project, and 
>    git diff, git status both work fine, but git commit
>    gets annoyed..

This is more or less deliberate, and I personally do not have a
strong reason to change it (except perhaps making the error
message a bit more helpful) even when we do a rewrite.

Unlike CVS that does version control per file basis, commit in
git is really about the whole tree state, so even if we changed
'git commit' to work from subdirectories that would commit
everything, which would probably be more confusing.  That is,
until somebody comes up with a good semantics and rationale why
allowing that semantics is a good change and the code to do so.

An example of such semantic change would be: if I am in
subdirecotry foo/, commit changes to files in that subdirectory
and subdirectory alone.  But that is actively _encouraging_
partial commits (commits that records a state that never existed
in your working tree as a whole) so I personally am not so
enthused to buy such a _feature_.
