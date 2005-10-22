From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-rev-list: add "--dense" flag
Date: Fri, 21 Oct 2005 20:55:09 -0700
Message-ID: <7voe5iqk82.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
	<20051022003733.GA8351@pasky.or.cz>
	<Pine.LNX.4.64.0510211814050.10477@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Oct 22 05:56:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ETAU3-00051Z-PD
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 05:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932583AbVJVDzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 23:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932584AbVJVDzP
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 23:55:15 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:32984 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932583AbVJVDzN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 23:55:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051022035443.ZYTF29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 21 Oct 2005 23:54:43 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10467>

Linus Torvalds <torvalds@osdl.org> writes:

> Yes. Note that git-rev-list doesn't actually _do_ the diff, it only checks 
> whether the tree is changed. You still just get a list of commits out of 
> it, and it is up to you to decide what to do with it.
>
> If you're just going to feed them to diff-tree _anyway_, then you might as 
> well not even do the dense thing, because quite frankly, you're just doing 
> extra work.
>
> But let's say that you want to follow a certain filename, what you can do 
> is basically (fake shell syntax with "goto restart")
>...
> or something similar. 

Isn't that only true because you are not doing more than "have
these paths change" in the new rev-list that already has part of
diff-tree?

If rev-list can optionally be told to detect renames internally
(it has necessary bits after all), it could adjust the set of
paths to follow when it sees something got renamed, either by
replacing the original path given from the command line with its
previous name, or adding its previous name to the set of path
limitters (to cover the copy case as well).
