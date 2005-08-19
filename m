From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Teach applymbox to keep the Subject: line.
Date: Thu, 18 Aug 2005 18:04:53 -0700
Message-ID: <7vacjeenyi.fsf@assigned-by-dhcp.cox.net>
References: <20050816214707.6842.qmail@web26302.mail.ukl.yahoo.com>
	<7vek8t7bva.fsf@assigned-by-dhcp.cox.net>
	<7vk6il2jz8.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508170830050.3553@g5.osdl.org>
	<20050818172646.GA18459@mars.ravnborg.org>
	<Pine.LNX.4.58.0508181257320.3412@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 19 03:05:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5vJb-0002ji-ID
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 03:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbVHSBE4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 21:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964781AbVHSBE4
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 21:04:56 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:43664 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964780AbVHSBE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 21:04:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819010454.OPFL15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 Aug 2005 21:04:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> Well, Junio has been talking about adding commit hooks. I don't think
> that's been done.

No, notyet.  But tonight.

> The only question is what the hook/trigger should look like. just put
> something like
>
> 	[ -x .git/hooks/applypatch-hook ] &&
> 	     .git/hooks/applypatch-hook "$tree" "$PATCHFILE" || exit
>
> at the line before that "git-apply" perhaps? Then, you could install your 
> own applypatch hook which looks at the message or the patch?

Sounds sensible.  The hook would probably want a handy access to
the commit object as well to catch:

     - the author name may be spelled wrong or has funky
       B-encodings still left.

     - some people might want to even run spellchecker on the
       commit message.

     - lack of S-O-B line.
