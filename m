From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: disable checkout of remote branch
Date: Sun, 21 Jun 2009 16:27:13 -0700
Message-ID: <7vtz29p3qm.fsf@alter.siamese.dyndns.org>
References: <19004.34350.109422.730109@cargo.ozlabs.ibm.com>
	<slrnh3ru9v.vgo.sitaramc@sitaramc.homelinux.net>
	<7v3a9uszzl.fsf@alter.siamese.dyndns.org>
	<20090622063405.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 01:37:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIWb6-0000t3-1F
	for gcvg-git-2@gmane.org; Mon, 22 Jun 2009 01:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752961AbZFUX1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 19:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752707AbZFUX1M
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 19:27:12 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:63282 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752666AbZFUX1L (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 19:27:11 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090621232715.KEXE18948.fed1rmmtao107.cox.net@fed1rmimpo03.cox.net>;
          Sun, 21 Jun 2009 19:27:15 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 6nTE1c0044aMwMQ04nTEud; Sun, 21 Jun 2009 19:27:14 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=abpcs_R5fxsA:10 a=UQnXkbzPAAAA:8
 a=ybZZDoGAAAAA:8 a=pGLkceISAAAA:8 a=aE5LevW6fwYiF-tSB-cA:9
 a=FyQPkjtItjoX3CiQYsZLPcZAsSwA:4 a=Q21-j9j7q-gA:10 a=qIVjreYYsbEA:10
 a=MSl-tDqOz04A:10
X-CM-Score: 0.00
In-Reply-To: <20090622063405.6117@nanako3.lavabit.com> (Nanako Shiraishi's message of "Mon\, 22 Jun 2009 06\:34\:05 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122001>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Quoting Junio C Hamano <gitster@pobox.com>:
>
>> Sitaram Chamarty <sitaramc@gmail.com> writes:
>>
>>> At the command line, this gives you a detailed warning message, but the
>>> GUI currently allows it without any fuss.
>>>
>>> Since the GUI is often used by people much less familiar with git, it
>>> seems reasonable to make the GUI more restrictive than the command line,
>>> not less.
>>> ...
>>> This patch helps me a lot.
>>
>> The patch seems to disable checkout unconditionally, but it at least needs
>> an "expert mode" switch to bypass the patch's logic, or (better yet) a
>> "training wheel" switch for you to set in repositories of the people you
>> manage.
>
> It will be more helpful if it checked out a new local branch that tracks
> the remote branch, instead of refusing what the user asked to do. It may
> need a new dialog that asks to confirm (and allows the user to change)
> the name of the new branch.

Heh, stop, step back and think a bit.  I admit that it wasn't just you; we
were both blind.

If we unconditionally disable "check out this branch" from the context
sensitive menu for the tip of a remote tracking branch, I do not think we
lose anything.  If one wants to start a new local branch from there, one
can use the context sensitive menu for an arbitrary commit (rowmenu) and
say "Create new branch".

If we wanted users of gitk to use it to detach HEAD, the current UI is not
a good way to do so anyway --- it only allows detaching the tip of remote
tracking branches and not an arbitrary commit.

	Side note.  I am not arguing it is a good idea.  I am only saying
	that if it were a good idea, such an action should be in rowmenu
	that applies to any commit, not headmenu that applies only to the
	tips of refs. 

So I retract my earlier objection entirely.  I do not think the feature
Sitaram is disabling was meant to allow detaching HEAD at all and it can
be safely disabled for remote tracking branches to make the GUI experience
safer.
