From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 4/6] Make it possible to set up libgit directly (instead of from the environment)
Date: Mon, 3 Jul 2006 23:30:59 +0200
Message-ID: <20060703213059.GO29115@pasky.or.cz>
References: <20060703204415.28541.47920.stgit@machine.or.cz> <20060703204803.28541.67315.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 03 23:31:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxW0Y-0007Si-Np
	for gcvg-git@gmane.org; Mon, 03 Jul 2006 23:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750722AbWGCVbD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Jul 2006 17:31:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750745AbWGCVbD
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Jul 2006 17:31:03 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36557 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750722AbWGCVbB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Jul 2006 17:31:01 -0400
Received: (qmail 2472 invoked by uid 2001); 3 Jul 2006 23:30:59 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <20060703204803.28541.67315.stgit@machine.or.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23215>

Dear diary, on Mon, Jul 03, 2006 at 10:48:03PM CEST, I got a letter
where Petr Baudis <pasky@suse.cz> said that...
> This introduces a setup_git() function which is essentialy a (public)
> backend for setup_git_env() which lets anyone specify custom sources
> for the various paths instead of environment variables. Since the repositories
> may get switched on the fly, this also updates code that caches paths to
> invalidate them properly; I hope neither of those is a sweet spot.
> 
> It is used by Git.xs' xs__call_gate() to set up per-repository data
> for libgit's consumption. No code actually takes advantage of it yet
> but get_object() will in the next patches.
> 
> Signed-off-by: Petr Baudis <pasky@suse.cz>

To further clarify, this only invalidates the path cache and grafts
list, not alternates (it assumes the environment variable stays the
same for now; that is to be fixed when we extend Git.pm further)
and not pack list - we will automagically extend the list of packs when
we meet more repositories, but we will never remove old packs from the
list. (For no special reason other than this does no harm other than
possibly finding objects that should be missing, and the patch smells
bad enough enough as it is now. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Snow falling on Perl. White noise covering line noise.
Hides all the bugs too. -- J. Putnam
