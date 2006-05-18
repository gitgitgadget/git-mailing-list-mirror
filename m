From: Junio C Hamano <junkio@cox.net>
Subject: Re: Do "git add" as a builtin
Date: Thu, 18 May 2006 09:50:00 -0700
Message-ID: <7vzmhfnupz.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605170927050.10823@g5.osdl.org>
	<7vhd3ocvyy.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605171321020.10823@g5.osdl.org>
	<7v64k3698l.fsf@assigned-by-dhcp.cox.net>
	<7vwtcj4tp6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0605180807060.10823@g5.osdl.org>
	<Pine.LNX.4.64.0605180917060.10823@g5.osdl.org>
	<Pine.LNX.4.64.0605180929450.10823@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 18 18:50:40 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FglhZ-00062V-Su
	for gcvg-git@gmane.org; Thu, 18 May 2006 18:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751377AbWERQuE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 May 2006 12:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWERQuE
	(ORCPT <rfc822;git-outgoing>); Thu, 18 May 2006 12:50:04 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:26051 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751377AbWERQuC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 May 2006 12:50:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060518165001.TZWH27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 May 2006 12:50:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605180929450.10823@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 18 May 2006 09:35:58 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20292>

Linus Torvalds <torvalds@osdl.org> writes:

> Thinking some more about it, I think I personally much prefer this.

I like this much better than the old (pre-builtin) behaviour.

> Especially as a quick look-through seems to say that there's actually a 
> path through git-update-index too that allows a unverified filename to get 
> into the index (the new "--unresolve" thing also misses the need to verify 
> the path).

Perhaps, but unresolve splits an entry that is available from
the heads being merged, so it would use unverified filename to
try finding the ents from trees, but get_tree_entry() would not
find one, so I think we are safe already.  Nevertheless, I think
your change makes things more strict and safer.

I doubt this would break people's scripts.  If they were relying
on the old behaviour, that means they threw real paths and
garbage at update-index and relied on it to sift them apart,
which indicates they were buggy to begin with anyway.
