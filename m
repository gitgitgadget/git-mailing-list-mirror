From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Sat, 17 Feb 2007 18:10:28 -0800
Message-ID: <7vlkiwnrl7.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<Pine.LNX.4.63.0702180105000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v64a0qpa8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180151060.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vhctkp8gk.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180226480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vy7mwnsm9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0702180301220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 03:10:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIbVb-0005LS-HA
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 03:10:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161067AbXBRCKa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 21:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161066AbXBRCKa
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 21:10:30 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:38497 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161067AbXBRCK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 21:10:29 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070218021029.GHJU21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 21:10:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QqAU1W0051kojtg0000000; Sat, 17 Feb 2007 21:10:28 -0500
In-Reply-To: <Pine.LNX.4.63.0702180301220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 18 Feb 2007 03:01:49 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40054>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 17 Feb 2007, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> 
>> >> I strongly disagree from my recent day-job experience. [Explains a 
>> >> convincing use case in favour of cd-up.]
>> >
>> > Hmm. I have to think about that. But a consequence of what you suggest 
>> > would be to disallow git-apply outside of a repository, because then you 
>> > would introduce _another_ inconsistency (git-apply without --index would 
>> > behave differently when inside a repo than when outside of one).
>> 
>> Why?  git-apply outside is like 'patch' isn't it?
>
> So, why shouldn't it be the same inside? That's the inconsistency I am 
> alluding to.

It appears that you are saying we cannot make it consistent in
both ways, and you are probably right.

I think git should cater first to git users who use git in git
repositories, which means consistency inside a git repository
between with --index and without is more important.

We can certainly teach 'git apply' without --index/--cache a new
"stay where you are" option to behave like patch (but do that
only without --index/--cache) inside a git repository for
special cases.
