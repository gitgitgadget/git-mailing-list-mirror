From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cloning speed comparison
Date: Fri, 12 Aug 2005 19:12:26 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508121908180.3295@g5.osdl.org>
References: <20050813015402.GC20812@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 13 04:14:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3lWZ-0000pR-Te
	for gcvg-git@gmane.org; Sat, 13 Aug 2005 04:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVHMCMo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 22:12:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932110AbVHMCMo
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 22:12:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:61064 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932107AbVHMCMn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 12 Aug 2005 22:12:43 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7D2CYjA029859
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 12 Aug 2005 19:12:35 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7D2CQFO024387;
	Fri, 12 Aug 2005 19:12:29 -0700
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050813015402.GC20812@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 13 Aug 2005, Petr Baudis wrote:
> 
>   Anyway, clone-pack is a clear winner for networks (but someone should
> re-check that, especially compared to rsync, wrt. server-side file
> caching); really cool fast, but not very practical for anonymous access.

git-daemon is for the anonymous access case, either started from inetd 
(or any other external "listen to port, exec service" thing), or with the 
built-in listening stuff.

It uses exactly the same protocol and logic as the regular ssh clone-pack 
thing, except it doesn't authenticate the remote end: it only checks that 
the local end is accepting anonymous pulls by checking whether there is a 
"git-daemon-export-ok" file in the git directory.

In my tests, the git daemon was noticeably faster than ssh, if only 
because the authentication actually tends to be a big part of the overhead 
in small pulls.

[ Hey. There's a deer outside my window eating our roses again. Cute ]

			Linus
