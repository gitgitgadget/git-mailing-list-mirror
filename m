From: Linus Torvalds <torvalds-3NddpPZAyC0@public.gmane.org>
Subject: RE: git pull on Linux/ACPI release tree
Date: Sun, 8 Jan 2006 11:10:20 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0601081100220.3169@g5.osdl.org>
References: <F7DC2337C7631D4386A2DF6E8FB22B3005A13489@hdsmsx401.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	akpm-3NddpPZAyC0@public.gmane.org, git-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
X-From: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org Sun Jan 08 20:10:33 2006
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Envelope-to: glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Evfvx-0003AM-A5
	for glad-acpi-devel-Uylq5CNFT+jYtjvyW6yDsg@public.gmane.org; Sun, 08 Jan 2006 20:10:29 +0100
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org via listexpand
	id S1161077AbWAHTKZ (ORCPT <rfc822;glad-acpi-devel@m.gmane.org>);
	Sun, 8 Jan 2006 14:10:25 -0500
Received: (majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org) by vger.kernel.org id S1161084AbWAHTKY
	(ORCPT <rfc822;linux-acpi-outgoing>); Sun, 8 Jan 2006 14:10:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21656 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161081AbWAHTKX (ORCPT
	<rfc822;linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>); Sun, 8 Jan 2006 14:10:23 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k08JALDZ025192
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 8 Jan 2006 11:10:22 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k08JAKc8032155;
	Sun, 8 Jan 2006 11:10:21 -0800
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
In-Reply-To: <F7DC2337C7631D4386A2DF6E8FB22B3005A13489-N2PTB0HCzHKkrb+BlOpmy7fspsVTdybXVpNB7YpNyf8@public.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.64__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Precedence: bulk
X-Mailing-List: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org



On Sun, 8 Jan 2006, Brown, Len wrote:
> 
> Is it possible for it git, like bk, to simply ignore merge commits in its summary output?

That's not the point. It does: "git log --no-merges" does exactly that.

But fire up "gitk" to watch the history, and see the difference.

> Note that "Auto-update from upstream" is just the place-holder comment
> embedded in the wrapper script in git/Documentation/howto/using-topic-branches.txt

That has absolutely nothing to do with anything. It's not the comment 
(which admittedly gives absolutely no information - but why should it, 
since the _commit_ itself has no information in it?)

It's like you have empty commits that don't do anything at all, except 
that they are worse, because they have two parents.

> I think that Tony's howto above captures two key requirements
> from all kernel maintainers -- which the exception of you --

No. Your commits make it harder for _everybody_ to track the history. 

A merge by definition "couples" the history of two branches. That's what a 
merge very fundamentally is. It ties two things together. But two things 
that don't have any connection to each other _shouldn't_ be tied together.

Just as an example: because of the extra merges, you've made all your 
commits dependent on what happened in my tree, with no real reason. So 
let's say that somebody reports that something broke in ACPI. Now you 
can't just go to the top of the ACPI history and work backwards - you'll 
have tied up the two histories so that they are intertwined.

And yes, you can always work around it, but there's just no point. And 
none of the other developers seem to need to do it. They do their 
development, and then they say "please pull". At that point the two 
histories are tied together, but now they are tied together for a 
_reason_. It was an intentional synchronization point.

An "automated pull" by definition has no reason. If it works automated, 
then the merge has zero semantic meaning. 

			Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
