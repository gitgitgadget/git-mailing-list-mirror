From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: refining .gitignores
Date: Thu, 15 Nov 2007 22:17:27 +0100
Message-ID: <20071115211727.GC3552@steel.home>
References: <804pfobgkp.fsf@tiny.isode.net> <20071114230258.GG3973@steel.home> <807ikj3fge.fsf@tiny.isode.net> <20071115192654.GA3552@steel.home> <80ejerdzjd.fsf@tiny.isode.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 22:18:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ism5x-0004eT-Ug
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 22:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761922AbXKOVRe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 16:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbXKOVRe
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 16:17:34 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:14616 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379AbXKOVRa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 16:17:30 -0500
Received: from tigra.home (Fcbc7.f.strato-dslnet.de [195.4.203.199])
	by post.webmailer.de (klopstock mo16) (RZmta 14.0)
	with ESMTP id L046e0jAFIZeLN ; Thu, 15 Nov 2007 22:17:28 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 16565277AE;
	Thu, 15 Nov 2007 22:17:28 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 005D856D22; Thu, 15 Nov 2007 22:17:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <80ejerdzjd.fsf@tiny.isode.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsKmZA=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65161>

Bruce Stephens, Thu, Nov 15, 2007 21:28:06 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> [...]
> 
> > .gitignore? Without "s"?
> 
> Yes, my mistake.  I added '*.c' to ".gitignore".
> 
> > Maybe your .c files are already added to index? Otherwise you have to
> > use the second form. It shows known-to-Git ignored files.
> 
> They are in the index.  What I want is a list of files which are known
> to git, which are matched by the default rules (in particular the
> .gitignore files).
> 
> So that should be this?
> 
>     git ls-files --exclude-per-directory=.gitignore -i

Yes, so it seems. The per-directory ignore-files don't work.
"--exclude-from=" (aka -X) still does.

> But that shows nothing at all, and it still shows nothing if I add a
> "builtin-add.c" as an argument to it (this file exists, and is in the
> index).
> 
> "git add builtin-add.c" fails, complaining (correctly) that the path
> is ignored by one of my .gitignore files.
> 
> We're obviously talking past one another somehow, or I have a broken
> build of git?

No, I honestly believed that Git-known files can be ignored. According
to Linus I must be wrong, but I have an excuse:

    $ mkdir aaa
    $ cd aaa
    $ git init
    Initialized empty Git repository in .git/
    $ uname >abc
    $ git add .
    $ ls > .gitignore
    $ git ls-files -X .gitignore
    $ git ls-files -X .gitignore -i
    abc
