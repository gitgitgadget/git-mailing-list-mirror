From: Junio C Hamano <junkio@cox.net>
Subject: Re: A note on merging conflicts..
Date: Fri, 30 Jun 2006 20:08:20 -0700
Message-ID: <7vy7vedntn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 01 05:08:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwVqM-0003jp-Ug
	for gcvg-git@gmane.org; Sat, 01 Jul 2006 05:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbWGADIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 23:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbWGADIW
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 23:08:22 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:47558 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751258AbWGADIV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 23:08:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060701030821.GZOE22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 30 Jun 2006 23:08:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 30 Jun 2006 19:44:32 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23035>

Linus Torvalds <torvalds@osdl.org> writes:

> Now, the downside is that the above is both a pain to type, and we don't 
> actually even save the MERGE_BASE as a head, so you actually have to 
> compute it yourself. It's easy enough to do:
>
> 	git-merge-base HEAD MERGE_HEAD > .git/MERGE_BASE
>
> will do it, but the fact is, we should make this even easier.

Heh, that's why I kept saying I want somebody to teach rev-list
a new notation, A...B, to mean $(merge-base A B)..B ;-).

> In fact, after writing the above a few times, I really think there's a 
> case for making a helper function that does exactly the above for us. 
> Including all the "conflicting-filename" thing. It would be nice if
>
> 	git log -p --merge [[--] filenames...]
>
> would basically expand to
>
> 	git log -p HEAD MERGE_HEAD
> 		^$(git-merge-base HEAD MERGE_HEAD)
> 		-- $(git-ls-files -u [filenames...])
>
> so that I wouldn't have to type that by hand ever again, and doing a
>
> 	git log -p --merge drivers/
>
> would automatically give me exactly that for all the unmerged files in 
> drivers/.

> Anybody want to try to make me happy, and learn some git internals at the 
> same time?

I fall in the former category but as the current maintainer I
feel I should leave chance to do the latter to others first.  I
wouldn't call it "trivial" but it is not that hard -- I think I
can write it in my head (as Linus can).
