From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sat, 30 Apr 2005 22:33:05 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504302228230.2296@ppc970.osdl.org>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org> <20050501014726.GA15220@nevyn.them.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 07:25:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DS6xK-0002n3-Sm
	for gcvg-git@gmane.org; Sun, 01 May 2005 07:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVEAFbP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 01:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVEAFbP
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 01:31:15 -0400
Received: from fire.osdl.org ([65.172.181.4]:3801 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261533AbVEAFbL (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 May 2005 01:31:11 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j415V6s4011551
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 30 Apr 2005 22:31:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j415V4jC001598;
	Sat, 30 Apr 2005 22:31:05 -0700
To: Daniel Jacobowitz <dan@debian.org>
In-Reply-To: <20050501014726.GA15220@nevyn.them.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 30 Apr 2005, Daniel Jacobowitz wrote:
> 
> It sounds good - but could you efficiently collect them before any diff
> output?  If you have something like this, it'll be easy to read:
> 
> Mode change: 644->755 foo.sh
> Mode change: 644->755 bar.sh
> 
> --- ChangeLog
> +++ ChangeLog

That may sound like a good idea, but it's horrid.

You'd only have to gather them back later anyway, since you can only apply 
the mode change _after_ you've done the diff. Why? The diff may be the 
thing that creates the file in the first place. Sp you should consider the 
mode changes as part of the "stream", not as something separate from the 
stream.

So I'd really much rather see it more as an "Index" line, which gets
prepended as part of the patch for that file (of course, either patch or
modeline can be missing).

		Linus
