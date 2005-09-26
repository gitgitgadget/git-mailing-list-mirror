From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cogito: cg-clone doesn't like packed tag objects
Date: Tue, 27 Sep 2005 00:29:45 +0200
Message-ID: <20050926222944.GG26340@pasky.or.cz>
References: <43348086.2040006@zytor.com> <20050924011833.GJ10255@pasky.or.cz> <20050926212536.GF26340@pasky.or.cz> <7virwna2oi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 27 00:31:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EK1U4-0000jx-Ok
	for gcvg-git@gmane.org; Tue, 27 Sep 2005 00:30:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932493AbVIZW3r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 18:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVIZW3r
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 18:29:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:17874 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932515AbVIZW3q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2005 18:29:46 -0400
Received: (qmail 17845 invoked by uid 2001); 27 Sep 2005 00:29:45 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7virwna2oi.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9349>

Dear diary, on Tue, Sep 27, 2005 at 12:23:41AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Petr Baudis <pasky@suse.cz> writes:
> > .... But fetching the tags will cause all the commits
> > connected to the tags getting slurped too, and we didn't want that.
> 
> What is the objective here?  If you fetch a tag without the
> object being tagged (or commit without its tree), you will end
> up with smaller object database but you would get yelled at by
> git-fsck-objects.

Yes - so you can't save the tag objects either, but then you'll re-slurp
them again and again, which is kind of silly. Alternatively, you could
actually make git-fsck-object silent about the case when an unreachable
(not referenced in refs/) tag object references a non-existing object -
perhaps unless --strict is passed to it. If you think the rest of my
logic is ok, I think this change to facilitate this "tags caching" is
not unreasonable.

The alternative solution would be to have the tags cache with the tag
objects separate of the main object database, but that'd be very dirty.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
