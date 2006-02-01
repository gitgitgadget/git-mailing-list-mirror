From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Bottlenecks in git merge
Date: Tue, 31 Jan 2006 17:04:00 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601311701000.7301@g5.osdl.org>
References: <20060131213314.GA32131@ebar091.ebar.dtu.dk>
 <7vk6cgq9ny.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601311533040.7301@g5.osdl.org>
 <20060201005035.GD31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Peter Eriksen <s022018@student.dtu.dk>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 01 02:04:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F46Px-0007ox-2J
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 02:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWBABEN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 20:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751319AbWBABEN
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 20:04:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:22484 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751305AbWBABEL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jan 2006 20:04:11 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k11141DZ018664
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 Jan 2006 17:04:02 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k11140aL011104;
	Tue, 31 Jan 2006 17:04:01 -0800
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060201005035.GD31278@pasky.or.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.67__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15372>



On Wed, 1 Feb 2006, Petr Baudis wrote:
> 
> xpasky@machine[0:0]~/linux-2.6.git$ echo -e '#!/bin/sh\n/bin/true' >r && chmod a+x r
> xpasky@machine[0:0]~/linux-2.6.git$ time git-merge-index -o ./r -a
> 
> real    0m3.827s
> user    0m1.788s
> sys     0m2.004s
> xpasky@machine[0:0]~/linux-2.6.git$ time git-merge-index -o ~/git-pb/git-merge-one-file -a
> [lots of "Removing"]
> 
> real    1m21.773s
> user    0m30.806s
> sys     0m13.248s
> 
> The costs are apparently in git-update-index, not in the shell.

Btw, this is where "oprofile" really shines. You can get exact listings of 
which symbols in which programs are taking up CPU-time, even when the time 
is spent in hundreds of different executions of a program.

Me, I'm too lazy to use it often, but not too lazy to point others towards 
it.

You do need to have kernel support for it compiled in, and it works better 
on certain CPU's (that have supported counters) than on others.

		Linus
