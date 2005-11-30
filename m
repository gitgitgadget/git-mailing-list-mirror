From: Junio C Hamano <junkio@cox.net>
Subject: Re: More merge questions
Date: Wed, 30 Nov 2005 12:23:50 -0800
Message-ID: <7vek4xsx49.fsf@assigned-by-dhcp.cox.net>
References: <7vwtiqzljr.fsf@assigned-by-dhcp.cox.net>
	<20051130131045.28149.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 21:31:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhYUn-0007Bu-Lz
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 21:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVK3UXw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 15:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVK3UXw
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 15:23:52 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:42370 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750713AbVK3UXv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 15:23:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130202217.MHPX20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 15:22:17 -0500
To: linux@horizon.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13015>

linux@horizon.com writes:

> 3) This says that if stage1 and state3 exist, use stage3.
>    3-way says if they're equal, delete the file, while if they're
>    unequal, it's fail.
>
> Given that it all matches up so nicely, I'd like to honestly ask if
> case 3 of the conditions is correct.  I'd think that if I deleted
> a file form te index, and the file wasn't changed on the head I'm
> tracking, the right resolution is to keep it deleted.  Why override
> my deletion?
>
> Sorry if this is a dumb question, but it's not obvious to me.

Funny that I asked exactly the same question when it was done
first:

	http://marc.theaimsgroup.com/?l=git&m=111804744926989

It was a question about then-current code, so other cases might
have been changed/corrected/enhanced since then, but I believe
the behaviour for the case in question here stays the same til
this day, and the response from Linus to that article still
applies.


	http://marc.theaimsgroup.com/?l=git&m=111807024201485

I'll quote only the punch line here, but the whole thing is
worth a read if you want to understand how this evolved and
what the design choices and decisions were:

  Right. We didn't lose anything hugely important. 

  In theory this could be a delete that we've missed, and we could add a 
  flag to actually reject this case. However, it's always easy to "recover" 
  deletes (just delete it again ;), so the loss of information is absolutely 
  minimal, and it allows starting from an empty index file.
