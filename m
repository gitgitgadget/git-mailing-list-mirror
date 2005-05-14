From: Petr Baudis <pasky@ucw.cz>
Subject: Rename tracking
Date: Sat, 14 May 2005 17:11:59 +0200
Message-ID: <20050514151159.GL3905@pasky.ji.cz>
References: <7vk6m260xf.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 17:12:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWyJC-0003Yk-Px
	for gcvg-git@gmane.org; Sat, 14 May 2005 17:12:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262780AbVENPMG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 11:12:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbVENPMG
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 11:12:06 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13466 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262780AbVENPMB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 11:12:01 -0400
Received: (qmail 11161 invoked by uid 2001); 14 May 2005 15:11:59 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk6m260xf.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 03:39:24AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Here are three patches to update diff we discussed earlier.
> 
>   [PATCH 1/3] Update mode-change strings in diff output.
>   [PATCH 2/3] Rename git-diff-tree-helper to git-diff-helper.
>   [PATCH 3/3] Rename git-diff-tree-helper to git-diff-helper (part 2).
> 
> The first one is to normalize the mode bits output to be more
> machine friendly, which we discussed.

I'll postpone it for another while since there is still some discussion
about tuning the output.

> The second commit records only renames for two files and there
> is no content change.  The third one is to change the Makefiles,
> documentation, and also usage string in git-diff-helper itself.
> 
> I am deliverately doing the 2 and 3 in separate steps for two
> reasons.  (1) to reduce the possibility of mistakes during the
> rename for myself; (2) people doing the git repository browser
> can use the commit trail for practicing their rename detection
> logic.  So please keep these two steps separate when you commit.

I buy that it is nice for now to keep the changes to the renamed files
separate, but I don't see why should I withhold changing other files
in parallel with the rename.

But I think we really need explicit rename tracking, since this really
sucks. And even if someone would written a hyperintelligent content
moves heuristic tracker, it would be horribly slow on longer distances,
and more importantly it could still be confused when renaming several
similar or same files in parallel.

I'm thinking about using "\n---\n\n" in commit message to separate some
"internal data" like this. cg-log (and web interfaces and other
toolkits, if we get to agree on something common) could then by default
hide it. Below it would contain something which we could hopefully embed
in patches too (actually less work for extracting patches by cg-mkpatch
or similar tools). What do you think?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
