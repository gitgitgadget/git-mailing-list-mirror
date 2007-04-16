From: Junio C Hamano <junkio@cox.net>
Subject: Re: Reverting the whole index-base series
Date: Sun, 15 Apr 2007 17:11:19 -0700
Message-ID: <7v8xct18m0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
	<7vbqhp4diw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704151356450.5473@woody.linux-foundation.org>
	<7vfy712uva.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704151632140.5473@woody.linux-foundation.org>
	<7vhcrh1a2w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704151652420.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 02:11:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdEoV-00086t-ND
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 02:11:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbXDPALV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 20:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbXDPALV
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 20:11:21 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:48637 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133AbXDPALU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 20:11:20 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416001119.MJOZ1218.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 20:11:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ncBK1W00P1kojtg0000000; Sun, 15 Apr 2007 20:11:20 -0400
In-Reply-To: <Pine.LNX.4.64.0704151652420.5473@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 15 Apr 2007 16:58:24 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44555>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> ... That said, maybe we could make it an option. There's really a few 
> different things we could do:
>
>  (a) what we do now - the working tree and index is totally unaffected
>  (b) do a "git-read-tree -m old new" and if that fails, fail the push.
>      This would at least ensure the *index* matches
>  (b') same as (b), but with "-u" to actually check it out
>  (c) do a "git-read-tree --reset new"
>  (c') same as (c), but with "-u"
>
> and we could just keep the *default* the same, but allow the receiving 
> side to say what it wants to happen.

Yeah, throw another one in:

 (d) what we do now, but detach HEAD.

> So if somebody does
>
> 	git push remote:my-git-tree/.git/
>
> then we'd *always* do (a), since we pushed into the "bare" part, but if 
> somebody did
>
> 	git push remote:my-git-tree
>
> and the receiver ended up doing a "cd .git", it would remember what the 
> checked-out tree was and update that one (and no other).

I suspect that this would make the pending "GIT_WORK_TREE"
series more interesting.
