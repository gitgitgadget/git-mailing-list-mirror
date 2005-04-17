From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [1/5] Parsing code in revision.h
Date: Sun, 17 Apr 2005 12:25:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504171221130.7211@ppc970.osdl.org>
References: <Pine.LNX.4.21.0504171120400.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0504171114020.7211@ppc970.osdl.org> <20050417183002.GE1461@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 21:24:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNFMr-0002bm-7A
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 21:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261426AbVDQT0o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 15:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261428AbVDQTZA
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 15:25:00 -0400
Received: from fire.osdl.org ([65.172.181.4]:1154 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261427AbVDQTX3 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 15:23:29 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3HJNOs4011608
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 17 Apr 2005 12:23:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3HJNNLP031135;
	Sun, 17 Apr 2005 12:23:23 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050417183002.GE1461@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 17 Apr 2005, Petr Baudis wrote:
> 
> Someone started the avalanche by adding date to the structure. Of
> course, date is smaller, but it leads people (including me) out of the
> way.

Yeah, the naming and the structure comes from "rev-tree.c", so there's a 
bit of historical baggage already. 

Anyway, I don't think you should need it. I cleaned up things a bit, and 
wrote a really simple "merge-base" thing that does base the "best" hit on 
date, which ends up probably doing the right thing in practice.

It might be interesting to extend that to do the "five best" common
parents according to date (making sure to remove the trivial cases: a
parent of a common parent is always itself a common parent, but such a
common grandparent is obviously always uninteresting).

Then, for that small set of parents, doing something much more involved
(generation counting is fairly simple, but possibly not as good a
"goodness" match as tree-diff or something).

		Linus
