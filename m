From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 0/2] apply.c: a fix and an enhancement
Date: Fri, 22 Jul 2005 14:53:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507221447420.6074@g5.osdl.org>
References: <7vzmsewzik.fsf@assigned-by-dhcp.cox.net>
 <20050722181800.GU20369@mythryan2.michonline.com> <7vsly6vd2b.fsf@assigned-by-dhcp.cox.net>
 <42E1571B.8070108@gmail.com> <Pine.LNX.4.58.0507221340450.6074@g5.osdl.org>
 <7vhdempmgg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: A Large Angry SCM <gitzilla@gmail.com>,
	Ryan Anderson <ryan@michonline.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 22 23:57:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dw5Wc-0002o3-7x
	for gcvg-git@gmane.org; Fri, 22 Jul 2005 23:57:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262199AbVGVV52 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Jul 2005 17:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262204AbVGVVyz
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jul 2005 17:54:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:55492 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262199AbVGVVxy (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jul 2005 17:53:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6MLrhjA001420
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 22 Jul 2005 14:53:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6MLrf75019786;
	Fri, 22 Jul 2005 14:53:41 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdempmgg.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 22 Jul 2005, Junio C Hamano wrote:
> 
> And the file would obviously be per-project, so according to
> Pasky's suggestion that would be ".gitinfo/fake_parents" ;-).

I'd _really_ prefer to not have any preferences or other metadata files
under version control within that same project.

If you want to version control them, that's fine, but don't tie the
versioning to the main project itself. You can have a _separate_ git
index, and a separate branch for the preferences and other metadata (but
you can, if you want to, obviously share the .git directory contents and
mix up the objects).

The thing is, different people might want to tie in these things different
ways. For example, one thing this kind of "grafting" is useful for is to
literally graft two different projects together, even if you may actually
want to export them independently (ie you do _not_ want the graftign
itself to be visible when you export it).

Think of something like a collection of projects, each under their own 
subdirectory. We could eventually literally make them _look_ like one big 
project, with cross-project commits grafted together, but they'd 
technically be totally independent (think "git" vs "gitk" - rather than 
having a very tight merge like I did, we could have tried to make it be a 
more virtual graft instead).

And personal preferences are just that - personal. I do _not_ want to have 
the kernel project history have things like "editor preferences" etc in 
the revision history - you might want to revision them, but that would be 
totally independent of the history of the project itself.

		Linus
