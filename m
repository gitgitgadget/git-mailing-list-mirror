From: Junio C Hamano <junkio@cox.net>
Subject: Re: Reverting the whole index-base series
Date: Sun, 15 Apr 2007 16:39:35 -0700
Message-ID: <7vhcrh1a2w.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0704121533560.4061@woody.linux-foundation.org>
	<7vbqhp4diw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704151356450.5473@woody.linux-foundation.org>
	<7vfy712uva.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704151632140.5473@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 01:39:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdEJn-0006He-KS
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 01:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbXDOXjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 19:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbXDOXjg
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 19:39:36 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:58688 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754076AbXDOXjg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 19:39:36 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415233937.MDRB1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 15 Apr 2007 19:39:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id nbfb1W00M1kojtg0000000; Sun, 15 Apr 2007 19:39:35 -0400
In-Reply-To: <Pine.LNX.4.64.0704151632140.5473@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 15 Apr 2007 16:33:46 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44548>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 15 Apr 2007, Junio C Hamano wrote:
>> >
>> > But no, I wasn't following that series, so I probably totally 
>> > misunderstood what you were going after..
>> 
>> Could be.
>> 
>> The issue in short was about:
>> 
>> 	$ git checkout $branch
>> 
>> At this point you think your HEAD is at $branch head, and you
>> are working towards building a commit that has that commit as
>> one of the parents.
>> 
>> Then a gremlin updates the commit HEAD points at.
>
> Ahh, ok. I was kind of expecting that you'd actually do something at 
> "receive-pack" time instead, not at the next commit. That would also solve 
> it - just have an option saying "update the working tree when receiving". 

I specifically did not want to do that, as it would break
existing workflow of pushing into a live repository, knowing the
branch might be checked out at the remote.

Also, the case of multiple working trees sharing the same refs/
namespace cannot be solved by trapping receive-pack alone.
