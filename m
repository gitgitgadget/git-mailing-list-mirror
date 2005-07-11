From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 3/6] git-gnu-progs-Makefile: git Makefile update
Date: Mon, 11 Jul 2005 13:00:34 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507111252380.17536@g5.osdl.org>
References: <20050711101417.10318.64006.sendpatchset@bryan-larsens-ibook-g4.local>
 <20050711101454.10318.70399.sendpatchset@bryan-larsens-ibook-g4.local>
 <7vk6jxupxs.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0507111206240.17536@g5.osdl.org>
 <42D2CBA2.8060705@yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, bryan.larsen@gmail.com,
	pasky@suse.cz, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 02:09:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds8Ka-0001Cl-U8
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 02:09:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVGKUEC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 16:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVGKUCG
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 16:02:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15256 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262529AbVGKUBK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jul 2005 16:01:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6BK0fjA017114
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 11 Jul 2005 13:00:42 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6BK0Y04028472;
	Mon, 11 Jul 2005 13:00:36 -0700
To: Bryan Larsen <bryanlarsen@yahoo.com>
In-Reply-To: <42D2CBA2.8060705@yahoo.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 11 Jul 2005, Bryan Larsen wrote:
> 
> > 
> > Most everything includes git-sh-setup-script anyway by now.
> > 
> > However, what are the features that break the default apple tools anyway? 
> > Maybe we should avoid using them? OSX clearly comes with "cp" and "xargs" 
> > regardless, what are the flags that don't work with their cruddy versions?
> 
> xargs -r, cp -l, cp -u, cp -a.  Git uses the first 2, cogito uses all 4.

I think we can replace "xargs -r" with just plain "xargs". It results in 
an empty "rm -f", but hey, that's ok. If some broken "rm" complains about 
that (GNU rm doesn't), you can always do

	find .. | xargs rm -f dummy-file.o

which makes sure that we have a dummy argument even for an empty list..

> Last night, I couldn't think of alternatives to these, but I obviously 
> didn't try very hard.  xargs -r can probably happen via a temporary file 
> and cp -u can probably be simulated using rsync.

I don't see a good alternative for "cp -l".

I also don't see why, if OS-X already _does_ include the GNU tools, they 
couldn't be under /opt/fsf/bin or something like that, and then you could 
just do

	PATH=/opt/fsf/bin:$PATH

and be done with it.

Grumble.

		Linus
