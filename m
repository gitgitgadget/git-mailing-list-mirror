From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 1/2] Introduce git-run-with-user-path helper program.
Date: Wed, 18 May 2005 17:34:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505181731450.18337@ppc970.osdl.org>
References: <7voebbpuxs.fsf@assigned-by-dhcp.cox.net> <20050517190355.GA7136@pasky.ji.cz>
 <7vk6lxfybc.fsf@assigned-by-dhcp.cox.net> <20050517203500.GH7136@pasky.ji.cz>
 <7v4qd1tuud.fsf@assigned-by-dhcp.cox.net> <20050517213752.GO7136@pasky.ji.cz>
 <7vzmutqz5f.fsf@assigned-by-dhcp.cox.net> <20050518213309.GD10358@pasky.ji.cz>
 <7vekc4nom5.fsf@assigned-by-dhcp.cox.net> <20050518232408.GA18281@pasky.ji.cz>
 <7v64xgnl55.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 02:32:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYYxm-0006W8-Nr
	for gcvg-git@gmane.org; Thu, 19 May 2005 02:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262426AbVESAdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 20:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVESAdL
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 20:33:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:13764 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262427AbVESAcw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 20:32:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4J0WhU3025511
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 May 2005 17:32:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4J0WgLX027986;
	Wed, 18 May 2005 17:32:43 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64xgnl55.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 18 May 2005, Junio C Hamano wrote:
> 
> PB> Yes. My point is that sometimes the Cogito commands have
> PB> directory-specific functionality even when called without any arguments.
> 
> PB> $ pwd
> PB> /usr/src/linux
> PB> $ date >>README
> PB> $ cd fs
> PB> $ date >>Makefile
> PB> $ cg-commit
> 
> PB> will commit only the fs/Makefile change.
> 
> Ah, thanks.  That what I missed.

Note that if git-run-with-user-path just has some way to tell what the
relative pathname of the original program was (say $DEF_SUBDIRECTORY),
this could still fairly easily be handled: having the cg-Xcommit program
say "if there are no arguments, we default to $DEF_SUBDIRECTORY" rather
than "with no arguments, default to '.'".

I don't personally much care, since this is all porcelain, but basically I
don't think these things are in any way mutually incompatible, and I do
believe that git-run-with-user-path _could_ be a good way to abstract out
the "where the heck in the tree am I?" issues.

		Linus
