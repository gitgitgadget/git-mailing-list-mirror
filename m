From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why is git clone not checking out files?
Date: Tue, 30 Jan 2007 12:00:55 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701301153580.3611@woody.linux-foundation.org>
References: <17855.35058.967318.546726@lisa.zopyra.com> <epo1tn$9sl$1@sea.gmane.org>
 <17855.35845.922009.364704@lisa.zopyra.com> <20070130182237.GC26415@spearce.org>
 <17855.36470.309129.391271@lisa.zopyra.com>
 <Pine.LNX.4.64.0701301040200.3611@woody.linux-foundation.org>
 <17855.38543.761930.929267@lisa.zopyra.com>
 <Pine.LNX.4.64.0701301123300.3611@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Jan 30 21:02:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBzAB-0004CB-UV
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 21:01:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbXA3UBE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 15:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbXA3UBE
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 15:01:04 -0500
Received: from smtp.osdl.org ([65.172.181.24]:45823 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751171AbXA3UBD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 15:01:03 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0UK0u1m021412
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 30 Jan 2007 12:00:56 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0UK0tpH027368;
	Tue, 30 Jan 2007 12:00:55 -0800
In-Reply-To: <Pine.LNX.4.64.0701301123300.3611@woody.linux-foundation.org>
X-Spam-Status: No, hits=-0.448 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38200>



On Tue, 30 Jan 2007, Linus Torvalds wrote:
> 
> So either use
> 
> 	git --bare fetch git://source/public/project topic:master
> 
> (to tell git to fetch the remote 'topic' into the local 'master')

Side note: it's usually a good idea to have a 'master' branch, not so much 
because git itself really cares (it's just a default, after all, in a 
technical sense), but more because NOT having a master branch may then end 
up confusing other people who try to access the repository, and it doesn't 
have the normal default branch.

> OR, if you just prefer using the 'topic' name - which is certainly not 
> wrong at all, do
> 
> 	git --bare fetch git://source/public/project topic:topic
> 	git --bare symbolic-ref HEAD refs/heads/topic

And another note on this. I did do that with a special command, and yes, 
th is is what you should do in a script. HOWEVER, as with .git/config, I 
really think it's probably just easier to open your editor on the HEAD 
file directly, and just do that renaming by hand.

I _like_ people being able to just open files and mucking with them. It's 
considered extremely bad form in CVS (yeah, people _do_ actually open the 
CVS internal *,v files and muck with them, and it's a horrible horrible 
thing to do, but sometimes people have reason to do it), but in git, all 
the files you really *really* must not try to edit are compressed binary 
files and are protected by really strong checksums etc, so I don't think 
it's wrong to encourage people to edit files under .git/ by hand.

The things that can be edited are perfectly fine to edit. You can screw 
things up, of course, but on the other hand, I think people can really get 
a much better feeling for what git does if they end up understanding the 
files that git depends on.

So by all means, get down and dirty, and just fire up your editor on 
.git/HEAD when you want to create a repository that has some other default 
HEAD than 'master'.

		Linus
