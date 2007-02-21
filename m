From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach 'git apply' to look at $GIT_DIR/config
Date: Wed, 21 Feb 2007 11:35:50 -0800
Message-ID: <7vr6sjnw15.fsf@assigned-by-dhcp.cox.net>
References: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
	<7v8xewsd2j.fsf@assigned-by-dhcp.cox.net>
	<20070217232603.GB30839@coredump.intra.peff.net>
	<7vmz3cqs3d.fsf@assigned-by-dhcp.cox.net>
	<20070217233203.GA6014@coredump.intra.peff.net>
	<Pine.LNX.4.64.0702191450580.20368@woody.linux-foundation.org>
	<7vodnp68p8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191527320.20368@woody.linux-foundation.org>
	<7vwt2d4s6c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702191601300.20368@woody.linux-foundation.org>
	<Pine.LNX.4.64.0702210014140.6485@iabervon.org>
	<Pine.LNX.4.64.0702210836210.4043@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 21 20:35:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJxFu-0003Lq-MV
	for gcvg-git@gmane.org; Wed, 21 Feb 2007 20:35:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422835AbXBUTfx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Feb 2007 14:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422832AbXBUTfw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Feb 2007 14:35:52 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:43586 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422835AbXBUTfv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Feb 2007 14:35:51 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070221193551.IPYW2394.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 21 Feb 2007 14:35:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SKbq1W00B1kojtg0000000; Wed, 21 Feb 2007 14:35:51 -0500
In-Reply-To: <Pine.LNX.4.64.0702210836210.4043@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 21 Feb 2007 08:44:05 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40322>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> We could just make "parse_traditional_patch()" try to take the prefix 
> information into account instead. That would be a better choice than doing 
> it unconditionally even for native git patches.
>
> Junio?

I guess I took your suggestion too literally while being blinded
by the thought to make things consistent.

>> I _think_ that the right answer is to (a) yes, make it be consistent, but 
>> (b) _not_ make it be the way we do "--index" now.
>>
>> Right now, when we see "--index", we do the "setup_git_directory()" and 
>> the git_config() stuff - which is (I think) something we should always do, 
>> but then we do *not* prefix the patch itself with the prefix we got. And I 
>> think that's wrong. I think we should always do the "-p1" behaviour from 
>> where we started.
>
>Hmm.  I am puzzled.  Are you suggesting to change behaviour of
>"git apply" with --index?

We can (and should) obviously do different things depending on
"diff --git".  Let me see.
