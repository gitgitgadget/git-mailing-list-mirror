From: Junio C Hamano <junkio@cox.net>
Subject: Re: cg-merge should use git-merge
Date: Mon, 17 Oct 2005 01:31:36 -0700
Message-ID: <7vzmp81r4n.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90510161644l35119401rdc05c081506ae715@mail.gmail.com>
	<46a038f90510161744m7e95303eu8a9942363ffc58a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 17 10:32:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ERQPF-0000jf-66
	for gcvg-git@gmane.org; Mon, 17 Oct 2005 10:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVJQIbi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Oct 2005 04:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVJQIbi
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Oct 2005 04:31:38 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:13814 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932207AbVJQIbh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Oct 2005 04:31:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051017083124.RFZS4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 17 Oct 2005 04:31:24 -0400
To: Martin Langhoff <martin.langhoff@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10181>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> - Junio, would you tolerate a flag for git-merge that says "don't
> autocommit even on cleanly merged"?

I'd *welcome* not just tolerate.

Currently both git-am and git-applypatch call git-merge-resolve
directly, but they should really be calling git-merge with user
supplied strategy with '-s' parameter.  By bypassing git-merge,
they happen to get the "do not commit when you fall back on
3-way merge" semantics, but that is just by accident.

I have a plan to rewrite git-cherry-pick using git-format-patch
piped into git-am (I have not scripted it, but that is the
primary way I do cherry-picks these days), and being able to
customize what happens after merge by git-merge would probably
be useful there as well.
