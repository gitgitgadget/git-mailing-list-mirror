From: Junio C Hamano <junkio@cox.net>
Subject: Re: Can GIT_EXEC_PATH behave more like PATH?
Date: Wed, 07 Dec 2005 11:14:07 -0800
Message-ID: <7v4q5kra80.fsf@assigned-by-dhcp.cox.net>
References: <20051207141218.GA721@igloo.ds.co.ug>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 20:16:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek4k2-0001oj-25
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 20:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751234AbVLGTOK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 14:14:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751774AbVLGTOK
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 14:14:10 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:37310 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751234AbVLGTOJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 14:14:09 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207191333.ZSMO3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Dec 2005 14:13:33 -0500
To: Martin Atukunda <matlads@dsmagic.com>
In-Reply-To: <20051207141218.GA721@igloo.ds.co.ug> (Martin Atukunda's message
	of "Wed, 7 Dec 2005 17:12:18 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13340>

Martin Atukunda <matlads@dsmagic.com> writes:

> I've been wondering if GIT_EXEC_PATH shouldn't be able to behave more
> like the PATH env. variable?

I do not think it is useful at all.

I think GIT_EXEC_PATH is useful only in two occasions.  (1) When
Porcelains want to bypass "git" to avoid extra forking, it can
ask where the executables are just once to "git --exec-path",
and export GIT_EXEC_PATH with that single path; (2) When you
want to try out a freshly built git without installing, you can
export GIT_EXEC_PATH set, again with the single path that is
where the build directory is.  Neither wants a list of
directories.

When users use "git frotz", the git command internally knows
where the right version of subcommands are stored.  When reason
you would want to override that, you would exactly know one
directory with which you want to override it.  You do not want
GIT_EXEC_PATH="/usr/lib/git-1.02:/usr/lib/git" in such a case,
either.
