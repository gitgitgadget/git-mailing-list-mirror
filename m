From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] git-branch: add --track and --no-track options
Date: Mon, 05 Mar 2007 22:45:51 -0800
Message-ID: <7vejo2uaxs.fsf@assigned-by-dhcp.cox.net>
References: <esgm1m$33f$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 07:45:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOTQp-0004vD-NP
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 07:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965804AbXCFGpx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 01:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965805AbXCFGpx
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 01:45:53 -0500
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:38037 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965804AbXCFGpw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 01:45:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306064551.VQEU1226.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Tue, 6 Mar 2007 01:45:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id XJlr1W00G1kojtg0000000; Tue, 06 Mar 2007 01:45:52 -0500
In-Reply-To: <esgm1m$33f$1@sea.gmane.org> (Paolo Bonzini's message of "Mon, 05
	Mar 2007 09:57:26 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41542>

Paolo Bonzini <bonzini@gnu.org> writes:

> In order to track and build on top of a branch 'topic' you track from
> your upstream repository, you often would end up doing this sequence:
>
>   git checkout -b mytopic origin/topic
>   git config --add branch.mytopic.remote origin
>   git config --add branch.mytopic.merge refs/heads/topic
>
> This would first fork your own 'mytopic' branch from the 'topic'
> branch you track from the 'origin' repository; then it would set up two
> configuration variables so that 'git pull' without parameters does the
> right thing while you are on your own 'mytopic' branch.
>
> This commit adds a --track option to git-branch, so that "git
> branch --track topic origin/topic" performs the latter two actions
> when creating your 'topic' branch.

Hmm. I think your use of 'mytopic' is very good for the purpose
of illustration. It makes clear which configuration takes name
from what. So I like your first paragraph. However, one reason
people like the separate remote layout is that it allows you to
name your own branch identically with that of the other side, so
in that sense, the description in your second paragraph matches
the real-life usage better. What I am getting at is that (1)
these two paragraphs are inconsistent, (2) there is a reason to
prefer the description in the first paragraph, and (3) there is
another reason to prefer the description in the second one.

> By setting configuration variable
> 'remote.REMOTENAME.trackintolocalbranches' to true, you do not have to
> pass the --track option explicitly (the configuration variable is off
> by default, and there is a --no-track option to countermand it even if
> the variable is set).

As Johannes already pointed this out, I think allowing this to
be controlled per remote is nice but overkill.  A single boolean
configuration, say "branch.autosetupmerge", would suffice.
