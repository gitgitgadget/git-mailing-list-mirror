From: Junio C Hamano <junkio@cox.net>
Subject: Re: Union diff
Date: Sun, 09 Apr 2006 02:45:37 -0700
Message-ID: <7vslonaxq6.fsf@assigned-by-dhcp.cox.net>
References: <20060326102100.GF18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 09 11:45:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FSWUP-0003E9-GM
	for gcvg-git@gmane.org; Sun, 09 Apr 2006 11:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750711AbWDIJpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Apr 2006 05:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWDIJpj
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Apr 2006 05:45:39 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:25031 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750711AbWDIJpi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Apr 2006 05:45:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060409094538.UQYB15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 9 Apr 2006 05:45:38 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20060326102100.GF18185@pasky.or.cz> (Petr Baudis's message of
	"Sun, 26 Mar 2006 12:21:00 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18545>

Petr Baudis <pasky@ucw.cz> writes:

>   Now, the -c option documentation says:
>
> 	  It shows the differences from each of the parents to the merge
> 	result simultaneously, instead of showing pairwise diff between
> 	a parent and the result one at a time, which '-m' option output
> 	does.
>
>   This sounds as exactly what I want. Well, the only problem is that the
> same diff command as above with -c option added produces no diff at all,
> just the header and commit messages. Did I misunderstand the -c
> description and does it do something different?

The --combined diff option is to show merges more sensibly than
plain -m option.  Now, the definition of "sensible" is to say
that a merge is not interesting if it takes a version from one
of the parents.  The paths whose results do not match any of the
parents' version are deemed interesting and are shown.

I think you could tweak and give an option to intersect_paths()
in combine-diff.c, so that paths that match one of the parents
are also included in the output.  I haven't thought about it too
much, but my gut feeling is it would not be very involved
change.
