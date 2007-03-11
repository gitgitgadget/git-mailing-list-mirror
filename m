From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git merge and merge message
Date: Sun, 11 Mar 2007 14:05:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703111348230.9690@woody.linux-foundation.org>
References: <200703111505.l2BF54Kq006625@localhost.localdomain>
 <20070311160424.GA629@fieldses.org> <200703111815.l2BIFHbq010315@localhost.localdomain>
 <Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org>
 <45F46713.6030702@qumranet.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Xavier Maillard <zedek@gnu.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 22:06:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQVEz-0006Cg-5D
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 22:06:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932322AbXCKVGB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 17:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbXCKVGB
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 17:06:01 -0400
Received: from smtp.osdl.org ([65.172.181.24]:58271 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932322AbXCKVF7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 17:05:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2BL5qo4011846
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 11 Mar 2007 14:05:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2BL5pB6019677;
	Sun, 11 Mar 2007 13:05:51 -0800
In-Reply-To: <45F46713.6030702@qumranet.com>
X-Spam-Status: No, hits=-0.487 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41983>



On Sun, 11 Mar 2007, Avi Kivity wrote:
> 
> Actually there's at least one tree where this should be activated -- yours.
> If you perform a fast-forward merge, there's no record of the merge, no record
> of which tree was pulled, and no sign-off from you.  The commits just appear
> there.  It partially defeats the sign-off system.

Well, the thing is, I explicitly don't *want* the merges to show up if 
it's a fast-forward. 

Maybe it's just me, and maybe I'm odd, but I have for several years now 
really thought of Linux development as being this collection of 
maintainers, rather than being a "Linus at the top" kind of situation. 

So yes, obviously I do end up getting a lot of merges attributed to me, 
simply because *in practice* my tree is generally the top of the food 
chain, but I think that's a practical issue because people generally want 
to avoid confusion by having a known maintainer, and it shouldn't be a 
design thing.

So I dislike the "hierarchical model" so much that even though it's true, 
I don't want to make it even _more_ true. I'd rather make it less true, 
and at least personally think of Linux development more as a "network of 
developers where some people are just more connected than others". I'm not 
saying that people are equal (because they aren't), but at the same time I 
do think that it should be perfectly fine if submaintainers pull from each 
other if they ever need to - ie pulling should work side-ways and not just 
up the "command chain".

So I think the hierarchical thing is largely a social thing, but not one 
that is necessarily the only way of doing things. 

And I believe that it might actually be *better* if we were to have some 
more merging side-ways. Yes, I've been rather involved in kernel 
development for fifteen years, and I don't really see myself stopping it 
either, but at the same time, I think that in the really long run, it 
would be a really interesting experiment to try to run things as a more 
"amorphous" development group of people that just trust each other, than a 
very hierarchical one.

And I really think tools matter, and that it's a much more healthy 
environment if you *don't* have the situation where people mark their 
merges in a hierarchy. If you have people pulling from each other, rather 
than a "central repo" model, it really *is* wrong to say "Merge feature 
Xyz", because when you then later pull the other way, now that merge 
message makes no sense any more.

> This feature would be good for top-level trees and for major subsystem trees
> IMO.

I realize that it can be useful, and I obviously use the "merge.summary" 
config variable that does make it a non-symmetric situation anyway, and 
maybe I'm just fighting windmills. It's just that I actually dislike the 
central repository model so much that I dislike it even when the central 
repository is *me*.

The Linux kernel is actually a bit strange in this way. I've always 
encouraged people to have their own repositories, in ways that most other 
projects do not. So I'm really happy with things like distributions 
maintaining their own versions, and with developers having their own 
trees, and keeping me honest that way. The -mm tree, the -aa tree, the -ck 
tree etc.

I think it's a sign o fa healthy community when there is competition in 
the maintainer space. Now, people don't always agree with how I do things, 
and yeah, every few years there is some flame war about how I suck ("Linus 
doesn't scale" kind of thing), but I think that to keep me reasonably 
honest, people always need to have alternatives. 

So when I really screw up, or become just _too_ impolite and offend too 
many people, I hope that there will be some other person maintaining his 
own tree, and people will just flock to that one instead. That's how 
things *should* work. And that's why I don't want to have too strict a 
hierarchy, or the tools being geared towards a central model.

So I realize that in practice, when things work reasonably well, you 
*will* have a central repository. At the same time, I want the tools and 
the infrastructure to support the case when somebody says "Linus does a 
horrible job, and I can do better".

So I'll fight tooth and nail to show that I'm better and smarter than any 
other kernel maintainer, of course, but I'll do that because I *like* the 
competition, not because I make the tools favor me, thank you very much.

			Linus
