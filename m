From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cogito - how do I ???
Date: Sat, 21 May 2005 16:41:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505211635440.2206@ppc970.osdl.org>
References: <20050521214700.GA18676@mars.ravnborg.org>
 <2765.10.10.10.24.1116713164.squirrel@linux1>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Ravnborg <sam@ravnborg.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 01:39:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZdYN-0005XY-Ho
	for gcvg-git@gmane.org; Sun, 22 May 2005 01:38:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbVEUXjo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 May 2005 19:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261692AbVEUXjo
	(ORCPT <rfc822;git-outgoing>); Sat, 21 May 2005 19:39:44 -0400
Received: from fire.osdl.org ([65.172.181.4]:6877 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261697AbVEUXj0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 May 2005 19:39:26 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4LNdJjA029123
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 21 May 2005 16:39:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4LNdIKp018833;
	Sat, 21 May 2005 16:39:19 -0700
To: Sean <seanlkml@sympatico.ca>
In-Reply-To: <2765.10.10.10.24.1116713164.squirrel@linux1>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 21 May 2005, Sean wrote:

> On Sat, May 21, 2005 5:47 pm, Sam Ravnborg said:
> > Hi all.
> >
> > While trying to get up to speed on cogito/git I stumbled across
> > a few things that I at least did not find available in cogito.
> >
> > 1) Something similar to "bk changes -R". I use this to see what has
> > happened upstream - to see if I really want to merge stuff.
> 
> Not sure what bk did here, but you can do something like:
> 
> cg-pull origin
> cg-log -c -r origin

In the raw git interfaces, you'd basically have to do the same thing that
"git-pull-script" does, except that _instead_ of calling the
git-resolve-script thing, you'd do

	git-rev-tree MERGE_HEAD ^HEAD | git-diff-tree -v -m -s --stdin

to show what is in the downloaded MERGE_HEAD but not in HEAD.

> > 2) Export of individual patches. "bk export -tpatch -r1.2345"
> > I have nu public git repository yet so I have to feed changes as
> > plain patches. Browsing cg-* I did not find the command to do this.
> 
> cg-diff -p -r SHA1

And again, without the porcelain this is:

	git-diff-tree -v -p <name>

(Basically, you can do _anything_ with "git-diff-tree". For example, you 
want "cg log"? Do

	git-rev-list HEAD | git-diff-tree --stdin -v -m -s

which is basically what "git-whatchanged" does).

		Linus
