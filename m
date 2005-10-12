From: Junio C Hamano <junkio@cox.net>
Subject: Re: Strangely broken git repo
Date: Tue, 11 Oct 2005 21:22:45 -0700
Message-ID: <7virw3qs8a.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510062014l7f5740e0l77fc53b50f822e8f@mail.gmail.com>
	<46a038f90510082014i6b296f2bvbac56e25344cbdf2@mail.gmail.com>
	<4349ED5D.6020703@catalyst.net.nz>
	<7v4q7p927d.fsf@assigned-by-dhcp.cox.net>
	<20051012032646.GA14819@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Martin Langhoff (CatalystIT)" <martin@catalyst.net.nz>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 06:24:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPY8h-0007w2-Sm
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 06:22:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbVJLEWs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 00:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbVJLEWs
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 00:22:48 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:65172 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932417AbVJLEWr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 00:22:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051012042239.OVVT19461.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 00:22:39 -0400
To: Nick Hengeveld <nickh@reactrix.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10003>

Nick Hengeveld <nickh@reactrix.com> writes:

> Oops, thanks for catching that - I'll fix it.

That's OK.  It turns out that fetch_alternates() function itself
is now called from the main just once; it used to be called
lazily and needed the call-once guard.

> I'd thought about chaining the alternates, but wasn't sure whether it's
> safe to consider all alternates in the chain equivalent.

Well, I decided we shouldn't, because the original repository
that has objects/info/alternates surely doesn't.
