From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Fri, 22 Jul 2005 12:46:36 -0700
Message-ID: <7vsly6vd2b.fsf@assigned-by-dhcp.cox.net>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net>
	<20050722181800.GU20369@mythryan2.michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri Jul 22 21:47:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw3Uu-0003kh-5n
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 21:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262147AbVGVTqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 15:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261346AbVGVTqz
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 15:46:55 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:61056 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262149AbVGVTqn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2005 15:46:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050722194635.KOMW16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 22 Jul 2005 15:46:35 -0400
To: Ryan Anderson <ryan@michonline.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Ryan Anderson <ryan@michonline.com> writes:

> On Fri, Jul 22, 2005 at 09:56:19AM -0700, Junio C Hamano wrote:
>> Now if we had a mechanism to graft a later history which starts
>> at 2.6.12-rc2 on top of this earlier history leading up to
>> it,...  ;-)
>
> We do - it's not even very hard, we just end up with 2 commits for every
> change/merge that's unique to git, until we get to the current head:

Aren't you essentially rewriting the history after 2.6.12-rc2?.
I suspect that would invalidate the current linux-2.6 history
people have been basing their work on since 2.6.12-rc2, which is
unacceptable.  That is not what I meant by "grafting".

What I meant was to give a hint to the core that says "this
2.6.12-rc2 commit in the current linux-2.6.git tree is recorded
as not having a parent, but please consider it the same as this
other 2.6.12-rc2 commit in the 2.4.0->2.6.12-rc2 history when
traversing the commit ancestry chain".

If git-rev-list is taught about that, then you will see "git
log" going across 2.6.12-rc2.  If git-merge-base is taught about
that, it will be able to find a merge base to merge a line of
development that is forked from say 2.6.11 to the current tip of
linux-2.6 tree.
