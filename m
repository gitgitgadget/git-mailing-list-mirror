From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-am and workflow question
Date: Thu, 08 Feb 2007 14:49:24 -0800
Message-ID: <7vveicxo23.fsf@assigned-by-dhcp.cox.net>
References: <FA0FC64E-75D2-4722-8BD9-F7E6C8C9AFA7@kernel.crashing.org>
	<7vodo5153j.fsf@assigned-by-dhcp.cox.net>
	<9A55745B-03D2-47B3-8359-FF2D9575502E@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kumar Gala <galak@kernel.crashing.org>
X-From: git-owner@vger.kernel.org Thu Feb 08 23:49:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFI5G-0006PG-4H
	for gcvg-git@gmane.org; Thu, 08 Feb 2007 23:49:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423281AbXBHWt2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 17:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423316AbXBHWt1
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 17:49:27 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:40899 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423281AbXBHWt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 17:49:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070208224926.FQUG1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 8 Feb 2007 17:49:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MApQ1W00l1kojtg0000000; Thu, 08 Feb 2007 17:49:25 -0500
In-Reply-To: <9A55745B-03D2-47B3-8359-FF2D9575502E@kernel.crashing.org> (Kumar
	Gala's message of "Thu, 8 Feb 2007 10:07:31 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39114>

Kumar Gala <galak@kernel.crashing.org> writes:

> Thanks.  Have there been any thoughts on having git-am apply the patch
> and then let the user do some modifications before the commit?   I
> kinda did this by hand by doing the following:
>
> git-am -i ...
> < suspend >
> patch -p1 < .dotest/patch
> < modify >
> git-diff > .dotest/patch
> < cleanup >
> < resume >

If you are using "am -i", I think the above is already there (I
mean, you should not have to do ^Z where you write <suspend>).
When you get the interactive prompt:

	Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all 

I think you can edit $dotest/patch in whatever way.

However, if I were to do bulk application _with_ incremental
fixup (which I think is a combination that would not work very
well for the way I work, though), I would probably have two
windows (I work inside "screen", so I would use two screens),
and run "am -i" in one and run shell in the other.  Normally I
would just say 'y' to the prompt, and after applying something I
might want to do fixups, I would go to the shell, do fixups and
"commit --amend", come back and let "am -i" to continue with the
next patch.
