From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: prepare for repositories with packed refs.
Date: Sat, 07 Oct 2006 03:26:00 -0700
Message-ID: <7v1wpks9qf.fsf@assigned-by-dhcp.cox.net>
References: <7vsli5pwqf.fsf@assigned-by-dhcp.cox.net>
	<20061006154059.GQ20017@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 12:26:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GW9Ni-0003BP-R4
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 12:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWJGK0E (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 06:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750807AbWJGK0E
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 06:26:04 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:31697 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750801AbWJGK0C (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 06:26:02 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061007102601.VDSF2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sat, 7 Oct 2006 06:26:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id XNS31V00l1kojtg0000000
	Sat, 07 Oct 2006 06:26:04 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20061006154059.GQ20017@pasky.or.cz> (Petr Baudis's message of
	"Fri, 6 Oct 2006 17:40:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28471>

Petr Baudis <pasky@suse.cz> writes:

> Having HEAD a dangling
> symlink is just wrong...

While I still disagree with this statement, as a practical
issue, I think it might make sense to have an option to
pack-refs to pack only tags, which are supposed to be mostly
immutable.  Or even introduce --all option and make the default
pack only tags.  Your branches point at commits waiting to be
updated, and if you have remote tracking branches they are meant
to be updated every time you fetch from that remote; otherwise
you would not be using tracking branches but merging straight
into your branch.

Also you are likely to do pack-refs (or whatever repository-wide
git operations) while on an active branch (be it "master" or
some non-master branch similar to my "next" or "pu"), and for
that reason I suspect packing the current branch is almost
always not very useful.  Active branches are by definition
expected to frequently change.
