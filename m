From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] prevent HEAD reflog to be interpreted as current branch reflog
Date: Thu, 01 Feb 2007 12:58:14 -0800
Message-ID: <7vmz3xoas9.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0702011231300.3021@xanadu.home>
	<20070201191323.GA18608@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Feb 01 21:58:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCj0c-0003Ez-VZ
	for gcvg-git@gmane.org; Thu, 01 Feb 2007 21:58:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423007AbXBAU6Q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Feb 2007 15:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423008AbXBAU6Q
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Feb 2007 15:58:16 -0500
Received: from fed1rmmtai16.cox.net ([68.230.241.43]:54026 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1423007AbXBAU6P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Feb 2007 15:58:15 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070201205814.KSVY1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Thu, 1 Feb 2007 15:58:14 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JLyE1W00L1kojtg0000000; Thu, 01 Feb 2007 15:58:14 -0500
In-Reply-To: <20070201191323.GA18608@spearce.org> (Shawn O. Pearce's message
	of "Thu, 1 Feb 2007 14:13:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38401>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Nicolas Pitre <nico@cam.org> wrote:
>> The work in progress to enable separate reflog for HEAD will make it
>> independent from reflog of any branch HEAD might be pointing to. In
>> the mean time disallow HEAD@{...} until that work is completed. Otherwise
>> people might get used to the current behavior which makes HEAD@{...} an
>> alias for <current_branch>@{...} which won't be the case later.
>
> I happen to really like the fact that HEAD@{...} is an alias for
> <current_branch>@{...}.

It is usually easier to type.

> But now that HEAD will soon be getting its own reflog, I guess I
> better relearn how to type <current_branch>.  :-)

One thing that is certain is that master@{...} will mean the
same thing no matter what happens to Nico's series -- it talks
about where the tip of that particular branch was at any recent
time.  Right now HEAD@{...} happens to talk about "the current
branch" (and only the current branch) -- Nico's patch would
change the semantics when/if it is merged.

So I would not mind making sure that our documentation talks
only about specific branch's reflog for now (git grep 'HEAD@{'
in Documentation directory luckily hits nothing) but am a bit
reluctant to remove the already useful shorthand from a working
system.

Although from the consistency point of view, HEAD reflog to
follow swicthing branches like Nico's patch aims for (but not
implements fully yet) makes perfect sense, I still am somewhat
doubtful about it being actually useful in practice.  Even if we
assume it is useful, I think forbidding people from saying
HEAD@{...} right now only because the new semantics is
unimplemented yet feels wrong.  If you use only one branch,
there is no difference between the reflog of master and HEAD
today, without waiting for that "reflog on HEAD".
