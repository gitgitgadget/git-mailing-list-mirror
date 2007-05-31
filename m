From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-p4import.py robustness changes
Date: Thu, 31 May 2007 16:53:35 -0700
Message-ID: <7vbqg01reo.fsf@assigned-by-dhcp.cox.net>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Scott Lamb <slamb@slamb.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 01:54:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtuSv-0002kU-M2
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 01:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756363AbXEaXxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 19:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756424AbXEaXxi
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 19:53:38 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:48230 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756363AbXEaXxh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 19:53:37 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070531235336.BNWH13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Thu, 31 May 2007 19:53:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 5ztb1X00L1kojtg0000000; Thu, 31 May 2007 19:53:35 -0400
In-Reply-To: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> (Scott Lamb's
	message of "Thu, 31 May 2007 09:47:51 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48832>

Scott Lamb <slamb@slamb.org> writes:

> There's a logfile option, but that's a poor excuse for no error
> handling. I'd like to fix it. A couple questions, though:

Good to have somebody who has access to p4.

> First, is it acceptable to switch from os.popen to the subprocess
> module? I ask because the latter was only introduced with Python 2.4
> on. The subprocess module does work with earlier versions of Python
> (definitely 2.3) and is GPL-compatible, so maybe it could be thrown
> into the distribution if desired.

We actually did ship with our own copy after clearing the
licensing situation with Python people, although we removed it
when it lost the last script that used it.  I do not think
resurrecting it is a problem.

> Second, this crowd seems to want sequences of tiny patches. How does
> this sound?
>
> * patch 1 - use subprocess to make git_command.git() and p4_command.p4
> () throw properly-typed exceptions on error, fix caller exception
> handling to match.
>
> * patch 2 - remove the use of the shell and pipelines (fix some
> escaping problems).
>
> * patch 3 - use lists instead of space separation for the commandline
> arguments (fix more escaping problems).
>
> * patch 4 - allow grabbing partial history (make my error go away).

Actually, my preference is to have a "patch 0" before all of the
above, that demotes git-p4import to contrib/ hierarchy.  Having
no access to p4 managed repositories (nor much inclination to
get one), I can never test nor maintain it myself, so it is just
crazy for me to be the maintainer for it.

But I do read Python and speak it passably -- the above 4 step
outline sounds sane to me.
