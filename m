From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Support for partial HTTP transfers
Date: Tue, 27 Sep 2005 10:09:49 -0700
Message-ID: <7v1x3a309u.fsf@assigned-by-dhcp.cox.net>
References: <20050926175204.GC9410@reactrix.com>
	<7vd5mvedcs.fsf@assigned-by-dhcp.cox.net>
	<20050927000931.GA15615@reactrix.com>
	<7vfyrr3vwp.fsf@assigned-by-dhcp.cox.net>
	<20050927153636.GA1377@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 19:12:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKIxm-00050n-Bw
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 19:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVI0RJw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Sep 2005 13:09:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965018AbVI0RJw
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Sep 2005 13:09:52 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:37790 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965017AbVI0RJv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Sep 2005 13:09:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050927170948.QJRO29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Sep 2005 13:09:48 -0400
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20050927153636.GA1377@reactrix.com> (Nick Hengeveld's message of
	"Tue, 27 Sep 2005 08:36:36 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9407>

Nick Hengeveld <nickh@reactrix.com> writes:

> The way I understand this sequence, one and two will not be writing to
> the same file.  When two unlinks tmpfile, one will still be able to 
> write to its local, but the body of the file that one is writing will
> be removed when it closes local.

True.  What I meant by "interesting" is that two is reading from
what one is writing.

>> Not that I think the multiple instances should be prevented at
>> this low level --- if they stomp on each other at this level, it
>> is very likely the they are doing duplicated work on the network
>> side as well, and should be prevented from doing so at much
>> higher level than this, I think.  That's why I said I do not
>> mind BKL upfront in git-fetch.sh.
>
> True, is that something I should include with the partial patch?

No.
