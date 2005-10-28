From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Thu, 27 Oct 2005 20:52:07 -0700
Message-ID: <7vr7a6z4bc.fsf@assigned-by-dhcp.cox.net>
References: <20051027203945.GC1622@pe.Belkin>
	<7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net>
	<46a038f90510271816i26389d5cqe136f515007ca057@mail.gmail.com>
	<Pine.LNX.4.64.0510271933140.4664@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 05:53:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVLI9-0006NK-KS
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 05:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965080AbVJ1DwL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 23:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965081AbVJ1DwL
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 23:52:11 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:26839 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S965080AbVJ1DwK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 23:52:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051028035136.EWVW29216.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Oct 2005 23:51:36 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510271933140.4664@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 27 Oct 2005 19:38:21 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10753>

Linus Torvalds <torvalds@osdl.org> writes:

> Well, if you do full copy detection (and break detection), then 
> git-diff-tree will actually have effectively calculated the size of the 
> diff of each file. It just doesn't print them (well, it does a percentage 
> for the renames/copies).

Unbroken in-place edit would never go through diffcore-rename,
so that is a gross overstatement.

But we could if we wanted to.  I do not know how useful it would
be, but if somebody wants to do it, I think the best strategy is
to do as a separate diffcore backend that comes after
diffcore_rename() runs, and do the similarity estimator only on
filepairs that rename/copy did not touch.
