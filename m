From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: refining .gitignores
Date: Thu, 15 Nov 2007 20:26:54 +0100
Message-ID: <20071115192654.GA3552@steel.home>
References: <804pfobgkp.fsf@tiny.isode.net> <20071114230258.GG3973@steel.home> <807ikj3fge.fsf@tiny.isode.net>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruce Stephens <bruce.stephens@isode.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 20:27:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IskMt-0007kC-9j
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 20:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762145AbXKOT06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 14:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761556AbXKOT05
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 14:26:57 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:60746 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758134AbXKOT04 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 14:26:56 -0500
Received: from tigra.home (Faed1.f.strato-dslnet.de [195.4.174.209])
	by post.webmailer.de (fruni mo37) (RZmta 14.0)
	with ESMTP id 4021f5jAFHcKOL ; Thu, 15 Nov 2007 20:26:55 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id D631B277AE;
	Thu, 15 Nov 2007 20:26:54 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 2987156D22; Thu, 15 Nov 2007 20:26:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <807ikj3fge.fsf@tiny.isode.net>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3upF1w=
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65152>

Bruce Stephens, Thu, Nov 15, 2007 12:39:45 +0100:
> Alex Riesen <raa.lkml@gmail.com> writes:
> > Bruce Stephens, Wed, Nov 14, 2007 23:36:06 +0100:
> >> How do I get a list of files (in HEAD, say) that would be ignored by
> >> the .gitignore files (and the other usual settings)?
> >> 
> >> It feels like something like this ought to work:
> >> 
> >>      git ls-files -z | xargs -0 git ls-files --ignored
> >> 
> >> But listing its arguments that are ignored by .gitignore (etc.)
> >> doesn't seem to be what "git ls-files --ignored" does.  Or at least,
> >> not quite as straightforwardly as that.
> >
> > git ls-files --exclude-per-directory=.gitignore -X .git/info/exclude -i -o
> 
> That doesn't seem to work.
> 
> For example, if I add '*.c' to .gitignores in git.git, I can't seem to
> get that command to display any .c files.

.gitignore? Without "s"?
Maybe your .c files are already added to index? Otherwise you have to
use the second form. It shows known-to-Git ignored files.

> Run on its own, it displays lots of files, but no .c files.  Run with
> an argument (such as builtin-add.c), it displays nothing.

because the *are* in the index. "-o" means "others", as in "not Git".

> >> The motivation is (obviously) that I fear some of the .gitignore
> >> patterns are too broad, and a reasonable check is that none of the
> >> files that are already committed would be caught by the patterns.
> >
> > git ls-files --exclude-per-directory=.gitignore -X .git/info/exclude -i
> 
> That also doesn't seem to do quite what I want, and probably in the
> same way. ...

It shows ignored files from the "known-to-Git" fileset.
