From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rev-list: fix --header
Date: Mon, 17 Apr 2006 14:42:01 -0700
Message-ID: <7vhd4rlw0m.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0604171443300.18017@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vwtdom1t9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0604172222390.19593@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 17 23:42:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVbU1-0004Kg-QX
	for gcvg-git@gmane.org; Mon, 17 Apr 2006 23:42:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbWDQVmG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 17:42:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWDQVmG
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 17:42:06 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:46306 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751334AbWDQVmF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Apr 2006 17:42:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060417214202.YCJK18351.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Apr 2006 17:42:02 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18836>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Wouldn't this be simpler and do the same thing, I wonder?  The
>> point being that "--pretty --header" and "--header --pretty"
>> traditionally did not make --header to override --pretty.
>
> I thought, why not fix that bug, too? After all, it is counterintuitive 
> what "--header --pretty" does, and it was easy to fix.

I checked with 0.99.9m and both "--pretty --header" and
"--header --pretty" gives preference to --pretty.  I think your
patch changes it to favor whichever comes later.

I thought it could be considered a bug to accept --header and
--pretty at the same time without complaining, but if you want
to forbid it, you could error out.  However, that might break
existing Porcelains, and that's why I suggested to keep the
traditional "--pretty wins over --header" behaviour.

If gitk were the only Porcelain we care about that uses
--header, it would make more sense to change the rule to
"--header trumps --pretty" and "gitk --pretty" would magically
start working.

Still undecided.  As you say it is an easy change, so I'd rather
leave the behaviour as before for now.
