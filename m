From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-daemon: --inetd implies --syslog
Date: Mon, 14 Nov 2005 12:54:46 -0800
Message-ID: <7vlkzrx84p.fsf@assigned-by-dhcp.cox.net>
References: <20051114164101.58A495BF92@nox.op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 14 21:55:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EblLw-0002J0-IO
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 21:55:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVKNUyu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 15:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbVKNUyt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 15:54:49 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:31362 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932125AbVKNUyt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2005 15:54:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051114205336.VGGG20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 14 Nov 2005 15:53:36 -0500
To: exon@op5.se (Andreas Ericsson), "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <20051114164101.58A495BF92@nox.op5.se> (Andreas Ericsson's
	message of "Mon, 14 Nov 2005 17:41:01 +0100 (CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11846>

exon@op5.se (Andreas Ericsson) writes:

> Otherwise nothing is logged anywhere, which is a Bad Thing.
>
> Signed-off-by: Andreas Ericsson <ae@op5.se>

Thanks; I am OK with what you are trying to do with this change,
except that:

 - I suspect closing stderr is still needed (the "workaround"
   was about inetd connection sending output to both fd 1 and 2
   to the client, which would corrupt the protocol conversation
   when exec'ed program writes anything to its standard error
   stream).

 - I would have preferred the removal of needless else as a
   separate cleanup patch (this is minor).

Peter, I am CC'ing this to you because I do not know how you run
the daemon on kernel.org machines -- I suspect you use --syslog
already and am hoping you are OK with this change.
