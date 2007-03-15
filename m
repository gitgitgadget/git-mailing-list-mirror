From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Wed, 14 Mar 2007 18:23:40 -0700
Message-ID: <7v4pon5mg3.fsf@assigned-by-dhcp.cox.net>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net>
	<7vodmv7bza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
	<7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0703141728350.9690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Mar 15 02:23:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRegz-0006Ay-02
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 02:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752769AbXCOBXm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Mar 2007 21:23:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752307AbXCOBXm
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Mar 2007 21:23:42 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:38462 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751964AbXCOBXl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Mar 2007 21:23:41 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070315012342.MEHF24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Mar 2007 21:23:42 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id apPg1W00r1kojtg0000000; Wed, 14 Mar 2007 21:23:41 -0400
In-Reply-To: <Pine.LNX.4.64.0703141728350.9690@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 14 Mar 2007 17:33:25 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42268>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 14 Mar 2007, Junio C Hamano wrote:
>
>> "Alex Riesen" <raa.lkml@gmail.com> writes:
>> 
>> > Now I'm happy :)
>> >
>> > ~/linux$ time git diff-tree -r -s v2.6.16 v2.6.20
>> >
>> > real    0m0.137s
>> > user    0m0.117s
>> > sys     0m0.020s
>> > ~/linux$ time ~/projects/git-diff/git-diff-tree -r --quiet v2.6.16 v2.6.20
>> >
>> > real    0m0.006s
>> > user    0m0.000s
>> > sys     0m0.007s
>> 
>> You do not need diff-tree --quiet to do that!
>> 
>> 	$ git-rev-parse v2.6.16^{tree} v2.6.20^{tree}
>
> Well, if you have a path-spec, it can certainly matter.
>
> Personally, I think it's more interesting if this can make a difference 
> for something like
>
> 	git log v2.6.12.. -- drivers/ > /dev/null
>
> but that would require that we actually understand that we can stop early 
> if we ever get to REV_TREE_DIFFERENT. I didn't check if you actually did 
> that optimization.

The code is supposed to be there, but I haven't benched.
