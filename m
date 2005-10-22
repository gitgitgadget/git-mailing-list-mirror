From: Junio C Hamano <junkio@cox.net>
Subject: Re: Handling renames.
Date: Fri, 21 Oct 2005 19:10:59 -0700
Message-ID: <7vbr1is3m4.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0510211631400.10477@g5.osdl.org>
	<20051022003733.GA8351@pasky.or.cz>
	<20051022004743.GN30889@pasky.or.cz>
	<Pine.LNX.4.64.0510211826350.10477@g5.osdl.org>
	<20051022015109.GO30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 22 04:12:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ET8qg-0008Ov-UQ
	for gcvg-git@gmane.org; Sat, 22 Oct 2005 04:11:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbVJVCLD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 22:11:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932567AbVJVCLD
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 22:11:03 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:63385 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932565AbVJVCLB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 22:11:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051022021033.GEBX29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 21 Oct 2005 22:10:33 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051022015109.GO30889@pasky.or.cz> (Petr Baudis's message of
	"Sat, 22 Oct 2005 03:51:09 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10462>

Petr Baudis <pasky@suse.cz> writes:

>> I'm convinced that git handles renames better than any other SCM ever. 
>> Exactly because we figure it out when it matters.
>
> It matters at least every time you show per-file history and every time
> you merge cross the rename. I think that can be both pretty common if
> you ever do the rename. That means you can do an expensive guess
> every time you hit that, and the guess can get it wrong, in which case
> there is no way around that and you lose.

I think it is OK for the higher level layer (like your
single-file-history follower) to use what you outlined with
"edges", as either a hint/request from the user and/or a cache
of what the expensive and unreliable thing figured out.

I however do not necessarily think adding the "edges"
information as an optional second item on "parent " line in a
commit is a good idea.  Rather, treating the set of "edges" just
like we treat the grafts feel more appropriate to me.  IOW,
create .git/info/edges and keep your edge information there.
