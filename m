From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Cogito-0.12
Date: Thu, 7 Jul 2005 17:09:48 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507071706090.25104@g5.osdl.org>
References: <20050703234629.GF13848@pasky.ji.cz> <42CBC822.30701@didntduck.org>
  <20050707144501.GG19781@pasky.ji.cz>  <7vk6k2sfa4.fsf@assigned-by-dhcp.cox.net>
  <Pine.LNX.4.58.0507071158220.3293@g5.osdl.org>  <20050707221443.GB7151@pasky.ji.cz>
  <Pine.LNX.4.58.0507071549330.25104@g5.osdl.org> <12c511ca05070716526954edd@mail.gmail.com>
 <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 08 02:10:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqgRY-0008Jk-Bf
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 02:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbVGHAKD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jul 2005 20:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVGHAKC
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jul 2005 20:10:02 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22755 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262368AbVGHAKA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2005 20:10:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6809njA026136
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 7 Jul 2005 17:09:49 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6809mRB002334;
	Thu, 7 Jul 2005 17:09:48 -0700
To: Tony Luck <tony.luck@gmail.com>
In-Reply-To: <Pine.LNX.4.58.0507071658460.25104@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 7 Jul 2005, Linus Torvalds wrote:
> > 
> > cg-update from a local repo that contains packs is broken though :-(
> 
> Is this with cg-0.12? The most recent release should be happy with packs.

Ahh, I see it. It's because it uses "git-local-pull", and yes, 
git-local-pull does the old filename assumption. Right?

Ho humm.. That's a bug in local-pull.c, although I'm not sure how to fix
it best. One option is to just not use it (as in "use git-fetch-pack
instead"), and another is to use GIT_ALTERNATE_OBJECT_DIRECTORIES and just
pick up the files that way. Yet another one is to actually copy over (or
link) the pack-file, but that's likely the least preferable one.

The _simplest_ fix is to use git-fetch-pack. It doesn't give you the 
convenient hard-linking, though.

		Linus
