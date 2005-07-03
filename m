From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Cogito: Use git-rev-parse instead of cg-Xnormid.
Date: Sun, 3 Jul 2005 17:41:27 +0200
Message-ID: <20050703154127.GA31848@pasky.ji.cz>
References: <42C77ECE.2080903@didntduck.org> <20050703065920.GA11765@pasky.ji.cz> <42C7D925.2070007@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 03 17:42:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dp6bK-0000mS-JS
	for gcvg-git@gmane.org; Sun, 03 Jul 2005 17:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVGCPlg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jul 2005 11:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVGCPlg
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jul 2005 11:41:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2968 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261455AbVGCPld (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Jul 2005 11:41:33 -0400
Received: (qmail 5023 invoked by uid 2001); 3 Jul 2005 15:41:27 -0000
To: Brian Gerst <bgerst@didntduck.org>
Content-Disposition: inline
In-Reply-To: <42C7D925.2070007@didntduck.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, Jul 03, 2005 at 02:25:09PM CEST, I got a letter
where Brian Gerst <bgerst@didntduck.org> told me that...
> Petr Baudis wrote:
> >Dear diary, on Sun, Jul 03, 2005 at 07:59:42AM CEST, I got a letter
> >where Brian Gerst <bgerst@didntduck.org> told me that...
> >
> >>Use git-rev-parse instead of cg-Xnormid.  This allows Cogito to work 
> >>properly with packed objects.
> >>
> >>Signed off by: Brian Gerst <bgerst@didntduck.org>
> >
> >
> >But git-rev-parse sucks. It won't detect invalid IDs (--revs-only?), and
> >does not support short object IDs (that's a must, it's tremendously
> >useful). You need to add that for it to be useful first.
> 
> cg-Xnormid is terminally broken in the presence of packed files, since 
> it cannot look into them to find objects.

That's right. Well, for everything but the short id matching we could
just check the ID validity by git-rev-parse instead of peeking into
the object store - I just did that. If I'm not missing anything, that
will just make the short id matching for packed objects impossible, but
works fine otherwise...?

> Moreover, many uses of commit-id in the scripts can be eliminated because
> the underlying git commands can already understand tags directly, and will
> check for invalid ids then.

I feel reserved about that. I want to have custom error handling here to
give the user less confusing output (no core GIT command name, since
that confuses users), and as I said, Cogito's rev resolving is more
powerful than Core Git's.

> The only thing missing is the short id matching.

Yes, but as I said, I think it's very important to have. BTW, another
cool thing cg-Xnormid does and git-rev-parse does not: time specifiers.
E.g. you could specify revisions as "2 days ago" or so, very useful for
cg-log, cg-diff and such.

Thanks for pointing this out, BTW.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
