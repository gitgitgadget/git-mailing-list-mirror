From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cogito - how do I ???
Date: Mon, 23 May 2005 07:35:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505230731430.2307@ppc970.osdl.org>
References: <20050521214700.GA18676@mars.ravnborg.org>
 <2765.10.10.10.24.1116713164.squirrel@linux1> <Pine.LNX.4.58.0505211635440.2206@ppc970.osdl.org>
 <20050523071919.GG23388@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>, Sam Ravnborg <sam@ravnborg.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 23 16:36:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DaE1N-0005d0-9S
	for gcvg-git@gmane.org; Mon, 23 May 2005 16:35:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVEWOg2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 May 2005 10:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261737AbVEWOg1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 May 2005 10:36:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:57783 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261733AbVEWOgS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 May 2005 10:36:18 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4NEXijA021276
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 23 May 2005 07:33:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4NEXfKH032630;
	Mon, 23 May 2005 07:33:43 -0700
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050523071919.GG23388@cip.informatik.uni-erlangen.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 23 May 2005, Thomas Glanzmann wrote:
> 
> > 	git-rev-tree MERGE_HEAD ^HEAD | git-diff-tree -v -m -s --stdin
> 
> This doesn't work for me:

Yeah, I'm an idiot.

> Bit this does:
> 
> (faui00u) [~/work/git/git] git-rev-tree 2cb45e95438c113871fbbea5b4f629f9463034e7 ^09d74b3b5ac634495e17b92b2b785fa996ffce97 | awk '{print $2'} | sed 's#:.*##' | git-diff-tree -v -m -s --stdin
> 
> was that a typo or is git-diff-tree supposed to handle the output of
> git-rev-tree as well and it is a bug?

It was me just forgetting about the time thing in rev-tree, forcing you to
have a second phase there (I usually use just "cut -d' ' -f2" - the input
_can_ have the ":n" flag thing that rev-tree outputs, and git-diff-tree
will just ignore it).

I actually suspect that whole time thing was a mistake, it seemed sensible 
back when we didn't have any other way of ordering the changesets well, 
but it's really a bad ordering anyway to do it by time (ie add a "sort 
-rn" in there), and we can (and probably should) order rev-tree output 
with some topological sort based on the commit tree.

		Linus
