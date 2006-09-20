From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] gitweb: Always use git-peek-remote in git_get_references
Date: Wed, 20 Sep 2006 09:09:47 -0700
Message-ID: <7v64fijz90.fsf@assigned-by-dhcp.cox.net>
References: <200609191430.51252.jnareb@gmail.com>
	<200609191431.49641.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:10:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ4e0-0000uE-Iq
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:09:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751640AbWITQJt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWITQJt
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:09:49 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:54477 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751640AbWITQJt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 12:09:49 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920160948.OOOL22977.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 12:09:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qg9a1V0051kojtg0000000
	Wed, 20 Sep 2006 12:09:34 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200609191431.49641.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 19 Sep 2006 14:31:49 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27359>

Jakub Narebski <jnareb@gmail.com> writes:

> Instead of trying to read info/refs file, which might not be present
> (we did fallback to git-ls-remote), always use git-peek-remote in
> git_get_references.
>
> It is preparation for git_get_refs_info to also return references
> info. We cannot use info/refs for git_get_refs_info as the information
> contained therein is usually stale.

What the patch does is sane, but I think the last sentence of
the proposed log message is not.  If info/refs is "usually
stale", it is a bug in the repository to have such a stale file.

The real reason for this patch is that a repository served by
gitweb is not necessarily meant to be fetched over HTTP and
info/refs does not have to be there.
