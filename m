From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach git-remote to list pushed branches.
Date: Mon, 19 Mar 2007 15:36:29 -0700
Message-ID: <7v648wg8sy.fsf@assigned-by-dhcp.cox.net>
References: <200703182134.46450.johannes.sixt@telecom.at>
	<7vzm6ajnj1.fsf@assigned-by-dhcp.cox.net>
	<200703192016.46894.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Mar 19 23:36:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTQSw-00057Z-VK
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 23:36:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965045AbXCSWgb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 18:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965138AbXCSWgb
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 18:36:31 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:56914 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965045AbXCSWga (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 18:36:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070319223631.LIIE1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Mon, 19 Mar 2007 18:36:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id cmcW1W00H1kojtg0000000; Mon, 19 Mar 2007 18:36:30 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42676>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> On Sunday 18 March 2007 21:37, Junio C Hamano wrote:
>> Johannes Sixt <johannes.sixt@telecom.at> writes:
>> >  The hunk that reads the 'Push'es from the .git/remotes file is taken
>> >  almost verbatim from the corresponding 'Pull' clause and is untested.
>>
>> Maybe while waiting for application nor comments you could have
>> tested and removed that comment?
>
> Fair enough ;)
>
> While waiting for application or comments again, I did test
> now, and the patch does what I expect even for .git/remotes
> files, that is, it prints the refs to be pushed just like it
> does for remotes noted in the config file.

Thanks, and sorry for that comment as I was in a grumpy mood.

Let's queue it in 'next', as I do not see anything obviously
wrong with it [*1*].

Now let's find other people who find this new feature
desirable.  I am personally neutral right now.


[Footnote]

*1* Actually I think the refspec list on "Push: " lines should
be split out into separate array elements, because

	Push: A B C

is equivalent to

	Push: A
        Push: B
        Push: C

This does not apply to "Pull: " lines, as

	Pull: A B C

and

	Pull: A
	Pull: B
	Pull: C

mean quite different things.

This distinction does not matter to the current callers, but I
was hoping that somebody would build "interactive" mode to edit
Push and Pull list, and when that happens, having A B C as
separate entries in @{$hash->{$name}{'PUSH'}} would be handier
to code.
