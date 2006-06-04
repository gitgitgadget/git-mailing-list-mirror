From: Junio C Hamano <junkio@cox.net>
Subject: Re: Gitk feature - show nearby tags
Date: Sun, 04 Jun 2006 02:21:39 -0700
Message-ID: <7vodx9cm3g.fsf@assigned-by-dhcp.cox.net>
References: <17537.22675.678700.118093@cargo.ozlabs.ibm.com>
	<7vslmm8rcd.fsf@assigned-by-dhcp.cox.net>
	<e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <junkio@cox.net>,
	"Paul Mackerras" <paulus@samba.org>, git@vger.kernel.org,
	"Jonas Fonseca" <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Sun Jun 04 11:21:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fmonp-0008Uc-5V
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 11:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWFDJVm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 05:21:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWFDJVm
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 05:21:42 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:60811 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750856AbWFDJVl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jun 2006 05:21:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060604092140.CHGR18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Jun 2006 05:21:40 -0400
To: "Marco Costalba" <mcostalba@gmail.com>
In-Reply-To: <e5bfff550606030416s2ef6182crbde1395dd29e5b94@mail.gmail.com>
	(Marco Costalba's message of "Sat, 3 Jun 2006 13:16:45 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21253>

"Marco Costalba" <mcostalba@gmail.com> writes:

> As example given a selected revision with id <sha> is it possible to
> do something like this to fond the ancestor?
>
> 1) get the tag list with git-peek-remote or something similar if tags
> are not already loaded
>
> 2) given the tagList vector with n elements run
>
>    git-rev-list  --topo-order <sha> ^tagList[0]  ^tagList[1]   ....
>  ^tagList[n-1]
>
> 3) take the last sha spit out by git-rev-list, be it <lastSha>.
>
> 4) Previous nearest tag is the parent of lastSha

Sorry, I do not understand what you are doing here at all.
Suppose you have this simple history.

  (root)

         a---b---d---e---f---g
         t1   \ /        t3        
            ---c
               t2

and <sha1> in (2) is "e".  When tagList = (t1, t2, t3), the
above rev-list would return empty.  For tagList = (t1, t2), the
rev-list would return "e", and then "d".  Parent of "d" are "b"
and "c", and c is tagged but b is not.  So if you are willing to
try 2^N permutations of what tagList to use, then the above
sequence, with a bit of tweak to step (4) to see which parents
are tagged, would yield the closest tag in the past of "e", but
is that what you are suggesting?
