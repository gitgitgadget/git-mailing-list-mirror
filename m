From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make cvsexportcommit work with filenames containing spaces.
Date: Sat, 23 Sep 2006 12:03:07 -0700
Message-ID: <7v4puytnh0.fsf@assigned-by-dhcp.cox.net>
References: <20060922223506.3377.34859.stgit@lathund.dewire.com>
	<7vvenfw727.fsf@assigned-by-dhcp.cox.net>
	<200609231427.55721.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 23 21:03:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRCmV-0003RL-BA
	for gcvg-git@gmane.org; Sat, 23 Sep 2006 21:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751431AbWIWTDK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Sep 2006 15:03:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWIWTDK
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Sep 2006 15:03:10 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:8331 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751431AbWIWTDI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Sep 2006 15:03:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060923190308.CLHK2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sat, 23 Sep 2006 15:03:08 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rv361V00h1kojtg0000000
	Sat, 23 Sep 2006 15:03:07 -0400
To: Robin Rosenberg <robin.rosenberg@dewire.com>
In-Reply-To: <200609231427.55721.robin.rosenberg@dewire.com> (Robin
	Rosenberg's message of "Sat, 23 Sep 2006 14:27:55 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27614>

Robin Rosenberg <robin.rosenberg@dewire.com> writes:

> Why patch? Well this patch works around (i.e. not perfect) a mismatch between 
> what patch eats and git submits. They are not totally, compatible, and I'm 
> not sure who to blame yet.  git emits diff's without timestamps, and what 
> matters to patch, without a TAB before the file timestamp. When patch sees a 
> header like "+++ filename with spaces.txt" it patches "filename". When it 
> sees "+++ filename with spaces.txt<TAB>" if patches "filename with 
> spaces.txt". The real fix would ofcourse be in git diff or patch sometime in 
> the future.

Ah, it might be because our diff output do not have trailing TAB
(and timestamp) and if CVS uses GNU patch that would be confused
and not detect the file being patched.

Interestingly, I did a two-patch series to address that issue
separately.  But that is not even in "next" yet.

More interestingly, the version of "GNU patch" that cannot grok
our patch (without trailing TAB) for a file that has SP in its
name is on my home machine where your patched cvsexportcommit
works.  I do not know if GNU patch on the other machine does.

Will collect necessary info and follow up.
