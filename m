From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Tags
Date: Sat, 2 Jul 2005 14:39:23 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507021432370.8247@g5.osdl.org>
References: <Pine.LNX.4.21.0506301403300.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506301302410.14331@ppc970.osdl.org> <42C454B2.6090307@zytor.com>
 <Pine.LNX.4.58.0506301344070.14331@ppc970.osdl.org> <42C462CD.9010909@zytor.com>
 <Pine.LNX.4.58.0506301432500.14331@ppc970.osdl.org> <42C46B86.8070006@zytor.com>
 <m13bqyk4uh.fsf_-_@ebiederm.dsl.xmission.com> <42C5714A.1020203@zytor.com>
 <m1u0jef8z9.fsf@ebiederm.dsl.xmission.com> <42C5C75F.4040100@zytor.com>
 <m1ll4qf7mg.fsf@ebiederm.dsl.xmission.com> <42C5DA77.4030107@zytor.com>
 <m1hdfdg0aa.fsf@ebiederm.dsl.xmission.com> <42C6D318.8050108@zytor.com>
 <m1k6k9drfk.fsf@ebiederm.dsl.xmission.com> <42C6D5AD.9070304@zytor.com>
 <m1fyuxdpq4.fsf@ebiederm.dsl.xmission.com> <42C7043C.9080904@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>, ftpadmin@kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 23:40:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dopig-0003lj-6W
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 23:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261289AbVGBVjx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 17:39:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVGBVjx
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 17:39:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:36586 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261289AbVGBVjp (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 17:39:45 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j62LdWjA025614
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 2 Jul 2005 14:39:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j62LdQpJ010700;
	Sat, 2 Jul 2005 14:39:28 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C7043C.9080904@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sat, 2 Jul 2005, H. Peter Anvin wrote:
> 
> They're not using a single global object storage.

Note that the fact that you use a common object store does not mean that 
everything should be common.

I still contend that tags and branches and things like that should be 
personal. A "gitforge" thing should _not_ try to unify tags. Instead, give 
people their own private area for keeping their own private references 
(you can limit it to just a few kilobytes per person, so you might as well 
just consider it to be part of their "user information" thing along with 
whatever other preferences they have).

Then, they call all share the objects, and there's never any confusion
about tags - everybody has their own tags, and you add a few simple
operations like "copy user xxx's tag to my tag-space, and start a new 
branch from that".

There're really no downsides. The only thing you need to have is some nice
tag-browser (and some simple permission model where developers can say
"others can read my tag" or "this tag is visible only to me" - the object 
store may be shared, but if nobody can see your pointers into the object 
store, you effectively have a totally private branch - which might be 
what some people want).

There's really never any reason to make tags global. Even in the case of
the kernel, people don't want to see a tag like "v2.6.12". They want to
see what _I_ tagged v2.6.12, so implicit in that whole thing is very much
that they want to see _my_ tags. Again, it's a _browsing_ issue, not a
"tags should be global" issue. They should be visible and easily 
fetchable.

		Linus
