From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Log message printout cleanups
Date: Mon, 17 Apr 2006 17:57:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0604171751540.3701@g5.osdl.org>
References: <Pine.LNX.4.64.0604161433000.3701@g5.osdl.org>
 <7vbqv1oxie.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604171149330.3701@g5.osdl.org>
 <7vodyzkehq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0604171647380.3701@g5.osdl.org>
 <7vejzvka09.fsf@assigned-by-dhcp.cox.net> <7v7j5nk9bf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 18 02:57:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FVeX8-0007ME-LH
	for gcvg-git@gmane.org; Tue, 18 Apr 2006 02:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWDRA51 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Apr 2006 20:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932099AbWDRA51
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Apr 2006 20:57:27 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43152 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932098AbWDRA51 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Apr 2006 20:57:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3I0vLtH012628
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 17 Apr 2006 17:57:21 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k3I0vK6S029454;
	Mon, 17 Apr 2006 17:57:20 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7j5nk9bf.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.72__
X-MIMEDefang-Filter: osdl$Revision: 1.133 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18846>



On Mon, 17 Apr 2006, Junio C Hamano wrote:
> 
> These days I find myself running "git log --stat" more often
> than "git whatchanged"; it looks so much nicer ;-).
> 
> Thanks for a job well done.

There's actually something _wrong_ with "git log --stat". 

What happens is that "git log" will enable "rev.combine_merges" by 
default, and that means that together with "--stat" ignoring merges by 
default, it will _instead_ generate a "--cc" diff for that merge.

I think that behaviour was introduced by the "--stat" code by Dscho, and 
not by my rewrite.

You can see it on the kernel archive on commit 88dd9c16, for example:

	git log --stat 88dd9c16

will make it pretty obvious what I'm talking about.

I still haven't looked a lot at what the diffstat code does, so I don't 
know what the obvious fix is. Maybe setting "ignore_merges". And maybe 
just making the diffstat thing do the right thing for merges. 

I'll leave that up to you, I'm getting pretty fed up with "git log" right 
now ;)

		Linus
