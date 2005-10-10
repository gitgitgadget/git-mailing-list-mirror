From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Fix cygwin install issues
Date: Mon, 10 Oct 2005 02:09:22 -0700
Message-ID: <7vmzlh7n7h.fsf@assigned-by-dhcp.cox.net>
References: <20051010085259.GA18009@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 11:11:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EOtex-0000YH-HM
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 11:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750708AbVJJJJY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 05:09:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVJJJJY
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 05:09:24 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:24480 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750708AbVJJJJY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2005 05:09:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051010090916.GXTM16347.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Oct 2005 05:09:16 -0400
To: Jonas Fonseca <fonseca@diku.dk>
In-Reply-To: <20051010085259.GA18009@diku.dk> (Jonas Fonseca's message of
	"Mon, 10 Oct 2005 10:52:59 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9880>

Jonas Fonseca <fonseca@diku.dk> writes:

> Support installing to paths including spaces.
> Remove any old .exe files so ln will succeed.
>

This is not a complaint but I am just wondering if:

> -	$(INSTALL) -d -m755 $(DESTDIR)$(bindir)
> +	$(INSTALL) -d -m755 "$(DESTDIR)$(bindir)"

this is the right way to quote things.  I suspect it might be
the responsibility of the user to quote them if she chooses to
set bindir or DESTDIR to a funky value, like this:

    $ make bindir="'My Documents\Programs'"

Because depending on how funky the values of bindir and DESTDIR
are, we cannot say double-quote you are giving them is even the
right quoting (think double-quote itself as part of the name).

The other "$X" change to cmd-renames is a good change (I thought
I heard HPA talking about that; maybe he sent one to me and I
dropped it on the floor by mistake, I dunno).  Thanks.
