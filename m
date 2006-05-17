From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git 1.3.2 on Solaris
Date: Wed, 17 May 2006 07:33:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605170728520.10823@g5.osdl.org>
References: <4973.1147836384@lotus.CS.Berkeley.EDU> 
 <Pine.LNX.4.64.0605162047380.10823@g5.osdl.org>
 <f3d7535d0605170105j2a6942cfh5a5a8a0d6153046f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 17 16:34:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FgN5y-00081d-An
	for gcvg-git@gmane.org; Wed, 17 May 2006 16:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571AbWEQOdr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 May 2006 10:33:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932576AbWEQOdr
	(ORCPT <rfc822;git-outgoing>); Wed, 17 May 2006 10:33:47 -0400
Received: from smtp.osdl.org ([65.172.181.4]:21134 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932571AbWEQOdq (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 May 2006 10:33:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4HEXetH024028
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 17 May 2006 07:33:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4HEXefX015118;
	Wed, 17 May 2006 07:33:40 -0700
To: Stefan Pfetzing <stefan.pfetzing@gmail.com>
In-Reply-To: <f3d7535d0605170105j2a6942cfh5a5a8a0d6153046f@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.134 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20202>



On Wed, 17 May 2006, Stefan Pfetzing wrote:
> 
> So I'd prefer a solution where one could set one flag for the Makefile of git,
> and git would check for the g prefix, create somewhere a directory with
> symlinks to the "real" gnu binaries and put it into $PATH upon startup of
> every git c-program or shellscript.

So let me just quote the thing you quoted but apparently didn't read:

> > If you use the git wrapper, for example, you can already depend on the
> > fact that it will prepend the git installation directory to the path, so
> > while the GNU tools might not _normally_ be on the path, if you put them
> > in the same directory as your git install, you'll automatically get them
> > as long as you use the "git cmd" format (rather than the "git-cmd"
> > format).

There already _is_ such a directory. It's your "prefix=" directory plus 
"bin".

So what you can do is make sure you compile with

	make prefix=/my/git/installation/prefix

and then install the GNU tools in /my/git/installation/prefix/bin, and 
you're all set.

At most you might have to make some of the tests use "git xyzzy" instead 
of "git-xyzzy", and run "make install" before "make test". 

It wouldn't be wonderful, but hey, I've given alternatives (like using the 
GNU tools by default, or helping make git more portable in the first 
place). So it's a hack. 

		Linus
