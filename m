From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Fri, 13 Jan 2006 12:46:23 -0800
Message-ID: <7vvewn3lgg.fsf@assigned-by-dhcp.cox.net>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
	<20060112190031.GH14196@ca-server1.us.oracle.com>
	<7vhd89mc0y.fsf@assigned-by-dhcp.cox.net>
	<20060113065855.GJ14196@ca-server1.us.oracle.com>
	<7vpsmwbo9s.fsf@assigned-by-dhcp.cox.net>
	<20060113191231.GM14196@ca-server1.us.oracle.com>
	<7vhd877w9m.fsf@assigned-by-dhcp.cox.net>
	<20060113200124.GO14196@ca-server1.us.oracle.com>
	<7virsn50lv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 21:46:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExVok-0007DF-Bg
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 21:46:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422943AbWAMUq1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 15:46:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422944AbWAMUq1
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 15:46:27 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:53209 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1422943AbWAMUq0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 15:46:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113204516.MWIX6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 15:45:16 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virsn50lv.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 13 Jan 2006 12:33:48 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14647>

Junio C Hamano <junkio@cox.net> writes:

> Joel Becker <Joel.Becker@oracle.com> writes:
>
>> On Fri, Jan 13, 2006 at 11:39:17AM -0800, Junio C Hamano wrote:
>>> That's what I do.  Although I use git-am not git-applymbox, both
>>> of them are designed to work that way.
>>
>> 	While I can see that git-am and git-applymbox have different
>> options for the same basic task, I can't quite see why one would be
>> preferred to the other.  What does git-am do that git-applymbox does
>> not?

The behaviour upon seeing unapplicable patch is somewhat
different.  In Linus workflow, he reviews (and modifies if
necessary) all patches inside mbox and runs "applymbox"; upon
failure, he blows what remains in .dotest away, trims mbox to
get rid of what has already been applied and re-runs it from
scratch.  The failure recovery method "applymbox" had (this
happened before my time IIRC) is to edit .dotest/patch to make
it applicable and re-run it.  OTOH, "am" tries to do better by
allowing you to hand tweak the working tree to match what would
have resulted if the patch applied cleanly and say "--resolved".

Another difference is that "am" can be told to handle binary
file changes and apply such as long as the patch is intra
repository (i.e. both pre and post image blob are available in
the repository).  This is used as a backend to do "git rebase".
