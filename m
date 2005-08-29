From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: cogito/git usage question
Date: Mon, 29 Aug 2005 11:31:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508291106510.3243@g5.osdl.org>
References: <4312E74D.5020203@eircom.net> <Pine.LNX.4.58.0508290804570.3243@g5.osdl.org>
 <4313369B.5060508@eircom.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 29 20:35:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9oPe-0006vT-UJ
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 20:31:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVH2SbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 14:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbVH2SbQ
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 14:31:16 -0400
Received: from smtp.osdl.org ([65.172.181.4]:12254 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751286AbVH2SbP (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Aug 2005 14:31:15 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7TIVCjA013929
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Aug 2005 11:31:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7TIVBZ8017108;
	Mon, 29 Aug 2005 11:31:11 -0700
To: "Bryan O'Donoghue" <typedef@eircom.net>
In-Reply-To: <4313369B.5060508@eircom.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7917>



On Mon, 29 Aug 2005, Bryan O'Donoghue wrote:
> 
> If I'm understanding, I update to a given git repository, branch locally
> based on tags and then I can checkout a branch locally, to make that the
> active branch.

Exactly. This is the difference between a tag and a branch: a tag is an
"immobile" point in time, while branches are "heads of active development"
(there's a bit more detail to this: you _can_ change a tag, so it's not
like it's totally fixed in stone, but the point is that it's not a dynamic
entity - it's some fairly static thing that you've protected).

So you can't start new development off a tag directly: you need to create
a new branch that just starts off at the point that the tag points to.  
So if you really think of a branch as that "head of active development"
and tags as "static points in time" this all makes tons of sense.

Btw, you don't need to branch based on tags: you can branch based of _any_ 
kind of local reference. A tag is just a common one. But you can branch 
based on your current state too, ie a command line like

	git branch -b fixup HEAD^

means that you will create a "fixup" branch that starts not at a tag, but 
at the "parent of HEAD". In particular, let's say that you just committed 
something, and realized that you need to work on something else without 
the new thing disturbing you (you have a patch that applies in the same 
area, or whatever), something like the above works fine.

Or just use "gitk" to visually find a place, and when you decide to start 
a new branch somewhere, select that commit in gitk, and use the 
cut-and-paste facility to just paste the SHA1 directly into

	git branch -b working <any-random-point-sha1>

so it's not like the tags are important per se, they're just short-hand 
symbolc way-markers.

			Linus
