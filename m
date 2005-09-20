From: Petr Baudis <pasky@suse.cz>
Subject: Re: Joining cg-*-id
Date: Tue, 20 Sep 2005 15:57:36 +0200
Message-ID: <20050920135735.GC1884@pasky.or.cz>
References: <1127166049.26772.26.camel@dv> <20050919215608.GA13845@pasky.or.cz> <Pine.LNX.4.58.0509191505470.2553@g5.osdl.org> <20050919225422.GG18320@pasky.or.cz> <Pine.LNX.4.58.0509191746130.2553@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, Pavel Roskin <proski@gnu.org>,
	fonseca@diku.dk, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 20 15:58:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHidf-00083Y-7f
	for gcvg-git@gmane.org; Tue, 20 Sep 2005 15:58:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVITN5n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Sep 2005 09:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVITN5n
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Sep 2005 09:57:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:7903 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932267AbVITN5m (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Sep 2005 09:57:42 -0400
Received: (qmail 7916 invoked by uid 2001); 20 Sep 2005 15:57:37 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0509191746130.2553@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8996>

Dear diary, on Tue, Sep 20, 2005 at 02:50:21AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Tue, 20 Sep 2005, Petr Baudis wrote:
> > But that semantics sucks, and I wouldn't mind changing it at all. I
> > think taking the previous commit works for everything but the start of
> > cg-log range, and it is how CVS behaves.
> 
> The thing is, it may have sensible behaviour for CVS, but only because CVS 
> doesn't have any notion of concurrent development (even a branch isn't 
> concurrent - it's totally separate, and when you merge it, it becomes just 
> one big diff at the time of the merge).
> 
> So I'd love to have
> 
> 	git diff yesterday..
> 
> but the fact is, there's no sensible semantics for it. _which_ yesterday? 
> There might be five different points that are "close to 24 hours ago", 
> along five different paths backwards in the history.

A well-defined meaning for this from Cogito standpoint would be "the
last commit on our HEAD before the date and all commits committed and
merged to the HEAD". In Cogito, you don't merge two branches _together_,
you merge one branch _into_ another (represented by the parents order),
so this would be sensible.

But we would have to sort the log in merge order for this to be possible
(and probably teach git-rev-list about it anyway).  I would absolutely
*love* to have cg-log in merge order instead of date order - longer I
see it the more I believe that it's evil and you should really want
merge order instead. The trouble is that cg-log would be no longer
incremental and would have to load the whole history first, a no-go for
any measurably long history.

By the way, did I understand it right that the only difference between
the results of merge ordering and topo ordering is the order commits
with regard to the order of parents?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
