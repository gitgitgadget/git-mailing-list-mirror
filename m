From: Petr Baudis <pasky@suse.cz>
Subject: Re: How to clone-pack the HEAD?
Date: Thu, 15 Dec 2005 02:32:01 +0100
Message-ID: <20051215013201.GD10680@pasky.or.cz>
References: <20051215004440.GM22159@pasky.or.cz> <7vfyovtaub.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 02:34:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emhya-0002KR-4i
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 02:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628AbVLOBcE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Dec 2005 20:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932646AbVLOBcE
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Dec 2005 20:32:04 -0500
Received: from w241.dkm.cz ([62.24.88.241]:60885 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932628AbVLOBcD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Dec 2005 20:32:03 -0500
Received: (qmail 16106 invoked by uid 2001); 15 Dec 2005 02:32:01 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyovtaub.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13670>

Dear diary, on Thu, Dec 15, 2005 at 02:20:28AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Petr Baudis <pasky@ucw.cz> writes:
> 
> >   (i) git-clone-pack url HEAD doesn't work
> 
> "clone-pack url branchname" might work, but the thing is, nobody
> uses clone-pack with explicit heads arguments so if HEAD does
> not work I am not surprised at all.
..snip..
> I think extending git-fetch-pack to optionally keep things
> packed would be somewhat painful but the right approach.  Less
> painful and readily doable would be to run clone-pack as is, and
> reorganize the result of "copy of the remote" yourself.  That
> would be a straightforward thing to do if you are using it for
> the initial cloning.

Except that I cannot do the guessing git-clone-pack does (without
fetching all the branches) - so I guess I'll make a patch tomorrow which
fixes git-clone-pack ... HEAD (probably by checking in write_one_ref()
whether it is looking at a symlink and following it first if that's the
case) and then in Cogito do

	git-symbolic-ref HEAD refs/heads/origin

before git-clone-pack (and repoint HEAD back after it's over). That
should do exactly what I need it to, I think.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
