From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Wed, 12 Oct 2005 14:33:56 -0700
Message-ID: <7vwtkictdn.fsf@assigned-by-dhcp.cox.net>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net>
	<20051007232909.GB8893@steel.home>
	<7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net>
	<20051008064555.GA3831@steel.home>
	<7vachks7aq.fsf@assigned-by-dhcp.cox.net>
	<20051008133032.GA32079@localhost>
	<7v64s7svya.fsf@assigned-by-dhcp.cox.net>
	<7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
	<87mzlgh8xa.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
	<87ek6s0w34.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
	<87slv7zvqj.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510111346220.14597@g5.osdl.org>
	<877jcjmdmq.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510120749230.14597@g5.osdl.org>
	<87vf02qy79.fsf@penguin.cs.ucla.edu>
	<Pine.LNX.4.64.0510121355280.15297@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 12 23:34:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPoEb-0000bO-JW
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 23:34:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932442AbVJLVd6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 17:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbVJLVd6
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 17:33:58 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:14276 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932442AbVJLVd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2005 17:33:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051012213340.WPII29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Oct 2005 17:33:40 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510121355280.15297@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 12 Oct 2005 14:05:25 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10052>

Linus Torvalds <torvalds@osdl.org> writes:

> This is really what my argument boils down to: character set encoding 
> should _not_ EVER affect the _transfer_ of the data. It doesn't matter if 
> something is latin1 or utf-8, the only thing that matters is the byte 
> sequence. Only when you _display_ it should you try to figure out what the 
> byte sequence possibly means.
>
> So I repeat: 
>  - escape as little as possible
>  - make the _viewer_ decide how to view it.

I think the same argument can be made about patch application,
although strictly speaking it is not "viewing".  Let the patch
program decide (or the user to tell her decision to the patch
program) what the unescaped byte sequence in the patch that
represents the path being affected is encoded in, and do
something sensible while taking into account that the pathname
encoding on the working tree may be different from what is
recorded in the patch.

For example, one of my partitions is ntfs mounted with
nls=euc-jp, and I expect the tool to help me apply patches to a
Japanese-named file when the patch is from a system with UTF-8
encoded filenames.
