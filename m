From: Petr Baudis <pasky@suse.cz>
Subject: Re: Fwd: Re: git checkout -f branch doesn't remove extra files
Date: Sat, 13 Aug 2005 14:33:11 +0200
Message-ID: <20050813123311.GD5608@pasky.ji.cz>
References: <20050813041737.GB25236@redhat.com> <Pine.LNX.4.58.0508122151120.19049@g5.osdl.org> <20050813110050.GA5608@pasky.ji.cz> <20050813161053.29593972.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 14:34:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3vCl-0000jT-4F
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 14:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbVHMMdR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Aug 2005 08:33:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932159AbVHMMdR
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Aug 2005 08:33:17 -0400
Received: from w241.dkm.cz ([62.24.88.241]:36105 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S1750819AbVHMMdR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 13 Aug 2005 08:33:17 -0400
Received: (qmail 12254 invoked by uid 2001); 13 Aug 2005 12:33:11 -0000
To: Sergey Vlasov <vsu@altlinux.ru>
Content-Disposition: inline
In-Reply-To: <20050813161053.29593972.vsu@altlinux.ru>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, Aug 13, 2005 at 02:10:53PM CEST, I got a letter
where Sergey Vlasov <vsu@altlinux.ru> told me that...
> However, cg-export is buggy - if you use the second argument
> (cg-export DESTFILE TREE_ID), the resulting tar file is different
> from what git-tar-tree produces for the same TREE_ID (unless that
> TREE_ID actually points to a tree - but in practice a commit or even
> tag ID is typically used).
> 
> The problem is in this line:
> 
> id=$(tree-id "$2")
> 
> This converts the passed commit or tag to the underlying tree, which
> is then passed to git-tar-tree.  However, git-tar-tree can follow
> such links itself, and, what's more important, it actually uses some
> information from the passed commit (it writes the commit ID to the
> tar file as an extended header, and sets timestamp of all archive
> members to the time of the commit).  Therefore reducing the ID
> passed to git-tar-tree to a plain tree ID is wrong - if a commit ID
> is available, it should be used.

Aha! Good catch, fixed, thanks.

BTW, I also changed cg-export usage to be more consistent and flexible,
by changing it from

	cg-export DESTFILE [TREE_ID]

to

	cg-export [-r TREE_ID] DESTFILE

since I think not many people are using cg-export anyway and much less
of them passing it TREE_ID explicitly.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
