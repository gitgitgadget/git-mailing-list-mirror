From: Andrew Morton <akpm@osdl.org>
Subject: Re: : Networking
Date: Tue, 26 Apr 2005 12:51:41 -0700
Message-ID: <20050426125141.6ec38d31.akpm@osdl.org>
References: <20050425214326.512b006e.davem@davemloft.net>
	<20050426005725.6bfe6135.akpm@osdl.org>
	<20050426183350.GB13224@pasky.ji.cz>
	<20050426115609.0481401b.akpm@osdl.org>
	<Pine.LNX.4.58.0504261209470.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: pasky@ucw.cz, davem@davemloft.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 21:48:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQW1S-0004Jp-0K
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 21:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261757AbVDZTwU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 15:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVDZTwU
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 15:52:20 -0400
Received: from fire.osdl.org ([65.172.181.4]:42151 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261757AbVDZTwR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 15:52:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3QJq7s4018756
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 26 Apr 2005 12:52:08 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j3QJq2tE004029;
	Tue, 26 Apr 2005 12:52:04 -0700
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504261209470.18901@ppc970.osdl.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Tue, 26 Apr 2005, Andrew Morton wrote:
> > 
> > I don't know if it'll be successful continually merging all those trees
> > together.  The way I did this with bk was to have a separate repo for each
> > tree, but I don't think I'll want 30-40 separate git trees.
> 
> You really don't. With git, the only thing you need is one object store,
> and some way to _track_ those 30-40 separate git trees (and "track" really
> means "remember a single SHA1 name for their top-of-tree").

Petr's wrappers do all that head tracking OK (which is why I'm using a
combo of those and of lower-level gittiness).  They do handy remote repo
tracking too.

> Then you can merge any combination of the 40 in the same tree. 
> 
> You'll get confused easily, but if you do this all with tools, it 
> shouldn't be too bad.
> 
> > So hm.  I guess git did what it was supposed to do here, and that a `git
> > merge' would have removed the common patch.  But if I take the approach of
> > merging all those subsystem trees I do wonder if things will come
> > unstuck...
> 
> Well, git isn't as good at merging as BK is, and your usage sure as hell
> would be a horrible worst-case example, but it might actually work fine.  
> Git merges are _cheap_ (with a capital C, and probably H as well) when
> they work out, and quite frankly, so far they have always worked out for
> me.
> 
> But yeah, you'd be doing some pretty aggressive merging, using a tool that 
> is two weeks old. It might work. I'd be interested to know ;)

Hm.  For now I might try what I have plus Jan's fancy interdiff command to
remove duped patches.  We'll see.  I obtained a copy of Tony's ia64 diff
quite happily - it didn't have any duplicates.

(It's fairly common for two subsystem maintainers to apply the same patch. 
With bk I was resolving that by just smashing the patches on top of each
other, ignoring the rejects and refreshing the topmost patch.  That
approach actually resolved this linus-vs-davem dupe as well.  But the duped
patch was so damn BIG that it threw me.  And I wasn't feeling gitty enough
to go hunting about looking for the particular patch(es) which caused the
problem)
