From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] C implementation of the 'git' program.
Date: Thu, 10 Nov 2005 11:41:10 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511101133550.4627@g5.osdl.org>
References: <20051110182631.3C5615BF90@nox.op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 10 20:42:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaIIR-0001It-Lm
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 20:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199AbVKJTlQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 14:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751200AbVKJTlQ
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 14:41:16 -0500
Received: from smtp.osdl.org ([65.172.181.4]:1241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751199AbVKJTlQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 14:41:16 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAAJfDnO024973
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 10 Nov 2005 11:41:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAAJfAdl002082;
	Thu, 10 Nov 2005 11:41:12 -0800
To: Andreas Ericsson <exon@op5.se>
In-Reply-To: <20051110182631.3C5615BF90@nox.op5.se>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11511>



On Thu, 10 Nov 2005, Andreas Ericsson wrote:
> 
> This patch provides a C implementation of the 'git' program and introduces
> support for putting the git-* commands in their own directory. It also
> saves some time on executing git-* commands in a tight loop and it prints
> the currently available git commands in a nicely formatted list.

I think this makes sense - "git" may be a very simple program even in 
shell, but hey, it's simple even in C, and while performance may be a 
secondary issue, when it is in C we will have the option to extend in more 
effectively later.

For example, we might implement some things directly in the "git" wrapper.

And the performance difference does seem to be quite noticeable too..

> The location of the GIT_LIB can be obtained by running
> 
> 	git --lib

I think this might be a bit ambiguous. When I see "GIT_LIB", to me it 
implies traditional libraries (ie a "libgit.a" kind of thing), not the 
kind of "git executable plugin" directory.

So I'd suggest renaming "--lib" and "GIT_LIB" to be more of a "--libexec" 
kind of flavor, if only to avoid that confusion. Even if the actual 
directory ends up being /usr/lib/git-<version>/ as in my original 
suggestion, I think it's good to make it clear that it's not just some 
kind of "link type" library, but more of a combination of libraries and 
plugins and executables.

But maybe that's just me?

		Linus
